defmodule TwitterSyllables.WordParser do
  use GenServer.Behaviour

  def start_link do
    :gen_server.start_link({ :local, :word_parser }, __MODULE__, [], [])
  end
  def init(state) do
    {:ok, parse_file}
  end

  def handle_call({:query, word}, _from, state) do
    result = HashDict.fetch(state, word)
    { :reply, result, state }
  end
  
  defp parse_file do
    stream = File.binstream! "cmudict.0.7a"

    dict = stream
      |> Stream.filter(&comments_filter/1)
      |> Stream.map(&process_line/1)
      |> HashDict.new

    IO.inspect dict
  end

  defp process_line(line) do
    [word | phonetics] = String.split(line)

    count = Enum.count phonetics, &Regex.match?(%r/[0-9]$/, &1)
    {word, count}
  end

  defp comments_filter(word) do
    not String.starts_with?(word, ";;;")
  end

end

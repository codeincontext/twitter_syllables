defmodule TwitterSyllables.WordParser do

  def parse_file do
    stream = File.binstream! "cmudict.0.7a"
    stream
      |> Stream.filter(&comments_filter/1)
      |> Enum.each(&process_line/1)
  end

  defp process_line(line) do
    [word | phonetics] = String.split(line)

    IO.puts word
    IO.puts count_syllables_for_codes(phonetics)
  end

  defp count_syllables_for_codes(codes) do
    Enum.count codes, &Regex.match?(%r/[0-9]$/, &1)
  end

  defp comments_filter(word) do
    not String.starts_with?(word, ";;;")
  end

  def get_words do

  end


  def syllables_in_word(word) do
    # look in lookup
    # if word: lookat number of syllables
  # if not, do the other method
  end

end

defmodule TwitterSyllables.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(TwitterSyllables.WordParser, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

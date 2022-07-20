defmodule JwstCli do
  @moduledoc """
  Documentation for `JwstCli`.
  """

  @doc """
  Provides a repl for querying and searching JWST data via jwstapi.com

  ## Examples

      iex> JwstCli.start(:single, {})

  """

  def start(:single, command) do
    process(command)
    :complete
  end

  def start() do
    IO.puts("Entering repl")
  end


  def process(command) do
    IO.puts("Command: " <> command)
  end

end

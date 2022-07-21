defmodule JwstCli do

  require JwstApi
  require Logger

  @moduledoc """
  Documentation for `JwstCli`.
  """

  @doc """
  Invokes a single command direclty from the commandline

  ## Examples

      iex> JwstCli.start(:single, "api_key", "help")
  """

  def start(:single, api_key, command) do
    process(api_key, command)
    :complete
  end

  @doc """
  Starts the repl loop to process commands via an interactive and stateful session 

  ## Examples

      iex> JwstCli.start("api-key")
  """

  def start(api_key) do
    IO.puts("Entering repl" <> api_key)
  end


  @doc false
  def process(api_key, command) do
    #IO.puts("Command: " <> command)
    result = case command do
      "get_program_list" -> JwstApi.get_program_list(api_key)
      "help" -> IO.puts "Valid commands"
      _ -> IO.puts "Unknown command " <> command
    end

    Logger.info inspect(result, pretty: true)
    :complete
  end

    
end

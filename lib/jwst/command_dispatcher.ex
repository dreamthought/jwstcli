defmodule Jwst.CommandDispatcher do

  require Jwst.Api
  require Logger
  
  @moduledoc """
  Documentation for `Jwst.CommandDispatcher`
  """

  @doc """
  Provides an abstraction in front of jwstapi.com

  ## Examples

    iex> Jwst.Api.get_program_list("api_key")

  """

  def dispatch(command, args) do
    #IO.puts("Command: " <> command)
    result = case command do
      "get_program_list_raw" -> Jwst.Api.get_program_list(args)
      "get_program_list" -> Jwst.Command.GetProgramList.execute(args)
      "help" -> IO.puts "Valid commands"
      _ -> IO.puts "Unknown command " <> command
    end

    Logger.info inspect(result, pretty: true)
    result || :ok
  end

end

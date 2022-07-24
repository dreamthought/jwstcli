defmodule JwstCli.CommandDispatcher do

  require JwstCli.Api
  require Logger
  
  @moduledoc """
  Documentation for `JwstCli.CommandDispatcher`
  """

  @doc """
  Provides an abstraction in front of jwstapi.com

  ## Examples

    iex> JwstCli.Api.get_program_list("api_key")

  """

  def dispatch(command, args) do
    #IO.puts("Command: " <> command)
    result = case command do
      "get_program_list_raw" -> JwstCli.Api.get_program_list(args)
      "get_program_list" -> JwstCli.Command.GetProgramList.execute(args)
      "get_all_jpg_raw" -> JwstCli.Api.get_all_by_file_type(args, :jpg)
      "get_all_fits_raw" -> JwstCli.Api.get_all_by_file_type(args, :fits)
      "get_all_ecsv_raw" -> JwstCli.Api.get_all_by_file_type(args, :ecsv)
      "get_all_json_raw" -> JwstCli.Api.get_all_by_file_type(args, :json)
      "help" -> IO.puts "Valid commands"
      _ -> IO.puts "Unknown command " <> command
    end

    Logger.info inspect(result, pretty: true)
    result || :ok
  end

end

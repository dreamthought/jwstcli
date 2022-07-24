defmodule JwstCli.CommandDispatcher do

  require JwstCli.Api
  require Logger

  @valid_commands """
      "get_program_list_raw" -> JSON for all program ids
      "get_program_list" -> An array of program ids
      "get_all_jpg_raw" -> JSON response with all JPGs
      "get_all_fits_raw" -> JSON response with all fits image data
      "get_all_ecsv_raw" -> JSON response with all ecsv
      "get_all_json_raw" -> JSON response with all JWST json consumed by the API
  """

 
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
      "help" -> @valid_commands
      _ -> "Unknown command " <> command
    end

    Logger.debug inspect(result, pretty: true)
    result || :ok
  end

end

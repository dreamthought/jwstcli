defmodule JwstCli.CommandDispatcher do
  require Application
  require JwstCli.Api
  require Logger
  require GenServer

  @valid_commands """
      "get_program_list_raw" -> JSON for all program ids
      "get_program_list" -> An array of program ids
      "get_all_jpg" -> An array of jpg URLs
      "get_recent_jpg" -> The single most recent jpg URL
      "get_all_jpg_raw" -> JSON response with all JPGs
      "get_all_fits_raw" -> JSON response with all fits image data
      "get_all_ecsv_raw" -> JSON response with all ecsv
      "get_all_json_raw" -> JSON response with all JWST json consumed by the API
      "download_file {:url, url, :path, path}" -> Download file to path
  """

  @download_path Application.compile_env(:jwst_cli, :download_path)

  @moduledoc """
  Documentation for `JwstCli.CommandDispatcher`
  """

  @doc """
  Provides an abstraction in front of jwstapi.com

  ## Examples

    iex> JwstCli.Api.get_program_list("api_key")

  """

  def dispatch(command, api_key, args) do
    #IO.puts("Command: " <> command)
    result = case command do
      "get_program_list_raw" -> JwstCli.Api.get_program_list(api_key)
      "get_program_list" -> JwstCli.Command.GetProgramList.execute(api_key)
      "get_all_jpg" -> JwstCli.Command.GetAllJpg.execute(api_key)
      "get_recent_jpg" -> Enum.take(JwstCli.Command.GetAllJpg.execute(api_key), -30)
      "download_recent_jpg" -> download_recent_jpg(api_key)
      "get_all_jpg_raw" -> JwstCli.Api.get_all_by_file_type(api_key, :jpg)
      "get_all_fits_raw" -> JwstCli.Api.get_all_by_file_type(api_key, :fits)
      "get_all_ecsv_raw" -> JwstCli.Api.get_all_by_file_type(api_key, :ecsv)
      "get_all_json_raw" -> JwstCli.Api.get_all_by_file_type(api_key, :json)
      "download_file" -> GenServer.cast(JwstCli.Downloader, args)
      "help" -> @valid_commands
      _ -> "Unknown command " <> command
    end

    Logger.debug inspect(result, pretty: true)
    result || :ok
  end
  
  defp download_recent_jpg(api_key) do
    Enum.take(JwstCli.Command.GetAllJpg.execute(api_key), -10)
    |> Enum.map(fn l->GenServer.cast(JwstCli.Downloader, {:url, l, :path, @download_path}) end) 
  end
end

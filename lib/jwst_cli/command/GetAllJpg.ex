defmodule JwstCli.Command.GetAllJpg do
  require JwstCli.Api
  require Logger

  def execute(api_key) do
    {result, response} = JwstCli.Api.get_all_by_file_type(api_key, :jpg)

    unless :ok = result do
      # TODO - ensure that this does not leak security info
      Logger.critical inspect response, "Failure"
      raise "Failed to query get_program_list"
    end

    {_,body} = Jason.decode(response.body)
    Enum.map(body["body"], fn map -> map["location"] end)
  end

end

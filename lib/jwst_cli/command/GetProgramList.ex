defmodule JwstCli.Command.GetProgramList do
  require JwstCli.Api
  require Logger

  def execute(api_key) do
    {result, response} = JwstCli.Api.get_program_list(api_key)

    unless :ok = result do
      # TODO - ensure that this does not leak security info
      Logger.critical inspect response, "Failure"
      raise "Failed to query get_program_list"
    end

    {_,body} = Jason.decode(response.body)
    Enum.map(body["body"], fn map -> map["program"] end)
  end

end

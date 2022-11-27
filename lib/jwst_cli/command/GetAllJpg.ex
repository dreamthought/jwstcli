defmodule JwstCli.Command.GetAllJpg do
  require JwstCli.Api
  require Logger

  def execute(api_key) do
      with {:ok, response} =  JwstCli.Api.get_all_by_file_type(api_key, :jpg),
           {_, body} = Jason.decode(response.body) do
          Enum.map(body["body"], fn map->map["location"] end)
      end
  end
end

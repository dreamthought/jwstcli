defmodule Jwst.Command.GetProgramList do
  require Jwst.Api
  require Logger

  def execute(api_key) do
   Jwst.Api.get_program_list(api_key)
  end

end

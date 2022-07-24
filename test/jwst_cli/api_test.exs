defmodule JwstCli.ApiTest do
  use ExUnit.Case
  doctest JwstCli.Api

  @moduletag :external_jwst_api
  test "" do
    assert JwstCli.Api.get_program_list(1234) == :ok
  end
end

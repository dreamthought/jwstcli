defmodule Jwst.ApiTest do
  use ExUnit.Case
  doctest Jwst.Api

  @moduletag :external_jwst_api
  test "" do
    assert Jwst.Api.get_program_list(1234) == :ok
  end
end

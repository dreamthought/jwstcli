defmodule Jwst.ApiTest do
  use ExUnit.Case
  doctest Jwst.Api

  test "" do
    assert Jwst.Api.get_program_list(1234) == :ok
  end
end

defmodule JwstApiTest do
  use ExUnit.Case
  doctest JwstApi

  test "" do
    assert JwstApi.get_program_list(1234) == :ok
  end
end

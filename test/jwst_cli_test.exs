defmodule JwstCliTest do
  use ExUnit.Case
  doctest JwstCli

  test "starts repl without a loop" do
    assert JwstCli.start(:single, "help") == :complete
  end
end

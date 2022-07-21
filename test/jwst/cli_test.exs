defmodule Jwst.CliTest do
  use ExUnit.Case
  doctest Jwst.Cli

  test "starts repl without a loop" do
    assert Jwst.Cli.start(:single, "fake api key", "help") == :complete
  end
end

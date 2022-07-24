defmodule JwstCli.Repl.ExecutorTest do
  use ExUnit.Case
  doctest JwstCli.Repl.Executor

  test "Can run help command" do
    assert JwstCli.Repl.Executor.start(:single, "fake api key", "help") == :complete
  end
end

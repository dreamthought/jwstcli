defmodule Jwst.Repl.ExecutorTest do
  use ExUnit.Case
  doctest Jwst.Repl.Executor

  test "Can run help command" do
    assert Jwst.Repl.Executor.start(:single, "fake api key", "help") == :complete
  end
end

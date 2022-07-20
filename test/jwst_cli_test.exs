defmodule JwstCliTest do
  use ExUnit.Case
  doctest JwstCli

  test "greets the world" do
    assert JwstCli.hello() == :world
  end
end

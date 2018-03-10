defmodule ArthurTest do
  use ExUnit.Case
  doctest Arthur

  test "greets the world" do
    assert Arthur.hello() == :world
  end
end

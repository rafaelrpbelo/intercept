defmodule InterceptTest do
  use ExUnit.Case
  doctest Intercept

  test "greets the world" do
    assert Intercept.hello() == :world
  end
end

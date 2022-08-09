defmodule VisualTest do
  use ExUnit.Case
  doctest Visual

  test "greets the world" do
    assert Visual.hello() == :world
  end
end

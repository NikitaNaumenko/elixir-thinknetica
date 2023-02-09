defmodule FerryboatTest do
  use ExUnit.Case
  doctest Ferryboat

  test "greets the world" do
    assert Ferryboat.hello() == :world
  end
end

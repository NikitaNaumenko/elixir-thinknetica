defmodule WcTest do
  use ExUnit.Case
  doctest Wc

  test "count small" do
    assert {2, 30, 206} = Wc.count_words("./test/fixtures/simple.txt")
  end

  test "count medium" do
    assert {5, 536, 3569} = Wc.count_words("./test/fixtures/medium.txt")
  end

  test "count huge" do
    assert {40, 4288, 28552} = Wc.count_words("./test/fixtures/huge.txt")
  end
end

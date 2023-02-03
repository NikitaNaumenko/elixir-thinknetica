defmodule WcTest do
  use ExUnit.Case
  doctest Wc

  test "count" do
    assert {5, 536, 3569} = Wc.count_words("./test/fixtures/lorem.txt")
  end
end

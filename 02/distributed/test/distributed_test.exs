defmodule DistributedTest do
  use ExUnit.Case
  # doctest Distributed

  test "greets the world" do
    slaves = TestCluster.start_slaves()
    assert {15, :"n2@127.0.0.1"} == Distributed.calc_fib(5)
    assert {15, :"n3@127.0.0.1"} == Distributed.calc_fib(5)
    TestCluster.disconnect(slaves)
  end
end

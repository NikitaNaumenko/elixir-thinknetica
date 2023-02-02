defmodule Distributed do
  @moduledoc """
  Documentation for `Distributed`.
  """

  alias Distributed.Router

  @doc """
  Run calc fib function on remote node

  ## Examples

      iex> Distributed.calc_fib(5)
      {15, :"n2@127.0.0.1"}

  """

  @spec calc_fib(non_neg_integer()) :: {non_neg_integer(), atom()}
  def calc_fib(num \\ 5) do
    next = GenServer.call(Router, :take_node)

    next_node =
      cond do
        next == node() -> GenServer.call(Router, :take_node)
        true -> next
      end

    pid =
      Node.spawn_link(next_node, fn ->
        receive do
          {:calc, client, num} -> send(client, {:reply, fib(num), node()})
        end
      end)

    send(pid, {:calc, self(), num})

    receive do
      {:reply, calculated, node_name} ->
        IO.puts("Fibonacci number was calculated, and reply got from node: #{node_name}")
        {calculated, node_name}
    end
  end

  def fib(0), do: 0
  def fib(1), do: 1

  def fib(num) do
    num + fib(num - 1)
  end
end

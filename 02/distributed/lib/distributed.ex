defmodule Distributed do
  @moduledoc """
  Documentation for `Distributed`.
  """

  use GenServer
  alias Distributed.Router

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, []}
  end

  @doc """
  Run calc fib function on remote node

  ## Examples

      iex> Distributed.calc_fib(5)
      {15, :"n2@127.0.0.1"}

  """

  @spec calc_fib(non_neg_integer()) :: {non_neg_integer(), atom()}
  def calc_fib(num \\ 5) do
    GenServer.call(__MODULE__, {:calc_fib, num})
  end

  @impl true
  def handle_call({:calc_fib, num}, _from, state) do
    next = GenServer.call(Router, :take_node)

    next_node =
      case node() do
        ^next -> GenServer.call(Router, :take_node)
        _ -> next
      end

    Node.spawn(next_node, __MODULE__, :fib, [num, self()])

    receive do
      {:reply, calculated, node_name} ->
        IO.puts("Fibonacci number was calculated, and reply got from node: #{node_name}")
        {:reply, {calculated, node_name}, state}
    end
  end

  def fib(num, pid) do
    calced = fib(num)
    send(pid, {:reply, calced, node()})
  end

  def fib(0), do: 0
  def fib(1), do: 1

  def fib(num) do
    num + fib(num - 1)
  end
end

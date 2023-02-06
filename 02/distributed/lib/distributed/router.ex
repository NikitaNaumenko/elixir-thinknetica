defmodule Distributed.Router do
  @doc """
  Dispatch the given `mod`, `fun`, `args` request
  to the appropriate node based on the choosing node alghorithm.
  """

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    nodes = [:"n1@127.0.0.1", :"n2@127.0.0.1", :"n3@127.0.0.1"]
    [next_node | rest_nodes] = nodes
    {:ok, {rest_nodes, next_node}}
  end

  @impl true
  def handle_call(:take_node, _from, {nodes, current_node}) do
    [next_node | rest_nodes] = nodes
    {:reply, current_node, {rest_nodes ++ [current_node], next_node}}
  end
end

defmodule Ferryboat.LeftCoast do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init([]) do
    {:ok, [:goat, :cabbage, :wolf]}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end

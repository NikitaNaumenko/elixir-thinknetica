defmodule Ferryboat.RightCoast do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init([]) do
    {:ok, []}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end

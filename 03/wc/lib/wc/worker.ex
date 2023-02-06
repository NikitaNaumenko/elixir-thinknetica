defmodule Wc.Worker do
  use GenServer

  def start_link(line_number) do
    DynamicSupervisor.start_child(
      {:via, Registry, {Wc.Workers, line_number}},
      %{
        id: GenServer,
        start:
          {GenServer, :start_link,
           [__MODULE__, {0, 0, 0}, [name: {:via, Registry, {Wc.Workers, line_number}}]]}
      }
    )

    # DynamicSupervisor.start_child(
    #   {:via, PartitionSupervisor, {{:via, Registry, {ExBf.Sessions, id}}, idx}},
    #   %{
    #     id: GenServer,
    #     start:
    #       {GenServer, :start_link,
    #        [__MODULE__, 0, [name: {:via, Registry, {ExBf.Cells, {id, idx}}}]]}
    #   }
    # )
  end

  @impl true
  def init(_) do
    {:ok, {0, 0, 0}}
  end

  @impl true
  def handle_cast({:count, line}, _state) do
    words = String.split(line, " ")
    # Compesate new line byte
    {:noreply, {1, Enum.count(words), byte_size(line) + 1}}
  end

  @impl true
  def handle_call(:result, _from, state) do
    {:reply, state, state}
  end
end

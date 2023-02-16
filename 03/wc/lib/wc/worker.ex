defmodule Wc.Worker do
  use GenServer

  def start_link(line_number) do
    DynamicSupervisor.start_child(
      Wc.Workers.Supervisor,
      %{
        id: GenServer,
        start:
          {GenServer, :start_link,
           [__MODULE__, {0, 0, 0}, [name: {:via, Registry, {Wc.Workers, line_number}}]]},
        restart: :transient
      }
    )
  end

  @impl true
  def init(_) do
    {:ok, {0, 0, 0}}
  end

  @impl true
  def handle_cast({:count, line}, _state) do
    words = String.split(line, " ")
    {:noreply, {1, Enum.count(words), byte_size(line)}}
  end

  @impl true
  def handle_call(:result, _from, state) do
    # {:reply, state, state}
    {:stop, :normal, state, state}
  end

  # @impl true
  # def handle_call(:stop, _from, state) do
  #   {:stop, :normal, state, state}
  #   # {:reply, state, state}
  # end

end

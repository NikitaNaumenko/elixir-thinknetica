defmodule Wc.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Wc.Workers},
      {DynamicSupervisor, name: Wc.Workers.Supervisor}
    ]

    spec = [strategy: :one_for_one, name: Wc.Supervisor]
    Supervisor.start_link(children, spec)
  end
end

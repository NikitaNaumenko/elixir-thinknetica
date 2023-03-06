defmodule Homework.CurrenciesCache do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(query) do
    key = build_key(query)
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def put(query, response) do
    key = build_key(query)
    Agent.update(__MODULE__, &Map.put(&1, key, response))
  end

  defp build_key(query) do
    :crypto.hash(:md5, inspect(query)) |> Base.encode16()
  end
end

defmodule Homework.CurrenciesCache do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(date, from, to) do
    key = build_key(date, from, to)
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def put(date, from, to, response) do
    key = build_key(date, from, to)
    Agent.update(__MODULE__, &Map.put(&1, key, response))
  end

  defp build_key(date, from, to) do
    Enum.join([date, from, to], "-")
  end
end

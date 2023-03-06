defmodule Homework.RateCache do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(date) do
    key = build_key(date)
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def put(date, response) do
    key = build_key(date)
    Agent.update(__MODULE__, &Map.put(&1, key, response))
  end

  defp build_key(date) do
    :crypto.hash(:md5, inspect(date)) |> Base.encode16()
  end
end

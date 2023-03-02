defmodule Homework.RateCache do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(date) do
    Agent.get(__MODULE__, &Map.get(&1, date))
  end

  def put(date, response) do
    Agent.update(__MODULE__, &Map.put(&1, date, response))
  end
end

defmodule Homework.Rates do
  @moduledoc """
  The Rates context.
  """

  import Ecto.Query, warn: false
  alias Homework.ExchangeRateAPI
  alias Homework.RateCache, as: Cache

  alias Homework.Rates.Rate

  @spec historical_rates(date :: String.t(), query :: map()) :: {:ok, [Rate.t()]} | {:error, atom()}
  def historical_rates(date, query \\ %{}),
    do: date |> Cache.get() |> do_historical_rates(date, query)

  defp do_historical_rates(nil, date, query) do
    with {:ok, %Tesla.Env{body: %{"rates" => rates}}} <- ExchangeRateAPI.historical_rates(date, query),
         rates <- transform_rates(rates),
         :ok <- Cache.put(date, rates),
         do: {:ok, rates}
  end
  defp do_historical_rates(cached, _, _), do: {:ok, cached}


  def latest_rates(query \\ %{}) do
     date = Date.utc_today()
            |> Date.to_string()
            |> historical_rates(query)
     date |> Cache.get() |> do_latest_rates(date, query)
    end

  defp do_latest_rates(nil, date, query) do
    with {:ok, %Tesla.Env{body: %{"rates" => rates}}} <- ExchangeRateAPI.latest_rates(query),
         rates <- transform_rates(rates),
         :ok <- Cache.put(date, rates),
         do: {:ok, rates}
  end
  defp do_latest_rates(cached, _, _), do: {:ok, cached}

  defp transform_rates(rates),
    do: Enum.into(rates, [], fn {k, v} -> %Rate{iso_code: k, rate: v} end)
end

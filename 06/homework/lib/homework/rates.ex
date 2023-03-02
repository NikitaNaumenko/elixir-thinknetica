defmodule Homework.Rates do
  @moduledoc """
  The Rates context.
  """

  import Ecto.Query, warn: false
  alias Homework.ExchangeRateAPI
  alias Homework.RateCache, as: Cache

  alias Homework.Rates.Rate

  @spec historical_rates(date :: String.t(), query :: map()) :: [Rate.t()] | {:error, atom()}
  def historical_rates(date, query \\ %{}) do
    case Cache.get(date) do
      nil -> historical_rates(date, query, cached: false)
      rates -> rates
    end
  end

  @spec historical_rates(date :: String.t(), query :: map(), cached: boolean()) ::
          [Rate.t()] | {:error, atom()}
  def historical_rates(date, query, cached: false) do
    case ExchangeRateAPI.historical_rates(date, query) do
      {:ok, %Tesla.Env{body: %{"rates" => rates}}} ->
        rates = transform_rates(rates)
        Cache.put(date, rates)
        rates

      error ->
        error
    end
  end

  @spec latest_rates(query :: map()) :: [Rate.t()] | {:error, atom()}
  def latest_rates(query \\ %{}) do
    current_date = Date.utc_today() |> Date.to_string()

    case Cache.get(current_date) do
      nil -> latest_rates(query, cached: false)
      rates -> rates
    end
  end

  @spec latest_rates(query :: map(), cached: boolean()) :: [Rate.t()] | {:error, atom()}
  def latest_rates(query, cached: false) do
    case ExchangeRateAPI.latest_rates(query) do
      {:ok, %Tesla.Env{body: %{"date" => date, "rates" => rates}}} ->
        rates = transform_rates(rates)
        Cache.put(date, rates)
        rates

      error ->
        error
    end
  end

  defp transform_rates(rates),
    do: Enum.into(rates, [], fn {k, v} -> %Rate{iso_code: k, rate: v} end)
end

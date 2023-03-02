defmodule Homework.Currencies do
  alias Homework.ExchangeRateAPI
  alias Homework.Currencies.Currency
  alias Homework.CurrenciesCache, as: Cache

  @spec convert_currency(map()) :: Currency.t() | {:error, any()}
  def convert_currency(%{"from" => from, "to" => to} = query) do
    date = Map.get(query, "date") || Date.utc_today() |> Date.to_string()

    case Cache.get(date, from, to) do
      nil -> convert_currency(query, cached: false)
      response -> response
    end
  end

  @spec convert_currency(map(), cached: boolean()) :: Currency.t() | {:error, any()}
  def convert_currency(%{"from" => from, "to" => to} = query, cached: false) do
    case ExchangeRateAPI.convert_currency(query) do
      {:ok, %Tesla.Env{body: %{"result" => rate, "date" => date}}} ->
        currency = %Currency{from: from, to: to, rate: rate}
        Cache.put(date, from, to, currency)
        currency

      error ->
        error
    end
  end
end

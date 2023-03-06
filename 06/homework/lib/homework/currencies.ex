defmodule Homework.Currencies do
  alias Homework.ExchangeRateAPI
  alias Homework.Currencies.Currency
  alias Homework.CurrenciesCache, as: Cache

  @spec convert_currency(query :: map()) :: {:ok, Currency.t()} | {:error, any()}
  def convert_currency(query \\ %{}),
    do: query |> Cache.get() |> do_convert_currency(query)

  defp do_convert_currency(nil, query) do
    with {:ok, %Tesla.Env{body: %{"result" => result, "date" => date}}} <- ExchangeRateAPI.convert_currency(query),
         currency <- %Currency{from: from, to: to, rate: result}
         :ok <- Cache.put(query),
         do: {:ok, currency}
  end
  defp do_convert_currency(cached, _), do: {:ok, cached}
end

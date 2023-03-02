defmodule Homework.ExchangeRateAPI do
  @callback historical_rates(day :: String.t(), query :: map()) :: {:ok, Tesla.Env.t()}
  @callback latest_rates(query :: map()) :: {:ok, Tesla.Env.t()}
  @callback convert_currency(query :: map()) :: {:ok, Tesla.Env.t()}

  def historical_rates(day, query), do: impl().historical_rates(day, query)
  def latest_rates(query), do: impl().latest_rates(query)
  def convert_currency(query), do: impl().convert_currency(query)
  defp impl, do: Application.get_env(:homework, :exchange_rate_api)
end

defmodule Homework.ExchangeRateRealAPI do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.exchangerate.host"
  plug Tesla.Middleware.JSON

  def historical_rates(day, query) do
    get("/#{day}", query: query)
  end

  def latest_rates(query) do
    get("/latest", query: query)
  end

  def convert_currency(query) do
    get("/convert", query: query)
  end
end

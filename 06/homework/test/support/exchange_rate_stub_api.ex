defmodule Homework.ExchangeRateStubAPI do
  @behaviour Homework.ExchangeRateAPI

  @impl true
  def historical_rates(_date, _query) do
    {:ok,
     %Tesla.Env{
       body: %{
         "rates" => %{
           "EUR" => 17.863887,
           "RUB" => 10.410711
         }
       }
     }}
  end

  @impl true
  def latest_rates(_query) do
    {:ok,
     %Tesla.Env{
       body: %{
         "date" => "2022-01-03",
         "rates" => %{
           "EUR" => 17.863887,
           "RUB" => 10.410711
         }
       }
     }}
  end

  @impl true
  def convert_currency(_query) do
    {:ok,
     %Tesla.Env{
       body: %{
         "date" => "2022-01-03",
         "result" => 79.605697
       }
     }}
  end
end

defmodule Homework.CurrenciesTest do
  use Homework.DataCase

  alias Homework.Currencies
  alias Homework.Currencies.Currency
  import Mox
  setup :verify_on_exit!

  setup do
    Mox.stub_with(Homework.ExchangeRateMockAPI, Homework.ExchangeRateStubAPI)
    :ok
  end

  describe "currencies" do
    test "converts currency" do
      assert %Currency{from: "EUR", to: "RUB", rate: 79.605697} =
               Currencies.convert_currency(%{"from" => "EUR", "to" => "RUB"})
    end
  end
end

defmodule Homework.RatesTest do
  use Homework.DataCase

  alias Homework.Rates
  alias Homework.Rates.Rate
  import Mox
  setup :verify_on_exit!

  setup do
    Mox.stub_with(Homework.ExchangeRateMockAPI, Homework.ExchangeRateStubAPI)
    :ok
  end

  describe "historical rates" do
    test "returns rates" do
      assert [
               %Rate{iso_code: "EUR", rate: 17.863887},
               %Rate{iso_code: "RUB", rate: 10.410711}
             ] = Rates.historical_rates("2021-11-11")
    end
  end

  describe "latest rates" do
    test "returns rates" do
      assert [
               %Rate{iso_code: "EUR", rate: 17.863887},
               %Rate{iso_code: "RUB", rate: 10.410711}
             ] = Rates.latest_rates()
    end
  end
end

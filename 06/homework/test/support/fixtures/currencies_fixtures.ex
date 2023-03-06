defmodule Homework.CurrenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Homework.Currencies` context.
  """

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{
        from: "some from",
        to: "some to"
      })
      |> Homework.Currencies.create_currency()

    currency
  end
end

defmodule Homework.RatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Homework.Rates` context.
  """

  @doc """
  Generate a rate.
  """
  def rate_fixture(attrs \\ %{}) do
    {:ok, rate} =
      attrs
      |> Enum.into(%{})
      |> Homework.Rates.create_rate()

    rate
  end
end

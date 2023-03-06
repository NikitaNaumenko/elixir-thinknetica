defmodule HomeworkWeb.RateController do
  use HomeworkWeb, :controller

  alias Homework.Rates

  def historical_rates(conn, %{"date" => date}) do
    rates = Rates.historical_rates(date)
    next_date = Date.from_iso8601!(date) |> Date.add(1) |> Date.to_string()
    previous_date = Date.from_iso8601!(date) |> Date.add(-1) |> Date.to_string()

    render(conn, :historical_rates,
      rates: rates,
      date: date,
      next_date: next_date,
      previous_date: previous_date
    )
  end

  def latest_rates(conn, _params) do
    rates = Rates.latest_rates()
    render(conn, :latest_rates, rates: rates)
  end
end

defmodule HomeworkWeb.CurrencyController do
  use HomeworkWeb, :controller
  alias Homework.Currencies
  alias Homework.Currencies.Currency

  def convert_currencies(conn, _params) do
    changeset = Currency.changeset(%Currency{}, %{})
    render(conn, :convert_currencies, changeset: changeset)
  end

  def convert(conn, %{"currency" => params}) do
    result = Currencies.convert_currency(params)
    render(conn, :convert, result: result)
  end
end

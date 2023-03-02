defmodule Homework.Currencies.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{
          from: String.t(),
          to: String.t(),
          rate: float()
        }

  embedded_schema do
    field :from, :string
    field :to, :string
    field :rate, :float
  end

  def changeset(currency, params) do
    currency
    |> cast(params, [:from, :to])
  end
end

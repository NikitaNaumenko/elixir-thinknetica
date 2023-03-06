defmodule Homework.Rates.Rate do
  use Ecto.Schema

  @type t() :: %__MODULE__{
          iso_code: String.t(),
          rate: float()
        }

  embedded_schema do
    field :iso_code, :string
    field :rate, :float
  end
end

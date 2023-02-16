defmodule Ferryboat.State do
  alias Ferryboat.Passenger

  @type t :: %__MODULE__{
          coasts: %{left: [] | [Passenger.t()], right: [] | [Passenger.t()]},
          history: [] | [[Passenger.t()] | []],
          direction: atom()
        }
  defstruct coasts: %{left: [], right: []}, history: [], direction: nil
end

defmodule Ferryboat.Passenger do
  @type t :: %__MODULE__{self: binary(), enemies: [binary()]}

  defstruct self: nil, enemies: []
end

defimpl String.Chars, for: Ferryboat.Passenger do
  def to_string(passenger) do
    map = %{"wolf" => "🐺", "goat" => "🐐", "cabbage" => "🥬"}
    Map.get(map, passenger.self)
  end
end

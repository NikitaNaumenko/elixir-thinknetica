defmodule Ferryboat do
  @moduledoc """
  Documentation for `Ferryboat`.
  """

  alias Ferryboat.{Passenger, LeftCoast, RightCoast}

  @goat %Passenger{self: "goat", enemies: ["wolf", "cabbage"]}
  @wolf %Passenger{self: "wolf", enemies: ["goat"]}
  @cabbage %Passenger{self: "cabbage", enemies: ["goat"]}

  @doc """
  Hello world.

  ## Examples

      iex> Ferryboat.hello()
      :world

  """
  def main() do
    left_state = ["goat", "cabbage", "wolf"]
    right_state = []
    history = []
    do_transit(left_state, right_state, history)
  end

  def do_transit([], _right_state, history), do: history

  def do_transit([passenger | left], right, history) do
    case check?(left) do
      false ->
        do_transit(left ++ [passenger], right, history)

      true ->
        right = right ++ [passenger]
        IO.puts("[#{Enum.join(left, ",")}]\n #{passenger} -->\n #{Enum.join(right, ",")}")

        case check?(right) do
          true ->
            do_transit(left, right, [%{left: left, right: right, passenger: passenger}])

          false ->
            [passenger | right] = right

            IO.puts(
              "[#{Enum.join(left ++ [passenger], ",")}]\n <-- #{passenger} \n [#{Enum.join(tl(right), ",")}]"
            )

            do_transit(left ++ [passenger], right, history)
        end
    end
  end

  def check?(state) do
    case state do
      ["goat", "cabbage"] -> false
      ["cabbage", "goat"] -> false
      ["wolf", "goat"] -> false
      ["goat", "wolf"] -> false
      _ -> true
    end
  end
end

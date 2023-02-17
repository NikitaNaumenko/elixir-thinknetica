defmodule Ferryboat do
  @moduledoc """
  Documentation for `Ferryboat`.
  """

  alias Ferryboat.{Passenger, State}

  @goat %Passenger{self: "goat", enemies: ["wolf", "cabbage"]}
  @wolf %Passenger{self: "wolf", enemies: ["goat"]}
  @cabbage %Passenger{self: "cabbage", enemies: ["goat"]}
  @initial_left_coast [@goat, @cabbage, @wolf]
  @state %State{
    coasts: %{left: @initial_left_coast, right: []},
    direction: :left,
    history: [@initial_left_coast]
  }

  @doc """
  Transit animals and alone vegetable

  ## Examples

      iex> Ferryboat.main()
      [
        ["🐐", "🥬", "🐺"],
        ["🥬", "🐺"],
        ["🐺"],
        ["🐐", "🐺"],
        ["🐐"],
        [],
        ["🐐", "🥬", "🐺"],
        ["🥬", "🐺"],
        ["🥬"],
        ["🐐", "🥬"],
        ["🐐"],
        [],
        ["🐐", "🥬", "🐺"],
        ["🥬", "🐺"],
        ["🥬"],
        ["🐺", "🥬"],
        ["🐺"],
        ["🐐", "🐺"],
        ["🐐"],
        []
       ]
  """

  @spec main() :: [[binary()]]
  def main() do
    transit(@state) |> Enum.to_list()
  end

  @spec transit(state :: State.t()) :: Enumerable.t()
  def transit(state) do
    case state.coasts.left do
      [] ->
        state.history
        |> Enum.reverse()
        |> Enum.map(fn h -> Enum.map(h, &to_string/1) end)

      _rest ->
        [nil | @initial_left_coast]
        |> Task.async_stream(&do_transit(state, &1))
        |> Stream.map(&elem(&1, 1))
        |> Stream.filter(& &1)
        |> Stream.flat_map(&transit/1)
    end
  end

  @spec do_transit(state :: State.t(), elem :: nil | Passenger.t()) :: State.t()
  def do_transit(%State{coasts: coasts, direction: direction, history: history} = state, nil) do
    with true <- direction == :right,
         true <- check?(coasts[:right]) do
      %State{
        state
        | direction: :left,
          history: history
      }
    end
  end

  def do_transit(%State{coasts: coasts, direction: direction, history: history}, elem) do
    [coast1, coast2] = if direction == :left, do: [:left, :right], else: [:right, :left]

    with true <- elem in coasts[direction],
         coasts = %{coast1 => coasts[coast1] -- [elem], coast2 => [elem | coasts[coast2]]},
         new_state = coasts[:left],
         true <- check?(coasts[direction]),
         true <- not Enum.member?(history, new_state) do
      %State{
        coasts: coasts,
        direction: coast2,
        history: [new_state | history]
      }
    end
  end

  @spec check?(list()) :: boolean()
  def check?(state) do
    selves = state |> Enum.map(& &1.self) |> MapSet.new()
    enemies = state |> Enum.flat_map(& &1.enemies) |> MapSet.new()

    MapSet.disjoint?(selves, enemies)
  end
end

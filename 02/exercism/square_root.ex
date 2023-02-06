defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer

  def calculate(radicand) when radicand > 0 do
    do_calculate(1, radicand, [])
  end

  defp do_calculate(guess, radicand, _) when guess * guess == radicand, do: guess

  defp do_calculate(guess, radicand, guesses) do
    new_guess = ((guess + radicand / guess) / 2) |> floor()
    do_calculate(new_guess, radicand, [new_guess | guesses])
  end
end

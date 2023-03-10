defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    calc(input, 0)
  end

  defp calc(input, acc) when input > 0 and is_integer(input) do
    cond do
      input == 1 -> acc
      rem(input, 2) == 0 -> calc(div(input, 2), acc + 1)
      true -> (input * 3 + 1) |> calc(acc + 1)
    end
  end
end

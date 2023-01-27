defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dist = distance(x, y)

    cond do
      dist <= 1 -> 10
      dist <= 5 -> 5
      dist <= 10 -> 1
      true -> 0
    end
  end

  def distance(x, y) do
    (:math.pow(Kernel.abs(x), 2) + :math.pow(Kernel.abs(y), 2)) |> :math.sqrt()
  end

  # 10|
  #  9|
  # 8|
  # 7|
  # 6|
  # 5|
  # 4|
  # 3|
  # 2|
  # 1|_ _ _ _ _ _ _ _ _ _ _
  #  0 1 2 3 4 5 6 7 8 9 1
end

defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight) do
    max_val(items, maximum_weight, 0)
  end

  def max_val([], _, acc), do: acc
  def max_val(_, 0, acc), do: acc

  def max_val([%{value: value, weight: weight} | rest], capacity, acc) do
    if weight > capacity do
      acc
    else
      with_current = max_val(rest, capacity - weight, acc + value)
      without_current = max_val(rest, capacity, acc)
      max(with_current, without_current)
    end
  end
end

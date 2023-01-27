defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_filter(list, fun, true, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_filter(list, fun, false, [])
  end

  defp do_filter([head | tail], fun, predicate, acc) do
    next_acc =
      cond do
        fun.(head) == predicate -> [head | acc]
        true -> acc
      end

    do_filter(tail, fun, predicate, next_acc)
  end

  defp do_filter(_, _fun, _predicate, acc), do: acc |> Enum.reverse()
end

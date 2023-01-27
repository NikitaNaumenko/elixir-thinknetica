defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    case bin_search(numbers, 0, tuple_size(numbers), key) do
      nil -> :not_found
      n -> {:ok, n}
    end
  end

  def bin_search(numbers, start, stop, key) when start + 1 <= stop do
    mid = div(start + stop, 2)

    el = elem(numbers, mid)

    cond do
      el == key -> mid
      el < key -> bin_search(numbers, mid + 1, stop, key)
      el > key -> bin_search(numbers, start, mid, key)
    end
  end

  def bin_search(_numbers, _start, _stop, _key), do: nil
end

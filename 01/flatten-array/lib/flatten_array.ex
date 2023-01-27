defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten(list) do
    do_flatten(list, [])
  end

  def do_flatten([], acc) do
    acc
  end

  def do_flatten([head | tail], acc) when is_list(head) do
    do_flatten(head, acc) ++ do_flatten(tail, acc)
  end

  def do_flatten([head | tail], acc) when is_nil(head) do
    acc ++ do_flatten(tail, acc)
  end

  def do_flatten([head | tail], acc) do
    [head | acc] ++ do_flatten(tail, acc)
  end
end

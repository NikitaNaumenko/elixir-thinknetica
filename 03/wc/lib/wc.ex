defmodule Wc do
  @moduledoc """
  Documentation for `Wc`.
  """

  @doc """
  Count words lines and bytesize by given filename

  ## Examples

      iex> Wc.count_words("./test/fixtures/simple.txt")
      {2, 30, 206}

  """
  @spec count_words(String.t()) :: {non_neg_integer(), non_neg_integer(), non_neg_integer()}
  def count_words(filename) do
    {:ok, content} = File.read(filename)

    trimed_content = String.trim(content)

    lines = trimed_content |> String.split("\n")

    words = lines |> Enum.reduce([], fn line, acc -> acc ++ String.split(line, " ") end)
    {Enum.count(lines), Enum.count(words), byte_size(content)}
  end
end

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

    lines
    |> Stream.with_index(1)
    |> Stream.map(fn {line, line_number} ->
      pid = ensure_process(line_number)
      GenServer.cast(pid, {:count, line})
      pid
    end)
    |> Enum.map(fn pid -> GenServer.call(pid, :result) end)
    |> Enum.reduce({0, 0, 0}, fn {line_count, word_count, byte_count},
                                 {line_acc, word_acc, byte_acc} ->
      {line_count + line_acc, word_acc + word_count, byte_count + byte_acc}
    end)
  end

  def ensure_process(line_number) do
    case Wc.Worker.start_link(line_number) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end
end

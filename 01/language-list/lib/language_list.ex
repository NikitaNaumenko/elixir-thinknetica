defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([_head | tail]) do
    tail
  end

  def first([head | _tail]) do
    head
  end

  def count(list) do
    count(list, 0)
  end

  def count([], acc), do: acc

  def count([_head | tail], acc) do
    count(tail, acc + 1)
  end

  def functional_list?([]) do
    false
  end

  def functional_list?([head | tail]) do
    case head == "Elixir" do
      true -> true
      _ -> functional_list?(tail)
    end
  end
end

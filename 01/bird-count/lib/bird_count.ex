defmodule BirdCount do
  def today([]), do: nil
  def today([head | _]) do
    head
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count([head | tail]) do
    [head + 1 | tail]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | tail]) do
    case head == 0 do
      true -> true
      _ -> has_day_without_birds?(tail)
    end
  end

  def total(list) do
    total(list, 0)
  end

  def total([], acc), do: acc
  def total([head | tail], acc), do: total(tail, acc + head)

  def busy_days(list) do
    busy_days(list, 0)
  end

  def busy_days([], acc), do: acc
  def busy_days([head | tail], acc) when head >= 5, do: busy_days(tail, acc + 1)
  def busy_days([_head | tail], acc), do: busy_days(tail, acc)
end

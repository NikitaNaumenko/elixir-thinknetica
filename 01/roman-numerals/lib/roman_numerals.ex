defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when number >= 1000, do: convert(number, "M", 1000)
  def numeral(number) when number >= 900, do: convert(number, "CM", 900)
  def numeral(number) when number >= 500, do: convert(number, "D", 500)
  def numeral(number) when number >= 400, do: convert(number, "CD", 400)
  def numeral(number) when number >= 100, do: convert(number, "C", 100)
  def numeral(number) when number >= 90, do: convert(number, "XC", 90)
  def numeral(number) when number >= 50, do: convert(number, "L", 50)
  def numeral(number) when number >= 40, do: convert(number, "XL", 40)
  def numeral(number) when number >= 10, do: convert(number, "X", 10)
  def numeral(number) when number == 9 ,do: "IX"
  def numeral(number) when number >= 5, do: convert(number, "V", 5)
  def numeral(number) when number == 4, do: "IV"
  def numeral(number), do: String.duplicate("I", number)

  defp convert(number, roman, divider) do
    String.duplicate(roman, div(number, divider)) <> numeral(rem(number, divider))
  end
end

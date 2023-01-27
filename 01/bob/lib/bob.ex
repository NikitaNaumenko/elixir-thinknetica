defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silent?(input) -> "Fine. Be that way!"
      shouting_question?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp silent?(input), do: "" == String.trim(input)
  defp shouting?(input), do: input == String.upcase(input) && letters?(input)
  defp question?(input), do: String.ends_with?(input, "?")
  defp shouting_question?(input), do: shouting?(input) && question?(input)
  defp letters?(input), do: Regex.match?(~r/\p{L}+/, input)
end

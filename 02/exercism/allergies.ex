defmodule Allergies do
  import Bitwise

  @allergens %{
    "eggs" => 1,
    "peanuts" => 2,
    "shellfish" => 4,
    "strawberries" => 8,
    "tomatoes" => 16,
    "chocolate" => 32,
    "pollen" => 64,
    "cats" => 128
  }

  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @allergens |> Map.keys() |> Enum.filter(&allergic_to?(flags, &1))
  end

  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    if item not in (@allergens |> Map.keys()) do
      raise "allergen not in list"
    else
      bit = @allergens |> Map.get(item)
      (flags &&& bit) == bit
    end
  end
end

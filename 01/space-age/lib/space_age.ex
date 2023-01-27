defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @earth 31_557_600
  defp get_coef(planet) do
    case planet do
      :mercury -> 0.2408467
      :venus -> 0.61519726
      :earth -> 1.0
      :mars -> 1.8808158
      :jupiter -> 11.862615
      :saturn -> 29.447498
      :uranus -> 84.016846
      :neptune -> 164.79132
      _ -> -1
    end
  end

  def age_on(planet, seconds) do
    year = get_coef(planet) * @earth
    if year < 0, do: {:error, "not a planet"}, else: {:ok, seconds / year}
  end
end

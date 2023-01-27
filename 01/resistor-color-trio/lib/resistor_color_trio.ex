defmodule ResistorColorTrio do
  @codes %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }
  @doc """
  Calculate a resistance value from three colors
  """
  @spec label(colors :: [atom]) :: {integer(), atom()}
  def label([color_10, color_1, color_3|_]) do
    num = (10 * @codes[color_10] + @codes[color_1]) * Integer.pow(10, @codes[color_3])
    if num >= 1000, do: {div(num, 1000), :kiloohms}, else: {num, :ohms}
  end
end

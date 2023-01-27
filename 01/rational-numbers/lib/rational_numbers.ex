defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    a = a1 * b2 + a2 * b1
    b = b1 * b2
    reduce({a, b})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    a = a1 * b2 - a2 * b1
    b = b1 * b2
    reduce({a, b})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    a = a1 * a2
    b = b1 * b2
    reduce({a, b})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    a = a1 * b2
    b = a2 * b1
    reduce({a, b})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    {Kernel.abs(a), Kernel.abs(b)}
    |> reduce()
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n >= 0,
    do:
      {Integer.pow(a, n), Integer.pow(b, n)}
      |> reduce()

  def pow_rational({a, b}, n),
    do:
      {Integer.pow(b, Kernel.abs(n)), Integer.pow(a, Kernel.abs(n))}
      |> reduce()

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    Float.pow(x / 1, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    a
    |> normalize()
    |> correct_sign()
  end

  defp normalize({a, b}) do
    gcd = Integer.gcd(a, b)
    {div(a, gcd), div(b, gcd)}
  end

  defp correct_sign({a, b}) when b < 0, do: {-a, -b}
  defp correct_sign(rational), do: rational
end

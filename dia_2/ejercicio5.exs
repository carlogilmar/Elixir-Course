defmodule Divisores do

  def gcd(a,a), do: a

  def gcd(a,b) when a>b, do: gcd(a-b, b)

  def gcd(a,b) when b>a, do: gcd(a, b-a)

end


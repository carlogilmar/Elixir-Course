defmodule Learning do

  def upto(n), do: create_list(n, [])
  defp create_list(0, lista), do: lista
  defp create_list(n, lista), do: create_list(n-1, [n | lista])

  def fizzbuzz([h|t]) when rem(h,3)==0 and rem(h,5) !=0  do
    IO.puts "Fizz"
    fizzbuzz(t)
  end

  def fizzbuzz([h|t]) when rem(h,5)==0 and rem(h,3) !=0 do
    IO.puts  "Buzz"
    fizzbuzz(t)
  end

  def fizzbuzz([h|t]) when rem(h,5)==0 and rem(h,3) ==0 do
    IO.puts "FizzBuzz"
    fizzbuzz(t)
  end

  def fizzbuzz([h|t]) when rem(h,5)!=0 and rem(h,3) !=0 do
    IO.puts h
    fizzbuzz(t)
  end

  def fizzbuzz([]) do
    IO.puts "Llegando al final de la lista"
  end

  def iterando_ando(n) do
    fizzbuzz(upto(n))
  end

end

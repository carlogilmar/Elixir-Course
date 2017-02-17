defmodule Guess do
  IO.puts "Guess My Number :P---> inicio(1..100)"

  def inicio(tope) do
    # buscando(:rand.uniform(tope), tope)
    comparador(0, tope, :rand.uniform(tope))
  end

  def inicio(number_guess, limit) do
    comparador(0, limit, number_guess)
  end

  def comparador(limite_inferior, limite_superior, number_guess) do
    #IO.puts "Adivinando #{middle}"
    middle = div(limite_inferior + limite_superior,2)
    cond do
      number_guess > middle ->
        IO.puts "Trying #{middle}"
        comparador(middle, limite_superior, number_guess)
      number_guess < middle ->
        IO.puts "Trying #{middle}"
        comparador(limite_inferior, middle, number_guess)
      middle == number_guess -> IO.puts "Number is #{middle}"
    end
  end

  def buscando(n, tope) do
    comparador(propuesta(tope), n)
  end

  def _buscando(n, tope)do
    comparador(tope, n)
  end

  def propuesta(tope) do
    div(tope,2)+1
  end

  def comparador(number, number) do
    IO.puts ">>>-----------> Ok, el numero es #{number} y la meta es #{number}"
  end

  def comparador(number, goal) when number>goal do
    IO.puts "Numero elegido: #{number} Es mayor a la meta #{goal}"
    newNumber = number-propuesta(number)
    _buscando(goal, newNumber)
  end

  def comparador(number, goal) when number<goal do
    IO.puts "#{number} Te falta ponle $5 mas para llegar a #{goal}"
    newNumber = number+propuesta(number)
    _buscando(goal, newNumber)
  end

end

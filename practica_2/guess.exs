defmodule Guess do
  IO.puts "Guess My Number :P---> inicio(1..100)"

  def inicio(tope) do
     buscando(:rand.uniform(tope), tope)
  end

  def buscando(n, tope) do
    comparador(propuesta(tope), n)
  end

  def _buscando(n, tope)do
    comparador(tope, n)
  end

  def propuesta(tope) do
    div(tope,2)
  end

  def comparador(number, goal) when number>goal do
    IO.puts "Numero elegido: #{number} Es mayor a la meta #{goal}"
    newNumber = number-1
    _buscando(goal, newNumber)
  end

  def comparador(number, goal) when number<goal do
    IO.puts "#{number} Te falta ponle $5 mas para llegar a #{goal}"
    newNumber = number+1
    _buscando(goal, newNumber)
  end

  def comparador(number, goal) when number==goal do
    IO.puts "Ok, el numero es #{number} y la meta es #{goal}"
  end

end

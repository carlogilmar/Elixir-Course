defmodule Guess do
  IO.puts "Guess My Number :P---> inicio(1..100)"

  #Entra: numero
  #Sale: indicacion encontro o (se paso, le falta)
  #@goal 20

  def inicio(tope) do
     buscando(:rand.uniform(tope), tope)
  end

  def buscando(n, tope) do
    IO.puts "Buscando iterando"
    comparador(propuesta(tope), n)
  end

  def propuesta(tope) do
    div(tope,2)
  end

  def comparador(number, goal) when number>goal do
    IO.puts "#{number}Es mayor a la meta #{goal}"
    tope=number*2
    nTope = tope - 5
    IO.puts "El tope es #{tope}, el nuevo tope sera #{nTope}"
    buscando(goal, nTope)
  end

  def comparador(number, goal) when number<goal do
    IO.puts "#{number} Te falta ponle $5 mas para llegar a #{goal}"
    tope=number*2
    nTope = tope + 5
    IO.puts "El tope es #{tope}, el nuevo tope sera #{nTope}"
    buscando(goal, nTope)

  end

  def comparador(number, goal) when number==goal do
    IO.puts "Ok, el n umero es #{number} y la meta es #{goal}"
  end


end

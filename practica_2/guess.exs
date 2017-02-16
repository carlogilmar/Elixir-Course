defmodule GuessMyNumber do
  IO.puts "Guess My Number :P---> inicio(1..100)"

  #Entra: numero
  #Sale: indicacion encontro o (se paso, le falta)
  @goal 20

  def inicio(tope) do
    @algo = :rand.uniform(tope)
  end

  def algo(tope) when tope == @goal, do: IO.puts "es igual a a"

  def buscar(n) when n>@goal, do: IO.puts "Es mayor a la meta"
  def buscar(n) when n<@goal, do: IO.puts "Te falta ponle $5 mas"


end

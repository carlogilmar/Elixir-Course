IO.puts "Hola elixir práctica 2"

defmodule Listas do
  IO.puts "Haciendo listas"

  def listando(n), do: crear_lista(n,[])
  def crear_lista(0, list), do: list
  def crear_lista(n, list), do: crear_lista(n-1, [n*10|list])

  def reversa([a]), do: a
  def reversa([a,b]), do: [b,a]
  def reversa([h|t]), do: reversa(t)

  def revert(lista), do: reverse(lista,[])
  def reverse([], list), do: list
  def reverse([h|t], list), do: reverse()

  #--------------------------------------Suma de Lista
  def suma_lista(lista), do: suma(lista,0)
  def suma([], total), do: total
  def suma([h|t], total), do: suma(t, h+total)

  def sumando([]), do: 0
  def sumando([element]), do: element
  def sumando([h|t]), do: h + sumando(t)

  #--------------------------------------Conteo de listas
  def contando([]), do: 0
  def contando([a]), do: 1
  def contando([_|t]), do: 1 + contando(t)

  #--------------------------------------Ultimo elemento
  def ultimo([]), do: 0
  def ultimo([a]), do: a
  def ultimo([_|t]), do: ultimo(t)

  #-------------------------------------- Maximo elemento
  def maximo([]), do: 0
  def maximo([a]), do: a
  def maximo([a,b]) when a>b, do: a
  def maximo([a,b]) when a<b, do: b
  def maximo([h|t]), do: maximo([h, maximo(t)])

  #-------------------------------------- Minimo
  def minimo([]), do: 0
  def minimo([a]), do: a
  def minimo([a,b]) when a>b, do: b
  def minimo([a,b]) when a<b, do: a
  def minimo([h|t]), do: minimo([h, minimo(t)])

  #--------------------------------------- Buscando un elemento
  def buscar([], _), do: :false
  def buscar([h|t], a) when h == a, do: :true
  def buscar([h|t], a) when h != a, do: buscar(t,a)

  #-------------------------------------Guess my number

end



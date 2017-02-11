defmodule MyFunctions do

  @moduledoc """
  Modulo de funciones de aprendizaje
  """

  def hello do
    "Hello anonymous"
  end

  @doc """
  Funcion que recibe un nombre y envia un saludo
  """
  def hello(name) do
    "Hello #{name}"
  end

  @doc """
  Funcion que recibe una lista y calcula su tamaño
  """
  def tamanio([]), do: 0
  def tamanio([_|t]), do: 1 + tamanio(t)


end

MyFunctions.hello "carlo" |> IO.puts
MyFunctions.hello |> IO.puts


defmodule MyProcesses do
  def operation(n) do
    receive do
      {parent, :+,a,b} ->
        send parent, a + b; operation(n+1)

      {parent, :-,a,b} ->
        send parent, a + b; operation(n+1)

      :counter ->
        IO.puts "#{n} times"
        operation(n)

      :terminate ->
        IO.puts "Terminado"

      _ ->
        :noop
        operation(n)
    end
  end

  def pmap(collection, fun) do
    collection
    |> Stream.map(&spawn_process(&1, self, fun))
    |> Stream.map(&await/1)
    |> Enum.map(&(&1))
  end

  def spawn_process(item, parent, fun) do
    pid = spawn fn ->
      send parent, {self, fun.(item)}
    end
    pid
  end

  def await(pid) do
    receive do
      {^pid, result} -> result
    end
  end
end

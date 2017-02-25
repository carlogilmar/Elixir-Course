defmodule MyProceses do
  def operation(caller) do

    receive do
      {:+, a, b} -> send caller, a+b
      {:-, a, b} -> send caller, a-b
      _ -> :noop
    end
    operation(caller)
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

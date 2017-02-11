defmodule Learning do

  def upto(n), do: create_list(n, [])
  defp create_list(0, lista), do: lista
  defp create_list(n, lista), do: create_list(n-1, [n | lista])


end

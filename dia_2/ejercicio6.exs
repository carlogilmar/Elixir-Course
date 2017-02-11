defmodule OperatorList do

  def sum_lista([]), do: 0
  def sum_lista([a]), do: a
  def sum_lista([h|t]), do: h+sum_lista(t)

end

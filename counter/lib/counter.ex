defmodule Counter do
  @moduledoc """
  Documentation for Counter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Counter.hello
      :world

  """
  def hello do
    :world
  end

  def count_lines do
    File.read!("/usr/share/dict/words")
    |> String.split()
    |> Enum.count()
  end

  def main(_args) do
    IO.puts count_lines()
  end
end

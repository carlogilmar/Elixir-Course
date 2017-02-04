
defmodule Counter do
#la convención va con _
  def count_lines do

    File.read!("/usr/share/dict/words") |> String.split() |> Enum.count()

  end
end

IO.puts Counter.count_lines

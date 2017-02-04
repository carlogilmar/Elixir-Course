num_lines = File.read!("/usr/share/dict/words") |> String.split() |> Enum.count()
IO.puts num_lines



IO.puts "Ejercicio 3"

handle_file = fn
  {:ok, text} -> IO.puts text
  {:error, _} -> IO.puts "Error not fount"
end

File.read("readme.txt")

#handle_file(File.read("readme.txt"))

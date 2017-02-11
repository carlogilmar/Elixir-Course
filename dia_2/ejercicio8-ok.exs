IO.puts "Ejercicio 8 Estructuras de control"

s=5

result = if rem(s,2) == 0 do
  :even
else
  :odd
end

IO.puts result

tuplaOk = [ status: :ok, code: 200, result: "</>"]
tuplaError = [ status: :error, code: 400, result: "Error"]
tupla = [ status: :unknown]

a = tuplaError

case a do
  [status: :ok, code: _, result: result] -> IO.puts result
  [status: :error, code: _, result: error] -> IO.puts result
  [status: _status] -> IO.puts "Desconocido"
end

result = cond do
  2+2 == 5 -> "Not pass"
  2*2 == 5 -> "Neither"
  1+1 == 2 -> "yei"
end

IO.puts result

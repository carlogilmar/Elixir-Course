#Procesos

run_query = fn(query_def) ->
  :timer.sleep 2000
  "#{query_def} result"
end

async_query = fn(query) ->
  spawn(fn -> IO.puts(run_query.(query)) end)
end

1..10 |> Enum.map(&async_query.("query #{&1}"))


send self, {:message, 1}

receive do
  {:message, n} ->
    IO.puts "Message is #{n}"
  after 5000 ->
    IO.puts "Expired"
end

result = receive do
  {:message, n} ->
    IO.puts "Message is #{n}"
  after 5000 ->
    IO.puts "Expired"
end

defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end
  def create_processes(n) do
    last = Enum.reduce 1..n, self,
            fn (_, send_to) ->
              spawn(Chain, :counter, [send_to])
            end
    # Start the count by sending
    send last, 0
    # And wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end
  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
# $ elixir -r chain.exs -e "Chain.run(10)"
# {3175,"Result is 10"}
# $ elixir -r chain.exs -e "Chain.run(100)"
# {3584,"Result is 100"}
# $ elixir -r chain.exs -e "Chain.run(1000)"
# {8838,"Result is 1000"}
# $ elixir -r chain.exs -e "Chain.run(10000)"
# {76550,"Result is 10000"}
# $ elixir -r chain.exs -e "Chain.run(400_000)"
# =ERROR REPORT==== 25-Apr-2013::15:16:14 ===
# Too many processes
# ** (SystemLimitError) a system limit has been reached
# $ elixir --erl "+P 1000000"  -r chain.exs -e "Chain.run(400_000)"
# {3210704,"Result is 400000"}
# $ elixir --erl "+P 1000000"  -r chain.exs -e "Chain.run(1_000_000)"
# {7225292,"Result is 1000000"}

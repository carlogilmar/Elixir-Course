
# Agenda

1.- Revisión de PingPong y Ring Exercises:q
2.- Spawn y recuperación para crear dependencias entre procesos
3.- Agents

Spawn
Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> pid = spawn(fn -> 1+1 end)
#PID<0.83.0>

iex(2)> Process.alive? pid
false

iex(3)> raise "errorz"
** (RuntimeError) errorz
    
iex(3)> pid = spawn(fn -> raise "errorz" end)
#PID<0.87.0>

iex(4)> 
10:50:18.993 [error] Process #PID<0.87.0> raised an exception
** (RuntimeError) errorz
    :erlang.apply/2


Agents y Task

Agent es un proceso que guardan un estado.
Task son procesos que realizan una tarea muy específica.

iex(5)> {:ok, agent}= Agent.start_link(fn -> [1,2,3] end)
{:ok, #PID<0.92.0>}
iex(6)> agent
#PID<0.92.0>
iex(7)> Agent.update(agent, fn state -> state ++ [2,5] end)
:ok
iex(8)> Agent.get(agent, &(&1))
[1, 2, 3, 2, 5]
iex(9)> 


Checar demo en Github..











# Dia 3 del curso de Elixir |m|

Agenda

Contenido

Construyendo proyecto con mix

> mix new Twinhub

En lib> crear "user.ex"

> defmodule Twinder.User do
> defstruct username: "", id:0
> end

Recordar que los keywordlist necesitan un espacio, sino se quejan.

Correr iex con mix al nivel del proyecto donde esta mix.exs

> iex -S mix

Crear una estructura de datos

> user = %Twinder.User{id: 123, username: "carlogilmar"}

> user.id
> 123

Modificando

> %{ user | username: "carlosins"}

El nombre de los módulos son átomos!!!!!!!

Vamo construyendo lo siguiente

>  1 defmodule Twinder.User do
>  2   defstruct username: "", id: 0
>  3
>  4   def new(id, username) do
>  5     %Twinder.User{id: id, username: username}
>  6   end
>  7
>  8   def capitalize_username(%Twinder.User{ username: username}) do
>  9     String.capitalize username
> 10   end
> 11
> 12 end

En iex

> iex(2)> Twinder.User.new(123, "carlogilmar")
> %Twinder.User{id: 123, username: "carlogilmar"}
> iex(3)> carlo = Twinder.User.new(123, "carlogilmar")
> %Twinder.User{id: 123, username: "carlogilmar"}
> iex(4)> Twinder.User.capitalize_username(carlo)
> "Carlogilmar"

# Instalar dependencias en Mix

Agregar en mix.exs

> extra_appliction [:my_dependencia]
> deps do

Para instalar hacer:

> mix deps.get

Siguiente paso en el curso: abrir el iex con mix, se seguiran descargando dependecias

> iex(6)> HTTPoison.get "https://api.github.com/users/neodevelop"
> blablalablabla 200

Agregamos otro modulo en elixir Followers

---

Compresiones

> for x <- [1,2,3,4], do: x
> for x <- [1,2,3,4], do: x+1
> for x <- [1,2,3,4], rem(x,3)== 0, do: x+1
> for x <- [1,2,3,4], rem(x,2)== 0, do: x+1
> for x <- [1,2,3,4], rem(x,2)== 0, do: {x, x+1}

> for x <- [1,2,3,4], rem(x,2)== 0, y <- [5,6,7,8,9], do: {x, x*2, y}

> for x <- [1,2,3,4], y <- [5,6,7,8], do: {x,y}

> for x <- [1,2,3,4], y <- [5,6,7,8], rem(x,2) ==0, do: {x,y}


Levantando procesos

> Generated twinder app
> Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
> iex(1)> pid = spawn(MyProceses, :operation, [:+, 1, 2])
> #PID<0.196.0>
> iex(2)> Process.alive? pid
> false
> iex(3)>

>  1 defmodule MyProceses do
>  2   def operation(operant, a, b) do
>  3     receive do
>  4       {:+, a, b} -> a+b
>  5       {:-, a, b} -> a-b
>  6       _ -> :noop
>  7     end
>  8   end
>  9 end

Ejemplo

> Compiling 1 file (.ex)
> Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
> iex(1)> pid = spawn(MyProceses, :operation, [])
> #PID<0.189.0>
> iex(2)> Proceses.alive? pid
> ** (UndefinedFunctionError) function Proceses.alive?/1 is undefined (module Proceses is not available)
>    Proceses.alive?(#PID<0.189.0>)
> iex(2)> Process.alive? pid
> true
> iex(3)> result = send(pid, {:+,3,5})
> {:+, 3, 5}
> iex(4)> result
> {:+, 3, 5}
> iex(5)> Process.alive? pid
> false

# Mandando un mensaje y levantando un solo proceso pero estatico

>  1 defmodule MyProceses do
>  2   def operation(caller) do
>  3     receive do
>  4       {:+, a, b} -> send caller, a+b
>  5       {:-, a, b} -> send caller, a-b
>  6       _ -> :noop
>  7     end
>  8     operation(caller)
>  9   end
> 10 end


# Ejemplo con esto

> iex(6)> pid = spawn(MyProceses, :operation, [self])
> warning: variable "self" does not exist and is being expanded to "self()", please use parentheses to remove the ambiguity or change the variable name
>   iex:6

> #PID<0.198.0>
> iex(7)> send pid, {:+, 1, 2}
> {:+, 1, 2}
> iex(8)> send pid, {:+, 2, 3}
> {:+, 2, 3}
> iex(9)> send pid, {:+, 3, 4}
> {:+, 3, 4}
> iex(10)> flush
> warning: variable "flush" does not exist and is being expanded to "flush()", please use parentheses to remove the ambiguity or change the variable name
>   iex:10

> 3
> 5
> 7
> :ok


Haciendo los procesos independientes

---
> iex(1)> pid = spawn(MyProceses, :operation, [self])
> warning: variable "self" does not exist and is being expanded to "self()", please use parentheses to remove the ambiguity or change the variable name
>  iex:1

#PID<0.189.0>
iex(2)> MyProceses.pmap [1,2,3,4], &(&1*&1)
[#PID<0.191.0>, #PID<0.192.0>, #PID<0.193.0>, #PID<0.194.0>]
iex(3)>
---

Esto se logra con esto:
---

  1 defmodule MyProceses do
  2   def operation(caller) do
  3     receive do
  4       {:+, a, b} -> send caller, a+b
  5       {:-, a, b} -> send caller, a-b
  6       _ -> :noop
  7     end
  8     operation(caller)
  9   end
 10
 11   def pmap(collection, fun) do
 12     collection
 13     |> Stream.map(&spawn_process(&1, self, fun))
 14     |> Stream.map(&await/1)
 15     |> Enum.map(&(&1))
 16   end
 17
 18   def spawn_process(item, parent, fun) do
 19     pid = spawn fn ->
 20       send parent, {self, fun.(item)}
 21     end
 22     pid
 23   end
 24
 25   def await(pid) do
 26     receive do
 27       {^pid, result} -> result
 28     end
 29   end
 30
 31 end


---

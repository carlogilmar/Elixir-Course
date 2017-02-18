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




























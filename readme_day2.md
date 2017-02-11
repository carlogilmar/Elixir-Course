# Dia 2 Curso Elixir
---

Agenda dia 2

-Hello World en Elixir

Elixir es un lenguaje funcional.

Dia de prácticas en Elixir.
Elixir lenguaje dinámico/tipado opcional/ scripting

Fácil de conocer.
Compatible con las bibliotecas de erland.
Extensible.
Productividad.
Se pueden usar las bibliotecas de erland (:crypto.md5)
Recordar sacar consola con :observer.start
Definición de Macros. MACRO: forma funcional de evitar código duplicado.
Árbol sintáctico abstracto.
Lenguaje homoicónico.

Quote

> iex(2)> quote do: nueva_function_if(1,2,3,45)
> {:nueva_function_if, [], [1, 2, 3, 45]}
> iex(3)>

DSL: Lenguaje especifico del dominio
USE: uso de una macro

Todo lo que no sea "use" es una macro.
Con las macros se habilitan DSL.

Productividad

Documentación basada en markdown
Tooling
Package management
REPL
Releases


No tenemos variables, no hay variables, BINDING(asignaciones)

Segundo ejercicio Geometry con modulos

Tipos de datos
Flotanes 0.1
Enteros
Binario 0b0110
Hexadecimal
Booleanos
Atomos :true :false :foo :nil
    Functions
        is_boolean false
        is_atom true

Los nombres de los módulos son átomos
    Geometry
    Geometry.circle
    Geometry.rectangle

Llamadas a bibliotecas de erlang denotadas por atomos.
Biblioteca de Erlang es un átomo
utf8 y unicode son soportados

> rem(12,5) <--- residuo
> div(20,10) <--- división

> -20 || true
> 24 && nil

Comparaciones booleanas
> true and false
> not false
> 32 and false <-----------------Error

Comparaciones

> 2 == 2.0 Comparando valores----->true
> 2 === 2.0 Comparando valores y tipos--->false

Tamanios

Se puede comparar :hello > 999

number < atom < reference < function < port < pid < tuple < map < list < bitsrting

Interpolación de variables y concatenacion

> name = "carlo"
> "Hola #{name}"
> "hola" <> name

Estructuras de datos

> [3.14, :pie, "Apple"]
> list = [3.14, :pie, "Apple"]
> ["n"] ++ list
> list ++ ["Fruta"]
> list -- [:pie]

La estructura queda igual, solo se modifican los datos
> list
> [3.14, :pie, "Apple"]

> hd list
> 3.14
> tl list
> [:pie, "Apple"]


Bindings

> 1 = a
> [h|t] = list
> h
> 3.14
> t
> [:pie, "Apple"]


Tuplas

Son elementos sin relación aparente entre ellos.

> {3.14, :pie, "Apple"}

> File.read "/ksns.txt"
> {:ok, "balblablabla"}

Key Word List

Lista de tuplas con una estructura específica

> kwl = [{:uno, 2}, {:dos, bla}]
> [uno:1, dos:2]

El elemento del key-world debe llevar un espacio.
> kwl= [uno: 1, dos: 2]

Mapas

> map = %{ :foo => "valor2", "hi" => :world}

> map = %{ :foo => "valor2", "hi" => :world, :foo =>5}
> :foo tomará el último valor asignado

Si en el mapa todos los elementos son átomos:
> map = %{ foo: "valor", hi: :world, foo: 5 }

> map.foo
> map.hi

> %{map | foo: "Otro valor asignado" }
Esto modifica la salida de los datos, sin embargo el valor inicial de map seguira siendo lo mismo


Pattern Matching

> list
> [3.14, :pie, "Apple"]
> [_, :pie, e] = list
> e
> "Apple":

# Functions

> sum = fn(a,b) -> a+b end
> sum.(4,5)

> mul = fn(a,b) -> a*b end
> square = fn(a) -> mul.(a,a) end

> square.(9)

Forma abreviada de hacer funciones de Erlang

> sum2 = &(&1 + &2)

> square2 = &(&1 * &1)

Funciones

iex(1)> File.read("readme.txt")
{:ok, "holii\n"}
iex(2)> handle_file = fn
...(2)> {:ok, text} -> IO.puts text
...(2)> {:error, _} -> IO.puts "errorz"
...(2)> end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(3)> handle_file.(File.read("readme.txt"))
holii

:ok
iex(4)>


Functions

> defp tamanio2([], n), do: n
> defp tamanio2([_|t],n), do: tamanio2(t,n+1)
> def true_size(lista) do
>   tamanio2(lista, 0)
> end


Guardas

> def true_size(lista) when is_list(lista) do

valores por default

> def true_size(lista \\ []) when is_list(lista) do

Strings

String.length "Hola mundo"

Cargar Scripts de elixir a IEx

> c "archivo.exs"

Documentación

En IEx

h MyFunctions.hello

















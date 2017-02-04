#Day 1 Notas de la clase de Elixir

Itinerario del día
- Presentación
- Topic 1: Estructura de Elixir
- Topic 2: Introducción
- Ejercicio Hola mundo
- Ejercicio Archivo elixir, contador de lineas
- Transformación del contador de lineas a Módulo
- Mix
- Primer proyecto básico de Elixir
	- Archivo mix.exs
	- Agregando funcion en lib/counter.exs
	-

# Estructura de Elixir
----
Herramientas y Bibliotecas de Elixir <-------Phoenix
Lenguaje Elixir(joven), Lenguaje Erlang(prolog), Lenguaje LFE(dialecto LISP) <-------Lenguajes que corren sobre Erlang
Bibliotecas, OTP, Monitoreo General (y análisis) <------ Core, Standard Library
Maquina Virtual de Erlang BEAM <-----codigo de bytes .beam; 30 años de madurez

Elixir:  Sistemas distribuidas, clúster 400 máquinas aprox.

# Introducción

Phoenix: Framework
Erlang: Plataforma 

Elixir:

- Sistemas de alta disponibilidad
- Mejor uso de los recursos
- Concurrencia
- Multiples procesadores

Java 95, .Net 00 no fueron pensadas para computadoras con más procesadores
Tandem 1974, luego fue comprada por HP. Nacida para competir con los mainframes(virtualización)
2005 Primera computadora personal con múltiples procesadores, ya los tenía tandem.(hardware)

Plataforma Erlang(software) <---- Tandem (hardware)
Hecha por Ericsson
Joe Amnstrong y Virding

Compañías usando Erlang
Facebook Chat, heroku, world War Craft, Amazon.com, bet365(Apuestas en tiempo real), WhattsApp(400 millones)

-Corre sobre Erlang
-Funcional
-UTF8
-Inmutable
-Macro System
-Tooling 

Elixir
2014 Primera Versión
JOse Valim

Phoenix
Web framework
Ecto -> data bases access
Plug -> Web Server Interface


Sistema Operativo: Procesos

Los procesos están aislados, para comunicarse necesitan hacerlo por medio de mensajes
IPC: internal process comunnication

# Comandos básicos
Shell de Erlang
> erl 
Erlang/OTP 19 [erts-8.2] [source-fbd2db2] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V8.2 

¿Que significa?

OTP/ 19 <--------- Vrsion
erts-8.2 <---------- Erlang Runtime Sistem, versión de la maquina virtual
source-fdb2db2<------ Compilación
64-bit<------------Arquitectura al que fue compilado
smp:4:4 <-------- Simetric Multi Processing, cores que existen. Cores:Schedulers
async-threads:10 <------------- Numero de Cores +2, Threads del SO
hipe <--------------- Ahead atime compiler, compilación a código del procesador
kernel-poll:false <------------- Bandera para el manejo de conexiones, false PULL, true PUSH
dtrace <---------------dinamyc trace (Sun Microsystems) mecanismo de instrumentación de programas, mecanismo a nivel del So que permite obtener información de los programas que están corriendo en ese instante.

ctrlC Pausa a la máquina virtual
ctrlG No detiene la máquina virtual
	
La máquina virtual al tener procesos se parece a un SO

andinamyc trace (Sun Microsystems) mecanismo de instrumentación de programas, mecanismo a nivel del So que permite obtener información de los programas que están corriendo en ese instante.

BEAM: Es un SO para sistemas distribuidos, sobre switches en equipos de telecomunicaciones

Interactive Elixir

>iex

>h
>h String
>h String.split

---

#hello world
iex(1)> IO.puts "hola mundo"
hola mundo
:ok
	puts <-- funcion
	IO <-- modulo
	" "<-- parametro
	:ok<-- return de la función "puts", es un átomo o tipo de dato

Crear carpeta y archivo counter.exs

num_lines = File.read!("/usr/share/dict/words") |> String.split() |> Enum.count()
IO.puts num_lines

> elixir counter.exs
23423432

Modulo File, Función Read
|> Operador pipe


Diferencia entre Expresiones y Sentencias

Lenguajes para expresiones y sentencias
Lenguajes para expresiones 
Lenguajes para sentencias

Expresión: Tiene un valor asociado, cuando se ejecuta siempre devuelve algo.
Sentencia: No devuelve un valor.

Ejemplo: IF no es una expresión, no tiene ningún valor asociado en Java.
En ruby si lo es. var algo = if()


# Mix Command

Despliegue, pruebas, dependencias <------ equivalente a build/.Net, combinación maven/ant/gradle etc... en JAVA

Si agregamos phoenix, le agrega comandos a MIX, se puede agregar nuevas cosas

> $ mix -h

> $ mix new counter
 
Creará una estructura basica de proyecto de elixir

.
├── config
│   └── config.exs
├── lib
│   └── counter.ex
├── mix.exs
├── README.md
└── test
    ├── counter_test.exs
    └── test_helper.exs

terminaciones
.ex codigo elixir que generará código de byte .beam
.exs elixir Script, es algo que se ejecturará

- Config
	Configuraciones según el ambiente

- Lib
	Documentacion con anotaciones
		## Examples <-------------prueba 
			iex> Counter.hello
			iex> :world
	$ mix test

- mix.exs: DSL que indicará cómo se ejecuta el proyecto
	application: Dependencias para que se ejecute el proyecto
	extra_aaplication: [:logger]
				*** el loger correrá por separado, y la aplicación igual, como un SO<---- "micro servicios<---- "micro servicios""
	deps: Lo que necesita la app cuando  se compila el proyecto

- test: Pruebas unitarias
	$ mix test
	2 test
		prueba

- README

Como el runtime de Java no puede manejar lo mismo, debe irse al siguiente nivel.

Proceso de un SO: Linux 2 Mb ram; Windows 1 MB ram, US10 10 MB ram

Procesos Erlang: 2 kb ram.

No es fácil crear microservicios por la orquestación. Erlang ya tiene todos esos mecanismos.

Agregando linea en mix.exs

Compilando y generando el binario:
	$ mix escript.build
	$ ./counter

Formas de correr elixir:
	Shell Elixir Interactive
	Script de Elixir
	Proyecto de elixir



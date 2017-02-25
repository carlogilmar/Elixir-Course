
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


# Agregando speaker al twinder

Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> pid = spawn(Speaker, :speak, [])
#PID<0.190.0>
iex(2)> send pid, {:say, "Holi"}        
Holi
{:say, "Holi"}
iex(3)> 

Entendiendo el Gen Server 

# Pasando un modulo al ServerWithNoResponse

iex(3)> pid = ServerWithNoResponse.start(Speaker)
#PID<0.200.0>
iex(4)> send pid, {:say, "Hello"}                
Hello
{:say, "Hello"}
iex(5)> 


# Ping -pong

iex(5)> ping = ServerWithNoResponse.start(PingPingNew)
#PID<0.206.0>
iex(6)> send ping, {:ping, self()}                    
{:ping, #PID<0.194.0>}
iex(7)> 

# Abstracción de Ping pong con Server With Response


# Server with Response and state

iex(*)> account = ServerWithResponseAndState.start(BackAccount, 0)  
#PID<0.012.9>
iex(*)> send account, {:deposit, 3400}
iex(*)> send account, {withdraw, 300}
iex(*)> send account, :balance
:balance
iex(*)> flush
{:balance, 3100}
:ok


----
Sistema sin race conditions


FIFO

Java, .Net ----> Problemas de Concurrencias
Erlang --> Ganarantía de concurrencia y manejo de procesos

El problema es que puede volverse un cuello de botella, pero puede aguantar bastante trabajando bien
Fácil 2000 transacciones por segundo

ETS es caché en memoria distribuido, permite distribuir los servidores

MNesia, base de datos distribuida no sql que permite distribuir a un nivel mayor

Riak: 500,000 transacciones por segundo

Se puede tener versionado

Cada árbol de procesos es un app
Un sistema puede estar conectado por varios app
Cada app tiene una versión (Mix.exs)
Al levantar las app, cada una representa un proceso, es así que Elixir puede ir subiendo la versión  en caliente. :P


# Haciendo un Gen Server

BankAccountGS.ex

Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> {:ok, account}= GenServer.start_link(BankAccountGS, 0)
{:ok, #PID<0.178.0>}
iex(2)> GenServer.cast(account, {:deposit, 1000})
:ok
iex(3)> GenServer.call(account, :balance)        
1000
iex(4)> GenServer.cast(account, {:deposit, 1000})
:ok
iex(5)> GenServer.call(account, :balance)        
2000
iex(6)> GenServer.cast(account, {:withdraw, 1000})
:ok
iex(7)> GenServer.call(account, :balance)         
1000
iex(8)> GenServer.cast(account, {:deposit, 5600})  
:ok
iex(9)> GenServer.cast(account, {:withdraw, 598}) 
:ok
iex(10)> GenServer.call(account, :balance)        
6002


# With API and server callbacks
# Commit "gen server works"

iex(2)> {:ok, account} = BankAccountGS.start_link
{:ok, #PID<0.202.0>}
iex(3)> BankAccountGS.deposit(account, 2000)     
:ok
iex(4)> BankAccountGS.withdraw(account, 200)     
:ok
iex(5)> BankAccountGS.balance(account) 

# With __MODULE__
iex(1)> BankAccountGS.start_link
{:ok, #PID<0.189.0>}
iex(2)> BankAccountGS.deposit   
deposit/1    
iex(2)> BankAccountGS.deposit(2988)
:ok
iex(3)> BankAccountGS.withdraw(56) 
:ok
iex(4)> BankAccountGS.balance     
2932
iex(5)> 



# micro-servicios

Desde el archivo de configuración se puede automatizar el start_link de algun servicio específico

O <--- App
|
O
|	|	|
0 	0	0
GS


iEx ¡es un proceso!
Todo el código es un proceso.

En el ejemplo:

 Gen Server Code
----------
Api'      | <---- en proceso Shell
		  |
Callbacks | <---- en proceso GenServer
----------


Shell <-- start_link
Proceso: iEx   

Shell <-- deposit(39)
Proceso: iEx

Shell <-- iEx 
deposit <-- iEx
cast <-- GenServer

-------------------------------


"println" operación síncrona, que envía al sistema I/O y tarda tiempo.

Elixir Logger ----> Asíncrono

------------------------

Aplicación con Phoenix

0.- Instalar postgress psql
1.- Instalando phoenix

> mix local.hex

> mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

2.- Creando proyecto de phoenix

> mix 

3.- Ejecutando la iex

> iex -S mix

4.- Problema con la DATABASE y el usuarios de postgress

> sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"

5.- Problema II con "database -speakers_dev" does not exist

> mix ecto.create

Entrar a shell iEx

6.- ver en el :observer.start / applications los procesos

- Desmenuzar phoenix

- Phx tiene un pool de conexiones en Repo.Pool (10 conexiones abre)

Si matamos una de esas conexiones, el supervisor levanta otro en automático

Procesos con Spawn-----------------
Spawn_link -> bidireccional
Spawn_monitor -> unidireccional

En el observer:

Línea Negra: Parentezco entre procesos: hijos y padres
Línea Azul: Un proceso monitorea a otros procesos sin haberlos creado.
Línea Roja: Igual que la línea azul.


----------- SUPERVISORES

Entre menos responsabilidades, menos cantidad de líneas, entre menos cantidad de líneas menor cantidad de errores.


El puerto #port es un tipo de dato.<--- usar otros códigos

PORT levanta un proceso del sistema operativo, y dentro de él corre el código escrito en otro lenguaje. Desde dentro Erlang lo ve como si fuera un  proceso de erlang, y así lo puede monitorear y supervisar. Ese proceso es equiparable al tamaño.

-------------------------


Proceso de EndPoint

-------------------------

COWBOY <---- webserver listo para producción

Está formado por varias bibliotecas: ranch, bullet, y sheriff.

Ranch: socket acceptor pull

-----------------

El proyecto de phoenix levanta muchísimos micro-servicios: ecto, elixir, logger, mix, iex, etc...


7.- Correr el proyecto de phoenix

> iex -S mix phoenix.start

Ver el :observer.start

Notar que levanta más procesos en el endPoint: server


<------------------------------------------------->

Manejo de conexiones: Phoenix como plataforma única


Socket: Conjunto de IP y Puerto
Ej: Localhost:8000
|
|_____ Puerto
|_____ IP: Intefaz de red

Protocolo TCP/IP mensajes asíncronos, donde cada proceso es una máquina

Conexión: Par de sockets

Esquemas para manejo de conexiones

- Serial
	Simple de implementar, sin concurrencia, uno a uno, bajo consumo de recursos, una conexión a la vez. Conexiones punto a punto.
- Proceso por conexión
	Concurrencia, se puede crear muchos que atiendan a varias peticiones a la vez. Cajero que da los tickets.
	Demonio: impresión, ftp, etc.
	SuperDemonio: Proceso que crea procesos.
- Thread por conexión
	1 treah = 1 mb
- Perforking
	Levanta un pool de procesos: apache.
	Si se acaba el pool, necesitar más complejidad.
- Thread pool
- Evented
	NodeJs
	Espere un momento...
	Muy rápido
	No consume recursos
	1 solo thread, 1 solo proceso
	Multples conexiones simultáneas
	Rector: while(true)
- Híbridos
	*Nginx
		-perforking y eventos
	*Apache
		-preforking y thread pool
	*Puma 
		-thread pool y evented

1 millón de conexiones
Procesos: 1 terabyte
Threads: 520 gb
Erlang: 2GB 

-------------------------------------------

Cowboy: Proceso por conexión

-------------------------------------------



































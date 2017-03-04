# Última Clase de Phoenix

Proyecto de Phoenix
- Config
	prod.secrets: Passwords(no versionado)
	config.exs: Configuración
- Deps 
	Dependencias descargadas por Phoenix(código fuente)
	Cowboy, Ecto, Phoenix, Plug
- Lib
	Código de la aplicación de Phoenix que estaos desarollando
	Versión 1.3 
	-Carpeta Web pasa a estar dentro de Lib/
- Private
	Recursos estáticos: js/css/internacionalización
	
- Test
	Pruebas
- Mix.exs y Mix.lock: Archivos en raíz 

# Mix. exs

Proyecto de configuración con sintáxis de Elixir

> def project do
	
Key Word list
- Nombre de la aplicación
- Versión
- Compiladores (extensiones) p.e. :phoenix
	Se puede indicar que compiladores inician antes que el compilador principal
- Aliases: Función para agregar alias para línea de comando.
- Application: Indica los módulos y aplicaciones que necesita nuestra aplicación para levantar.
	
- Paths: Funciones privadas que indican qué directorios usarán según los ambientes: desarrollo/producción.

- Deps: Versión de los compiladores necesarios para nuestra aplicación.
	Live_reload: Monitorean los archivos de la aplicación

# Mix.lock

Lista de las versiones de las bibliotecas. 
Esta parte le indica a "mix deps get" qué versión de las aplicaciones usadas para desarrollar fueron usadas para el desarrollo de la aplicación.

Para subir de versión en las bibliotecas usadas hay un "update" para poder hacerlo sin necesidad de entrar a este archivo.

Este archivo es importante tenerlo en control de versiones.

Puede indicar bajar una vesión >= (mayor o igual), se puede indicar un rango de versiones de las aplicaciones.

Vívorita + > = Versión compatible con 1.0 (version)

# Versionamiento Semántico

Estructura: 1.    0.     0
	    |     |      |
	   mayor  minor  bugs

Versión 1.0.1: Solo incluye correción de bugs y compatible con la versión 1.0.0, incluye garantía.

Versión 1.1.0:  Incluye nuevas cosas y posibles correcciones de bugs y compatible con la versión 1.0.0

Versión 2.0.0: No hay garantía de compatibilidad, se libera una versión con cambios mayormente significativos.


# Configuración en config.exs

Sintaxis para configuración
 > config + modulo a configurar
 > configuración del modulo de ecto
 > configuración del endpoint

 	EndPoint(phoenix) = Socket [ip:puerto]
		- Url
		- Render Errors: despliegue
		- Acceptaciones
 > Logger
	- Despliegue en consola
	- Despligue con metadatos
	- 
 > Import de la configuración de ambiente
	- Aquí se puede indicar el ambiente que se esta usando: desarrollo, o producción. 

# Directorios de configuración config/

# Configuración de desarrollo dev.exs

- Se indica un endPoint con puerto diretente
- Habilitación de debugs de errores (true)
- Credenciales de database

# configuracion de test.exs

- habilitación de endPoint (Pruebas no lo tocan)
- Configuracion de base de datos de pruebas

# Configuración de producción

- Puerto del endpoint
- Manifiesto del cache de los recursos estáticos
- Logger y nivel (:info)
- Importando credenciales
- Configuración del OTP para el endPoint (debe ser true)

* Una aplicación de Phoenix puede tener muchos endPoint para hacer pública cierta información. Se puede indicar qué endPoints se levanten, si todos o sólo algunos.

A nivel de seguridad a nivel de firewall se puede bloquear endPoints, a pesar de la seguridad por Token, el puerto estaría bloqueado por el Firewall y visible a nivel local, pero invisible.


# lib/

Usando Ejemplo de Speakers

# Speakers.exs

Nodo raíz: (Application)
- Main = Start
- Uso de supervisores (genServer)
Children's supervisors
- Recibe módulos: repo y endPoint.(importa el orden en que se escriban)


			 ----- End point
Application(nodo raíz)  |
			 ----- Repo

- Start_link(childrens, opts): Crea la estructura de procesos.
- Repo y EndPoint también son supervisores que pueden crear más supervisores.

- opts/ 
	- Estrategias: qué pasará cuando algo falle.
		- One_for_one: Cuando falle, vuelve a nacer
		- One_for_all: Mata a los demás y levanta a todos. 
		- One_for_rest: los children al crearse en un orden permiten que cuando falle algo, se mate el conflicto principal y las creaciones siguientes. La dependencia es unidireccional, se muere el principal y derivados para garantizar consistencia.
		
* Escenarios: Cuando depende uno del otro, entonces one_for_all, si no dependen one_for_one

¿A quién preguntamos qué workers están disponibles? En este caso...
	EndPoint: registro de lista de los procesos (process_id) que están en Repo.
	Cuando se mueren los procesos del repo, entonces de nada sirve tener un EndPoint mirando los procesos, existe una dependencia, por lo tanto la estrategia es one_for_all.


* Cada supervisor tiene un conjunto de reglas y estrategias. Con Phoenix se puede formar una estrcutura de Supervisores, hasta llegar al último nivel donde estarán los Workers(Lógica de negocio). Si existe un problema en un worker, el supervisor encargado lo aislará, sin permitir afectar la estructura del proyecto. Existe un límite para decir el rango entre tiempo donde sed etecta cuantas veces terminó el proceso, y entonces en consecuencia se puede hacer algo como meterlo en cuarentena.

* Los supervisores no saben qué hacen los workers.

* la estructura basada en supervisores además de aislar, lo que pasará es que se irán escalando la recuperación de errores.
En última instancia la máquina virtual de erlang intenta volver a levantar la aplicación (supervisora), o puede matarta.

* Estrategia por default: one_for_one
* Erlang tiene un servicio nativo hard_bit que supervisa los nodos o máquinas virtuales. Cuando toda la máquina se apaga, el hard-bit la levanta (supervisor)

* Se puede tener un control sobre todo esto.

# Ejercicio: Dibujar el árbol de supervisores y levantar máquina.

# Plug

- Especificación de de composición de módulos.
- Equivalente a una interfaz con ciertas funciones.
- El EndPoint tiene una lista de plugs.
	- Módulos sesión, router, etc.

- Se pueden implementar por 1) función, o 2) módulo que implementa función. 
- Recibe conexión, y siempre la devuelve, ya que la necesitan los siguientes plugs.

> defp authenticathion(conn, params) do
>	if conn.authenticate? (conn) do
>		conn
>	else
>		conn |> redirect(to: "/signing")
>	end

- Se pueden definir módulos
	- Import plug.conn
	- debe tener dos funciones: init y call

- Como si fueran un filtro, pueden recibir aquí peticiones a través del EndPoint, que tiene una fluidez de plugs hasta llegar al router.

# Router web/router.ex

- pipeline <- plugs
- pipeline <- api
- scope: pipeline, get, controller

plug -> plug -> plug -> router(plug)

- pipe_through :browser (invocación a cadena de plug)

Flujos en Plugs:

- EndPoint -> cadana de plugs -> Router(plug) -> cadenas de plugs -> controller

- SCOPE "/url"

¡Todos son plugs!

# Controller

- Es también un controlador.
- Soporta que dentro de una función puedas tener un plug.
- Los plug son formas de ir de la general a lo particular.

# Ejercicio: Imprimir la conexión en cada plug

- La última función "render" recibe  una conexión y la vista a renderear.

 Router > Controler > View > Template

- El controlador se llama "PageController", la vista será "PageView"

> use speakers2.web, :view
> use speakers2.web, :controller

- Import: Referencia a un módulo, cuyas funciones se comportan como si estuvieran definidas dentro.
- Use: para poder hacer Use de un módulo necesito poder tener en ese mismo módulo una macro __using__(which) ya que USE llama esa misma macro, mandando como parámetro en (which) un átomo como por ejemplo :view :controller :view (son funciones en speakers.web)

Con use podemos evitar duplicar /import/

- ver Routes: mix phoenix.routes

# Views /templates

	-directorios: layout y pages (views)
	- pages/index.html.eex
		> <div class...>
	- layout/app.html.eex
		> <html>...

- Se pueden tener diferentes layouts y a nivel de view poder especificar cuál usar en cualquier caso especial.
- Los templates los carga en memoria. Por eso es tan rápido.
- Usando :gettext se usa como concatenación de cadenas.

# Mix

> mix -h
> mix app.tree "árbol de dependecias"
> mix deps.tree "árbol de versiones de depenencias"
> mix deps.update
> mix gettext.extract

Generando modelo
> mix phoenix.gen.html User users name lastname email:string password	

Crea lo siguiente:
- User_controller
- edit, form, index, new, show... html.eex
-user_controller_test
- user_view
- create_user_exs

- indica agregar una línea "resources" al router.

> mix phoenix.routes

- indica que comando de mix usar

> mix ecto.migrate

Automáticamente se hace un User_controller

# User controller

- En index puedo pasar 1. Conexión, 2. View, 3. users

- Se reutilizan los templates(formularios)

# Migrations

- funcion change: cambia los datos nuevos en la base de datos.
- "timestamps" indica agregar un registro para fecha de modificación y fecha de actualización.


# Ecto

Proporciona un lenguaje para manipular la base de datos.

Ecto es completamente independiente de Phoenix. Phoenix tiene una adaptador para Ecto que facilita la integrc ión entre ecto y las formas de phoenix.

- mix ecto.create Crea solo la base de datos.
- mix ecto.drop Destruye la base de datos.
- mix ecto.gen.migrate Contruye el esquema de base de datos.
- mix ecto.rollback Deconstruye el último migration.
- mix ecto.rollback -n 4 Deconstruye cuatro migrations.

# Aliases

- ecto.setup realize: createm migrate...
- ecto.reset realize: drop, setup.

# Tareas de phenix_ecto en mix

generar controller modelo, y vista /html
> mix phoenix.gen.html
> mix phoenix.gen.json
> mix phoenix.gen.html

# ChangeSet(validador)

- Función usada por el controller.
- Tiene la estructura original, y la estructura modificada.
- Tiene también el conjunto de cambios.
- Es una estructura con la estructura original, los datos a modificar y una bandera que indicará el cambio t/f.	 

# Toda entrada de fuente externa debe ser tratada por default como basura.

- En changeSet: Cast(se toman los datos específicos), Validate(
- El changeset contiene una lista de errores. 

	- Edit
	- Recupera usuario
	- Pasar el usuario al changeset
	- Renderea el changeset a la view

	- update
	- Recibe el resultado del changeset

# Querys

- Basado en LINQ
- lenguaje para acceder a la base de datos.
- No hay sql injection.

Prepared Statements:
  * Al intentar compilar un store_procedures lo que sucede es que se crea un *plan de ejecución*
  que queda guardado, y que no se puede rehusar, un prepared-Statement si.

[arco-circunfleco] Evita el rebind de la variable.

Expresiones de consultas

Speakers.User |> Apeakers.Repo.all

Speakers.User
  |> where([p], p.available) == true
  |> Speakers.Repo.all
  
 Composición de Consultas
 
 query = from p in Speakers.User,
          select p
 query2 = from p in query ...

Finalmente sera posible tener algo así:
  last_post = User
   |> User.available
   |> User.sorted
   |> Speakers.Repo.One
   
   
# Repo

Independiente de los modelos y consultas, es solamente el canal para usar la base de datos.
Llama al adaptador de la DB y facilita que se tenga más de una base de datos.



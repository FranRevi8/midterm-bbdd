Ideas:
Empiezo pensando en una bbdd para Circle Project, pero no encuentro una forma sencilla y curiosa de hacer que funcione, creo que le falta complejidad (no necesita una bbdd demasiado compleja).

Pregunto a Chat GPT para que me de ideas y decido hacer una BBDD para una web de venta de vehículos usados.

BBDD, creación de la base de datos y de las tablas, al menos de una primera versión.
En mi experiencia ha sido más sencillo hacer primero un esquema básico (directamente empezar con el script) antes de hacer un modelo conceptual completo, por lo tanto empiezo a meter tablas para hacerme una idea de cómo va a avanzar el proyecto.

Después de hacer una tabla de vehículos y una de clientes, empiezo a re-formular y acabo con:
Marcas: separa las marcas para normalizar la tabla vehículos. Se podrá usar en la web para hacer filtros.
Vehículos: la tabla ppal del proyecto, almacena datos básicos de los coches a la venta (y vendidos).
Detalle Vehículos: se separa de la tabla “vehículos” de forma que podamos establecer una relación one-to-one en la bbdd cumpliendo con ello un requisito del midterm.
Clientes: la 2a tabla ppal del proyecto: si vendemos coches necesitamos que alguien los compre.
Ventas: relaciona los clientes y los vehículos y los clientes añadiendo información como el precio final o la fecha de ventas. 
Extras: cumple otro requisito del midterm, many-to-many.

Las creo en este orden, de manera que las relaciones se establecen directamente  sin tener que alterar tablas (pendiente de hacer un ALTER después).

Realmente podría normalizar bastante más las tablas… Pero no lo hago porque no quiero añadir complejidad a la bbdd. Prefiero centrarme en la parte de las funcionalidades web y no me importa la normalización más allá de lo básico.

Pido datos mockeados a Chat GPT.

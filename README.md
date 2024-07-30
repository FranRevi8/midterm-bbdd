Ideas:
Empiezo pensando en una bbdd para Circle Project, pero no encuentro una forma sencilla y curiosa de hacer que funcione, creo que le falta complejidad (no necesita una bbdd demasiado compleja).

Pregunto a Chat GPT para que me de ideas y decido hacer una BBDD para una web de venta de vehículos usados. Haré un CRM, no una web para el usuario final sino algo para los trabajadores del concesionario.

BBDD, creación de la base de datos y de las tablas, al menos de una primera versión.
En mi experiencia ha sido más sencillo hacer primero un esquema básico (directamente empezar con el script) antes de hacer un modelo conceptual completo, por lo tanto empiezo a meter tablas para hacerme una idea de cómo va a avanzar el proyecto.

Después de hacer una tabla de vehículos y una de clientes, empiezo a re-formular y acabo con:
Marcas: separa las marcas para normalizar la tabla vehículos. Se podrá usar en la web para hacer filtros.
Vehículos: la tabla ppal del proyecto, almacena datos básicos de los coches a la venta (y vendidos).
Detalle Vehículos: se separa de la tabla “vehículos” de forma que podamos establecer una relación one-to-one en la bbdd cumpliendo con ello un requisito del midterm.
Clientes: la 2a tabla ppal del proyecto: si vendemos coches necesitamos que alguien los compre.
Ventas: relaciona los clientes y los vehículos y los clientes añadiendo información como el precio final o la fecha de ventas. 
Extras: cumple otro requisito del midterm, many-to-many.

	Pido datos mockeados a Chat GPT.

Añado ALTERs para añadir las columnas ID necesarias para la relación One-to-One y de paso usar la función alter tal y como se pide en el midterm.

Realmente podría normalizar más las tablas, pero no lo hago porque no quiero añadir complejidad a la bbdd. Prefiero centrarme en la parte de las funcionalidades web y no me importa la normalización más allá de lo básico.

Consultas:
Empiezo por las simples, continúo con las complejas. Preguntar por si hiciese falta más complejidad.

Funciones:
Trato de hacer un par de triggers para que, al introducir un vehículo, se me actualicen automáticamente la tabla “marcas” y la tabla “detalles”. No lo consigo y acabo con un procedure que lo soluciona tal y como quería. 
Añado trigger creado en primera instancia y que no logré que funcionase debido a bucles generados por la IDs:

DELIMITER $$

CREATE TRIGGER insert_brand_if_not_exists
BEFORE INSERT ON Vehicles
FOR EACH ROW
BEGIN
    DECLARE brand_exists INT;
    
    -- Comprobar si la marca ya existe
    SELECT COUNT(*) INTO brand_exists
    FROM Brands
    WHERE id = NEW.brand_id;
    
    -- Si la marca no existe, insertarla
    IF brand_exists = 0 THEN
        INSERT INTO Brands (name) VALUES ('Nueva Marca'); -- PENDIENTE DE CAMBIO, APUNTAR A ESTO DESDE DOM
        SET NEW.brand_id = LAST_INSERT_ID();
    END IF;
END$$

DELIMITER ;


Empiezo con la web:
Con un HTML muy simple, empiezo casi directamente con Python. Importaciones y configuración de la bbdd, y empezamos con los métodos.

Decoradores de ruta ppal y para introducir coches:
Uso el procedimiento creado anteriormente en SQL, lo que hace que funcione todo casi instantáneamente. Eso sí, uso métodos GET y POST, porque añadiendo GET y un IF, cargar las direcciones auxiliares me parece más sencillo. Aparte de esto, utilizo dictionary=true para que los resultados del cursor me dejen acceder a los datos como se suele acceder a un objeto en js y no con las posiciones numéricas (esto hace que todo sea más sencillo en los HTML).

Decorador para detalles.
Por la naturaleza de mi bbdd y teniendo en cuenta el diseño que quiero que tenga la web, hacemos un nuevo HTML para cada coche en detalle y lo conectamos con la id de cada vehículo, mostrando los datos de ambas tablas (vehicles y vehicle details).

Decorador para edición de coches:
	Este tiene la peculiaridad de que, si cambias la marca del coche (que está recogida 
en “brands” y pones una nueva, obtienes un error. Por lo tanto he tenido que añadir un bloque de código IF que comprueba si la marca existe o no en la BBDD y la añade antes de modificar la id de la brand.

Decorador para eliminar coches. 
Después de probar a hacerlo varias veces sin éxito y cambiar el orden en el que se eliminan las cosas para no interferir en las claves foráneas, me doy por vencido. Genero un procedimiento en SQL (como lo que hacía para añadir coches) y encuentro como solución a lo de las claves foráneas el 
set FOREIGN_KEY_CHECKS = 0;
lo que inhabilita los foreign key mientras elimino las filas de las dos tablas de vehículo, para luego restaurar 
set FOREIGN_KEY_CHECKS = 1;
Con eso funciona a la perfección. (hacemos uso del procedimiento desde el decorador al igual que con add.
En cualquiera de los casos, mi orientación original para las eliminaciones siempre respeta el historial de vehículos vendidos, de manera que si el coche existe en la tabla sales, no se puede eliminar para garantizar que no se borra el historial de ventas. Añado flash messages para dar un mensaje de éxito o error cuando se haga una eliminación.

CSS:
Solicito a Chat GPT un css sencillito y las webs se convierten en una cosa mucho mejor. Hago pequeñas modificaciones para adaptarlo a mi gusto.


drop database if exists car_store;
create database car_store;
use car_store;

-- Crear la tabla Marcas
create table Marcas (
    id INT auto_increment primary key,
    nombre VARCHAR(50)
);

-- Crear la tabla Vehiculos
create table Vehiculos (
    id INT auto_increment primary key,
    marca_id INT,
    modelo VARCHAR(50),
    anio INT,
    precio DECIMAL(10, 2),
    constraint fk_marca foreign key (marca_id) references Marcas(id)
);

-- Crear la tabla DetallesVehiculos (One-to-One con Vehiculos)
create table DetallesVehiculos (
    id_detalle INT auto_increment primary key,
    color VARCHAR(30),
    kilometraje INT,
    tipo_combustible VARCHAR(30),
    transmision VARCHAR(30)
);

-- Crear la tabla Clientes
create table Clientes (
    id INT auto_increment primary key,
    nombre VARCHAR(50),
    email VARCHAR(50),
    telefono VARCHAR(20)
);

-- Crear la tabla Ventas
create table Ventas (
    id INT auto_increment primary key,
    vehiculo_id INT,
    cliente_id INT,
    fecha DATE,
    precio_venta DECIMAL(10, 2),
    constraint fk_vehiculo foreign key (vehiculo_id) references Vehiculos(id),
    constraint fk_cliente foreign key (cliente_id) references Clientes(id)
);

-- Crear la tabla Extras
create table Extras (
    id INT auto_increment primary key,
    nombre VARCHAR(50)
);

-- Crear la tabla intermedia VehiculoExtras (Many-to-Many entre Vehiculos y Extras)
create table VehiculoExtras (
    vehiculo_id INT,
    extra_id INT,
    constraint fk_vehiculo_extras foreign key (vehiculo_id) references Vehiculos(id),
    constraint fk_extra_vehiculo foreign key (extra_id) references Extras(id),
    primary key (vehiculo_id, extra_id)
);



-- ---------------------------------------------------------------



-- Insertar marcas
INSERT INTO Marcas (nombre) VALUES 
('Toyota'), 
('Honda'), 
('Ford'), 
('Chevrolet'), 
('BMW'), 
('Mercedes-Benz'), 
('Audi'), 
('Nissan'), 
('Hyundai'), 
('Kia');

-- Insertar vehículos
INSERT INTO Vehiculos (marca_id, modelo, anio, precio) VALUES
(1, 'Corolla', 2015, 15000.00),
(2, 'Civic', 2018, 18000.00),
(3, 'Mustang', 2020, 35000.00),
(4, 'Impala', 2017, 20000.00),
(5, 'X5', 2019, 45000.00),
(6, 'C-Class', 2020, 40000.00),
(7, 'A4', 2021, 38000.00),
(8, 'Altima', 2016, 16000.00),
(9, 'Elantra', 2018, 17000.00),
(10, 'Sportage', 2019, 22000.00);

-- Insertar detalles de vehículos
INSERT INTO DetallesVehiculos (color, kilometraje, tipo_combustible, transmision) VALUES
('Rojo', 50000, 'Gasolina', 'Automática'),
('Azul', 30000, 'Gasolina', 'Manual'),
('Negro', 10000, 'Gasolina', 'Automática'),
('Blanco', 40000, 'Gasolina', 'Automática'),
('Gris', 25000, 'Diesel', 'Manual'),
('Negro', 15000, 'Gasolina', 'Automática'),
('Azul', 5000, 'Gasolina', 'Automática'),
('Blanco', 60000, 'Gasolina', 'Manual'),
('Rojo', 35000, 'Gasolina', 'Automática'),
('Gris', 30000, 'Gasolina', 'Manual');

-- Insertar clientes
INSERT INTO Clientes (nombre, email, telefono) VALUES
('Juan Perez', 'juan.perez@example.com', '123456789'),
('Maria Gomez', 'maria.gomez@example.com', '987654321'),
('Carlos Ruiz', 'carlos.ruiz@example.com', '555555555'),
('Ana Martinez', 'ana.martinez@example.com', '444444444'),
('Luis Sanchez', 'luis.sanchez@example.com', '333333333'),
('Marta Diaz', 'marta.diaz@example.com', '222222222'),
('Jose Lopez', 'jose.lopez@example.com', '111111111'),
('Laura Fernandez', 'laura.fernandez@example.com', '666666666'),
('Miguel Torres', 'miguel.torres@example.com', '777777777'),
('Sandra Ortiz', 'sandra.ortiz@example.com', '888888888');

-- Insertar ventas
INSERT INTO Ventas (vehiculo_id, cliente_id, fecha, precio_venta) VALUES
(1, 1, '2023-01-15', 14000.00),
(2, 2, '2023-02-20', 17500.00),
(3, 3, '2023-03-25', 34000.00),
(4, 4, '2023-04-10', 19000.00),
(5, 5, '2023-05-05', 44000.00),
(6, 6, '2023-06-15', 39000.00),
(7, 7, '2023-07-20', 37000.00),
(8, 8, '2023-08-25', 15000.00),
(9, 9, '2023-09-10', 16000.00),
(10, 10, '2023-10-15', 21000.00);

-- Insertar extras
INSERT INTO Extras (nombre) VALUES 
('Asientos calefactables'), 
('Techo solar'), 
('Climatizador bizona'),
('Sistema de navegación'),
('Cámara de reversa'),
('Control de crucero adaptativo'),
('Faros LED'),
('Sistema de sonido premium'),
('Asientos de cuero'),
('Sensores de estacionamiento');

-- Insertar relación Many-to-Many entre vehículos y extras
INSERT INTO VehiculoExtras (vehiculo_id, extra_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 10), (4, 1), (4, 2),
(5, 3), (5, 4), (5, 5),
(6, 6), (6, 7), (6, 8),
(7, 9), (7, 10), (7, 1),
(8, 2), (8, 3), (8, 4),
(9, 5), (9, 6), (9, 7),
(10, 8), (10, 9), (10, 10);



-- ---------------------------------------------------------------



-- Modificar la tabla Vehiculos para añadir la columna detalle_id
alter table Vehiculos
    add column detalle_id INT,
    add constraint fk_detalle foreign key (detalle_id) references DetallesVehiculos (id_detalle);

-- Actualizar la tabla DetallesVehiculos para añadir la columna vehiculo_id
alter table DetallesVehiculos
	add column vehiculo_id INT,
    add constraint fk_vehiculo_id foreign key (vehiculo_id) references Vehiculos(id);

-- Actualizar los valores de detalle_id en Vehiculos
update Vehiculos
set detalle_id = id;

-- Actualizar los valores de vehiculo_id en DetallesVehiculos
update DetallesVehiculos
set vehiculo_id = id_detalle;



-- ---------------------------------------------------------------



-- Consultas Simples

-- 1. Seleccionar el nombre y el precio de todos los vehículos ordenando por precio
select modelo, precio from Vehiculos
order by precio;

-- 2. Seleccionar todos los clientes.
select * from Clientes;

-- 3. Seleccionar el nombre de la marca de un modelo específico (por ejemplo, con id = 2)
select nombre from Marcas where id = 2;

-- 4. Seleccionar el nombre y el email de un cliente específico (por ejemplo, con id = 3)
select nombre, email from Clientes where id = 3;

-- 5. Seleccionar los nombres de los vehículos y sus colores, ordenando por color.
select Vehiculos.modelo, DetallesVehiculos.color
from Vehiculos
join DetallesVehiculos on Vehiculos.id = DetallesVehiculos.vehiculo_id
order by color;

-- 6. Seleccionar los modelos de vehículos fabricados después del año 2020
select modelo from Vehiculos where anio >= 2020;

-- 7. Número de extras disponibles.
select count(nombre) as Extras_disponibles from Extras;

-- 8. Seleccionar los nombres de 3 clientes y sus números de teléfono
select nombre, telefono from Clientes limit 0,3;

-- 9. Seleccionar los modelos de vehículos que tienen un precio entre 15000 y 30000
select modelo, precio from Vehiculos where precio between 15000 and 30000;

-- 10. Seleccionar las fecha de todas las ventas realizadas en 2023
select * from Ventas where fecha between "2023-01-01" and "2023-12-31";



-- ---------------------------------------------------------------



-- Consultas Complejas:

-- 1. La marca y modelo de todos los vehículos:
select Marcas.nombre as marca, Vehiculos.modelo  
from Vehiculos
join Marcas on Vehiculos.marca_id = Marcas.id;

-- 2. Clientes que han comprado un vehículo con un precio mayor a 30000
select Clientes.nombre
from Clientes
join Ventas on Clientes.id = Ventas.cliente_id
where Ventas.precio_venta > 30000;

-- 3. El número de ventas para cada modelo
select Vehiculos.modelo, count(Ventas.id) as numero_ventas
from Vehiculos
join Ventas on Vehiculos.id = Ventas.vehiculo_id
group by Vehiculos.modelo;

-- 4. El nombre del cliente y el modelo del vehículo (para cada venta).
select c.nombre as Cliente, v.modelo as Modelo, ve.fecha as Fecha, ve.precio_venta as Precio
from Ventas ve
join Clientes c on ve.cliente_id = c.id
join (select * from Vehiculos where anio > 2015) v on ve.vehiculo_id = v.id;

-- 5. Clientes que han comprado más de un vehículo
select Clientes.nombre, count(Ventas.id) as numero_compras
from Clientes
join Ventas on Clientes.id = Ventas.cliente_id
group by Clientes.nombre
having count(Ventas.id) > 1;

-- 6. Marcas Premium (que tienen vehículos un precio medio mayor a 25000)
select Marcas.nombre
from Vehiculos
join Marcas on Vehiculos.marca_id = Marcas.id
group by Marcas.nombre
having avg(Vehiculos.precio) > 25000;

-- 7. Vehículos en venta
select Vehiculos.modelo
from Vehiculos
left join Ventas on Vehiculos.id = Ventas.vehiculo_id
where Ventas.id is null;

-- 8. Todos los vehículos con el número de extras que tienen:
select Vehiculos.modelo as Coche, count(VehiculoExtras.extra_id) as Total_extras
from Vehiculos
join VehiculoExtras on Vehiculos.id = VehiculoExtras.vehiculo_id
group by Vehiculos.modelo;

-- 9. Cliente con la mayor cantidad de dinero gastado
select Clientes.nombre, sum(Ventas.precio_venta) as total_gastado
from Clientes
join Ventas on Clientes.id = Ventas.cliente_id
group by Clientes.nombre
order by total_gastado desc
limit 1;

-- 10. Vehículos vendidos de color rojo.
select Vehiculos.modelo
from Vehiculos
join DetallesVehiculos on Vehiculos.id = DetallesVehiculos.vehiculo_id
join Ventas on Vehiculos.id = Ventas.vehiculo_id
where DetallesVehiculos.color = 'Rojo';



-- ---------------------------------------------------------------



-- Funciones:
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
    vehiculo_id INT PRIMARY KEY,
    color VARCHAR(30),
    kilometraje INT,
    tipo_combustible VARCHAR(30),
    transmision VARCHAR(30),
    constraint fk_vehiculo_detalle foreign key (vehiculo_id) references Vehiculos(id)
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
INSERT INTO DetallesVehiculos (vehiculo_id, color, kilometraje, tipo_combustible, transmision) VALUES
(1, 'Rojo', 50000, 'Gasolina', 'Automática'),
(2, 'Azul', 30000, 'Gasolina', 'Manual'),
(3, 'Negro', 10000, 'Gasolina', 'Automática'),
(4, 'Blanco', 40000, 'Gasolina', 'Automática'),
(5, 'Gris', 25000, 'Diesel', 'Manual'),
(6, 'Negro', 15000, 'Gasolina', 'Automática'),
(7, 'Azul', 5000, 'Gasolina', 'Automática'),
(8, 'Blanco', 60000, 'Gasolina', 'Manual'),
(9, 'Rojo', 35000, 'Gasolina', 'Automática'),
(10, 'Gris', 30000, 'Gasolina', 'Manual');

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
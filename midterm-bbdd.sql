drop database if exists car_store;
create database car_store;
use car_store;

-- Create the Brands table
create table Brands (
    id INT auto_increment primary key,
    name VARCHAR(50)
);

-- Create the Vehicles table
create table Vehicles (
    id INT auto_increment primary key,
    brand_id INT,
    model VARCHAR(50),
    year INT,
    price DECIMAL(10, 2),
    constraint fk_brand foreign key (brand_id) references Brands(id)
);

-- Create the VehicleDetails table (One-to-One with Vehicles)
create table VehicleDetails (
    id_detail INT auto_increment primary key,
    color VARCHAR(30),
    mileage INT,
    fuel_type ENUM("Diesel", "Gasoline", "Electric", "Hybrid","-"),
    transmission ENUM("Automatic", "Manual","-")
);

-- Create the Customers table
create table Customers (
    id INT auto_increment primary key,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(20)
);

-- Create the Sales table
create table Sales (
    id INT auto_increment primary key,
    vehicle_id INT,
    customer_id INT,
    date DATE,
    sale_price DECIMAL(10, 2),
    constraint fk_vehicle foreign key (vehicle_id) references Vehicles(id),
    constraint fk_customer foreign key (customer_id) references Customers(id)
);

-- Create the Extras table
create table Extras (
    id INT auto_increment primary key,
    name VARCHAR(50)
);

-- Create the intermediate table VehicleExtras (Many-to-Many between Vehicles and Extras)
create table VehicleExtras (
    vehicle_id INT,
    extra_id INT,
    constraint fk_vehicle_extras foreign key (vehicle_id) references Vehicles(id),
    constraint fk_extra_vehicle foreign key (extra_id) references Extras(id),
    primary key (vehicle_id, extra_id)
);

-- Insert brands
INSERT INTO Brands (name) VALUES 
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

-- Insert vehicles
INSERT INTO Vehicles (brand_id, model, year, price) VALUES
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

-- Insert vehicle details
INSERT INTO VehicleDetails (color, mileage, fuel_type, transmission) VALUES
('Red', 50000, 'Gasoline', 'Automatic'),
('Blue', 30000, 'Gasoline', 'Manual'),
('Black', 10000, 'Gasoline', 'Automatic'),
('White', 40000, 'Gasoline', 'Automatic'),
('Gray', 25000, 'Diesel', 'Manual'),
('Black', 15000, 'Gasoline', 'Automatic'),
('Blue', 5000, 'Gasoline', 'Automatic'),
('White', 60000, 'Gasoline', 'Manual'),
('Red', 35000, 'Gasoline', 'Automatic'),
('Gray', 30000, 'Gasoline', 'Manual');

-- Insert customers
INSERT INTO Customers (name, email, phone) VALUES
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

-- Insert sales
INSERT INTO Sales (vehicle_id, customer_id, date, sale_price) VALUES
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

-- Insert extras
INSERT INTO Extras (name) VALUES 
('Heated seats'), 
('Sunroof'), 
('Dual-zone climate control'),
('Navigation system'),
('Reverse camera'),
('Adaptive cruise control'),
('LED headlights'),
('Premium sound system'),
('Leather seats'),
('Parking sensors');

-- Insert Many-to-Many relationship between vehicles and extras
INSERT INTO VehicleExtras (vehicle_id, extra_id) VALUES
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

-- Modify the Vehicles table to add the detail_id column
alter table Vehicles
    add column detail_id INT,
    add constraint fk_detail foreign key (detail_id) references VehicleDetails (id_detail);

-- Update the VehicleDetails table to add the vehicle_id column
alter table VehicleDetails
	add column vehicle_id INT,
    add constraint fk_vehicle_id foreign key (vehicle_id) references Vehicles(id);

-- Update the detail_id values in Vehicles
update Vehicles
set detail_id = id;

-- Update the vehicle_id values in VehicleDetails
update VehicleDetails
set vehicle_id = id_detail;

-- Simple Queries

-- 1. Select the model and price of all vehicles ordering by price
select model, price from Vehicles
order by price;

-- 2. Select all customers.
select * from Customers;

-- 3. Select the name of the brand of a specific model (e.g., with id = 2)
select name from Brands where id = 2;

-- 4. Select the name and email of a specific customer (e.g., with id = 3)
select name, email from Customers where id = 3;

-- 5. Select the names of the vehicles and their colors, ordering by color.
select Vehicles.model, VehicleDetails.color
from Vehicles
join VehicleDetails on Vehicles.id = VehicleDetails.vehicle_id
order by color;

-- 6. Select the models of vehicles manufactured after the year 2020
select model from Vehicles where year >= 2020;

-- 7. Number of available extras.
select count(name) as Extras_available from Extras;

-- 8. Select the names of 3 customers and their phone numbers
select name, phone from Customers limit 0,3;

-- 9. Select the models of vehicles that have a price between 15000 and 30000
select model, price from Vehicles where price between 15000 and 30000;

-- 10. Select the dates of all sales made in 2023
select * from Sales where date between '2023-01-01' and '2023-12-31';

-- Complex Queries:

-- 1. The brand and model of all vehicles:
select Brands.name as brand, Vehicles.model  
from Vehicles
join Brands on Vehicles.brand_id = Brands.id;

-- 2. Customers who have bought a vehicle with a price greater than 30000
select Customers.name
from Customers
join Sales on Customers.id = Sales.customer_id
where Sales.sale_price > 30000;

-- 3. The number of sales for each model
select Vehicles.model, count(Sales.id) as number_of_sales
from Vehicles
join Sales on Vehicles.id = Sales.vehicle_id
group by Vehicles.model;

-- 4. The name of the customer and the model of the vehicle (for each sale).
select c.name as Customer, v.model as Model, s.date as Date, s.sale_price as Price
from Sales s
join Customers c on s.customer_id = c.id
join (select * from Vehicles where year > 2015) v on s.vehicle_id = v.id;

-- 5. Customers who have bought more than one vehicle
select Customers.name, count(Sales.id) as number_of_purchases
from Customers
join Sales on Customers.id = Sales.customer_id
group by Customers.name
having count(Sales.id) > 1;

-- 6. Premium brands (that have vehicles with an average price greater than 25000)
select Brands.name
from Vehicles
join Brands on Vehicles.brand_id = Brands.id
group by Brands.name
having avg(Vehicles.price) > 25000;

-- 7. Vehicles for sale
select Vehicles.model
from Vehicles
left join Sales on Vehicles.id = Sales.vehicle_id
where Sales.id is null;

-- 8. All vehicles with the number of extras they have:
select Vehicles.model as Car, count(VehicleExtras.extra_id) as Total_extras
from Vehicles
join VehicleExtras on Vehicles.id = VehicleExtras.vehicle_id
group by Vehicles.model;

-- 9. Customer with the highest amount of money spent
select Customers.name, sum(Sales.sale_price) as total_spent
from Customers
join Sales on Customers.id = Sales.customer_id
group by Customers.name
order by total_spent desc
limit 1;

-- 10. Vehicles sold in red color.
select Vehicles.model
from Vehicles
join VehicleDetails on Vehicles.id = VehicleDetails.vehicle_id
join Sales on Vehicles.id = Sales.vehicle_id
where VehicleDetails.color = 'Red';



-- ---------------------------------------------------------------



-- Functions:

-- When a vehicle is added, we will trigger the addition of extras (and a brand if is new). 
-- **Not being capable of doing it with triggers, I decided to do it with a Procedure:** (I will add the trigger tests in the README)

DELIMITER $$

create procedure insert_vehicle_with_brand_and_details(
    in p_brand_name VARCHAR(50),
    in p_model VARCHAR(50),
    in p_year INT,
    in p_price DECIMAL(10, 2)
)
begin
    declare v_brand_id INT;
    declare v_vehicle_id INT;
    declare v_detail_id INT;

    -- Check if the brand exists
    select id into v_brand_id
    from Brands
    where name = p_brand_name;

    -- Insert the brand if not exists
    if v_brand_id is null then
        insert into Brands (name) values (p_brand_name);
        set v_brand_id = LAST_INSERT_ID();
    end if;

    -- Insert the vehicle
    insert into Vehicles (brand_id, model, year, price)
    values (v_brand_id, p_model, p_year, p_price);
    set v_vehicle_id = LAST_INSERT_ID();

    -- Insert the details of the vehicle
    insert into VehicleDetails (vehicle_id, color, mileage, fuel_type, transmission)
    values (v_vehicle_id, '-', 0, '-', '-');
    set v_detail_id = LAST_INSERT_ID();

    -- Link the vehicle with its details
    update Vehicles
    set detail_id = v_detail_id
    where id = v_vehicle_id;
end$$

DELIMITER ;

DELIMITER $$

create procedure delete_vehicle_and_details(in p_vehicle_id INT)
begin
    declare v_sales_count INT;

    -- Check if the vehicle has been sold
    select count(*) into v_sales_count from Sales where vehicle_id = p_vehicle_id;

    if v_sales_count = 0 then
        -- Put the foreign keys off
        set FOREIGN_KEY_CHECKS = 0;
        
        -- Delete vehicle details
        delete from VehicleDetails where vehicle_id = p_vehicle_id;
        -- Delete vehicle itself
        delete from Vehicles where id = p_vehicle_id;
        
        -- Reactivate the foreign keys
        set FOREIGN_KEY_CHECKS = 1;
    else
        -- In case of sold vehicle:
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El vehículo ha sido vendido y no se puede eliminar.';
    end if;
end$$

DELIMITER ;

create table users (
    id INT auto_increment primary key,
    username VARCHAR(50) unique not null,
    password VARCHAR(50) not null,
    logged_in BOOL default false
);

insert into users (username, password) values ("admin","admin"), ("revidiego", "revidiego");































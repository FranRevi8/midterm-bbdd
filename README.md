# Proyecto Midterm: CRM para Venta de Vehículos Usados

Este proyecto es un CRM para un concesionario de vehículos usados, desarrollado como parte del curso de Ironhack que estoy estudiando. A continuación, se detalla el proceso de creación y desarrollo del proyecto, que se ha desarrollado en 4 días.

## 1. Idea Inicial
Originalmente, consideré desarrollar una base de datos (BBDD) para un proyecto llamado Circle Project. Sin embargo, decidí cambiar de dirección y opté por crear una BBDD para una web de venta de vehículos usados, enfocada en ser un CRM para los empleados del concesionario.

## 2. Diseño de la Base de Datos
### 2.1. Esquema Inicial
Comencé creando un esquema básico directamente en SQL, lo que me permitió visualizar cómo evolucionaría el proyecto.

### 2.2. Tablas Principales
- **Marcas**: Para normalizar la tabla de vehículos y permitir filtrado.
- **Vehículos**: Tabla principal que almacena datos básicos de los coches.
- **Detalle Vehículos**: Relación one-to-one con la tabla Vehículos.
- **Clientes**: Tabla principal que almacena información de los compradores.
- **Ventas**: Relaciona clientes y vehículos, añadiendo información como precio final y fecha de venta.
- **Extras**: Tabla para cumplir el requisito many-to-many del midterm.

### 2.3. Mock Data
Solicité datos mockeados a Chat GPT para poblar las tablas.

### 2.4. Normalización y ALTERs
Apliqué normalización básica y añadí columnas ID necesarias para las relaciones one-to-one mediante ALTER TABLE.

## 3. Consultas SQL
Empecé con consultas simples y progresé a consultas más complejas, asegurándome de cumplir con los requisitos del curso.

## 4. Funciones y Triggers
### 4.1. Procedimientos y Triggers
Intenté crear un trigger para actualizar automáticamente las tablas Marcas y Detalle-Vehículos al insertar un vehículo, pero enfrenté problemas con bucles de IDs. por esta razón, lo resolví con un procedimiento almacenado.

**Trigger no funcional que usé:**
```sql
DELIMITER $$

CREATE TRIGGER insert_brand_if_not_exists
BEFORE INSERT ON Vehicles
FOR EACH ROW
BEGIN
    DECLARE brand_exists INT;
    SELECT COUNT(*) INTO brand_exists
    FROM Brands
    WHERE id = NEW.brand_id;
    IF brand_exists = 0 THEN
        INSERT INTO Brands (name) VALUES ('Nueva Marca');
        SET NEW.brand_id = LAST_INSERT_ID();
    END IF;
END$$

DELIMITER ;
```

## 5. Desarrollo Web
### 5.1. HTML y Python
Desarrollé la interfaz web con HTML simple y Python para la lógica del servidor.

### 5.2. Rutas y Decoradores
- **Principal e Introducción de Coches**: Utilicé métodos GET y POST.
- **Detalles del Vehículo**: HTML específico para cada coche, mostrando datos de las tablas Vehicles y Vehicle Details.
- **Edición de Coches**: Incluye lógica para añadir nuevas marcas si no existen.
- **Eliminación de Coches**: Utiliza un procedimiento en SQL que deshabilita temporalmente las restricciones de claves foráneas para eliminar registros sin problemas.

### 5.3. CSS
Solicité un CSS sencillo a Chat GPT y realicé modificaciones para adaptar el estilo a mis preferencias.

## 6. Autenticación y Roles
### 6.1. Login
Generé un HTML y un decorador en Python para manejar el login, además de una tabla en SQL para los usuarios.

### 6.2. Roles de Usuario
Utilicé Flask-Session para gestionar la sesión y definir roles, añadiendo lógica condicional en los decoradores para mostrar información según el rol del usuario.

### 6.3. Modificaciones en HTML
Adapté los HTML para incluir funcionalidades de login y logout, y ajusté las vistas según el rol del usuario.

## 7. Conclusión
Este proyecto midterm me permitió aplicar conocimientos de SQL, Python y desarrollo web para crear un CRM funcional para la venta de vehículos usados. A lo largo del desarrollo, enfrenté y resolví varios desafíos técnicos, lo que me brindó una valiosa experiencia práctica y me permitió aprender nuevas soluciones a problemas clásicos de este tipo de proyectos.


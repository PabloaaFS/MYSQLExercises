/*
Ejercicio MySQL 1: Creación e inserción de tablas

Crear la tabla denominada AUTOMÓVILES, compuesta de los siguientes campos:
Codigo - Numérico de 2 posiciones - Obligatorio
Nombre marca - Alfanumérico de longitud 80 - Obligatorio
Precio - Numérico de 8 posiciones con 2 decimales - Obligatorio
Fecha - Campos de tipo fecha - NO Obligatorio

La clave primaria será el campo Código y se generará de forma automática al insertar los registros.

Seguir los siguientes pasos:
Una vez creada la tabla, insertar estos cuatro registros relacionados:

Marca: Peugeot - Precio: 32000 - Fecha: 25/09/2023
Marca: Opel - Precio: 25500.50 - Fecha: 19/09/2022
Marca: Audi - Precio: 37000 
Marca: Dacia - Precio: 24000 

Una vez insertados los registros, realizar una consulta que busque aquellas marcas que contengan la letra “L” en su nombre:

Realizar una consulta que busque aquellos automóviles cuyo precio sea mayor o igual a 25000 y menor que 37000.

Crear la tabla denominada MODELOS.
CodModelo - Numérico de 2 posiciones - Obligatorio
Nombre - Alfanumérico de longitud 100 - Obligatorio

Añadir un nuevo campo a la tabla AUTOMOVILES, se denominará CodModelo y que sea FK de la tabla MODELOS.
*/

CREATE DATABASE palvarezvehiculos;

USE palvarezvehiculos;

-- Crear la tabla Automoviles
CREATE TABLE automoviles (
    Codigo INT(2) AUTO_INCREMENT PRIMARY KEY,
    NombreMarca VARCHAR(80) NOT NULL,
    Precio DECIMAL(8,2) NOT NULL,
    Fecha DATE
);

-- Insertar los registros proporcionados
INSERT INTO automoviles (NombreMarca, Precio, Fecha) VALUES
('Peugeot', 32000, '2023-09-25'),
('Opel', 25500.50, '2022-09-19'),
('Audi', 37000, NULL),
('Dacia', 24000, NULL);

-- Consulta: Marcas que contienen la letra "L" en su nombre
SELECT * FROM automoviles WHERE NombreMarca LIKE '%L%';

-- Consulta: Automóviles cuyo precio sea mayor o igual a 25000 y menor que 37000
SELECT * FROM automoviles WHERE Precio >= 25000 AND Precio < 37000;

-- Crear la tabla Modelos
CREATE TABLE modelos (
    CodModelo INT(2) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Agregar el campo CodModelo como clave foránea en la tabla AUTOMOVILES
/*
ALTER TABLE AUTOMOVILES: Este comando SQL indica que se realizarán cambios en la estructura de la tabla AUTOMOVILES.
ADD CodModelo INT(2): Se añade una nueva columna llamada CodModelo a la tabla AUTOMOVILES, que es de tipo entero (INT) con una longitud máxima de 2 dígitos.

Explicación: Modifica la estructura de la tabla AUTOMOVILES para agregar una nueva columna llamada CodModelo
que servirá como clave foránea para referenciar la tabla MODELOS. 
Este campo CodModelo es de tipo INT, lo que significa que contendrá valores numéricos enteros. 
El paréntesis (2) después del INT especifica la longitud máxima del campo.
*/
ALTER TABLE automoviles ADD CodModelo INT(2);

-- Agregar la restricción de clave foránea
/*
ALTER TABLE AUTOMOVILES: Indica que se realizarán cambios en la estructura de la tabla AUTOMOVILES.
ADD CONSTRAINT fk_codmodelo: Este comando añade una restricción de clave foránea a la tabla AUTOMOVILES con el nombre fk_codmodelo.
FOREIGN KEY (CodModelo): Indica que el campo CodModelo en la tabla AUTOMOVILES es una clave foránea.
REFERENCES MODELOS(CodModelo): Especifica que la clave foránea hace referencia a la columna CodModelo de la tabla MODELOS.

Agrega una restricción de clave foránea a la tabla AUTOMOVILES que asegura que el campo CodModelo en la tabla AUTOMOVILES
solo pueda contener valores que existan en la columna CodModelo de la tabla MODELOS. 
Esto garantiza la integridad referencial entre las dos tablas y 
evita que se introduzcan valores que no existan en la tabla MODELOS.
*/
ALTER TABLE automoviles ADD CONSTRAINT fk_codmodelo FOREIGN KEY (CodModelo) REFERENCES modelos(CodModelo);
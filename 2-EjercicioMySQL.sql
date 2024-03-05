/*
Ejercicio MySQL 2: BD Biblioteca pública (BP)

Crear una estructura de tablas que posibilite almacenar la información de los títulos de una biblioteca pública:
Libros - Hay que almacenar el ISBN, el título de libro y el año de publicación.
Autores - Hay que almacenar el Nombre y apellidos, en campos distintos, y la fecha de nacimiento.
Editoriales - Hay que almacenar la Editorial y la razón social.
Temáticas - Hay que almacenar el tipo categoría del libro (Novela, Historia, Medicina... etc.)

Cada tabla debe contener adicionalmente un campo que identifique cada registro, y por tanto actúe como PK.

Consideraciones a la hora de crear las relaciones (FK):
Un autor puede haber escrito o no varios libros.
Una Editorial puede haber publicado o no varios libros.
Un libro solo puede tener asociada una categoría
Una categoría puede estar presente en varios libros
*/

CREATE DATABASE palvarezlectura;

USE palvarezlectura;

-- Crear la tabla Autores
CREATE TABLE Autores (
    AutorID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    FechaNacimiento DATE
);

-- Crear la tabla Editoriales
CREATE TABLE Editoriales (
    EditorialID INT AUTO_INCREMENT PRIMARY KEY,
    Editorial VARCHAR(100) NOT NULL,
    RazonSocial VARCHAR(100) NOT NULL
);

-- Crear la tabla Temáticas
CREATE TABLE Tematicas (
    TematicaID INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(50) NOT NULL
);

-- Crear la tabla Libros
CREATE TABLE Libros (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    AnioPublicacion INT,
    AutorID INT,
    EditorialID INT,
    TematicaID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID),
    FOREIGN KEY (EditorialID) REFERENCES Editoriales(EditorialID),
    FOREIGN KEY (TematicaID) REFERENCES Tematicas(TematicaID)
);

-- Insertar valores en la tabla Autores
INSERT INTO Autores (Nombre, Apellidos, FechaNacimiento) VALUES
('Francisco', 'Diaz Diaz', NULL),
('Alberto', 'Miguelez Lopez', NULL),
('Raúl', 'Ochandiano Rivera', NULL),
('Fernando', 'Martos Etxeberria', NULL),
('Joanne', 'Rowling', NULL),
('Miguel', 'Limón Ignacio', NULL),
('David', 'Mozas Jerez', NULL);

-- Insertar valores en la tabla Editoriales
INSERT INTO Editoriales (Editorial, RazonSocial) VALUES
('Planeta', 'Grupo Planeta'),
('O''REILLY', 'O''Reilly Media, Inc.'),
('RBA', 'RBA Libros');

-- Insertar valores en la tabla Temáticas
INSERT INTO Tematicas (Categoria) VALUES
('Historia'),
('Informática'),
('Novela');

-- Insertar valores en la tabla Libros
INSERT INTO Libros (ISBN, Titulo, AnioPublicacion, AutorID, EditorialID, TematicaID) VALUES
('9788408135628', 'Historia de Alemania', 2001, 1, 1, 1),
('9788408135629', 'Historia de España', 2002, 1, 1, 1),
('9788408135630', 'Historia de Francia', 2002, 1, 1, 1),
('9788408135631', 'La sociedad medieval', 2001, 2, 1, 1),
('9781234567890', 'Angular desde 0', 2013, 3, 2, 2),
('9789876543210', 'Crepúsculo Vampiros', 1999, 4, 3, 3),
('9789876543211', 'Crepúsculo Zombies', 1998, 4, 3, 3),
('9789876543212', 'Crepúsculo Monsters', 1997, 4, 3, 3),
('9789876543213', 'Harry Potter I', 2000, 5, 3, 3),
('9789876543214', 'Harry Potter II', 2001, 5, 3, 3),
('9789876543215', 'Harry Potter III', 2001, 5, 3, 3),
('9789876543216', 'Harry Potter IV', 2002, 5, 3, 3),
('9788408135632', 'La sociedad industrial', 1972, 2, 1, 1),
('9788408135633', 'Los templarios', 1998, 6, 1, 1),
('9788408135634', 'Los albigenses', 1986, 6, 1, 1),
('9788408135635', 'Los godos', 2001, 6, 1, 1),
('9780987654321', 'Spring', 2014, 7, 2, 2),
('9780123456789', 'jQuery', 2015, 7, 2, 2),
('9780543210987', 'MySQL', 2016, 7, 2, 2),
('9780987654322', 'Oracle', 2003, 7, 2, 2);

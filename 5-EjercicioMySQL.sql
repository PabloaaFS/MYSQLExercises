/*
Ejercicio MySQL 5: BD BP-Trigger

La biblioteca que habéis creado necesita conocer el stock de cada libro existente en el almacén. 
Para ello tenéis que crear una tabla que informe por cada libro cuántas unidades existen:

Tabla FORMATOS, campos:
Identificador único del formato.
descripción - Descripción del formato.

La tabla solo albergará dos datos:

Tapa Dura
Tapa Blanda

Tabla STOCK, campos:
Identificador único del libro.
Identificador único del formato.
Unidades del libro en el almacén.
Fecha.

El Identificador único del libro es FK contra la tabla LIBROS. 
El Identificador único del formato es FK contra la tabla FORMATOS. 
Ambos campos componen la PK de la tabla.

Tabla HISTORICO, campos:
Identificador único del libro.
Identificador único del formato.
Unidades del libro en el almacén (valor anterior).
Fecha.

Esta tabla no tiene claves.

Cada vez que se modifique el valor de las unidades existentes de un libro en la tabla STOCK 
deberá ejecutar un trigger que inserte el valor de stock antiguo en la tabla HISTORICO, 
junto con el identificador del libro, el identificador del formato y la fecha del sistema en el momento de grabación. 
Si se modifica el campo fecha de la tabla STOCK no se debe ejecutar el trigger.
*/

-- Crear tabla FORMATOS
CREATE TABLE Formatos (
    FormatoID INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Insertar datos en FORMATOS
INSERT INTO Formatos (descripcion) VALUES
('Tapa blanda'),
('Tapa dura');

-- Crear tabla LibrosEjercicio5
CREATE TABLE LibrosEjercicio5 (
    LibroID INT AUTO_INCREMENT PRIMARY KEY,
    ISBN VARCHAR(13),
    Titulo VARCHAR(100) NOT NULL,
    AnioPublicacion INT,
    AutorID INT,
    EditorialID INT,
    TematicaID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID),
    FOREIGN KEY (EditorialID) REFERENCES Editoriales(EditorialID),
    FOREIGN KEY (TematicaID) REFERENCES Tematicas(TematicaID)
);

-- Crear tabla STOCK
CREATE TABLE Stock (
    LibroID INT,
    FormatoID INT,
    Unidades INT,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (LibroID, FormatoID),
    FOREIGN KEY (LibroID) REFERENCES LibrosEjercicio5(LibroID),
    FOREIGN KEY (FormatoID) REFERENCES FORMATOS(FormatoID)
);

-- Crear tabla HISTORICO
CREATE TABLE Historico (
    LibroID INT,
    FormatoID INT,
    UnidadesAnteriores INT,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (LibroID) REFERENCES LibrosEjercicio5(LibroID),
    FOREIGN KEY (FormatoID) REFERENCES FORMATOS(FormatoID)
);

/*
Este trigger captura las actualizaciones en la tabla STOCK y, si el número de unidades cambia,
 registra el estado anterior de las unidades en la tabla HISTORICO. 
 Esto proporciona un registro de los cambios en el stock de libros en el almacén.
 
DELIMITER // y DELIMITER ;:
DELIMITER //: Establece el delimitador de comandos como // en lugar del habitual ;.
Esto es necesario para definir triggers o funciones en MySQL, ya que el delimitador predeterminado (;)
se utiliza tanto para separar comandos como para terminar la definición de triggers o funciones. 
Usar // como delimitador permite que los comandos dentro del trigger o función 
se procesen correctamente sin ser interpretados como el final del comando.
DELIMITER ;: Restablece el delimitador de comandos al valor predeterminado (;) 
después de definir el trigger. Esto asegura que los comandos posteriores en el archivo SQL utilicen el delimitador correcto.

CREATE TRIGGER historico_insert AFTER UPDATE ON STOCK:
CREATE TRIGGER historico_insert: Este comando crea un nuevo trigger en la base de datos llamado historico_insert.
AFTER UPDATE ON STOCK: Especifica que el trigger se activará después de que se actualice una fila en la tabla STOCK.

FOR EACH ROW:
Indica que el trigger se ejecutará una vez por cada fila afectada por la operación que desencadenó el trigger.

BEGIN y END:
Estos comandos delimitan el cuerpo del trigger, es decir, el conjunto de comandos que se ejecutarán cuando se active el trigger.

IF OLD.Unidades != NEW.Unidades THEN:
Esta es una condición que verifica si el valor de la columna Unidades ha cambiado después de la actualización.
OLD.Unidades se refiere al valor antiguo de la columna Unidades antes de la actualización.
NEW.Unidades se refiere al nuevo valor de la columna Unidades después de la actualización.

INSERT INTO HISTORICO (LibroID, FormatoID, UnidadesAnteriores) VALUES (OLD.LibroID, OLD.FormatoID, OLD.Unidades);:
Este comando INSERT INTO inserta una nueva fila en la tabla HISTORICO.
LibroID, FormatoID, UnidadesAnteriores especifica las columnas en las que se insertarán los valores.
VALUES (OLD.LibroID, OLD.FormatoID, OLD.Unidades) inserta los valores antiguos de LibroID, FormatoID y Unidades en la tabla HISTORICO. Esto significa que se está registrando en el histórico el estado anterior de las unidades antes de la actualización en la tabla STOCK.
*/

-- Crear trigger para insertar en HISTORICO cuando se modifica STOCK
DELIMITER //
CREATE TRIGGER historico_insert AFTER UPDATE ON STOCK
FOR EACH ROW
BEGIN
    IF OLD.Unidades != NEW.Unidades THEN
        INSERT INTO HISTORICO (LibroID, FormatoID, UnidadesAnteriores)
        VALUES (OLD.LibroID, OLD.FormatoID, OLD.Unidades);
    END IF;
END;
//
DELIMITER ;
/*
Ejercicio MySQL 7: BD BP-Función

Crear un nuevo campo en la tabla HISTORICO, que se llamará diferencia. 

En el campo diferencia, mediante el trigger, almacenar la diferencia de restar el valor antiguo 
de las unidades del libro en el almacén, con el valor nuevo.

Este cálculo se realizará mediante una función que tenéis que crear:
Valores de entrada: a la función se le pasará los valores de unidades antiguo y nuevo.
Valor de salida: la función devolverá la diferencia. El valor devuelto se almacenará en el nuevo campo.
*/

/*
Este código crea una función llamada CalcularDiferencia para calcular la diferencia entre 
las unidades antiguas y nuevas, y un trigger que se activa después de actualizar la tabla STOCK 
para registrar la diferencia en la tabla HISTORICO. 
La estructura del código se ve afectada por la necesidad de utilizar un delimitador especial debido a la definición de la función.

DELIMITER //
Cambia el delimitador de comandos de punto y coma (;) a doble barra diagonal (//). 
Esto es necesario porque la definición de funciones en MySQL contiene múltiples sentencias SQL 
que también terminan con punto y coma, por lo que se necesita un delimitador diferente para definir la función.

CREATE FUNCTION CalcularDiferencia(unidades_antiguo INT, unidades_nuevo INT) 
Inicia la definición de una nueva función llamada CalcularDiferencia, que acepta 
dos parámetros de entrada: unidades_antiguo y unidades_nuevo, ambos de tipo INT.

RETURNS INT 
Especifica que la función devuelve un valor de tipo INT.

BEGIN y END 
Marcan el inicio y el fin del bloque de código de la función.

DECLARE diferencia INT; 
Declara una variable local llamada diferencia de tipo INT para almacenar el resultado del cálculo.

SET diferencia = unidades_nuevo - unidades_antiguo; 
Calcula la diferencia entre las unidades nuevas y las unidades antiguas y almacena el resultado en la variable diferencia.

RETURN diferencia; 
Devuelve el valor almacenado en la variable diferencia como resultado de la función.
*/
-- Crear función CalcularDiferencia
DELIMITER //

CREATE FUNCTION CalcularDiferencia(unidades_antiguo INT, unidades_nuevo INT)
RETURNS INT
BEGIN
    DECLARE diferencia INT;
    SET diferencia = unidades_nuevo - unidades_antiguo;
    RETURN diferencia;
END//

DELIMITER ;

-- Crear tablas
CREATE TABLE FORMATOS (
    FormatoID INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE STOCK (
    LibroID INT,
    FormatoID INT,
    Unidades INT,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (LibroID, FormatoID),
    FOREIGN KEY (LibroID) REFERENCES Libros(LibroID),
    FOREIGN KEY (FormatoID) REFERENCES FORMATOS(FormatoID)
);

CREATE TABLE HISTORICO (
    LibroID INT,
    FormatoID INT,
    UnidadesAnteriores INT,
    diferencia INT, -- Nuevo campo para almacenar la diferencia
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (LibroID) REFERENCES Libros(LibroID),
    FOREIGN KEY (FormatoID) REFERENCES FORMATOS(FormatoID)
);

/*
CREATE TRIGGER historico_insert AFTER UPDATE ON STOCK 
Define un nuevo trigger llamado historico_insert que se activará después de actualizar una fila en la tabla STOCK.

FOR EACH ROW 
Especifica que el trigger se ejecutará una vez por cada fila afectada por la operación de actualización.

BEGIN y END 
Marcan el inicio y el fin del bloque de código del trigger.

DECLARE diff INT;
Declara una variable local llamada diff de tipo INT para almacenar la diferencia de unidades.

IF OLD.Unidades != NEW.Unidades THEN 
Comprueba si el valor de las unidades antiguas es diferente al valor de las unidades nuevas después de la actualización.

SET diff = CalcularDiferencia(OLD.Unidades, NEW.Unidades); 
Calcula la diferencia entre las unidades antiguas y las unidades nuevas utilizando la función CalcularDiferencia definida anteriormente.

INSERT INTO HISTORICO ... 
Inserta una nueva fila en la tabla HISTORICO con los valores relevantes, incluida la diferencia de unidades calculada.
*/
-- Crear trigger para actualizar HISTORICO
DELIMITER //

CREATE TRIGGER historico_insert AFTER UPDATE ON STOCK
FOR EACH ROW
BEGIN
    DECLARE diff INT;
    IF OLD.Unidades != NEW.Unidades THEN
        SET diff = CalcularDiferencia(OLD.Unidades, NEW.Unidades);
        INSERT INTO HISTORICO (LibroID, FormatoID, UnidadesAnteriores, diferencia)
        VALUES (OLD.LibroID, OLD.FormatoID, OLD.Unidades, diff);
    END IF;
END;
//

DELIMITER ;
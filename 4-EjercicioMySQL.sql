/*
Ejercicio MySQL 4: BD BP-Consulta Autores

Hacer la siguiente consulta:
Obtener en una consulta todos los autores junto con una columna extra, llamada “cuenta”, 
en la que se muestre la cantidad de libros de los que sean autores.
*/

/*
SELECT Autores.Nombre, Autores.Apellidos, COUNT(Libros.ISBN) AS cuenta:
Este es el inicio de la consulta SQL que indica qué columnas se van a seleccionar en los resultados.
Autores.Nombre, Autores.Apellidos: Selecciona el nombre y apellidos de los autores de la tabla Autores.

COUNT(Libros.ISBN) AS cuenta: 
Utiliza la función de agregación COUNT para contar el número de ISBN (número de identificación único de los libros) de la tabla Libros para cada autor.
El resultado de esta cuenta se almacena en una nueva columna llamada cuenta.

FROM Autores:
Indica la tabla principal de donde se seleccionarán los datos, en este caso, la tabla Autores.

LEFT JOIN Libros ON Autores.AutorID = Libros.AutorID:
Esta cláusula LEFT JOIN combina la tabla Autores con la tabla Libros usando la columna AutorID como clave de unión.
Utiliza LEFT JOIN en lugar de INNER JOIN para asegurarse de que todos los autores aparezcan en los resultados,
incluso si no tienen libros asociados en la tabla Libros.

GROUP BY Autores.AutorID:
Agrupa los resultados por el campo AutorID de la tabla Autores.
Esto significa que la función de agregación COUNT se aplicará a los registros que tengan el mismo AutorID,
lo que nos permitirá contar el número de libros asociados a cada autor.
*/

SELECT Autores.Nombre, Autores.Apellidos, COUNT(Libros.ISBN) AS cuenta
FROM Autores
LEFT JOIN Libros ON Autores.AutorID = Libros.AutorID
GROUP BY Autores.AutorID;
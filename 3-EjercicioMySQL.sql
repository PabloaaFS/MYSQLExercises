/*
Ejercicio MySQL 3: BD BP-Consulta Libros de Historia

Una vez creada la estructura de tablas e insertados los datos proporcionados, 
hacer la consulta indicada en el siguiente enunciado:

Obtener todos los libros de novela del autor Fernando, Martos Etxeberria y Miguel Limón Ignacio, 
y de este último, solo el libro de ‘Los Godos’. 
Ordenarlo por año de publicación de forma que los primeros registros sean los libros más antiguos. 
Todo en una misma consulta. 
*/

/*
SELECT Libros.Titulo, Libros.AnioPublicacion, Autores.Nombre, Autores.Apellidos:
Este es el inicio de la consulta SQL que indica qué columnas se van a seleccionar en los resultados.
Libros.Titulo, Libros.AnioPublicacion: Selecciona el título del libro y el año de publicación de la tabla Libros.
Autores.Nombre, Autores.Apellidos: Selecciona el nombre y apellidos del autor de la tabla Autores.

FROM Libros:
Indica la tabla principal de donde se seleccionarán los datos, en este caso, la tabla Libros.

JOIN Autores ON Libros.AutorID = Autores.AutorID:
Esta cláusula JOIN combina la tabla Libros con la tabla Autores usando la columna AutorID como clave de unión.
Esto permite obtener los detalles del autor para cada libro.

JOIN Tematicas ON Libros.TematicaID = Tematicas.TematicaID:
Esta cláusula JOIN combina la tabla Libros con la tabla Tematicas usando la columna TematicaID como clave de unión.
Esto permite obtener la categoría temática de cada libro.

WHERE Autores.Apellidos = 'Martos Etxeberria' AND Tematicas.Categoria = 'Novela':
Esta cláusula WHERE filtra los resultados para que solo se devuelvan los libros cuyo autor tenga apellidos "Martos Etxeberria" y cuya categoría temática sea "Novela".

OR (Autores.Apellidos = 'Limón Ignacio' AND Libros.Titulo = 'Los Godos'):
Esta parte de la cláusula WHERE agrega una condición adicional que permite seleccionar los libros cuyo autor tenga apellidos "Limón Ignacio" y cuyo título sea "Los Godos".
Utiliza el operador lógico OR para combinar esta condición con la anterior, de modo que se devuelvan los libros que cumplan al menos una de estas condiciones.

ORDER BY Libros.AnioPublicacion ASC:
Ordena los resultados en función del año de publicación de los libros de manera ascendente (ASC).
*/

SELECT Libros.Titulo, Libros.AnioPublicacion, Autores.Nombre, Autores.Apellidos
FROM Libros
JOIN Autores ON Libros.AutorID = Autores.AutorID
JOIN Tematicas ON Libros.TematicaID = Tematicas.TematicaID
WHERE Autores.Apellidos = 'Martos Etxeberria' AND Tematicas.Categoria = 'Novela'
   OR (Autores.Apellidos = 'Limón Ignacio' AND Libros.Titulo = 'Los Godos')
ORDER BY Libros.AnioPublicacion ASC;
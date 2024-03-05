/*
Ejercicio MySQL 6: BD BP-Consulta codificada

Obtener en una consulta el campo de la descripción de la tabla EDITORIALES codificado. Es decir:

Si el valor es RBA devolvéis EDITORIAL 1.
Si el valor es PLANETA devolvéis EDITORIAL 2.
Si el valor es O’REILLY devolvéis EDITORIAL 3.
*/

/*
Esta consulta SQL toma los valores de la columna Editorial de la tabla Editoriales y los codifica según ciertas condiciones
establecidas en la expresión CASE. 
El resultado es una nueva columna llamada Editorial_Codificado que contiene la codificación 
de los valores originales de la columna Editorial. 
Esto es útil para cambiar los valores de una columna a valores más legibles o significativos en el contexto de la consulta.

SELECT CASE Editorial ... END AS Editorial_Codificado:
Este es el inicio de la consulta SQL que indica qué columna se va a seleccionar en los resultados y cómo se va a modificar.
CASE Editorial ... END: Esto inicia una expresión CASE que evaluará el valor de la columna Editorial y realizará diferentes acciones según el valor.
AS Editorial_Codificado: Renombra el resultado de la expresión CASE como Editorial_Codificado.

CASE Editorial ... WHEN 'RBA' THEN 'EDITORIAL 1' ... ELSE 'Otro' END:
Este es el bloque CASE que define las condiciones y los resultados para cada valor posible de la columna Editorial.
WHEN 'RBA' THEN 'EDITORIAL 1': Si el valor de la columna Editorial es 'RBA', entonces se devuelve 'EDITORIAL 1'.
WHEN 'PLANETA' THEN 'EDITORIAL 2': Si el valor de la columna Editorial es 'PLANETA', entonces se devuelve 'EDITORIAL 2'.
WHEN 'O''REILLY' THEN 'EDITORIAL 3': Si el valor de la columna Editorial es 'O'REILLY', entonces se devuelve 'EDITORIAL 3'.
ELSE 'Otro': Si el valor de la columna Editorial no coincide con ninguno de los casos anteriores, se devuelve 'Otro'.

FROM Editoriales:
Indica la tabla de la que se seleccionarán los datos, en este caso, la tabla Editoriales.
*/

SELECT
    CASE Editorial
        WHEN 'RBA' THEN 'EDITORIAL 1'
        WHEN 'PLANETA' THEN 'EDITORIAL 2'
        WHEN 'O''REILLY' THEN 'EDITORIAL 3'
        ELSE 'Otro'
    END AS Editorial_Codificado
FROM
    Editoriales;

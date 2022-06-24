/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
de la tercera columna.

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/

DROP TABLE IF EXISTS data;
DROP TABLE IF EXISTS salida;

CREATE TABLE data (letter STRING, fecha DATE, number INT)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';


LOAD DATA LOCAL INPATH 'data.tsv' OVERWRITE INTO TABLE data;


INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT DISTINCT number FROM data as number
ORDER BY number
LIMIT 5;

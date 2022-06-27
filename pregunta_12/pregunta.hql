DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;


DROP TABLE IF EXISTS salida_aux;
DROP TABLE IF EXISTS salida;

CREATE TABLE salida_aux AS
SELECT letras, c3 FROM t0 
LATERAL VIEW explode(c2) t0 AS letras;

CREATE TABLE salida
AS
SELECT 
    letras,
    key as clave
FROM 
    salida_aux 
LATERAL VIEW 
    explode(c3) t0;



INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT letras, clave, count(1) AS count FROM salida
GROUP BY letras, clave;

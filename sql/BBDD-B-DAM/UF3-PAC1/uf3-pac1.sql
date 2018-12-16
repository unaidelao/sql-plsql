/*
 * DAMDAW_M02B_UF3_PAC1 - SQL - DCL y extensión procedimental
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de realizar los ejercicicos, se crean las tablas.
-- Y se crea la conexión con System.
CONNECT System/roottoor;

CREATE TABLE alumnos (
id_alumno INT NOT NULL PRIMARY KEY,
nombre VARCHAR2 (20),
apellido VARCHAR2 (29),
edad NUMBER
);

CREATE TABLE profesores (
nombre VARCHAR2 (20),
apellido VARCHAR2 (29),
asignatura VARCHAR2 (20)
);

/*
 * Ejercicio 1.
 *
 * Crea un usuario nuevo con CREATE USER en local, de nombre “Pedro” que tenga
 * permisos de solo conexión.
 */
CREATE USER Pedro IDENTIFIED BY 1234;
GRANT CREATE SESSION TO Pedro;

/*
 * Ejercicio 2.
 *
 * Crea un usuario local que se llame “Susana” usando la sintaxis GRANT con
 * permisos de solo conexión.
 */
CREATE USER Susana IDENTIFIED BY 1234;
GRANT CREATE SESSION TO Susana;

/*
 * Ejercicio 3
 *
 * Concede permisos de SELECT a Pedro en la tabla alumnos.
 */
GRANT SELECT ON alumnos TO Pedro;

/*
 * Ejercicio 4
 *
 * Da permisos a Susana de consulta, actualización e inserción en todas las
 * tablas de la base de datos. Usa la opción GRANT.
 */
GRANT SELECT ANY TABLE, UPDATE ANY TABLE, INSERT ANY TABLE TO Susana;

/*
 * Ejercicio 5
 *
 * Con el usuario de Susana, concede permisos de consulta a Pedro en la tabla
 * de profesores.
 */
GRANT ALL PRIVILEGES TO Susana;
CONNECT Susana/1234;
GRANT SELECT ON System.profesores TO Pedro;

/*
 * Ejercicio 6
 *
 * Quita todos los permisos sobre la tabla alumnos a Pedro.
 */
REVOKE ALL PRIVILEGES ON System.alumnos FROM Pedro;

/*
 * Ejercicio 7
 *
 * Conecta con root y elimina los permisos de Pedro y Susana.
 */
CONNECT System/roottoor;
REVOKE ALL PRIVILEGES FROM Susana;
REVOKE CREATE SESSION FROM Pedro;

/*
 * Ejercicio 8
 *
 * Conéctate con el usuario de Susana y haz una consulta de todos los campos de
 * la tabla alumnos y explica qué pasa.
 */
GRANT CREATE SESSION TO Susana;
INSERT INTO alumnos VALUES (1, 'Juan', 'Rodriguez', 25);
CONNECT Susana/1234;
SELECT * FROM System.alumnos;

/*
 * Ejercicio 9
 *
 * Elimina el usuario de Pedro.
 */
CONNECT System/roottoor;
DROP USER Pedro;
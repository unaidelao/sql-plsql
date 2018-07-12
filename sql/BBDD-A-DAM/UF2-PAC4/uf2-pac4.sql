/*
 * DAX_M02A_UF2_PAC4 - Lenguajes DDL y DML
 *
 * Realizado por: Unai de la O Pagaegui
 */
 
/*
 * Ejercicio 1.
 *
 * Eliminar la restricción de clave ajena en el campo árbitro en la tabla
 * partida.
 */
ALTER TABLE partida
DROP FOREIGN KEY FK_PARTIDA_1;

ALTER TABLE partida
DROP INDEX FK_PARTIDA_1;

/*
 * Ejercicio 2.
 *
 * Añadir la clave foránea para el campo árbitro en la tabla partida.
 */
ALTER TABLE partida
ADD CONSTRAINT FK_PARTIDA_1 FOREIGN KEY (arbitro) REFERENCES arbitros (num_asoc);

/*
 * Ejercicio 3.
 *
 * Aumentar la capacidad de las salas con capacidad menor que la media en un
 * 5 %.
 */
SELECT AVG(capacidad) FROM salas; -- la media es 43.

UPDATE salas
SET capacidad = CEIL(capacidad * 1.05)
WHERE capacidad < 43;

/*
 * Ejercicio 4.
 *
 * Añadir una columna sueldo en la tabla árbitros.
 */
ALTER TABLE arbitros
ADD (sueldo INTEGER(5));

/*
 * Ejercicio 5.
 *
 * Dar un sueldo fijo a todos los árbitros (15000).
 */
UPDATE arbitros
SET sueldo = 15000;

/*
 * Ejercicio 6.
 *
 * Borrar aquellas salas en las que no se han disputado partidas.
 */
DELETE salas
FROM salas LEFT JOIN partida
ON salas.codigo_salas = partida.codigo_salas
WHERE partida.codigo_salas IS NULL;

/*
 * Ejercicio 7.
 *
 * Eliminar todos los valores de la tabla partida.
 */
ALTER TABLE jugar
DROP FOREIGN KEY FK_JUGAR_2;

ALTER TABLE jugar
ADD CONSTRAINT FK_JUGAR_2 FOREIGN KEY (codigo_partida) REFERENCES partida (codigo_partida) ON DELETE CASCADE;

DELETE FROM partida;

/*
 * Ejercicio 8.
 *
 * Crear una vista con los hoteles y sus capacidades.
 */
CREATE VIEW CAPACIDAD_HOTELES AS
SELECT nombre_hotel, capacidad
FROM hotel INNER JOIN salas
ON hotel.codigo_hotel = salas.hotel;

SELECT * FROM CAPACIDAD_HOTELES;

/*
 * Ejercicio 9.
 *
 * Crear una vista con los jugadores y el nombre del país del que proceden.
 */
CREATE VIEW JUGADORES_PAISES AS
SELECT nombre_part, nombre_pais
FROM jugadores INNER JOIN participantes
ON jugadores.num_asoc = participantes.num_asoc
INNER JOIN pais
ON participantes.pais = pais.codigo_pais;

SELECT * FROM JUGADORES_PAISES;

/*
 * Tal y como está la base de datos, ¿podemos eliminar la tabla hotel?
 * ¿Qué pasos tendríamos que seguir?
 */
ALTER TABLE salas
DROP FOREIGN KEY FK_SALAS;

ALTER TABLE alojar
DROP FOREIGN KEY FK_ALOJAR_2;

DROP TABLE hotel;
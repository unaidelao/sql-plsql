/*
 * DAMDAW_M02A_UF2_PAC02 - Lenguaje DML
 *
 * Realizado por: Unai de la O Pagaegui
 */
 
/*
 * Ejercicio 1.
 *
 * Lista todos los hoteles de Lleida.
 */
SELECT * FROM hotel
WHERE provincia_hotel LIKE 'Lleida'
AND nombre_hotel LIKE 'hotel%';
  
/*
 * Ejercicio 2.
 *
 * Lista todos los hostales de la base de datos.
 */
SELECT * FROM hotel
WHERE nombre_hotel LIKE 'hostal%';
  
/*
 * Ejercicio 3.
 *
 * Listar nombre, dirección y localidad de aquellos hoteles de la provincia de
 * Lleida pero no de la ciudad de Lleida.
 */
SELECT nombre_hotel, direccion_hotel, localidad_hotel
FROM hotel
WHERE provincia_hotel LIKE 'Lleida'
AND localidad_hotel <> 'Lleida' AND nombre_hotel LIKE 'hotel%';

/*
 * Ejercicio 4.
 *
 * Deseamos conocer aquellas salas que disponen de todos los medios y con
 * capacidad menor que 50.
 */
SELECT nombre_sala
FROM salas
WHERE medio LIKE 'todos' AND capacidad < 50;

/*
 * Ejercicio 5.
 *
 * ¿Cuántas salas disponen de todos los medios?
 */
SELECT COUNT(*) AS 'Salas con todos los medios'
FROM salas
WHERE medio LIKE 'todos';

/*
 * Ejercicio 6.
 *
 * ¿Cuántos países tenemos almacenados por continentes?
 */
SELECT continente_pais AS 'Continente', COUNT(*) AS 'Nº Países'
FROM pais GROUP BY continente_pais;

/*
 * Ejercicio 7.
 *
 * Deseamos saber el nombre y apellido del jugador con nivel de juego 5.
 */
SELECT nombre_part, apellidos_part
FROM participantes
WHERE num_asoc IN (SELECT num_asoc FROM jugadores WHERE nivel = 5);

/*
 * Ejercicio 8.
 *
 * Listar todos los datos personales de los árbitros.
 */
SELECT nombre_part, apellidos_part, direccion_part, telefono_part
FROM participantes
WHERE num_asoc IN (SELECT num_asoc FROM arbitros);

/*
 * Ejercicio 9.
 *
 * Deseamos conocer los datos de aquellos hoteles situados en Avenidas.
 */
SELECT * FROM hotel
WHERE direccion_hotel LIKE 'avda%';

/*
 * Ejercicio 10.
 *
 * Deseamos conocer las representaciones de los paises: el nombre del país
 * representado y el que lo representa.
 */

SELECT B.nombre_pais AS 'País', C.nombre_pais AS 'País Representado'
FROM representa A, pais B, pais C
WHERE A.pais_1 = B.codigo_pais
AND A.pais_2 = C.codigo_pais;

/*
 * Ejercicio 11.
 *
 * Deseamos calcular la media de clubes entre los países que participan en el
 * campeonato.
 */
SELECT AVG(clubes_pais) FROM pais;

/*
 * Ejercicio 12.
 *
 * ¿Cuántos participantes caben en cada hotel?
 */
SELECT nombre_hotel, SUM(capacidad) AS 'Capacidad del Hotel'
FROM hotel H, salas S
WHERE H.codigo_hotel = S.hotel
GROUP BY nombre_hotel;

/*
 * Ejercicio 13.
 *
 * ¿Cuántas partidas ha arbitrado cada árbitro?
 */
SELECT num_asoc, COUNT(*) AS 'Partidas arbitradas'
FROM partida P, arbitros A
WHERE P.arbitro = A.num_asoc
GROUP BY num_asoc;

/*
 * Ejercicio 14.
 *
 * Nombre de los jugadores que han jugado alguna vez con las fichas negras.
 */
SELECT DISTINCT(nombre_part) AS 'Jugadores fichas negras'
FROM participantes P, jugar J
WHERE P.num_asoc = J.num_asoc AND J.color_ficha = 'negras';

/*
 * Ejercicio 15.
 *
 * Deseamos conocer el nombre de las salas que dispone el "Hotel Central",
 * ordenado por capacidad, de forma descendente.
 */
SELECT nombre_sala, capacidad
FROM salas
WHERE hotel = 'h001'
ORDER BY capacidad DESC;
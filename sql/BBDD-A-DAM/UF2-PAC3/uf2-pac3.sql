/*
 * DAX_M02A_UF2_PAC3 - Lenguaje DML
 *
 * Realizado por: Unai de la O Pagaegui
 */
 
/*
 * Ejercicio 1.
 *
 * Obtener los datos del participante más experimentado (el que ha participado
 * en más campeonatos).
 */
SELECT * FROM participantes
WHERE campeonatos = (SELECT MAX(campeonatos) FROM participantes);
  
/*
 * Ejercicio 2.
 *
 * Obtener los datos del hotel y la sala que tiene la sala más pequeña.
 */
SELECT *
FROM hotel
INNER JOIN salas ON hotel.codigo_hotel = salas.hotel
WHERE salas.capacidad = (SELECT MIN(capacidad) FROM salas);
  
/*
 * Ejercicio 3.
 *
 * Visualizar los nombres de los hoteles que tienen más de un participante
 * alojado (indicar también el número de participantes hospedados).
 */
SELECT H.nombre_hotel AS 'Nombre del Hotel', COUNT(*) AS 'Nº de participantes'
FROM hotel H INNER JOIN alojar A
WHERE H.codigo_hotel = A.hotel
GROUP BY A.hotel
HAVING COUNT(*) > 1;

/*
 * Ejercicio 4.
 *
 * Por cada hotel, calcular la media de los campeonatos de los jugadores,
 * junto con el máximo nivel de los jugadores hospedados.
 */
SELECT hotel.nombre_hotel, AVG(participantes.campeonatos), MAX(jugadores.nivel)
FROM hotel 
INNER JOIN alojar ON hotel.codigo_hotel = alojar.hotel
INNER JOIN participantes ON alojar.num_asoc = participantes.num_asoc
INNER JOIN jugadores ON participantes.num_asoc = jugadores.num_asoc
GROUP BY hotel.codigo_hotel;

/*
 * Ejercicio 5.
 *
 * Obtener los datos de los hoteles que no tienen árbitro.
 */
SELECT hotel.*
FROM hotel INNER JOIN alojar ON alojar.hotel = hotel.codigo_hotel
WHERE alojar.num_asoc NOT IN (SELECT arbitros.num_asoc FROM arbitros)
GROUP BY hotel.codigo_hotel;

/*
 * Ejercicio 6.
 *
 * Listar el nombre y apellido de los participantes junto con el nombre y
 * dirección del hotel donde se aloja durante el campeonato.
 */
SELECT P.nombre_part, P.apellidos_part, H.nombre_hotel, H.direccion_hotel
FROM participantes P
INNER JOIN alojar A ON P.num_asoc = A.num_asoc
INNER JOIN hotel H ON H.codigo_hotel = A.hotel;

/*
 * Ejercicio 7.
 *
 * Contar el número de clubes y calcular la media de los países que tienen más
 * clubes federados que la media  aritmética total de todos los países.
 */
SELECT COUNT(*) AS 'Total', SUM(clubes_pais) AS 'Suma Clubes', AVG(clubes_pais) AS 'Media'
FROM pais
WHERE clubes_pais > (SELECT AVG(clubes_pais) FROM pais);

/*
 * Ejercicio 8.
 *
 * Nombre, apellidos y color de los jugadores en las partidas, ordenado por
 * partidas.
 */
SELECT codigo_partida, nombre_part, apellidos_part, color_ficha
FROM participantes INNER JOIN jugar
ON participantes.num_asoc = jugar.num_asoc
ORDER BY codigo_partida;

/*
 * Ejercicio 9.
 *
 * Mostrar las salas en las que no se ha disputado ninguna partida, ordenadas
 * por capacidad.
 */
SELECT S.nombre_sala, S.capacidad 
FROM salas S LEFT JOIN partida P
ON S.codigo_salas = P.codigo_salas
WHERE P.codigo_salas IS NULL
ORDER BY S.capacidad;


/*
 * Ejercicio 10.
 *
 * Mostrar las salas en las que se han disputado al menos una partida.
 */
SELECT *
FROM salas S INNER JOIN partida P
ON S.codigo_salas = P.codigo_salas
GROUP BY S.codigo_salas
HAVING COUNT(P.codigo_salas) >= 1;
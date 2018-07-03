-- UF2 PAC01, BASES DE DATOS A
-- Alumno: Unai de la O Pagaegui

/* 
 * Instrucciones DDL-SQL para crear la Base de Datos CAMPEONATO, según se indica
 * en la descripción de la PAC01-UF02
 */
 
CREATE DATABASE IF NOT EXISTS CAMPEONATO;
USE CAMPEONATO;

CREATE TABLE IF NOT EXISTS HOTEL
(
  codigo_hotel CHAR(4) NOT NULL,
  nombre_hotel VARCHAR(50),
  direccion_hotel VARCHAR(100),
  telefono_hotel CHAR(9),
  localidad_hotel VARCHAR(50),
  provincia_hotel VARCHAR(50),
  PRIMARY KEY (codigo_hotel)
);

CREATE TABLE IF NOT EXISTS PAIS
(
  codigo_pais CHAR(4) NOT NULL,
  nombre_pais VARCHAR(50),
  continente_pais VARCHAR(10),
  clubes_pais INT UNSIGNED,
  PRIMARY KEY (codigo_pais)
);

CREATE TABLE IF NOT EXISTS SALAS
(
  codigo_salas CHAR(4) NOT NULL,
  nombre_sala VARCHAR(50),
  capacidad INT UNSIGNED,
  medio VARCHAR(20),
  hotel CHAR(4),
  INDEX (hotel),
  FOREIGN KEY (hotel) REFERENCES HOTEL (codigo_hotel),
  PRIMARY KEY (codigo_salas)
);

CREATE TABLE IF NOT EXISTS PARTICIPANTES
(
  num_asoc CHAR(3) NOT NULL,
  nombre_part VARCHAR(50),
  apellidos_part VARCHAR(50),
  direccion_part VARCHAR(100),
  telefono_part CHAR(9),
  campeonatos INT UNSIGNED,
  pais CHAR(4),
  INDEX (pais),
  FOREIGN KEY (pais) REFERENCES PAIS (codigo_pais),
  PRIMARY KEY (num_asoc)
);

CREATE TABLE IF NOT EXISTS ALOJAR
(
  num_asoc CHAR(3),
  INDEX (num_asoc),
  FOREIGN KEY (num_asoc) REFERENCES PARTICIPANTES (num_asoc),
  hotel CHAR(4),
  INDEX (hotel),
  FOREIGN KEY (hotel) REFERENCES HOTEL (codigo_hotel),
  fecha_in DATE,
  fecha_out DATE,
  PRIMARY KEY (num_asoc,hotel)
);

CREATE TABLE IF NOT EXISTS JUGADORES
(
  num_asoc CHAR(3),
  INDEX (num_asoc),
  FOREIGN KEY (num_asoc) REFERENCES PARTICIPANTES (num_asoc),
  nivel INT UNSIGNED,
  PRIMARY KEY (num_asoc)
);

CREATE TABLE IF NOT EXISTS ARBITROS
(
  num_asoc CHAR(3),
  INDEX (num_asoc),
  FOREIGN KEY (num_asoc) REFERENCES PARTICIPANTES (num_asoc),
  PRIMARY KEY (num_asoc)
);

CREATE TABLE IF NOT EXISTS PARTIDA
(
  codigo_partida CHAR(5) NOT NULL,
  arbitro cHAR(3),
  INDEX (arbitro),
  FOREIGN KEY (arbitro) REFERENCES ARBITROS (num_asoc),
  codigo_salas CHAR(4),
  INDEX (codigo_salas),
  FOREIGN KEY (codigo_salas) REFERENCES SALAS (codigo_salas),
  PRIMARY KEY (codigo_partida)
);

CREATE TABLE IF NOT EXISTS REPRESENTA
(
  pais_1 CHAR(4),
  INDEX (pais_1),
  FOREIGN KEY (pais_1) REFERENCES PAIS (codigo_pais),
  pais_2 CHAR(4),
  INDEX (pais_2),
  FOREIGN KEY (pais_2) REFERENCES PAIS (codigo_pais),
  PRIMARY KEY (pais_1, pais_2)
);

CREATE TABLE IF NOT EXISTS JUGAR
(
  num_asoc CHAR(3),
  INDEX (num_asoc),
  FOREIGN KEY (num_asoc) REFERENCES PARTICIPANTES (num_asoc),
  codigo_partida CHAR(5),
  INDEX (codigo_partida),
  FOREIGN KEY (codigo_partida) REFERENCES PARTIDA (codigo_partida),
  color_ficha ENUM ('blancas', 'negras'), -- porque solo puede ser blancas o negras
  PRIMARY KEY (num_asoc, codigo_partida)
);

/*
 * Instrucciones para INSERTAR datos en la base de datos creada CAMPEONATO,
 * según los requisitos de la PAC01-UF2.
 */
 
 INSERT INTO HOTEL VALUES ('h001', 'hotel central', 'c/ larga,7', '923230101', 'Lleida', 'Lleida');
 INSERT INTO HOTEL VALUES ('h002', 'hotel cappont', 'c/ rio ebro,7', '923555657', 'Alcarras', 'Lleida');
 INSERT INTO HOTEL VALUES ('h003', 'hotel ilerna', 'avda barcelona,13', '922211001', 'Barcelona', 'Barcelona');
 INSERT INTO HOTEL VALUES ('h004', 'hotel real', 'c/ ancha,14', '923622558', 'Lleida', 'Lleida');
 INSERT INTO HOTEL VALUES ('h005', 'hostal manzanares', 'avda mayor,30', '923455221', 'Bellpuig', 'Lleida');
 
 INSERT INTO PAIS VALUES ('p001', 'Rusia', 'Europa', 10);
 INSERT INTO PAIS VALUES ('p002', 'Francia', 'Europa', 3);
 INSERT INTO PAIS VALUES ('p003', 'Guayana Francesa', 'America', 1);
 INSERT INTO PAIS VALUES ('p004', 'Uzbekistan', 'Asia', 8);
 INSERT INTO PAIS VALUES ('p005', 'Nigeria', 'Africa', 14);
 
 INSERT INTO SALAS VALUES ('s001', 's_euclides', 30, 'todos', 'h001');
 INSERT INTO SALAS VALUES ('s002', 's_descartes', 60, 'todos', 'h001');
 INSERT INTO SALAS VALUES ('s003', 's_principal', 15, 'video', 'h003');
 INSERT INTO SALAS VALUES ('s004', 's_gerona', 30, 'audio', 'h004');
 INSERT INTO SALAS VALUES ('s005', 's_tarragona', 80, 'todos', 'h004');
 
 INSERT INTO PARTICIPANTES VALUES ('001', 'JOSE LUIS', 'LOPEZ VAZQUEZ', 'c/guadalquivir,8', '955233221', 4, 'p001');
 INSERT INTO PARTICIPANTES VALUES ('002', 'SERGIO', 'RAMOS GARCIA', 'c/victoria,18', '955233441', 6, 'p003');
 INSERT INTO PARTICIPANTES VALUES ('003', 'MICKEY', 'MOUSE LOPEZ', 'c/disney,28', '988566998', 1, 'p002');
 INSERT INTO PARTICIPANTES VALUES ('004', 'DONALD JOSE', 'PATO GARCIA', 'c/gargolas,14', '988744552', 14, 'p004');
 INSERT INTO PARTICIPANTES VALUES ('005', 'LUIS BRAD', 'PITT JACKSON', 'avda america,1', '652255887', 4, 'p005');
 
 INSERT INTO ALOJAR VALUES ('001', 'h001', '2017-06-26', '2017-06-28');
 INSERT INTO ALOJAR VALUES ('002', 'h001', '2017-06-26', '2017-07-26');
 INSERT INTO ALOJAR VALUES ('003', 'h002', '2017-06-26', '2017-07-26');
 INSERT INTO ALOJAR VALUES ('004', 'h003', '2017-06-26', '2017-07-01');
 INSERT INTO ALOJAR VALUES ('005', 'h005', '2017-06-26', '2017-07-14');
 
 INSERT INTO JUGADORES VALUES ('001', 5);
 INSERT INTO JUGADORES VALUES ('002', 2);
 INSERT INTO JUGADORES VALUES ('003', 6);
  
 INSERT INTO ARBITROS VALUES ('004');
 INSERT INTO ARBITROS VALUES ('005');
 
 INSERT INTO PARTIDA VALUES ('par01', '004', 's001');
 INSERT INTO PARTIDA VALUES ('par02', '004', 's002');
 INSERT INTO PARTIDA VALUES ('par03', '005', 's001');
 INSERT INTO PARTIDA VALUES ('par04', '005', 's003');
 INSERT INTO PARTIDA VALUES ('par05', '004', 's003');
 
 INSERT INTO REPRESENTA VALUES ('p002', 'p003');
 INSERT INTO REPRESENTA VALUES ('p001', 'p004');
 
 INSERT INTO JUGAR VALUES ('001', 'par01', 'negras');
 INSERT INTO JUGAR VALUES ('001', 'par03', 'negras');
 INSERT INTO JUGAR VALUES ('002', 'par01', 'blancas');
 INSERT INTO JUGAR VALUES ('002', 'par02', 'negras');
 INSERT INTO JUGAR VALUES ('003', 'par02', 'blancas');
 INSERT INTO JUGAR VALUES ('003', 'par03', 'blancas');
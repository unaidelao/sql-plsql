-- Ejemplo de creación de una tabla con llave primaria compuesta y llaves foráneas.

CREATE TABLE CURSA
(
  dni VARCHAR(9),
  codigo NUMERIC(9),
  nota DECIMAL(5,2),
  CONSTRAINT PK_CURSA PRIMARY KEY (dni, codigo),
  CONSTRAINT FK_CURSA FOREIGN KEY (dni) REFERENCES ALUMNO (dni),
  CONSTRAINT FK_CURSA_2 FOREIGN KEY (codigo) REFERENCES ASIGNATURA (codigo) 
);
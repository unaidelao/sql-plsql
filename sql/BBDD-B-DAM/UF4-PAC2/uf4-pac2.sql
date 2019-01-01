/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF04-PAC02
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF4-PAC2');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/*
 * Ejercicio 1.
 */
-- Crea el tipo animal como Objeto.
CREATE OR REPLACE TYPE animal AS OBJECT(
    nombre VARCHAR2(10),
    patas NUMBER(1),
    sonido VARCHAR2(10),
    sexo CHAR(1), -- M (masculino), F (femenino).
    fecha_nac DATE,
    MEMBER FUNCTION calcula_edad RETURN NUMBER,
    MEMBER PROCEDURE imprime_datos
) NOT FINAL;
/

-- Implementa el cuerpo del tipo objeto animal.
CREATE OR REPLACE TYPE BODY animal AS
    MEMBER FUNCTION calcula_edad RETURN NUMBER IS
    BEGIN
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_nac) / 12);
    END;
  
    MEMBER PROCEDURE imprime_datos IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESCRIPCION DEL OBJETO (Superclase)');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre || CHR(10) ||
                             'Patas: '  || patas || CHR(10) ||
                             'Sonido: ' || sonido || CHR(10) ||
                             'Sexo: '   || sexo || CHR(10) ||
                             'Edad: '   || calcula_edad());
    END;
END;
/

DECLARE
    a1 animal := animal('Whiskas', 4, 'Guau!!', 'M', '25-07-2010');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Edad de ' || a1.nombre ||
                         ': ' || a1.calcula_edad() || CHR(10));
    
    a1.imprime_datos();
END;
/

/*
 * Ejercicio 2.
 */

-- Parte declarativa de la subclase perro.
CREATE OR REPLACE TYPE perro UNDER animal(
    tipo_de_animal VARCHAR2(10),
    CONSTRUCTOR FUNCTION perro(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE imprime_datos
);
/
-- Implementa el cuerpo de la subclase perro.
CREATE OR REPLACE TYPE BODY perro AS
    CONSTRUCTOR FUNCTION perro(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT
    AS
    BEGIN
        nombre := n;
        patas := 4;
        sonido := 'Guau!';
        sexo := s;
        fecha_nac := f;
        tipo_de_animal := 'Mamifero';
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE imprime_datos IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESCRIPCION DEL OBJETO (Subclase)');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        DBMS_OUTPUT.PUT_LINE('Tipo de animal: ' || tipo_de_animal || CHR(10) ||
                             'Nombre: ' || nombre || CHR(10) ||
                             'Patas: '  || patas || CHR(10) ||
                             'Sonido: ' || sonido || CHR(10) ||
                             'Sexo: '   || sexo || CHR(10) ||
                             'Edad: '   || SELF.calcula_edad());
    END;
END;
/
-- Prueba de la subclase perro.
DECLARE
    perro1 perro := perro('Thor', 'M', '20-05-2012');
BEGIN
    perro1.imprime_datos();
END;
/

-- Parte declarativa de la subclase gato.
CREATE OR REPLACE TYPE gato UNDER animal(
    tipo_de_animal VARCHAR2(10),
    CONSTRUCTOR FUNCTION gato(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE imprime_datos
);
/
-- Implementa el cuerpo de la subclase gato.
CREATE OR REPLACE TYPE BODY gato AS
    CONSTRUCTOR FUNCTION gato(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT
    AS
    BEGIN
        nombre := n;
        patas := 4;
        sonido := 'Miau!';
        sexo := s;
        fecha_nac := f;
        tipo_de_animal := 'Mamifero';
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE imprime_datos IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESCRIPCION DEL OBJETO (Subclase)');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        DBMS_OUTPUT.PUT_LINE('Tipo de animal: ' || tipo_de_animal || CHR(10) ||
                             'Nombre: ' || nombre || CHR(10) ||
                             'Patas: '  || patas || CHR(10) ||
                             'Sonido: ' || sonido || CHR(10) ||
                             'Sexo: '   || sexo || CHR(10) ||
                             'Edad: '   || SELF.calcula_edad());
    END;
END;
/
-- Prueba de la subclase gato.
DECLARE
    gato1 gato := gato('Kira', 'F', '18-07-2013');
BEGIN
    gato1.imprime_datos();
END;
/

-- Parte declarativa de la subclase pato.
CREATE OR REPLACE TYPE pato UNDER animal(
    tipo_de_animal VARCHAR2(10),
    CONSTRUCTOR FUNCTION pato(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE imprime_datos
);
/
-- Implementa el cuerpo de la subclase pato.
CREATE OR REPLACE TYPE BODY pato AS
    CONSTRUCTOR FUNCTION pato(n VARCHAR2, s CHAR, f DATE)
    RETURN SELF AS RESULT
    AS
    BEGIN
        nombre := n;
        patas := 2;
        sonido := 'Cuak!!';
        sexo := s;
        fecha_nac := f;
        tipo_de_animal := 'Ave';
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE imprime_datos IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESCRIPCION DEL OBJETO (Subclase)');
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        DBMS_OUTPUT.PUT_LINE('Tipo de animal: ' || tipo_de_animal || CHR(10) ||
                             'Nombre: ' || nombre || CHR(10) ||
                             'Patas: '  || patas || CHR(10) ||
                             'Sonido: ' || sonido || CHR(10) ||
                             'Sexo: '   || sexo || CHR(10) ||
                             'Edad: '   || SELF.calcula_edad());
    END;
END;
/
-- Prueba de la subclase pato.
DECLARE
    pato1 pato := pato('Donald', 'M', '01-03-2010');
BEGIN
    pato1.imprime_datos();
END;
/

-- Parte declarativa de la subclase vaca.
-- Se quita el parámetro sexo del constructor pues toda
-- vaca es sexo femenino.
CREATE OR REPLACE TYPE vaca UNDER animal(
    tipo_de_animal VARCHAR2(10),
    CONSTRUCTOR FUNCTION vaca(n VARCHAR2, f DATE)
    RETURN SELF AS RESULT,
    OVERRIDING MEMBER PROCEDURE imprime_datos
);
/
-- Implementa el cuerpo de la subclase vaca.
-- Se inicializa el sexo como femenino.
CREATE OR REPLACE TYPE BODY vaca AS
    CONSTRUCTOR FUNCTION vaca(n VARCHAR2, f DATE)
    RETURN SELF AS RESULT
    AS
    BEGIN
        nombre := n;
        patas := 4;
        sonido := 'Muuuu!!';
        sexo := 'F';
        fecha_nac := f;
        tipo_de_animal := 'Mamifero';
        RETURN;
    END;
    
    OVERRIDING MEMBER PROCEDURE imprime_datos IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESCRIPCION DEL OBJETO');
        DBMS_OUTPUT.PUT_LINE('----------------------');
        DBMS_OUTPUT.PUT_LINE('Tipo de animal: ' || tipo_de_animal || CHR(10) ||
                             'Nombre: ' || nombre || CHR(10) ||
                             'Patas: '  || patas || CHR(10) ||
                             'Sonido: ' || sonido || CHR(10) ||
                             'Sexo: '   || sexo || CHR(10) ||
                             'Edad: '   || SELF.calcula_edad());
    END;
END;
/
-- Prueba de la subclase vaca.
DECLARE
    vaca1 vaca := vaca('Lucerito', '25-09-2016');
BEGIN
    vaca1.imprime_datos();
END;
/

/*
 * Instrucciones accesorias
 */
--DROP TYPE animal FORCE;

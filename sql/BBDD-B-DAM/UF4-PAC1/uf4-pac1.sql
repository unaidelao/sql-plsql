/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF04-PAC01
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF4-PAC1');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/*
 * Ejercicio 1.
 */
-- 1.A.
CREATE OR REPLACE TYPE direccion_t AS OBJECT (
calle VARCHAR2(30),
ciudad VARCHAR2(30),
provincia VARCHAR2(30),
cp NUMBER(5)
);
/

-- 1.B.
CREATE OR REPLACE TYPE empleado_t AS OBJECT (
codigo NUMBER,
nombre VARCHAR2(70),
direccion direccion_t,
telefono NUMBER(9),
fechaNac DATE,
MEMBER FUNCTION edad RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY empleado_t AS
    MEMBER FUNCTION edad RETURN NUMBER IS
    BEGIN
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, fechaNac)/12);
    END;
END;
/

-- prueba del ejercicio 1.A y 1.B.
DECLARE
    direccion1 direccion_t := direccion_t('calle Toledo', 'Aranjuez', 'Madrid', 28424); 
    empleado1 empleado_t := empleado_t(210, 'Juan', direccion1, 699123245, '12-01-1984');
    v_edad_empleado1 NUMBER;
BEGIN
    v_edad_empleado1 := empleado1.edad;
    DBMS_OUTPUT.PUT_LINE('Edad del empleado es: '|| v_edad_empleado1);
END;
/

/*
 * Ejercicio 2.
 */
-- 2.A.
DECLARE
    direccion_a direccion_t;
BEGIN
    direccion_a := NEW direccion_t('Calle los Sajardines 23', 'Alicante', 'Alicante', 03080);
    -- comprobación
    DBMS_OUTPUT.PUT_LINE('OBJETO direccion_a');
    DBMS_OUTPUT.PUT_LINE('Calle: ' || direccion_a.calle || ', ' ||
                         'Ciudad: ' || direccion_a.ciudad || ', ' ||
                         'Provincia: ' || direccion_a.provincia || ', ' ||
                         'CP: ' || direccion_a.cp);
END;
/

-- 2.B.
DECLARE
    direccion_b direccion_t;
    empleado_b empleado_t;
BEGIN
    direccion_b := NEW direccion_t('Calle del Pez 10', 'Castellon', 'Castellon', 34580);
    empleado_b := NEW empleado_t(1234, 'Jose Garrido', direccion_b, 615845212, '12-01-1979');
    -- comprobación
    DBMS_OUTPUT.PUT_LINE('OBJETO empleado_b');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || empleado_b.nombre || ', ' ||
                         'Direccion (solo la Calle): ' || empleado_b.direccion.calle || ', ' ||
                         'Fecha Nac.: ' || empleado_b.fechaNac);
END;
/


/*
 * Ejercicio 3.
 */
-- declaración de la colección empleados
CREATE OR REPLACE TYPE c_empleados IS TABLE OF VARCHAR2(10);
/

-- creación de la tabla departamento
CREATE TABLE departamento (
    sub_codigo_dept NUMBER,
    sub_nombre_dept VARCHAR(20),
    sub_empleados c_empleados
) NESTED TABLE sub_empleados STORE AS tabla_anidada;
/

-- inserciones en la tabla departamento
INSERT INTO departamento(sub_codigo_dept, sub_nombre_dept, sub_empleados)
VALUES ('101', 'Juguetes', c_empleados('Juan A.', 'Alicia B.', 'Isabel C.'));

INSERT INTO departamento(sub_codigo_dept, sub_nombre_dept, sub_empleados)
VALUES ('102', 'Deportes', c_empleados('Rosa D.', 'Ernesto E.'));

-- descripción de la estructura de la tabla departamento
DESC departamento;

-- consulta con el contenido de la tabla departamento
SELECT * FROM departamento;


/*
 * Ejercicio 4.
 */
-- declaración de la colección para empleados del 2018
CREATE OR REPLACE TYPE c_empleados2018 IS TABLE OF empleado_t;
/

-- se crea la tabla que contendrá los empleados de 2018
CREATE TABLE empleados_2018 (
    sub_anyo_actual NUMBER DEFAULT 2018,
    sub_empleados c_empleados2018
) NESTED TABLE sub_empleados STORE AS tabla_anidada2;
/

-- prueba del ejercicio 4
DECLARE
    direccion_c direccion_t := direccion_t('Calle Azucena 2', 'Lugo', 'Galicia', 77022);
    empleado_c empleado_t := empleado_t(3333, 'Ana Lugo', direccion_c, 699012345, '22-03-1987');
    
    direccion_d direccion_t := direccion_t('Calle Geranio 3', 'Orense', 'Galicia', 88022);
    empleado_d empleado_t := empleado_t(3334, 'Luis Orense', direccion_d, 620011222, '15-06-1990');
BEGIN
    INSERT INTO empleados_2018
    VALUES (default, c_empleados2018(empleado_c));
    
    INSERT INTO empleados_2018
    VALUES (default, c_empleados2018(empleado_d));
END;
/

/*
-- instrucciones accesorias
TRUNCATE TABLE empleados_2018

DESC empleados_2018

SELECT * FROM empleados_2018

SELECT t.sub_anyo_actual AS ANYO, tt.nombre, tt.telefono
FROM empleados_2018 t, table(t.sub_empleados) tt;
*/

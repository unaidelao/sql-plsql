/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF04-PAC03
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF4-PAC3');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/* ===============  EJERCICIO 1 =============== */

/*
 * Crea un tipo DIRECCIÓN con los siguientes atributos:
 *     - calle
 *     - ciudad
 *     - país
 *     - código postal
 */
CREATE OR REPLACE TYPE direccion_t AS OBJECT (
    calle VARCHAR2(30),
    ciudad VARCHAR2(30),
    pais VARCHAR2(30),
    cp NUMBER(5)
);
/

/*
 * Crea un tipo EMPLEADO con los siguientes atributos
 *     - número de empleado
 *     - nombre
 *     - apellido
 *     - email
 *     - teléfono
 *     - fecha de alta
 *     - sueldo anual
 *     - nombre del departamento
 *     - dirección (de tipo DIRECCIÓN definido antes)
 *
 * Y un método para mostrar la dirección en pantalla (IMPORTANTE: este método
 * debe estar dentro del BODY del tipo empleado).
 */
-- Parte declarativa o cabecera.
CREATE OR REPLACE TYPE empleado_t AS OBJECT (
    num_empleado NUMBER,
    nombre VARCHAR2(20),
    apellido VARCHAR2(20),
    email VARCHAR2(30),
    telefono NUMBER(9),
    fecha_alta DATE,
    sueldo_anual NUMBER,
    nombre_dpto VARCHAR2(20),
    direccion direccion_t,
    MEMBER PROCEDURE imprime_direccion
);
/

-- Parte del cuerpo.
CREATE OR REPLACE TYPE BODY empleado_t AS
    MEMBER PROCEDURE imprime_direccion IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Direccion del empleado ' || num_empleado ||
                             ' es: ' || direccion.calle || ', ' ||
                             direccion.ciudad || ', ' || direccion.pais ||
                             ', ' || direccion.cp);
    END imprime_direccion;
END;
/

/****** PRUEBA ******/
DECLARE
    dir_a direccion_t := direccion_t('calle Alemania 24', 'Madrid', 'España', 28810);
    emp_1 empleado_t := empleado_t (1, 'Juan', 'Torres', 'jtorres@aol.es', 915456389,
                                    '21-03-2017', 25000, 'Deportes', dir_a);
BEGIN
    DBMS_OUTPUT.PUT_LINE('~~~ Probando los tipos objeto creados ~~~');
    emp_1.imprime_direccion();
    DBMS_OUTPUT.PUT_LINE('Y por ejemplo, su email es ' || emp_1.email ||
                         ' , con fecha de alta '|| emp_1.fecha_alta || CHR(10));
END;
/


/*
 * Crea una tabla de empleados cuyos registros son objetos de tipo EMPLEADO y
 * dale una clave primaria al atributo 'número de empleado' en esa tabla.
 */
CREATE TABLE empleados OF empleado_t(
    CONSTRAINT empleados_pk PRIMARY KEY (num_empleado)
);
/

/*
 * Inserta tres empleados en la tabla de los empleados con los números
 * de empleado 310, 370 y 390.
 */
DECLARE
    -- direcciones
    dir_e1 direccion_t := direccion_t('calle Sol 12', 'Madrid', 'España', 28010);
    dir_e2 direccion_t := direccion_t('calle Barco 4', 'Madrid', 'España', 28020);
    dir_e3 direccion_t := direccion_t('calle San Marcos 56', 'Madrid', 'España', 28030);
    -- empleados
    e1 empleado_t := empleado_t (310, 'Sara', 'Olmedo', 'solmedo@emp.es', 917207070,
                                    '11-08-2016', 27000, 'Contabilidad', dir_e1);
    e2 empleado_t := empleado_t (370, 'Paco', 'Castillo', 'pcastillo@emp.es', 912301234,
                                    '15-11-2017', 24000, 'Almacen', dir_e2);
    e3 empleado_t := empleado_t (390, 'Alba', 'Solana', 'asolana@emp.es', 913335566,
                                    '27-10-2010', 35000, 'Ventas', dir_e3);
BEGIN
    INSERT INTO empleados VALUES (e1);
    INSERT INTO empleados VALUES (e2);
    INSERT INTO empleados VALUES (e3);
END;
/

/*
 * Modifica el sueldo del empleado no. 310, el teléfono del
 * empleado no. 370 y la calle del empleado no. 390.
 */
-- modifica sueldo del empleado 310 de 27000 a 77500.
UPDATE empleados SET sueldo_anual = 77500 WHERE num_empleado = 310;
-- modifica el teléfono del empleado 370 a 666000222.
UPDATE empleados SET telefono = 666000222 WHERE num_empleado = 370;
-- modifica la calle del empleado 390.
UPDATE empleados t SET t.direccion.calle = 'calle Nueva 1' WHERE t.num_empleado = 390;


/* SELECT personalizado para comprobar las modificaciones */
SELECT t.num_empleado, t.telefono, t.sueldo_anual, t.direccion.calle
FROM empleados t

/*
 * Elimina al empleado número 310 de la tabla.
 */
DELETE FROM empleados WHERE num_empleado = 310;


/* ===============  EJERCICIO 2 =============== */

/*
 * Crea una referencia REF al tipo EMPLEADO y apunta con tal
 * referencia al empleado 370 de la anterior tabla de empleados.
 */
DECLARE
    -- variable de tipo objeto empleado_t, null.
    empleado1 empleado_t;
    -- variable de tipo puntero que referencia a tipo objeto empleado_t.
    empleado370_puntero REF empleado_t;
    -- variable que contendrá el nombre y apellidos de un empleado.
    nombre_completo VARCHAR2(100);
BEGIN
    -- recoge el valor del puntero y lo aloja en empleado_puntero
    SELECT REF(t) INTO empleado370_puntero
    FROM empleados t WHERE t.NUM_EMPLEADO = 370;
    -- dereferencia el puntero, asignando el valor del registro en empleado1, usando tabla DUAL.
    SELECT DEREF(empleado370_puntero) INTO empleado1 FROM DUAL;
    -- asignación del valor a nombre_completo.
    nombre_completo := 'Nombre: ' || empleado1.nombre || ', ' ||
                       'Apellido: ' || empleado1.apellido;
    -- se muestra por pantalla nombre_apellido
    DBMS_OUTPUT.PUT_LINE(nombre_completo);
END;
/
    
/*
-- Instrucciones complementarias.
DROP TYPE direccion_t FORCE;
DROP TYPE empleado_t FORCE;
DROP TABLE empleados;

SELECT * FROM empleados
*/
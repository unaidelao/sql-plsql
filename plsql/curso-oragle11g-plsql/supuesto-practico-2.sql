/*
 * Oracle 11g PL/SQL - CURSO PRACTICO DE FORMACION
 *
 * Supuesto Practico 2.
 *
 * Autor: Unai de la O Pagaegui.
 */

/*
 * Crear un bloque sin nominar en SQL *PLUS que realice las siguientes
 * operaciones:
 *
 * Solicitar el siguiente literal por pantalla: nombre_de_enfermo, y
 * almacenarlo en una variable del mismo tipo y tamaño que el campo que
 * almacena el nombre en la tabla enfermo.
 *
 * Solicitar el siguiente literal par pantalla: apellidos_del_mismo, y
 * almacenarlo en una variable del mismo tipo y tamaño que el campo que
 * almacena el apellido en la tabla enfermo.
 *
 * Solicitar el siguiente literal par pantalla: dirección_donde_reside, y
 * almacenarlo en una variable del mismo tipo y tamaño que el campo que
 * almacena la dirección en la tabla enfermo.
 *
 * Mostrar un texto con la siguiente información: 'Nº de filas en tabla
 * enfermo antes de insertar =', concatenado con el resultado de contar el
 * número de filas que hay en la tabla enfermo.
 *
 * Insertar en la tabla ENFERMO un registro con la siguiente información:
 *     NUMSEGSOCIAL = 280862486
 *     NOMBRE= el nombre que se ha insertado por pantalla
 *     APELLIDOS= los apellidos introducidos por pantalla
 *     DIRECCION= la que se ha introducido por pantalla
 *     SEXO=M
 *
 * Insertar, mediante un bucle repetitivo, diez líneas en la tabla
 * HOSPITAL_ENFERMO con la siguiente información para el mismo:
 *     HOSP_CODIGO = 6
 *     INSCRIPCION = seq_inscripcion.nextval
 *     ENF_NUMSEGSOCIAL = 280862486
 *     FINSCRIPCION = TO_DATE('01012000' 'DDMMYYYY') + seq_inscripcion.nextval
 *
 * Rechazar las filas insertadas.
 *
 * Mostrar un texto con la siguiente información: 'Nº de filas en la tabla
 * enfermo después de insertar y rechazar filas=' concatenado con el
 * resultado de contar el número de filas gue hay en la tabla enfermo.
 */
SET SERVEROUTPUT ON
DECLARE
    v_nombre_enfermo ENFERMO.NOMBRE%TYPE;
    v_apellidos_enfermo ENFERMO.APELLIDOS%TYPE;
    v_direccion_enfermo ENFERMO.DIRECCION%TYPE;
    v_contador NUMBER;
BEGIN
    v_nombre_enfermo := '&nombre_del_enfermo';
    v_apellidos_enfermo := '&apellidos_del_mismo';
    v_direccion_enfermo := '&direccion_donde_reside';
    SELECT COUNT(*) INTO v_contador FROM ENFERMO;

    DBMS_OUTPUT.PUT_LINE('Num filas en tabla enfermo antes de insertar = '
                        || v_contador);

    INSERT INTO ENFERMO(NUMSEGSOCIAL, DIRECCION, NOMBRE, APELLIDOS, SEXO)
    VALUES(280862486, v_direccion_enfermo, v_nombre_enfermo, v_apellidos_enfermo,'M');

    FOR i IN 1..10 LOOP
        INSERT INTO HOSPITAL_ENFERMO (HOSP_CODIGO, INSCRIPCION, ENF_NUMSEGSOCIAL, FINSCRIPCION)
        VALUES (6,seq_inscripcion.nextval,280862486,TO_DATE('01012000','DDMMYYYY') + seq_inscripcion.nextval);
    END LOOP;
    ROLLBACK;

    SELECT COUNT(*) INTO v_contador FROM ENFERMO;
    DBMS_OUTPUT.PUT_LINE('Num filas en tabla enfermo tras insertar y rechazar filas = '
                        || v_contador);
END;
/

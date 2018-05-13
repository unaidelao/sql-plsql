/*
 * Oracle 11g PL/SQL - CURSO PRACTICO DE FORMACION
 *
 * Supuesto Practico 2.
 *
 * Autor: Unai de la O Pagaegui.
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

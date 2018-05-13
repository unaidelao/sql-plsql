/*
 * Oracle 11g PL/SQL - CURSO PRACTICO DE FORMACION
 *
 * Supuesto Practico 1.
 *
 * Autor: Unai de la O Pagaegui.
 */
SET SERVEROUTPUT ON
DECLARE
    v_nombre_enfermo ENFERMO.NOMBRE%TYPE;
    v_apellidos_enfermo ENFERMO.APELLIDOS%TYPE;
    v_direccion_enfermo ENFERMO.DIRECCION%TYPE;
BEGIN
    v_nombre_enfermo := '&Nombre_del_enfermo';
    v_apellidos_enfermo := '&Apellidos_del_enfermo';
    v_direccion_enfermo := '&Direccion_del_enfermo';
    
    DBMS_OUTPUT.PUT_LINE('DATOS DEL ENFERMO');
    DBMS_OUTPUT.PUT_LINE('-----------------' || CHR(10));
    DBMS_OUTPUT.PUT_LINE('Nombre y Apellidos: ' || v_nombre_enfermo || ', ' || v_apellidos_enfermo);
    DBMS_OUTPUT.PUT_LINE('Direccion: ' || v_direccion_enfermo);
END;
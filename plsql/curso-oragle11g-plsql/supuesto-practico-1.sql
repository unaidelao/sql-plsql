/*
 * Oracle 11g PL/SQL - CURSO PRACTICO DE FORMACION
 *
 * Supuesto Practico 1.
 *
 * Autor: Unai de la O Pagaegui.
 */

 /*
  * Crear un bloque sin nominar que realice las siguientes operaciones:
  *
  * Solicitar el siguiente literal par pantalla: nombre_de_enfermo, y
  * almacenarlo en una variable del mismo tipo y tamafio que el campo que
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
  * Una vez introducidos todos estos datos, se debera ejecutar el siguiente
  * código:
  *     DBMS_OUTPUT.PUT_LINE('DATOS DEL ENFERMO');
  *     DBMS_OUTPUT.PUT_LINE ('----------------' || CHR (10) );
  *
  * Mostrar en una primera línea el nombre del enfermo introducido por pantalla
  * seguido de una coma (,) y el apellido.
  *
  * Mostrar en una segunda línea la dirección del enfermo introducida por
  * pantalla.
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

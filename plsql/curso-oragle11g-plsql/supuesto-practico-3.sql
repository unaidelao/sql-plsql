/*
 * Oracle 11g PL/SQL - CURSO PRACTICO DE FORMACION
 *
 * Supuesto Practico 3.
 *
 * Autor: Unai de la O Pagaegui.
 */

 /*
  * (1) Realizar una consulta de la tabla DEPARTAMENTO que saque el
  * NOMBRE de todos los departamentos distintos que haya en la misma.
  *
  * (2) Crear un bloque sin nominar en SQL *PLUS que realice las siguientes
  * operaciones:
  *
  * 2.a) Declarar un tipo registro que se componga de los siguientes campos:
  *   -Un campo que almacene el nombre del departamento y que
  *   sea del mismo tipo y tamaño que su homólogo en la tabla
  *   departamentos.
  *
  *   -Un campo que almacene el número de empleados que trabajan
  *   en el departamento, de tipo numérico de 5 dígitos.
  *
  *   -Un campo que almacene el tipo de ocupación con formato VARCHAR2(20).
  *
  * 2.b) Declarar un tipo tabla que almacene registros como el que se ha creado
  * en el punto anterior.
  *
  * 2.c) Realizar una consulta que solicite por pantalla el nombre de un
  * departamento y que para el mismo, extraiga el nombre y el número de
  * empleados que trabajan en él. El nombre del departamento se almacenará
  * en el primer campo del registro declarado y el número de empleados en
  * el segundo campo de registro.
  *
  * 2.c) En el tercer campo del registro declarado se almacenarán algunos de
  * los siguientes literales (BAJA, MEDIA, ALTA) dependiendo de las siguientes
  * consideraciones:
  *   -Si el número de empleados de un departamento es menor que 10, entonces
  *   se almacenará la palabra BAJA.
  *
  *   -Si el número de empleados de un departamento se encuentra entre 10 y 19,
  *   entonces se almacenará la palabra MEDIA.
  *
  *   -En el resto de casos se almacenará la palabra ALTA.
  *
  * 2.d) Después de esto se deberá mostrar la siguiente línea:
  *     (CHR(10) || CHR(10) || 'Datos de ocupación del departarnento'
  * concatenado con el nombre del departamento que se ha almacenado en el
  * primer elemento del tipo tabla declarado.
  *
  * 2.e) A continuación, mostrará la siguiente línea:
  *     ('Ocupación actual (Tipo/n° empleados):'
  * concatenado con el símbolo '/' y por ultimo concatenado con el segundo
  * campo del tipo tabla declarado.
  */
SET SERVEROUTPUT ON
-- 1
SELECT DISTINCT DEPARTAMENTO.NOMBRE AS Nombres_Dpto FROM DEPARTAMENTO;

-- 2
DECLARE
    TYPE r_departamento IS RECORD (
        nombre_dpto DEPARTAMENTO.NOMBRE%TYPE,
        total_empleados NUMBER(5),
        ocupacion VARCHAR(20)
    );
    
    TYPE t_departamento IS TABLE OF r_departamento INDEX BY BINARY_INTEGER;

    tabla_ejercicio t_departamento;
BEGIN
    SELECT DEPARTAMENTO.NOMBRE, COUNT(DEPARTAMENTO_EMPLEADO.EMP_NIF)
    INTO tabla_ejercicio(1).nombre_dpto, tabla_ejercicio(1).total_empleados
    FROM DEPARTAMENTO, DEPARTAMENTO_EMPLEADO
    WHERE UPPER(DEPARTAMENTO.NOMBRE) = UPPER('&Indique_un_dpto')
    AND DEPARTAMENTO_EMPLEADO.DEPT_CODIGO = DEPARTAMENTO.CODIGO
    GROUP BY DEPARTAMENTO.NOMBRE;

    IF tabla_ejercicio(1).total_empleados < 10 THEN
        tabla_ejercicio(1).ocupacion := 'BAJA';
    ELSIF tabla_ejercicio(1).total_empleados BETWEEN 10 AND 19 THEN
        tabla_ejercicio(1).ocupacion := 'MEDIA';
    ELSE
        tabla_ejercicio(1).ocupacion := 'ALTA';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10)||CHR(10)|| 'Datos de ocup. dpto. ' || tabla_ejercicio(1).nombre_dpto);
    DBMS_OUTPUT.PUT_LINE('Ocup. actual (tipo/num.empleados): ' || tabla_ejercicio(1).ocupacion
                        || '/' || tabla_ejercicio(1).total_empleados);
END;
/

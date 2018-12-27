/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF03-PAC02
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF3-PAC2');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/*
 * Ejercicio 1.
 * Un procedimiento para mostrar el anyo actual.
 */
CREATE OR REPLACE PROCEDURE ejercicio1
IS
anyo INT;
BEGIN
SELECT EXTRACT(YEAR FROM SYSDATE) INTO anyo FROM DUAL;
DBMS_OUTPUT.PUT_LINE('Anyo actual: ' || anyo);
END;
/
EXECUTE ejercicio1;

/*
 * Ejercicio 2.
 * Un procedimiento que sume uno a la variable anterior cada vez que se ejecute.
 */
CREATE OR REPLACE PROCEDURE ejercicio2(anyo IN OUT INT)
IS
BEGIN
anyo := anyo + 1;
DBMS_OUTPUT.PUT_LINE('Valor actualizado de anyo: ' || anyo);
END;
/

-- Prueba del procedimiento ejercicio2.
DECLARE
anyo INT;
BEGIN
anyo := 2018;
ejercicio2(anyo);
ejercicio2(anyo);
END;
/

/*
 * Ejercicio 3.
 * Un procedimiento al que se le pasen dos cadenas como parámetros
 * y las muestre concatenadas y en mayúsculas.
 */
CREATE OR REPLACE PROCEDURE ejercicio3(cad1 IN VARCHAR2, cad2 IN VARCHAR2)
IS
cadFinal VARCHAR2(100);
BEGIN
cadFinal := UPPER(CONCAT(cad1, cad2));
DBMS_OUTPUT.PUT_LINE('Cadena 1: ' || cad1);
DBMS_OUTPUT.PUT_LINE('Cadena 2: ' || cad2);
DBMS_OUTPUT.PUT_LINE('Resultado: ' || cadFinal);
END;
/
-- Prueba del ejercicio3.
EXECUTE ejercicio3('Hola ', 'buenas tardes!');

/*
 * Ejercicio 4.
 * Bloque anónimo que pida un código de empleado y muestre su salario actual,
 * después lo disminuya en un tercio y muestre el nuevo salario.
 */
DECLARE
cod_empleado EMP.EMP_NO%TYPE;
salario_empleado EMP.SALARIO%TYPE;
nuevo_salario_empleado EMP.SALARIO%TYPE;
BEGIN
cod_empleado := &Código_del_empleado;
-- Muestra salario actual.
SELECT SALARIO INTO salario_empleado FROM EMP WHERE EMP_NO = cod_empleado;
DBMS_OUTPUT.PUT_LINE('El salario del empleado es: ' || salario_empleado);
-- Disminuye el salario en un tercio.
UPDATE EMP SET EMP.SALARIO = (salario_empleado * (2/ 3)) WHERE EMP_NO = cod_empleado;
-- Muestra el nuevo salario actualizado.
SELECT SALARIO INTO nuevo_salario_empleado FROM EMP WHERE EMP_NO = cod_empleado;
DBMS_OUTPUT.PUT_LINE('El nuevo salario del empleado es: ' || nuevo_salario_empleado);
END;
/

/*
 * Ejercicio 5.
 * Una función para mostrar el día de la semana según un valor de entrada
 * numérico, para domingo, lunes, etc. utilizando la estructura "IF/IF ELSE".
 */
CREATE OR REPLACE FUNCTION ejercicio5(num INT)
RETURN VARCHAR2
IS
dia VARCHAR2(20);
mensaje_err CHAR(30);
BEGIN
    mensaje_err := 'Valor introducido no permitido';
    IF num >= 1 AND num <= 7 THEN -- Sólo permitida la semana
        IF num = 1 THEN dia := 'Lunes';
        ELSIF num = 2 THEN
            dia := 'Martes'; 
        ELSIF num = 3 THEN
            dia := 'Miercoles';
        ELSIF num = 4 THEN
            dia := 'Jueves';
        ELSIF num = 5 THEN
            dia := 'Viernes';
        ELSIF num = 6 THEN
            dia:= 'Sabado';
        ELSE
            dia := 'Domingo';
        END IF;
    ELSE
        RETURN mensaje_err;
    END IF;
    RETURN dia;
END;
/
-- Prueba del ejercicio5.
BEGIN
DBMS_OUTPUT.PUT_LINE('Valor 7: ' || ejercicio5(7));
DBMS_OUTPUT.PUT_LINE('Valor -5: ' || ejercicio5(-5));
END;

/*
 * Ejercicio 6.
 * La misma función que muestre el día de la semana según un valor de entrada
 * numérico, para domingo, lunes, etc. pero esta vez utilizando la estructura
 * condicional "CASE".
 */
CREATE OR REPLACE FUNCTION ejercicio6(num INT)
RETURN VARCHAR2
IS
dia VARCHAR2(20);
BEGIN
    CASE num
        WHEN 1 THEN dia := 'Lunes';
        WHEN 2 THEN dia := 'Martes';
        WHEN 3 THEN dia := 'Miercoles';
        WHEN 4 THEN dia := 'Jueves';
        WHEN 5 THEN dia := 'Viernes';
        WHEN 6 THEN dia := 'Sabado';
        WHEN 7 THEN dia := 'Domingo';
        ELSE DBMS_OUTPUT.PUT_LINE('Numero pasado incoherente!!');
    END CASE;
    RETURN dia;
END;
/
-- Prueba del ejercicio6.
BEGIN
DBMS_OUTPUT.PUT_LINE('El dia se llama: ' || ejercicio6(1));
END;

/*
 * Ejercicio 7.
 * Una función que devuelva el mayor de tres números
 * pasados como parámetros.
 */
CREATE OR REPLACE FUNCTION ejercicio7(num1 INT, num2 INT, num3 INT)
RETURN INTEGER
IS
mayor INT;
BEGIN
    IF num1 >= num2 AND num1 >= num3 THEN
        mayor := num1;
    ELSIF num2 >= num1 AND num2 >= num3 THEN
        mayor := num2;
    ELSE
        mayor := num3;
    END IF;
    RETURN mayor;
END;
/
-- Prueba del ejercicio7.
BEGIN
DBMS_OUTPUT.PUT_LINE('El numero mayor es: ' || ejercicio7(12,45,3));
END;

/*
 * Ejercicio 8.
 * Un procedimiento que muestre la suma de los primeros n números
 * enteros, siendo n un parámetro de entrada.
 */
CREATE OR REPLACE PROCEDURE ejercicio8(n INT)
IS
suma_total INT;
BEGIN
suma_total := 0;
    FOR i IN 1 .. n
    LOOP
        suma_total := suma_total + i;
    END LOOP;
DBMS_OUTPUT.PUT_LINE('Suma de los ' || n || ' primeros numeros: ' || suma_total);
END;
/
-- Prueba del ejercicio8.
EXECUTE ejercicio8(4);

/*
 * Ejercicio 9.
 * Una función que determine si un número es primo, devolviendo 0 o 1.
 */
CREATE OR REPLACE FUNCTION ejercicio9(num INT)
RETURN INTEGER
IS
flag_primo INT; -- 1 será primo, 0 no primo.
BEGIN
    flag_primo := 0;
    FOR i IN 2 .. num -1
    LOOP
        IF MOD(num,i) = 0 THEN
            EXIT WHEN flag_primo = 0;
        ELSE
            flag_primo := 1;
        END IF;
    END LOOP;
    RETURN flag_primo;
END;
/
-- Prueba ejercicio9
BEGIN
DBMS_OUTPUT.PUT_LINE(ejercicio9(7));
END;

/*
 * Ejercicio 10.
 * Usando la función anterior, crear otra que calcule la suma de
 * los primeros m números primos, empezando en el 1.
 */
CREATE OR REPLACE FUNCTION ejercicio10(m INTEGER)
RETURN INTEGER
IS
    primos_encontrados INTEGER;
    suma INTEGER;
    flag_divisor BOOLEAN;
    k NUMBER;
BEGIN
    primos_encontrados := 0;
    suma := 0;
    -- se analizará hasta el número 100, por ejemplo.
    -- el número 1 se incluye como primo, según el enunciado.
    FOR n IN 1..100 LOOP
        flag_divisor := FALSE;
        k := FLOOR(n/2);
        FOR i IN 2..k LOOP
            IF (MOD(n, i) = 0) THEN
                flag_divisor := TRUE;
            END IF;
        END LOOP;
        IF (flag_divisor = FALSE) THEN -- número primo encontrado
            suma := suma + n;
            primos_encontrados := primos_encontrados +1;
        END IF;
        IF (primos_encontrados >= m) THEN EXIT; -- si llegamos a m, fin del programa.
        END IF;
    END LOOP; --fin for loop principal.
    RETURN suma;
END;
/
-- Prueba ejercicio 10.
BEGIN
DBMS_OUTPUT.PUT_LINE('Total: ' || ejercicio10(11));
END;
    
/*
 * Ejercicio 11.
 * Crea una función "Nomina1" que reciba como argumento el código de un
 * empleado y calcule el importe a cobrar cada mes, teniendo en cuenta que:
 *     - El salario que figura en la tabla "emp" es el sueldo bruto anual.
 *     - Nuestros trabajadores cobran 14 pagas iguales al año.
 *     - Cada mes les pagamos también la comisión correspondiente. La comisión
 *     que figura en la tabla es la comisión anual (correspondiente a 12 meses)
 */
CREATE OR REPLACE FUNCTION Nominal(cod EMP.EMP_NO%TYPE)
RETURN EMP.SALARIO%TYPE
IS
salario_mensual EMP.SALARIO%TYPE;
salario_bruto_anual EMP.SALARIO%TYPE;
comisión_anual EMP.COMISION%TYPE;
BEGIN
SELECT SALARIO INTO salario_bruto_anual FROM EMP WHERE EMP_NO = cod;
SELECT COMISION INTO comisión_anual FROM EMP WHERE EMP_NO = cod;
salario_mensual := (salario_bruto_anual / 14) + (comisión_anual / 12);
RETURN salario_mensual;
END;
/
-- Prueba del ejercicio 11.
BEGIN
DBMS_OUTPUT.PUT_LINE(Nominal(7654));
END;

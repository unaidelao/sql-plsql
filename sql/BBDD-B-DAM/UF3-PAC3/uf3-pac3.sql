/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF03-PAC03
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF3-PAC3');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/*
 * Ejercicio 1.
 * Programa anonimo que visualice el nombre y la localidad de todos
 * los departamentos.
 */
DECLARE
CURSOR cursor1 IS SELECT DEPT.DNOMBREBRE, DEPT.LUGAR FROM DEPT;
registroNombreLugar cursor1%ROWTYPE;
BEGIN
OPEN cursor1;
FETCH cursor1 INTO registroNombreLugar; -- lee la primera fila
WHILE cursor1%FOUND LOOP -- mientras hayan filas...
    DBMS_OUTPUT.PUT_LINE(registroNombreLugar.DNOMBREBRE || ' -> '
    || registroNombreLugar.LUGAR);
    FETCH cursor1 INTO registroNombreLugar; -- lee la siguiente fila
END LOOP;
CLOSE cursor1;
END;
/

/*
 * Ejercicio 2.
 * Programa que muestre los apellidos de los empleados que pertenecen
 * al departamento de VENTAS. Hay que numerar cada línea secuencialmente.
 */
DECLARE
CURSOR cursor1 IS SELECT EMP.APELLIDO FROM EMP
WHERE EMP.DEPT_NO = 30; -- el departamento de ventas es el 30
v_apellido EMP.APELLIDO%TYPE;
v_contador NUMBER;
BEGIN
    v_contador := 1;
    OPEN cursor1;
    FETCH cursor1 INTO v_apellido; -- lee primera fila
    WHILE cursor1%FOUND LOOP -- mientras hayan filas...
        DBMS_OUTPUT.PUT_LINE(v_contador || ': ' || v_apellido);
        FETCH cursor1 INTO v_apellido; -- lee la siguiente fila
        v_contador := v_contador + 1; -- incrementa contador
    END LOOP;
    CLOSE cursor1;
END;
/

/*
 * Ejercicio 3.
 * Crea un procedimiento que visualice por pantalla los apellidos de los empleados
 * del departamento que se recibe como argumento (se recibe el código del departamento).
 * Haz dos versiones, una usando un " for " y otra sin usarlo. Ambas versiones tienen que
 * informar en el caso de que no se muestre ningún empleado (bien porque el departamento
 * pedido no exista o que no tenga empleados).
 */

-- VERSION CON FOR.
CREATE OR REPLACE PROCEDURE UF3PAC3Ej3FOR(codigoDept NUMBER)
IS
    CURSOR cursorDept IS SELECT DNOMBREBRE FROM DEPT
    WHERE DEPT_NO = codigoDept; -- recoge el nombre del departamento
    v_nombreDept DEPT.DNOMBREBRE%TYPE; -- variable para alojar tal nombre
    CURSOR cursorApellido IS SELECT EMP.APELLIDO FROM EMP
    WHERE DEPT_NO = codigoDept; -- recoge el apellido del empleado
    v_apellido EMP.APELLIDO%TYPE; -- variable para alojar tal apellido
    v_contador NUMBER; -- variable contador
    v_parcialEmpleados NUMBER; --variable para ver si hay empleados en un dept.
    DEPT_EXCEPTION EXCEPTION;
    EMPLEADO_EXCEPTION EXCEPTION;
BEGIN
    v_contador := 1;
    v_parcialEmpleados := 0;
    OPEN cursorDept;
    FETCH cursorDept INTO v_nombreDept;
    IF cursorDept%NOTFOUND THEN
        RAISE DEPT_EXCEPTION;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Departamento ' || codigoDept || ' -> ' || v_nombreDept);
        FOR v_apellido IN cursorApellido LOOP
            v_parcialEmpleados := v_parcialEmpleados + 1;
            DBMS_OUTPUT.PUT_LINE(v_contador || ': '
                    || v_apellido.APELLIDO);
                    v_contador := v_contador +1;
        END LOOP;
        IF v_parcialEmpleados = 0 THEN
            RAISE EMPLEADO_EXCEPTION;
        END IF;
    FETCH cursorDept INTO v_nombreDept;
    END IF;
    CLOSE cursorDept;
EXCEPTION
    WHEN DEPT_EXCEPTION THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION: El Departamento ' ||codigoDept || ' no existe!!');
    WHEN EMPLEADO_EXCEPTION THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION: Departamento ' ||codigoDept || ' sin empleados!!');
END;
/


BEGIN
UF3PAC3Ej3FOR(10);
UF3PAC3Ej3FOR(20);
UF3PAC3Ej3FOR(30);
UF3PAC3Ej3FOR(40);
UF3PAC3Ej3FOR(90);
END;

-- VERSION SIN FOR
CREATE OR REPLACE PROCEDURE UF3PAC3Ej3SINFOR(codigoDept NUMBER)
IS
CURSOR cursorDept IS SELECT DNOMBREBRE FROM DEPT
WHERE DEPT_NO = codigoDept; -- recoge el nombre del departamento
v_nombreDept DEPT.DNOMBREBRE%TYPE; -- variable para alojar tal nombre
CURSOR cursorApellido IS SELECT EMP.APELLIDO FROM EMP
WHERE DEPT_NO = codigoDept; -- recoge el apellido del empleado
v_apellido EMP.APELLIDO%TYPE; -- variable para alojar tal apellido
v_contador NUMBER; -- variable contador
DEPT_EXCEPTION EXCEPTION;
EMPLEADO_EXCEPTION EXCEPTION;
BEGIN
    v_contador := 1;
    OPEN cursorDept;
    FETCH cursorDept INTO v_nombreDept;
    IF cursorDept%NOTFOUND THEN
        RAISE DEPT_EXCEPTION;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Departamento ' || codigoDept || ' -> ' || v_nombreDept);
        OPEN cursorApellido;
        FETCH cursorApellido INTO v_apellido;
        IF cursorApellido%NOTFOUND THEN
            RAISE EMPLEADO_EXCEPTION;
        END IF;
        WHILE cursorApellido%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(v_contador || ': '
            || v_apellido);
            v_contador := v_contador +1;
            FETCH cursorApellido INTO v_apellido;
        END LOOP;
        CLOSE cursorApellido;
    END IF;
    CLOSE cursorDept;
EXCEPTION
    WHEN DEPT_EXCEPTION THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION: El Departamento ' ||codigoDept || ' no existe!!');
    WHEN EMPLEADO_EXCEPTION THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION: Departamento ' ||codigoDept || ' sin empleados!!');
END;
/

BEGIN
UF3PAC3Ej3SINFOR(10);
UF3PAC3Ej3SINFOR(20);
UF3PAC3Ej3SINFOR(30);
UF3PAC3Ej3SINFOR(40);
UF3PAC3Ej3SINFOR(90);
END;

/*
 * Ejercicio 4.
 * Crear una función que sirva para calcular cuántos empleados del departamento
 * que pasamos por parámetro cobran comisión (significa comisión mayor que 0):
 * pasamos por parámetro el código del departamento; hazlo sin utilizar la función
 * de agregación COUNT(); si el departamento no existe, la función debe devolver NULL;
 * si el departamento no tiene ningún empleado que cobre comisión, la función debe devolver 0.
 */
CREATE OR REPLACE FUNCTION UF3PAC3Ej4 (numDept NUMBER)
RETURN NUMBER
IS
    CURSOR cursorEmpleados IS SELECT * FROM EMP
    WHERE EMP.DEPT_NO = numDept;
    registroEmpleado EMP%ROWTYPE;
    CURSOR cursorDept IS SELECT DEPT.DNOMBREBRE FROM DEPT
    WHERE DEPT.DEPT_NO = NumDept;
    v_departamento DEPT.DNOMBREBRE%TYPE;
    v_contador NUMBER;
BEGIN
    v_contador := 0;
    OPEN cursorDept;
    FETCH cursorDept INTO v_departamento;
    IF cursorDept%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('El departamento ' || numDept || ' no figura en BBDD');
        RETURN NULL;
    ELSE
        OPEN cursorEmpleados;
        FETCH cursorEmpleados INTO registroEmpleado;
        WHILE cursorEmpleados%FOUND AND registroEmpleado.COMISION > 0 LOOP
            v_contador := v_contador + 1;
            FETCH cursorEmpleados INTO registroEmpleado;
        END LOOP;
        CLOSE cursorEmpleados;
    END IF;
RETURN v_contador;
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE(UF3PAC3Ej4(10));
DBMS_OUTPUT.PUT_LINE(UF3PAC3Ej4(20));
DBMS_OUTPUT.PUT_LINE(UF3PAC3Ej4(30));
DBMS_OUTPUT.PUT_LINE(UF3PAC3Ej4(40));
DBMS_OUTPUT.PUT_LINE(UF3PAC3Ej4(90));
END;

/*
 * Ejercicio 5.
 * Haz un procedimiento que, utilizando la función del ejercicio 4, muestre
 * por pantalla el código y nombre de los departamentos en los que menos de
 * la mitad de sus empleados cobren comisión. Si el departamento no tiene
 * ningún empleado, debe mostrar un mensaje informativo.
 */
CREATE OR REPLACE PROCEDURE UF3PAC3Ej5
IS
    CURSOR cursorDept IS SELECT * FROM DEPT;
    registroDept DEPT%ROWTYPE;
    v_cantidad NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('RESULTADO');
    OPEN cursorDept;
    FETCH cursorDept INTO registroDept;
    WHILE cursorDept%FOUND LOOP
        SELECT COUNT(*) INTO v_cantidad FROM EMP
        WHERE EMP.DEPT_NO = registroDept.DEPT_NO;
        IF UF3PAC3Ej4(registroDept.DEPT_NO) < v_cantidad / 2 THEN
                DBMS_OUTPUT.PUT_LINE('Departamento ' || registroDept.DEPT_NO
                || ' -> ' || registroDept.DNOMBREBRE);
        END IF;
        IF v_cantidad = 0 THEN
            DBMS_OUTPUT.PUT_LINE('El Departamento ' || registroDept.DEPT_NO
            || ' no tiene empleados!!');
        END IF;
        FETCH cursorDept INTO registroDept;
    END LOOP;
    CLOSE cursorDept;
END;
/

EXECUTE UF3PAC3Ej5;

/*
 * Ejercicio 6.
 * Programa que muestre por cada departamento una línea con el número de
 * empleados y la suma de los salarios del departamento. A continuación la
 * lista de los apellidos y salarios de los empleados de este departamento.
 * Al final del listado: El número total de empleados de la empresa y suma
 * de todos los salarios.
 */
CREATE OR REPLACE PROCEDURE UF3PAC3Ej6
IS
    CURSOR cursorDept IS SELECT * FROM DEPT;
    registroDept DEPT%ROWTYPE;
    CURSOR cursorEmpleados IS SELECT * FROM EMP;
    registroEmpleados EMP%ROWTYPE;
    v_totalEmpleadosPorDept NUMBER;
    v_totalSalarioPorDept NUMBER;
    v_totalEmpleados NUMBER;
    v_totalSalarios NUMBER;
BEGIN
    -- Se inician las variables a 0.
    v_totalEmpleadosPorDept := 0;
    v_totalSalarioPorDept := 0;
    v_totalEmpleados := 0;
    v_totalSalarios := 0;
    -- Recupera datos propios del departamento.
    FOR registroDept IN cursorDept LOOP
        SELECT COUNT(*), SUM(EMP.SALARIO) INTO v_totalEmpleadosPorDept, v_totalSalarioPorDept
        FROM EMP WHERE registroDept.DEPT_NO = EMP.DEPT_NO;
        DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || registroDept.DNOMBREBRE
        || ' Empleados: ' || v_totalEmpleadosPorDept
        || ' Sumatorio Salarios: ' || v_totalSalarioPorDept);
        -- Recupera datos propios de los empleados por departamento.
        DBMS_OUTPUT.PUT_LINE('EMPLEADOS:');
        FOR registroEmpleados IN cursorEmpleados LOOP
            -- Solo si coincide con el departamento actual del primer bucle.
            IF registroDept.DEPT_NO = registroEmpleados.DEPT_NO THEN
                DBMS_OUTPUT.PUT_LINE('-Apellido: ' || registroEmpleados.APELLIDO
                || '  -Salario: ' || registroEmpleados.SALARIO);
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        -- Una vez acabado el departamento entero, se actualizan variables.
        v_totalEmpleados := v_totalEmpleados + v_totalEmpleadosPorDept;
        /*DEBUG
        DBMS_OUTPUT.PUT_LINE('***DEBUG Salario por Dept: ' || v_totalSalarioPorDept);
        */
        -- Ojo con que no sea valor NULL porque si no, no aparece el sumatorio final.
        -- Y el departamento de PRODUCCION va a generar valores NULL porque no tiene empleados.
        IF v_totalSalarioPorDept IS NOT NULL THEN
        v_totalSalarios := v_totalSalarios + v_totalSalarioPorDept;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('EMPLEADOS EN LA EMPRESA: ' || v_totalEmpleados);
    DBMS_OUTPUT.PUT_LINE('SUMA DE SALARIOS EN LA EMPRESA: ' || v_totalSalarios);
END;
/

EXECUTE UF3PAC3Ej6;

/*
 * Ejercicio 7.
 * Hacer un procedimiento que reciba por parámetro el nombre de un departamento
 * y el porcentaje de subida de salario. El procedimiento incrementará el salario
 * en el porcentaje que le indicamos a los empleados que pertenecen al departamento
 * recibido e informará de cuántos empleados se les ha modificado el salario.
 * El porcentaje se recibirá en tanto por uno (es decir, el 10% sería 0,1).
 */
CREATE OR REPLACE PROCEDURE UF3PAC3Ej7(nDept DEPT.DNOMBREBRE%TYPE, subida NUMBER)
IS
CURSOR cursorEmpleado IS SELECT * FROM EMP;
registroEmpleado EMP%ROWTYPE;
v_codigoDept EMP.DEPT_NO%TYPE;
v_contador NUMBER;
BEGIN
    v_contador := 0;
    SELECT DEPT.DEPT_NO INTO v_codigoDept FROM DEPT WHERE DEPT.DNOMBREBRE = nDept;
    FOR registroEmpleado IN cursorEmpleado LOOP
        IF registroEmpleado.DEPT_NO = v_codigoDept THEN
            -- UPDATE con la subida especificada por parametro.
            UPDATE EMP SET EMP.SALARIO = EMP.SALARIO + (EMP.SALARIO * subida)
            WHERE EMP.EMP_NO = registroEmpleado.EMP_NO;
            -- Actualiza contador.
            v_contador :=  v_contador +1;
        END IF;
    END LOOP;
    -- Imprime total salarios modificados.
    DBMS_OUTPUT.PUT_LINE('Se han modificado ' || v_contador || ' salarios.');
END;
/

BEGIN
  UF3PAC3Ej7('VENTAS',0.25);
END;

/*
 * Ejercicio 8.
 * Crear un procedimiento que reciba el número de empleado y la cantidad que se
 * incrementa al salario del empleado correspondiente. Utilice dos excepciones:
 * una definida por el usuario (salario_null) y otra predeterminada (NO_DATA_FOUND).
 */
CREATE OR REPLACE PROCEDURE UF3PAC3Ej8(nEmp EMP.EMP_NO%TYPE, subida NUMBER)
IS
v_salario EMP.SALARIO%TYPE;
SALARIO_NULL EXCEPTION;
BEGIN
    -- Recupero el salario del trabajador.
    SELECT EMP.SALARIO INTO v_salario FROM EMP WHERE EMP_NO = nEmp;
    -- Si el salario es nulo, salta excepcion predefinida.
    IF v_salario IS NULL THEN
        RAISE SALARIO_NULL;
    END IF;
    -- Se actualiza el salario del trabajador.
    UPDATE EMP SET SALARIO = SALARIO + subida
    WHERE EMP.EMP_NO = nEmp;
EXCEPTION
    WHEN SALARIO_NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error: No hay salario del empleado ' || nEmp);
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No hay datos del empleado ' || nEmp);
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE('==== Subida de 50.000 al empleado 7369 ====');
UF3PAC3Ej8(7369, 50000);
DBMS_OUTPUT.PUT_LINE('==== Subida de 50.000 al empleado 9999 (que no existe) ====');
UF3PAC3Ej8(9999, 50000);
END;

/*
 * Ejercicio 9.
 * Procedimiento que permita subir el sueldo de todos los empleados que ganen
 * menos que el salario medio de su oficio. La subida será del 50% de la
 * diferencia entre el salario del empleado y la media de su oficio. Hay que
 * terminar la transacción y gestionar los posibles errores.
 */
CREATE OR REPLACE PROCEDURE UF3PAC3Ej9
IS
CURSOR cursorEmpleados IS SELECT * FROM EMP;
registroEmpleados EMP%ROWTYPE;
v_salarioMedioProfesion EMP.SALARIO%TYPE;
v_salarioEmpleado EMP.SALARIO%TYPE;

BEGIN
    OPEN cursorEmpleados;
    FETCH cursorEmpleados INTO registroEmpleados;
    WHILE cursorEmpleados%FOUND LOOP
        -- Salario medio de la profesion.
        SELECT AVG(EMP.SALARIO) INTO v_salarioMedioProfesion FROM EMP
        WHERE EMP.OFICIO = registroEmpleados.OFICIO;
        -- Salario del empleado.
        SELECT EMP.SALARIO INTO v_salarioEmpleado FROM EMP
        WHERE EMP.EMP_NO = registroEmpleados.EMP_NO;
        -- Comprobacion.
        IF v_salarioEmpleado < v_salarioMedioProfesion THEN
            -- Imprime datos actuales del empleado con salario por debajo de la media de su profesion.
            DBMS_OUTPUT.PUT_LINE('TRABAJADOR ' || registroEmpleados.EMP_NO
            || ' por debajo de media Categoria ' || registroEmpleados.OFICIO
            || ' que es ' || v_salarioMedioProfesion || '. Salario inicial: ' || v_salarioEmpleado);
            -- Corrige el salario.
            UPDATE EMP SET EMP.SALARIO = SALARIO + ((v_salarioMedioProfesion - v_salarioEmpleado) * 0.5)
            WHERE EMP.EMP_NO = registroEmpleados.EMP_NO;
            -- Recupera de nuevo el salario del trabajador.
            SELECT EMP.SALARIO INTO v_salarioEmpleado FROM EMP
            WHERE EMP.EMP_NO = registroEmpleados.EMP_NO;
            -- Imprime el salario corregido.
            DBMS_OUTPUT.PUT_LINE('Salario actual corregido: ' || v_salarioEmpleado);
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        -- Lee siguiente linea.
        FETCH cursorEmpleados INTO registroEmpleados;
    
    END LOOP;
    CLOSE cursorEmpleados;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('EXCEPCION DETECTADA: ' || SQLERRM);
END;
/

EXECUTE UF3PAC3Ej9;





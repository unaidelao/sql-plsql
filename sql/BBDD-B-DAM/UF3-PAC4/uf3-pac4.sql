/*
 * Asignatura: BASES DE DATOS B.
 * 
 * UF03-PAC04
 *
 * ORACLE DB
 *
 * Realizado por: Unai de la O Pagaegui
 */

-- Antes de nada, se activa el modo serveroutput y mensaje inicial.
SET SERVEROUTPUT ON
EXECUTE DBMS_OUTPUT.PUT_LINE('EJERCICIOS UF3-PAC4');
EXECUTE DBMS_OUTPUT.PUT_LINE('Unai de la O Pagaegui');

/*
 * Ejercicio 1.
 */
-- Crea la tabla AUDITAEMPLE
CREATE TABLE AUDITAEMPLE (
ID_CAMBIO NUMBER(5) NOT NULL,
DESCRIPCION_CAMPO VARCHAR2(100),
FECHA_CAMBIO DATE,
PRIMARY KEY (ID_CAMBIO)
);

-- Trigger TR_AUDITASUELDO
CREATE OR REPLACE TRIGGER TR_AUDITASUELDO
AFTER UPDATE OF SALARIO ON EMP
FOR EACH ROW
BEGIN
  INSERT INTO AUDITAEMPLE VALUES((SELECT COUNT(*) FROM AUDITAEMPLE) + 1,
  'El salario del empleado ' || :OLD.EMP_NO || ' antes era de ' || :OLD.SALARIO ||
  ' y ahora es de ' || :NEW.SALARIO, SYSDATE);
END;
/

-- Se prueba el trigger.
BEGIN
  UPDATE EMP SET SALARIO = 99999 WHERE EMP_NO = 7369;
  UPDATE EMP SET SALARIO = 88888 WHERE EMP_NO = 7499;
END;
/

/*
 * Ejercicio 2.
 */
-- Crea el trigger TR_AUDITAEMPLE
CREATE OR REPLACE TRIGGER TR_AUDITAEMPLE
AFTER INSERT OR UPDATE OF SALARIO ON EMP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO AUDITAEMPLE VALUES((SELECT COUNT(*) FROM AUDITAEMPLE) + 1,
        'Nuevo empleado con código ' || :NEW.EMP_NO, SYSDATE);
    ELSIF UPDATING ('SALARIO') THEN
        INSERT INTO AUDITAEMPLE VALUES((SELECT COUNT(*) FROM AUDITAEMPLE) + 1,
        'El salario del empleado ' || :OLD.EMP_NO || ' antes era de ' || :OLD.SALARIO ||
        ' y ahora es de ' || :NEW.SALARIO, SYSDATE);
    END IF;
END;
/

-- Prueba del segundo trigger.
BEGIN
    INSERT INTO EMP VALUES(7777, 'GILBERTO', 'CIENT.LOCO', 7839, SYSDATE, 77777, 70707, 20);
    UPDATE EMP SET SALARIO = 500 WHERE EMP_NO = 7499;
END;
/


/*
 * Ejercicio 3.
 */
-- Crea el trigger TR_AUDITAEMPLE2
CREATE OR REPLACE TRIGGER TR_AUDITAEMPLE2
BEFORE UPDATE OF SALARIO ON EMP
FOR EACH ROW
WHEN (NEW.SALARIO > OLD.SALARIO * 1.10)
BEGIN
    INSERT INTO AUDITAEMPLE VALUES((SELECT COUNT(*) FROM AUDITAEMPLE) + 1,
    'El salario del empleado ' || :OLD.EMP_NO || ' antes era de ' || :OLD.SALARIO ||
    ' y ahora es de ' || :NEW.SALARIO || ' subida > 10%', SYSDATE);
END;
/

-- Prueba del tercer trigger.
DECLARE
v_sueldoEmpleado EMP.SALARIO%TYPE;
BEGIN
    -- Subida de un 80% al empleado 7499.
    BEGIN
        SELECT EMP.SALARIO INTO v_sueldoEmpleado
        FROM EMP WHERE EMP.EMP_NO = 7499;
        
        UPDATE EMP SET EMP.SALARIO = v_sueldoEmpleado * 1.80
        WHERE EMP.EMP_NO = 7499;
    END;
    -- Bajada de un 5% al empleado 7777.
    BEGIN
        SELECT EMP.SALARIO INTO v_sueldoEmpleado
        FROM EMP WHERE EMP.EMP_NO = 7777;
        
        UPDATE EMP SET EMP.SALARIO = v_sueldoEmpleado * 0.95
        WHERE EMP.EMP_NO = 7777;
    END;
END;
/


/*
 * Ejercicio 4.
 */
CREATE OR REPLACE TRIGGER TR_VERIFICAUNIDADES
BEFORE INSERT OR UPDATE OF CANTIDAD ON DETALLE
FOR EACH ROW
BEGIN
    IF :NEW.CANTIDAD <= 999 THEN
        IF UPDATING ('CANTIDAD') THEN
            :NEW.IMPORTE := :OLD.PRECIO_VENDA * :NEW.CANTIDAD;
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20000, 'Error: CANTIDAD no puede ser > 999');
    END IF;
END;
/

-- Prueba 1 del cuarto trigger
BEGIN
    UPDATE DETALLE SET CANTIDAD = 2 WHERE COM_NUM = 610;
END;
/

-- Prueba 2 del cuarto trigger
BEGIN
    UPDATE DETALLE SET CANTIDAD = 2500 WHERE COM_NUM = 610;
END;
/

-- Prueba 3 del cuarto trigger
BEGIN
    INSERT INTO DETALLE VALUES(610, 5, 200380, 55, 10, 550); 
END;
/

-- Prueba 4 del cuarto trigger
BEGIN
    INSERT INTO DETALLE VALUES(610, 15, 200380, 55, 1500, 82500); 
END;
/

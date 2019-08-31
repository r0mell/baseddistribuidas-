CREATE MATERIALIZED VIEW LOG ON CLIENTE_REP
BUILD INMMEDIATE 
USING INDEX TABLESPACE USERS
REFRESH FAST
START WITH TO_DATE('25-jul-2008 19:00:00'.'dd-Mon-yyy HH24:MI:SS')
NEXT SYSDATE + 1/1440
AS SELECT * FROM CLIENTE@db_bddproyecto;


CREATE MATERIALIZED VIEW LOG ON CLIENTE;
CREATE MATERIALIZED VIEW LOG ON EMPLEADO;
CREATE MATERIALIZED VIEW LOG ON MEDICAMENTO;

CREATE OR REPLACE TRIGGER audit_cliente
AFTER DELETE OR INSERT OR UPDATE ON cliente
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='cliente';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.CI_CLI||'|'||:OLD.NOM_CLI||'|'||:OLD.APE_CLI||'|'||:OLD.TEL_CLI||'|'||:OLD.DIR_CLI;
 v_nuevo:= :NEW.CI_CLI||'|'||:NEW.NOM_CLI||'|'||:NEW.APE_CLI||'|'||:NEW.TEL_CLI||'|'||:NEW.DIR_CLI;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_empleado
AFTER DELETE OR INSERT OR UPDATE ON empleado
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='empleado';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.CI||'|'||:OLD.COD_FAR||'|'||:OLD.COD_ROL||'|'||:OLD.NOM_EMP||'|'||:OLD.APE_EMP||'|'||:OLD.TEL_EMP||'|'||:OLD.SUELDO||'|'||:OLD.USR_EMP||'|'||:OLD.CLAVE_EMP;
 v_nuevo:= :NEW.CI||'|'||:NEW.COD_FAR||'|'||:NEW.COD_ROL||'|'||:NEW.NOM_EMP||'|'||:NEW.APE_EMP||'|'||:NEW.TEL_EMP||'|'||:NEW.SUELDO||'|'||:NEW.USR_EMP||'|'||:NEW.CLAVE_EMP;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_factura
AFTER DELETE OR INSERT OR UPDATE ON factura
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='factura';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.COD_MED||'|'||:OLD.CI_CLI||'|'||:OLD.COD_FACTURA||'|'||:OLD.ESTADO||'|'||:OLD.CANTIDAD_FAC||'|'||:OLD.FECHA||'|'||:OLD.PRECIO_FAC||'|'||:OLD.CIUDAD_FAC;
 v_nuevo:= :NEW.COD_MED||'|'||:NEW.CI_CLI||'|'||:NEW.COD_FACTURA||'|'||:NEW.ESTADO||'|'||:NEW.CANTIDAD_FAC||'|'||:NEW.FECHA||'|'||:NEW.PRECIO_FAC||'|'||:NEW.CIUDAD_FAC;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_farmacia
AFTER DELETE OR INSERT OR UPDATE ON farmacia
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='farmacia';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.COD_FAR||'|'||:OLD.NOM_FAR||'|'||:OLD.DIR_FAR||'|'||:OLD.TEL_FAR||'|'||:OLD.CIUDAD_FAR;
 v_nuevo:= :NEW.COD_FAR||'|'||:NEW.NOM_FAR||'|'||:NEW.DIR_FAR||'|'||:NEW.TEL_FAR||'|'||:NEW.CIUDAD_FAR;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_laboratorio
AFTER DELETE OR INSERT OR UPDATE ON laboratorio
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='laboratorio';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.COD_PROV||'|'||:OLD.NOM_PROV||'|'||:OLD.DIR_PROV||'|'||:OLD.TEL_PROV||'|'||:OLD.CIUDAD_PROV;
 v_nuevo:= :NEW.COD_PROV||'|'||:NEW.NOM_PROV||'|'||:NEW.DIR_PROV||'|'||:NEW.TEL_PROV||'|'||:NEW.CIUDAD_PROV;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_medicamento
AFTER DELETE OR INSERT OR UPDATE ON medicamento
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='medicamento';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.COD_MED||'|'||:OLD.COD_FAR||'|'||:OLD.COD_PROV||'|'||:OLD.NOM_MED||'|'||:OLD.PRECIO||'|'||:OLD.CANTIDAD;
 v_nuevo:= :NEW.COD_MED||'|'||:NEW.COD_FAR||'|'||:NEW.COD_PROV||'|'||:NEW.NOM_MED||'|'||:NEW.PRECIO||'|'||:NEW.CANTIDAD;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

CREATE OR REPLACE TRIGGER audit_rol
AFTER DELETE OR INSERT OR UPDATE ON rol
FOR EACH ROW
declare 
 v_op       varchar2(1);
 v_tabla varchar2(20);
 v_anterior varchar2(200);
 v_nuevo varchar2(200);
BEGIN
v_tabla :='rol';
if inserting then
 v_op := 'I';
 elsif updating then
 v_op := 'U';
 elsif deleting then
  v_op := 'D';
end if;
 v_anterior:=:OLD.COD_ROL||'|'||:OLD.NOM_ROL;
 v_nuevo:= :NEW.COD_ROL||'|'||:NEW.NOM_ROL;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_table,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

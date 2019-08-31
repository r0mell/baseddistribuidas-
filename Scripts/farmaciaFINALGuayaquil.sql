/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     1/8/2018 17:29:01                            */
/*==============================================================*/


alter table EMPLEADO
   drop constraint FK_EMPLEADO_RELATIONS_ROL;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_RELATIONS_FARMACIA;

alter table FACTURA
   drop constraint FK_FACTURA_PERTENECE_MEDICAME;

alter table FACTURA
   drop constraint FK_FACTURA_RELATIONS_CLIENTE;

alter table MEDICAMENTO
   drop constraint FK_MEDICAME_RELATIONS_FARMACIA;

alter table MEDICAMENTO
   drop constraint FK_MEDICAME_RELATIONS_LABORATO;

drop table CLIENTE cascade constraints;

drop index RELATIONSHIP_4_FK;

drop index RELATIONSHIP_3_FK;

drop table EMPLEADO cascade constraints;

drop index RELATIONSHIP_6_FK;

drop index PERTENECE_A_FK;

drop table FACTURA cascade constraints;

drop table FARMACIA cascade constraints;

drop table LABORATORIO cascade constraints;

drop index RELATIONSHIP_2_FK;

drop index RELATIONSHIP_1_FK;

drop table MEDICAMENTO cascade constraints;

drop table ROL cascade constraints;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   CI_CLI               VARCHAR2(10)         not null,
   NOM_CLI              VARCHAR2(20)         not null,
   APE_CLI              VARCHAR2(20)         not null,
   TEL_CLI              VARCHAR2(10)         not null,
   DIR_CLI              VARCHAR2(20)         not null,
   CIUDAD_CLI           VARCHAR2(10)         not null,
   constraint PK_CLIENTE primary key (CI_CLI)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO 
(
   CI                   VARCHAR2(10)         not null,
   COD_FAR              VARCHAR2(5)          not null,
   COD_ROL              VARCHAR2(5)          not null,
   NOM_EMP              VARCHAR2(20)         not null,
   APE_EMP              VARCHAR2(20)         not null,
   TEL_EMP              VARCHAR2(10)         not null,
   SUELDO               NUMBER(9,2)          not null,
   USR_EMP              VARCHAR2(15)         not null,
   CLAVE_EMP            VARCHAR2(15)         not null,
   CIUDAD_EMP           VARCHAR2(10)         not null,
   constraint PK_EMPLEADO primary key (CI)
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on EMPLEADO (
   COD_ROL ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on EMPLEADO (
   COD_FAR ASC
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA 
(
   COD_MED              VARCHAR2(5)          not null,
   CI_CLI               VARCHAR2(10)         not null,
   COD_FACTURA          NUMBER(9)            not null,
   ESTADO               VARCHAR2(1)          not null,
   CANTIDAD_FAC         NUMBER(9)            not null,
   FECHA                DATE                 not null,
   PRECIO_FAC           NUMBER(9,2)          not null,
   CIUDAD_FAC           VARCHAR2(10)         not null,
   constraint PK_FACTURA primary key (COD_MED, CI_CLI, COD_FACTURA)
);

/*==============================================================*/
/* Index: PERTENECE_A_FK                                        */
/*==============================================================*/
create index PERTENECE_A_FK on FACTURA (
   COD_MED ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on FACTURA (
   CI_CLI ASC
);

/*==============================================================*/
/* Table: FARMACIA                                              */
/*==============================================================*/
create table FARMACIA 
(
   COD_FAR              VARCHAR2(5)          not null,
   NOM_FAR              VARCHAR2(20)         not null,
   DIR_FAR              VARCHAR2(40),
   TEL_FAR              VARCHAR2(11),
   constraint PK_FARMACIA primary key (COD_FAR)
);

/*==============================================================*/
/* Table: LABORATORIO                                           */
/*==============================================================*/
create table LABORATORIO 
(
   COD_PROV             VARCHAR2(13)         not null,
   NOM_PROV             VARCHAR2(20)         not null,
   DIR_PROV             VARCHAR2(20)         not null,
   TEL_PROV             VARCHAR2(10)         not null,
   constraint PK_LABORATORIO primary key (COD_PROV)
);

/*==============================================================*/
/* Table: MEDICAMENTO                                           */
/*==============================================================*/
create table MEDICAMENTO 
(
   COD_MED              VARCHAR2(5)          not null,
   COD_FAR              VARCHAR2(5)          not null,
   COD_PROV             VARCHAR2(13)         not null,
   NOM_MED              VARCHAR2(20)         not null,
   PRECIO               NUMBER(9,2)          not null,
   CANTIDAD             NUMBER(9)            not null,
   constraint PK_MEDICAMENTO primary key (COD_MED)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on MEDICAMENTO (
   COD_FAR ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on MEDICAMENTO (
   COD_PROV ASC
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL 
(
   COD_ROL              VARCHAR2(5)          not null,
   NOM_ROL              VARCHAR2(20)         not null,
   constraint PK_ROL primary key (COD_ROL)
);

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_ROL foreign key (COD_ROL)
      references ROL (COD_ROL);

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_FARMACIA foreign key (COD_FAR)
      references FARMACIA (COD_FAR);

alter table FACTURA
   add constraint FK_FACTURA_PERTENECE_MEDICAME foreign key (COD_MED)
      references MEDICAMENTO (COD_MED);

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_CLIENTE foreign key (CI_CLI)
      references CLIENTE (CI_CLI);

alter table MEDICAMENTO
   add constraint FK_MEDICAME_RELATIONS_FARMACIA foreign key (COD_FAR)
      references FARMACIA (COD_FAR);

alter table MEDICAMENTO
   add constraint FK_MEDICAME_RELATIONS_LABORATO foreign key (COD_PROV)
      references LABORATORIO (COD_PROV);

alter table CLIENTE 
  add constraint CK_CIUDAD_CIENTE CHECK (CIUDAD_CLI IN 'GUAYAQUIL');

alter table FACTURA
  add constraint CK_CIUDAD_PROVEEDOR CHECK (CIUDAD_FAC IN 'GUAYAQUIL');

alter table EMPLEADO
  add constraint CK_CIUDAD_EMPLEADO CHECK (CIUDAD_EMP IN 'GUAYAQUIL');

DROP MATERIALIZED VIEW ROL_REP;
create materialized view ROL_REP
build immediate
using index tablespace users 
refresh fast
start with to_date('2-ago-2018 08:55:00','dd-Mon-yyyy HH24:MI:SS')
next sysdate + 1/1440
as SELECT * FROM ROL@db_bddproyecto;

DROP MATERIALIZED VIEW LABORATORIO_REP;
create materialized view LABORATORIO_REP
build immediate
using index tablespace users 
refresh fast
start with to_date('2-ago-2018 08:55:00','dd-Mon-yyyy HH24:MI:SS')
next sysdate + 1/1440
as SELECT * FROM LABORATORIO@db_bddproyecto;

DROP MATERIALIZED VIEW MEDICAMENTO_REP;
create materialized view MEDICAMENTO_REP
build immediate
using index tablespace users 
refresh fast
start with to_date('2-ago-2018 08:55:00','dd-Mon-yyyy HH24:MI:SS')
next sysdate + 1/1440
as SELECT * FROM MEDICAMENTO@db_bddproyecto;

DROP MATERIALIZED VIEW FARMACIA_REP;
create materialized view FARMACIA_REP
build immediate
using index tablespace users 
refresh fast
start with to_date('2-ago-2018 08:55:00','dd-Mon-yyyy HH24:MI:SS')
next sysdate + 1/1440
as SELECT * FROM FARMACIA@db_bddproyecto;

DROP TABLE AUDITORIA;


CREATE TABLE AUDITORIA
(
	user_name varchar2(20),
 
	fecha date,
 
	tipo_operacion varchar2(1),
 
	nombre_tabla varchar2(30),
 
	anterior varchar2(500),
 
	nuevo varchar2(500));

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
 v_anterior:=:OLD.CI_CLI||'|'||:OLD.NOM_CLI||'|'||:OLD.APE_CLI||'|'||:OLD.TEL_CLI||'|'||:OLD.DIR_CLI||'|'||:OLD.CIUDAD_CLI;
 v_nuevo:= :NEW.CI_CLI||'|'||:NEW.NOM_CLI||'|'||:NEW.APE_CLI||'|'||:NEW.TEL_CLI||'|'||:NEW.DIR_CLI||'|'||:NEW.CIUDAD_CLI;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo);
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
 v_anterior:=:OLD.CI||'|'||:OLD.COD_FAR||'|'||:OLD.COD_ROL||'|'||:OLD.NOM_EMP||'|'||:OLD.APE_EMP||'|'||:OLD.TEL_EMP||'|'||:OLD.SUELDO||'|'||:OLD.USR_EMP||'|'||:OLD.CLAVE_EMP||'|'||:OLD.CIUDAD_EMP;
 v_nuevo:= :NEW.CI||'|'||:NEW.COD_FAR||'|'||:NEW.COD_ROL||'|'||:NEW.NOM_EMP||'|'||:NEW.APE_EMP||'|'||:NEW.TEL_EMP||'|'||:NEW.SUELDO||'|'||:NEW.USR_EMP||'|'||:NEW.CLAVE_EMP||'|'||:NEW.CIUDAD_EMP;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
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
 v_nuevo:=:NEW.COD_MED||'|'||:NEW.CI_CLI||'|'||:NEW.COD_FACTURA||'|'||:NEW.ESTADO||'|'||:NEW.CANTIDAD_FAC||'|'||:NEW.FECHA||'|'||:NEW.PRECIO_FAC||'|'||:NEW.CIUDAD_FAC;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo);
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
 v_anterior:=:OLD.COD_FAR||'|'||:OLD.NOM_FAR||'|'||:OLD.DIR_FAR||'|'||:OLD.TEL_FAR;
 v_nuevo:= :NEW.COD_FAR||'|'||:NEW.NOM_FAR||'|'||:NEW.DIR_FAR||'|'||:NEW.TEL_FAR;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
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
 v_anterior:=:OLD.COD_PROV||'|'||:OLD.NOM_PROV||'|'||:OLD.DIR_PROV||'|'||:OLD.TEL_PROV;
 v_nuevo:= :NEW.COD_PROV||'|'||:NEW.NOM_PROV||'|'||:NEW.DIR_PROV||'|'||:NEW.TEL_PROV;
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
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
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
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
  INSERT INTO auditoria(user_name, fecha, tipo_operacion, nombre_tabla,
    anterior,nuevo)
     VALUES (USER, SYSDATE,v_op,v_tabla, v_anterior,v_nuevo
     );
END;
/

INSERT INTO FARMACIA VALUES ('FR-02','EL CURITA', 'Carcelen',3123123);
INSERT INTO ROL VALUES ('ADM','Administrador');
INSERT INTO ROL VALUES ('CAJ','Cajero');
INSERT INTO EMPLEADO VALUES ('12345','FR-02','ADM','Jessica','Altamirano',2213231,400.00,'admin','admin', 'GUAYAQUIL');
INSERT INTO LABORATORIO VALUES ('PROV-01', 'Bayern','Calderon', '4234211412');
INSERT INTO MEDICAMENTO VALUES('MD-01','FR-02','PROV-01','Paracetamol',0.4,40);
INSERT INTO MEDICAMENTO VALUES('MD-02','FR-02','PROV-01','Penisilina',0.9,50);

/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     22/6/2018 14:58:24                           */
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
   constraint PK_CLIENTE primary key (CI_CLI)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO 
(
   CI                   VARCHAR2(10)         not null,
   CLAVE_EMP            VARCHAR2(15)         not null,
   USR_EMP              VARCHAR2(15)         not null,
   COD_FAR              VARCHAR2(5)          not null,
   COD_ROL              VARCHAR2(5)          not null,
   NOM_EMP              VARCHAR2(20)         not null,
   APE_EMP              VARCHAR2(20)         not null,
   TEL_EMP              VARCHAR2(10)         not null,
   SUELDO               NUMBER(7,2)          not null,
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
   COD_FACTURA          INTEGER		     not null,
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
   NOM_FAR              VARCHAR2(20),
   DIR_FAR              VARCHAR2(40),
   TEL_FAR              VARCHAR2(11),
   CIUDAD               VARCHAR2(10),
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
   PRECIO               NUMBER(5,2)          not null,
   CANTIDAD             INTEGER,
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

alter table FARMACIA
   add constraint CHK_FARMACIA_CIUDAD CHECK (ciudad IN 'GUAYAQUIL');


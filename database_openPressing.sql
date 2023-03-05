/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     05/03/2023 15:46:23                          */
/*==============================================================*/


drop table CLIENT;

drop table COMMANDE;

drop table EMPLOYEE;

drop table LIVREUR;

drop table PIECE_LINGE;

drop table PRESSING;

drop table RESPONSABLE_PRESSING;

drop table TARICATION;

drop table TYPE_KILO;

drop table TYPE_LINGE;

/*==============================================================*/
/* Table: CLIENT                                                */
/*==============================================================*/
create table CLIENT (
   ID_CLIENT            INT4                 not null,
   NOM_CLIENT           VARCHAR(20)          not null,
   PRENOM_CLIENT        VARCHAR(20)          null,
   DATE_DE_NAISSANCE    DATE                 not null,
   NUMERO_TELEPHONE_CLIENT VARCHAR(9)           not null,
   ADRESSE_EMAIL_CLIENT VARCHAR(128)         not null,
   MOT_DE_PASSE_CLENT   VARCHAR(20)          not null,
   constraint PK_CLIENT primary key (ID_CLIENT)
);

/*==============================================================*/
/* Table: COMMANDE                                              */
/*==============================================================*/
create table COMMANDE (
   ID_LOT               INT4                 not null,
   ID_CLIENT            INT4                 not null,
   ID_LIVREUR           INT4                 not null,
   ID_PRESSING          INT4                 not null,
   NOMBRE_LINGE         INT4                 not null,
   DETAIL               TEXT                 null,
   LIEU_DEPOT           VARCHAR(128)         not null,
   LIEU_RECUPERATION    VARCHAR(128)         not null,
   DATE_RECUPERATION    DATE                 null,
   DATE_COMMANDE_PRETE  DATE                 null,
   DATE_LIVRAISON_EFFECTUER DATE                 null,
   COMMANDE_VALIDEE_    BOOL                 not null,
   constraint PK_COMMANDE primary key (ID_LOT)
);

/*==============================================================*/
/* Table: EMPLOYEE                                              */
/*==============================================================*/
create table EMPLOYEE (
   ID_EMPLOYEE          INT4                 not null,
   ID_PRESSING          INT4                 not null,
   NOM_EMPLOYEE         VARCHAR(20)          not null,
   PRENOM_EMPLOYEE      VARCHAR(20)          null,
   DATE_NAISSANCE_EMPLOYEE DATE                 null,
   NUMERO_TELEPHONE_EMPLOYEE VARCHAR(9)           not null,
   ADRESSE_EMAIL_EMPLOYEE VARCHAR(128)         not null,
   MOT_DE_PASSE_CLENT   VARCHAR(20)          null,
   constraint PK_EMPLOYEE primary key (ID_EMPLOYEE)
);

/*==============================================================*/
/* Table: LIVREUR                                               */
/*==============================================================*/
create table LIVREUR (
   ID_LIVREUR           INT4                 not null,
   NOM_LIVREUR          VARCHAR(20)          not null,
   PRENOM_LIVREUR       VARCHAR(20)          null,
   SOCIETE              VARCHAR(50)          not null,
   NUMERO_TELEPHONE_LIVREUR VARCHAR(9)           null,
   constraint PK_LIVREUR primary key (ID_LIVREUR)
);

/*==============================================================*/
/* Table: PIECE_LINGE                                           */
/*==============================================================*/
create table PIECE_LINGE (
   ID_PIECE             INT4                 not null,
   ID_LOT               INT4                 not null,
   ID_CLIENT            INT4                 not null,
   COULEURE             VARCHAR(20)          not null,
   DESCRIPTION          TEXT                 not null,
   TYPE                 VARCHAR(20)          not null,
   constraint PK_PIECE_LINGE primary key (ID_PIECE)
);

/*==============================================================*/
/* Table: PRESSING                                              */
/*==============================================================*/
create table PRESSING (
   ID_PRESSING          INT4                 not null,
   ID_RESPONSABLE       INT4                 not null,
   ENSEIGNE             VARCHAR(50)          not null,
   LOCALISATION         VARCHAR(128)         not null,
   CONTACT              INT4                 not null,
   LOGO                 CHAR(254)            not null,
   SLOGAN               VARCHAR(70)          null,
   constraint PK_PRESSING primary key (ID_PRESSING)
);

/*==============================================================*/
/* Table: RESPONSABLE_PRESSING                                  */
/*==============================================================*/
create table RESPONSABLE_PRESSING (
   ID_RESPONSABLE       INT4                 not null,
   NOM_RESPONSABLE      VARCHAR(20)          not null,
   PRENOM_RESPONSABLE   VARCHAR(20)          null,
   DATE_NAISSANCE_RESPONSSABLE DATE                 not null,
   NUMERO_TELEPHONE_RESPONSABLE VARCHAR(9)           not null,
   ADRESSE_EMAIL_RESPONSABLE VARCHAR(128)         not null,
   MOT_DE_PASSE_RESPONSABLE VARCHAR(20)          not null,
   constraint PK_RESPONSABLE_PRESSING primary key (ID_RESPONSABLE)
);

/*==============================================================*/
/* Table: TARICATION                                            */
/*==============================================================*/
create table TARICATION (
   ID_TARIF             INT4                 not null,
   ID_PRESSING          INT4                 not null,
   ID_KILO              INT4                 not null,
   ID                   INT4                 not null,
   TYPE                 VARCHAR(20)          not null,
   REMISE_              BOOL                 not null,
   POURCENTAGE_REMISE   FLOAT8               null,
   constraint PK_TARICATION primary key (ID_TARIF)
);

/*==============================================================*/
/* Table: TYPE_KILO                                             */
/*==============================================================*/
create table TYPE_KILO (
   ID_KILO              INT4                 not null,
   PRIX_PAR_KILO        INT4                 not null,
   constraint PK_TYPE_KILO primary key (ID_KILO)
);

/*==============================================================*/
/* Table: TYPE_LINGE                                            */
/*==============================================================*/
create table TYPE_LINGE (
   ID                   INT4                 not null,
   NOM                  VARCHAR(20)          not null,
   PRIX                 INT4                 not null,
   constraint PK_TYPE_LINGE primary key (ID)
);

alter table COMMANDE
   add constraint FK_COMMANDE_CREER_CLIENT foreign key (ID_CLIENT)
      references CLIENT (ID_CLIENT)
      on delete restrict on update restrict;

alter table COMMANDE
   add constraint FK_COMMANDE_LIVRER_LIVREUR foreign key (ID_LIVREUR)
      references LIVREUR (ID_LIVREUR)
      on delete restrict on update restrict;

alter table COMMANDE
   add constraint FK_COMMANDE_TRAITER_PRESSING foreign key (ID_PRESSING)
      references PRESSING (ID_PRESSING)
      on delete restrict on update restrict;

alter table EMPLOYEE
   add constraint FK_EMPLOYEE_TRAVALLER_PRESSING foreign key (ID_PRESSING)
      references PRESSING (ID_PRESSING)
      on delete restrict on update restrict;

alter table PIECE_LINGE
   add constraint FK_PIECE_LI_AJOUTER_CLIENT foreign key (ID_CLIENT)
      references CLIENT (ID_CLIENT)
      on delete restrict on update restrict;

alter table PIECE_LINGE
   add constraint FK_PIECE_LI_FAIRE_PAR_COMMANDE foreign key (ID_LOT)
      references COMMANDE (ID_LOT)
      on delete restrict on update restrict;

alter table PRESSING
   add constraint FK_PRESSING_POSSEDER_RESPONSA foreign key (ID_RESPONSABLE)
      references RESPONSABLE_PRESSING (ID_RESPONSABLE)
      on delete restrict on update restrict;

alter table TARICATION
   add constraint FK_TARICATI_DEFINIR_TYPE_LIN foreign key (ID)
      references TYPE_LINGE (ID)
      on delete restrict on update restrict;

alter table TARICATION
   add constraint FK_TARICATI_DEFINIR_K_TYPE_KIL foreign key (ID_KILO)
      references TYPE_KILO (ID_KILO)
      on delete restrict on update restrict;

alter table TARICATION
   add constraint FK_TARICATI_FIXER_PRESSING foreign key (ID_PRESSING)
      references PRESSING (ID_PRESSING)
      on delete restrict on update restrict;


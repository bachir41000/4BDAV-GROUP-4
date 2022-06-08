# Create schema

CREATE USER bacher IDENTIFIED BY oracle;
GRANT CREATE TABLE TO bacher;
GRANT CREATE SESSION TO bacher;

# -----------------------------------------------------------------------------------------------------------------

# Create table 

CREATE TABLE CLI(
NumCli INT PRIMARY KEY NOT NULL,
NomCli VARCHAR(255),
Pays   VARCHAR(255),
Tel    VARCHAR(255),
Ville  VARCHAR(255),
Dept   VARCHAR(255),
Nat    VARCHAR(255)
);

CREATE TABLE COM
(
  NumCom      INT PRIMARY KEY NOT NULL,
  NumCli      INT,
  FraisPort   FLOAT(4),
  AnCom       VARCHAR(255),
  Payment     FLOAT(4)
);

CREATE TABLE DET
(
  NumPro INT,
  NumCom INT,
  Qte    INT,
  Remise FLOAT(4)
);

CREATE TABLE PRO
(
  NumPro    INT PRIMARY KEY NOT NULL, 
  NumFou    INT,
  NomPro    VARCHAR(255),
  TypePro   VARCHAR(255),
  PrixUnit  FLOAT(4)
);

CREATE TABLE FOU
(
  NumFou INT PRIMARY KEY NOT NULL, 
  NomFou VARCHAR(255),
  Pays   VARCHAR(255),
  Tel    VARCHAR(255)
);

# -----------------------------------------------------------------------------------------------------------------

# Order

# Il y a un ordre à respecter suivant les tables et les clés étrangères que l'on souhaite ajouter car il peut avoir des erreurs si on ajoute une
# clé étrangères alors que la table n'est pas encore créée. La meilleure pratique est de créer toutes les tables puis d'ajouter les clés étrangères pour éviter des erreurs.

# -----------------------------------------------------------------------------------------------------------------

# Add Constraint

ALTER TABLE COM
ADD CONSTRAINT FK_NumCli
FOREIGN KEY (NumCli) 
REFERENCES CLI(NumCli);

ALTER TABLE DET
ADD CONSTRAINT FK_NumCom
FOREIGN KEY (NumCom) REFERENCES COM(NumCom);

ALTER TABLE DET
ADD CONSTRAINT FK_NumPro
FOREIGN KEY (NumPro) REFERENCES PRO(NumPro);

ALTER TABLE PRO
ADD CONSTRAINT FK_NumFou
FOREIGN KEY (NumFou) REFERENCES FOU(NumFou);

# -----------------------------------------------------------------------------------------------------------------

# DescribeProperties

DESCRIBE CLI;
DESCRIBE COM;
DESCRIBE DET;
DESCRIBE PRO;
DESCRIBE FOU;

# -----------------------------------------------------------------------------------------------------------------

# Add tablespace 

GRANT UNLIMITED TABLESPACE TO bacher;

# -----------------------------------------------------------------------------------------------------------------

#  Add values on tables

INSERT INTO CLI VALUES(1,'test1','FR','06-01-02-03-04','RENNES','Iles-et-Vilaine','FR');
INSERT INTO CLI VALUES(2,'test2','FR','06-05-06-07-08','RENNES','Finistere','FR');

INSERT INTO COM VALUES(1,1,'10','12-05-2022','Cheque');
INSERT INTO COM VALUES(2,2,'25','15-05-2020','CB');

INSERT INTO DET VALUES(1,1,1,5);
INSERT INTO DET VALUES(2,2,1,5);

INSERT INTO PRO VALUES(1,1,'PONDU','ADS556','500,00€');
INSERT INTO PRO VALUES(2,2,'MICHEL','MLTP69','69,00€');

INSERT INTO FOU VALUES(1,'CARREFOUR','FR','06-00-01-10-10');
INSERT INTO FOU VALUES(2,'LECLERC','FR','06-10-13-15-10');

# -----------------------------------------------------------------------------------------------------------------

# Truncate table

# Etant donné que nous avons des clés étrangères dans certaines tables, nous devons dans un premier temps supprimer ces contraintes puis vider la table

ALTER TABLE CLI
DROP CONSTRAINT FK_NumCli;
TRUNCATE TABLE CLI;

ALTER TABLE DET
DROP CONSTRAINT FK_NumCom;

ALTER TABLE DET
DROP CONSTRAINT FK_NumPro;
TRUNCATE TABLE DET;

ALTER TABLE PRO
DROP CONSTRAINT FK_NumFou;
TRUNCATE TABLE PRO;

# -----------------------------------------------------------------------------------------------------------------
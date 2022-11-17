------------------------------------------------------
-- AUTOR       : Manoli Mena González
-- DESCRIPCIÓN : Scripts para el taller práctico de JDBC
------------------------------------------------------

-- Eliminación de la base de datos.
DROP DATABASE EDUCATION;

-- Creación de la base de datos.
CREATE DATABASE EDUCATION;

-- Uso de la base de datos.
USE EDUCATION;

-- Creación de tabla para formador.
CREATE TABLE TRAINER (

	cod_trainer INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(15),
	surnames VARCHAR(30),
	dni VARCHAR(9),
	sex CHAR(1),
	address VARCHAR(50),
	city VARCHAR(15),
	post_code INT(5),
	telephone_number INT(9),
	
	CONSTRAINT trainer_pk PRIMARY KEY (cod_trainer),
	CONSTRAINT sex_trainer_chk CHECK (sex IN ('H','M')),
	CONSTRAINT dni_trainer_uq UNIQUE (DNI)
 );

-- Creación de tabla para empresa.
CREATE TABLE COMPANY (

	cod_company INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(15),
	post_code INT(5),
	cod_trainer INT,
	
	CONSTRAINT company_pk PRIMARY KEY (cod_company),
	CONSTRAINT cod_trainer_fk FOREIGN KEY (cod_trainer) REFERENCES TRAINER(cod_trainer) on update cascade on delete cascade
 );


--Inserciones para la tabla Formador (Trainer)
INSERT INTO Trainer (name,surnames,dni,sex,address,city,post_code,telephone_number)
VALUES ('Javier', 'Diaz Fernandez', '54678654F', 'H', 'C. Aguilas C-1 5 P-2', 'Sevilla', 41004, 423546186);
INSERT INTO Trainer (name,surnames,dni,sex,address,city,post_code,telephone_number)
VALUES ('Sara','Lopez Garcia','54676945S','M', 'C.Pirineos F-7 3 P-3', 'Sevilla', 41005, 453256764);
INSERT INTO Trainer (name,surnames,dni,sex,address,city,post_code,telephone_number)
VALUES ('Miguel', 'Reyes Ortiz', '45327694F', 'H', 'C. Rosalia G-2', 'Malaga', 29010, 654532836);
INSERT INTO Trainer (name,surnames,dni,sex,address,city,post_code,telephone_number)
VALUES ('Luis', 'Rivera Martinez', '37465498Y','H', 'C.Rafaela R-3 6 P-3', 'Malaga', 29009, 546768523);
INSERT INTO Trainer (name,surnames,dni,sex,address,city,post_code,telephone_number)
VALUES ('Paula', 'Perez Barroso', '34768793R', 'M', 'C. Asturias E-3 2 P-1', 'Sevilla', 41010, 455672129);

--Inserciones para la tabla Empresa (Company)
INSERT INTO Company (name,address,city,post_code,cod_trainer)
VALUES ('NTT DATA', 'C. Americo Vespucio, 5 - 2C', 'Sevilla', 41092, 1);
INSERT INTO Company (name,address,city,post_code,cod_trainer)
VALUES ('Ricoh', 'C. Esclusa 11', 'Sevilla', 41011, 2);
INSERT INTO Company (name,address,city,post_code,cod_trainer)
VALUES ('NTT DATA', 'C. Larios', 'Malaga', 29005, 3);
INSERT INTO Company (name,address,city,post_code,cod_trainer)
VALUES ('Accenture', 'C. Severo Ochoa 6', 'Malaga',29590, 4);
INSERT INTO Company (name,address,city,post_code,cod_trainer)
VALUES ('Tier1', 'C. Boabdil Vega 7', 'Sevilla', 41900, 5);
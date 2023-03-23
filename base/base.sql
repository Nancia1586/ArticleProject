CREATE DATABASE achatvente;
\c achatvente;

DROP TABLE IF EXISTS Departement ;
DROP TABLE IF EXISTS ChefDept;
DROP TABLE IF EXISTS RespAppro;
DROP TABLE IF EXISTS Demande;
DROP TABLE IF EXISTS SousDemande;
DROP TABLE IF EXISTS DemandeProforma;
DROP TABLE IF EXISTS Fournisseur ;
DROP TABLE IF EXISTS Proforma;
DROP TABLE IF EXISTS ProformaDemande;
DROP TABLE IF EXISTS SousProforma;
DROP TABLE IF EXISTS BonDeCommande;
DROP TABLE IF EXISTS SousBonDeReception;
DROP TABLE IF EXISTS BonDeReception;
DROP TABLE IF EXISTS DemandeSatisfait;


CREATE TABLE Departement  (
idDept SERIAL PRIMARY KEY NOT NULL,
NomDept VARCHAR(20) NOT NULL UNIQUE);

CREATE TABLE ChefDept (
idChef SERIAL PRIMARY KEY NOT NULL,
idDept SERIAL NOT NULL,
Nom VARCHAR(20) NOT NULL,
Login VARCHAR(20) NOT NULL UNIQUE,
Mdp VARCHAR(30) NOT NULL,
FOREIGN KEY(idDept) REFERENCES Departement (idDept));



CREATE TABLE Demande (
idDemande SERIAL PRIMARY KEY NOT NULL,
idDept SERIAL NOT NULL,
DateDemande DATE NOT NULL,
Etat INTEGER NOT NULL DEFAULT 0,
FOREIGN KEY(idDept) REFERENCES Departement (idDept));

CREATE TABLE SousDemande (
idSousDemande SERIAL PRIMARY KEY NOT NULL,
idDemande SERIAL NOT NULL UNIQUE,
quantite INTEGER NOT NULL,
qualite VARCHAR(30) NOT NULL,
Designation VARCHAR(30) NOT NULL,
Rubrique  VARCHAR(30) NOT NULL,
DelaiLivraison DATE NOT NULL,
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));



CREATE TABLE BonDeCommande (
idBC SERIAL PRIMARY KEY NOT NULL,
idProforma  SERIAL NOT NULL,
DateBC DATE NOT NULL,
Signature VARCHAR(60) NOT NULL,
FOREIGN KEY(idProforma ) REFERENCES Proforma(idProforma));

CREATE TABLE SousBonDeReception (
idSousBR SERIAL PRIMARY KEY NOT NULL,
idBR SERIAL NOT NULL,
Designation  VARCHAR(30) NOT NULL,
Rubrique  VARCHAR(30) NOT NULL,
Quantité  INTEGER NOT NULL,
qualité  VARCHAR(30) NOT NULL,
FOREIGN KEY(idBR) REFERENCES BonDeReception(idBR));

CREATE TABLE BonDeReception (
idBR SERIAL PRIMARY KEY NOT NULL,
idBC SERIAL NOT NULL,
DateReception  DATE NOT NULL,
FOREIGN KEY(idBC) REFERENCES BonDeCommande(idBC));

CREATE TABLE DemandeSatisfait (
idDemandeSatisfait SERIAL PRIMARY KEY NOT NULL,
idDemande SERIAL NOT NULL,
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));

--Udpate Dina


-- +===========================+
-- From dev_karen
Nom VARCHAR(30) NOT NULL,
Login VARCHAR(30) NOT NULL UNIQUE,
Mdp VARCHAR(30) NOT NULL
-- >>>>>>>>>>>>>
alter table Sousdemande drop column Designation;
alter table Sousdemande add column idSuggestion int not null;
alter table Sousdemande add FOREIGN KEY (idSuggestion) REFERENCES Suggestion(idSuggestion);

-- select count(*),sg.nom from sousdemande s join suggestion sg on sg.idSuggestion=s.idSuggestion group by sg.idSuggestion,sg.nom;
-- select count(*),dmd.idDept from sousdemande s join suggestion sg on sg.idSuggestion=s.idSuggestion join demande dmd on dmd.iddemande=s.iddemande where group by dmd.iddept;

-- select quantite,dmd.idDept,sg.nom from sousdemande s join suggestion sg on sg.idSuggestion=s.idSuggestion join demande dmd on dmd.iddemande=s.iddemande where sg.idSuggestion

CREATE TABLE Demande (
idDemande SERIAL PRIMARY KEY NOT NULL,
idDept SERIAL NOT NULL,
DateDemande DATE NOT NULL,
Etat INTEGER NOT NULL DEFAULT 0,
FOREIGN KEY(idDept) REFERENCES Departement (idDept));

CREATE TABLE SousDemande (
idSousDemande SERIAL PRIMARY KEY NOT NULL,
idDemande SERIAL NOT NULL,
quantite INTEGER NOT NULL,
qualite VARCHAR(30) NOT NULL,
Designation VARCHAR(30) NOT NULL,
Rubrique  VARCHAR(30) NOT NULL,
DelaiLivraison DATE NOT NULL,
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));

CREATE TABLE Fournisseur  (
idFournisseur SERIAL PRIMARY KEY NOT NULL,
Nom VARCHAR(30) NOT NULL UNIQUE,
Adresse VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE DemandeProforma (
idDemandeProforma SERIAL PRIMARY KEY NOT NULL,
idFournisseur  SERIAL NOT NULL,
DateDemande DATE NOT NULL,
LieuLivraison VARCHAR(30) NOT NULL,
DelaiPaiement INTEGER NOT NULL,
FOREIGN KEY(idFournisseur ) REFERENCES Fournisseur (idFournisseur));

CREATE TABLE Proforma (
idProforma SERIAL PRIMARY KEY NOT NULL,
idFournisseur SERIAL NOT NULL,
idDemandeProforma SERIAL NOT NULL,
Reference  SERIAL NOT NULL UNIQUE,
FOREIGN KEY(idFournisseur) REFERENCES Fournisseur (idFournisseur),
FOREIGN KEY(idDemandeProforma) REFERENCES DemandeProforma(idDemandeProforma));

CREATE TABLE ProformaDemande (
idProformaDemande SERIAL PRIMARY KEY NOT NULL,
idDemandeProforma  SERIAL NOT NULL,
idDemande SERIAL NOT NULL,
FOREIGN KEY(idDemandeProforma ) REFERENCES DemandeProforma(idDemandeProforma),
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));

CREATE TABLE SousProforma (
idSousProforma SERIAL PRIMARY KEY NOT NULL,
idProforma  SERIAL NOT NULL,
quantite INTEGER NOT NULL,
Rubrique VARCHAR(30) NOT NULL,
Designation VARCHAR(30) NOT NULL,
PrixUnitaire DOUBLE PRECISION NOT NULL,
qualite VARCHAR(30) NOT NULL,
NoteQualite DOUBLE PRECISION NOT NULL,
FOREIGN KEY(idProforma ) REFERENCES Proforma(idProforma));





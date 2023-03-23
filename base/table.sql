DROP TABLE IF EXISTS Departement CASCADE;
DROP TABLE IF EXISTS ChefDept CASCADE;
DROP TABLE IF EXISTS RespAppro CASCADE;
DROP TABLE IF EXISTS Demande CASCADE;
DROP TABLE IF EXISTS SousDemande CASCADE;
DROP TABLE IF EXISTS DemandeProforma CASCADE;
DROP TABLE IF EXISTS Fournisseur  CASCADE;
DROP TABLE IF EXISTS Proforma CASCADE;
DROP TABLE IF EXISTS ProformaDemande CASCADE;
DROP TABLE IF EXISTS SousProforma CASCADE;
DROP TABLE IF EXISTS BonDeCommande CASCADE;
DROP TABLE IF EXISTS SousBonDeReception CASCADE;
DROP TABLE IF EXISTS BonDeReception CASCADE;
DROP TABLE IF EXISTS DemandeSatisfait CASCADE;

CREATE TABLE Departement  (
    idDept SERIAL PRIMARY KEY NOT NULL,
    NomDept VARCHAR(20) NOT NULL UNIQUE
);
INSERT INTO Departement (NomDept) values ('departement1');

CREATE TABLE ChefDept (
    idChef SERIAL PRIMARY KEY NOT NULL,
    idDept SERIAL NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Login VARCHAR(20) NOT NULL UNIQUE,
    Mdp VARCHAR(30) NOT NULL,
    FOREIGN KEY(idDept) REFERENCES Departement (idDept)
);

CREATE TABLE Demande (
    idDemande SERIAL PRIMARY KEY NOT NULL,
    idDept INT NOT NULL,
    intitule varchar(100),
    DateDemande DATE default CURRENT_DATE,
    Etat INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(idDept) REFERENCES Departement (idDept)
);
INSERT INTO Demande (idDept,intitule) values (1,'Demande d''equipement');

CREATE TABLE SousDemande (
idSousDemande SERIAL PRIMARY KEY NOT NULL,
idDemande SERIAL NOT NULL UNIQUE,
quantite INTEGER NOT NULL,
qualite VARCHAR(30) NOT NULL,
Designation VARCHAR(30) NOT NULL,
Rubrique  VARCHAR(30) NOT NULL,
DelaiLivraison DATE NOT NULL,
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));

CREATE TABLE Suggestion(
idSuggestion SERIAL PRIMARY KEY NOT NULL,
nom varchar(100)not null
);

alter table Sousdemande add column idSuggestion int not null;
alter table Sousdemande add FOREIGN KEY (idSuggestion) REFERENCES Suggestion(idSuggestion);

CREATE TABLE RespAppro (
idAppro  SERIAL PRIMARY KEY NOT NULL,
----- HEAD
Nom VARCHAR(30) NOT NULL,
Login VARCHAR(30) NOT NULL UNIQUE,
Mdp VARCHAR(30) NOT NULL,
FOREIGN KEY(idDept) REFERENCES Departement (idDept));

CREATE TABLE Fournisseur  (
idFournisseur SERIAL PRIMARY KEY NOT NULL,
Nom VARCHAR(30) NOT NULL UNIQUE,
Adresse VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE DemandeProforma (
idDemandeProforma SERIAL PRIMARY KEY NOT NULL,
fournisseurId  SERIAL NOT NULL,
DateDemande DATE NOT NULL DEFAULT current_date,
LieuLivraison VARCHAR(30) NOT NULL,
DelaiPaiement INTEGER NOT NULL,
FOREIGN KEY(fournisseurId) REFERENCES Fournisseur (idFournisseur));

CREATE TABLE Proforma (
idProforma SERIAL PRIMARY KEY NOT NULL,
idFournisseur SERIAL NOT NULL,
idDemandeProforma SERIAL NOT NULL,
Reference  SERIAL NOT NULL UNIQUE,
FOREIGN KEY(idFournisseur) REFERENCES Fournisseur (idFournisseur),
FOREIGN KEY(idDemandeProforma) REFERENCES DemandeProforma(idDemandeProforma));

CREATE TABLE ProformaDemande (
idProformaDemande SERIAL PRIMARY KEY NOT NULL,
idDemandeProforma  SERIAL NOT NULL UNIQUE,
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

CREATE TABLE BonDeCommande (
idBC SERIAL PRIMARY KEY NOT NULL,
idProforma  SERIAL NOT NULL,
DateBC DATE NOT NULL,
Etat INT DEFAULT 1,
FOREIGN KEY(idProforma ) REFERENCES Proforma(idProforma));

CREATE TABLE SousBonDeCommande(
    idSousBDC SERIAL PRIMARY KEY NOT NULL,
    idBC SERIAL NOT NULL,
    Designation  VARCHAR(30) NOT NULL,
    Rubrique  VARCHAR(30) NOT NULL,
    Quantité  INTEGER NOT NULL,
    PrixUnitaire DOUBLE PRECISION NOT NULL,
    Montant DOUBLE PRECISION NOT NULL, 
    FOREIGN KEY(idBC) REFERENCES BonDeCommande(idBC)
);

CREATE TABLE BonDeReception (
idBR SERIAL PRIMARY KEY NOT NULL,
idBC SERIAL NOT NULL,
DateReception  DATE NOT NULL,
FOREIGN KEY(idBC) REFERENCES BonDeCommande(idBC));

CREATE TABLE SousBonDeReception (
    idSousBR SERIAL PRIMARY KEY NOT NULL,
    idBR SERIAL NOT NULL,
    Designation  VARCHAR(30) NOT NULL,
    Rubrique  VARCHAR(30) NOT NULL,
    Quantité  INTEGER NOT NULL,
    qualité  VARCHAR(30) NOT NULL,
    FOREIGN KEY(idBR) REFERENCES BonDeReception(idBR)
);

CREATE TABLE DemandeSatisfait (
idDemandeSatisfait SERIAL PRIMARY KEY NOT NULL,
idDemande SERIAL NOT NULL,
FOREIGN KEY(idDemande) REFERENCES Demande(idDemande));
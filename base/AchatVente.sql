CREATE DATABASE achatvente;
CREATE ROLE achatvente LOGIN PASSWORD 'achatvente';
ALTER DATABASE achatvente OWNER TO achatvente;

DROP TABLE IF EXISTS ChefDept;
DROP TABLE IF EXISTS RespAppro;
DROP TABLE IF EXISTS DemandeSatisfait;
DROP TABLE IF EXISTS SousDemande;
DROP TABLE IF EXISTS Suggestion;
DROP TABLE IF EXISTS ProformaDemande;
DROP TABLE IF EXISTS Demande;
DROP TABLE IF EXISTS SousProforma;
DROP TABLE IF EXISTS SousBonDeReception;
DROP TABLE IF EXISTS Département;
DROP TABLE IF EXISTS BonDeReception;
DROP TABLE IF EXISTS BonDeCommande;
DROP TABLE IF EXISTS Proforma;
DROP TABLE IF EXISTS DemandeProforma;
DROP TABLE IF EXISTS Fournisseur;


CREATE TABLE Département  (
    idDept SERIAL PRIMARY KEY NOT NULL,
    NomDept VARCHAR(20) NOT NULL UNIQUE
);
INSERT INTO Département (NomDept) values ('departement1');

CREATE TABLE ChefDept (
    idChef SERIAL PRIMARY KEY NOT NULL,
    idDept SERIAL NOT NULL,
    Nom VARCHAR(20) NOT NULL,
    Login VARCHAR(20) NOT NULL UNIQUE,
    Mdp VARCHAR(30) NOT NULL,
    FOREIGN KEY(idDept) REFERENCES Département (idDept)
);
INSERT INTO ChefDept (idDept,Nom,Login,Mdp) values (1,'jean','jean','jean');

CREATE TABLE RespAppro (
    idAppro  SERIAL PRIMARY KEY NOT NULL,
    idDept SERIAL NOT NULL,
    Nom VARCHAR(30) NOT NULL,
    Login VARCHAR(30) NOT NULL UNIQUE,
    Mdp VARCHAR(30) NOT NULL,
    FOREIGN KEY(idDept) REFERENCES Département (idDept)
);

CREATE TABLE Demande (
    idDemande SERIAL PRIMARY KEY NOT NULL,
    idDept SERIAL NOT NULL,
    DateDemande DATE default now(),
    Etat INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(idDept) REFERENCES Département (idDept)
);
INSERT INTO Demande (idDept) values (1);

CREATE TABLE Suggestion(
    idSuggestion SERIAL PRIMARY KEY NOT NULL,
    nom varchar(100)not null
);
INSERT INTO Suggestion (nom) values ('sug1');
INSERT INTO Suggestion (nom) values ('aaa');
INSERT INTO Suggestion (nom) values ('bcd');
INSERT INTO Suggestion (nom) values ('ion');
INSERT INTO Suggestion (nom) values ('aub');

CREATE TABLE SousDemande (
    idSousDemande SERIAL PRIMARY KEY NOT NULL,
    idDemande INT NOT NULL,
    quantite INTEGER NOT NULL,
    qualite VARCHAR(30) NOT NULL,
    idSuggestion int not null,
    Designation VARCHAR(30) NOT NULL,
    Rubrique  VARCHAR(30) NOT NULL,
    DelaiLivraison DATE NOT NULL,
    FOREIGN KEY(idSuggestion) REFERENCES Suggestion(idSuggestion),
    FOREIGN KEY(idDemande) REFERENCES Demande(idDemande)
);
INSERT INTO SousDemande (idDemande,quantite,qualite,idSuggestion,Designation,Rubrique,DelaiLivraison) VALUES (1,5,'qualite A',1,'Designation','rubrique1','2022-12-15');
INSERT INTO SousDemande (idDemande,quantite,qualite,idSuggestion,Designation,Rubrique,DelaiLivraison) VALUES (1,7,'qualite B',2,'Autre Designation','rubrique2','2022-12-15');

CREATE TABLE Fournisseur  (
    idFournisseur SERIAL PRIMARY KEY NOT NULL,
    Nom VARCHAR(30) NOT NULL UNIQUE,
    Adresse VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE DemandeProforma (
    idDemandeProforma SERIAL PRIMARY KEY NOT NULL,
    idFournisseur  SERIAL NOT NULL,
    DateDemande DATE NOT NULL,
    LieuLivraison VARCHAR(30) NOT NULL,
    DelaiPaiement INTEGER NOT NULL,
    FOREIGN KEY(idFournisseur ) REFERENCES Fournisseur (idFournisseur)
);

CREATE TABLE Proforma (
    idProforma SERIAL PRIMARY KEY NOT NULL,
    idFournisseur SERIAL NOT NULL,
    idDemandeProforma SERIAL NOT NULL,
    Référence  SERIAL NOT NULL UNIQUE,
    FOREIGN KEY(idFournisseur) REFERENCES Fournisseur (idFournisseur),
    FOREIGN KEY(idDemandeProforma) REFERENCES DemandeProforma(idDemandeProforma)
);

CREATE TABLE ProformaDemande (
    idProformaDemande SERIAL PRIMARY KEY NOT NULL,
    idDemandeProforma  SERIAL NOT NULL UNIQUE,
    idDemande SERIAL NOT NULL UNIQUE,
    FOREIGN KEY(idDemandeProforma ) REFERENCES DemandeProforma(idDemandeProforma),
    FOREIGN KEY(idDemande) REFERENCES Demande(idDemande)
);

CREATE TABLE SousProforma (
    idSousProforma SERIAL PRIMARY KEY NOT NULL,
    idProforma  SERIAL NOT NULL,
    quantite INTEGER NOT NULL,
    Rubrique VARCHAR(30) NOT NULL,
    Designation VARCHAR(30) NOT NULL,
    PrixUnitaire DOUBLE PRECISION NOT NULL,
    qualite VARCHAR(30) NOT NULL,
    NoteQualite DOUBLE PRECISION NOT NULL,
    NoteQuantite DOUBLE PRECISION NOT NULL,
    FOREIGN KEY(idProforma ) REFERENCES Proforma(idProforma)
);

CREATE TABLE BonDeCommande (
    idBC SERIAL PRIMARY KEY NOT NULL,
    idProforma  SERIAL NOT NULL,
    DateBC DATE NOT NULL,
    Signature VARCHAR(60) NOT NULL,
    FOREIGN KEY(idProforma ) REFERENCES Proforma(idProforma)
);

CREATE TABLE BonDeReception (
    idBR SERIAL PRIMARY KEY NOT NULL,
    idBC SERIAL NOT NULL,
    DateReception  DATE NOT NULL,
    FOREIGN KEY(idBC) REFERENCES BonDeCommande(idBC)
);

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
    idDemande INTEGER NOT NULL,
    FOREIGN KEY(idDemande) REFERENCES Demande(idDemande)
);
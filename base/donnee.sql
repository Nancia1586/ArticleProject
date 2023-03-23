

INSERT INTO Departement VALUES(DEFAULT,'Dept_1');
INSERT INTO Departement VALUES(DEFAULT,'Dept_2');

INSERT INTO ChefDept VALUES(DEFAULT,1,'Idealy','Idea','1234');

INSERT INTO RespAppro VALUES(DEFAULT,'Dina','dina','1234');

INSERT INTO Demande VALUES(DEFAULT,1,'Demande Eau Vive',NOW(),0);
INSERT INTO Demande VALUES(DEFAULT,2,'Demande Casquete',NOW(),0);

INSERT INTO SousDemande VALUES(DEFAULT,1,2,'cuir','designation','rubrique','2022-10-10');
INSERT INTO SousDemande VALUES(DEFAULT,1,1,'cuir','designation2','rubrique','2022-10-10');
INSERT INTO SousDemande VALUES(DEFAULT,2,1,'cuir','designation','rubrique','2022-10-10');

--Fournisseur
INSERT INTO Fournisseur(nom,adresse)
VALUES
	('Telma','Antananarivo1'),
	('Star','Antananarivo2'),
	('Holcim','Antsirabe1'),
	('Eau vive','Andranovelona1'),
	('Ranovisy','Antsirabe2'),
	('Orange','Antananarivo3'),
	('JB','Antananarivo4'),
	('Airtel','Antananarivo5');

INSERT INTO Fournisseur VALUES(DEFAULT,'F_1','Lot II F1');
INSERT INTO Fournisseur VALUES(DEFAULT,'F_2','Lot II F2');
INSERT INTO Fournisseur VALUES(DEFAULT,'F_3','Lot II F3');

INSERT INTO DemandeProforma VALUES(DEFAULT,1,NOW(),'L1',29);
INSERT INTO DemandeProforma VALUES(DEFAULT,2,NOW(),'L1',29);
INSERT INTO DemandeProforma VALUES(DEFAULT,3,NOW(),'L1',29);

INSERT INTO Proforma(idDemandeProforma,idFournisseur) VALUES(1,1);
INSERT INTO Proforma(idDemandeProforma,idFournisseur) VALUES(2,2);
INSERT INTO Proforma(idDemandeProforma,idFournisseur) VALUES(3,3);

INSERT INTO SousProforma VALUES(DEFAULT,1,1,'rubrique','designation',7000,'cuir',15);
INSERT INTO SousProforma VALUES(DEFAULT,2,2,'rubrique','designation',10000,'tsy cuir',13);
INSERT INTO SousProforma VALUES(DEFAULT,2,1,'rubrique','designation2',1500,'cuir',13);
INSERT INTO SousProforma VALUES(DEFAULT,3,3,'rubrique','designation',7000,'cuir',10);

INSERT INTO ProformaDemande VALUES(DEFAULT,1,1);
INSERT INTO ProformaDemande VALUES(DEFAULT,1,2);
INSERT INTO ProformaDemande VALUES(DEFAULT,2,1);
INSERT INTO ProformaDemande VALUES(DEFAULT,2,2);
INSERT INTO ProformaDemande VALUES(DEFAULT,3,1);
INSERT INTO ProformaDemande VALUES(DEFAULT,3,2);

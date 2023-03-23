CREATE OR REPLACE VIEW V_FournisseurDemande 
AS 
SELECT * FROM Fournisseur f JOIN DemandeProforma d ON f.idFournisseur = d.fournisseurId;

CREATE  VIEW DemandeGrouper as  select sum(quantite)as nombre,sg.nom,sg.idsuggestion from sousdemande s join suggestion sg on sg.idSuggestion=s.idSuggestion group by sg.idSuggestion,sg.nom,sg.idsuggestion;

CREATE VIEW v_DemandeEnCours AS
    SELECT * FROM Demande WHERE idDemande NOT IN (SELECT idDemande FROM DemandeSatisfait) 
    AND idDemande IN (SELECT idDemande FROM ProformaDemande WHERE idDemandeProforma IN 
    (SELECT idDemandeProforma FROM Proforma WHERE idProforma IN (SELECT idProforma FROM BonDeCommande WHERE Etat>0))
    );

CREATE VIEW v_DemandeSatisfait AS 
    SELECT * FROM Demande WHERE idDemande IN (SELECT idDemande FROM DemandeSatisfait);

CREATE VIEW v_DemandeNonSatisfait AS
    SELECT * FROM Demande WHERE idDemande NOT IN(SELECT idDemande FROM v_DemandeEnCours) 
    AND idDemande NOT IN (SELECT idDemande FROM v_DemandeSatisfait);

CREATE VIEW v_DemandeDetailNonSatisfaitRegroupe AS
    SELECT Designation,SUM(quantite) as QuantiteVoulu FROM SousDemande WHERE idDemande IN (SELECT idDemande FROM v_DemandeNonSatisfait) GROUP BY Designation;

CREATE VIEW v_ProformaDetail AS 
    SELECT P.idProforma,P.idDemandeProforma,P.Reference,
    S.idSousProforma,S.Quantite,S.Rubrique,S.Designation,S.PrixUnitaire,S.NoteQualite,
    DP.idFournisseur,Dp.LieuLivraison, DP.DelaiPaiement,F.Nom,F.Adresse
    FROM Proforma P JOIN SousProforma S ON (P.idProforma=S.idProforma)
    JOIN DemandeProforma DP ON (DP.idDemandeProforma=P.idDemandeProforma)
    JOIN Fournisseur F ON (DP.idFournisseur=F.idFournisseur);

CREATE VIEW v_ProformaDemandeNonSatisfait AS
    SELECT * FROM v_ProformaDetail WHERE idDemandeProforma IN 
    (SELECT idDemandeProforma FROM ProformaDemande WHERE idDemande IN (SELECT idDemande FROM v_DemandeNonSatisfait));
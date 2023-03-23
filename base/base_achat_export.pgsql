--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Ubuntu 12.2-4)
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-4)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: demande; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.demande (
    iddemande integer NOT NULL,
    iddept integer NOT NULL,
    intitule character varying(100),
    datedemande date DEFAULT CURRENT_DATE,
    etat integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.demande OWNER TO dina;

--
-- Name: departement; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.departement (
    iddept integer NOT NULL,
    nomdept character varying(20) NOT NULL
);


ALTER TABLE public.departement OWNER TO dina;

--
-- Name: sousdemande; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.sousdemande (
    idsousdemande integer NOT NULL,
    iddemande integer NOT NULL,
    quantite integer NOT NULL,
    qualite character varying(30) NOT NULL,
    designation character varying(30) NOT NULL,
    rubrique character varying(30) NOT NULL,
    delailivraison date NOT NULL,
    idsuggestion integer NOT NULL
);


ALTER TABLE public.sousdemande OWNER TO dina;

--
-- Name: suggestion; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.suggestion (
    idsuggestion integer NOT NULL,
    nom character varying(100) NOT NULL,
    codeproduit character varying(100) DEFAULT 'PR_'::character varying
);


ALTER TABLE public.suggestion OWNER TO dina;

--
-- Name: alldemande; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.alldemande AS
 SELECT sum(s.quantite) AS quantite,
    sg.nom,
    sg.idsuggestion,
    dept.iddept,
    dept.nomdept
   FROM (((public.sousdemande s
     JOIN public.demande d ON ((d.iddemande = s.iddemande)))
     JOIN public.departement dept ON ((dept.iddept = d.iddept)))
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  GROUP BY dept.iddept, dept.nomdept, sg.nom, sg.idsuggestion;


ALTER TABLE public.alldemande OWNER TO dina;

--
-- Name: bondecommande; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.bondecommande (
    idbc integer NOT NULL,
    idproforma integer NOT NULL,
    datebc date NOT NULL,
    etat integer DEFAULT 1,
    idfournisseur integer NOT NULL,
    totalht double precision DEFAULT 0,
    tva double precision DEFAULT 0,
    ttc double precision DEFAULT 0,
    datelivraison date DEFAULT CURRENT_DATE,
    lieulivraison character varying(30),
    delaipaiement integer
);


ALTER TABLE public.bondecommande OWNER TO dina;

--
-- Name: bondecommande_idbc_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondecommande_idbc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondecommande_idbc_seq OWNER TO dina;

--
-- Name: bondecommande_idbc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondecommande_idbc_seq OWNED BY public.bondecommande.idbc;


--
-- Name: bondecommande_idfournisseur_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondecommande_idfournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondecommande_idfournisseur_seq OWNER TO dina;

--
-- Name: bondecommande_idfournisseur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondecommande_idfournisseur_seq OWNED BY public.bondecommande.idfournisseur;


--
-- Name: bondecommande_idproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondecommande_idproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondecommande_idproforma_seq OWNER TO dina;

--
-- Name: bondecommande_idproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondecommande_idproforma_seq OWNED BY public.bondecommande.idproforma;


--
-- Name: bondereception; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.bondereception (
    idbr integer NOT NULL,
    idbc integer NOT NULL,
    datereception date NOT NULL
);


ALTER TABLE public.bondereception OWNER TO dina;

--
-- Name: bondereception_fini; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.bondereception_fini (
    idbr_fini integer NOT NULL,
    idbr integer NOT NULL
);


ALTER TABLE public.bondereception_fini OWNER TO dina;

--
-- Name: bondereception_fini_idbr_fini_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondereception_fini_idbr_fini_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondereception_fini_idbr_fini_seq OWNER TO dina;

--
-- Name: bondereception_fini_idbr_fini_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondereception_fini_idbr_fini_seq OWNED BY public.bondereception_fini.idbr_fini;


--
-- Name: bondereception_fini_idbr_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondereception_fini_idbr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondereception_fini_idbr_seq OWNER TO dina;

--
-- Name: bondereception_fini_idbr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondereception_fini_idbr_seq OWNED BY public.bondereception_fini.idbr;


--
-- Name: bondereception_idbc_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondereception_idbc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondereception_idbc_seq OWNER TO dina;

--
-- Name: bondereception_idbc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondereception_idbc_seq OWNED BY public.bondereception.idbc;


--
-- Name: bondereception_idbr_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.bondereception_idbr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bondereception_idbr_seq OWNER TO dina;

--
-- Name: bondereception_idbr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.bondereception_idbr_seq OWNED BY public.bondereception.idbr;


--
-- Name: chefdept; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.chefdept (
    idchef integer NOT NULL,
    iddept integer NOT NULL,
    nom character varying(20) NOT NULL,
    login character varying(20) NOT NULL,
    mdp character varying(30) NOT NULL
);


ALTER TABLE public.chefdept OWNER TO dina;

--
-- Name: chefdept_idchef_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.chefdept_idchef_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chefdept_idchef_seq OWNER TO dina;

--
-- Name: chefdept_idchef_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.chefdept_idchef_seq OWNED BY public.chefdept.idchef;


--
-- Name: chefdept_iddept_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.chefdept_iddept_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chefdept_iddept_seq OWNER TO dina;

--
-- Name: chefdept_iddept_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.chefdept_iddept_seq OWNED BY public.chefdept.iddept;


--
-- Name: dd; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.dd (
    id integer
);


ALTER TABLE public.dd OWNER TO dina;

--
-- Name: demande_iddemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demande_iddemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demande_iddemande_seq OWNER TO dina;

--
-- Name: demande_iddemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demande_iddemande_seq OWNED BY public.demande.iddemande;


--
-- Name: demandegrouper; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.demandegrouper AS
 SELECT sum(s.quantite) AS nombre,
    sg.nom,
    sg.idsuggestion
   FROM (public.sousdemande s
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  GROUP BY sg.idsuggestion, sg.nom;


ALTER TABLE public.demandegrouper OWNER TO dina;

--
-- Name: demandeproforma; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.demandeproforma (
    iddemandeproforma integer NOT NULL,
    fournisseurid integer NOT NULL,
    datedemande date DEFAULT CURRENT_DATE NOT NULL,
    lieulivraison character varying(30) NOT NULL,
    delaipaiement integer NOT NULL
);


ALTER TABLE public.demandeproforma OWNER TO dina;

--
-- Name: demandeproforma_fournisseurid_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandeproforma_fournisseurid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandeproforma_fournisseurid_seq OWNER TO dina;

--
-- Name: demandeproforma_fournisseurid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandeproforma_fournisseurid_seq OWNED BY public.demandeproforma.fournisseurid;


--
-- Name: demandeproforma_iddemandeproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandeproforma_iddemandeproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandeproforma_iddemandeproforma_seq OWNER TO dina;

--
-- Name: demandeproforma_iddemandeproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandeproforma_iddemandeproforma_seq OWNED BY public.demandeproforma.iddemandeproforma;


--
-- Name: demandesatisfait; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.demandesatisfait (
    iddemandesatisfait integer NOT NULL,
    iddemande integer NOT NULL
);


ALTER TABLE public.demandesatisfait OWNER TO dina;

--
-- Name: demandesatisfait_iddemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandesatisfait_iddemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandesatisfait_iddemande_seq OWNER TO dina;

--
-- Name: demandesatisfait_iddemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandesatisfait_iddemande_seq OWNED BY public.demandesatisfait.iddemande;


--
-- Name: demandesatisfait_iddemandesatisfait_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandesatisfait_iddemandesatisfait_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandesatisfait_iddemandesatisfait_seq OWNER TO dina;

--
-- Name: demandesatisfait_iddemandesatisfait_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandesatisfait_iddemandesatisfait_seq OWNED BY public.demandesatisfait.iddemandesatisfait;


--
-- Name: demandevalide; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.demandevalide (
    iddemandesatisfait integer NOT NULL,
    iddemande integer NOT NULL
);


ALTER TABLE public.demandevalide OWNER TO dina;

--
-- Name: demandevalide_iddemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandevalide_iddemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandevalide_iddemande_seq OWNER TO dina;

--
-- Name: demandevalide_iddemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandevalide_iddemande_seq OWNED BY public.demandevalide.iddemande;


--
-- Name: demandevalide_iddemandesatisfait_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.demandevalide_iddemandesatisfait_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demandevalide_iddemandesatisfait_seq OWNER TO dina;

--
-- Name: demandevalide_iddemandesatisfait_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.demandevalide_iddemandesatisfait_seq OWNED BY public.demandevalide.iddemandesatisfait;


--
-- Name: departement_iddept_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.departement_iddept_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departement_iddept_seq OWNER TO dina;

--
-- Name: departement_iddept_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.departement_iddept_seq OWNED BY public.departement.iddept;


--
-- Name: dispatchproduit; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.dispatchproduit (
    iddr integer NOT NULL,
    iddept integer NOT NULL,
    idsuggestion integer NOT NULL,
    quantite integer DEFAULT 0,
    daty date DEFAULT CURRENT_DATE
);


ALTER TABLE public.dispatchproduit OWNER TO dina;

--
-- Name: dispatchproduit_iddept_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.dispatchproduit_iddept_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dispatchproduit_iddept_seq OWNER TO dina;

--
-- Name: dispatchproduit_iddept_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.dispatchproduit_iddept_seq OWNED BY public.dispatchproduit.iddept;


--
-- Name: dispatchproduit_iddr_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.dispatchproduit_iddr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dispatchproduit_iddr_seq OWNER TO dina;

--
-- Name: dispatchproduit_iddr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.dispatchproduit_iddr_seq OWNED BY public.dispatchproduit.iddr;


--
-- Name: dispatchproduit_idsuggestion_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.dispatchproduit_idsuggestion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dispatchproduit_idsuggestion_seq OWNER TO dina;

--
-- Name: dispatchproduit_idsuggestion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.dispatchproduit_idsuggestion_seq OWNED BY public.dispatchproduit.idsuggestion;


--
-- Name: fournisseur; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.fournisseur (
    idfournisseur integer NOT NULL,
    nom character varying(30) NOT NULL,
    adresse character varying(30) NOT NULL
);


ALTER TABLE public.fournisseur OWNER TO dina;

--
-- Name: fournisseur_idfournisseur_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.fournisseur_idfournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fournisseur_idfournisseur_seq OWNER TO dina;

--
-- Name: fournisseur_idfournisseur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.fournisseur_idfournisseur_seq OWNED BY public.fournisseur.idfournisseur;


--
-- Name: proforma; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.proforma (
    idproforma integer NOT NULL,
    idfournisseur integer NOT NULL,
    iddemandeproforma integer NOT NULL,
    reference integer NOT NULL
);


ALTER TABLE public.proforma OWNER TO dina;

--
-- Name: proforma_iddemandeproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proforma_iddemandeproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proforma_iddemandeproforma_seq OWNER TO dina;

--
-- Name: proforma_iddemandeproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proforma_iddemandeproforma_seq OWNED BY public.proforma.iddemandeproforma;


--
-- Name: proforma_idfournisseur_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proforma_idfournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proforma_idfournisseur_seq OWNER TO dina;

--
-- Name: proforma_idfournisseur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proforma_idfournisseur_seq OWNED BY public.proforma.idfournisseur;


--
-- Name: proforma_idproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proforma_idproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proforma_idproforma_seq OWNER TO dina;

--
-- Name: proforma_idproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proforma_idproforma_seq OWNED BY public.proforma.idproforma;


--
-- Name: proforma_reference_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proforma_reference_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proforma_reference_seq OWNER TO dina;

--
-- Name: proforma_reference_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proforma_reference_seq OWNED BY public.proforma.reference;


--
-- Name: proformademande; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.proformademande (
    idproformademande integer NOT NULL,
    iddemandeproforma integer NOT NULL,
    iddemande integer NOT NULL
);


ALTER TABLE public.proformademande OWNER TO dina;

--
-- Name: proformademande_iddemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proformademande_iddemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proformademande_iddemande_seq OWNER TO dina;

--
-- Name: proformademande_iddemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proformademande_iddemande_seq OWNED BY public.proformademande.iddemande;


--
-- Name: proformademande_iddemandeproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proformademande_iddemandeproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proformademande_iddemandeproforma_seq OWNER TO dina;

--
-- Name: proformademande_iddemandeproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proformademande_iddemandeproforma_seq OWNED BY public.proformademande.iddemandeproforma;


--
-- Name: proformademande_idproformademande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.proformademande_idproformademande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proformademande_idproformademande_seq OWNER TO dina;

--
-- Name: proformademande_idproformademande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.proformademande_idproformademande_seq OWNED BY public.proformademande.idproformademande;


--
-- Name: qtegrouper; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.qtegrouper AS
 SELECT sum(s.quantite) AS quantite,
    sg.nom,
    sg.idsuggestion
   FROM (((public.sousdemande s
     JOIN public.demande d ON ((d.iddemande = s.iddemande)))
     JOIN public.departement dept ON ((dept.iddept = d.iddept)))
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  GROUP BY sg.nom, sg.idsuggestion;


ALTER TABLE public.qtegrouper OWNER TO dina;

--
-- Name: respappro; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.respappro (
    idappro integer NOT NULL,
    nom character varying(30) NOT NULL,
    login character varying(30) NOT NULL,
    mdp character varying(30) NOT NULL
);


ALTER TABLE public.respappro OWNER TO dina;

--
-- Name: respappro_idappro_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.respappro_idappro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.respappro_idappro_seq OWNER TO dina;

--
-- Name: respappro_idappro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.respappro_idappro_seq OWNED BY public.respappro.idappro;


--
-- Name: sousbondecommande; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.sousbondecommande (
    idsousbdc integer NOT NULL,
    idbc integer NOT NULL,
    designation character varying(30) NOT NULL,
    rubrique character varying(30) NOT NULL,
    "quantité" integer NOT NULL,
    prixunitaire double precision NOT NULL,
    montant double precision NOT NULL,
    idsuggestion integer,
    qualite character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.sousbondecommande OWNER TO dina;

--
-- Name: sousbondecommande_idbc_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousbondecommande_idbc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousbondecommande_idbc_seq OWNER TO dina;

--
-- Name: sousbondecommande_idbc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousbondecommande_idbc_seq OWNED BY public.sousbondecommande.idbc;


--
-- Name: sousbondecommande_idsousbdc_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousbondecommande_idsousbdc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousbondecommande_idsousbdc_seq OWNER TO dina;

--
-- Name: sousbondecommande_idsousbdc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousbondecommande_idsousbdc_seq OWNED BY public.sousbondecommande.idsousbdc;


--
-- Name: sousbondereception; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.sousbondereception (
    idsousbr integer NOT NULL,
    idbr integer NOT NULL,
    designation character varying(30) NOT NULL,
    rubrique character varying(30) NOT NULL,
    "quantité" integer NOT NULL,
    "qualité" character varying(30) NOT NULL,
    idsuggestion integer,
    daty date DEFAULT CURRENT_DATE,
    observation character varying(100) DEFAULT 'Rien A Signaler'::character varying
);


ALTER TABLE public.sousbondereception OWNER TO dina;

--
-- Name: sousbondereception_idbr_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousbondereception_idbr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousbondereception_idbr_seq OWNER TO dina;

--
-- Name: sousbondereception_idbr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousbondereception_idbr_seq OWNED BY public.sousbondereception.idbr;


--
-- Name: sousbondereception_idsousbr_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousbondereception_idsousbr_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousbondereception_idsousbr_seq OWNER TO dina;

--
-- Name: sousbondereception_idsousbr_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousbondereception_idsousbr_seq OWNED BY public.sousbondereception.idsousbr;


--
-- Name: sousdemande_iddemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousdemande_iddemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousdemande_iddemande_seq OWNER TO dina;

--
-- Name: sousdemande_iddemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousdemande_iddemande_seq OWNED BY public.sousdemande.iddemande;


--
-- Name: sousdemande_idsousdemande_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousdemande_idsousdemande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousdemande_idsousdemande_seq OWNER TO dina;

--
-- Name: sousdemande_idsousdemande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousdemande_idsousdemande_seq OWNED BY public.sousdemande.idsousdemande;


--
-- Name: sousproforma; Type: TABLE; Schema: public; Owner: dina
--

CREATE TABLE public.sousproforma (
    idsousproforma integer NOT NULL,
    idproforma integer NOT NULL,
    quantite integer NOT NULL,
    rubrique character varying(30) NOT NULL,
    designation character varying(30) NOT NULL,
    prixunitaire double precision NOT NULL,
    qualite character varying(30) NOT NULL,
    notequalite double precision NOT NULL,
    idsuggestion integer,
    prixnote double precision DEFAULT 0
);


ALTER TABLE public.sousproforma OWNER TO dina;

--
-- Name: sousproforma_idproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousproforma_idproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousproforma_idproforma_seq OWNER TO dina;

--
-- Name: sousproforma_idproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousproforma_idproforma_seq OWNED BY public.sousproforma.idproforma;


--
-- Name: sousproforma_idsousproforma_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.sousproforma_idsousproforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sousproforma_idsousproforma_seq OWNER TO dina;

--
-- Name: sousproforma_idsousproforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.sousproforma_idsousproforma_seq OWNED BY public.sousproforma.idsousproforma;


--
-- Name: suggestion_idsuggestion_seq; Type: SEQUENCE; Schema: public; Owner: dina
--

CREATE SEQUENCE public.suggestion_idsuggestion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggestion_idsuggestion_seq OWNER TO dina;

--
-- Name: suggestion_idsuggestion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dina
--

ALTER SEQUENCE public.suggestion_idsuggestion_seq OWNED BY public.suggestion.idsuggestion;


--
-- Name: v_bondecommande; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_bondecommande AS
 SELECT bc.idbc,
    bc.idproforma,
    bc.datebc,
    bc.etat,
    bc.idfournisseur,
    bc.totalht,
    bc.tva,
    bc.ttc,
    bc.datelivraison,
    bc.lieulivraison,
    bc.delaipaiement,
    f.nom,
    p.reference
   FROM ((public.bondecommande bc
     JOIN public.fournisseur f ON ((f.idfournisseur = bc.idfournisseur)))
     JOIN public.proforma p ON ((p.idproforma = bc.idproforma)));


ALTER TABLE public.v_bondecommande OWNER TO dina;

--
-- Name: v_bondecommandedetail; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_bondecommandedetail AS
 SELECT vbc.idbc,
    vbc.idproforma,
    vbc.datebc,
    vbc.etat,
    vbc.idfournisseur,
    vbc.totalht,
    vbc.tva,
    vbc.ttc,
    vbc.datelivraison,
    vbc.lieulivraison,
    vbc.delaipaiement,
    vbc.nom,
    vbc.reference,
    sbc.idsousbdc,
    sbc.designation,
    sbc.rubrique,
    sbc."quantité" AS quantite,
    sbc.prixunitaire,
    sbc.montant,
    sbc.idsuggestion
   FROM (public.v_bondecommande vbc
     JOIN public.sousbondecommande sbc ON ((sbc.idbc = vbc.idbc)));


ALTER TABLE public.v_bondecommandedetail OWNER TO dina;

--
-- Name: v_demandesatisfait; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_demandesatisfait AS
 SELECT demande.iddemande,
    demande.iddept,
    demande.intitule,
    demande.datedemande,
    demande.etat
   FROM public.demande
  WHERE (demande.iddemande IN ( SELECT demandesatisfait.iddemande
           FROM public.demandesatisfait));


ALTER TABLE public.v_demandesatisfait OWNER TO dina;

--
-- Name: v_demandenonsatisfait; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_demandenonsatisfait AS
 SELECT demande.iddemande,
    demande.iddept,
    demande.intitule,
    demande.datedemande,
    demande.etat
   FROM public.demande
  WHERE (NOT (demande.iddemande IN ( SELECT v_demandesatisfait.iddemande
           FROM public.v_demandesatisfait)));


ALTER TABLE public.v_demandenonsatisfait OWNER TO dina;

--
-- Name: v_datelivraison; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_datelivraison AS
 SELECT sousdemande.delailivraison
   FROM (public.sousdemande
     JOIN public.demande ON ((sousdemande.iddemande = demande.iddemande)))
  WHERE (demande.iddemande IN ( SELECT v_demandenonsatisfait.iddemande
           FROM public.v_demandenonsatisfait))
  ORDER BY sousdemande.delailivraison;


ALTER TABLE public.v_datelivraison OWNER TO dina;

--
-- Name: v_demandedetailnonsatisfaitregroupe; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_demandedetailnonsatisfaitregroupe AS
 SELECT sg.nom AS designation,
    sg.idsuggestion,
    sum(s.quantite) AS quantitevoulu
   FROM (public.sousdemande s
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  WHERE (s.iddemande IN ( SELECT v_demandenonsatisfait.iddemande
           FROM public.v_demandenonsatisfait))
  GROUP BY sg.nom, sg.idsuggestion;


ALTER TABLE public.v_demandedetailnonsatisfaitregroupe OWNER TO dina;

--
-- Name: v_demandeencours; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_demandeencours AS
 SELECT demande.iddemande,
    demande.iddept,
    demande.intitule,
    demande.datedemande,
    demande.etat
   FROM public.demande
  WHERE ((NOT (demande.iddemande IN ( SELECT demandesatisfait.iddemande
           FROM public.demandesatisfait))) AND (demande.iddemande IN ( SELECT proformademande.iddemande
           FROM public.proformademande
          WHERE (proformademande.iddemandeproforma IN ( SELECT proforma.iddemandeproforma
                   FROM public.proforma
                  WHERE (proforma.idproforma IN ( SELECT bondecommande.idproforma
                           FROM public.bondecommande
                          WHERE (bondecommande.etat > 0))))))));


ALTER TABLE public.v_demandeencours OWNER TO dina;

--
-- Name: v_fournisseurdemande; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_fournisseurdemande AS
 SELECT f.idfournisseur,
    f.nom,
    f.adresse,
    d.iddemandeproforma,
    d.fournisseurid,
    d.datedemande,
    d.lieulivraison,
    d.delaipaiement
   FROM (public.fournisseur f
     JOIN public.demandeproforma d ON ((f.idfournisseur = d.fournisseurid)));


ALTER TABLE public.v_fournisseurdemande OWNER TO dina;

--
-- Name: v_proformadetail; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_proformadetail AS
 SELECT p.idproforma,
    p.iddemandeproforma,
    p.reference,
    s.idsousproforma,
    s.quantite,
    s.rubrique,
    s.idsuggestion,
    s.designation,
    s.prixunitaire,
    s.notequalite,
    dp.fournisseurid AS idfournisseur,
    dp.lieulivraison,
    dp.delaipaiement,
    f.nom,
    f.adresse
   FROM (((public.proforma p
     JOIN public.sousproforma s ON ((p.idproforma = s.idproforma)))
     JOIN public.demandeproforma dp ON ((dp.iddemandeproforma = p.iddemandeproforma)))
     JOIN public.fournisseur f ON ((dp.fournisseurid = f.idfournisseur)));


ALTER TABLE public.v_proformadetail OWNER TO dina;

--
-- Name: v_proformademandenonsatisfait; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_proformademandenonsatisfait AS
 SELECT v_proformadetail.idproforma,
    v_proformadetail.iddemandeproforma,
    v_proformadetail.reference,
    v_proformadetail.idsousproforma,
    v_proformadetail.quantite,
    v_proformadetail.rubrique,
    v_proformadetail.idsuggestion,
    v_proformadetail.designation,
    v_proformadetail.prixunitaire,
    v_proformadetail.notequalite,
    v_proformadetail.idfournisseur,
    v_proformadetail.lieulivraison,
    v_proformadetail.delaipaiement,
    v_proformadetail.nom,
    v_proformadetail.adresse
   FROM public.v_proformadetail
  WHERE (v_proformadetail.iddemandeproforma IN ( SELECT proformademande.iddemandeproforma
           FROM public.proformademande
          WHERE (proformademande.iddemande IN ( SELECT v_demandenonsatisfait.iddemande
                   FROM public.v_demandenonsatisfait))));


ALTER TABLE public.v_proformademandenonsatisfait OWNER TO dina;

--
-- Name: v_reception; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_reception AS
 SELECT sum(s."quantité") AS nombre,
    sg.nom,
    sg.idsuggestion,
    s.idbr
   FROM (public.sousbondereception s
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  WHERE (NOT (s.idbr IN ( SELECT bondereception_fini.idbr
           FROM public.bondereception_fini)))
  GROUP BY sg.idsuggestion, sg.nom, s.idbr;


ALTER TABLE public.v_reception OWNER TO dina;

--
-- Name: v_receptionbondecommmande; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_receptionbondecommmande AS
 SELECT sum(s."quantité") AS nombre,
    sg.nom,
    sg.idsuggestion,
    s.idbc
   FROM (public.sousbondecommande s
     JOIN public.suggestion sg ON ((sg.idsuggestion = s.idsuggestion)))
  GROUP BY sg.idsuggestion, sg.nom, s.idbc;


ALTER TABLE public.v_receptionbondecommmande OWNER TO dina;

--
-- Name: v_receptioncommande; Type: VIEW; Schema: public; Owner: dina
--

CREATE VIEW public.v_receptioncommande AS
 SELECT rcp.qtereception,
    rcp.idbr,
    cmd.qtecommande,
    cmd.idbc
   FROM ( SELECT
                CASE
                    WHEN (sum(sb."quantité") >= 0) THEN sum(sb."quantité")
                    ELSE (0)::bigint
                END AS qtereception,
            br.idbr
           FROM (public.sousbondereception sb
             RIGHT JOIN public.bondereception br ON ((br.idbr = sb.idbr)))
          GROUP BY br.idbr) rcp,
    ( SELECT sum(sousbondecommande."quantité") AS qtecommande,
            sousbondecommande.idbc
           FROM public.sousbondecommande
          GROUP BY sousbondecommande.idbc) cmd;


ALTER TABLE public.v_receptioncommande OWNER TO dina;

--
-- Name: bondecommande idbc; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande ALTER COLUMN idbc SET DEFAULT nextval('public.bondecommande_idbc_seq'::regclass);


--
-- Name: bondecommande idproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande ALTER COLUMN idproforma SET DEFAULT nextval('public.bondecommande_idproforma_seq'::regclass);


--
-- Name: bondecommande idfournisseur; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande ALTER COLUMN idfournisseur SET DEFAULT nextval('public.bondecommande_idfournisseur_seq'::regclass);


--
-- Name: bondereception idbr; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception ALTER COLUMN idbr SET DEFAULT nextval('public.bondereception_idbr_seq'::regclass);


--
-- Name: bondereception idbc; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception ALTER COLUMN idbc SET DEFAULT nextval('public.bondereception_idbc_seq'::regclass);


--
-- Name: bondereception_fini idbr_fini; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception_fini ALTER COLUMN idbr_fini SET DEFAULT nextval('public.bondereception_fini_idbr_fini_seq'::regclass);


--
-- Name: bondereception_fini idbr; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception_fini ALTER COLUMN idbr SET DEFAULT nextval('public.bondereception_fini_idbr_seq'::regclass);


--
-- Name: chefdept idchef; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.chefdept ALTER COLUMN idchef SET DEFAULT nextval('public.chefdept_idchef_seq'::regclass);


--
-- Name: chefdept iddept; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.chefdept ALTER COLUMN iddept SET DEFAULT nextval('public.chefdept_iddept_seq'::regclass);


--
-- Name: demande iddemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demande ALTER COLUMN iddemande SET DEFAULT nextval('public.demande_iddemande_seq'::regclass);


--
-- Name: demandeproforma iddemandeproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandeproforma ALTER COLUMN iddemandeproforma SET DEFAULT nextval('public.demandeproforma_iddemandeproforma_seq'::regclass);


--
-- Name: demandeproforma fournisseurid; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandeproforma ALTER COLUMN fournisseurid SET DEFAULT nextval('public.demandeproforma_fournisseurid_seq'::regclass);


--
-- Name: demandesatisfait iddemandesatisfait; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandesatisfait ALTER COLUMN iddemandesatisfait SET DEFAULT nextval('public.demandesatisfait_iddemandesatisfait_seq'::regclass);


--
-- Name: demandesatisfait iddemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandesatisfait ALTER COLUMN iddemande SET DEFAULT nextval('public.demandesatisfait_iddemande_seq'::regclass);


--
-- Name: demandevalide iddemandesatisfait; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandevalide ALTER COLUMN iddemandesatisfait SET DEFAULT nextval('public.demandevalide_iddemandesatisfait_seq'::regclass);


--
-- Name: demandevalide iddemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandevalide ALTER COLUMN iddemande SET DEFAULT nextval('public.demandevalide_iddemande_seq'::regclass);


--
-- Name: departement iddept; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.departement ALTER COLUMN iddept SET DEFAULT nextval('public.departement_iddept_seq'::regclass);


--
-- Name: dispatchproduit iddr; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit ALTER COLUMN iddr SET DEFAULT nextval('public.dispatchproduit_iddr_seq'::regclass);


--
-- Name: dispatchproduit iddept; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit ALTER COLUMN iddept SET DEFAULT nextval('public.dispatchproduit_iddept_seq'::regclass);


--
-- Name: dispatchproduit idsuggestion; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit ALTER COLUMN idsuggestion SET DEFAULT nextval('public.dispatchproduit_idsuggestion_seq'::regclass);


--
-- Name: fournisseur idfournisseur; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.fournisseur ALTER COLUMN idfournisseur SET DEFAULT nextval('public.fournisseur_idfournisseur_seq'::regclass);


--
-- Name: proforma idproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma ALTER COLUMN idproforma SET DEFAULT nextval('public.proforma_idproforma_seq'::regclass);


--
-- Name: proforma idfournisseur; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma ALTER COLUMN idfournisseur SET DEFAULT nextval('public.proforma_idfournisseur_seq'::regclass);


--
-- Name: proforma iddemandeproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma ALTER COLUMN iddemandeproforma SET DEFAULT nextval('public.proforma_iddemandeproforma_seq'::regclass);


--
-- Name: proforma reference; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma ALTER COLUMN reference SET DEFAULT nextval('public.proforma_reference_seq'::regclass);


--
-- Name: proformademande idproformademande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande ALTER COLUMN idproformademande SET DEFAULT nextval('public.proformademande_idproformademande_seq'::regclass);


--
-- Name: proformademande iddemandeproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande ALTER COLUMN iddemandeproforma SET DEFAULT nextval('public.proformademande_iddemandeproforma_seq'::regclass);


--
-- Name: proformademande iddemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande ALTER COLUMN iddemande SET DEFAULT nextval('public.proformademande_iddemande_seq'::regclass);


--
-- Name: respappro idappro; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.respappro ALTER COLUMN idappro SET DEFAULT nextval('public.respappro_idappro_seq'::regclass);


--
-- Name: sousbondecommande idsousbdc; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondecommande ALTER COLUMN idsousbdc SET DEFAULT nextval('public.sousbondecommande_idsousbdc_seq'::regclass);


--
-- Name: sousbondecommande idbc; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondecommande ALTER COLUMN idbc SET DEFAULT nextval('public.sousbondecommande_idbc_seq'::regclass);


--
-- Name: sousbondereception idsousbr; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondereception ALTER COLUMN idsousbr SET DEFAULT nextval('public.sousbondereception_idsousbr_seq'::regclass);


--
-- Name: sousbondereception idbr; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondereception ALTER COLUMN idbr SET DEFAULT nextval('public.sousbondereception_idbr_seq'::regclass);


--
-- Name: sousdemande idsousdemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousdemande ALTER COLUMN idsousdemande SET DEFAULT nextval('public.sousdemande_idsousdemande_seq'::regclass);


--
-- Name: sousdemande iddemande; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousdemande ALTER COLUMN iddemande SET DEFAULT nextval('public.sousdemande_iddemande_seq'::regclass);


--
-- Name: sousproforma idsousproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousproforma ALTER COLUMN idsousproforma SET DEFAULT nextval('public.sousproforma_idsousproforma_seq'::regclass);


--
-- Name: sousproforma idproforma; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousproforma ALTER COLUMN idproforma SET DEFAULT nextval('public.sousproforma_idproforma_seq'::regclass);


--
-- Name: suggestion idsuggestion; Type: DEFAULT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.suggestion ALTER COLUMN idsuggestion SET DEFAULT nextval('public.suggestion_idsuggestion_seq'::regclass);


--
-- Data for Name: bondecommande; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.bondecommande (idbc, idproforma, datebc, etat, idfournisseur, totalht, tva, ttc, datelivraison, lieulivraison, delaipaiement) FROM stdin;
28	17	2022-11-20	1	1	848122	169624.4	1017746.4	2019-02-01		0
29	18	2022-11-20	1	2	556581	111316.2	667897.2	2019-02-01		0
30	17	2022-11-20	1	1	590112	118022.4	708134.4	2019-02-01		0
\.


--
-- Data for Name: bondereception; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.bondereception (idbr, idbc, datereception) FROM stdin;
11	28	2022-11-09
\.


--
-- Data for Name: bondereception_fini; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.bondereception_fini (idbr_fini, idbr) FROM stdin;
\.


--
-- Data for Name: chefdept; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.chefdept (idchef, iddept, nom, login, mdp) FROM stdin;
2	3	compta	compta	compta
3	4	info	info	info
1	1	secure	secure	secure
\.


--
-- Data for Name: dd; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.dd (id) FROM stdin;
\.


--
-- Data for Name: demande; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.demande (iddemande, iddept, intitule, datedemande, etat) FROM stdin;
5	1	Demande	2022-11-20	1
6	1	Achat_12	2022-11-20	0
\.


--
-- Data for Name: demandeproforma; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.demandeproforma (iddemandeproforma, fournisseurid, datedemande, lieulivraison, delaipaiement) FROM stdin;
1	1	2022-11-18	L1	29
2	2	2022-11-18	L1	29
3	3	2022-11-18	L1	29
4	1	2022-11-20		0
5	2	2022-11-20		0
6	3	2022-11-20		0
\.


--
-- Data for Name: demandesatisfait; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.demandesatisfait (iddemandesatisfait, iddemande) FROM stdin;
\.


--
-- Data for Name: demandevalide; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.demandevalide (iddemandesatisfait, iddemande) FROM stdin;
2	5
3	5
4	5
\.


--
-- Data for Name: departement; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.departement (iddept, nomdept) FROM stdin;
1	Secure
4	Info
3	Comptabilite
\.


--
-- Data for Name: dispatchproduit; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.dispatchproduit (iddr, iddept, idsuggestion, quantite, daty) FROM stdin;
34	4	1	5	2022-11-19
35	1	1	10	2022-11-19
36	3	4	10	2022-11-19
37	4	3	14	2022-11-19
38	3	3	6	2022-11-19
39	1	3	23	2022-11-19
\.


--
-- Data for Name: fournisseur; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.fournisseur (idfournisseur, nom, adresse) FROM stdin;
1	F_1	Lot II F1
2	F_2	Lot II F2
3	F_3	Lot II F3
\.


--
-- Data for Name: proforma; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.proforma (idproforma, idfournisseur, iddemandeproforma, reference) FROM stdin;
17	1	4	1
18	2	5	2
\.


--
-- Data for Name: proformademande; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.proformademande (idproformademande, iddemandeproforma, iddemande) FROM stdin;
66	4	5
67	5	5
68	6	5
\.


--
-- Data for Name: respappro; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.respappro (idappro, nom, login, mdp) FROM stdin;
1	admin	admin	admin
\.


--
-- Data for Name: sousbondecommande; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.sousbondecommande (idsousbdc, idbc, designation, rubrique, "quantité", prixunitaire, montant, idsuggestion, qualite) FROM stdin;
34	28	EauVive	u	26	6700	174200	1	
35	28	Cristalline	dd	29	2890	83810	2	
36	28	Masque	a	26	8912	231712	3	
37	28	Akondro	ui	50	7168	358400	9	
38	29	EauVive	u	26	7120	185120	1	
39	29	Cristalline	d	29	12809	371461	2	
40	30	Masque	a	26	8912	231712	3	
41	30	Akondro	ui	50	7168	358400	9	
\.


--
-- Data for Name: sousbondereception; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.sousbondereception (idsousbr, idbr, designation, rubrique, "quantité", "qualité", idsuggestion, daty, observation) FROM stdin;
26	11	EauVive	df	10	Best	1	2019-12-09	Rien A Signaler
\.


--
-- Data for Name: sousdemande; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.sousdemande (idsousdemande, iddemande, quantite, qualite, designation, rubrique, delailivraison, idsuggestion) FROM stdin;
75	5	29	Cuir	Cristalline	Au de qualite	2019-02-01	2
76	5	26	Best	EauVive	Au de qualite	2019-08-09	1
77	5	50	Tsara 	Akondro	1/2 Dh	2019-02-09	9
78	5	26	Best	Masque	KF19	2022-12-20	3
79	6	17	Meilleur	Singe	UU	2022-02-02	5
\.


--
-- Data for Name: sousproforma; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.sousproforma (idsousproforma, idproforma, quantite, rubrique, designation, prixunitaire, qualite, notequalite, idsuggestion, prixnote) FROM stdin;
13	17	26	a	Masque	8912	dasdo	0	3	0
14	17	50	ui	Akondro	7168	1	0	9	0
15	18	26	u	EauVive	7120	82	0	1	0
17	18	28	n	Masque	1569	78	0	3	0
18	18	50	NB	Akondro	1234	8	0	9	0
16	18	29	d	Cristalline	12809	w	6	2	12803
12	17	29	dd	Cristalline	2890	12mm	2	2	2888
11	17	28	u	EauVive	6700	KI	12	1	6688
\.


--
-- Data for Name: suggestion; Type: TABLE DATA; Schema: public; Owner: dina
--

COPY public.suggestion (idsuggestion, nom, codeproduit) FROM stdin;
1	EauVive	PR_
5	Singe	PR_
6	Julian	PR_
7	Morit	PR_
8	Banane	PR_
9	Akondro	PR_
2	Cristalline	PR_
3	Masque	PR_
4	Blouse Mainty	PR_
10	YY	PRYY527
11	Dina	PRDina871
12	Dina	PRDina923
13	Dina	PRDina183
14	Dina	PRDina727
15	uda	PRuda567
16	Jo	PRJo755
17	Jo	PRJo692
18	uda	PRuda107
19	uda	PRuda864
20		PR230
21	din	PRdin621
22	POX	PRPOX548
23	POX	PRPOX240
24	POX	PRPOX439
25	POX	PRPOX109
26	POX	PRPOX697
27	POX	PRPOX770
28	POX	PRPOX201
\.


--
-- Name: bondecommande_idbc_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondecommande_idbc_seq', 30, true);


--
-- Name: bondecommande_idfournisseur_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondecommande_idfournisseur_seq', 21, true);


--
-- Name: bondecommande_idproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondecommande_idproforma_seq', 1, false);


--
-- Name: bondereception_fini_idbr_fini_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondereception_fini_idbr_fini_seq', 1, false);


--
-- Name: bondereception_fini_idbr_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondereception_fini_idbr_seq', 1, false);


--
-- Name: bondereception_idbc_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondereception_idbc_seq', 1, true);


--
-- Name: bondereception_idbr_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.bondereception_idbr_seq', 11, true);


--
-- Name: chefdept_idchef_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.chefdept_idchef_seq', 3, true);


--
-- Name: chefdept_iddept_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.chefdept_iddept_seq', 1, false);


--
-- Name: demande_iddemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demande_iddemande_seq', 6, true);


--
-- Name: demandeproforma_fournisseurid_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandeproforma_fournisseurid_seq', 1, false);


--
-- Name: demandeproforma_iddemandeproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandeproforma_iddemandeproforma_seq', 6, true);


--
-- Name: demandesatisfait_iddemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandesatisfait_iddemande_seq', 1, false);


--
-- Name: demandesatisfait_iddemandesatisfait_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandesatisfait_iddemandesatisfait_seq', 8, true);


--
-- Name: demandevalide_iddemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandevalide_iddemande_seq', 1, false);


--
-- Name: demandevalide_iddemandesatisfait_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.demandevalide_iddemandesatisfait_seq', 4, true);


--
-- Name: departement_iddept_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.departement_iddept_seq', 4, true);


--
-- Name: dispatchproduit_iddept_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.dispatchproduit_iddept_seq', 1, false);


--
-- Name: dispatchproduit_iddr_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.dispatchproduit_iddr_seq', 39, true);


--
-- Name: dispatchproduit_idsuggestion_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.dispatchproduit_idsuggestion_seq', 1, false);


--
-- Name: fournisseur_idfournisseur_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.fournisseur_idfournisseur_seq', 3, true);


--
-- Name: proforma_iddemandeproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proforma_iddemandeproforma_seq', 1, false);


--
-- Name: proforma_idfournisseur_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proforma_idfournisseur_seq', 1, false);


--
-- Name: proforma_idproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proforma_idproforma_seq', 18, true);


--
-- Name: proforma_reference_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proforma_reference_seq', 3, true);


--
-- Name: proformademande_iddemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proformademande_iddemande_seq', 1, false);


--
-- Name: proformademande_iddemandeproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proformademande_iddemandeproforma_seq', 1, false);


--
-- Name: proformademande_idproformademande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.proformademande_idproformademande_seq', 68, true);


--
-- Name: respappro_idappro_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.respappro_idappro_seq', 1, true);


--
-- Name: sousbondecommande_idbc_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousbondecommande_idbc_seq', 1, false);


--
-- Name: sousbondecommande_idsousbdc_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousbondecommande_idsousbdc_seq', 41, true);


--
-- Name: sousbondereception_idbr_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousbondereception_idbr_seq', 1, false);


--
-- Name: sousbondereception_idsousbr_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousbondereception_idsousbr_seq', 26, true);


--
-- Name: sousdemande_iddemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousdemande_iddemande_seq', 1, false);


--
-- Name: sousdemande_idsousdemande_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousdemande_idsousdemande_seq', 79, true);


--
-- Name: sousproforma_idproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousproforma_idproforma_seq', 1, false);


--
-- Name: sousproforma_idsousproforma_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.sousproforma_idsousproforma_seq', 18, true);


--
-- Name: suggestion_idsuggestion_seq; Type: SEQUENCE SET; Schema: public; Owner: dina
--

SELECT pg_catalog.setval('public.suggestion_idsuggestion_seq', 28, true);


--
-- Name: bondecommande bondecommande_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_pkey PRIMARY KEY (idbc);


--
-- Name: bondereception_fini bondereception_fini_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception_fini
    ADD CONSTRAINT bondereception_fini_pkey PRIMARY KEY (idbr_fini);


--
-- Name: bondereception bondereception_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception
    ADD CONSTRAINT bondereception_pkey PRIMARY KEY (idbr);


--
-- Name: chefdept chefdept_login_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.chefdept
    ADD CONSTRAINT chefdept_login_key UNIQUE (login);


--
-- Name: chefdept chefdept_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.chefdept
    ADD CONSTRAINT chefdept_pkey PRIMARY KEY (idchef);


--
-- Name: demande demande_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_pkey PRIMARY KEY (iddemande);


--
-- Name: demandeproforma demandeproforma_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandeproforma
    ADD CONSTRAINT demandeproforma_pkey PRIMARY KEY (iddemandeproforma);


--
-- Name: demandesatisfait demandesatisfait_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandesatisfait
    ADD CONSTRAINT demandesatisfait_pkey PRIMARY KEY (iddemandesatisfait);


--
-- Name: demandevalide demandevalide_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandevalide
    ADD CONSTRAINT demandevalide_pkey PRIMARY KEY (iddemandesatisfait);


--
-- Name: departement departement_nomdept_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_nomdept_key UNIQUE (nomdept);


--
-- Name: departement departement_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_pkey PRIMARY KEY (iddept);


--
-- Name: dispatchproduit dispatchproduit_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit
    ADD CONSTRAINT dispatchproduit_pkey PRIMARY KEY (iddr);


--
-- Name: fournisseur fournisseur_adresse_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_adresse_key UNIQUE (adresse);


--
-- Name: fournisseur fournisseur_nom_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_nom_key UNIQUE (nom);


--
-- Name: fournisseur fournisseur_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (idfournisseur);


--
-- Name: proforma proforma_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma
    ADD CONSTRAINT proforma_pkey PRIMARY KEY (idproforma);


--
-- Name: proforma proforma_reference_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma
    ADD CONSTRAINT proforma_reference_key UNIQUE (reference);


--
-- Name: proformademande proformademande_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande
    ADD CONSTRAINT proformademande_pkey PRIMARY KEY (idproformademande);


--
-- Name: respappro respappro_login_key; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.respappro
    ADD CONSTRAINT respappro_login_key UNIQUE (login);


--
-- Name: respappro respappro_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.respappro
    ADD CONSTRAINT respappro_pkey PRIMARY KEY (idappro);


--
-- Name: sousbondecommande sousbondecommande_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondecommande
    ADD CONSTRAINT sousbondecommande_pkey PRIMARY KEY (idsousbdc);


--
-- Name: sousbondereception sousbondereception_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondereception
    ADD CONSTRAINT sousbondereception_pkey PRIMARY KEY (idsousbr);


--
-- Name: sousdemande sousdemande_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousdemande
    ADD CONSTRAINT sousdemande_pkey PRIMARY KEY (idsousdemande);


--
-- Name: sousproforma sousproforma_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousproforma
    ADD CONSTRAINT sousproforma_pkey PRIMARY KEY (idsousproforma);


--
-- Name: suggestion suggestion_pkey; Type: CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.suggestion
    ADD CONSTRAINT suggestion_pkey PRIMARY KEY (idsuggestion);


--
-- Name: bondecommande bondecommande_idproforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_idproforma_fkey FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: bondecommande bondecommande_idproforma_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_idproforma_fkey1 FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: bondecommande bondecommande_idproforma_fkey2; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_idproforma_fkey2 FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: bondecommande bondecommande_idproforma_fkey3; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_idproforma_fkey3 FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: bondecommande bondecommande_idproforma_fkey4; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondecommande
    ADD CONSTRAINT bondecommande_idproforma_fkey4 FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: bondereception_fini bondereception_fini_idbr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception_fini
    ADD CONSTRAINT bondereception_fini_idbr_fkey FOREIGN KEY (idbr) REFERENCES public.bondereception(idbr);


--
-- Name: bondereception bondereception_idbc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.bondereception
    ADD CONSTRAINT bondereception_idbc_fkey FOREIGN KEY (idbc) REFERENCES public.bondecommande(idbc);


--
-- Name: chefdept chefdept_iddept_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.chefdept
    ADD CONSTRAINT chefdept_iddept_fkey FOREIGN KEY (iddept) REFERENCES public.departement(iddept);


--
-- Name: demande demande_iddept_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demande
    ADD CONSTRAINT demande_iddept_fkey FOREIGN KEY (iddept) REFERENCES public.departement(iddept);


--
-- Name: demandeproforma demandeproforma_fournisseurid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandeproforma
    ADD CONSTRAINT demandeproforma_fournisseurid_fkey FOREIGN KEY (fournisseurid) REFERENCES public.fournisseur(idfournisseur);


--
-- Name: demandesatisfait demandesatisfait_iddemande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandesatisfait
    ADD CONSTRAINT demandesatisfait_iddemande_fkey FOREIGN KEY (iddemande) REFERENCES public.demande(iddemande);


--
-- Name: demandevalide demandevalide_iddemande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.demandevalide
    ADD CONSTRAINT demandevalide_iddemande_fkey FOREIGN KEY (iddemande) REFERENCES public.demande(iddemande);


--
-- Name: dispatchproduit dispatchproduit_iddept_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit
    ADD CONSTRAINT dispatchproduit_iddept_fkey FOREIGN KEY (iddept) REFERENCES public.departement(iddept);


--
-- Name: dispatchproduit dispatchproduit_idsuggestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.dispatchproduit
    ADD CONSTRAINT dispatchproduit_idsuggestion_fkey FOREIGN KEY (idsuggestion) REFERENCES public.suggestion(idsuggestion);


--
-- Name: proforma proforma_iddemandeproforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma
    ADD CONSTRAINT proforma_iddemandeproforma_fkey FOREIGN KEY (iddemandeproforma) REFERENCES public.demandeproforma(iddemandeproforma);


--
-- Name: proforma proforma_idfournisseur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proforma
    ADD CONSTRAINT proforma_idfournisseur_fkey FOREIGN KEY (idfournisseur) REFERENCES public.fournisseur(idfournisseur);


--
-- Name: proformademande proformademande_iddemande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande
    ADD CONSTRAINT proformademande_iddemande_fkey FOREIGN KEY (iddemande) REFERENCES public.demande(iddemande);


--
-- Name: proformademande proformademande_iddemandeproforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.proformademande
    ADD CONSTRAINT proformademande_iddemandeproforma_fkey FOREIGN KEY (iddemandeproforma) REFERENCES public.demandeproforma(iddemandeproforma);


--
-- Name: sousbondecommande sousbondecommande_idbc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondecommande
    ADD CONSTRAINT sousbondecommande_idbc_fkey FOREIGN KEY (idbc) REFERENCES public.bondecommande(idbc);


--
-- Name: sousbondecommande sousbondecommande_idsuggestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondecommande
    ADD CONSTRAINT sousbondecommande_idsuggestion_fkey FOREIGN KEY (idsuggestion) REFERENCES public.suggestion(idsuggestion);


--
-- Name: sousbondereception sousbondereception_idbr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondereception
    ADD CONSTRAINT sousbondereception_idbr_fkey FOREIGN KEY (idbr) REFERENCES public.bondereception(idbr);


--
-- Name: sousbondereception sousbondereception_idsuggestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousbondereception
    ADD CONSTRAINT sousbondereception_idsuggestion_fkey FOREIGN KEY (idsuggestion) REFERENCES public.suggestion(idsuggestion);


--
-- Name: sousdemande sousdemande_iddemande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousdemande
    ADD CONSTRAINT sousdemande_iddemande_fkey FOREIGN KEY (iddemande) REFERENCES public.demande(iddemande);


--
-- Name: sousdemande sousdemande_idsuggestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousdemande
    ADD CONSTRAINT sousdemande_idsuggestion_fkey FOREIGN KEY (idsuggestion) REFERENCES public.suggestion(idsuggestion);


--
-- Name: sousproforma sousproforma_idproforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousproforma
    ADD CONSTRAINT sousproforma_idproforma_fkey FOREIGN KEY (idproforma) REFERENCES public.proforma(idproforma);


--
-- Name: sousproforma sousproforma_idsuggestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dina
--

ALTER TABLE ONLY public.sousproforma
    ADD CONSTRAINT sousproforma_idsuggestion_fkey FOREIGN KEY (idsuggestion) REFERENCES public.suggestion(idsuggestion);


--
-- PostgreSQL database dump complete
--


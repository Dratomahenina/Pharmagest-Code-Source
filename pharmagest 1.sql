--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-03 03:00:33

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

--
-- TOC entry 240 (class 1255 OID 16712)
-- Name: update_login_historique(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_login_historique() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM login_historique WHERE id_utilisateur = NEW.id_utilisateur) THEN
        UPDATE login_historique
        SET date_heure = CURRENT_TIMESTAMP,
            nom_utilisateur = NEW.nom_utilisateur,
            role = NEW.role
        WHERE id_utilisateur = NEW.id_utilisateur;
    ELSE
        INSERT INTO login_historique (id_utilisateur, nom_utilisateur, role, date_heure)
        VALUES (NEW.id_utilisateur, NEW.nom_utilisateur, NEW.role, CURRENT_TIMESTAMP);
    END IF;
    RETURN NULL; -- Changement ici
END;
$$;


ALTER FUNCTION public.update_login_historique() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16890)
-- Name: approvisionnement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.approvisionnement (
    id_approvisionnement integer NOT NULL,
    id_medicament integer,
    id_fournisseur integer,
    quantite_commandee integer NOT NULL,
    date_approvisionnement date DEFAULT CURRENT_DATE,
    statut character varying(20) DEFAULT 'en attente'::character varying,
    prix_fournisseur numeric(10,2),
    quantite_recue integer,
    commentaire character varying(255)
);


ALTER TABLE public.approvisionnement OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16889)
-- Name: approvisionnement_id_approvisionnement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.approvisionnement_id_approvisionnement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.approvisionnement_id_approvisionnement_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 229
-- Name: approvisionnement_id_approvisionnement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.approvisionnement_id_approvisionnement_seq OWNED BY public.approvisionnement.id_approvisionnement;


--
-- TOC entry 236 (class 1259 OID 17152)
-- Name: caisse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caisse (
    id_caisse integer NOT NULL,
    date_caisse date,
    montant_initial numeric(10,2),
    total_ventes numeric(10,2),
    total_retraits numeric(10,2),
    montant_final numeric(10,2)
);


ALTER TABLE public.caisse OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17151)
-- Name: caisse_id_caisse_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.caisse_id_caisse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.caisse_id_caisse_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 235
-- Name: caisse_id_caisse_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.caisse_id_caisse_seq OWNED BY public.caisse.id_caisse;


--
-- TOC entry 215 (class 1259 OID 16634)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50) NOT NULL,
    prenom_client character varying(50) NOT NULL,
    date_naissance_client date,
    adresse_client character varying(200),
    telephone_client character varying(20),
    date_creation date DEFAULT CURRENT_DATE,
    statut character varying(20) DEFAULT 'actif'::character varying
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16638)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_client_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 216
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 220 (class 1259 OID 16677)
-- Name: famille; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.famille (
    id_famille integer NOT NULL,
    nom_famille character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);


ALTER TABLE public.famille OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16676)
-- Name: famille_id_famille_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.famille_id_famille_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.famille_id_famille_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 219
-- Name: famille_id_famille_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.famille_id_famille_seq OWNED BY public.famille.id_famille;


--
-- TOC entry 222 (class 1259 OID 16686)
-- Name: forme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forme (
    id_forme integer NOT NULL,
    nom_forme character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);


ALTER TABLE public.forme OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16685)
-- Name: forme_id_forme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forme_id_forme_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forme_id_forme_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 221
-- Name: forme_id_forme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forme_id_forme_seq OWNED BY public.forme.id_forme;


--
-- TOC entry 226 (class 1259 OID 16852)
-- Name: fournisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fournisseur (
    id_fournisseur integer NOT NULL,
    nom_fournisseur character varying(255) NOT NULL,
    email_fournisseur character varying(255) NOT NULL,
    tel_fournisseur character varying(20) NOT NULL,
    adresse_fournisseur character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);


ALTER TABLE public.fournisseur OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16851)
-- Name: fournisseur_id_fournisseur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fournisseur_id_fournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fournisseur_id_fournisseur_seq OWNER TO postgres;

--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 225
-- Name: fournisseur_id_fournisseur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fournisseur_id_fournisseur_seq OWNED BY public.fournisseur.id_fournisseur;


--
-- TOC entry 234 (class 1259 OID 17135)
-- Name: ligne_vente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ligne_vente (
    id_ligne_vente integer NOT NULL,
    id_vente integer,
    id_medicament integer,
    quantite integer,
    prix_unitaire numeric(10,2),
    prix_total numeric(10,2)
);


ALTER TABLE public.ligne_vente OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17134)
-- Name: ligne_vente_id_ligne_vente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ligne_vente_id_ligne_vente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ligne_vente_id_ligne_vente_seq OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 233
-- Name: ligne_vente_id_ligne_vente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ligne_vente_id_ligne_vente_seq OWNED BY public.ligne_vente.id_ligne_vente;


--
-- TOC entry 224 (class 1259 OID 16695)
-- Name: login_historique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_historique (
    id_login integer NOT NULL,
    id_utilisateur integer,
    nom_utilisateur character varying(255),
    role character varying(50),
    date_heure timestamp without time zone
);


ALTER TABLE public.login_historique OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16694)
-- Name: login_historique_id_login_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_historique_id_login_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_historique_id_login_seq OWNER TO postgres;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 223
-- Name: login_historique_id_login_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_historique_id_login_seq OWNED BY public.login_historique.id_login;


--
-- TOC entry 228 (class 1259 OID 16863)
-- Name: medicament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicament (
    id_medicament integer NOT NULL,
    nom_medicament character varying(255) NOT NULL,
    description_medicament text,
    id_fournisseur integer,
    id_famille integer,
    id_forme integer,
    statut character varying(20) DEFAULT 'actif'::character varying,
    quantite_medicament integer,
    prix_vente numeric(10,2),
    prix_fournisseur numeric(10,2)
);


ALTER TABLE public.medicament OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16862)
-- Name: medicament_id_medicament_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicament_id_medicament_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicament_id_medicament_seq OWNER TO postgres;

--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 227
-- Name: medicament_id_medicament_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicament_id_medicament_seq OWNED BY public.medicament.id_medicament;


--
-- TOC entry 217 (class 1259 OID 16645)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id_utilisateur integer NOT NULL,
    nom_utilisateur character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    date_creation date
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16650)
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateurs_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNER TO postgres;

--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 218
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNED BY public.utilisateurs.id_utilisateur;


--
-- TOC entry 232 (class 1259 OID 17123)
-- Name: vente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vente (
    id_vente integer NOT NULL,
    id_client integer,
    type_vente character varying(50),
    montant_total numeric(10,2),
    date_vente date,
    statut character varying(20)
);


ALTER TABLE public.vente OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17158)
-- Name: vente_caisse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vente_caisse (
    id_vente integer NOT NULL,
    id_caisse integer NOT NULL
);


ALTER TABLE public.vente_caisse OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17122)
-- Name: vente_id_vente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vente_id_vente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vente_id_vente_seq OWNER TO postgres;

--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 231
-- Name: vente_id_vente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vente_id_vente_seq OWNED BY public.vente.id_vente;


--
-- TOC entry 239 (class 1259 OID 17316)
-- Name: ventes_payees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventes_payees (
    id_vente_payee integer NOT NULL,
    id_vente integer NOT NULL,
    id_client integer,
    type_vente character varying(50) NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    date_vente date NOT NULL,
    date_paiement date NOT NULL
);


ALTER TABLE public.ventes_payees OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17315)
-- Name: ventes_payees_id_vente_payee_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventes_payees_id_vente_payee_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventes_payees_id_vente_payee_seq OWNER TO postgres;

--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 238
-- Name: ventes_payees_id_vente_payee_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventes_payees_id_vente_payee_seq OWNED BY public.ventes_payees.id_vente_payee;


--
-- TOC entry 4764 (class 2604 OID 16893)
-- Name: approvisionnement id_approvisionnement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvisionnement ALTER COLUMN id_approvisionnement SET DEFAULT nextval('public.approvisionnement_id_approvisionnement_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 17155)
-- Name: caisse id_caisse; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caisse ALTER COLUMN id_caisse SET DEFAULT nextval('public.caisse_id_caisse_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 16652)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 4752 (class 2604 OID 16680)
-- Name: famille id_famille; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famille ALTER COLUMN id_famille SET DEFAULT nextval('public.famille_id_famille_seq'::regclass);


--
-- TOC entry 4755 (class 2604 OID 16689)
-- Name: forme id_forme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forme ALTER COLUMN id_forme SET DEFAULT nextval('public.forme_id_forme_seq'::regclass);


--
-- TOC entry 4759 (class 2604 OID 16855)
-- Name: fournisseur id_fournisseur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur ALTER COLUMN id_fournisseur SET DEFAULT nextval('public.fournisseur_id_fournisseur_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 17138)
-- Name: ligne_vente id_ligne_vente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligne_vente ALTER COLUMN id_ligne_vente SET DEFAULT nextval('public.ligne_vente_id_ligne_vente_seq'::regclass);


--
-- TOC entry 4758 (class 2604 OID 16698)
-- Name: login_historique id_login; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_historique ALTER COLUMN id_login SET DEFAULT nextval('public.login_historique_id_login_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 16866)
-- Name: medicament id_medicament; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament ALTER COLUMN id_medicament SET DEFAULT nextval('public.medicament_id_medicament_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 16654)
-- Name: utilisateurs id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateurs_id_utilisateur_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 17126)
-- Name: vente id_vente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente ALTER COLUMN id_vente SET DEFAULT nextval('public.vente_id_vente_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 17319)
-- Name: ventes_payees id_vente_payee; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes_payees ALTER COLUMN id_vente_payee SET DEFAULT nextval('public.ventes_payees_id_vente_payee_seq'::regclass);


--
-- TOC entry 4969 (class 0 OID 16890)
-- Dependencies: 230
-- Data for Name: approvisionnement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.approvisionnement (id_approvisionnement, id_medicament, id_fournisseur, quantite_commandee, date_approvisionnement, statut, prix_fournisseur, quantite_recue, commentaire) FROM stdin;
10	4	4	20	2024-04-27	Reçu	\N	\N	Maalox
11	11	7	25	2024-04-23	Reçu	150.00	\N	25
12	11	7	15	2024-04-24	Reçu	140.00	\N	test
14	11	7	15	2024-04-25	Reçu	140.00	\N	test1
15	11	7	5	2024-04-28	Reçu	140.00	\N	test
16	11	7	55	2024-05-03	Reçu	140.00	\N	test
\.


--
-- TOC entry 4975 (class 0 OID 17152)
-- Dependencies: 236
-- Data for Name: caisse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caisse (id_caisse, date_caisse, montant_initial, total_ventes, total_retraits, montant_final) FROM stdin;
\.


--
-- TOC entry 4954 (class 0 OID 16634)
-- Dependencies: 215
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id_client, nom_client, prenom_client, date_naissance_client, adresse_client, telephone_client, date_creation, statut) FROM stdin;
1	Dupont	Jean	1985-03-22	12 rue de la Paix, Paris	0123456789	2024-03-18	actif
2	Durand	Marie	1990-07-15	24 avenue des Champs-Élysées, Paris	0987654321	2024-03-18	actif
4	Lefebvre	Sophie	1995-09-18	3 rue du Faubourg Saint-Honoré, Paris	0654321987	2024-03-18	actif
3	Martin	Pierre	1978-12-05	8 boulevard du Montparnasse, Paris	0112233445	2024-03-18	actif
5	Leroy	Antoine	1982-06-30	17 rue de Rivoli, Paris	0987123456	2024-03-18	actif
8	Raforce	Elyse	1999-05-08	Albion	87654321	2024-05-02	actif
12	test	test	1999-05-08	test	87654321	2024-05-02	actif
\.


--
-- TOC entry 4959 (class 0 OID 16677)
-- Dependencies: 220
-- Data for Name: famille; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.famille (id_famille, nom_famille, statut, date_creation) FROM stdin;
1	Allergologie	actif	2024-04-04
2	Anesthésie réanimation	actif	2024-04-04
3	Antalgiques	actif	2024-04-04
4	Anti-inflammatoires	actif	2024-04-04
5	Cancérologie et hématologie	actif	2024-04-04
6	Cardiologie et angéiologie	actif	2024-04-04
7	Contraception et interruption de grossesse	actif	2024-04-04
8	Dermatologie	actif	2024-04-04
9	Endocrinologie	actif	2024-04-04
10	Gastro-Entéro-Hépatologie	actif	2024-04-04
11	Gynécologie	actif	2024-04-04
12	Hémostase et sang	actif	2024-04-04
13	Immunologie	actif	2024-04-04
14	Infectiologie - Parasitologie	actif	2024-04-04
15	Métabolisme et nutrition	actif	2024-04-04
16	Neurologie-psychiatrie	actif	2024-04-04
17	Ophtalmologie	actif	2024-04-04
18	Oto-rhino-laryngologie	actif	2024-04-04
19	Pneumologie	actif	2024-04-04
20	Produits diagnostiques ou autres produits thérapeutiques	actif	2024-04-04
21	Rhumatologie	actif	2024-04-04
22	Sang et dérivés	actif	2024-04-04
23	Souches Homéopathiques	actif	2024-04-04
24	Stomatologie	actif	2024-04-04
25	Toxicologie	actif	2024-04-04
26	Urologie néphrologie	actif	2024-04-04
\.


--
-- TOC entry 4961 (class 0 OID 16686)
-- Dependencies: 222
-- Data for Name: forme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forme (id_forme, nom_forme, statut, date_creation) FROM stdin;
1	BAIN DE BOUCHE	actif	2024-04-04
2	GOMME	actif	2024-04-04
3	CAPSULE	actif	2024-04-04
4	LOTION	actif	2024-04-04
5	COLLYRE	actif	2024-04-04
6	COMPRIMÉ	actif	2024-04-04
7	PANSEMENT	actif	2024-04-04
8	SHAMPOOING	actif	2024-04-04
9	CRÈME	actif	2024-04-04
10	SIROP	actif	2024-04-04
11	GÉLULE	actif	2024-04-04
12	SUPPOSITOIRE	actif	2024-04-04
\.


--
-- TOC entry 4965 (class 0 OID 16852)
-- Dependencies: 226
-- Data for Name: fournisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fournisseur (id_fournisseur, nom_fournisseur, email_fournisseur, tel_fournisseur, adresse_fournisseur, statut, date_creation) FROM stdin;
2	MediSupply	info@medisupply.com	0987654321	24 Avenue des Remèdes, 69000 Lyon	actif	2024-04-12
3	PharmaCentral	commandes@pharmacentral.com	0112233445	36 Boulevard des Pilules, 13000 Marseille	actif	2024-04-12
4	MedicaPlus	contact@medicaplus.com	0566778899	48 Rue des Comprimés, 31000 Toulouse	actif	2024-04-12
5	PharmaDistri	info@pharmadistri.com	0987123456	60 Avenue des Gélules, 67000 Strasbourg	actif	2024-04-12
6	PharmaPro	commandes@pharmapro.com	0123789456	72 Boulevard des Sirops, 44000 Nantes	actif	2024-04-12
7	MediPharm	contact@medipharm.com	0987321654	84 Rue des Ampoules, 59000 Lille	actif	2024-04-12
8	PharmaLine	info@pharmaline.com	0112233445	96 Avenue des Pommades, 33000 Bordeaux	actif	2024-04-12
9	MedicaService	commandes@medicaservice.com	0566778899	108 Rue des Sprays, 06000 Nice	actif	2024-04-12
10	PharmaHealth	contact@pharmahealth.com	0987123456	120 Boulevard des Vitamines, 35000 Rennes	actif	2024-04-12
1	Pharma Express	contact@pharmaexpress.com	0123456789	12 Rue des Médicaments, 75000 Paris	actif	2024-04-12
\.


--
-- TOC entry 4973 (class 0 OID 17135)
-- Dependencies: 234
-- Data for Name: ligne_vente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ligne_vente (id_ligne_vente, id_vente, id_medicament, quantite, prix_unitaire, prix_total) FROM stdin;
1	1	7	2	100.00	200.00
2	2	7	3	100.00	300.00
3	3	11	10	180.00	1800.00
4	3	8	5	150.00	750.00
5	4	11	5	180.00	900.00
6	4	8	2	150.00	300.00
7	5	8	2	150.00	300.00
8	6	8	1	150.00	150.00
9	7	11	20	180.00	3600.00
\.


--
-- TOC entry 4963 (class 0 OID 16695)
-- Dependencies: 224
-- Data for Name: login_historique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_historique (id_login, id_utilisateur, nom_utilisateur, role, date_heure) FROM stdin;
6	2	loic	caissier	2024-04-10 11:57:42.43989
5	1	kim	admin	2024-05-03 02:58:32.721808
236	45	test	admin	2024-05-01 23:30:18.408543
\.


--
-- TOC entry 4967 (class 0 OID 16863)
-- Dependencies: 228
-- Data for Name: medicament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicament (id_medicament, nom_medicament, description_medicament, id_fournisseur, id_famille, id_forme, statut, quantite_medicament, prix_vente, prix_fournisseur) FROM stdin;
6	Smecta	Pansement digestif	1	5	6	actif	40	60.00	40.00
7	Ventoline	Bronchodilatateur	2	6	7	actif	40	100.00	70.00
8	Vogalene	Antiémétique	3	7	8	actif	40	150.00	100.00
11	test	test test	7	14	2	En cours	25	180.00	140.00
5	Levothyrox	Hormone thyroïdienne de synthèse	5	4	5	actif	30	200.00	150.00
2	Aspirin	Antidouleur, antipyrétique et antiagrégant plaquettaire	2	1	2	actif	10	75.00	50.00
1	Doliprane	Antidouleur et antipyrétique	1	1	1	actif	50	150.00	100.00
10	Efferalgan	Antidouleur et antipyrétique	5	1	10	actif	10	120.00	90.00
4	Maalox	Antiacide et anti-ulcéreux	4	3	4	actif	20	90.00	0.00
3	Spasfon	Antispasmodique	3	2	3	actif	40	120.00	80.00
9	Kardegic	Antiagrégant plaquettaire	4	1	9	actif	30	80.00	60.00
\.


--
-- TOC entry 4956 (class 0 OID 16645)
-- Dependencies: 217
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id_utilisateur, nom_utilisateur, mot_de_passe, role, date_creation) FROM stdin;
3	andi	andi	vendeur	\N
2	loic	loic	caissier	\N
1	kim	kim	admin	\N
45	test	test	admin	\N
\.


--
-- TOC entry 4971 (class 0 OID 17123)
-- Dependencies: 232
-- Data for Name: vente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente (id_vente, id_client, type_vente, montant_total, date_vente, statut) FROM stdin;
1	1	Avec Ordonnance	200.00	2024-05-02	En attente
4	12	Avec Ordonnance	1200.00	2024-05-02	Payée
6	\N	Sans Ordonnance	150.00	2024-05-03	En attente
3	2	Sans Ordonnance	2550.00	2024-05-02	Payée
7	\N	Sans Ordonnance	3600.00	2024-05-03	En attente
2	1	Avec Ordonnance	300.00	2024-05-02	Payée
5	\N	Sans Ordonnance	300.00	2024-05-03	Payée
\.


--
-- TOC entry 4976 (class 0 OID 17158)
-- Dependencies: 237
-- Data for Name: vente_caisse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente_caisse (id_vente, id_caisse) FROM stdin;
\.


--
-- TOC entry 4978 (class 0 OID 17316)
-- Dependencies: 239
-- Data for Name: ventes_payees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventes_payees (id_vente_payee, id_vente, id_client, type_vente, montant_total, date_vente, date_paiement) FROM stdin;
1	5	0	Sans Ordonnance	300.00	2024-05-03	2024-05-03
\.


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 229
-- Name: approvisionnement_id_approvisionnement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.approvisionnement_id_approvisionnement_seq', 16, true);


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 235
-- Name: caisse_id_caisse_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caisse_id_caisse_seq', 1, false);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 216
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_client_seq', 12, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 219
-- Name: famille_id_famille_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.famille_id_famille_seq', 27, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 221
-- Name: forme_id_forme_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forme_id_forme_seq', 12, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 225
-- Name: fournisseur_id_fournisseur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fournisseur_id_fournisseur_seq', 10, true);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 233
-- Name: ligne_vente_id_ligne_vente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ligne_vente_id_ligne_vente_seq', 9, true);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 223
-- Name: login_historique_id_login_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_historique_id_login_seq', 292, true);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 227
-- Name: medicament_id_medicament_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicament_id_medicament_seq', 11, true);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 218
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateurs_id_utilisateur_seq', 45, true);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 231
-- Name: vente_id_vente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vente_id_vente_seq', 7, true);


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 238
-- Name: ventes_payees_id_vente_payee_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventes_payees_id_vente_payee_seq', 1, true);


--
-- TOC entry 4788 (class 2606 OID 16897)
-- Name: approvisionnement approvisionnement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_pkey PRIMARY KEY (id_approvisionnement);


--
-- TOC entry 4794 (class 2606 OID 17157)
-- Name: caisse caisse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caisse
    ADD CONSTRAINT caisse_pkey PRIMARY KEY (id_caisse);


--
-- TOC entry 4772 (class 2606 OID 16658)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 4776 (class 2606 OID 16684)
-- Name: famille famille_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famille
    ADD CONSTRAINT famille_pkey PRIMARY KEY (id_famille);


--
-- TOC entry 4778 (class 2606 OID 16693)
-- Name: forme forme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forme
    ADD CONSTRAINT forme_pkey PRIMARY KEY (id_forme);


--
-- TOC entry 4784 (class 2606 OID 16861)
-- Name: fournisseur fournisseur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id_fournisseur);


--
-- TOC entry 4792 (class 2606 OID 17140)
-- Name: ligne_vente ligne_vente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_pkey PRIMARY KEY (id_ligne_vente);


--
-- TOC entry 4780 (class 2606 OID 16720)
-- Name: login_historique login_historique_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- TOC entry 4782 (class 2606 OID 16700)
-- Name: login_historique login_historique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_pkey PRIMARY KEY (id_login);


--
-- TOC entry 4786 (class 2606 OID 16871)
-- Name: medicament medicament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id_medicament);


--
-- TOC entry 4774 (class 2606 OID 16662)
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id_utilisateur);


--
-- TOC entry 4796 (class 2606 OID 17162)
-- Name: vente_caisse vente_caisse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_caisse
    ADD CONSTRAINT vente_caisse_pkey PRIMARY KEY (id_vente, id_caisse);


--
-- TOC entry 4790 (class 2606 OID 17128)
-- Name: vente vente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id_vente);


--
-- TOC entry 4798 (class 2606 OID 17321)
-- Name: ventes_payees ventes_payees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes_payees
    ADD CONSTRAINT ventes_payees_pkey PRIMARY KEY (id_vente_payee);


--
-- TOC entry 4810 (class 2620 OID 16714)
-- Name: utilisateurs update_login_historique; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_login_historique AFTER INSERT OR UPDATE ON public.utilisateurs FOR EACH ROW EXECUTE FUNCTION public.update_login_historique();


--
-- TOC entry 4803 (class 2606 OID 16903)
-- Name: approvisionnement approvisionnement_id_fournisseur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);


--
-- TOC entry 4804 (class 2606 OID 16898)
-- Name: approvisionnement approvisionnement_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);


--
-- TOC entry 4806 (class 2606 OID 17146)
-- Name: ligne_vente ligne_vente_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);


--
-- TOC entry 4807 (class 2606 OID 17141)
-- Name: ligne_vente ligne_vente_id_vente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ligne_vente
    ADD CONSTRAINT ligne_vente_id_vente_fkey FOREIGN KEY (id_vente) REFERENCES public.vente(id_vente);


--
-- TOC entry 4799 (class 2606 OID 16701)
-- Name: login_historique login_historique_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateurs(id_utilisateur);


--
-- TOC entry 4800 (class 2606 OID 16877)
-- Name: medicament medicament_id_famille_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_famille_fkey FOREIGN KEY (id_famille) REFERENCES public.famille(id_famille);


--
-- TOC entry 4801 (class 2606 OID 16882)
-- Name: medicament medicament_id_forme_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_forme_fkey FOREIGN KEY (id_forme) REFERENCES public.forme(id_forme);


--
-- TOC entry 4802 (class 2606 OID 16872)
-- Name: medicament medicament_id_fournisseur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);


--
-- TOC entry 4808 (class 2606 OID 17168)
-- Name: vente_caisse vente_caisse_id_caisse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_caisse
    ADD CONSTRAINT vente_caisse_id_caisse_fkey FOREIGN KEY (id_caisse) REFERENCES public.caisse(id_caisse);


--
-- TOC entry 4809 (class 2606 OID 17163)
-- Name: vente_caisse vente_caisse_id_vente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_caisse
    ADD CONSTRAINT vente_caisse_id_vente_fkey FOREIGN KEY (id_vente) REFERENCES public.vente(id_vente);


--
-- TOC entry 4805 (class 2606 OID 17129)
-- Name: vente vente_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


-- Completed on 2024-05-03 03:00:33

--
-- PostgreSQL database dump complete
--


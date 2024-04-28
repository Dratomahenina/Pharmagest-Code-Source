PGDMP                      |         
   Pharmagest    16.2    16.2 Y    _           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            `           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            a           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            b           1262    16628 
   Pharmagest    DATABASE        CREATE DATABASE "Pharmagest" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE "Pharmagest";
                postgres    false            �            1255    16712    update_login_historique()    FUNCTION     �  CREATE FUNCTION public.update_login_historique() RETURNS trigger
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
 0   DROP FUNCTION public.update_login_historique();
       public          postgres    false            �            1259    16890    approvisionnement    TABLE     �  CREATE TABLE public.approvisionnement (
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
 %   DROP TABLE public.approvisionnement;
       public         heap    postgres    false            �            1259    16889 *   approvisionnement_id_approvisionnement_seq    SEQUENCE     �   CREATE SEQUENCE public.approvisionnement_id_approvisionnement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.approvisionnement_id_approvisionnement_seq;
       public          postgres    false    230            c           0    0 *   approvisionnement_id_approvisionnement_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public.approvisionnement_id_approvisionnement_seq OWNED BY public.approvisionnement.id_approvisionnement;
          public          postgres    false    229            �            1259    16634    client    TABLE     �  CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50) NOT NULL,
    prenom_client character varying(50) NOT NULL,
    date_naissance_client date,
    adresse_client character varying(200),
    telephone_client character varying(20),
    date_creation date DEFAULT CURRENT_DATE,
    statut character varying(20) DEFAULT 'actif'::character varying
);
    DROP TABLE public.client;
       public         heap    postgres    false            �            1259    16638    client_id_client_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.client_id_client_seq;
       public          postgres    false    215            d           0    0    client_id_client_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;
          public          postgres    false    216            �            1259    16677    famille    TABLE     �   CREATE TABLE public.famille (
    id_famille integer NOT NULL,
    nom_famille character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.famille;
       public         heap    postgres    false            �            1259    16676    famille_id_famille_seq    SEQUENCE     �   CREATE SEQUENCE public.famille_id_famille_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.famille_id_famille_seq;
       public          postgres    false    220            e           0    0    famille_id_famille_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.famille_id_famille_seq OWNED BY public.famille.id_famille;
          public          postgres    false    219            �            1259    16686    forme    TABLE     �   CREATE TABLE public.forme (
    id_forme integer NOT NULL,
    nom_forme character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.forme;
       public         heap    postgres    false            �            1259    16685    forme_id_forme_seq    SEQUENCE     �   CREATE SEQUENCE public.forme_id_forme_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.forme_id_forme_seq;
       public          postgres    false    222            f           0    0    forme_id_forme_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.forme_id_forme_seq OWNED BY public.forme.id_forme;
          public          postgres    false    221            �            1259    16852    fournisseur    TABLE     �  CREATE TABLE public.fournisseur (
    id_fournisseur integer NOT NULL,
    nom_fournisseur character varying(255) NOT NULL,
    email_fournisseur character varying(255) NOT NULL,
    tel_fournisseur character varying(20) NOT NULL,
    adresse_fournisseur character varying(255) NOT NULL,
    statut character varying(20) DEFAULT 'actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE
);
    DROP TABLE public.fournisseur;
       public         heap    postgres    false            �            1259    16851    fournisseur_id_fournisseur_seq    SEQUENCE     �   CREATE SEQUENCE public.fournisseur_id_fournisseur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.fournisseur_id_fournisseur_seq;
       public          postgres    false    226            g           0    0    fournisseur_id_fournisseur_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.fournisseur_id_fournisseur_seq OWNED BY public.fournisseur.id_fournisseur;
          public          postgres    false    225            �            1259    16695    login_historique    TABLE     �   CREATE TABLE public.login_historique (
    id_login integer NOT NULL,
    id_utilisateur integer,
    nom_utilisateur character varying(255),
    role character varying(50),
    date_heure timestamp without time zone
);
 $   DROP TABLE public.login_historique;
       public         heap    postgres    false            �            1259    16694    login_historique_id_login_seq    SEQUENCE     �   CREATE SEQUENCE public.login_historique_id_login_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.login_historique_id_login_seq;
       public          postgres    false    224            h           0    0    login_historique_id_login_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.login_historique_id_login_seq OWNED BY public.login_historique.id_login;
          public          postgres    false    223            �            1259    16863 
   medicament    TABLE     �  CREATE TABLE public.medicament (
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
    DROP TABLE public.medicament;
       public         heap    postgres    false            �            1259    16862    medicament_id_medicament_seq    SEQUENCE     �   CREATE SEQUENCE public.medicament_id_medicament_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.medicament_id_medicament_seq;
       public          postgres    false    228            i           0    0    medicament_id_medicament_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.medicament_id_medicament_seq OWNED BY public.medicament.id_medicament;
          public          postgres    false    227            �            1259    16645    utilisateurs    TABLE     �   CREATE TABLE public.utilisateurs (
    id_utilisateur integer NOT NULL,
    nom_utilisateur character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role character varying(50) NOT NULL
);
     DROP TABLE public.utilisateurs;
       public         heap    postgres    false            �            1259    16650    utilisateurs_id_utilisateur_seq    SEQUENCE     �   CREATE SEQUENCE public.utilisateurs_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.utilisateurs_id_utilisateur_seq;
       public          postgres    false    217            j           0    0    utilisateurs_id_utilisateur_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNED BY public.utilisateurs.id_utilisateur;
          public          postgres    false    218            �            1259    16938    vente    TABLE       CREATE TABLE public.vente (
    id_vente integer NOT NULL,
    id_client integer,
    date_vente date,
    type_vente character varying(20),
    statut character varying(20),
    montant_total numeric(10,2),
    remise numeric(10,2),
    date_paiement timestamp without time zone
);
    DROP TABLE public.vente;
       public         heap    postgres    false            �            1259    16937    vente_id_vente_seq    SEQUENCE     �   CREATE SEQUENCE public.vente_id_vente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.vente_id_vente_seq;
       public          postgres    false    232            k           0    0    vente_id_vente_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.vente_id_vente_seq OWNED BY public.vente.id_vente;
          public          postgres    false    231            �            1259    16950    vente_medicament    TABLE     �   CREATE TABLE public.vente_medicament (
    id_vente_medicament integer NOT NULL,
    id_vente integer,
    id_medicament integer,
    quantite integer,
    prix_unitaire numeric(10,2),
    id_client integer,
    type_vente character varying(20)
);
 $   DROP TABLE public.vente_medicament;
       public         heap    postgres    false            �            1259    16949 (   vente_medicament_id_vente_medicament_seq    SEQUENCE     �   CREATE SEQUENCE public.vente_medicament_id_vente_medicament_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.vente_medicament_id_vente_medicament_seq;
       public          postgres    false    234            l           0    0 (   vente_medicament_id_vente_medicament_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.vente_medicament_id_vente_medicament_seq OWNED BY public.vente_medicament.id_vente_medicament;
          public          postgres    false    233            �            1259    16970    vente_payee    TABLE     �   CREATE TABLE public.vente_payee (
    id_vente integer NOT NULL,
    id_client integer,
    date_vente date,
    type_vente character varying(20),
    statut character varying(20),
    montant_total numeric(10,2),
    remise numeric(10,2)
);
    DROP TABLE public.vente_payee;
       public         heap    postgres    false            �           2604    16893 &   approvisionnement id_approvisionnement    DEFAULT     �   ALTER TABLE ONLY public.approvisionnement ALTER COLUMN id_approvisionnement SET DEFAULT nextval('public.approvisionnement_id_approvisionnement_seq'::regclass);
 U   ALTER TABLE public.approvisionnement ALTER COLUMN id_approvisionnement DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    16652    client id_client    DEFAULT     t   ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);
 ?   ALTER TABLE public.client ALTER COLUMN id_client DROP DEFAULT;
       public          postgres    false    216    215            �           2604    16680    famille id_famille    DEFAULT     x   ALTER TABLE ONLY public.famille ALTER COLUMN id_famille SET DEFAULT nextval('public.famille_id_famille_seq'::regclass);
 A   ALTER TABLE public.famille ALTER COLUMN id_famille DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16689    forme id_forme    DEFAULT     p   ALTER TABLE ONLY public.forme ALTER COLUMN id_forme SET DEFAULT nextval('public.forme_id_forme_seq'::regclass);
 =   ALTER TABLE public.forme ALTER COLUMN id_forme DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16855    fournisseur id_fournisseur    DEFAULT     �   ALTER TABLE ONLY public.fournisseur ALTER COLUMN id_fournisseur SET DEFAULT nextval('public.fournisseur_id_fournisseur_seq'::regclass);
 I   ALTER TABLE public.fournisseur ALTER COLUMN id_fournisseur DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    16698    login_historique id_login    DEFAULT     �   ALTER TABLE ONLY public.login_historique ALTER COLUMN id_login SET DEFAULT nextval('public.login_historique_id_login_seq'::regclass);
 H   ALTER TABLE public.login_historique ALTER COLUMN id_login DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16866    medicament id_medicament    DEFAULT     �   ALTER TABLE ONLY public.medicament ALTER COLUMN id_medicament SET DEFAULT nextval('public.medicament_id_medicament_seq'::regclass);
 G   ALTER TABLE public.medicament ALTER COLUMN id_medicament DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    16654    utilisateurs id_utilisateur    DEFAULT     �   ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateurs_id_utilisateur_seq'::regclass);
 J   ALTER TABLE public.utilisateurs ALTER COLUMN id_utilisateur DROP DEFAULT;
       public          postgres    false    218    217            �           2604    16941    vente id_vente    DEFAULT     p   ALTER TABLE ONLY public.vente ALTER COLUMN id_vente SET DEFAULT nextval('public.vente_id_vente_seq'::regclass);
 =   ALTER TABLE public.vente ALTER COLUMN id_vente DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    16953 $   vente_medicament id_vente_medicament    DEFAULT     �   ALTER TABLE ONLY public.vente_medicament ALTER COLUMN id_vente_medicament SET DEFAULT nextval('public.vente_medicament_id_vente_medicament_seq'::regclass);
 S   ALTER TABLE public.vente_medicament ALTER COLUMN id_vente_medicament DROP DEFAULT;
       public          postgres    false    233    234    234            W          0    16890    approvisionnement 
   TABLE DATA           �   COPY public.approvisionnement (id_approvisionnement, id_medicament, id_fournisseur, quantite_commandee, date_approvisionnement, statut, prix_fournisseur, quantite_recue, commentaire) FROM stdin;
    public          postgres    false    230   �v       H          0    16634    client 
   TABLE DATA           �   COPY public.client (id_client, nom_client, prenom_client, date_naissance_client, adresse_client, telephone_client, date_creation, statut) FROM stdin;
    public          postgres    false    215   w       M          0    16677    famille 
   TABLE DATA           Q   COPY public.famille (id_famille, nom_famille, statut, date_creation) FROM stdin;
    public          postgres    false    220   7x       O          0    16686    forme 
   TABLE DATA           K   COPY public.forme (id_forme, nom_forme, statut, date_creation) FROM stdin;
    public          postgres    false    222   �y       S          0    16852    fournisseur 
   TABLE DATA           �   COPY public.fournisseur (id_fournisseur, nom_fournisseur, email_fournisseur, tel_fournisseur, adresse_fournisseur, statut, date_creation) FROM stdin;
    public          postgres    false    226   �z       Q          0    16695    login_historique 
   TABLE DATA           g   COPY public.login_historique (id_login, id_utilisateur, nom_utilisateur, role, date_heure) FROM stdin;
    public          postgres    false    224   v|       U          0    16863 
   medicament 
   TABLE DATA           �   COPY public.medicament (id_medicament, nom_medicament, description_medicament, id_fournisseur, id_famille, id_forme, statut, quantite_medicament, prix_vente, prix_fournisseur) FROM stdin;
    public          postgres    false    228   �|       J          0    16645    utilisateurs 
   TABLE DATA           [   COPY public.utilisateurs (id_utilisateur, nom_utilisateur, mot_de_passe, role) FROM stdin;
    public          postgres    false    217   l~       Y          0    16938    vente 
   TABLE DATA           z   COPY public.vente (id_vente, id_client, date_vente, type_vente, statut, montant_total, remise, date_paiement) FROM stdin;
    public          postgres    false    232   �~       [          0    16950    vente_medicament 
   TABLE DATA           �   COPY public.vente_medicament (id_vente_medicament, id_vente, id_medicament, quantite, prix_unitaire, id_client, type_vente) FROM stdin;
    public          postgres    false    234   �       \          0    16970    vente_payee 
   TABLE DATA           q   COPY public.vente_payee (id_vente, id_client, date_vente, type_vente, statut, montant_total, remise) FROM stdin;
    public          postgres    false    235   5�       m           0    0 *   approvisionnement_id_approvisionnement_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.approvisionnement_id_approvisionnement_seq', 15, true);
          public          postgres    false    229            n           0    0    client_id_client_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.client_id_client_seq', 7, true);
          public          postgres    false    216            o           0    0    famille_id_famille_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.famille_id_famille_seq', 27, true);
          public          postgres    false    219            p           0    0    forme_id_forme_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.forme_id_forme_seq', 12, true);
          public          postgres    false    221            q           0    0    fournisseur_id_fournisseur_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.fournisseur_id_fournisseur_seq', 10, true);
          public          postgres    false    225            r           0    0    login_historique_id_login_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.login_historique_id_login_seq', 195, true);
          public          postgres    false    223            s           0    0    medicament_id_medicament_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.medicament_id_medicament_seq', 11, true);
          public          postgres    false    227            t           0    0    utilisateurs_id_utilisateur_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.utilisateurs_id_utilisateur_seq', 44, true);
          public          postgres    false    218            u           0    0    vente_id_vente_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.vente_id_vente_seq', 27, true);
          public          postgres    false    231            v           0    0 (   vente_medicament_id_vente_medicament_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.vente_medicament_id_vente_medicament_seq', 41, true);
          public          postgres    false    233            �           2606    16897 (   approvisionnement approvisionnement_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_pkey PRIMARY KEY (id_approvisionnement);
 R   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_pkey;
       public            postgres    false    230            �           2606    16658    client client_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    215            �           2606    16684    famille famille_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.famille
    ADD CONSTRAINT famille_pkey PRIMARY KEY (id_famille);
 >   ALTER TABLE ONLY public.famille DROP CONSTRAINT famille_pkey;
       public            postgres    false    220            �           2606    16693    forme forme_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.forme
    ADD CONSTRAINT forme_pkey PRIMARY KEY (id_forme);
 :   ALTER TABLE ONLY public.forme DROP CONSTRAINT forme_pkey;
       public            postgres    false    222            �           2606    16861    fournisseur fournisseur_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id_fournisseur);
 F   ALTER TABLE ONLY public.fournisseur DROP CONSTRAINT fournisseur_pkey;
       public            postgres    false    226            �           2606    16720 4   login_historique login_historique_id_utilisateur_key 
   CONSTRAINT     y   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_key UNIQUE (id_utilisateur);
 ^   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_id_utilisateur_key;
       public            postgres    false    224            �           2606    16700 &   login_historique login_historique_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_pkey PRIMARY KEY (id_login);
 P   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_pkey;
       public            postgres    false    224            �           2606    16871    medicament medicament_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id_medicament);
 D   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_pkey;
       public            postgres    false    228            �           2606    16662    utilisateurs utilisateurs_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id_utilisateur);
 H   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_pkey;
       public            postgres    false    217            �           2606    16955 &   vente_medicament vente_medicament_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.vente_medicament
    ADD CONSTRAINT vente_medicament_pkey PRIMARY KEY (id_vente_medicament);
 P   ALTER TABLE ONLY public.vente_medicament DROP CONSTRAINT vente_medicament_pkey;
       public            postgres    false    234            �           2606    16974    vente_payee vente_payee_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.vente_payee
    ADD CONSTRAINT vente_payee_pkey PRIMARY KEY (id_vente);
 F   ALTER TABLE ONLY public.vente_payee DROP CONSTRAINT vente_payee_pkey;
       public            postgres    false    235            �           2606    16943    vente vente_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id_vente);
 :   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_pkey;
       public            postgres    false    232            �           2620    16714 $   utilisateurs update_login_historique    TRIGGER     �   CREATE TRIGGER update_login_historique AFTER INSERT OR UPDATE ON public.utilisateurs FOR EACH ROW EXECUTE FUNCTION public.update_login_historique();
 =   DROP TRIGGER update_login_historique ON public.utilisateurs;
       public          postgres    false    217    236            �           2606    16903 7   approvisionnement approvisionnement_id_fournisseur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);
 a   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_id_fournisseur_fkey;
       public          postgres    false    226    230    4772            �           2606    16898 6   approvisionnement approvisionnement_id_medicament_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.approvisionnement
    ADD CONSTRAINT approvisionnement_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);
 `   ALTER TABLE ONLY public.approvisionnement DROP CONSTRAINT approvisionnement_id_medicament_fkey;
       public          postgres    false    230    228    4774            �           2606    16701 5   login_historique login_historique_id_utilisateur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.login_historique
    ADD CONSTRAINT login_historique_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateurs(id_utilisateur);
 _   ALTER TABLE ONLY public.login_historique DROP CONSTRAINT login_historique_id_utilisateur_fkey;
       public          postgres    false    4762    224    217            �           2606    16877 %   medicament medicament_id_famille_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_famille_fkey FOREIGN KEY (id_famille) REFERENCES public.famille(id_famille);
 O   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_famille_fkey;
       public          postgres    false    228    220    4764            �           2606    16882 #   medicament medicament_id_forme_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_forme_fkey FOREIGN KEY (id_forme) REFERENCES public.forme(id_forme);
 M   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_forme_fkey;
       public          postgres    false    4766    222    228            �           2606    16872 )   medicament medicament_id_fournisseur_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_id_fournisseur_fkey FOREIGN KEY (id_fournisseur) REFERENCES public.fournisseur(id_fournisseur);
 S   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_id_fournisseur_fkey;
       public          postgres    false    228    226    4772            �           2606    16944    vente vente_id_client_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);
 D   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_id_client_fkey;
       public          postgres    false    232    215    4760            �           2606    16961 4   vente_medicament vente_medicament_id_medicament_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vente_medicament
    ADD CONSTRAINT vente_medicament_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicament(id_medicament);
 ^   ALTER TABLE ONLY public.vente_medicament DROP CONSTRAINT vente_medicament_id_medicament_fkey;
       public          postgres    false    234    228    4774            �           2606    16956 /   vente_medicament vente_medicament_id_vente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vente_medicament
    ADD CONSTRAINT vente_medicament_id_vente_fkey FOREIGN KEY (id_vente) REFERENCES public.vente(id_vente);
 Y   ALTER TABLE ONLY public.vente_medicament DROP CONSTRAINT vente_medicament_id_vente_fkey;
       public          postgres    false    232    234    4778            W   l   x�m�=
�0��9�KKS�%tpv��&8X�y/f�)��>&�4���!5��m��=kB��!�A���#Ktbq�rC.�f��a�����2&sق����E�0      H     x�e�MN�0���> F�M�%!��T�-�)q[K���$�G�(=G.�CDA�fVO�<=C|�=��h�$� q����E�E�y�ot	R�25&���w�Bd-�o`��6s5���\�PG��D�O��%:}��4]l�ڵ�J���k[��=��-�BwZ�ܶ�#r);�G�a�G�C�{�|����/x����\�w���8땡\P���l�v���?6y��ǔ��*\)��kY��1������Y6�-�d��ߕ_�Z��e�5�v[�7�zm      M   �  x�}�Kn�0���S�*,��d�A�E#Nv�L%Z@�C����s�b9	��h����σ�p۶Vjn�&X:�Y�u�������>4���f2��@��ٕ�ۚ�D�Ϗ��1��-v��$s��Е� )e6d}�)n��T�GW���+�cK�OeL�+?�+����[]緯ổ������r)�X�� �߻0��?�C�V,
x8�q(��U������6`[�S��t^kxr�۟�̳
zJg����7��Sh�м;�-����U��ˆP�9�+x��R�}ρsi��y�rtI7�s6&��v�U�ೊ�v�ȓ�3�j=��� �6���M/M�`c`��35�R-���5C�`ϱl4�#w��j�&r���Bn���Q�@fo_ӦF�I���-�w�PS      O   �   x�m�M
�0����������Lch�̐����{a�Ջ��|��o�j�-��⛞f7z�?ޯ'��t��?e`�؁�\� P�&�T��p�������x�����T�	�h#aj=���G*�-�Ăh�%�q�@����D(�ܶJ�/19S;      S   �  x�m�͎�0F��S� 3#���i�.&J���q�3��eC4y��9�b�؈I!;|�w?(��F�k�R��<vp���P���y�RJe��Q�A&���Nv��pq��c����F������{��	ݤ�:׉�{'Z�섆�m��qQ�P���e(�ɳZy�	�J�pIG�V8/U��5��ZT���{�#H���(�2��(��"�MF/��Nu�3`R2b~�7��ߠd���{�brѨ	�9;BS�q��uv�.�I��#g�?fp�k�H�3���3Sr4͋r�t��^9c���H�!t/�������g��@P��̞:k�I[p{)�$񪴼���r�%����C�Ұ�g�)��5�����jyVܾ��e�l��:q�!��-+���w)��0��a��>�x��_�ȏ^��I�o-�L���u��O����A 8;m/�Ѿ�`y�U©������?�      Q   U   x�=�1�  ��}������-.E���7���j��}@H4�����l*QǼdL�px��5��'y 1V�Ī_\#"�޶      U   �  x��Q�J�0}�~E?@���>�(*���Ц�@��4��?r������I�"���I�9g�91l�A�`��h�$�d�B��p2�ي׉�ܺ�襣*$һ�(���h!ɡ�6QYD��Ep׶ܠ���+�7	dC�'N���<�j)������Q��[��=�G�~��
`����ҷ��=�'D���k�|Yq=�z>>!���H�}��'�pl�W>R���-�e���*�q<�7m'C����Z��]�FpE7�c<){��ǋo)�����+�T���ᝨ���Lɱj�Ȗ= w 칲�=c��$A�EK��
�{ձ�L�e����P�%��ܯ%4S��G�"�a���"<�yO�a#:���	�W��o>��M����B      J   9   x�3�L�KɄe�y)��E\F�9���"91��83��ː3;3�Sr3�b���� r�      Y   F  x���=N�0�k�� �̳�t��D�M����8��b���8��\Y߼��3	+V �����}<v��/�4L�Q=_���d���^�v
�
��az[� �Kp)�v��U�Ty�ך�+���Wv$�.0�`ݞ\!`j�= �^o�fMb~��mk��t[d�����o��ro<��!�W�e�;��(�d1B�9(�!��A�E#���Ȫႛ$B�`Z'����f�3��g���d��`i���j�)�=��v�#�3I��Z��.��6ڳ���8��k4���g]��l�$�E&�2u���N�q:�K"op0Z�o�K�      [     x�m�;n1Dk�9�!��>e.�i���5� 9F��f�8�eb<��=YK�3^�*���2P��HqC�͠n�c�ʥT�R�_Z0��;.T�V�	K�LQ;
7O����H�%&��"a�ڽ5��"a��^��{���_?��q\���8ئW���:^8�b4�CҦ�3}�=n�ԓ�ð�Tg��b �q����`�k7��(\+#t����7R��v��S�D��
���":c]����}�q�OL+���N�g,KN����G�۬���x9c�8��      \      x������ � �     
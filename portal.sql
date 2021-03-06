PGDMP                          w            portal    9.6.10    9.6.10 (    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16741    portal    DATABASE     d   CREATE DATABASE portal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE portal;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16742    doctor_user    TABLE     �   CREATE TABLE public.doctor_user (
    doctor_id character varying(256) NOT NULL,
    pass_hash character varying(128),
    pass_salt character varying(128),
    translate_lang_code character varying(10)
);
    DROP TABLE public.doctor_user;
       public         dbadmin    false    3            �            1259    16748    nammin_answer    TABLE     z   CREATE TABLE public.nammin_answer (
    nammin_id integer,
    nammin_q_id integer,
    answer character varying(1024)
);
 !   DROP TABLE public.nammin_answer;
       public         dbadmin    false    3            �            1259    16754    nammin_user    TABLE     �  CREATE TABLE public.nammin_user (
    nammin_id integer NOT NULL,
    nammin_name character varying(256),
    facebook_user_id character varying(64),
    facebook_info text,
    mail_address character varying(256),
    pass_hash character varying(128),
    pass_salt character varying(128),
    translate_lang_code character varying(10),
    last_screening_time timestamp without time zone,
    last_screening_request_time timestamp without time zone
);
    DROP TABLE public.nammin_user;
       public         dbadmin    false    3            �            1259    16760    nammin_user_nammin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.nammin_user_nammin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.nammin_user_nammin_id_seq;
       public       dbadmin    false    187    3            �           0    0    nammin_user_nammin_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.nammin_user_nammin_id_seq OWNED BY public.nammin_user.nammin_id;
            public       dbadmin    false    188            �            1259    16762 	   screening    TABLE     �   CREATE TABLE public.screening (
    screening_id integer NOT NULL,
    nammin_id integer,
    answered_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.screening;
       public         dbadmin    false    3            �            1259    16766    screening_answer    TABLE     �   CREATE TABLE public.screening_answer (
    screening_id integer NOT NULL,
    screening_q_id integer NOT NULL,
    answer character varying(1024)
);
 $   DROP TABLE public.screening_answer;
       public         dbadmin    false    3            �            1259    16772    screening_category    TABLE     w   CREATE TABLE public.screening_category (
    category_id integer NOT NULL,
    category_name character varying(256)
);
 &   DROP TABLE public.screening_category;
       public         dbadmin    false    3            �            1259    16775 "   screening_category_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.screening_category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.screening_category_category_id_seq;
       public       dbadmin    false    3    191            �           0    0 "   screening_category_category_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.screening_category_category_id_seq OWNED BY public.screening_category.category_id;
            public       dbadmin    false    192            �            1259    16777    screening_q    TABLE     b   CREATE TABLE public.screening_q (
    screening_q_id integer NOT NULL,
    category_id integer
);
    DROP TABLE public.screening_q;
       public         dbadmin    false    3            �            1259    16780    screening_q_screening_q_id_seq    SEQUENCE     �   CREATE SEQUENCE public.screening_q_screening_q_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.screening_q_screening_q_id_seq;
       public       dbadmin    false    193    3            �           0    0    screening_q_screening_q_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.screening_q_screening_q_id_seq OWNED BY public.screening_q.screening_q_id;
            public       dbadmin    false    194            �            1259    16782    view_last_screening_answer    VIEW     �  CREATE VIEW public.view_last_screening_answer AS
 SELECT s.nammin_id,
    sq.screening_q_id,
    sa.answer,
    sq.category_id
   FROM ((public.screening s
     LEFT JOIN public.screening_answer sa ON ((s.screening_id = sa.screening_id)))
     LEFT JOIN public.screening_q sq ON ((sa.screening_q_id = sq.screening_q_id)))
  WHERE ((s.nammin_id, sa.screening_q_id, sa.screening_id) IN ( SELECT s_1.nammin_id,
            sa_1.screening_q_id,
            max(s_1.screening_id) AS max_screening_id
           FROM (public.screening s_1
             LEFT JOIN public.screening_answer sa_1 ON ((s_1.screening_id = sa_1.screening_id)))
          WHERE (sa_1.screening_id IS NOT NULL)
          GROUP BY s_1.nammin_id, sa_1.screening_q_id));
 -   DROP VIEW public.view_last_screening_answer;
       public       dbadmin    false    193    189    189    190    190    190    193    3            �            1259    16787    screening_result    VIEW     �  CREATE VIEW public.screening_result AS
 SELECT t.nammin_id,
    t.category_id,
        CASE
            WHEN (t.nocount = 0) THEN '0'::text
            WHEN (t.nocount = 1) THEN '1'::text
            ELSE '2'::text
        END AS result
   FROM ( SELECT v.nammin_id,
            v.category_id,
            sum(v.isno) AS nocount
           FROM ( SELECT view_last_screening_answer.nammin_id,
                    view_last_screening_answer.screening_q_id,
                        CASE
                            WHEN ((view_last_screening_answer.answer)::text = '2'::text) THEN 1
                            ELSE 0
                        END AS isno,
                    view_last_screening_answer.category_id
                   FROM public.view_last_screening_answer
                  WHERE (NOT (view_last_screening_answer.screening_q_id = ANY (ARRAY[5, 6, 11])))) v
          GROUP BY v.nammin_id, v.category_id) t;
 #   DROP VIEW public.screening_result;
       public       dbadmin    false    195    195    195    195    3            �            1259    16792    screening_screening_id_seq    SEQUENCE     �   CREATE SEQUENCE public.screening_screening_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.screening_screening_id_seq;
       public       dbadmin    false    189    3            �           0    0    screening_screening_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.screening_screening_id_seq OWNED BY public.screening.screening_id;
            public       dbadmin    false    197            �           2604    16794    nammin_user nammin_id    DEFAULT     ~   ALTER TABLE ONLY public.nammin_user ALTER COLUMN nammin_id SET DEFAULT nextval('public.nammin_user_nammin_id_seq'::regclass);
 D   ALTER TABLE public.nammin_user ALTER COLUMN nammin_id DROP DEFAULT;
       public       dbadmin    false    188    187            �           2604    16795    screening screening_id    DEFAULT     �   ALTER TABLE ONLY public.screening ALTER COLUMN screening_id SET DEFAULT nextval('public.screening_screening_id_seq'::regclass);
 E   ALTER TABLE public.screening ALTER COLUMN screening_id DROP DEFAULT;
       public       dbadmin    false    197    189            �           2604    16796    screening_category category_id    DEFAULT     �   ALTER TABLE ONLY public.screening_category ALTER COLUMN category_id SET DEFAULT nextval('public.screening_category_category_id_seq'::regclass);
 M   ALTER TABLE public.screening_category ALTER COLUMN category_id DROP DEFAULT;
       public       dbadmin    false    192    191            �           2604    16797    screening_q screening_q_id    DEFAULT     �   ALTER TABLE ONLY public.screening_q ALTER COLUMN screening_q_id SET DEFAULT nextval('public.screening_q_screening_q_id_seq'::regclass);
 I   ALTER TABLE public.screening_q ALTER COLUMN screening_q_id DROP DEFAULT;
       public       dbadmin    false    194    193            w          0    16742    doctor_user 
   TABLE DATA               [   COPY public.doctor_user (doctor_id, pass_hash, pass_salt, translate_lang_code) FROM stdin;
    public       dbadmin    false    185   �0       x          0    16748    nammin_answer 
   TABLE DATA               G   COPY public.nammin_answer (nammin_id, nammin_q_id, answer) FROM stdin;
    public       dbadmin    false    186   �0       y          0    16754    nammin_user 
   TABLE DATA               �   COPY public.nammin_user (nammin_id, nammin_name, facebook_user_id, facebook_info, mail_address, pass_hash, pass_salt, translate_lang_code, last_screening_time, last_screening_request_time) FROM stdin;
    public       dbadmin    false    187   1       �           0    0    nammin_user_nammin_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.nammin_user_nammin_id_seq', 1, false);
            public       dbadmin    false    188            {          0    16762 	   screening 
   TABLE DATA               I   COPY public.screening (screening_id, nammin_id, answered_at) FROM stdin;
    public       dbadmin    false    189   )1       |          0    16766    screening_answer 
   TABLE DATA               P   COPY public.screening_answer (screening_id, screening_q_id, answer) FROM stdin;
    public       dbadmin    false    190   F1       }          0    16772    screening_category 
   TABLE DATA               H   COPY public.screening_category (category_id, category_name) FROM stdin;
    public       dbadmin    false    191   c1       �           0    0 "   screening_category_category_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.screening_category_category_id_seq', 1, false);
            public       dbadmin    false    192                      0    16777    screening_q 
   TABLE DATA               B   COPY public.screening_q (screening_q_id, category_id) FROM stdin;
    public       dbadmin    false    193   �1       �           0    0    screening_q_screening_q_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.screening_q_screening_q_id_seq', 1, false);
            public       dbadmin    false    194            �           0    0    screening_screening_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.screening_screening_id_seq', 1, false);
            public       dbadmin    false    197            w      x������ � �      x      x�3�4��M,�V����+������� C��      y      x������ � �      {      x������ � �      |      x������ � �      }      x������ � �            x������ � �     
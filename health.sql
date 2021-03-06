PGDMP     9                     w            health    9.6.10    9.6.10     o           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            p           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            r           1262    16692    health    DATABASE     d   CREATE DATABASE health WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE health;
             health    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            s           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            t           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16720    blood_test_results    TABLE     �  CREATE TABLE public.blood_test_results (
    resource_key uuid NOT NULL,
    reference_datetime timestamp without time zone NOT NULL,
    item_class_code character varying(100) NOT NULL,
    derived_from character varying(26) NOT NULL,
    json_data jsonb NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 &   DROP TABLE public.blood_test_results;
       public         health    false    3            �            1259    16729    findings    TABLE     �  CREATE TABLE public.findings (
    resource_key uuid NOT NULL,
    reference_datetime timestamp without time zone NOT NULL,
    item_class_code character varying(100) NOT NULL,
    derived_from character varying(26) NOT NULL,
    json_data jsonb NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.findings;
       public         health    false    3            �            1259    16711    inspection_results    TABLE     �  CREATE TABLE public.inspection_results (
    resource_key uuid NOT NULL,
    reference_datetime timestamp without time zone NOT NULL,
    item_class_code character varying(100) NOT NULL,
    derived_from character varying(26) NOT NULL,
    json_data jsonb NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 &   DROP TABLE public.inspection_results;
       public         health    false    3            �            1259    16702    medical_checkup_interviews    TABLE     �  CREATE TABLE public.medical_checkup_interviews (
    resource_key uuid NOT NULL,
    reference_datetime timestamp without time zone NOT NULL,
    item_class_code character varying(100) NOT NULL,
    derived_from character varying(26) NOT NULL,
    json_data jsonb NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 .   DROP TABLE public.medical_checkup_interviews;
       public         health    false    3            �            1259    16693    physical_informations    TABLE     �  CREATE TABLE public.physical_informations (
    resource_key uuid NOT NULL,
    reference_datetime timestamp without time zone NOT NULL,
    item_class_code character varying(100) NOT NULL,
    derived_from character varying(26) NOT NULL,
    json_data jsonb NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 )   DROP TABLE public.physical_informations;
       public         health    false    3            k          0    16720    blood_test_results 
   TABLE DATA               �   COPY public.blood_test_results (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       health    false    188   �'       l          0    16729    findings 
   TABLE DATA               �   COPY public.findings (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       health    false    189   �'       j          0    16711    inspection_results 
   TABLE DATA               �   COPY public.inspection_results (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       health    false    187   (       i          0    16702    medical_checkup_interviews 
   TABLE DATA               �   COPY public.medical_checkup_interviews (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       health    false    186   Z)       h          0    16693    physical_informations 
   TABLE DATA               �   COPY public.physical_informations (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       health    false    185   l*       �           2606    16727 (   blood_test_results pk_blood_test_results 
   CONSTRAINT     �   ALTER TABLE ONLY public.blood_test_results
    ADD CONSTRAINT pk_blood_test_results PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 R   ALTER TABLE ONLY public.blood_test_results DROP CONSTRAINT pk_blood_test_results;
       public         health    false    188    188    188    188    188            �           2606    16736    findings pk_findings 
   CONSTRAINT     �   ALTER TABLE ONLY public.findings
    ADD CONSTRAINT pk_findings PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 >   ALTER TABLE ONLY public.findings DROP CONSTRAINT pk_findings;
       public         health    false    189    189    189    189    189            �           2606    16718 (   inspection_results pk_inspection_results 
   CONSTRAINT     �   ALTER TABLE ONLY public.inspection_results
    ADD CONSTRAINT pk_inspection_results PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 R   ALTER TABLE ONLY public.inspection_results DROP CONSTRAINT pk_inspection_results;
       public         health    false    187    187    187    187    187            �           2606    16709 8   medical_checkup_interviews pk_medical_checkup_interviews 
   CONSTRAINT     �   ALTER TABLE ONLY public.medical_checkup_interviews
    ADD CONSTRAINT pk_medical_checkup_interviews PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 b   ALTER TABLE ONLY public.medical_checkup_interviews DROP CONSTRAINT pk_medical_checkup_interviews;
       public         health    false    186    186    186    186    186            �           2606    16700 .   physical_informations pk_physical_informations 
   CONSTRAINT     �   ALTER TABLE ONLY public.physical_informations
    ADD CONSTRAINT pk_physical_informations PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 X   ALTER TABLE ONLY public.physical_informations DROP CONSTRAINT pk_physical_informations;
       public         health    false    185    185    185    185    185            �           1259    16728    idx_blood_test_results_1    INDEX     �   CREATE INDEX idx_blood_test_results_1 ON public.blood_test_results USING btree (resource_key, reference_datetime, derived_from);
 ,   DROP INDEX public.idx_blood_test_results_1;
       public         health    false    188    188    188            �           1259    16737    idx_findings_1    INDEX     m   CREATE INDEX idx_findings_1 ON public.findings USING btree (resource_key, reference_datetime, derived_from);
 "   DROP INDEX public.idx_findings_1;
       public         health    false    189    189    189            �           1259    16719    idx_inspection_results_1    INDEX     �   CREATE INDEX idx_inspection_results_1 ON public.inspection_results USING btree (resource_key, reference_datetime, derived_from);
 ,   DROP INDEX public.idx_inspection_results_1;
       public         health    false    187    187    187            �           1259    16710     idx_medical_checkup_interviews_1    INDEX     �   CREATE INDEX idx_medical_checkup_interviews_1 ON public.medical_checkup_interviews USING btree (resource_key, reference_datetime, derived_from);
 4   DROP INDEX public.idx_medical_checkup_interviews_1;
       public         health    false    186    186    186            �           1259    16701    idx_physical_informations_1    INDEX     �   CREATE INDEX idx_physical_informations_1 ON public.physical_informations USING btree (resource_key, reference_datetime, derived_from);
 /   DROP INDEX public.idx_physical_informations_1;
       public         health    false    185    185    185            k      x������ � �      l      x������ � �      j   0  x���MJ�@���)Bfk����tW�<�$�#�q!�ݍ
���8�izU<���x�}�!:�e�{�D�}�	}�>�#y@vb��U|���0ĩ2�����zkO�64�m�^��i��y8��E��ڰ	���N{4,+e�n�}>�y~9�_���|\O��d��iڼ~�/�D�"#[�'�5�W�@V'6S9?��?y	�4�]�	�7n�l+��l����D�
&��tH2�h�EL�s�t�O >�R"�ە����J�'I�#)C�-�W�S"rMz��	�P�(�J���J����}W��w�R      i     x���Kj�0@��)Bf����>DO�Ml�eh�,fv���ާ������+m!��J�V�R!�d�<	�lB���Ņ�#)` �=b�����=ׇN�-ؽ��!����~���]����t,�y��Dz�HE�0��݉��~��.�z�B$����iS�M�n�U� �G���ѲU�;1�$�b�9ES+"
)aL��c��r�����Fn'#���Č�J$K-nn�� �. j�D6'�7���
?&��҈hyd�Gc����      h   �   x����j1E��&�j�����B�	��@��^�BW]̢D!�Apn�Y���M �j{�.�I���wO�{:�t�/�s�L�Hu��c9�����y!�+.O���{�|N�r�]�N5���wB�0�D�(����N�T�-qoPz�Jd�y8���4����ĦJ���}��Z�*~'f��$vD/��Q�+`�\�fۃ%4�H7�3��HZ�.	G���Z:�-Y�c%����.�<�Ƙ/Ѵ�,     
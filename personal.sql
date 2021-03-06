PGDMP     2                     w            personal    9.6.10    9.6.10     O           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            P           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            Q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            R           1262    16576    personal    DATABASE     f   CREATE DATABASE personal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE personal;
             personal    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            S           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            T           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16577    personal_informations    TABLE     �  CREATE TABLE public.personal_informations (
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
 )   DROP TABLE public.personal_informations;
       public         personal    false    3            L          0    16577    personal_informations 
   TABLE DATA               �   COPY public.personal_informations (resource_key, reference_datetime, item_class_code, derived_from, json_data, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       personal    false    185   �       �           2606    16584 .   personal_informations pk_personal_informations 
   CONSTRAINT     �   ALTER TABLE ONLY public.personal_informations
    ADD CONSTRAINT pk_personal_informations PRIMARY KEY (resource_key, reference_datetime, item_class_code, derived_from);
 X   ALTER TABLE ONLY public.personal_informations DROP CONSTRAINT pk_personal_informations;
       public         personal    false    185    185    185    185    185            �           1259    16585    idx_personal_informations_1    INDEX     �   CREATE INDEX idx_personal_informations_1 ON public.personal_informations USING btree (resource_key, reference_datetime, derived_from);
 /   DROP INDEX public.idx_personal_informations_1;
       public         personal    false    185    185    185            �           1259    16586    idx_personal_informations_2    INDEX     �   CREATE INDEX idx_personal_informations_2 ON public.personal_informations USING btree (item_class_code, ((json_data ->> 'patient_id'::text))) WHERE ((item_class_code)::text = 'patient_id'::text);
 /   DROP INDEX public.idx_personal_informations_2;
       public         personal    false    185    185    185            �           1259    16587    idx_personal_informations_3    INDEX     �   CREATE INDEX idx_personal_informations_3 ON public.personal_informations USING btree (item_class_code, ((json_data ->> 'full_name'::text))) WHERE ((item_class_code)::text = 'full_name'::text);
 /   DROP INDEX public.idx_personal_informations_3;
       public         personal    false    185    185    185            �           1259    16588    idx_personal_informations_4    INDEX     �   CREATE INDEX idx_personal_informations_4 ON public.personal_informations USING btree (item_class_code, ((json_data ->> 'birth_day'::text))) WHERE ((item_class_code)::text = 'birth_day'::text);
 /   DROP INDEX public.idx_personal_informations_4;
       public         personal    false    185    185    185            �           1259    16589    idx_personal_informations_5    INDEX       CREATE INDEX idx_personal_informations_5 ON public.personal_informations USING btree (item_class_code, ((json_data ->> 'insurer'::text)), ((json_data ->> 'insured_mark'::text)), ((json_data ->> 'insured_number'::text))) WHERE ((item_class_code)::text = 'insured_information'::text);
 /   DROP INDEX public.idx_personal_informations_5;
       public         personal    false    185    185    185            L   �  x���͊�0��&{�0��ӷ}��z,9��!V���.���{O}��
��>m)}�:�l
!��nl|0���	��Č�� �Rݓ�!etQ8�\g���u�X��YY5��w�!�+�+����y�ϙ�PS�w�j���u�]fd��
�2+5�~]36�w��2�:��=��ǯ?�}�~w������?L�^���	~Y��ij�V�t����f����۩��tؐ�e���?NSo�����/F
�6��FK��.�&!bН���h`�{�$�R��@]���S�]�ٽx]�&��T�#E���K.�U�W /�>3�Å���JjXˀ0hؕ&Ǖ2���v����# �m��#8���{N��	�v:��!`���H2��u;�!(m@�J�RH��DE�k�$۳m8|���E�#'�Y���BN�>0�C�����漤�     
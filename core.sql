PGDMP     7                     w            core    9.6.10    9.6.10 0    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16591    core    DATABASE     b   CREATE DATABASE core WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE core;
             core    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16592    anchor_resources    TABLE     a  CREATE TABLE public.anchor_resources (
    anchor_key uuid NOT NULL,
    resource_type character varying(26) NOT NULL,
    resource_key uuid NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 $   DROP TABLE public.anchor_resources;
       public         core    false    3            �            1259    16598 	   auth_keys    TABLE     �  CREATE TABLE public.auth_keys (
    auth_key uuid NOT NULL,
    ip_addresses character varying(100) NOT NULL,
    resource_type character varying(26) DEFAULT NULL::character varying,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.auth_keys;
       public         core    false    3            �            1259    16617    consolidation_items    TABLE     2  CREATE TABLE public.consolidation_items (
    from_resource_type character varying(26) NOT NULL,
    from_item_name character varying(100) NOT NULL,
    from_item_caption character varying(100) NOT NULL,
    from_is_reference_datetime character varying(1) NOT NULL,
    to_db_name character varying(30) DEFAULT NULL::character varying,
    to_resource_type character varying(26) DEFAULT NULL::character varying,
    to_table_caption character varying(100) DEFAULT NULL::character varying,
    to_table_name character varying(30) DEFAULT NULL::character varying,
    to_item_class_caption character varying(100) DEFAULT NULL::character varying,
    to_item_class_code character varying(100) DEFAULT NULL::character varying,
    to_item_caption character varying(100) DEFAULT NULL::character varying,
    to_item_name character varying(100) DEFAULT NULL::character varying,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 '   DROP TABLE public.consolidation_items;
       public         core    false    3            �            1259    16633    consolidation_priorities    TABLE     �  CREATE TABLE public.consolidation_priorities (
    db_name character varying(30) NOT NULL,
    table_caption character varying(100) NOT NULL,
    table_name character varying(30) NOT NULL,
    priority numeric(8,0) NOT NULL,
    resource_type character varying(26) NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 ,   DROP TABLE public.consolidation_priorities;
       public         core    false    3            �            1259    16609    items    TABLE     `  CREATE TABLE public.items (
    name character varying(100) NOT NULL,
    caption character varying(100) NOT NULL,
    db_name character varying(30) NOT NULL,
    resource_type character varying(26) NOT NULL,
    table_caption character varying(100) NOT NULL,
    table_name character varying(30) NOT NULL,
    class_caption character varying(100) NOT NULL,
    class_code character varying(100) NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.items;
       public         core    false    3            �            1259    16639    log_api_call    TABLE     �  CREATE TABLE public.log_api_call (
    sequence_id numeric(10,0) NOT NULL,
    result character varying(1) NOT NULL,
    api_name character varying(100) NOT NULL,
    api_parameters text,
    message_id character varying(6) DEFAULT ''::character varying NOT NULL,
    message text NOT NULL,
    system_message text,
    ip_address character varying(40) NOT NULL,
    created_at timestamp without time zone NOT NULL
);
     DROP TABLE public.log_api_call;
       public         core    false    3            �            1259    16648 
   log_system    TABLE     �  CREATE TABLE public.log_system (
    sequence_id numeric(10,0) NOT NULL,
    process_number numeric(10,0) NOT NULL,
    level character varying(1) NOT NULL,
    event_code character varying(16) NOT NULL,
    message text DEFAULT ''::text NOT NULL,
    function_name character varying(100) NOT NULL,
    derived_from character varying(26) DEFAULT NULL::character varying,
    ip_address character varying(40) NOT NULL,
    created_at timestamp without time zone NOT NULL
);
    DROP TABLE public.log_system;
       public         core    false    3            �            1259    16659    provisional_sql_templates    TABLE     �   CREATE TABLE public.provisional_sql_templates (
    name character varying(30) NOT NULL,
    sql text NOT NULL,
    db_name character varying(30) NOT NULL,
    response_type character varying(10) NOT NULL
);
 -   DROP TABLE public.provisional_sql_templates;
       public         core    false    3            �            1259    16604    resource_types    TABLE     E  CREATE TABLE public.resource_types (
    type character varying(26) NOT NULL,
    caption character varying(100) NOT NULL,
    created_by character varying(32) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_by character varying(32) NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 "   DROP TABLE public.resource_types;
       public         core    false    3            �            1259    16667    seq_anchor_key    SEQUENCE     w   CREATE SEQUENCE public.seq_anchor_key
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.seq_anchor_key;
       public       core    false    3            �            1259    16671    seq_log_api_call    SEQUENCE     y   CREATE SEQUENCE public.seq_log_api_call
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.seq_log_api_call;
       public       core    false    3            �            1259    16673    seq_log_system_id    SEQUENCE     z   CREATE SEQUENCE public.seq_log_system_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.seq_log_system_id;
       public       core    false    3            �            1259    16675    seq_log_system_process_number    SEQUENCE     �   CREATE SEQUENCE public.seq_log_system_process_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.seq_log_system_process_number;
       public       core    false    3            �            1259    16669    seq_resource_key    SEQUENCE     y   CREATE SEQUENCE public.seq_resource_key
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.seq_resource_key;
       public       core    false    3            �          0    16592    anchor_resources 
   TABLE DATA               �   COPY public.anchor_resources (anchor_key, resource_type, resource_key, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    185   �@       �          0    16598 	   auth_keys 
   TABLE DATA               z   COPY public.auth_keys (auth_key, ip_addresses, resource_type, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    186   GC       �          0    16617    consolidation_items 
   TABLE DATA               9  COPY public.consolidation_items (from_resource_type, from_item_name, from_item_caption, from_is_reference_datetime, to_db_name, to_resource_type, to_table_caption, to_table_name, to_item_class_caption, to_item_class_code, to_item_caption, to_item_name, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    189   �D       �          0    16633    consolidation_priorities 
   TABLE DATA               �   COPY public.consolidation_priorities (db_name, table_caption, table_name, priority, resource_type, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    190   $i       �          0    16609    items 
   TABLE DATA               �   COPY public.items (name, caption, db_name, resource_type, table_caption, table_name, class_caption, class_code, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    188   @j       �          0    16639    log_api_call 
   TABLE DATA               �   COPY public.log_api_call (sequence_id, result, api_name, api_parameters, message_id, message, system_message, ip_address, created_at) FROM stdin;
    public       core    false    191   ]j       �          0    16648 
   log_system 
   TABLE DATA               �   COPY public.log_system (sequence_id, process_number, level, event_code, message, function_name, derived_from, ip_address, created_at) FROM stdin;
    public       core    false    192   wp       �          0    16659    provisional_sql_templates 
   TABLE DATA               V   COPY public.provisional_sql_templates (name, sql, db_name, response_type) FROM stdin;
    public       core    false    193   �p       �          0    16604    resource_types 
   TABLE DATA               g   COPY public.resource_types (type, caption, created_by, created_at, updated_by, updated_at) FROM stdin;
    public       core    false    187   us       �           0    0    seq_anchor_key    SEQUENCE SET     <   SELECT pg_catalog.setval('public.seq_anchor_key', 4, true);
            public       core    false    194            �           0    0    seq_log_api_call    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.seq_log_api_call', 64, true);
            public       core    false    196            �           0    0    seq_log_system_id    SEQUENCE SET     @   SELECT pg_catalog.setval('public.seq_log_system_id', 1, false);
            public       core    false    197            �           0    0    seq_log_system_process_number    SEQUENCE SET     L   SELECT pg_catalog.setval('public.seq_log_system_process_number', 1, false);
            public       core    false    198            �           0    0    seq_resource_key    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.seq_resource_key', 16, true);
            public       core    false    195                       2606    16596 $   anchor_resources pk_anchor_resources 
   CONSTRAINT     �   ALTER TABLE ONLY public.anchor_resources
    ADD CONSTRAINT pk_anchor_resources PRIMARY KEY (anchor_key, resource_type, resource_key);
 N   ALTER TABLE ONLY public.anchor_resources DROP CONSTRAINT pk_anchor_resources;
       public         core    false    185    185    185    185                       2606    16603    auth_keys pk_auth_keys 
   CONSTRAINT     Z   ALTER TABLE ONLY public.auth_keys
    ADD CONSTRAINT pk_auth_keys PRIMARY KEY (auth_key);
 @   ALTER TABLE ONLY public.auth_keys DROP CONSTRAINT pk_auth_keys;
       public         core    false    186    186                       2606    16632 *   consolidation_items pk_consolidation_items 
   CONSTRAINT     �   ALTER TABLE ONLY public.consolidation_items
    ADD CONSTRAINT pk_consolidation_items PRIMARY KEY (from_resource_type, from_item_name);
 T   ALTER TABLE ONLY public.consolidation_items DROP CONSTRAINT pk_consolidation_items;
       public         core    false    189    189    189                       2606    16637 4   consolidation_priorities pk_consolidation_priorities 
   CONSTRAINT     �   ALTER TABLE ONLY public.consolidation_priorities
    ADD CONSTRAINT pk_consolidation_priorities PRIMARY KEY (db_name, table_name);
 ^   ALTER TABLE ONLY public.consolidation_priorities DROP CONSTRAINT pk_consolidation_priorities;
       public         core    false    190    190    190                       2606    16616    items pk_items 
   CONSTRAINT     N   ALTER TABLE ONLY public.items
    ADD CONSTRAINT pk_items PRIMARY KEY (name);
 8   ALTER TABLE ONLY public.items DROP CONSTRAINT pk_items;
       public         core    false    188    188                       2606    16647    log_api_call pk_log_api_call 
   CONSTRAINT     c   ALTER TABLE ONLY public.log_api_call
    ADD CONSTRAINT pk_log_api_call PRIMARY KEY (sequence_id);
 F   ALTER TABLE ONLY public.log_api_call DROP CONSTRAINT pk_log_api_call;
       public         core    false    191    191                       2606    16657    log_system pk_log_system 
   CONSTRAINT     _   ALTER TABLE ONLY public.log_system
    ADD CONSTRAINT pk_log_system PRIMARY KEY (sequence_id);
 B   ALTER TABLE ONLY public.log_system DROP CONSTRAINT pk_log_system;
       public         core    false    192    192                       2606    16666 6   provisional_sql_templates pk_provisional_sql_templates 
   CONSTRAINT     v   ALTER TABLE ONLY public.provisional_sql_templates
    ADD CONSTRAINT pk_provisional_sql_templates PRIMARY KEY (name);
 `   ALTER TABLE ONLY public.provisional_sql_templates DROP CONSTRAINT pk_provisional_sql_templates;
       public         core    false    193    193                       2606    16608     resource_types pk_resource_types 
   CONSTRAINT     `   ALTER TABLE ONLY public.resource_types
    ADD CONSTRAINT pk_resource_types PRIMARY KEY (type);
 J   ALTER TABLE ONLY public.resource_types DROP CONSTRAINT pk_resource_types;
       public         core    false    187    187                       1259    16658    idx_log_system_1    INDEX     ]   CREATE INDEX idx_log_system_1 ON public.log_system USING btree (process_number, created_at);
 $   DROP INDEX public.idx_log_system_1;
       public         core    false    192    192                       1259    16597    uk_anchor_resources_1    INDEX     a   CREATE UNIQUE INDEX uk_anchor_resources_1 ON public.anchor_resources USING btree (resource_key);
 )   DROP INDEX public.uk_anchor_resources_1;
       public         core    false    185                       1259    16638    uk_consolidation_priorities_1    INDEX     m   CREATE UNIQUE INDEX uk_consolidation_priorities_1 ON public.consolidation_priorities USING btree (priority);
 1   DROP INDEX public.uk_consolidation_priorities_1;
       public         core    false    190            �   }  x�ŖˊAE�����U*�ߒ����Y$�OdL�<�$3��Ъ�A��v�0���=6�1q�m�	�~Dz�����P��+dr��@�E�����4^��x��u�ϕȀ؟�N('�#IS���@�"����T"j���q�τ
���I){���� B�C�C[�{��ؒ�ziݺ�"s��(B��PW�\�RIB`������:i}(!�aM�AW�H4�c���NcS/;��F�*R4BA�$j�ȅ�n��|���{�9���^��β���HV֖(�{&��UL�PjݱK*��C�����\d��d��Q|�����/jt��!��	bJ�Gf�L��|�/�Șk]+��<��l����6s0[�����ڀB�z�-��d8"�D�^�n4'@yF>��؎���en���x���Qk�a��Kr��+�$X�$�m����z��n;���A�8;�Y5-�8Ƌ������e���g��\2�����̨�֚�����ֳ*e����bm/m���)�����	>gO&xrC�p��r+�7'<<��T���>�k=2ͺ�n(kF2�䁾���K�e������(aD�j�Y�Qj���?�YEeti��'3^�82d:9C�6}m�10☳���.��/����>���      �   �  x���9�1E��)t�7�d�*N�T�l���Nfx�
Z}���g�jj�;h�c�C���p���6�E���yэ鮖ICĚ��o���~�Ɂ�����`yh����{�q��U�
舀^�@�֩�t����j���.b0�[����+t�r�:hVƪ	6M\y!��g�{��&&n���b}j�)�G3Е��ڀ��w����ө�����a���A,��^݌�r�I.1I��Oe�}��S�Jf�Oh�΋l,�Lz�I���޽ei4��@����Y'�Ti�
�l�-��Q�ͷd��s�r�����?w���勢|޻�I"SJ󘂛"�sξQ��(W�����~���gz�X��>Ҫ���O>0[E[M3��
ʏ���PRx      �      x��]ْ�F�}�����(=Hƾ���,�-M˶�R;�{z�Q$�@��%�_��<0����I,�= @��B"	�7�M�rs����W��>��u�a���vQ�&y�+����w�O�.)�"�2M7t�+�a����cH��E�e�E^� �Ǥ��:�UR�w���KCi_��7���鼲��¿0���6��pՉ��U��O����=ϱ����ӼڗI)c]�z��U7L놔��cZ6L@	�0an��Q{&3:a"@ֲtߜLZ����sy^{�� a�6w@Z���c�G��>��<�&ZE(�^4&�]��on_,���D;���z.|@��O�z�j��%a����</0�I I�J>k	+Y��t7��$�+�����2�����.�ML�H��jU&U�8�;��'���=3@eOH�uT����d��/Ѷ�N�Q	(Y����V�\G���*�F%�d;:Ng 9o�t��e��$QVo4����4���嫨\	7� �E��7	 	�2�O��]ۅދ���6վ���l�\F��o@��t���4J�:��2�o�2�c��&on�Foƾ�9�$�.�i]��:�${�(��XU]*	 �Ǜd,Ah�M����I i�SZ�I��=D��'2����SM�{��iz&4B H#���=�-aߓW�˴L��$�vV"�|7�����KH��m����rF���1�uR>��'�~��дY툼	�K���I\�OI���+V�T^��l��� �v3_e���<D� ����$  ?��F��x����`�(����}*�YZ5�" {ϳ,h� ���.�j֭��,}���S�e�'k;д�����t0��LϛХ���y�ƒǍ1�L��gE�
w��/�}�P�@r_��3�o5��|Cg��I ]��*	?E��y\&Q���HҘ�]�����8[�4h��P$�N�l_�y?���(( ��ڨ&� ��������'K�6Vc.��s���q۱u��J �/�uv`�U�:r�jE��^��x���<@��ԛ�,�8c�u�L�#H�KT8Ȼv�B���ԯ2��w�.i�X��X�1���/��MTUK I<c��]�xGW������Q�rR��NԷW3��4���/�s*���\�07ڻ��\�Ap-G�4��0� �z$`�9ܧYZ���|y��NtU���;(�% 8,%�tL�+��U:'˰<4�)h�B{���yl���� v�r�DH ]�D;����y����� v����#t��k��Ǐ��q%ȿA쬽��' $�ߘ��ͥ���o���[�R$�nͫL���7w>��K�>��a�/���"�pDCh�Y���}7����7L�Pѻ�ȸ�t�w���lo��N�}�����~���D�_���t�ل�tݱD�YĹ��� rKw�˩ ��a��wof�@L@	�o�o۴� `���o�h{Ȣ*�����c��wO�,�x) ������<�!bJ���]��iOQ&ҙw��4O��2G��;	��[f��^�~(��?�2�!�ʊ_���p����ߗ��bؒDW3�	H�a��X &�HK��g6��|璦d�n�"�@{7�}�}|�����he�/���Ѡ�!$�=W���$�D+�� i���$�i��ڷ�iE.��7�ݱ��H������z9��R[z���뚖�j]	 ���S4��K)�	�e�*,�@���f�T"��2Ǳ�C �ʹ����3k�b�qv_���.���"��̇��R*F�4��* =B���:��m��g�t�M&BveQ'��TE��f*�"������X2��W�� �D~=�Ɇk���fv:���� n���	��L��^�23wr%ȿA�ey��� 0ʨ�r7��K��h�������J��3�Y.��7�=plu�$�.ݻM�}|�ff�	�VV��9��4pP1� �d��>~����J������#� zuwmi�hͣ�� ��[�=	 �l�=��}��(� Mx( ��U����������*~st+@eGh:�i��4�J�J���]�	&� �sw�U�u�Nr�ͷ��P��*���<��c`��}�:\ξ��w��mÆ�R h��S'�׿��/DF��nz�g�!	���}�%�8D(�	<��\U'U-	�w�Z�y������u߀R�A�t�� �t��߀��`WM&���}\T	�,�v����J�����e�6��$�L{�"Z���CQ�r]n�ˡY�X q�e��$`�e�.�b�W0�i�PvXG ��0�&��ɽ�M�M.���p�<�̱�0���+X��� ھX�� ��4����W�� ��	��(S�G*�k ꁱ(h���`��g�*�����5L�0���<8�'�ⶦ�/�c���I���۰���L9��e�}���$���&pTQHs��b^������wfv���3�9b�LZ�DS�a� =���v՟~�0w���\�'�� ��Z���b������^��id��+�ǳ����F��;#x�ȓ2}����a� ¦�cc�s�2�����>�w@O�Ʊ����?.��7;�"�Ѓ,��c�������nfC��T�K@���pz̏��v�Ǘw�g�H������B��
 ��%�u_'"�j6�FfLO�`h�M z�z�dY&i�b�������-���|W' �>X�� ��7)���ۋxs�B@ʵ`�O�ӛX�2M�%�Tq�h�<���`�vm�wo.".�J3����������j�{a���BKGC��
�Ґ�	�M�/M�>w����&��.:�D�Ψʒꢌ��8�wub��]�
0�|y�����;
)K��P"|��N$�����}'�w0�-߃���>t�&YZEڛ��������A�{�a.�i���m_�9H �F��I�8K�o�����g[v�
�jE��<{*�)��I��,�3��QC��( ��Q�j��-��Z1Z�0p\��p�M=dE���G������4Y�1ԚK �R�E!&���M�����Ӓ�QHM�� �ó����S�IY��%��K@�`�]��4�v���{g~>
�o�`���f�	�$�X"<�5�FJ�՚����A�F� sG|4�*t�NvU�|Z�viv��ҹ�����. g��12�u�}݀�Ƿ%N�1�l�6�c�@7`�^',���G����2��t��^y/�<]RGa�������{~QhdHe�4�@w�|P�!1�<ʉ���i �
��c���F% L��%#�Ƭe��dt�Y(NL�%پ{�6��VL!�-���<�:)sqZ�U-��K ����I i�:�&��ɊQ�S��+��vY;ӊB�'�����S�W����a-*jcj�� C���Y	 ��zs��
=1�t����aE( �QI�j]~@W�%O|�e����.5�=3 �����* t=�J��Ǉ(WG�,��(]'���1aN�2�}Yl���Q=��I����M
@�L"�5f�VR�Dm8�<	@;�7Q���E㢄���.k������$����RjR�y8`��;�T z�8���ߋ��3G�R=1kbd,Vq�.��.�:�ޮgx�� ���̍�+��de���Z�DI{sul�T ��I����Z�_c��U�=b��Pd��  �fbwy��:��x���@��X� ��/�8�O���\`�`�H�8�1�E\��)�m���
 S<	��SX6o��J�wur��� ttW2��8ɲj�1%�{����>�4��&��ˍWsz�d�V0'� �b&�Lo�}&���$Y��j�j~Z�X "�O� t��G�c)#Zz� =��h��ٙ�E�z���@uT ���hw�ЧW�2>4˩����S-�;�[ ^�ӄ��1����^���~��P�u��'�`i�I)��]���	��� t�����X��Vӗ�\ҔL����
������T��;���.�iX�T ��{��d.QrS�l�8    TP���(w^h�e�^�e��T-? �m(���ϊ���]h�� Clǁc@�?%��Ȼˊ�PA��rj q��8��X �?"��ڮ�f������pd�#����z�Q������o����q�Ml��%�⺗�4r���rG�eQ(�3��ӄ���&!5�����) iݚ���,*[�z�sQҿE��{��HI ��>.�YU�׀�a�����3{�@+�M7 �U�����>�n<0�\�F����M^PPF�o���#��^����"�:׀�����!t'�I�,lW<.|�Ҙ��MD2�X� 8��"g����ᷝ7�=q�+8�zl�뫡�0mlד_�Ԅ�<�mp�,N7J �.������R���� ���O�F��}K�A�XT�(]'�[�h�נ* mN�����]��n���L��b���p���l�,�PA���\,MS 0����b�5�(������l�~�I�y������ �	�Y���� ���.)B�D����# �2O�z/����K[�3�c0��}�XG�W�J��ny/w�G�n�s�Q�)��(L�p���<)e߶��w*�`��y���W
@Or%ۢJWI����I�;	�ˆ�m@O�
�2\�$J��>`k�6x��u㬚hŁoM�oQ#��ܨ� t��冋zu�%�d��Ր ���W�v��|��v�n�{s�b�1=%J���\�SᴇZd�m~چ\�yO)����6�tQc�p\�yWuY��CV�L�pQRF��i�G	 ǹ䟊r&��B{N4�n b�����NVi�����@A{I3ru�rQ.� ԪFu��5��M�{���Ӌ :�y�g�;�&?S��Q�}1�9 ��{�p��u��'�a͸��M@���`ףоM������yĹ��� v�� z:v}�ޛ� ���::�J��G��'��#+~����Z��7qIF%��L}�¦ ����T��\dȘ��=�0plp���OU����R�}�����[G�V	��|
���G2�̏S>Qн�wD%��1��#t����5`ez�S[ �=��nSćz�l*�5t�+�5��E���"WQΥܓ=�Ll�oQ �%O���,�J��O��ꁉZ	 =��^~�#x�| �G$ �6n���x��a�F����||���Q 0��d������R������]h�]���H���#�%ZY����f`�>�ЍBy�7e�}�|Ϣ���J�5`�_��V�����Kc�IT�K*Z>�J��Mۆ��$���V�6)C���.D�F)x�~ �Y�	]p	 �L��|r$����ُ���4�x�,�����cbYTU��D��c^|���s�9z!X��x�����>/�mw�i��3����=�'FЌNUg��@=����%��yx���i�������J�4K�3|�r�Hq�u4��{\�"�,u�9�C��r�#=���<�B�\	8wY�\����Ȍ6�����AOI��#�X{�����yQ��Ի	8�E��QI X��iwAe@�	 �-σ�� Δ�՝�}�!C�5`e�x[��}�"}L���*���\�G y�+��\'����TI����Ғ �
rBU�J�I^K�7Ş�`,Q�hQ��n���+��3�}���3	��I��� ���~�a;g�Rt�va��k�ߡң:"6���������
p�y�Ѽ�g��gN����tu� �W��ڊ�3?J�㝄��ۀ�i`�P�.c�/�/C0ս�n<S�$�f9>ݕh���+*��O���0.��R�U2���?��IZԑ�B�8̵=��L�L�U��aXmq �RW�� lq<׃�
 Z��R7)K��{�� �zh�X���m�7�+YXOttn b^�����;hB��_��Y��HW\�L���}�������))waO��o���@/T X~O�_��N���,8�LHs���2-B�&b�{v��xa�uJ)�0-,�T z�@�ś�>��,;c�5��F�n�_�?	@���9�U�,�1f��'r؞WJ����}+�H��E�ڎ O蹖�1+�0��UZ��h>��*��9�\�@��#�ф�	0�q�V
 v/q���蠚���������%�h�Y 0��u}����$��=s"��;=�	`�+ `[ξ�o��鋅���*.v�~��R,�rN�(���#]&�&0Ћ��>b�K�p�L��
��G��[��o�[G��f���a�V �j+���+"ϙb��͔�bX-V�����+�ӓ���d&�����1��`Z��M8�H�:W�[X������B3D[�ARHc���`@۲Lpl��c�p��r�N�ƶ��;��X��ES�؎�Eͺ&��.K>w�i��7�5�#/�)k�wY$�t����8�W���@	��BE��t��V~�����d���WXz�V9(��Y���V�4G���y&t�����u���4
�ֶ� �r	8˜�y.'1 ��,��E����F�.�v��<�]��_���'1_ �rqg�S#�q#\�I 4��Aw�ð�Wn_�,��c��GI �<_�Q 0�P�삓a_o~�}<C��d����],aV���T�ɺ(�)C�v��v<*��m�&8�A&�Z���<��׵�S��"���	[_	 /�(�����v��8H�.r/�#fY��M88Z����6OX�3Z�|Q��+�,�M��S� ���J�*y~S��	��6�)�yy�/
;��3UL B`�V��8�����$�*R�~�yRL�1<m�V pn@�� �qϑ��\�!t�(�d>��Ќ]����}-z��TF�p<N�GG���p��(Y�qMy=�� s���{	���w�>��S'@Դ8� �SJJ��c<#�ۯ��i�PGD�l,]T z��T��nե�����J�N��f�f4�&�t`��}���?X�I ]F�)�Eɇ������Ť�_h�]��P �;{�C/���n83����8XV��0+)��S?pp�+ 畆�Di<�s��*�?�^��.�g-(:��0l�	8�i�A6��,0-l�T�s���Gq���T��L-��� g>�g�Di<mۆn���Lz�N�4�u�����Ƕ%����x���t�?H �%��7!���^d�TЪ�<VJ`��iڽGr��c,
���q%
0�ǱP1DͿ/�n4t���<F.c� �]�z�3z0��vCݾ���Mu{�{��R ��W��j���-�8�L��)Z�[�uq���	h�v��|. 8�M犬�F@�q��K�DZ_w��	h��R��<�do���mvK�9��=o$���|rm�V@��|�V�Hu���_L�了���`��Kp�_�z�3L]� ���x��I�i�no�y�`�A{�竽X�)5�v��4|V	��ُў�y�1�+X2	`l�8�Kй�E�a��qpu��zN���ufM8.�K]�[~NG^l��Yvp�F���+W ����]�{���.��ښ�k�_8��쪧�Gh�h�M��ꗀ3�PO��fL=?���2	 �B>��ם��=�л�ܫ#�I޿��f+�o/g��"}ꊦ�:��9I ������|�R����&l�6&, gOD��us����k)5�����8�H&���L���Y���h9� �W�N��̙K���r`�v�Y����#$ƴ���cAo@�Q��E��au�W%ka�D�-h���z��L�?��u)*���ޯ'����{�ާ�(�VK?%�SǮk �{�{� �H�"���5X߲l9m��w �.x͖LY�Gϛ{�Pd�W::W]���R�%��hǸU���e�=&�h�("+�ֈur���.�ےʧ4��M�� `�i��1*��Ư�}\T��y���Ym�`�e��8��,݉s��-���(�t0�v��P� "  �UnҊ����2�����}b9Kְ��A4��V:Ίp��8+K�L��$q�+$�9f�x|���r����R���1]��!|��L�W"#7o�0i�vS�D�s��n�5��"3 ]&۔�ý��VM�p
|l�T zto[<�1��X�z�W4-�0\��F�	&r��&��I�����ԙ"�ϘaMG�x,�`�a��io_��Ϥ��*	7�}�|$�6�P3uP��E�	�k�͡��_Ǯ�ވy�Or�d2m�|C���5�x����,�Ԫ�Ʊ���c`I�,Fx�'��?����&��vz�N�bլ�o�3��Y,p��V��m��s�.�&�'�:���+�3}�D ��{&8�A�aUŏ�!��*������ ����  �x�n��ˌ:�7r��j���N_�	���5|����%b���H�$�P�v�'q�q�6`l�hj��,Iv������7 dýE
@�ťIU�d�/\ڰ��%u' k;��!�k�v�v�>��6��W��cW8i㼃c�vuښ�@T��� L�b���w[<��\��b~��'>�I�X�4WQ�n��j����@�o�s�`,�M��y��̽Kʪ�G���������;_x�O�Hs>��i����g�%l
@��E����N����mT"��b=G�uK 4&��L���{�d,��-y�����E�+��~<��v��w�_����-��C��c��I�3cctC$��}i|����W�/,��:�Z�uj��������ox�`��< �����m�bL��w7��ŢLx��^S�������� �����25ߵ�r_C{A�0�� z4�Ӓ����PK{	���56!3 ��V┥e���Vc�m��m��nr 藇�E�㛬���c��G{�4k�h�;}�U嫨�|5�1���j9�fe촫�G�ӕI~�$�[�	3� �s�q��3o��5� ������H�b���*)	������K�Bh'��"(���a��H�` ��]����m>��QW���_���p�      �     x���Oj�0��e�<E�̮#_�D�Yt1+]
�jfu����k�=I������(L�d���@~��t���mR'�W_�Ўw�T��;�F6JA@�xs:ha�(�&���5�1e���C��S��6$���W�Z�`H��9��Lp��ܦ��H�[Q�bY't_��d�I-&%x�5��tef��n�23B���-v�"k0�}Z�^�R�à�Krviʿ`Rvʈ�U�78��4dQ��o�AǗ���$A�c�s1d,�Σ�8����\      �      x������ � �      �   
  x��[K�E>�Ed�L�U]Տ��C��%�jv=N���+�WE�b/��B	E����$?f!��j�#�l���hƻ�]m�T}�读��9י�k�Ť|�r9Y/��a�:.7F���jy�s�[lN�,��n�5ˡ_Z\�|X���=��!�s�����}��<��֋q�VNd�n~��^L�p�4��4�b�6����F^й﷿~����Pm�Sm�Z�~��T�Y5{���VM?�f�Tӯ�������s�\<j4�hG420�Sr�9EM)8���L����#�QY1se4��zb�L�GkK�k��Ċ�/%�_222����_t�׻b��Q�u0�(��u���4�KIG��� 3��է�'zm��.e�?���?_ݼy��on}(��"u�����+ң!z�g�d�J9�|e��^�����VG��R�<��4㵍�ฒ~��,�$&M��6�:^����^5}KD�������vM�~�FG^�t |��5!N;FX��q���0���h�B$R�&�_X�10j�l,)�j�1��m�ɀ5=�Pol�Fd,�*6]U��� (0uf���<�T�mA���\f��+zn9#�~ѧ����ج�ެ�Qo��hz,눲��윩�<��;�ϟ�f߿�̓�w��j���w�yx�}����j��jv��ݭf�T[�u�|5���z���Nd�������9*��c�);Ij����0�S�	j����# K*q�0�� {]�d��]`rk4;A��5�,H00Y��(���!�"�cV[D��:�P]�д�q`��68as-0��Xʍ՞e��
[����u�����i�(*lY�#`0G�ɲ'TX;˥!csr��(���6	���Q�A��xn�I�am���~[A�_/v�se�m[!3��bbr2:
�uVa]̾qA �H'M&��\���>WV�T�r�B�GP�,��!�x��,4�����}�/��˘���0E?�_���M�^Y����5x�>(ۈ�����cA[ ��]�mn\�ca@��l�P�Ic�K��:��hf�8���#D��c���_�cb��� L���*p��tRqc[�m�;:xH������t5�	YEu�<��,u z�۔jPJ���Rێ����Jт�UR7�����B�Uʑs6i�-�KQ�D�W5f/׵u�xց]G��!��B�U�w�`����`�s��8�pRq[�ڤ���_J�:F��V�J�Mu +n[��J�����E�d�QF�^+ǧ^/7&�ȥ�3��9�#�^{ޝ߹�!��iޕ�� Nq�5�x��s��)�����1���O&�G�Ϲ�"�h�b�J�_�#��Z�l�i�ڠ�Kk�	�mH �K��H&�3#�@�l��x�
�9�����%�D�@q]ͼ̓eޅ�G&�N@C�a5R˭r'���а hFv!*w�y��!��P���{xX���%XN@#�!Q	��}Dt�VJ�mD<�      �      x������ � �      �   �  x��X]o�0}�_q�K��U�>���J[��L-T��M�0]Vb�$H����l��d4DL3��%�s}�s#�s�;�<�(�Q�x6�F�<����}1p)����	����6��{y�j�/��j�`	�l�b!R����{c?��c�{��^@'�(��`Fc���t�^�=���s�A�4�' �ﴗ����h�Ǳ7��	cM�өG��X"��k�=�������P����$AH�m�/Dؕs�ह�c�a%���O�%��<"c}����� x�Z�K9���_�K�Ұ�=�XB/�����/����,���.���~�IׯjP�R�i�w$�2L����W'�[gp)���Ǳ��L#��z�Bȫ�"Z�Vy����ʤ�x�dKRX-��B<��kf-�ȥ�*��B���E��#3+���
k"�,+"��{��kcҎ2�<�˺�~v�Uz�ԯ�`��K��,a56�B�[IYZ^�eH1�k}��M��  j��*��C�9P)m���t���NgUX��u���3�
q-�b��	E�j:A��W�?�+����.N�刘Gp�ewE����k��!@Cp���ݍ0GJvc���k�7�_}� }T�-�������¾����l����V���%�%�	ǣ=Z�,hY��e���*����/(e��L
%
%
%
%
%
����Ki�)�� �ʂ�b&Ts�`+������8U��      �   �  x����N�0���)��P�F���,�3k`E��?v���K�t���|�;'�{��vӴ���N;�G�#�;p#��8x����
�N�䌺i�������Y*/���5�F�C
�B�^R�T�]����d�v�	�i���'U�*F3 D��;k�(Hϋ�ꍇ����^5{�D����njklj�hu��j��.��ծ*�Al�8���3P������^C;�� tKAlM��ݷ&@Cj�>�2P�pwq)Z�8�2P��� �3�ӟ��tf$1r����B�@�:-�LGK���V4ۃ��U�]�8-f��@�DQi@o���sԟ��ö�������-HS3����!u��9w�J�+yO������]�D@q�M�2������"���#�Wa�c�W�z�R�,e     
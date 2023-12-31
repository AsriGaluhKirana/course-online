PGDMP         1                {            courseonline    15.3    15.3                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    16978    courseonline    DATABASE     �   CREATE DATABASE courseonline WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE courseonline;
                postgres    false            �            1259    18174    course    TABLE     �   CREATE TABLE public.course (
    id character varying NOT NULL,
    nama character varying NOT NULL,
    deskripsi character varying NOT NULL,
    kategori character varying NOT NULL
);
    DROP TABLE public.course;
       public         heap    postgres    false            �            1259    18182 
   coursedata    TABLE     �   CREATE TABLE public.coursedata (
    id integer NOT NULL,
    user_id character varying,
    course_id character varying,
    status character varying NOT NULL
);
    DROP TABLE public.coursedata;
       public         heap    postgres    false            �            1259    18181    coursedata_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coursedata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.coursedata_id_seq;
       public          postgres    false    217            $           0    0    coursedata_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.coursedata_id_seq OWNED BY public.coursedata.id;
          public          postgres    false    216            �            1259    18167    pengguna    TABLE     �   CREATE TABLE public.pengguna (
    id character varying NOT NULL,
    nama character varying,
    password character varying NOT NULL,
    role character varying NOT NULL
);
    DROP TABLE public.pengguna;
       public         heap    postgres    false            �            1259    18201 
   prequisite    TABLE     �   CREATE TABLE public.prequisite (
    id integer NOT NULL,
    course_id character varying,
    prequisite_id character varying
);
    DROP TABLE public.prequisite;
       public         heap    postgres    false            �            1259    18200    prequisite_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prequisite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.prequisite_id_seq;
       public          postgres    false    219            %           0    0    prequisite_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.prequisite_id_seq OWNED BY public.prequisite.id;
          public          postgres    false    218            �            1259    18231    viewtopcourse    VIEW     �   CREATE VIEW public.viewtopcourse AS
 SELECT count(a.nama) AS jumlah,
    a.nama
   FROM (public.course a
     LEFT JOIN public.coursedata b ON (((a.id)::text = (b.course_id)::text)))
  GROUP BY a.nama
  ORDER BY (count(a.nama)) DESC
 LIMIT 5;
     DROP VIEW public.viewtopcourse;
       public          postgres    false    217    215    215            �            1259    18235    viewtopstudent    VIEW     �   CREATE VIEW public.viewtopstudent AS
 SELECT count(a.nama) AS jumlah,
    a.nama
   FROM (public.pengguna a
     LEFT JOIN public.coursedata b ON (((a.id)::text = (b.user_id)::text)))
  GROUP BY a.nama
  ORDER BY (count(b.status)) DESC
 LIMIT 5;
 !   DROP VIEW public.viewtopstudent;
       public          postgres    false    214    214    217    217            z           2604    18185    coursedata id    DEFAULT     n   ALTER TABLE ONLY public.coursedata ALTER COLUMN id SET DEFAULT nextval('public.coursedata_id_seq'::regclass);
 <   ALTER TABLE public.coursedata ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            {           2604    18204    prequisite id    DEFAULT     n   ALTER TABLE ONLY public.prequisite ALTER COLUMN id SET DEFAULT nextval('public.prequisite_id_seq'::regclass);
 <   ALTER TABLE public.prequisite ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                      0    18174    course 
   TABLE DATA           ?   COPY public.course (id, nama, deskripsi, kategori) FROM stdin;
    public          postgres    false    215   �"                 0    18182 
   coursedata 
   TABLE DATA           D   COPY public.coursedata (id, user_id, course_id, status) FROM stdin;
    public          postgres    false    217   �&                 0    18167    pengguna 
   TABLE DATA           <   COPY public.pengguna (id, nama, password, role) FROM stdin;
    public          postgres    false    214   ='                 0    18201 
   prequisite 
   TABLE DATA           B   COPY public.prequisite (id, course_id, prequisite_id) FROM stdin;
    public          postgres    false    219   <(       &           0    0    coursedata_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.coursedata_id_seq', 27, true);
          public          postgres    false    216            '           0    0    prequisite_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.prequisite_id_seq', 4, true);
          public          postgres    false    218                       2606    18180    course course_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.course DROP CONSTRAINT course_pkey;
       public            postgres    false    215            �           2606    18189    coursedata coursedata_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.coursedata
    ADD CONSTRAINT coursedata_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.coursedata DROP CONSTRAINT coursedata_pkey;
       public            postgres    false    217            }           2606    18173    pengguna pengguna_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pengguna
    ADD CONSTRAINT pengguna_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.pengguna DROP CONSTRAINT pengguna_pkey;
       public            postgres    false    214            �           2606    18208    prequisite prequisite_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.prequisite
    ADD CONSTRAINT prequisite_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.prequisite DROP CONSTRAINT prequisite_pkey;
       public            postgres    false    219            �           2606    18195 $   coursedata coursedata_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.coursedata
    ADD CONSTRAINT coursedata_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);
 N   ALTER TABLE ONLY public.coursedata DROP CONSTRAINT coursedata_course_id_fkey;
       public          postgres    false    215    217    3199            �           2606    18190 "   coursedata coursedata_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.coursedata
    ADD CONSTRAINT coursedata_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.pengguna(id);
 L   ALTER TABLE ONLY public.coursedata DROP CONSTRAINT coursedata_user_id_fkey;
       public          postgres    false    3197    217    214            �           2606    18209 $   prequisite prequisite_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prequisite
    ADD CONSTRAINT prequisite_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);
 N   ALTER TABLE ONLY public.prequisite DROP CONSTRAINT prequisite_course_id_fkey;
       public          postgres    false    219    3199    215            �           2606    18214 (   prequisite prequisite_prequisite_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prequisite
    ADD CONSTRAINT prequisite_prequisite_id_fkey FOREIGN KEY (prequisite_id) REFERENCES public.course(id);
 R   ALTER TABLE ONLY public.prequisite DROP CONSTRAINT prequisite_prequisite_id_fkey;
       public          postgres    false    215    219    3199               �  x��U�n�6}����-�^ؽ�ѵ�4m/��җ�4+�ŋJRq�_�CR��N0�&9�3gf���./..�+�9/�7T��lK�m$�h�VѓX�]u��8E��,b/v���u��CuC��>�����w*:��ȶ�����ϪM�b�q�n�!k�+�����p�<�OM�UpHLQ	��2)8S}T�4�Ԛ3�d]��8Ck�m�U(�%�8(M�F�&�r��0aNH4|$#l$���$�b�[c��� �u�Bb,DiB��Su���7���'�G�aS�����PO`�h�&�!5�v�-�]v�dl�n�����P��Ű�Cuպ�ծwхލ����:A��V�8��'5k�'�f�� �t��&�������73SO�p�8 �&�)����d�H��J~���`Q̝�b�9%dㄠ�)Ĉ�EU9aFϝ���q9�KŰ-}��];�'���e��e�t�W���%�R#�n�
#4�p�ՕZ�v��t�DVo�֚c��|��w���(&�o�f����w�Ww�o�^o��4���o�p+X=$�JE�Y�b��ߓȌd�����(
yJ/�(��Λ�LEr�� ݰR�@�;"�=���e;�s�E^�<?�E��5Ԡeo׍ȓ�Q�l<��0���g����B�_����1�����A�$zS�c��+��+�a�x�a;�S����Z�N����v���*��ee:<�a2��'3+A��q]��1��p��c�����n��i�nftA�|j�*u��V���VC� �L��4����؞Hr!�����λ#/J�B�Y��XF��A���ܗ$�fY��4p���� �f��bIi�.h�z L����GZ m���^^<сۼ�����*��$'�v�55\;M{k�����݃D����0i,J?���
�(J���ӧ�i�X�ٿ۳��O��Y         �   x�m�;�0��>'@���P�Rb!$ Q��h��	���3#w�@�n80Qv�x�n��Ͼ�$#��Rq��n���ܗ�s��(�X�eEd��(�y��U&	fH�vb ���YbK��IQ�����H*��%��oVݠj	�7 ��?��O{���%��         �   x�m��j�@D��W���Mv=�dِK�B.Mf��q�Q7���#		;95����hY$I" Gǐ"� U�6*�̯ؑ%t�{�Ӭ��"��U�� %���}��'rN��q�� m]d}���ܠ&��O��v8���A�U�ř��˞���;<�{C���e,�6�q��,qA�Ô<R�o�>BI�'���k$�Φ�>�`�������cG��#��\�?�����(�� A��         &   x�3�t�7400�PF\FP�2�2�0L!�W� $	�     
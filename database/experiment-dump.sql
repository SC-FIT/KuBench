--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Ubuntu 17.4-1.pgdg24.04+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS experiment;
--
-- Name: experiment; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE experiment WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE experiment OWNER TO admin;

\connect experiment

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."group" (
    id integer NOT NULL,
    name text NOT NULL,
    contract_signed timestamp without time zone NOT NULL,
    contract_number integer,
    institute_name text,
    institute_address_name text NOT NULL,
    institute_address_number text,
    institute_postal_code text NOT NULL,
    province text,
    city text NOT NULL,
    country text NOT NULL,
    vat text,
    institute_phone text NOT NULL,
    institute_email text NOT NULL,
    state_id integer NOT NULL,
    priority real NOT NULL,
    responsible_user_id integer
);


ALTER TABLE public."group" OWNER TO admin;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.group_id_seq OWNER TO admin;

--
-- Name: group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    group_id integer NOT NULL,
    state_id integer NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    login text NOT NULL,
    passwd text,
    email text NOT NULL,
    phone text,
    is_dsm_admin boolean NOT NULL,
    is_group_admin boolean NOT NULL,
    is_planner boolean NOT NULL,
    is_support_tech boolean NOT NULL,
    photo text
);


ALTER TABLE public."user" OWNER TO admin;

--
-- Name: usergroupstate; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usergroupstate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.usergroupstate OWNER TO admin;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO admin;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: usergroupstate_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.usergroupstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usergroupstate_id_seq OWNER TO admin;

--
-- Name: usergroupstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.usergroupstate_id_seq OWNED BY public.usergroupstate.id;


--
-- Name: group id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: usergroupstate id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usergroupstate ALTER COLUMN id SET DEFAULT nextval('public.usergroupstate_id_seq'::regclass);


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."group" (id, name, contract_signed, contract_number, institute_name, institute_address_name, institute_address_number, institute_postal_code, province, city, country, vat, institute_phone, institute_email, state_id, priority, responsible_user_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."user" (id, group_id, state_id, name, surname, login, passwd, email, phone, is_dsm_admin, is_group_admin, is_planner, is_support_tech, photo) FROM stdin;
\.


--
-- Data for Name: usergroupstate; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.usergroupstate (id, label) FROM stdin;
\.


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.group_id_seq', 1, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_id_seq', 9, true);


--
-- Name: usergroupstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.usergroupstate_id_seq', 3, true);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: usergroupstate usergroupstate_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usergroupstate
    ADD CONSTRAINT usergroupstate_pkey PRIMARY KEY (id);


--
-- Name: group_contract_number; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX group_contract_number ON public."group" USING btree (contract_number);


--
-- Name: group_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX group_name ON public."group" USING btree (name);


--
-- Name: group_responsible_user_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX group_responsible_user_id ON public."group" USING btree (responsible_user_id);


--
-- Name: group_state_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX group_state_id ON public."group" USING btree (state_id);


--
-- Name: user_group_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_group_id ON public."user" USING btree (group_id);


--
-- Name: user_login; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX user_login ON public."user" USING btree (login);


--
-- Name: user_state_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_state_id ON public."user" USING btree (state_id);


--
-- Name: usergroupstate_label; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX usergroupstate_label ON public.usergroupstate USING btree (label);


--
-- Name: group fk_group_responsible_user_id_refs_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT fk_group_responsible_user_id_refs_user FOREIGN KEY (responsible_user_id) REFERENCES public."user"(id);


--
-- Name: group group_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.usergroupstate(id);


--
-- Name: user user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: user user_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.usergroupstate(id);


--
-- PostgreSQL database dump complete
--


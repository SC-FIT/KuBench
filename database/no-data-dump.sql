--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg24.04+1)

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

DROP DATABASE experiment;
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
-- Name: alert; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alert (
    id integer NOT NULL,
    header text NOT NULL,
    body text NOT NULL,
    created timestamp without time zone NOT NULL,
    expiry timestamp without time zone NOT NULL
);


ALTER TABLE public.alert OWNER TO postgres;

--
-- Name: alert_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alert_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alert_id_seq OWNER TO postgres;

--
-- Name: alert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alert_id_seq OWNED BY public.alert.id;


--
-- Name: alertuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alertuser (
    alert_id integer NOT NULL,
    user_id integer NOT NULL,
    visited boolean NOT NULL
);


ALTER TABLE public.alertuser OWNER TO postgres;

--
-- Name: allocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.allocation (
    id integer NOT NULL,
    name text NOT NULL,
    start_date timestamp without time zone NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    state_id integer NOT NULL,
    priority integer NOT NULL,
    price real NOT NULL,
    currency_id integer NOT NULL
);


ALTER TABLE public.allocation OWNER TO postgres;

--
-- Name: allocation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.allocation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.allocation_id_seq OWNER TO postgres;

--
-- Name: allocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.allocation_id_seq OWNED BY public.allocation.id;


--
-- Name: allocationstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.allocationstate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.allocationstate OWNER TO postgres;

--
-- Name: allocationstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.allocationstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.allocationstate_id_seq OWNER TO postgres;

--
-- Name: allocationstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.allocationstate_id_seq OWNED BY public.allocationstate.id;


--
-- Name: allowedcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.allowedcode (
    id integer NOT NULL,
    hpc_queue_id integer NOT NULL,
    hpc_id integer NOT NULL,
    code_type_id integer NOT NULL,
    implementation_details_id integer NOT NULL,
    modules text
);


ALTER TABLE public.allowedcode OWNER TO postgres;

--
-- Name: allowedcode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.allowedcode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.allowedcode_id_seq OWNER TO postgres;

--
-- Name: allowedcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.allowedcode_id_seq OWNED BY public.allowedcode.id;


--
-- Name: authors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authors (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    surname character varying(255) NOT NULL,
    birth_date date,
    death_date date
);


ALTER TABLE public.authors OWNER TO admin;

--
-- Name: changelogentry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.changelogentry (
    id integer NOT NULL,
    table_name text NOT NULL,
    record_id integer NOT NULL,
    operation_type text NOT NULL,
    "user" integer,
    details text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.changelogentry OWNER TO postgres;

--
-- Name: changelogentry_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.changelogentry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.changelogentry_id_seq OWNER TO postgres;

--
-- Name: changelogentry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.changelogentry_id_seq OWNED BY public.changelogentry.id;


--
-- Name: codetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codetype (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.codetype OWNER TO postgres;

--
-- Name: codetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.codetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.codetype_id_seq OWNER TO postgres;

--
-- Name: codetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.codetype_id_seq OWNED BY public.codetype.id;


--
-- Name: currency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currency (
    id integer NOT NULL,
    name text NOT NULL,
    shortcut text NOT NULL
);


ALTER TABLE public.currency OWNER TO postgres;

--
-- Name: currency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.currency_id_seq OWNER TO postgres;

--
-- Name: currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currency_id_seq OWNED BY public.currency.id;


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- Name: file; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.file (
    id integer NOT NULL,
    job_id integer NOT NULL,
    type_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.file OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.file_id_seq OWNER TO postgres;

--
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;


--
-- Name: filetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filetype (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.filetype OWNER TO postgres;

--
-- Name: filetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filetype_id_seq OWNER TO postgres;

--
-- Name: filetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filetype_id_seq OWNED BY public.filetype.id;


--
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public."group" OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.group_id_seq OWNER TO postgres;

--
-- Name: group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: usergroupstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usergroupstate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.usergroupstate OWNER TO postgres;

--
-- Name: group_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.group_view AS
 SELECT g.id AS group_id,
    g.name,
    g.contract_signed,
    g.contract_number,
    g.institute_name,
    g.institute_address_name,
    g.institute_address_number,
    g.institute_postal_code,
    g.province,
    g.city,
    g.country,
    g.vat,
    g.institute_phone,
    g.institute_email,
    g.priority,
    s.label AS status_name,
    u.id AS responsible_user_id
   FROM ((public."group" g
     JOIN public.usergroupstate s ON ((g.state_id = s.id)))
     LEFT JOIN public."user" u ON ((u.id = g.responsible_user_id)));


ALTER VIEW public.group_view OWNER TO postgres;

--
-- Name: hpc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hpc (
    id integer NOT NULL,
    name text NOT NULL,
    hostname text NOT NULL,
    hpc_state_id integer NOT NULL,
    factor real NOT NULL
);


ALTER TABLE public.hpc OWNER TO postgres;

--
-- Name: hpc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hpc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hpc_id_seq OWNER TO postgres;

--
-- Name: hpc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hpc_id_seq OWNED BY public.hpc.id;


--
-- Name: hpcpurchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hpcpurchase (
    hpc_id integer NOT NULL,
    purchase_id integer NOT NULL
);


ALTER TABLE public.hpcpurchase OWNER TO postgres;

--
-- Name: hpcqueue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hpcqueue (
    id integer NOT NULL,
    hpc_id integer NOT NULL,
    name text NOT NULL,
    max_wall_clock integer NOT NULL,
    nodes_number integer NOT NULL,
    cost_factor real NOT NULL,
    ncpus integer NOT NULL,
    memory real,
    enabled boolean NOT NULL
);


ALTER TABLE public.hpcqueue OWNER TO postgres;

--
-- Name: hpcqueue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hpcqueue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hpcqueue_id_seq OWNER TO postgres;

--
-- Name: hpcqueue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hpcqueue_id_seq OWNED BY public.hpcqueue.id;


--
-- Name: hpcqueueallocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hpcqueueallocation (
    hpc_queue_id integer NOT NULL,
    allocation_id integer NOT NULL,
    cost_per_unit real NOT NULL
);


ALTER TABLE public.hpcqueueallocation OWNER TO postgres;

--
-- Name: hpcstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hpcstate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.hpcstate OWNER TO postgres;

--
-- Name: hpcstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hpcstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hpcstate_id_seq OWNER TO postgres;

--
-- Name: hpcstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hpcstate_id_seq OWNED BY public.hpcstate.id;


--
-- Name: implementationdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.implementationdetails (
    id integer NOT NULL,
    name text NOT NULL,
    is_gpu boolean NOT NULL,
    is_mpi boolean NOT NULL,
    is_omp boolean NOT NULL,
    is_matlab boolean NOT NULL,
    priority integer NOT NULL
);


ALTER TABLE public.implementationdetails OWNER TO postgres;

--
-- Name: implementationdetails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.implementationdetails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.implementationdetails_id_seq OWNER TO postgres;

--
-- Name: implementationdetails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.implementationdetails_id_seq OWNED BY public.implementationdetails.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    id integer NOT NULL,
    treatment_plan_id integer NOT NULL,
    run_id integer,
    status_id integer NOT NULL,
    pbs_id text,
    file_name text,
    last_change_time_stamp timestamp without time zone NOT NULL,
    update_time_stamp timestamp without time zone NOT NULL,
    time_stamp_threshold integer NOT NULL,
    core_hours_reserved real NOT NULL,
    core_hours_used real NOT NULL,
    core_hours_billed real NOT NULL,
    expected_file_size real,
    error_msg text NOT NULL,
    job_phase text NOT NULL,
    progress real NOT NULL,
    nodes_number integer,
    wall_clock integer
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_id_seq OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- Name: jobdependency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobdependency (
    id integer NOT NULL,
    job_id integer NOT NULL,
    predecessor_id integer NOT NULL
);


ALTER TABLE public.jobdependency OWNER TO postgres;

--
-- Name: jobdependency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobdependency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobdependency_id_seq OWNER TO postgres;

--
-- Name: jobdependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobdependency_id_seq OWNED BY public.jobdependency.id;


--
-- Name: jobstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobstate (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.jobstate OWNER TO postgres;

--
-- Name: jobstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobstate_id_seq OWNER TO postgres;

--
-- Name: jobstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobstate_id_seq OWNED BY public.jobstate.id;


--
-- Name: kwavescaling; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kwavescaling (
    id integer NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    z integer NOT NULL,
    resource_id integer NOT NULL,
    job_id integer,
    binary_id integer NOT NULL,
    timestep real NOT NULL,
    timesteps integer NOT NULL,
    code_type_id integer NOT NULL,
    nodes integer NOT NULL,
    threads integer NOT NULL,
    mpi_procs integer NOT NULL,
    is_abs boolean NOT NULL,
    is_linear boolean NOT NULL,
    is_homogeneous boolean NOT NULL,
    is_axisymmetric boolean NOT NULL,
    is_elastic boolean NOT NULL,
    time_stamp timestamp without time zone NOT NULL
);


ALTER TABLE public.kwavescaling OWNER TO postgres;

--
-- Name: kwavescaling_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kwavescaling_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kwavescaling_id_seq OWNER TO postgres;

--
-- Name: kwavescaling_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kwavescaling_id_seq OWNED BY public.kwavescaling.id;


--
-- Name: libraries; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.libraries (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    sigla character varying(255) NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE public.libraries OWNER TO admin;

--
-- Name: library_works; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.library_works (
    library_id uuid NOT NULL,
    work_id uuid NOT NULL
);


ALTER TABLE public.library_works OWNER TO admin;

--
-- Name: license; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.license (
    id integer NOT NULL,
    group_id integer NOT NULL,
    license_number text,
    fingerprint text,
    expiry timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    license_type_id integer NOT NULL,
    license_state_id integer NOT NULL,
    sw_version real NOT NULL,
    message text
);


ALTER TABLE public.license OWNER TO postgres;

--
-- Name: license_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.license_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.license_id_seq OWNER TO postgres;

--
-- Name: license_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.license_id_seq OWNED BY public.license.id;


--
-- Name: licensestate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licensestate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.licensestate OWNER TO postgres;

--
-- Name: licensestate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.licensestate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.licensestate_id_seq OWNER TO postgres;

--
-- Name: licensestate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.licensestate_id_seq OWNED BY public.licensestate.id;


--
-- Name: licensetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licensetype (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.licensetype OWNER TO postgres;

--
-- Name: licensetype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.licensetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.licensetype_id_seq OWNER TO postgres;

--
-- Name: licensetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.licensetype_id_seq OWNED BY public.licensetype.id;


--
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    group_id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    contract_number text NOT NULL,
    state_id integer NOT NULL,
    name text NOT NULL,
    amount real NOT NULL,
    consumed real NOT NULL,
    price real NOT NULL,
    currency_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    unit_factor real NOT NULL
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_id_seq OWNER TO postgres;

--
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
-- Name: purchaseresource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchaseresource (
    id integer NOT NULL,
    name text NOT NULL,
    amount real NOT NULL,
    price real NOT NULL,
    currency_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    purchase_id integer NOT NULL,
    state_id integer NOT NULL
);


ALTER TABLE public.purchaseresource OWNER TO postgres;

--
-- Name: purchaseresource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchaseresource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchaseresource_id_seq OWNER TO postgres;

--
-- Name: purchaseresource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchaseresource_id_seq OWNED BY public.purchaseresource.id;


--
-- Name: purchasestate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchasestate (
    id integer NOT NULL,
    label text NOT NULL
);


ALTER TABLE public.purchasestate OWNER TO postgres;

--
-- Name: purchasestate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchasestate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchasestate_id_seq OWNER TO postgres;

--
-- Name: purchasestate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchasestate_id_seq OWNED BY public.purchasestate.id;


--
-- Name: restartedjobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restartedjobs (
    old_job_id integer NOT NULL,
    new_job_id integer NOT NULL
);


ALTER TABLE public.restartedjobs OWNER TO postgres;

--
-- Name: run; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.run (
    id integer NOT NULL,
    implementation_details_id integer NOT NULL,
    hpc_id integer NOT NULL,
    queue_id integer NOT NULL,
    binary_path text NOT NULL,
    template_name text NOT NULL
);


ALTER TABLE public.run OWNER TO postgres;

--
-- Name: run_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.run_id_seq OWNER TO postgres;

--
-- Name: run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.run_id_seq OWNED BY public.run.id;


--
-- Name: treatmentplan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treatmentplan (
    id integer NOT NULL,
    planner_id integer NOT NULL,
    reviewer_id integer,
    allocation_id integer,
    purchase_id integer,
    hpc_id integer,
    status_id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    progress real NOT NULL,
    base_folder_path text NOT NULL,
    plan_file_name text NOT NULL,
    result_file_name text,
    status_time_stamp timestamp without time zone NOT NULL,
    restarts_number integer NOT NULL,
    max_restarts integer NOT NULL,
    type_name text,
    error_note text,
    remote_cleaned boolean NOT NULL,
    consumed real NOT NULL
);


ALTER TABLE public.treatmentplan OWNER TO postgres;

--
-- Name: treatmentplan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treatmentplan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatmentplan_id_seq OWNER TO postgres;

--
-- Name: treatmentplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treatmentplan_id_seq OWNED BY public.treatmentplan.id;


--
-- Name: treatmentplanstate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.treatmentplanstate (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.treatmentplanstate OWNER TO postgres;

--
-- Name: treatmentplanstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.treatmentplanstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.treatmentplanstate_id_seq OWNER TO postgres;

--
-- Name: treatmentplanstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.treatmentplanstate_id_seq OWNED BY public.treatmentplanstate.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: user_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_view AS
 SELECT u.id AS user_id,
    g.name AS group_name,
    u.name,
    u.surname,
    u.login,
    u.email,
    u.phone,
    s.label AS status_name,
    u.is_dsm_admin,
    u.is_group_admin,
    u.is_planner,
    u.is_support_tech,
    u.photo
   FROM ((public."user" u
     JOIN public.usergroupstate s ON ((u.state_id = s.id)))
     JOIN public."group" g ON ((u.group_id = g.id)));


ALTER VIEW public.user_view OWNER TO postgres;

--
-- Name: usergroupstate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usergroupstate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usergroupstate_id_seq OWNER TO postgres;

--
-- Name: usergroupstate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usergroupstate_id_seq OWNED BY public.usergroupstate.id;


--
-- Name: works; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.works (
    id uuid NOT NULL,
    isbn character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    author_id uuid NOT NULL,
    genre character varying(255),
    publisher character varying(255),
    year integer,
    pages integer,
    language character varying(255),
    description character varying(255),
    type character varying(255)
);


ALTER TABLE public.works OWNER TO admin;

--
-- Name: alert id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alert ALTER COLUMN id SET DEFAULT nextval('public.alert_id_seq'::regclass);


--
-- Name: allocation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation ALTER COLUMN id SET DEFAULT nextval('public.allocation_id_seq'::regclass);


--
-- Name: allocationstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocationstate ALTER COLUMN id SET DEFAULT nextval('public.allocationstate_id_seq'::regclass);


--
-- Name: allowedcode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode ALTER COLUMN id SET DEFAULT nextval('public.allowedcode_id_seq'::regclass);


--
-- Name: changelogentry id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changelogentry ALTER COLUMN id SET DEFAULT nextval('public.changelogentry_id_seq'::regclass);


--
-- Name: codetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codetype ALTER COLUMN id SET DEFAULT nextval('public.codetype_id_seq'::regclass);


--
-- Name: currency id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency ALTER COLUMN id SET DEFAULT nextval('public.currency_id_seq'::regclass);


--
-- Name: file id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);


--
-- Name: filetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filetype ALTER COLUMN id SET DEFAULT nextval('public.filetype_id_seq'::regclass);


--
-- Name: group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);


--
-- Name: hpc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpc ALTER COLUMN id SET DEFAULT nextval('public.hpc_id_seq'::regclass);


--
-- Name: hpcqueue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueue ALTER COLUMN id SET DEFAULT nextval('public.hpcqueue_id_seq'::regclass);


--
-- Name: hpcstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcstate ALTER COLUMN id SET DEFAULT nextval('public.hpcstate_id_seq'::regclass);


--
-- Name: implementationdetails id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.implementationdetails ALTER COLUMN id SET DEFAULT nextval('public.implementationdetails_id_seq'::regclass);


--
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- Name: jobdependency id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobdependency ALTER COLUMN id SET DEFAULT nextval('public.jobdependency_id_seq'::regclass);


--
-- Name: jobstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobstate ALTER COLUMN id SET DEFAULT nextval('public.jobstate_id_seq'::regclass);


--
-- Name: kwavescaling id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling ALTER COLUMN id SET DEFAULT nextval('public.kwavescaling_id_seq'::regclass);


--
-- Name: license id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license ALTER COLUMN id SET DEFAULT nextval('public.license_id_seq'::regclass);


--
-- Name: licensestate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licensestate ALTER COLUMN id SET DEFAULT nextval('public.licensestate_id_seq'::regclass);


--
-- Name: licensetype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licensetype ALTER COLUMN id SET DEFAULT nextval('public.licensetype_id_seq'::regclass);


--
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- Name: purchaseresource id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseresource ALTER COLUMN id SET DEFAULT nextval('public.purchaseresource_id_seq'::regclass);


--
-- Name: purchasestate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchasestate ALTER COLUMN id SET DEFAULT nextval('public.purchasestate_id_seq'::regclass);


--
-- Name: run id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run ALTER COLUMN id SET DEFAULT nextval('public.run_id_seq'::regclass);


--
-- Name: treatmentplan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan ALTER COLUMN id SET DEFAULT nextval('public.treatmentplan_id_seq'::regclass);


--
-- Name: treatmentplanstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplanstate ALTER COLUMN id SET DEFAULT nextval('public.treatmentplanstate_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: usergroupstate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroupstate ALTER COLUMN id SET DEFAULT nextval('public.usergroupstate_id_seq'::regclass);


--
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alert (id, header, body, created, expiry) FROM stdin;
\.


--
-- Data for Name: alertuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alertuser (alert_id, user_id, visited) FROM stdin;
\.


--
-- Data for Name: allocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.allocation (id, name, start_date, expiry_date, state_id, priority, price, currency_id) FROM stdin;
2	MYRIAD-FREE	2024-11-26 13:23:43.79873	2042-02-20 23:59:59	3	0	0	1
1	OPEN-27-69	2024-11-26 13:23:43	2023-10-24 23:59:59	1	0	5000	3
\.


--
-- Data for Name: allocationstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.allocationstate (id, label) FROM stdin;
2	EXPIRED
3	CANCELLED
4	BLOCKED
1	Active
\.


--
-- Data for Name: allowedcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.allowedcode (id, hpc_queue_id, hpc_id, code_type_id, implementation_details_id, modules) FROM stdin;
1	1	2	2	1	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
2	2	2	2	1	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
3	5	2	2	2	HDF5/1.10.7-iimpi-2021a-serial  CUDAcore/11.6.0
4	3	2	2	1	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
5	4	2	2	1	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
6	1	2	1	4	MATLAB/R2015b
7	2	2	1	4	MATLAB/R2015b
8	1	2	6	6	GCC/9.3.0
9	2	2	6	6	GCC/9.3.0
10	1	2	7	7	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
11	2	2	7	7	HDF5/1.10.7-iimpi-2021a-serial FFTW/3.3.9-gompi-2021a imkl/2021.4.0
12	2	2	8	9	GCC/9.3.0
13	1	2	8	9	GCC/9.3.0
14	2	2	9	11	GCC/9.3.0
15	1	2	9	11	GCC/9.3.0
16	1	2	7	12	HDF5/1.10.7-iimpi-2021a-serial
17	2	2	7	12	HDF5/1.10.7-iimpi-2021a-serial
18	2	2	11	14	GCC/9.3.0
19	1	2	11	14	GCC/9.3.0
20	2	2	4	16	GCC/9.3.0
21	1	2	4	16	GCC/9.3.0
22	7	1	6	6	GCC/9.3.0
23	6	1	6	6	GCC/9.3.0
24	6	1	7	7	HDF5/1.10.6-intel-2020a
25	7	1	7	7	HDF5/1.10.6-intel-2020a
26	7	1	8	9	GCC/9.3.0
27	6	1	8	9	GCC/9.3.0
28	7	1	9	11	GCC/9.3.0
29	6	1	9	11	GCC/9.3.0
30	7	1	10	12	HDF5/1.10.6-intel-2020a
31	6	1	10	12	HDF5/1.10.6-intel-2020a
32	7	1	11	14	GCC/9.3.0
33	6	1	11	14	GCC/9.3.0
34	7	1	4	16	GCC/9.3.0
35	6	1	4	16	GCC/9.3.0
36	6	1	2	1	HDF5/1.10.6-intel-2020a
37	7	1	2	1	HDF5/1.10.6-intel-2020a
38	10	1	2	2	HDF5/1.10.6-intel-2020a CUDAcore/11.6.0
39	7	1	12	17	\N
40	6	1	12	17	\N
41	2	2	12	17	\N
42	1	2	12	17	\N
\.


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authors (id, name, surname, birth_date, death_date) FROM stdin;
4c2f3ae1-dbe1-4c87-93f1-73ac75bd8bbd	Petr	Chelcicky	2024-11-01	2024-11-01
dac97342-6a44-47c6-a2f8-744524963820	Antoine	de Saint-Exupéry	1900-06-29	1944-07-31
aad0e4ae-848a-4893-a6bf-fd76a78a78c5	Fyodor	Dostoevsky	1821-11-11	1881-02-09
571a116d-c651-434e-b233-4a405c357081	Herman	Melville	1819-08-01	1891-09-28
39206e26-14c5-419c-8718-be42abb22c7e	Leo	Tolstoy	1828-09-09	1910-11-20
d3da1381-b356-4aad-bc93-17e206c6f295	Fyodor	Dostoevsky	1821-11-11	1881-02-09
\.


--
-- Data for Name: changelogentry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.changelogentry (id, table_name, record_id, operation_type, "user", details, "timestamp") FROM stdin;
1	hpc	1	INSERT	\N	INSERT operation on hpc with ID 1	2024-11-26 13:23:43.695696
2	hpc	2	INSERT	\N	INSERT operation on hpc with ID 2	2024-11-26 13:23:43.700348
3	hpc	3	INSERT	\N	INSERT operation on hpc with ID 3	2024-11-26 13:23:43.705005
4	hpc	4	INSERT	\N	INSERT operation on hpc with ID 4	2024-11-26 13:23:43.708847
5	hpc	5	INSERT	\N	INSERT operation on hpc with ID 5	2024-11-26 13:23:43.713777
6	group	1	INSERT	\N	INSERT operation on group with ID 1	2024-11-26 13:23:43.775738
7	license	1	INSERT	\N	INSERT operation on license with ID 1	2024-11-26 13:23:43.787781
8	allocation	1	INSERT	\N	INSERT operation on allocation with ID 1	2024-11-26 13:23:43.795974
9	allocation	2	INSERT	\N	INSERT operation on allocation with ID 2	2024-11-26 13:23:43.801178
10	group	1	UPDATE	\N	UPDATE operation on group with ID 1	2024-11-26 13:23:43.805922
11	purchase	1	INSERT	\N	INSERT operation on purchase with ID 1	2024-11-26 13:23:43.813837
12	user	1	INSERT	\N	INSERT operation on user with ID 1	2024-11-26 13:23:43.828581
13	user	1	UPDATE	\N	UPDATE operation on user with ID 1	2024-11-26 13:23:43.963217
14	user	2	INSERT	\N	INSERT operation on user with ID 2	2024-11-26 13:23:43.968538
15	user	2	UPDATE	\N	UPDATE operation on user with ID 2	2024-11-26 13:23:44.099565
16	user	3	INSERT	\N	INSERT operation on user with ID 3	2024-11-26 13:23:44.104795
17	user	3	UPDATE	\N	UPDATE operation on user with ID 3	2024-11-26 13:23:44.232947
18	user	4	INSERT	\N	INSERT operation on user with ID 4	2024-11-26 13:23:44.23772
19	user	4	UPDATE	\N	UPDATE operation on user with ID 4	2024-11-26 13:23:44.375989
20	user	5	INSERT	\N	INSERT operation on user with ID 5	2024-11-26 13:23:44.381025
21	user	5	UPDATE	\N	UPDATE operation on user with ID 5	2024-11-26 13:23:44.512649
22	user	6	INSERT	\N	INSERT operation on user with ID 6	2024-11-26 13:23:44.518639
23	user	6	UPDATE	\N	UPDATE operation on user with ID 6	2024-11-26 13:23:44.647632
24	user	7	INSERT	\N	INSERT operation on user with ID 7	2024-11-26 13:23:44.654862
25	user	7	UPDATE	\N	UPDATE operation on user with ID 7	2024-11-26 13:23:44.786699
26	user	8	INSERT	\N	INSERT operation on user with ID 8	2024-11-26 13:23:44.791932
27	user	8	UPDATE	\N	UPDATE operation on user with ID 8	2024-11-26 13:23:44.923703
28	user	9	INSERT	\N	INSERT operation on user with ID 9	2024-11-26 13:23:44.928337
29	user	9	UPDATE	\N	UPDATE operation on user with ID 9	2024-11-26 13:23:45.05929
30	codetype	1	INSERT	\N	INSERT operation on codetype with ID 1	2024-11-26 13:23:45.10527
31	codetype	2	INSERT	\N	INSERT operation on codetype with ID 2	2024-11-26 13:23:45.109231
32	codetype	3	INSERT	\N	INSERT operation on codetype with ID 3	2024-11-26 13:23:45.113077
33	codetype	4	INSERT	\N	INSERT operation on codetype with ID 4	2024-11-26 13:23:45.117434
34	codetype	5	INSERT	\N	INSERT operation on codetype with ID 5	2024-11-26 13:23:45.12155
35	codetype	6	INSERT	\N	INSERT operation on codetype with ID 6	2024-11-26 13:23:45.12598
36	codetype	7	INSERT	\N	INSERT operation on codetype with ID 7	2024-11-26 13:23:45.129887
37	codetype	8	INSERT	\N	INSERT operation on codetype with ID 8	2024-11-26 13:23:45.133833
38	codetype	9	INSERT	\N	INSERT operation on codetype with ID 9	2024-11-26 13:23:45.137853
39	codetype	10	INSERT	\N	INSERT operation on codetype with ID 10	2024-11-26 13:23:45.142253
40	codetype	11	INSERT	\N	INSERT operation on codetype with ID 11	2024-11-26 13:23:45.146205
41	codetype	12	INSERT	\N	INSERT operation on codetype with ID 12	2024-11-26 13:23:45.150869
42	hpcqueue	1	INSERT	\N	INSERT operation on hpcqueue with ID 1	2024-11-26 13:23:45.155731
43	hpcqueue	2	INSERT	\N	INSERT operation on hpcqueue with ID 2	2024-11-26 13:23:45.160595
44	hpcqueue	3	INSERT	\N	INSERT operation on hpcqueue with ID 3	2024-11-26 13:23:45.165684
45	hpcqueue	4	INSERT	\N	INSERT operation on hpcqueue with ID 4	2024-11-26 13:23:45.170398
46	hpcqueue	5	INSERT	\N	INSERT operation on hpcqueue with ID 5	2024-11-26 13:23:45.175296
47	hpcqueue	6	INSERT	\N	INSERT operation on hpcqueue with ID 6	2024-11-26 13:23:45.18161
48	hpcqueue	7	INSERT	\N	INSERT operation on hpcqueue with ID 7	2024-11-26 13:23:45.191357
49	hpcqueue	8	INSERT	\N	INSERT operation on hpcqueue with ID 8	2024-11-26 13:23:45.201696
50	hpcqueue	9	INSERT	\N	INSERT operation on hpcqueue with ID 9	2024-11-26 13:23:45.208837
51	hpcqueue	10	INSERT	\N	INSERT operation on hpcqueue with ID 10	2024-11-26 13:23:45.213628
52	hpcqueue	11	INSERT	\N	INSERT operation on hpcqueue with ID 11	2024-11-26 13:23:45.218816
53	hpcqueue	12	INSERT	\N	INSERT operation on hpcqueue with ID 12	2024-11-26 13:23:45.223694
54	implementationdetails	1	INSERT	\N	INSERT operation on implementationdetails with ID 1	2024-11-26 13:23:45.235583
55	implementationdetails	2	INSERT	\N	INSERT operation on implementationdetails with ID 2	2024-11-26 13:23:45.240289
56	implementationdetails	3	INSERT	\N	INSERT operation on implementationdetails with ID 3	2024-11-26 13:23:45.24513
57	implementationdetails	4	INSERT	\N	INSERT operation on implementationdetails with ID 4	2024-11-26 13:23:45.249638
58	implementationdetails	5	INSERT	\N	INSERT operation on implementationdetails with ID 5	2024-11-26 13:23:45.253831
59	implementationdetails	6	INSERT	\N	INSERT operation on implementationdetails with ID 6	2024-11-26 13:23:45.258358
60	implementationdetails	7	INSERT	\N	INSERT operation on implementationdetails with ID 7	2024-11-26 13:23:45.263286
61	implementationdetails	8	INSERT	\N	INSERT operation on implementationdetails with ID 8	2024-11-26 13:23:45.267746
62	implementationdetails	9	INSERT	\N	INSERT operation on implementationdetails with ID 9	2024-11-26 13:23:45.272184
63	implementationdetails	10	INSERT	\N	INSERT operation on implementationdetails with ID 10	2024-11-26 13:23:45.276801
64	implementationdetails	11	INSERT	\N	INSERT operation on implementationdetails with ID 11	2024-11-26 13:23:45.281132
65	implementationdetails	12	INSERT	\N	INSERT operation on implementationdetails with ID 12	2024-11-26 13:23:45.28641
66	implementationdetails	13	INSERT	\N	INSERT operation on implementationdetails with ID 13	2024-11-26 13:23:45.29057
67	implementationdetails	14	INSERT	\N	INSERT operation on implementationdetails with ID 14	2024-11-26 13:23:45.294469
68	implementationdetails	15	INSERT	\N	INSERT operation on implementationdetails with ID 15	2024-11-26 13:23:45.298388
69	implementationdetails	16	INSERT	\N	INSERT operation on implementationdetails with ID 16	2024-11-26 13:23:45.303022
70	implementationdetails	17	INSERT	\N	INSERT operation on implementationdetails with ID 17	2024-11-26 13:23:45.307157
71	allowedcode	1	INSERT	\N	INSERT operation on allowedcode with ID 1	2024-11-26 13:23:45.376484
72	allowedcode	2	INSERT	\N	INSERT operation on allowedcode with ID 2	2024-11-26 13:23:45.381345
73	allowedcode	3	INSERT	\N	INSERT operation on allowedcode with ID 3	2024-11-26 13:23:45.386483
74	allowedcode	4	INSERT	\N	INSERT operation on allowedcode with ID 4	2024-11-26 13:23:45.390694
75	allowedcode	5	INSERT	\N	INSERT operation on allowedcode with ID 5	2024-11-26 13:23:45.394801
76	allowedcode	6	INSERT	\N	INSERT operation on allowedcode with ID 6	2024-11-26 13:23:45.399309
77	allowedcode	7	INSERT	\N	INSERT operation on allowedcode with ID 7	2024-11-26 13:23:45.404515
78	allowedcode	8	INSERT	\N	INSERT operation on allowedcode with ID 8	2024-11-26 13:23:45.411872
79	allowedcode	9	INSERT	\N	INSERT operation on allowedcode with ID 9	2024-11-26 13:23:45.420298
80	allowedcode	10	INSERT	\N	INSERT operation on allowedcode with ID 10	2024-11-26 13:23:45.429225
81	allowedcode	11	INSERT	\N	INSERT operation on allowedcode with ID 11	2024-11-26 13:23:45.434284
82	allowedcode	12	INSERT	\N	INSERT operation on allowedcode with ID 12	2024-11-26 13:23:45.438866
83	allowedcode	13	INSERT	\N	INSERT operation on allowedcode with ID 13	2024-11-26 13:23:45.443721
84	allowedcode	14	INSERT	\N	INSERT operation on allowedcode with ID 14	2024-11-26 13:23:45.449597
85	allowedcode	15	INSERT	\N	INSERT operation on allowedcode with ID 15	2024-11-26 13:23:45.456117
86	allowedcode	16	INSERT	\N	INSERT operation on allowedcode with ID 16	2024-11-26 13:23:45.461808
87	allowedcode	17	INSERT	\N	INSERT operation on allowedcode with ID 17	2024-11-26 13:23:45.467025
88	allowedcode	18	INSERT	\N	INSERT operation on allowedcode with ID 18	2024-11-26 13:23:45.471678
89	allowedcode	19	INSERT	\N	INSERT operation on allowedcode with ID 19	2024-11-26 13:23:45.476345
90	allowedcode	20	INSERT	\N	INSERT operation on allowedcode with ID 20	2024-11-26 13:23:45.481062
91	allowedcode	21	INSERT	\N	INSERT operation on allowedcode with ID 21	2024-11-26 13:23:45.486404
92	allowedcode	22	INSERT	\N	INSERT operation on allowedcode with ID 22	2024-11-26 13:23:45.490522
93	allowedcode	23	INSERT	\N	INSERT operation on allowedcode with ID 23	2024-11-26 13:23:45.495101
94	allowedcode	24	INSERT	\N	INSERT operation on allowedcode with ID 24	2024-11-26 13:23:45.499322
95	allowedcode	25	INSERT	\N	INSERT operation on allowedcode with ID 25	2024-11-26 13:23:45.505503
96	allowedcode	26	INSERT	\N	INSERT operation on allowedcode with ID 26	2024-11-26 13:23:45.509695
97	allowedcode	27	INSERT	\N	INSERT operation on allowedcode with ID 27	2024-11-26 13:23:45.514093
98	allowedcode	28	INSERT	\N	INSERT operation on allowedcode with ID 28	2024-11-26 13:23:45.519041
99	allowedcode	29	INSERT	\N	INSERT operation on allowedcode with ID 29	2024-11-26 13:23:45.523636
100	allowedcode	30	INSERT	\N	INSERT operation on allowedcode with ID 30	2024-11-26 13:23:45.527819
101	allowedcode	31	INSERT	\N	INSERT operation on allowedcode with ID 31	2024-11-26 13:23:45.531997
102	allowedcode	32	INSERT	\N	INSERT operation on allowedcode with ID 32	2024-11-26 13:23:45.53676
103	allowedcode	33	INSERT	\N	INSERT operation on allowedcode with ID 33	2024-11-26 13:23:45.541349
104	allowedcode	34	INSERT	\N	INSERT operation on allowedcode with ID 34	2024-11-26 13:23:45.546241
105	allowedcode	35	INSERT	\N	INSERT operation on allowedcode with ID 35	2024-11-26 13:23:45.551127
106	allowedcode	36	INSERT	\N	INSERT operation on allowedcode with ID 36	2024-11-26 13:23:45.557006
107	allowedcode	37	INSERT	\N	INSERT operation on allowedcode with ID 37	2024-11-26 13:23:45.565357
108	allowedcode	38	INSERT	\N	INSERT operation on allowedcode with ID 38	2024-11-26 13:23:45.57263
109	allowedcode	39	INSERT	\N	INSERT operation on allowedcode with ID 39	2024-11-26 13:23:45.576906
110	allowedcode	40	INSERT	\N	INSERT operation on allowedcode with ID 40	2024-11-26 13:23:45.582677
111	allowedcode	41	INSERT	\N	INSERT operation on allowedcode with ID 41	2024-11-26 13:23:45.588258
112	allowedcode	42	INSERT	\N	INSERT operation on allowedcode with ID 42	2024-11-26 13:23:45.59289
113	run	1	INSERT	\N	INSERT operation on run with ID 1	2024-11-26 13:23:45.603695
114	run	2	INSERT	\N	INSERT operation on run with ID 2	2024-11-26 13:23:45.611962
115	run	3	INSERT	\N	INSERT operation on run with ID 3	2024-11-26 13:23:45.618647
116	run	4	INSERT	\N	INSERT operation on run with ID 4	2024-11-26 13:23:45.626822
117	run	5	INSERT	\N	INSERT operation on run with ID 5	2024-11-26 13:23:45.63868
118	run	6	INSERT	\N	INSERT operation on run with ID 6	2024-11-26 13:23:45.645503
119	run	7	INSERT	\N	INSERT operation on run with ID 7	2024-11-26 13:23:45.653216
120	run	8	INSERT	\N	INSERT operation on run with ID 8	2024-11-26 13:23:45.659356
121	run	9	INSERT	\N	INSERT operation on run with ID 9	2024-11-26 13:23:45.66799
122	run	10	INSERT	\N	INSERT operation on run with ID 10	2024-11-26 13:23:45.674436
123	run	11	INSERT	\N	INSERT operation on run with ID 11	2024-11-26 13:23:45.680803
124	run	12	INSERT	\N	INSERT operation on run with ID 12	2024-11-26 13:23:45.691717
125	run	13	INSERT	\N	INSERT operation on run with ID 13	2024-11-26 13:23:45.698062
126	run	14	INSERT	\N	INSERT operation on run with ID 14	2024-11-26 13:23:45.706077
127	run	15	INSERT	\N	INSERT operation on run with ID 15	2024-11-26 13:23:45.715428
128	run	16	INSERT	\N	INSERT operation on run with ID 16	2024-11-26 13:23:45.723565
129	run	17	INSERT	\N	INSERT operation on run with ID 17	2024-11-26 13:23:45.731987
130	run	18	INSERT	\N	INSERT operation on run with ID 18	2024-11-26 13:23:45.739764
131	run	19	INSERT	\N	INSERT operation on run with ID 19	2024-11-26 13:23:45.748502
132	run	20	INSERT	\N	INSERT operation on run with ID 20	2024-11-26 13:23:45.758644
133	run	21	INSERT	\N	INSERT operation on run with ID 21	2024-11-26 13:23:45.767427
134	run	22	INSERT	\N	INSERT operation on run with ID 22	2024-11-26 13:23:45.776186
135	run	23	INSERT	\N	INSERT operation on run with ID 23	2024-11-26 13:23:45.784833
136	run	24	INSERT	\N	INSERT operation on run with ID 24	2024-11-26 13:23:45.797039
137	run	25	INSERT	\N	INSERT operation on run with ID 25	2024-11-26 13:23:45.806027
138	run	26	INSERT	\N	INSERT operation on run with ID 26	2024-11-26 13:23:45.81387
139	run	27	INSERT	\N	INSERT operation on run with ID 27	2024-11-26 13:23:45.824568
140	run	28	INSERT	\N	INSERT operation on run with ID 28	2024-11-26 13:23:45.835252
141	run	29	INSERT	\N	INSERT operation on run with ID 29	2024-11-26 13:23:45.847834
142	run	30	INSERT	\N	INSERT operation on run with ID 30	2024-11-26 13:23:45.855326
143	run	31	INSERT	\N	INSERT operation on run with ID 31	2024-11-26 13:23:45.86755
144	run	32	INSERT	\N	INSERT operation on run with ID 32	2024-11-26 13:23:45.875362
145	run	33	INSERT	\N	INSERT operation on run with ID 33	2024-11-26 13:23:45.886839
146	run	34	INSERT	\N	INSERT operation on run with ID 34	2024-11-26 13:23:45.893803
147	run	35	INSERT	\N	INSERT operation on run with ID 35	2024-11-26 13:23:45.901842
148	run	36	INSERT	\N	INSERT operation on run with ID 36	2024-11-26 13:23:45.911268
149	run	37	INSERT	\N	INSERT operation on run with ID 37	2024-11-26 13:23:45.927449
150	run	38	INSERT	\N	INSERT operation on run with ID 38	2024-11-26 13:23:45.93485
151	run	39	INSERT	\N	INSERT operation on run with ID 39	2024-11-26 13:23:45.941554
152	run	40	INSERT	\N	INSERT operation on run with ID 40	2024-11-26 13:23:45.949437
153	run	41	INSERT	\N	INSERT operation on run with ID 41	2024-11-26 13:23:45.957855
154	run	42	INSERT	\N	INSERT operation on run with ID 42	2024-11-26 13:23:45.966081
155	run	43	INSERT	\N	INSERT operation on run with ID 43	2024-11-26 13:23:45.973891
156	run	44	INSERT	\N	INSERT operation on run with ID 44	2024-11-26 13:23:45.984345
157	run	45	INSERT	\N	INSERT operation on run with ID 45	2024-11-26 13:23:45.992961
158	run	46	INSERT	\N	INSERT operation on run with ID 46	2024-11-26 13:23:45.99952
159	run	47	INSERT	\N	INSERT operation on run with ID 47	2024-11-26 13:23:46.007122
160	run	48	INSERT	\N	INSERT operation on run with ID 48	2024-11-26 13:23:46.01422
161	run	49	INSERT	\N	INSERT operation on run with ID 49	2024-11-26 13:23:46.022541
162	run	50	INSERT	\N	INSERT operation on run with ID 50	2024-11-26 13:23:46.030417
163	run	51	INSERT	\N	INSERT operation on run with ID 51	2024-11-26 13:23:46.037262
164	run	52	INSERT	\N	INSERT operation on run with ID 52	2024-11-26 13:23:46.04388
165	run	53	INSERT	\N	INSERT operation on run with ID 53	2024-11-26 13:23:46.053706
166	run	54	INSERT	\N	INSERT operation on run with ID 54	2024-11-26 13:23:46.062989
167	run	55	INSERT	\N	INSERT operation on run with ID 55	2024-11-26 13:23:46.074251
168	run	56	INSERT	\N	INSERT operation on run with ID 56	2024-11-26 13:23:46.087286
169	run	57	INSERT	\N	INSERT operation on run with ID 57	2024-11-26 13:23:46.09568
170	run	58	INSERT	\N	INSERT operation on run with ID 58	2024-11-26 13:23:46.101837
171	run	59	INSERT	\N	INSERT operation on run with ID 59	2024-11-26 13:23:46.107677
172	run	60	INSERT	\N	INSERT operation on run with ID 60	2024-11-26 13:23:46.114928
173	run	61	INSERT	\N	INSERT operation on run with ID 61	2024-11-26 13:23:46.122812
174	run	62	INSERT	\N	INSERT operation on run with ID 62	2024-11-26 13:23:46.131423
175	run	63	INSERT	\N	INSERT operation on run with ID 63	2024-11-26 13:23:46.141713
\.


--
-- Data for Name: codetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codetype (id, name) FROM stdin;
1	PREPROCESSOR
2	ULTRASOUND_SIM
3	MIDPROCESSOR
4	THERMAL_SIM
5	POSTPROCESSOR
6	ABERRATION_CORRECTION_PREPROCESSOR
7	ABERRATION_CORRECTION_SIMULATION
8	ABERRATION_CORRECTION_POSTPROCESSOR
9	FORWARD_PLANNING_PREPROCESSOR
10	FORWARD_PLANNING_SIMULATION
11	FORWARD_PLANNING_POSTPROCESSOR
12	CLEANING
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currency (id, name, shortcut) FROM stdin;
1	czech crown	CZK
3	czech crownpo	CLK
2	czech crownopl	CPK
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1	Sauer	db/changelog/changes/initial_schema.xml	2024-10-31 18:23:13.894748	1	EXECUTED	9:65ab3f47978ef29571fee20a32c9329a	createTable tableName=libraries		\N	4.27.0	\N	\N	0398993839
2	Sauer	db/changelog/changes/initial_schema.xml	2024-10-31 18:23:13.912616	2	EXECUTED	9:2ab9aef524ffe7a608904b28af9ccb5a	createTable tableName=authors		\N	4.27.0	\N	\N	0398993839
3	Sauer	db/changelog/changes/initial_schema.xml	2024-10-31 18:23:13.941892	3	EXECUTED	9:ba3d124e83439f4287e0b99d6237f73d	createTable tableName=works; addForeignKeyConstraint baseTableName=works, constraintName=fk_works_author, referencedTableName=authors		\N	4.27.0	\N	\N	0398993839
4	Sauer	db/changelog/changes/initial_schema.xml	2024-10-31 18:23:13.959785	4	EXECUTED	9:4e2830c865816bb25e3a6b9b765fbddd	createTable tableName=library_works; addPrimaryKey constraintName=pk_library_works, tableName=library_works; addForeignKeyConstraint baseTableName=library_works, constraintName=fk_library_works_library, referencedTableName=libraries; addForeignKey...		\N	4.27.0	\N	\N	0398993839
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.file (id, job_id, type_id, name) FROM stdin;
\.


--
-- Data for Name: filetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filetype (id, label) FROM stdin;
1	INPUT
2	OUTPUT
3	ERR
4	LOG
5	SSCRIPT
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (id, name, contract_signed, contract_number, institute_name, institute_address_name, institute_address_number, institute_postal_code, province, city, country, vat, institute_phone, institute_email, state_id, priority, responsible_user_id) FROM stdin;
1	SCFIT	2024-11-26 13:23:43	12345	Supercomputing technologies research group	Bozetechova	2	61266	\N	Brno	Czech republic	\N	111222333	nobody@fit.vutbr.cz	1	0	\N
2	TECHLAB	2024-11-10 08:26:15.321	23456	Technology Innovation Lab	Techstreet	15	11000		Prague	Czech republic		222333444	contact@techlab.cz	1	5	\N
3	DATASC	2024-10-20 09:07:13.456	34567	Data Science Institute	Data Avenue	8A	20000		Ostrava	Czech republic		333444555	datasc@vut.cz	2	3	\N
4	ROBOTIC	2024-12-01 13:55:09.101	45678	Robotics and AI Research	Robo Lane	42	70000		Zlin	Czech republic		444555666	robotics@ai.cz	3	4	\N
5	MEDTECH	2024-11-05 15:32:37.233	56789	Medical Technology Center	Health Blvd	10	40000		Pilsen	Czech republic		555666777	medtech@pilsen.cz	2	6	\N
6	AERORES	2024-09-15 10:28:39.654	67890	Aerospace Research Hub	Flight Street	25	30000		Liberec	Czech republic		666777888	aero@liberec.cz	1	8	\N
7	BIOENG	2024-10-01 08:36:24.987	78901	Bioengineering Solutions	Bio Way	50	60000		Olomouc	Czech republic		777888999	bio@olomouc.cz	2	9	\N
8	NANOMAT	2024-11-18 16:52:30.112	89012	Nanomaterials Research	Nano Drive	7	50000		Hradec Kralove	Czech republic		888999000	nano@hradec.cz	3	2	\N
9	ITSEC	2024-12-03 12:39:38.344	90123	IT Security Group	Secure Blvd	99	80000		Usti nad Labem	Czech republic		999000111	security@usti.cz	1	10	\N
10	ENERGYX	2024-11-29 14:19:21.677	1234	Energy Research Center	Power Avenue	18	90000		Karlovy Vary	Czech republic		000111222	energy@karlovy.cz	2	7	\N
\.


--
-- Data for Name: hpc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hpc (id, name, hostname, hpc_state_id, factor) FROM stdin;
1	karolina	karolina.it4i.cz	1	1
2	barbora	barbora.it4i.cz	1	1
3	mock	mock-hostname	1	0
4	myriad	myriad.rc.ucl.ac.uk	1	0
5	bell	112.112.112.112	1	0
\.


--
-- Data for Name: hpcpurchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hpcpurchase (hpc_id, purchase_id) FROM stdin;
2	1
1	1
5	1
\.


--
-- Data for Name: hpcqueue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hpcqueue (id, hpc_id, name, max_wall_clock, nodes_number, cost_factor, ncpus, memory, enabled) FROM stdin;
1	2	qcpu_exp	60	16	0.4	36	192	t
2	2	qcpu	2880	190	0.4	36	192	t
3	2	qcpu_long	8640	20	0.4	36	192	t
4	2	qfat	2880	1	0.4	128	6144	t
5	2	qgpu	2880	8	1.5	24	16	t
6	1	qcpu_exp	60	4	0.4	128	192	t
7	1	qcpu	2880	190	0.4	128	192	t
8	1	qcpu_long	8640	20	0.4	128	192	t
9	1	qfat	2880	1	0.4	128	6144	t
10	1	qgpu	2880	8	1.5	128	16	t
11	4	B	60	16	0	36	\N	t
12	4	D	60	285	0	36	\N	t
\.


--
-- Data for Name: hpcqueueallocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hpcqueueallocation (hpc_queue_id, allocation_id, cost_per_unit) FROM stdin;
7	1	1
\.


--
-- Data for Name: hpcstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hpcstate (id, label) FROM stdin;
1	RUNNING
2	DOWN
3	ELIMINATED
\.


--
-- Data for Name: implementationdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.implementationdetails (id, name, is_gpu, is_mpi, is_omp, is_matlab, priority) FROM stdin;
1	kspace_first_order_omp	f	f	t	f	0
2	kspace_first_order_gpu	t	f	f	f	0
3	kspace_first_order_mpi	f	t	f	f	0
4	kwave_preprocessor	f	f	f	t	0
5	aberration_correction_preprocessor	f	f	f	t	0
6	aberration_correction_preprocessor_compiled	f	f	f	f	0
7	kspace_first_order_omp	f	f	t	f	0
8	aberration_correction_postprocessor	f	f	f	t	0
9	aberration_correction_postprocessor_compiled	f	f	f	f	0
10	forward_planning_preprocessor	f	f	f	t	0
11	forward_planning_preprocessor_compiled	f	f	f	f	0
12	kspace_first_order_omp	f	f	t	f	0
13	forward_planning_postprocessor	f	f	f	t	0
14	forward_planning_postprocessor_compiled	f	f	f	f	0
15	thermal_simulation	f	f	f	t	0
16	thermal_simulation_compiled	f	f	f	f	0
17	remove_files_and_directories	f	f	f	f	0
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (id, treatment_plan_id, run_id, status_id, pbs_id, file_name, last_change_time_stamp, update_time_stamp, time_stamp_threshold, core_hours_reserved, core_hours_used, core_hours_billed, expected_file_size, error_msg, job_phase, progress, nodes_number, wall_clock) FROM stdin;
2	1	44	4	1944011	jscript_neurostim_2024-11-25_16-55-43_0_0.pbs	2024-11-25 17:08:31.36	2024-11-25 17:08:31.361	300	2.4	0.17916666	0.071666665	\N	None	FORWARD_PLANNING_PREPROCESSOR	0	1	360
3	1	61	4	1944012	jscript_neurostim_2024-11-25_16-55-43_1_0.pbs	2024-11-25 17:56:33.975	2024-11-25 17:56:33.979	300	36	0.7786111	1.1679167	\N	None	FORWARD_PLANNING_SIMULATION	0	1	1440
4	1	50	4	1944013	jscript_neurostim_2024-11-25_16-55-43_2_0.pbs	2024-11-25 18:12:30.85	2024-11-25 18:12:30.852	300	2.4	0.26055557	0.10422223	\N	None	FORWARD_PLANNING_POSTPROCESSOR	0	1	360
5	1	55	4	1944014	jscript_neurostim_2024-11-25_16-55-43_3_0.pbs	2024-11-25 18:12:32.089	2024-11-25 18:12:32.094	300	1.5	0.02638889	0.039583337	\N	None	THERMAL_SIM	0	1	60
\.


--
-- Data for Name: jobdependency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobdependency (id, job_id, predecessor_id) FROM stdin;
1	3	2
2	4	3
3	5	4
\.


--
-- Data for Name: jobstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobstate (id, name) FROM stdin;
1	NEW
2	QUEUED
3	RUNNING
4	COMPLETE
5	HOLD
6	DELETED
7	ERROR
8	FAILED
9	TRANSFERRED
10	TO_SUBMIT
\.


--
-- Data for Name: kwavescaling; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kwavescaling (id, x, y, z, resource_id, job_id, binary_id, timestep, timesteps, code_type_id, nodes, threads, mpi_procs, is_abs, is_linear, is_homogeneous, is_axisymmetric, is_elastic, time_stamp) FROM stdin;
\.


--
-- Data for Name: libraries; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.libraries (id, name, sigla, address) FROM stdin;
2394def0-7a64-4d91-9886-304740190e0a	Brno	BRN001	Samalova 13, 61500 Brno
3c3595ab-35c7-4ac3-b0c6-696bdbbdc2fb	Prague	PRG001	Náměstí Republiky 5, 11000 Prague
4fb6bd1e-444d-4b40-a7a6-29da199bb8d0	Ostrava	OST001	Masarykovo náměstí 12, 70200 Ostrava
10dcd0de-3aad-49cc-8e7f-03d909612147	Olomouc	OLM001	Horní náměstí 20, 77900 Olomouc
f18d832c-31dd-410d-ab88-df13ab2884cf	Plzeň	PLZ001	Plzeňská 8, 30100 Plzeň
ded82a87-5f2b-4ef4-9778-2c78a8088602	České Budějovice	CBU001	Senovážné náměstí 18, 37001 České Budějovice
\.


--
-- Data for Name: library_works; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.library_works (library_id, work_id) FROM stdin;
2394def0-7a64-4d91-9886-304740190e0a	23f77bb1-282f-46b1-8f92-d58abdf55137
3c3595ab-35c7-4ac3-b0c6-696bdbbdc2fb	35d2f49c-3c7d-40f8-8462-0f3ba1336b2d
4fb6bd1e-444d-4b40-a7a6-29da199bb8d0	569004f2-b665-4c2b-af68-e01ce1958d3b
10dcd0de-3aad-49cc-8e7f-03d909612147	9bac9610-33cf-4d09-817b-b3a125806c66
f18d832c-31dd-410d-ab88-df13ab2884cf	c0713517-7d38-4ec9-b4b1-dfae09be440e
ded82a87-5f2b-4ef4-9778-2c78a8088602	b4bd7a76-698e-4be6-b587-0c966dd98c6a
\.


--
-- Data for Name: license; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.license (id, group_id, license_number, fingerprint, expiry, created, license_type_id, license_state_id, sw_version, message) FROM stdin;
1	1	AAA	BBB	2050-12-31 23:59:59	2024-11-26 13:23:43.784309	1	1	1	
\.


--
-- Data for Name: licensestate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licensestate (id, label) FROM stdin;
1	VALID
2	INVALID
3	EXPIRED
\.


--
-- Data for Name: licensetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licensetype (id, label) FROM stdin;
1	EDUCATIONAL
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase (id, group_id, date, contract_number, state_id, name, amount, consumed, price, currency_id, start_date, expiry_date, unit_factor) FROM stdin;
1	1	2022-06-14 23:59:59	1234567	1	test	100	23	5000	2	2022-06-24 23:59:59	2032-06-24 23:59:59	1
\.


--
-- Data for Name: purchaseresource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchaseresource (id, name, amount, price, currency_id, start_date, expiry_date, purchase_id, state_id) FROM stdin;
1	dummyname	1000	1548.95	1	2024-06-27 16:03:18.757135	2024-06-27 16:03:18.757139	1	2
\.


--
-- Data for Name: purchasestate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchasestate (id, label) FROM stdin;
1	ACTIVE
2	EXPIRED
3	CANCELLED
4	BLOCKED
\.


--
-- Data for Name: restartedjobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restartedjobs (old_job_id, new_job_id) FROM stdin;
\.


--
-- Data for Name: run; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.run (id, implementation_details_id, hpc_id, queue_id, binary_path, template_name) FROM stdin;
1	17	2	1	rm -f	general_pbs
2	17	2	2	rm -f	general_pbs
3	17	1	6	rm -f	general_pbs
4	17	1	7	rm -f	general_pbs
5	1	2	1	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	general_pbs
6	1	2	2	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	general_pbs
7	1	2	3	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	general_pbs
8	2	2	5	/home/icudova/dispatcher/programs/kspaceFirstOrder-CUDA	general_pbs
9	4	2	1	/home/icudova/dispatcher/programs/Preprocessor/GenerateInputFile	matlab_pbs
10	4	2	2	/home/icudova/dispatcher/programs/Preprocessor/GenerateInputFile	matlab_pbs
11	5	2	1	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPreProc	matlab_pbs
12	5	2	2	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPreProc	matlab_pbs
13	6	2	2	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPreProcC	general_pbs
14	6	2	1	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPreProcC	general_pbs
15	7	2	1	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
16	7	2	2	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
17	7	2	5	/home/icudova/dispatcher/programs/kspaceFirstOrder-CUDA	retrieve_args_pbs
18	8	2	1	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPostProc	matlab_pbs
19	8	2	2	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPostProc	matlab_pbs
20	9	2	2	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPostProcC	general_pbs
21	9	2	1	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPostProcC	general_pbs
22	10	2	1	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPreProc	matlab_pbs
23	10	2	2	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPreProc	matlab_pbs
24	11	2	2	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPreProcC	general_pbs
25	11	2	1	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPreProcC	general_pbs
26	12	2	1	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
27	12	2	2	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
28	12	2	5	/home/icudova/dispatcher/programs/kspaceFirstOrder-CUDA	retrieve_args_pbs
29	13	2	1	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPostProc	matlab_pbs
30	13	2	2	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPostProc	matlab_pbs
31	14	2	2	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPostProcC	general_pbs
32	14	2	1	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPostProcC	general_pbs
33	15	2	1	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/runThermalSimulations	matlab_pbs
34	15	2	2	/home/icudova/dispatcher/programs/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/runThermalSimulations	matlab_pbs
35	16	2	2	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/runThermalSimulationsC	general_pbs
36	16	2	1	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/runThermalSimulationsC	general_pbs
37	6	1	7	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPreProcC	general_pbs
38	6	1	6	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPreProcC	general_pbs
39	5	1	6	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPreProc	matlab_pbs
40	5	1	7	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPreProc	matlab_pbs
41	7	1	7	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
42	7	1	6	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
43	9	1	7	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPostProcC	general_pbs
44	9	1	6	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/aberrationCorrectionPostProcC	general_pbs
45	8	1	6	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPostProc	matlab_pbs
46	8	1	7	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/aberrationCorrectionPostProc	matlab_pbs
47	11	1	7	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPreProcC	general_pbs
48	11	1	6	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPreProcC	general_pbs
49	10	1	6	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPreProc	matlab_pbs
50	10	1	7	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPreProc	matlab_pbs
51	12	1	7	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
52	12	1	6	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	retrieve_args_pbs
53	14	1	7	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPostProcC	general_pbs
54	14	1	6	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/forwardPlanningPostProcC	general_pbs
55	13	1	6	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPostProc	matlab_pbs
56	13	1	7	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/forwardPlanningPostProc	matlab_pbs
57	16	1	7	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/runThermalSimulationsC	general_pbs
58	16	1	6	/home/icudova/dispatcher/programs/k-Plan/k-Plan/binaries/runThermalSimulationsC	general_pbs
59	15	1	6	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/runThermalSimulations	matlab_pbs
60	15	1	7	/home/icudova/dispatcher/programms/k-wave-matlab-neurostim/k-plan-qms-sem/toolbox/runThermalSimulations	matlab_pbs
61	1	1	6	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	general_pbs
62	1	1	7	/home/icudova/dispatcher/programs/kspaceFirstOrder-OMP	general_pbs
63	2	1	10	/home/icudova/dispatcher/programs/kspaceFirstOrder-CUDA	general_pbs
\.


--
-- Data for Name: treatmentplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treatmentplan (id, planner_id, reviewer_id, allocation_id, purchase_id, hpc_id, status_id, date, progress, base_folder_path, plan_file_name, result_file_name, status_time_stamp, restarts_number, max_restarts, type_name, error_note, remote_cleaned, consumed) FROM stdin;
1	5	6	1	1	2	2	2024-11-26 13:23:46.145306	0	/base/folder/	plan.h5	\N	2024-11-26 13:23:46.145313	0	5	\N	\N	f	0
5	1	\N	1	1	\N	1	2024-11-26 13:23:46	0	/home	plan.h5	\N	2024-11-26 13:23:46	0	5	\N	\N	f	0
\.


--
-- Data for Name: treatmentplanstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.treatmentplanstate (id, name) FROM stdin;
1	NEW
2	RUNNING
3	COMPLETE
4	DELETED
5	ERROR
6	CLOSED
7	TO_DELETE
8	PROCESSING
9	PARTIALLY_SUBMITTED
10	FINALIZED
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, group_id, state_id, name, surname, login, passwd, email, phone, is_dsm_admin, is_group_admin, is_planner, is_support_tech, photo) FROM stdin;
1	1	1	Planner	tester	planner2	scrypt:32768:8:1$vguoc0b3r5WnFmHX$c13240311280510b1b18175241c1f7869d9d754472ac7015b03da9a9b7b4bfc96a983534ca96cdbfb413a12be72c37693da627876b5dfa5b7b485dbc1f917fcb	planner2@email	111222333	f	f	t	f	\N
5	1	1	Planner	tester	planner	scrypt:32768:8:1$vguoc0b3r5WnFmHX$c13240311280510b1b18175241c1f7869d9d754472ac7015b03da9a9b7b4bfc96a983534ca96cdbfb413a12be72c37693da627876b5dfa5b7b485dbc1f917fcb	planner@email	111222333	f	f	t	f	
6	1	1	Reviewer	tester	reviewer	scrypt:32768:8:1$OwtZwk7ibJiB4xCs$be2d3356c1b03966e097be29292470ea2d146f96a69770381b6b0b41da1b351dd183244644a053bbbae9d84d7b71dcefd201501fd82c1e79109332e8ccb7aa04	reviewer@email	111222333	f	f	f	f	
7	1	1	DSM	admin	dsmadmin	scrypt:32768:8:1$xjInMhOaobWHQWFQ$e723ced4d9906cb3eaf2b4909031d49e0922f4cc4aafec56d7192a401dc1467309ed322d411b02aff5d9afd2f37ec81cf3a76192ebc4b2e8a25c6b4f4f9711f3	dsmadmin@email	111222333	t	f	f	f	
8	1	1	Group	Admin	groupadmin	scrypt:32768:8:1$8n3Bx8SJWW9ugGYB$94dc69c6949479e71bd15446718dcf9bc53386e2ab06eaece3fedb7064d89bbfdfa6afd8d9ed61917697fca91cf4ee1b6297d464ce57d4bf6ecca52bb320796b	reviewer@email	111222333	f	t	f	f	
9	1	1	Zero	Tester	zerotester	scrypt:32768:8:1$Pc3iLpLDqPcmr7Mw$765a72646dff70184f0accf7543934d280753e8875e1c301af77a384200ca0c86ef33547493b26623b3b3899be4231578caa1a3ad9368b82f150bb66f38cdc5d	zero@email	111222333	f	f	f	f	
10	2	2	Planner	New	plannernew	scrypt:32768:8:1$2j3hfb7MpxQWztyN$a7c1a203fb847f6d3958c7ab76c2b77a0de17fa4d85442b89080c4b683dff3f002c6e7e6fd172381c9b4c5d1e5f74892d6f1b4cb81c6b52e5bda99a8e1a01cbf	plannernew@email	123456789	f	f	t	f	
11	2	2	Reviewer	New	reviewernew	scrypt:32768:8:1$f5aNn6xkGp98BdOz$3f98b76e1d284c8b476f97e673aec7f49138dbfc738e08d2675c4e30617b9827c0ec331e8dc1b4975b759c679d291f6f2e74c8b29a16f51412632406b42fa24	reviewernew@email	123456789	f	f	f	f	
12	2	2	DSM	Admin	dsmadmin2	scrypt:32768:8:1$n4kTmW7AzXQWzNbP$2ac49f831547e7d8abf65939e617d2c5e80b5a83c7892e94c2a5a4b38f8fc19e730edc4e4bcb6df46ad438c685fdd472e397f9bc94390f47f329db2a46b9b571	dsmadmin2@email	123456789	t	f	f	f	
13	2	2	Group	Admin	groupadmin2	scrypt:32768:8:1$k8M2b3HpWxXfyMzL$b3f287df4b6c79e5e374d2c8a4d8e6a98a7dfc9e2b5a34f1b3c5d8e92d84c8a723ebd2e6e76b3c7d98c29a487b6494a2e5b79c8b4d3f8b271c5b4e9f8e12345	groupadmin2@email	123456789	f	t	f	f	
14	2	2	User	Tester	usertester	scrypt:32768:8:1$p9x2Lm2aXgPzb7Oc$81d6b2c794a76d2b385e7f86a3e8c7498f379c7d284f938b5a2c6e8f7c192e47f3c8b6d72e93847e68f293e8b4d87f5a629b37a485f1e92a7e3b6f8b73e1c41	usertester@email	123456789	f	f	f	f	
15	3	3	Support	Tech	supporttech	scrypt:32768:8:1$72jMp7Nx6QgPz4Lc$293f8d7643a7e5b8c9a7f5e3293d6f8b947c2d8f6a384c7b5f93827d4e6a7b7c2938d7f8a6e2b3947c5f9a3e7d6c84b5a3f6b7d2938f5e7a3c6d2f5e8b9a27c	supporttech@email	987654321	f	f	f	t	
16	3	3	Planner	Junior	juniorplanner	scrypt:32768:8:1$e8k3zMn4XpZb7LyP$8b2f7d4c5a9e2c8d2937b5f6e8b7a4d6f2e9c4b8a5f7d3c8e6b2a9c5f8e9b7a3d4f8b7c2a9e3b6d7f5c8a9e7b6d5f8a3e9b2c6f8d7a5c4b3e8f7b9a3d	juniorplanner@email	987654321	f	f	t	f	
17	3	3	Admin	Manager	adminmanager	scrypt:32768:8:1$o7N2k4Zp3jLm8WxP$9b7e3c5d8a4f2c9e7a3d5f8b6a2c7f3d8e9a4b7f6c3e8a9d2b6f7c8a5d3e9b2a7f8c4b5e6d7a9c3f5b8d6e2a9b7f4c3d8e6a5b7f3c9d2b4e8f6a9c3	adminmanager@email	987654321	t	t	f	f	
18	3	3	Zero	User	zerouser	scrypt:32768:8:1$4P7zN9kLmXq3b2jO$7c5e2a9b8f4d6c3e7f8b5a9d4c6e2a7b8f5c3d9a2e6b7f3c8d5a4b7e9c3f6a8b2d5e7f3c9a4d8b6a7f5c2e8b3d7a9c4f8e5b3d7c6a2b8f9a3e6b7c5d2	zerouser@email	987654321	f	f	f	f	
\.


--
-- Data for Name: usergroupstate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usergroupstate (id, label) FROM stdin;
3	BLOCKED
1	ACTIVE
2	INACTIVE
\.


--
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.works (id, isbn, title, author_id, genre, publisher, year, pages, language, description, type) FROM stdin;
23f77bb1-282f-46b1-8f92-d58abdf55137	1324548513168	Duna	4c2f3ae1-dbe1-4c87-93f1-73ac75bd8bbd	Skyfy	Albatros	1995	1032	Czekish	Book about muslim like prophet	0
35d2f49c-3c7d-40f8-8462-0f3ba1336b2d	1234567890123	The Little Prince	dac97342-6a44-47c6-a2f8-744524963820	Fable	Gallimard	1943	96	French	A story about the importance of friendship and love	0
569004f2-b665-4c2b-af68-e01ce1958d3b	9876543210987	Crime and Punishment	aad0e4ae-848a-4893-a6bf-fd76a78a78c5	Philosophical Fiction	The Russian Messenger	1866	671	Russian	A philosophical exploration of morality and redemption	0
9bac9610-33cf-4d09-817b-b3a125806c66	1111111111111	Moby Dick	571a116d-c651-434e-b233-4a405c357081	Adventure	Harper & Brothers	1851	635	English	The saga of Captain Ahab’s quest to take down a giant whale	0
c0713517-7d38-4ec9-b4b1-dfae09be440e	2222222222222	War and Peace	39206e26-14c5-419c-8718-be42abb22c7e	Historical Fiction	The Russian Messenger	1869	1225	Russian	An epic narrative on Russian society during the Napoleonic Era	0
b4bd7a76-698e-4be6-b587-0c966dd98c6a	3333333333333	The Brothers Karamazov	d3da1381-b356-4aad-bc93-17e206c6f295	Philosophical Fiction	The Russian Messenger	1880	796	Russian	A story exploring faith, family, and moral dilemmas	0
\.


--
-- Name: alert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alert_id_seq', 1, false);


--
-- Name: allocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.allocation_id_seq', 2, true);


--
-- Name: allocationstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.allocationstate_id_seq', 4, true);


--
-- Name: allowedcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.allowedcode_id_seq', 42, true);


--
-- Name: changelogentry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.changelogentry_id_seq', 175, true);


--
-- Name: codetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.codetype_id_seq', 12, true);


--
-- Name: currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currency_id_seq', 1, true);


--
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.file_id_seq', 1, false);


--
-- Name: filetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filetype_id_seq', 5, true);


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_id_seq', 1, true);


--
-- Name: hpc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hpc_id_seq', 5, true);


--
-- Name: hpcqueue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hpcqueue_id_seq', 12, true);


--
-- Name: hpcstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hpcstate_id_seq', 3, true);


--
-- Name: implementationdetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.implementationdetails_id_seq', 17, true);


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_id_seq', 5, true);


--
-- Name: jobdependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobdependency_id_seq', 3, true);


--
-- Name: jobstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobstate_id_seq', 10, true);


--
-- Name: kwavescaling_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kwavescaling_id_seq', 1, false);


--
-- Name: license_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.license_id_seq', 1, true);


--
-- Name: licensestate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licensestate_id_seq', 3, true);


--
-- Name: licensetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licensetype_id_seq', 1, true);


--
-- Name: purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_id_seq', 1, true);


--
-- Name: purchaseresource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchaseresource_id_seq', 1, true);


--
-- Name: purchasestate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchasestate_id_seq', 4, true);


--
-- Name: run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.run_id_seq', 63, true);


--
-- Name: treatmentplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treatmentplan_id_seq', 1, true);


--
-- Name: treatmentplanstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.treatmentplanstate_id_seq', 10, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 9, true);


--
-- Name: usergroupstate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usergroupstate_id_seq', 3, true);


--
-- Name: alert alert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);


--
-- Name: alertuser alertuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertuser
    ADD CONSTRAINT alertuser_pkey PRIMARY KEY (alert_id, user_id);


--
-- Name: allocation allocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_pkey PRIMARY KEY (id);


--
-- Name: allocationstate allocationstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocationstate
    ADD CONSTRAINT allocationstate_pkey PRIMARY KEY (id);


--
-- Name: allowedcode allowedcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode
    ADD CONSTRAINT allowedcode_pkey PRIMARY KEY (id);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: changelogentry changelogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.changelogentry
    ADD CONSTRAINT changelogentry_pkey PRIMARY KEY (id);


--
-- Name: codetype codetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.codetype
    ADD CONSTRAINT codetype_pkey PRIMARY KEY (id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- Name: filetype filetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filetype
    ADD CONSTRAINT filetype_pkey PRIMARY KEY (id);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: hpc hpc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpc
    ADD CONSTRAINT hpc_pkey PRIMARY KEY (id);


--
-- Name: hpcpurchase hpcpurchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcpurchase
    ADD CONSTRAINT hpcpurchase_pkey PRIMARY KEY (hpc_id, purchase_id);


--
-- Name: hpcqueue hpcqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueue
    ADD CONSTRAINT hpcqueue_pkey PRIMARY KEY (id);


--
-- Name: hpcqueueallocation hpcqueueallocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueueallocation
    ADD CONSTRAINT hpcqueueallocation_pkey PRIMARY KEY (hpc_queue_id, allocation_id);


--
-- Name: hpcstate hpcstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcstate
    ADD CONSTRAINT hpcstate_pkey PRIMARY KEY (id);


--
-- Name: implementationdetails implementationdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.implementationdetails
    ADD CONSTRAINT implementationdetails_pkey PRIMARY KEY (id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: jobdependency jobdependency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobdependency
    ADD CONSTRAINT jobdependency_pkey PRIMARY KEY (id);


--
-- Name: jobstate jobstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobstate
    ADD CONSTRAINT jobstate_pkey PRIMARY KEY (id);


--
-- Name: kwavescaling kwavescaling_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling
    ADD CONSTRAINT kwavescaling_pkey PRIMARY KEY (id);


--
-- Name: libraries libraries_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.libraries
    ADD CONSTRAINT libraries_name_key UNIQUE (name);


--
-- Name: libraries libraries_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.libraries
    ADD CONSTRAINT libraries_pkey PRIMARY KEY (id);


--
-- Name: libraries libraries_sigla_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.libraries
    ADD CONSTRAINT libraries_sigla_key UNIQUE (sigla);


--
-- Name: license license_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_pkey PRIMARY KEY (id);


--
-- Name: licensestate licensestate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licensestate
    ADD CONSTRAINT licensestate_pkey PRIMARY KEY (id);


--
-- Name: licensetype licensetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licensetype
    ADD CONSTRAINT licensetype_pkey PRIMARY KEY (id);


--
-- Name: library_works pk_library_works; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.library_works
    ADD CONSTRAINT pk_library_works PRIMARY KEY (library_id, work_id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: purchaseresource purchaseresource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseresource
    ADD CONSTRAINT purchaseresource_pkey PRIMARY KEY (id);


--
-- Name: purchasestate purchasestate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchasestate
    ADD CONSTRAINT purchasestate_pkey PRIMARY KEY (id);


--
-- Name: restartedjobs restartedjobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restartedjobs
    ADD CONSTRAINT restartedjobs_pkey PRIMARY KEY (old_job_id, new_job_id);


--
-- Name: run run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_pkey PRIMARY KEY (id);


--
-- Name: treatmentplan treatmentplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_pkey PRIMARY KEY (id);


--
-- Name: treatmentplanstate treatmentplanstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplanstate
    ADD CONSTRAINT treatmentplanstate_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: usergroupstate usergroupstate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usergroupstate
    ADD CONSTRAINT usergroupstate_pkey PRIMARY KEY (id);


--
-- Name: works works_isbn_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_isbn_key UNIQUE (isbn);


--
-- Name: works works_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_pkey PRIMARY KEY (id);


--
-- Name: alertuser_alert_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX alertuser_alert_id ON public.alertuser USING btree (alert_id);


--
-- Name: alertuser_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX alertuser_user_id ON public.alertuser USING btree (user_id);


--
-- Name: allocation_currency_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allocation_currency_id ON public.allocation USING btree (currency_id);


--
-- Name: allocation_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX allocation_name ON public.allocation USING btree (name);


--
-- Name: allocation_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allocation_state_id ON public.allocation USING btree (state_id);


--
-- Name: allocationstate_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX allocationstate_label ON public.allocationstate USING btree (label);


--
-- Name: allowedcode_code_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allowedcode_code_type_id ON public.allowedcode USING btree (code_type_id);


--
-- Name: allowedcode_hpc_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allowedcode_hpc_id ON public.allowedcode USING btree (hpc_id);


--
-- Name: allowedcode_hpc_queue_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allowedcode_hpc_queue_id ON public.allowedcode USING btree (hpc_queue_id);


--
-- Name: allowedcode_implementation_details_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX allowedcode_implementation_details_id ON public.allowedcode USING btree (implementation_details_id);


--
-- Name: codetype_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX codetype_name ON public.codetype USING btree (name);


--
-- Name: currency_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX currency_name ON public.currency USING btree (name);


--
-- Name: currency_shortcut; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX currency_shortcut ON public.currency USING btree (shortcut);


--
-- Name: file_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX file_job_id ON public.file USING btree (job_id);


--
-- Name: file_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX file_type_id ON public.file USING btree (type_id);


--
-- Name: filetype_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX filetype_label ON public.filetype USING btree (label);


--
-- Name: group_contract_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX group_contract_number ON public."group" USING btree (contract_number);


--
-- Name: group_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX group_name ON public."group" USING btree (name);


--
-- Name: group_responsible_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX group_responsible_user_id ON public."group" USING btree (responsible_user_id);


--
-- Name: group_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX group_state_id ON public."group" USING btree (state_id);


--
-- Name: hpc_hostname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hpc_hostname ON public.hpc USING btree (hostname);


--
-- Name: hpc_hpc_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpc_hpc_state_id ON public.hpc USING btree (hpc_state_id);


--
-- Name: hpc_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hpc_name ON public.hpc USING btree (name);


--
-- Name: hpcpurchase_hpc_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpcpurchase_hpc_id ON public.hpcpurchase USING btree (hpc_id);


--
-- Name: hpcpurchase_purchase_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpcpurchase_purchase_id ON public.hpcpurchase USING btree (purchase_id);


--
-- Name: hpcqueue_hpc_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpcqueue_hpc_id ON public.hpcqueue USING btree (hpc_id);


--
-- Name: hpcqueueallocation_allocation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpcqueueallocation_allocation_id ON public.hpcqueueallocation USING btree (allocation_id);


--
-- Name: hpcqueueallocation_hpc_queue_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hpcqueueallocation_hpc_queue_id ON public.hpcqueueallocation USING btree (hpc_queue_id);


--
-- Name: hpcstate_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX hpcstate_label ON public.hpcstate USING btree (label);


--
-- Name: job_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_run_id ON public.job USING btree (run_id);


--
-- Name: job_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_status_id ON public.job USING btree (status_id);


--
-- Name: job_treatment_plan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_treatment_plan_id ON public.job USING btree (treatment_plan_id);


--
-- Name: jobdependency_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobdependency_job_id ON public.jobdependency USING btree (job_id);


--
-- Name: jobdependency_predecessor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobdependency_predecessor_id ON public.jobdependency USING btree (predecessor_id);


--
-- Name: jobstate_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX jobstate_name ON public.jobstate USING btree (name);


--
-- Name: kwavescaling_binary_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kwavescaling_binary_id ON public.kwavescaling USING btree (binary_id);


--
-- Name: kwavescaling_code_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kwavescaling_code_type_id ON public.kwavescaling USING btree (code_type_id);


--
-- Name: kwavescaling_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kwavescaling_job_id ON public.kwavescaling USING btree (job_id);


--
-- Name: kwavescaling_resource_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kwavescaling_resource_id ON public.kwavescaling USING btree (resource_id);


--
-- Name: license_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX license_group_id ON public.license USING btree (group_id);


--
-- Name: license_license_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX license_license_number ON public.license USING btree (license_number);


--
-- Name: license_license_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX license_license_state_id ON public.license USING btree (license_state_id);


--
-- Name: license_license_type_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX license_license_type_id ON public.license USING btree (license_type_id);


--
-- Name: licensestate_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX licensestate_label ON public.licensestate USING btree (label);


--
-- Name: licensetype_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX licensetype_label ON public.licensetype USING btree (label);


--
-- Name: purchase_contract_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX purchase_contract_number ON public.purchase USING btree (contract_number);


--
-- Name: purchase_currency_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchase_currency_id ON public.purchase USING btree (currency_id);


--
-- Name: purchase_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchase_group_id ON public.purchase USING btree (group_id);


--
-- Name: purchase_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX purchase_name ON public.purchase USING btree (name);


--
-- Name: purchase_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchase_state_id ON public.purchase USING btree (state_id);


--
-- Name: purchaseresource_currency_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchaseresource_currency_id ON public.purchaseresource USING btree (currency_id);


--
-- Name: purchaseresource_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX purchaseresource_name ON public.purchaseresource USING btree (name);


--
-- Name: purchaseresource_purchase_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchaseresource_purchase_id ON public.purchaseresource USING btree (purchase_id);


--
-- Name: purchaseresource_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX purchaseresource_state_id ON public.purchaseresource USING btree (state_id);


--
-- Name: purchasestate_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX purchasestate_label ON public.purchasestate USING btree (label);


--
-- Name: restartedjobs_new_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX restartedjobs_new_job_id ON public.restartedjobs USING btree (new_job_id);


--
-- Name: restartedjobs_old_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX restartedjobs_old_job_id ON public.restartedjobs USING btree (old_job_id);


--
-- Name: run_hpc_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX run_hpc_id ON public.run USING btree (hpc_id);


--
-- Name: run_implementation_details_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX run_implementation_details_id ON public.run USING btree (implementation_details_id);


--
-- Name: run_queue_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX run_queue_id ON public.run USING btree (queue_id);


--
-- Name: treatmentplan_allocation_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_allocation_id ON public.treatmentplan USING btree (allocation_id);


--
-- Name: treatmentplan_hpc_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_hpc_id ON public.treatmentplan USING btree (hpc_id);


--
-- Name: treatmentplan_planner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_planner_id ON public.treatmentplan USING btree (planner_id);


--
-- Name: treatmentplan_purchase_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_purchase_id ON public.treatmentplan USING btree (purchase_id);


--
-- Name: treatmentplan_reviewer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_reviewer_id ON public.treatmentplan USING btree (reviewer_id);


--
-- Name: treatmentplan_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX treatmentplan_status_id ON public.treatmentplan USING btree (status_id);


--
-- Name: treatmentplanstate_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX treatmentplanstate_name ON public.treatmentplanstate USING btree (name);


--
-- Name: user_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_group_id ON public."user" USING btree (group_id);


--
-- Name: user_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_login ON public."user" USING btree (login);


--
-- Name: user_state_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_state_id ON public."user" USING btree (state_id);


--
-- Name: usergroupstate_label; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX usergroupstate_label ON public.usergroupstate USING btree (label);


--
-- Name: alertuser alertuser_alert_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertuser
    ADD CONSTRAINT alertuser_alert_id_fkey FOREIGN KEY (alert_id) REFERENCES public.alert(id);


--
-- Name: alertuser alertuser_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertuser
    ADD CONSTRAINT alertuser_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: allocation allocation_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(id);


--
-- Name: allocation allocation_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allocation
    ADD CONSTRAINT allocation_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.allocationstate(id);


--
-- Name: allowedcode allowedcode_code_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode
    ADD CONSTRAINT allowedcode_code_type_id_fkey FOREIGN KEY (code_type_id) REFERENCES public.codetype(id);


--
-- Name: allowedcode allowedcode_hpc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode
    ADD CONSTRAINT allowedcode_hpc_id_fkey FOREIGN KEY (hpc_id) REFERENCES public.hpc(id);


--
-- Name: allowedcode allowedcode_hpc_queue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode
    ADD CONSTRAINT allowedcode_hpc_queue_id_fkey FOREIGN KEY (hpc_queue_id) REFERENCES public.hpcqueue(id);


--
-- Name: allowedcode allowedcode_implementation_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.allowedcode
    ADD CONSTRAINT allowedcode_implementation_details_id_fkey FOREIGN KEY (implementation_details_id) REFERENCES public.implementationdetails(id);


--
-- Name: file file_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(id);


--
-- Name: file file_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.filetype(id);


--
-- Name: group fk_group_responsible_user_id_refs_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT fk_group_responsible_user_id_refs_user FOREIGN KEY (responsible_user_id) REFERENCES public."user"(id);


--
-- Name: library_works fk_library_works_library; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.library_works
    ADD CONSTRAINT fk_library_works_library FOREIGN KEY (library_id) REFERENCES public.libraries(id);


--
-- Name: library_works fk_library_works_work; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.library_works
    ADD CONSTRAINT fk_library_works_work FOREIGN KEY (work_id) REFERENCES public.works(id);


--
-- Name: works fk_works_author; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT fk_works_author FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- Name: group group_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.usergroupstate(id);


--
-- Name: hpc hpc_hpc_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpc
    ADD CONSTRAINT hpc_hpc_state_id_fkey FOREIGN KEY (hpc_state_id) REFERENCES public.hpcstate(id);


--
-- Name: hpcpurchase hpcpurchase_hpc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcpurchase
    ADD CONSTRAINT hpcpurchase_hpc_id_fkey FOREIGN KEY (hpc_id) REFERENCES public.hpc(id);


--
-- Name: hpcpurchase hpcpurchase_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcpurchase
    ADD CONSTRAINT hpcpurchase_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(id);


--
-- Name: hpcqueue hpcqueue_hpc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueue
    ADD CONSTRAINT hpcqueue_hpc_id_fkey FOREIGN KEY (hpc_id) REFERENCES public.hpc(id);


--
-- Name: hpcqueueallocation hpcqueueallocation_allocation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueueallocation
    ADD CONSTRAINT hpcqueueallocation_allocation_id_fkey FOREIGN KEY (allocation_id) REFERENCES public.allocation(id);


--
-- Name: hpcqueueallocation hpcqueueallocation_hpc_queue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hpcqueueallocation
    ADD CONSTRAINT hpcqueueallocation_hpc_queue_id_fkey FOREIGN KEY (hpc_queue_id) REFERENCES public.hpcqueue(id);


--
-- Name: job job_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(id);


--
-- Name: job job_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.jobstate(id);


--
-- Name: job job_treatment_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_treatment_plan_id_fkey FOREIGN KEY (treatment_plan_id) REFERENCES public.treatmentplan(id);


--
-- Name: jobdependency jobdependency_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobdependency
    ADD CONSTRAINT jobdependency_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(id);


--
-- Name: jobdependency jobdependency_predecessor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobdependency
    ADD CONSTRAINT jobdependency_predecessor_id_fkey FOREIGN KEY (predecessor_id) REFERENCES public.job(id);


--
-- Name: kwavescaling kwavescaling_binary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling
    ADD CONSTRAINT kwavescaling_binary_id_fkey FOREIGN KEY (binary_id) REFERENCES public.run(id);


--
-- Name: kwavescaling kwavescaling_code_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling
    ADD CONSTRAINT kwavescaling_code_type_id_fkey FOREIGN KEY (code_type_id) REFERENCES public.codetype(id);


--
-- Name: kwavescaling kwavescaling_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling
    ADD CONSTRAINT kwavescaling_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(id);


--
-- Name: kwavescaling kwavescaling_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kwavescaling
    ADD CONSTRAINT kwavescaling_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.hpc(id);


--
-- Name: license license_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: license license_license_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_license_state_id_fkey FOREIGN KEY (license_state_id) REFERENCES public.licensestate(id);


--
-- Name: license license_license_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.license
    ADD CONSTRAINT license_license_type_id_fkey FOREIGN KEY (license_type_id) REFERENCES public.licensetype(id);


--
-- Name: purchase purchase_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(id);


--
-- Name: purchase purchase_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: purchase purchase_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.purchasestate(id);


--
-- Name: restartedjobs restartedjobs_new_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restartedjobs
    ADD CONSTRAINT restartedjobs_new_job_id_fkey FOREIGN KEY (new_job_id) REFERENCES public.job(id);


--
-- Name: restartedjobs restartedjobs_old_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restartedjobs
    ADD CONSTRAINT restartedjobs_old_job_id_fkey FOREIGN KEY (old_job_id) REFERENCES public.job(id);


--
-- Name: run run_hpc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_hpc_id_fkey FOREIGN KEY (hpc_id) REFERENCES public.hpc(id);


--
-- Name: run run_implementation_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_implementation_details_id_fkey FOREIGN KEY (implementation_details_id) REFERENCES public.implementationdetails(id);


--
-- Name: run run_queue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_queue_id_fkey FOREIGN KEY (queue_id) REFERENCES public.hpcqueue(id);


--
-- Name: treatmentplan treatmentplan_allocation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_allocation_id_fkey FOREIGN KEY (allocation_id) REFERENCES public.allocation(id);


--
-- Name: treatmentplan treatmentplan_hpc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_hpc_id_fkey FOREIGN KEY (hpc_id) REFERENCES public.hpc(id);


--
-- Name: treatmentplan treatmentplan_planner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_planner_id_fkey FOREIGN KEY (planner_id) REFERENCES public."user"(id);


--
-- Name: treatmentplan treatmentplan_purchase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(id);


--
-- Name: treatmentplan treatmentplan_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public."user"(id);


--
-- Name: treatmentplan treatmentplan_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.treatmentplan
    ADD CONSTRAINT treatmentplan_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.treatmentplanstate(id);


--
-- Name: user user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_group_id_fkey FOREIGN KEY (group_id) REFERENCES public."group"(id);


--
-- Name: user user_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.usergroupstate(id);


--
-- PostgreSQL database dump complete
--


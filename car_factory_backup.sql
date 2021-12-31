--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: bds; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bds;


ALTER SCHEMA bds OWNER TO postgres;

--
-- Name: SCHEMA bds; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA bds IS 'standard public schema';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA bds;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: insert_employee(bigint, character varying, character varying, character varying, bigint); Type: PROCEDURE; Schema: bds; Owner: postgres
--

CREATE PROCEDURE bds.insert_employee(IN bigint, IN character varying, IN character varying, IN character varying, IN bigint)
    LANGUAGE plpgsql
    AS $_$
BEGIN
INSERT INTO public.employee(employee_id, first_name, surname, mail,building_id) values ($1,$2,$3,$4,$5);
COMMIT;

END;
$_$;


ALTER PROCEDURE bds.insert_employee(IN bigint, IN character varying, IN character varying, IN character varying, IN bigint) OWNER TO postgres;

--
-- Name: new_employee(); Type: FUNCTION; Schema: bds; Owner: postgres
--

CREATE FUNCTION bds.new_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
RAISE NOTICE 'New employee in company!';
RETURN NEW;
END;
$$;


ALTER FUNCTION bds.new_employee() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.address (
    address_id bigint NOT NULL,
    city character varying(45) NOT NULL,
    street character varying(45) NOT NULL,
    street_number character varying(45),
    zip_code character varying(45)
);


ALTER TABLE bds.address OWNER TO postgres;

--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.address_address_id_seq OWNER TO postgres;

--
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.address_address_id_seq OWNED BY bds.address.address_id;


--
-- Name: building; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.building (
    building_id bigint NOT NULL,
    building_name character varying(45) NOT NULL
);


ALTER TABLE bds.building OWNER TO postgres;

--
-- Name: building_building_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.building_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.building_building_id_seq OWNER TO postgres;

--
-- Name: building_building_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.building_building_id_seq OWNED BY bds.building.building_id;


--
-- Name: car; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.car (
    car_id bigint NOT NULL,
    car_brand character varying(45) NOT NULL,
    car_color character varying(45) NOT NULL,
    customer_id bigint
);


ALTER TABLE bds.car OWNER TO postgres;

--
-- Name: car_car_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_car_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_car_id_seq OWNER TO postgres;

--
-- Name: car_car_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_car_id_seq OWNED BY bds.car.car_id;


--
-- Name: car_customer_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_customer_id_seq OWNER TO postgres;

--
-- Name: car_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_customer_id_seq OWNED BY bds.car.customer_id;


--
-- Name: car_has_workers; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.car_has_workers (
    car_id bigint NOT NULL,
    employee_id bigint NOT NULL,
    deadline date
);


ALTER TABLE bds.car_has_workers OWNER TO postgres;

--
-- Name: car_has_workers_car_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_has_workers_car_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_has_workers_car_id_seq OWNER TO postgres;

--
-- Name: car_has_workers_car_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_has_workers_car_id_seq OWNED BY bds.car_has_workers.car_id;


--
-- Name: car_has_workers_employee_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_has_workers_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_has_workers_employee_id_seq OWNER TO postgres;

--
-- Name: car_has_workers_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_has_workers_employee_id_seq OWNED BY bds.car_has_workers.employee_id;


--
-- Name: car_in_building; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.car_in_building (
    car_id bigint NOT NULL,
    building_id bigint NOT NULL,
    parts character varying(45) NOT NULL
);


ALTER TABLE bds.car_in_building OWNER TO postgres;

--
-- Name: car_in_building_building_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_in_building_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_in_building_building_id_seq OWNER TO postgres;

--
-- Name: car_in_building_building_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_in_building_building_id_seq OWNED BY bds.car_in_building.building_id;


--
-- Name: car_in_building_car_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.car_in_building_car_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.car_in_building_car_id_seq OWNER TO postgres;

--
-- Name: car_in_building_car_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.car_in_building_car_id_seq OWNED BY bds.car_in_building.car_id;


--
-- Name: car_view; Type: MATERIALIZED VIEW; Schema: bds; Owner: postgres
--

CREATE MATERIALIZED VIEW bds.car_view AS
 SELECT DISTINCT e.car_id,
    e.car_brand,
    e.customer_id,
    chw.employee_id,
    cib.parts,
    cib.building_id
   FROM ((bds.car e
     JOIN bds.car_has_workers chw ON ((e.car_id = chw.car_id)))
     JOIN bds.car_in_building cib ON ((chw.car_id = cib.car_id)))
  WITH NO DATA;


ALTER TABLE bds.car_view OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.customer (
    customer_id bigint NOT NULL,
    customer_f_name character varying(45) NOT NULL,
    customer_s_name character varying(45) NOT NULL,
    car_id bigint NOT NULL
);


ALTER TABLE bds.customer OWNER TO postgres;

--
-- Name: customer_car_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.customer_car_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.customer_car_id_seq OWNER TO postgres;

--
-- Name: customer_car_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.customer_car_id_seq OWNED BY bds.customer.car_id;


--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.customer_customer_id_seq OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.customer_customer_id_seq OWNED BY bds.customer.customer_id;


--
-- Name: dummy_table; Type: TABLE; Schema: bds; Owner: batman
--

CREATE TABLE bds.dummy_table (
    employee_id integer NOT NULL,
    name character varying(40) NOT NULL,
    email character varying(40) NOT NULL
);


ALTER TABLE bds.dummy_table OWNER TO batman;

--
-- Name: dummy_table_employee_id_seq; Type: SEQUENCE; Schema: bds; Owner: batman
--

CREATE SEQUENCE bds.dummy_table_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.dummy_table_employee_id_seq OWNER TO batman;

--
-- Name: dummy_table_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: batman
--

ALTER SEQUENCE bds.dummy_table_employee_id_seq OWNED BY bds.dummy_table.employee_id;


--
-- Name: employee; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.employee (
    employee_id bigint NOT NULL,
    first_name character varying(45) NOT NULL,
    surname character varying(45) NOT NULL,
    email character varying(45) NOT NULL,
    building_id bigint NOT NULL,
    pwd character varying(60)
);


ALTER TABLE bds.employee OWNER TO postgres;

--
-- Name: employee_building_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.employee_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.employee_building_id_seq OWNER TO postgres;

--
-- Name: employee_building_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.employee_building_id_seq OWNED BY bds.employee.building_id;


--
-- Name: employee_has_address; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.employee_has_address (
    employee_id bigint NOT NULL,
    address_id integer NOT NULL,
    address_type character varying(45) NOT NULL
);


ALTER TABLE bds.employee_has_address OWNER TO postgres;

--
-- Name: employee_has_contract; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.employee_has_contract (
    contract_expiration date,
    employee_id bigint NOT NULL,
    job_id bigint NOT NULL
);


ALTER TABLE bds.employee_has_contract OWNER TO postgres;

--
-- Name: job; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.job (
    job_id bigint NOT NULL,
    job_type character varying(45) NOT NULL,
    salary integer
);


ALTER TABLE bds.job OWNER TO postgres;

--
-- Name: employee_check; Type: VIEW; Schema: bds; Owner: postgres
--

CREATE VIEW bds.employee_check AS
 SELECT DISTINCT e.employee_id,
    e.first_name,
    e.surname,
    j.job_type,
    j.salary,
    a.city,
    a.street,
    a.street_number
   FROM ((((bds.employee e
     JOIN bds.employee_has_contract ehc ON ((e.employee_id = ehc.employee_id)))
     JOIN bds.job j ON ((ehc.job_id = j.job_id)))
     JOIN bds.employee_has_address eha ON ((eha.employee_id = e.employee_id)))
     JOIN bds.address a ON ((a.address_id = eha.address_id)));


ALTER TABLE bds.employee_check OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.employee_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.employee_employee_id_seq OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.employee_employee_id_seq OWNED BY bds.employee.employee_id;


--
-- Name: employee_has_address_employee_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.employee_has_address_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.employee_has_address_employee_id_seq OWNER TO postgres;

--
-- Name: employee_has_address_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.employee_has_address_employee_id_seq OWNED BY bds.employee_has_address.employee_id;


--
-- Name: employee_has_contract_employee_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.employee_has_contract_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.employee_has_contract_employee_id_seq OWNER TO postgres;

--
-- Name: employee_has_contract_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.employee_has_contract_employee_id_seq OWNED BY bds.employee_has_contract.employee_id;


--
-- Name: employee_has_contract_job_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.employee_has_contract_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.employee_has_contract_job_id_seq OWNER TO postgres;

--
-- Name: employee_has_contract_job_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.employee_has_contract_job_id_seq OWNED BY bds.employee_has_contract.job_id;


--
-- Name: job_job_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.job_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.job_job_id_seq OWNER TO postgres;

--
-- Name: job_job_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.job_job_id_seq OWNED BY bds.job.job_id;


--
-- Name: manager; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.manager (
    manager_id bigint NOT NULL,
    manager_firstname character varying(45) NOT NULL,
    manager_surname character varying(45) NOT NULL,
    salary double precision NOT NULL,
    building_id bigint NOT NULL,
    email character varying(45),
    pwd character varying(60)
);


ALTER TABLE bds.manager OWNER TO postgres;

--
-- Name: manager_building_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.manager_building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.manager_building_id_seq OWNER TO postgres;

--
-- Name: manager_building_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.manager_building_id_seq OWNED BY bds.manager.building_id;


--
-- Name: manager_has_address; Type: TABLE; Schema: bds; Owner: postgres
--

CREATE TABLE bds.manager_has_address (
    manager_id bigint NOT NULL,
    address_id integer NOT NULL,
    address_type character varying(45) NOT NULL
);


ALTER TABLE bds.manager_has_address OWNER TO postgres;

--
-- Name: manager_has_address_manager_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.manager_has_address_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.manager_has_address_manager_id_seq OWNER TO postgres;

--
-- Name: manager_has_address_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.manager_has_address_manager_id_seq OWNED BY bds.manager_has_address.manager_id;


--
-- Name: manager_manager_id_seq; Type: SEQUENCE; Schema: bds; Owner: postgres
--

CREATE SEQUENCE bds.manager_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bds.manager_manager_id_seq OWNER TO postgres;

--
-- Name: manager_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: bds; Owner: postgres
--

ALTER SEQUENCE bds.manager_manager_id_seq OWNED BY bds.manager.manager_id;


--
-- Name: teachers_view; Type: VIEW; Schema: bds; Owner: postgres
--

CREATE VIEW bds.teachers_view AS
 SELECT employee.employee_id,
    employee.first_name,
    employee.surname,
    employee.email AS mail
   FROM bds.employee;


ALTER TABLE bds.teachers_view OWNER TO postgres;

--
-- Name: address address_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.address ALTER COLUMN address_id SET DEFAULT nextval('bds.address_address_id_seq'::regclass);


--
-- Name: building building_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.building ALTER COLUMN building_id SET DEFAULT nextval('bds.building_building_id_seq'::regclass);


--
-- Name: car car_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car ALTER COLUMN car_id SET DEFAULT nextval('bds.car_car_id_seq'::regclass);


--
-- Name: car customer_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car ALTER COLUMN customer_id SET DEFAULT nextval('bds.car_customer_id_seq'::regclass);


--
-- Name: car_has_workers car_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_has_workers ALTER COLUMN car_id SET DEFAULT nextval('bds.car_has_workers_car_id_seq'::regclass);


--
-- Name: car_has_workers employee_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_has_workers ALTER COLUMN employee_id SET DEFAULT nextval('bds.car_has_workers_employee_id_seq'::regclass);


--
-- Name: car_in_building car_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_in_building ALTER COLUMN car_id SET DEFAULT nextval('bds.car_in_building_car_id_seq'::regclass);


--
-- Name: car_in_building building_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_in_building ALTER COLUMN building_id SET DEFAULT nextval('bds.car_in_building_building_id_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.customer ALTER COLUMN customer_id SET DEFAULT nextval('bds.customer_customer_id_seq'::regclass);


--
-- Name: customer car_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.customer ALTER COLUMN car_id SET DEFAULT nextval('bds.customer_car_id_seq'::regclass);


--
-- Name: dummy_table employee_id; Type: DEFAULT; Schema: bds; Owner: batman
--

ALTER TABLE ONLY bds.dummy_table ALTER COLUMN employee_id SET DEFAULT nextval('bds.dummy_table_employee_id_seq'::regclass);


--
-- Name: employee employee_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee ALTER COLUMN employee_id SET DEFAULT nextval('bds.employee_employee_id_seq'::regclass);


--
-- Name: employee building_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee ALTER COLUMN building_id SET DEFAULT nextval('bds.employee_building_id_seq'::regclass);


--
-- Name: employee_has_address employee_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_address ALTER COLUMN employee_id SET DEFAULT nextval('bds.employee_has_address_employee_id_seq'::regclass);


--
-- Name: employee_has_contract employee_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_contract ALTER COLUMN employee_id SET DEFAULT nextval('bds.employee_has_contract_employee_id_seq'::regclass);


--
-- Name: employee_has_contract job_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_contract ALTER COLUMN job_id SET DEFAULT nextval('bds.employee_has_contract_job_id_seq'::regclass);


--
-- Name: job job_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.job ALTER COLUMN job_id SET DEFAULT nextval('bds.job_job_id_seq'::regclass);


--
-- Name: manager manager_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager ALTER COLUMN manager_id SET DEFAULT nextval('bds.manager_manager_id_seq'::regclass);


--
-- Name: manager building_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager ALTER COLUMN building_id SET DEFAULT nextval('bds.manager_building_id_seq'::regclass);


--
-- Name: manager_has_address manager_id; Type: DEFAULT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager_has_address ALTER COLUMN manager_id SET DEFAULT nextval('bds.manager_has_address_manager_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.address (address_id, city, street, street_number, zip_code) FROM stdin;
1	Nechanice	Na Kopečku	1544	50315
2	Louny	Louny	17123	44001
3	Úhretice	Jiráskova	1045	53832
4	Zajecov	K Lukárně	5188	26736
5	Rožmitál pod Tremšínem	U medvídků	2155	26242
\.


--
-- Data for Name: building; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.building (building_id, building_name) FROM stdin;
1	výroba
2	účetnictví
3	headquarters
4	závodní jídelna
5	odpadová hala
6	strojírenství
\.


--
-- Data for Name: car; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.car (car_id, car_brand, car_color, customer_id) FROM stdin;
1	Volkswagen	červená	\N
2	Volkswagen	černá	\N
3	BMW	černá	\N
4	BMW	bílá	\N
5	Škoda	stříbrná	\N
6	Porsche	červená	2
\.


--
-- Data for Name: car_has_workers; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.car_has_workers (car_id, employee_id, deadline) FROM stdin;
1	12	2022-10-05
1	14	2022-10-07
1	44	2022-10-12
3	1	2022-04-22
3	15	2022-04-27
\.


--
-- Data for Name: car_in_building; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.car_in_building (car_id, building_id, parts) FROM stdin;
1	1	Volant
1	6	Motor
2	1	Zrcátka
2	6	Motor
4	1	Sedadla
4	6	Motor
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.customer (customer_id, customer_f_name, customer_s_name, car_id) FROM stdin;
1	Dominik	Strouhal	1
2	Kateřina	Karelová	2
3	Martin	Kořínek	3
4	Natálie	Pavelková	4
5	Michaela	Jahodová	5
\.


--
-- Data for Name: dummy_table; Type: TABLE DATA; Schema: bds; Owner: batman
--

COPY bds.dummy_table (employee_id, name, email) FROM stdin;
1	Pepa Novák	pepa.novak@seznam.cz
2	Aneta Žaneta	zaneta.aneta@seznam.cz
3	Jaromír Rukavica	rukavicka.jara@seznam.cz
4	Lucie Oranžová	oranzova.lucie@seznam.cz
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.employee (employee_id, first_name, surname, email, building_id, pwd) FROM stdin;
5	Luboš	Veverka	lubos.vever@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
3	Hana	Jandová	alena.jand@automotive.cz	4	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
7	Jakub	Ferenc	jakub.ferenc@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
8	Zbyněk	Hrnčíř	zbynek.hrncir@automotive.cz	2	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
2	Petr	Kalivoda	petr.kal@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
68	Marek	Nalezený	mareknalezeny@automotive.cz	5	$2a$12$QiNmoxRnZNRzduxOWB3vZ.GdcEFFkGFkHIs7.FLVSoMeK65ZAdfSq
70	Jiří	Rychlý	zavodakjirka@automotive.cz	4	$2a$12$ZhJXw08QaGoHcJHs/x3w..146Mg7SC0jFeixSfgJ1WkFu5tAlulPu
6	Markéta	Janková	mj.1@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
4	Alois	Smola	alois.smola@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
9	Vojtěch	Sluka	vojtech.sluk@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
10	Štěpán	Bečvár	stepan.becvar@automotive.cz	4	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
11	Šimon	Motl	simon.motl@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
12	Rostislav	Kropáček	rost.krop@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
13	Richard	Maršík	richard.mars@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
14	Adam	Vybíral	nevybral@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
15	Bohuslav	Berky	bohus.berky@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
16	Jan	Hromádka	jan.hromadka@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
17	Martin	Provazník	martin.provaz@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
18	Vítězslav	Černý	vita.cerny@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
19	Miloš	Vrzal	vrzvrz@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
20	Petr	Trčka	petr.trcka@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
21	Dalibor	Válek	dalibor.valek@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
22	Barbora	Ptáčková	bara.ptack@automotive.cz	2	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
23	Jiří	Vašák	jiri.vasak@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
24	Jitka	Peterková	jitka.peter@automotive.cz	4	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
25	Luděk	Dědek	ludek.dedek@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
26	Natálie	Danielová	natalie.dan@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
27	Božena	Fuksová	bozena.fuks@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
28	Michal	Starý	michal.stary@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
29	Rostislav	Šebek	rosta.sebek@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
30	Tomáš	Adam	tomas.adam@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
31	Jana	Čížková	jana.cizk@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
32	Soňa	Bauerová	sona.bauer@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
33	Šimon	Sokol	simon.sokol@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
34	Helena	Slezáková	helena.slezak@automotive.cz	4	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
35	Tomáš	Bartošek	tomas.bartos@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
36	František	Benda	fanos.benda@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
37	Emilie	Kubátová	emilie.kubat@automotive.cz	2	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
38	Markéta	Dvorská	maka.dvorska@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
39	Radim	Doležal	radim.dolez@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
40	Vendula	Pechová	vendy.pech@automotive.cz	3	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
41	Lubomír	Vaníček	lubomir.van@automotive.cz	6	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
42	Filip	Myška	filip.myska@automotive.cz	6	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
43	Lubomír	Beneš	lubomir.benes@automotive.cz	6	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
44	Ludvík	Daniš	ludva.danis@automotive.cz	6	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
45	Ján	Kudrna	jan.kudrna@automotive.cz	6	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
46	Matěj	Dvořáček	matej.dvor@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
47	Tomáš	Hlaváč	tom.hlavac@automotive.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
48	Ludvík	Gajdoš	ludva.gajdos@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
49	Zbyněk	Trnak	zbynek.trnka@tomotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
50	Kamil	Koutný	kamil.koutny@automotive.cz	5	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
1	Hana	Samková	alena.samkova@automotive.cz	2	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
51	Ondřej	Křupatý	okrup@mail.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
52	Karlos	Vémola	vymol@mail.cz	1	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
53	Lojza	Zlojza	lojzazlojza@mail.cz	4	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
69	Jarek	Koště	jarekkoste@automotive.cz	2	$2a$12$WvipfJgLNRHXbYQSLO95bufgKHPXPAeUGWTfS7BNOCnLiEwvUcH3G
71	Pavel	Hrubý	hruby.pavel@automotive.cz	1	$2a$12$KIYgqrC9ZFCSYiW38xuZje28HLrNGn7xUvHecd/XwhszpnbohKq7W
75	a	a	a	1	$2a$12$GyQ9J8qOfgs4VHt0V9fWJ.wLWma8n.tftAvzqr7kTUGyb726w/yoe
\.


--
-- Data for Name: employee_has_address; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.employee_has_address (employee_id, address_id, address_type) FROM stdin;
1	1	Korespondenční adresa
1	3	Adresa trvalého bydliště
2	4	Korespondenční adresa
3	2	Korespondenční adresa
3	5	Adresa trvalého bydliště
5	1	Adresa trvalého bydliště
6	2	Korespondenèní adresa
7	4	Adresa trvalého bydliště
\.


--
-- Data for Name: employee_has_contract; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.employee_has_contract (contract_expiration, employee_id, job_id) FROM stdin;
2023-01-01	1	5
2023-01-01	2	5
2023-01-01	3	4
2023-01-01	4	1
2023-01-01	5	1
2023-01-01	6	7
2023-01-01	7	1
2023-01-01	8	5
2023-01-01	9	1
2023-01-01	10	6
\N	11	1
2025-01-01	12	3
\N	13	1
\N	14	1
\N	15	1
\N	16	1
\N	17	1
\N	18	1
\N	19	1
\N	20	1
\N	21	1
2024-01-01	22	5
\N	23	1
\N	24	8
2024-01-01	25	4
\N	26	2
\N	27	1
2025-01-01	28	3
\N	29	1
\N	30	4
\N	31	2
\N	32	2
2023-01-01	33	4
\N	34	6
2023-01-01	35	4
2023-01-01	36	4
\N	37	2
\N	38	2
\N	39	1
\N	40	2
\N	41	9
\N	42	9
2023-01-01	43	9
\N	44	9
2023-01-01	45	9
\N	46	1
\N	47	1
\N	49	1
\N	50	7
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.job (job_id, job_type, salary) FROM stdin;
1	dělník	22000
2	uklízečka	18000
3	vedoucí výroby	33200
4	IT technik	35000
5	účetní	29500
6	kuchař	22000
7	správce odpadů	27500
8	pomocný kuchař	20000
9	strojař	51000
\.


--
-- Data for Name: manager; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.manager (manager_id, manager_firstname, manager_surname, salary, building_id, email, pwd) FROM stdin;
1	Miroslav	Hladký	100000	1	hladky.miroslav@automotive.cz	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
2	Natálie	Syrová	82000	2	syrova.natalie@automotive.cz	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
3	Rudolf	Bednařík	135000	3	bednarik.rudolf@automotive.cz	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
4	Alžběta	Stupková	35000	4	stupkova.alzbeta@automotive.cz	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
5	Marcel	Šimčík	43200	5	simcik.marcel@automotive.cz	$2a$12$R2cCMfzhkntzHxzQ4fdkL.F8.iUwp0ziCwS242JJhx8qaIFeVCfCC
\.


--
-- Data for Name: manager_has_address; Type: TABLE DATA; Schema: bds; Owner: postgres
--

COPY bds.manager_has_address (manager_id, address_id, address_type) FROM stdin;
1	1	Adresa trvalého bydliště
5	1	Adresa trvalého bydliště
4	4	Korespondenční adresa
2	3	Korespondenční adresa
3	5	Adresa trvalého bydliště
\.


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.address_address_id_seq', 5, true);


--
-- Name: building_building_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.building_building_id_seq', 6, true);


--
-- Name: car_car_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_car_id_seq', 5, true);


--
-- Name: car_customer_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_customer_id_seq', 1, false);


--
-- Name: car_has_workers_car_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_has_workers_car_id_seq', 1, false);


--
-- Name: car_has_workers_employee_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_has_workers_employee_id_seq', 1, false);


--
-- Name: car_in_building_building_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_in_building_building_id_seq', 1, false);


--
-- Name: car_in_building_car_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.car_in_building_car_id_seq', 1, false);


--
-- Name: customer_car_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.customer_car_id_seq', 1, false);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.customer_customer_id_seq', 5, true);


--
-- Name: dummy_table_employee_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: batman
--

SELECT pg_catalog.setval('bds.dummy_table_employee_id_seq', 4, true);


--
-- Name: employee_building_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.employee_building_id_seq', 13, true);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.employee_employee_id_seq', 77, true);


--
-- Name: employee_has_address_employee_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.employee_has_address_employee_id_seq', 1, false);


--
-- Name: employee_has_contract_employee_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.employee_has_contract_employee_id_seq', 1, false);


--
-- Name: employee_has_contract_job_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.employee_has_contract_job_id_seq', 1, false);


--
-- Name: job_job_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.job_job_id_seq', 9, true);


--
-- Name: manager_building_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.manager_building_id_seq', 1, false);


--
-- Name: manager_has_address_manager_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.manager_has_address_manager_id_seq', 1, false);


--
-- Name: manager_manager_id_seq; Type: SEQUENCE SET; Schema: bds; Owner: postgres
--

SELECT pg_catalog.setval('bds.manager_manager_id_seq', 5, true);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- Name: building building_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (building_id);


--
-- Name: car_has_workers car_has_workers_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_has_workers
    ADD CONSTRAINT car_has_workers_pkey PRIMARY KEY (car_id, employee_id);


--
-- Name: car_in_building car_in_building_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_in_building
    ADD CONSTRAINT car_in_building_pkey PRIMARY KEY (car_id, building_id);


--
-- Name: car car_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car
    ADD CONSTRAINT car_pkey PRIMARY KEY (car_id);


--
-- Name: customer customer_customer_id_key; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.customer
    ADD CONSTRAINT customer_customer_id_key UNIQUE (customer_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id, car_id);


--
-- Name: dummy_table dummy_table_pkey; Type: CONSTRAINT; Schema: bds; Owner: batman
--

ALTER TABLE ONLY bds.dummy_table
    ADD CONSTRAINT dummy_table_pkey PRIMARY KEY (employee_id);


--
-- Name: employee employee_employee_id_key; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee
    ADD CONSTRAINT employee_employee_id_key UNIQUE (employee_id);


--
-- Name: employee_has_address employee_has_address_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_address
    ADD CONSTRAINT employee_has_address_pkey PRIMARY KEY (employee_id, address_id);


--
-- Name: employee_has_contract employee_has_contract_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_contract
    ADD CONSTRAINT employee_has_contract_pkey PRIMARY KEY (employee_id, job_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id, building_id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (job_id);


--
-- Name: manager_has_address manager_has_address_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager_has_address
    ADD CONSTRAINT manager_has_address_pkey PRIMARY KEY (manager_id, address_id);


--
-- Name: manager manager_manager_id_key; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager
    ADD CONSTRAINT manager_manager_id_key UNIQUE (manager_id);


--
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_id, building_id);


--
-- Name: n_idx; Type: INDEX; Schema: bds; Owner: postgres
--

CREATE INDEX n_idx ON bds.employee USING btree (first_name);


--
-- Name: employee information; Type: TRIGGER; Schema: bds; Owner: postgres
--

CREATE TRIGGER information AFTER INSERT ON bds.employee FOR EACH STATEMENT EXECUTE FUNCTION bds.new_employee();


--
-- Name: employee_has_address address_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_address
    ADD CONSTRAINT address_id FOREIGN KEY (address_id) REFERENCES bds.address(address_id);


--
-- Name: manager_has_address address_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager_has_address
    ADD CONSTRAINT address_id FOREIGN KEY (address_id) REFERENCES bds.address(address_id);


--
-- Name: employee building_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee
    ADD CONSTRAINT building_id FOREIGN KEY (building_id) REFERENCES bds.building(building_id);


--
-- Name: manager building_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager
    ADD CONSTRAINT building_id FOREIGN KEY (building_id) REFERENCES bds.building(building_id);


--
-- Name: car_in_building building_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_in_building
    ADD CONSTRAINT building_id FOREIGN KEY (building_id) REFERENCES bds.building(building_id);


--
-- Name: customer car_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.customer
    ADD CONSTRAINT car_id FOREIGN KEY (car_id) REFERENCES bds.car(car_id);


--
-- Name: car_has_workers car_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_has_workers
    ADD CONSTRAINT car_id FOREIGN KEY (car_id) REFERENCES bds.car(car_id);


--
-- Name: car_in_building car_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_in_building
    ADD CONSTRAINT car_id FOREIGN KEY (car_id) REFERENCES bds.car(car_id);


--
-- Name: car customer_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id) REFERENCES bds.customer(customer_id);


--
-- Name: employee_has_address employee_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_address
    ADD CONSTRAINT employee_id FOREIGN KEY (employee_id) REFERENCES bds.employee(employee_id);


--
-- Name: employee_has_contract employee_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_contract
    ADD CONSTRAINT employee_id FOREIGN KEY (employee_id) REFERENCES bds.employee(employee_id);


--
-- Name: car_has_workers employee_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.car_has_workers
    ADD CONSTRAINT employee_id FOREIGN KEY (employee_id) REFERENCES bds.employee(employee_id);


--
-- Name: employee_has_contract job_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.employee_has_contract
    ADD CONSTRAINT job_id FOREIGN KEY (job_id) REFERENCES bds.job(job_id);


--
-- Name: manager_has_address manager_id; Type: FK CONSTRAINT; Schema: bds; Owner: postgres
--

ALTER TABLE ONLY bds.manager_has_address
    ADD CONSTRAINT manager_id FOREIGN KEY (manager_id) REFERENCES bds.manager(manager_id);


--
-- Name: SCHEMA bds; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA bds TO batman;


--
-- Name: TABLE address; Type: ACL; Schema: bds; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bds.address TO teacher;
GRANT ALL ON TABLE bds.address TO bob;
GRANT ALL ON TABLE bds.address TO batman;


--
-- Name: SEQUENCE address_address_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.address_address_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.address_address_id_seq TO batman;


--
-- Name: TABLE building; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.building TO bob;
GRANT ALL ON TABLE bds.building TO batman;


--
-- Name: SEQUENCE building_building_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.building_building_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.building_building_id_seq TO batman;


--
-- Name: TABLE car; Type: ACL; Schema: bds; Owner: postgres
--

GRANT SELECT ON TABLE bds.car TO student;
GRANT ALL ON TABLE bds.car TO bob;
GRANT ALL ON TABLE bds.car TO batman;


--
-- Name: SEQUENCE car_car_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_car_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_car_id_seq TO batman;


--
-- Name: SEQUENCE car_customer_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_customer_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_customer_id_seq TO batman;


--
-- Name: TABLE car_has_workers; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.car_has_workers TO bob;
GRANT ALL ON TABLE bds.car_has_workers TO batman;


--
-- Name: SEQUENCE car_has_workers_car_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_has_workers_car_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_has_workers_car_id_seq TO batman;


--
-- Name: SEQUENCE car_has_workers_employee_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_has_workers_employee_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_has_workers_employee_id_seq TO batman;


--
-- Name: TABLE car_in_building; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.car_in_building TO bob;
GRANT ALL ON TABLE bds.car_in_building TO batman;


--
-- Name: SEQUENCE car_in_building_building_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_in_building_building_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_in_building_building_id_seq TO batman;


--
-- Name: SEQUENCE car_in_building_car_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.car_in_building_car_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.car_in_building_car_id_seq TO batman;


--
-- Name: TABLE car_view; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.car_view TO bob;
GRANT ALL ON TABLE bds.car_view TO batman;


--
-- Name: TABLE customer; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.customer TO bob;
GRANT ALL ON TABLE bds.customer TO batman;


--
-- Name: SEQUENCE customer_car_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.customer_car_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.customer_car_id_seq TO batman;


--
-- Name: SEQUENCE customer_customer_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.customer_customer_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.customer_customer_id_seq TO batman;


--
-- Name: TABLE employee; Type: ACL; Schema: bds; Owner: postgres
--

GRANT SELECT ON TABLE bds.employee TO student;
GRANT ALL ON TABLE bds.employee TO bob;
GRANT ALL ON TABLE bds.employee TO batman;


--
-- Name: SEQUENCE employee_building_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.employee_building_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.employee_building_id_seq TO batman;


--
-- Name: TABLE employee_has_address; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.employee_has_address TO bob;
GRANT ALL ON TABLE bds.employee_has_address TO batman;


--
-- Name: TABLE employee_has_contract; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.employee_has_contract TO bob;
GRANT ALL ON TABLE bds.employee_has_contract TO batman;


--
-- Name: TABLE job; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.job TO bob;
GRANT ALL ON TABLE bds.job TO batman;


--
-- Name: TABLE employee_check; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.employee_check TO bob;
GRANT ALL ON TABLE bds.employee_check TO batman;


--
-- Name: SEQUENCE employee_employee_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.employee_employee_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.employee_employee_id_seq TO batman;


--
-- Name: SEQUENCE employee_has_address_employee_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.employee_has_address_employee_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.employee_has_address_employee_id_seq TO batman;


--
-- Name: SEQUENCE employee_has_contract_employee_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.employee_has_contract_employee_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.employee_has_contract_employee_id_seq TO batman;


--
-- Name: SEQUENCE employee_has_contract_job_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.employee_has_contract_job_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.employee_has_contract_job_id_seq TO batman;


--
-- Name: SEQUENCE job_job_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.job_job_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.job_job_id_seq TO batman;


--
-- Name: TABLE manager; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.manager TO bob;
GRANT ALL ON TABLE bds.manager TO batman;


--
-- Name: SEQUENCE manager_building_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.manager_building_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.manager_building_id_seq TO batman;


--
-- Name: TABLE manager_has_address; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON TABLE bds.manager_has_address TO bob;
GRANT ALL ON TABLE bds.manager_has_address TO batman;


--
-- Name: SEQUENCE manager_has_address_manager_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.manager_has_address_manager_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.manager_has_address_manager_id_seq TO batman;


--
-- Name: SEQUENCE manager_manager_id_seq; Type: ACL; Schema: bds; Owner: postgres
--

GRANT ALL ON SEQUENCE bds.manager_manager_id_seq TO bob;
GRANT ALL ON SEQUENCE bds.manager_manager_id_seq TO batman;


--
-- Name: TABLE teachers_view; Type: ACL; Schema: bds; Owner: postgres
--

GRANT SELECT ON TABLE bds.teachers_view TO teacher;
GRANT ALL ON TABLE bds.teachers_view TO bob;
GRANT ALL ON TABLE bds.teachers_view TO batman;


--
-- Name: car_view; Type: MATERIALIZED VIEW DATA; Schema: bds; Owner: postgres
--

REFRESH MATERIALIZED VIEW bds.car_view;


--
-- PostgreSQL database dump complete
--


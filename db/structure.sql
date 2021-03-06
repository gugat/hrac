SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: assistance_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.assistance_kind AS ENUM (
    'in',
    'out'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: anomalies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anomalies (
    id bigint NOT NULL,
    absence boolean,
    arrived_late boolean,
    worked_too_short boolean,
    finished_too_early boolean,
    incomplete_assistances boolean,
    day timestamp without time zone,
    employee_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: anomalies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anomalies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anomalies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anomalies_id_seq OWNED BY public.anomalies.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: assistances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assistances (
    id bigint NOT NULL,
    employee_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    happening_at timestamp without time zone,
    kind public.assistance_kind
);


--
-- Name: assistances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assistances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assistances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assistances_id_seq OWNED BY public.assistances.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying,
    provider character varying DEFAULT 'email'::character varying NOT NULL,
    uid character varying DEFAULT ''::character varying NOT NULL,
    tokens text,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    role integer DEFAULT 0
);


--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: work_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.work_days (
    id bigint NOT NULL,
    day timestamp without time zone,
    total_hours double precision,
    employee_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: work_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.work_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.work_days_id_seq OWNED BY public.work_days.id;


--
-- Name: anomalies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anomalies ALTER COLUMN id SET DEFAULT nextval('public.anomalies_id_seq'::regclass);


--
-- Name: assistances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assistances ALTER COLUMN id SET DEFAULT nextval('public.assistances_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: work_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_days ALTER COLUMN id SET DEFAULT nextval('public.work_days_id_seq'::regclass);


--
-- Name: anomalies anomalies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anomalies
    ADD CONSTRAINT anomalies_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assistances assistances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assistances
    ADD CONSTRAINT assistances_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: work_days work_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_days
    ADD CONSTRAINT work_days_pkey PRIMARY KEY (id);


--
-- Name: index_anomalies_on_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_anomalies_on_employee_id ON public.anomalies USING btree (employee_id);


--
-- Name: index_assistances_on_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assistances_on_employee_id ON public.assistances USING btree (employee_id);


--
-- Name: index_employees_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_employees_on_uid_and_provider ON public.employees USING btree (uid, provider);


--
-- Name: index_work_days_on_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_days_on_employee_id ON public.work_days USING btree (employee_id);


--
-- Name: assistances fk_rails_50b4b716bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assistances
    ADD CONSTRAINT fk_rails_50b4b716bd FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: work_days fk_rails_64f64b0686; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_days
    ADD CONSTRAINT fk_rails_64f64b0686 FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190224135012'),
('20190224135150'),
('20190226015501'),
('20190226031815'),
('20190227230803'),
('20190227231820'),
('20190301125706'),
('20190301220557'),
('20190302002837');



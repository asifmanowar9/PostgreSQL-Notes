--
-- PostgreSQL database dump
--

\restrict 7aTltsvaTOI2SBU0bsSdNfQcoItsjmqfoAfPqJH1ZKLsnqUDh8qlQoeJmPAzOE0

-- Dumped from database version 16.15 (Debian 16.15-1.pgdg13+2)
-- Dumped by pg_dump version 16.15 (Debian 16.15-1.pgdg13+2)

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

DROP POLICY restrict_post_access ON public.posts;
ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_author_id_fkey;
DROP INDEX public.idx_published_titles;
DROP INDEX public.idx_posts_metadata;
DROP INDEX public.idx_post_title;
DROP INDEX public.idex_author_and_date;
ALTER TABLE ONLY store.products DROP CONSTRAINT unique_product_name;
ALTER TABLE ONLY store.products DROP CONSTRAINT products_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
ALTER TABLE ONLY public.authors DROP CONSTRAINT authors_pkey;
DROP TABLE store.products;
DROP TABLE public.users;
DROP TABLE public.posts;
DROP TABLE public.authors;
DROP TABLE public.audit_logs;
DROP TYPE public.post_status;
DROP SCHEMA store;
--
-- Name: store; Type: SCHEMA; Schema: -; Owner: asif
--

CREATE SCHEMA store;


ALTER SCHEMA store OWNER TO asif;

--
-- Name: post_status; Type: TYPE; Schema: public; Owner: asif
--

CREATE TYPE public.post_status AS ENUM (
    'draft',
    'published',
    'archived'
);


ALTER TYPE public.post_status OWNER TO asif;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: asif
--

CREATE TABLE public.audit_logs (
    action text,
    resource_name text
);


ALTER TABLE public.audit_logs OWNER TO asif;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: asif
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.authors OWNER TO asif;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: asif
--

ALTER TABLE public.authors ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: posts; Type: TABLE; Schema: public; Owner: asif
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title text NOT NULL,
    content text,
    published_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    author_id integer,
    tags text[],
    metadata jsonb,
    status public.post_status DEFAULT 'draft'::public.post_status
);


ALTER TABLE public.posts OWNER TO asif;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: asif
--

ALTER TABLE public.posts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: asif
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    age integer,
    CONSTRAINT users_age_check CHECK ((age >= 18))
);


ALTER TABLE public.users OWNER TO asif;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: asif
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: products; Type: TABLE; Schema: store; Owner: asif
--

CREATE TABLE store.products (
    id integer NOT NULL,
    name text,
    price numeric,
    CONSTRAINT products_price_check CHECK ((price > (0)::numeric))
);


ALTER TABLE store.products OWNER TO asif;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: store; Owner: asif
--

ALTER TABLE store.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: asif
--

COPY public.audit_logs (action, resource_name) FROM stdin;
\.


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: asif
--

COPY public.authors (id, name, created_at) FROM stdin;
1	Asif	2026-09-23 06:33:07.354526+00
2	Bob	2026-09-23 06:49:39.180798+00
4	Good Author	2026-09-24 05:08:02.370727+00
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: asif
--

COPY public.posts (id, title, content, published_at, author_id, tags, metadata, status) FROM stdin;
3	my 3rd post	this is the 3rd content of my post	2026-09-23 06:12:58.29052+00	\N	\N	\N	draft
1	Updated Title	This is the content of my post.	2026-09-23 06:10:01.043607+00	\N	\N	\N	draft
8	Another post by Asif	Content here	2026-09-23 06:49:57.620468+00	1	\N	\N	draft
9	Yet another post by Asif	More content	2026-09-23 06:49:57.620468+00	1	\N	\N	draft
10	A post by Bob	Different content	2026-09-23 06:49:57.620468+00	2	\N	\N	draft
4	My first post	This is the content of my post.	2026-09-23 06:25:06.599754+00	1	{sql,learning,posrgree}	{"theme": "dark", "views": 100, "is_featured": true}	draft
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: asif
--

COPY public.users (id, email, age) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: store; Owner: asif
--

COPY store.products (id, name, price) FROM stdin;
2	Bad Apple	1
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asif
--

SELECT pg_catalog.setval('public.authors_id_seq', 5, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asif
--

SELECT pg_catalog.setval('public.posts_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asif
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: store; Owner: asif
--

SELECT pg_catalog.setval('store.products_id_seq', 2, true);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: asif
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: asif
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: asif
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: asif
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: store; Owner: asif
--

ALTER TABLE ONLY store.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products unique_product_name; Type: CONSTRAINT; Schema: store; Owner: asif
--

ALTER TABLE ONLY store.products
    ADD CONSTRAINT unique_product_name UNIQUE (name);


--
-- Name: idex_author_and_date; Type: INDEX; Schema: public; Owner: asif
--

CREATE INDEX idex_author_and_date ON public.posts USING btree (author_id, published_at);


--
-- Name: idx_post_title; Type: INDEX; Schema: public; Owner: asif
--

CREATE INDEX idx_post_title ON public.posts USING btree (title);


--
-- Name: idx_posts_metadata; Type: INDEX; Schema: public; Owner: asif
--

CREATE INDEX idx_posts_metadata ON public.posts USING gin (metadata);


--
-- Name: idx_published_titles; Type: INDEX; Schema: public; Owner: asif
--

CREATE INDEX idx_published_titles ON public.posts USING btree (title) WHERE (status = 'published'::public.post_status);


--
-- Name: posts posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: asif
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- Name: posts; Type: ROW SECURITY; Schema: public; Owner: asif
--

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

--
-- Name: posts restrict_post_access; Type: POLICY; Schema: public; Owner: asif
--

CREATE POLICY restrict_post_access ON public.posts FOR SELECT TO app_user USING ((CURRENT_USER = 'Asif'::name));


--
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: asif
--

GRANT SELECT,INSERT ON TABLE public.posts TO app_user;
GRANT SELECT ON TABLE public.posts TO intern_readonly;


--
-- PostgreSQL database dump complete
--

\unrestrict 7aTltsvaTOI2SBU0bsSdNfQcoItsjmqfoAfPqJH1ZKLsnqUDh8qlQoeJmPAzOE0


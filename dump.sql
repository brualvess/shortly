--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: shortUrl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."shortUrl" (
    id integer NOT NULL,
    url text NOT NULL,
    key text NOT NULL,
    "userId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


ALTER TABLE public."shortUrl" OWNER TO postgres;

--
-- Name: shortUrl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."shortUrl_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."shortUrl_id_seq" OWNER TO postgres;

--
-- Name: shortUrl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."shortUrl_id_seq" OWNED BY public."shortUrl".id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    token text NOT NULL,
    "userId" integer NOT NULL,
    "expireAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(110) NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visits (
    id integer NOT NULL,
    "urlId" integer NOT NULL,
    "visitDate" timestamp without time zone NOT NULL
);


ALTER TABLE public.visits OWNER TO postgres;

--
-- Name: visits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visits_id_seq OWNER TO postgres;

--
-- Name: visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visits_id_seq OWNED BY public.visits.id;


--
-- Name: shortUrl id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortUrl" ALTER COLUMN id SET DEFAULT nextval('public."shortUrl_id_seq"'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: visits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits ALTER COLUMN id SET DEFAULT nextval('public.visits_id_seq'::regclass);


--
-- Data for Name: shortUrl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."shortUrl" (id, url, key, "userId", "createdAt") FROM stdin;
1	https://pt.wikipedia.org/wiki/Os_Simpsons	ylekT0B	1	2022-08-07 00:00:00
2	https://bootcampra.notion.site/Projeto-Shortly-API-4ffa110c0ebd4e83ad7302cfafd33133	u0hYQLF	1	2022-08-07 00:00:00
3	https://www.reverso.net/tradu%C3%A7%C3%A3o-texto#sl=eng&tl=por&text=error%253A%2520too%2520many%2520command-line%2520arguments%2520(first%2520is%2520%2522shortly%2522)%250A	yt6dpSS	1	2022-08-07 00:00:00
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tokens (id, token, "userId", "expireAt", "createdAt") FROM stdin;
1	9cdb07f3-fe49-4853-875a-3766774ea7db	1	2022-09-06 19:09:19	2022-08-07 00:00:00
2	3a3ce5c7-ce9c-4dba-845d-8605c91876ad	1	2022-09-06 19:09:20	2022-08-07 00:00:00
3	39715350-0251-47f5-9120-163531b6a88e	6	2022-09-06 23:20:31.344	2022-08-07 00:00:00
4	ad65f720-51f4-499a-8905-676b513f6abc	7	2022-09-06 23:20:38.067	2022-08-07 00:00:00
5	56582dec-359e-4925-8ea3-9c6938236f25	8	2022-09-06 23:20:43.361	2022-08-07 00:00:00
6	a287f6d7-658f-4681-be98-ba664ff952a8	9	2022-09-06 23:20:48.892	2022-08-07 00:00:00
7	399709a4-0c42-4567-ac44-663078df7ecb	10	2022-09-06 23:20:53.834	2022-08-07 00:00:00
8	353e75ce-f058-4588-9368-565896af0506	11	2022-09-06 23:20:59.04	2022-08-07 00:00:00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, "createdAt") FROM stdin;
1	Juca	juca@gmail.com	$2b$10$F4wxpqtNdDQ4paGU4n5nV.SQPh44HWzAH33lkRPG5dF5SHpPbqyEa	2022-08-07 00:00:00
3	adriana	adriana@gmail.com	$2b$10$wzqssNfTCKITy.UnTE/fFOgKKIPvG8nKeKVpYITuKXcJ/NiVz7ENO	2022-08-07 00:00:00
4	lilica	lilica@gmail.com	$2b$10$75BtlmOWr3OlCt1kHAGWeOvrbsCSHiL6ISsMNmhuXzN13oC.rEjF2	2022-08-07 00:00:00
5	luluzinha	luluzinha@gmail.com	$2b$10$EnMGl.vxzuQauuPJ6vEjVe/J6Kv48i6hrTj.JSnSjjGUMQm247xGu	2022-08-07 00:00:00
6	a	a@gmail.com	$2b$10$dxH7Vw3EoCECBs3eHDdHKulaEA9Ix914xOjnNXdtzRvLsogXMQiQ6	2022-08-07 00:00:00
7	b	b@gmail.com	$2b$10$2uPUZt8Ozo9Ni07Q9h/ypOZdd7kNygncQ/6TrGSuIoMJx5goSRF2a	2022-08-07 00:00:00
8	c	c@gmail.com	$2b$10$HadRxYDJqXlyXvjVOVwpKOIFcMUWpF7eKivPXCxiidSWUcA4SuS1a	2022-08-07 00:00:00
9	d	d@gmail.com	$2b$10$DsZKYr09X6LqqEy/w.Y8teG89.DsfI9NSQHG7Jf7xlus31sBrgaD2	2022-08-07 00:00:00
10	e	e@gmail.com	$2b$10$mfEHWruAjlK33REQV/DYCORDpawbJdVM8VaL6t7w5Rsp1mTgQB4LS	2022-08-07 00:00:00
11	f	f@gmail.com	$2b$10$g7GMdbUz3di6Djz7hQWNUuWkx8HIt/FGNOc60xDq/bxC4ejQZhq5q	2022-08-07 00:00:00
12	g	g@gmail.com	$2b$10$WWnGjtMp6gzMp0TJuKLQ9upnSOExMaS6BgWzGLh9nmQXsLVJK.G3.	2022-08-07 00:00:00
13	h	h@gmail.com	$2b$10$lY0s.eZqxQUxzAFWZc61IeWSsvJqDzMSysA4gWiOGQ.fikBPS2ut.	2022-08-07 00:00:00
\.


--
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visits (id, "urlId", "visitDate") FROM stdin;
1	1	2022-08-07 00:00:00
2	1	2022-08-07 00:00:00
5	1	2022-08-07 00:00:00
6	1	2022-08-07 00:00:00
\.


--
-- Name: shortUrl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."shortUrl_id_seq"', 4, true);


--
-- Name: tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tokens_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visits_id_seq', 6, true);


--
-- Name: shortUrl shortUrl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortUrl"
    ADD CONSTRAINT "shortUrl_pk" PRIMARY KEY (id);


--
-- Name: tokens tokens_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pk PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: visits visits_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pk PRIMARY KEY (id);


--
-- Name: shortUrl shortUrl_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortUrl"
    ADD CONSTRAINT "shortUrl_fk0" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: tokens tokens_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_fk0 FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: visits visits_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_fk0 FOREIGN KEY ("urlId") REFERENCES public."shortUrl"(id);


--
-- PostgreSQL database dump complete
--


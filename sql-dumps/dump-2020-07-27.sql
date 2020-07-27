--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.8 (Ubuntu 11.8-1.pgdg16.04+1)

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

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.accounts (
    id character(36) NOT NULL,
    name character varying(70) NOT NULL,
    email character varying(355) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    last_login timestamp without time zone,
    google_id character varying(30),
    picture text,
    gender character varying(16)
);


ALTER TABLE public.accounts OWNER TO hugokawamata;

--
-- Name: character_results; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.character_results (
    id integer NOT NULL,
    user_id character(36) NOT NULL,
    character_id integer NOT NULL,
    answers text[],
    marks text[],
    created_at timestamp without time zone
);


ALTER TABLE public.character_results OWNER TO hugokawamata;

--
-- Name: character_results_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.character_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.character_results_id_seq OWNER TO hugokawamata;

--
-- Name: character_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.character_results_id_seq OWNED BY public.character_results.id;


--
-- Name: characters; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    "character" character varying(3) NOT NULL,
    type character varying(10) NOT NULL,
    readings character varying(10)[]
);


ALTER TABLE public.characters OWNER TO hugokawamata;

--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_id_seq OWNER TO hugokawamata;

--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.courses (
    id character varying(20) NOT NULL,
    title character varying(100),
    unlocks_ids text
);


ALTER TABLE public.courses OWNER TO hugokawamata;

--
-- Name: lectures; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.lectures (
    id integer NOT NULL,
    text text,
    image text,
    "position" character varying(31),
    set_lesson_id character varying(20),
    title character varying(100)
);


ALTER TABLE public.lectures OWNER TO hugokawamata;

--
-- Name: lectures_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.lectures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lectures_id_seq OWNER TO hugokawamata;

--
-- Name: lectures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.lectures_id_seq OWNED BY public.lectures.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO hugokawamata;

--
-- Name: set_lessons; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.set_lessons (
    id character varying(20) NOT NULL,
    title character varying(80) NOT NULL,
    image text,
    unlocks_ids text,
    course_id character varying(20),
    skill_level character varying(32),
    time_estimate integer
);


ALTER TABLE public.set_lessons OWNER TO hugokawamata;

--
-- Name: testable_results; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.testable_results (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    answers text[],
    marks text[],
    user_id character(36) NOT NULL,
    testable_id integer NOT NULL
);


ALTER TABLE public.testable_results OWNER TO hugokawamata;

--
-- Name: testable_results_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.testable_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testable_results_id_seq OWNER TO hugokawamata;

--
-- Name: testable_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.testable_results_id_seq OWNED BY public.testable_results.id;


--
-- Name: testables; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.testables (
    id integer NOT NULL,
    set_lesson_id character varying(20) NOT NULL,
    person character varying(40),
    location character varying(40),
    context_jp text,
    context_fg text,
    context_en text,
    possible_answers text,
    question_text text,
    question_text_fg text,
    word_id integer,
    question_type character varying(20) NOT NULL,
    order_in_lesson integer NOT NULL,
    context_speaker text,
    answer_type character varying(20) NOT NULL,
    question_prompt text
);


ALTER TABLE public.testables OWNER TO hugokawamata;

--
-- Name: testables_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.testables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testables_id_seq OWNER TO hugokawamata;

--
-- Name: testables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.testables_id_seq OWNED BY public.testables.id;


--
-- Name: user_characters; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.user_characters (
    user_id character(36) NOT NULL,
    character_id integer NOT NULL,
    proficiency real NOT NULL,
    result_ids integer[],
    mnemonic character varying(255)
);


ALTER TABLE public.user_characters OWNER TO hugokawamata;

--
-- Name: user_courses; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.user_courses (
    user_id character(36) NOT NULL,
    course_id character varying(20) NOT NULL,
    status character varying(15) NOT NULL,
    completed_at date
);


ALTER TABLE public.user_courses OWNER TO hugokawamata;

--
-- Name: user_set_lessons; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.user_set_lessons (
    user_id character(36) NOT NULL,
    set_lesson_id character varying(20) NOT NULL,
    status character varying(15) NOT NULL,
    completed_at date
);


ALTER TABLE public.user_set_lessons OWNER TO hugokawamata;

--
-- Name: user_testables; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.user_testables (
    proficiency real NOT NULL,
    user_id character(36) NOT NULL,
    testable_id integer NOT NULL
);


ALTER TABLE public.user_testables OWNER TO hugokawamata;

--
-- Name: user_words; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.user_words (
    user_id character(36) NOT NULL,
    word_id integer NOT NULL,
    proficiency real NOT NULL,
    mnemonic character varying(255)
);


ALTER TABLE public.user_words OWNER TO hugokawamata;

--
-- Name: word_results; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.word_results (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    answers text[],
    marks text[],
    user_id character(36) NOT NULL,
    word_id integer NOT NULL
);


ALTER TABLE public.word_results OWNER TO hugokawamata;

--
-- Name: word_results_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.word_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.word_results_id_seq OWNER TO hugokawamata;

--
-- Name: word_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.word_results_id_seq OWNED BY public.word_results.id;


--
-- Name: words; Type: TABLE; Schema: public; Owner: hugokawamata
--

CREATE TABLE public.words (
    id integer NOT NULL,
    japanese character varying(50) NOT NULL,
    hiragana character varying(50) NOT NULL,
    english character varying(255) NOT NULL,
    introduction character varying(255),
    emoji character varying(10),
    image character varying(255),
    set_lesson_id character varying(20)
);


ALTER TABLE public.words OWNER TO hugokawamata;

--
-- Name: words_id_seq; Type: SEQUENCE; Schema: public; Owner: hugokawamata
--

CREATE SEQUENCE public.words_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.words_id_seq OWNER TO hugokawamata;

--
-- Name: words_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hugokawamata
--

ALTER SEQUENCE public.words_id_seq OWNED BY public.words.id;


--
-- Name: character_results id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.character_results ALTER COLUMN id SET DEFAULT nextval('public.character_results_id_seq'::regclass);


--
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- Name: lectures id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.lectures ALTER COLUMN id SET DEFAULT nextval('public.lectures_id_seq'::regclass);


--
-- Name: testable_results id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testable_results ALTER COLUMN id SET DEFAULT nextval('public.testable_results_id_seq'::regclass);


--
-- Name: testables id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testables ALTER COLUMN id SET DEFAULT nextval('public.testables_id_seq'::regclass);


--
-- Name: word_results id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.word_results ALTER COLUMN id SET DEFAULT nextval('public.word_results_id_seq'::regclass);


--
-- Name: words id; Type: DEFAULT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.words ALTER COLUMN id SET DEFAULT nextval('public.words_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.accounts (id, name, email, created_at, last_login, google_id, picture, gender) FROM stdin;
3d7e40ad-3fe9-5f38-90d4-cd9ac653664f	Ella Byrd	ellabyrd.85826@gmail.com	2020-07-20 15:19:05.949918	2020-07-20 15:19:26.277667	\N	https://lh5.googleusercontent.com/-0kNP0Kelw6E/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucllYHzP3yZ8opCiM4AEJcUdIsCm1w/s96-c/photo.jpg	\N
2b7b56be-3bdb-5f38-b28b-6ee83bd89cbd	BagIt Australia	bagitaustralia@gmail.com	2020-06-30 07:17:36.604199	2020-06-30 07:17:36.604199	\N	https://lh3.googleusercontent.com/a-/AOh14GgiM39X0YnjJePZA0GilyxxG1OabQJdMnQCoNLD=s96-c	F
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	Holistic Japanese	holisticjapanese@gmail.com	2020-06-28 06:02:08.474602	2020-07-06 21:27:42.582819	\N	https://lh3.googleusercontent.com/-i6ZUJk8xQgk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnojwOovfHfYmFhpVjRdDWc4-7YHw/s96-c/photo.jpg	F
0a893a59-2311-5c65-a908-c41a9b43aea7	Hugo Kawamata	hugo@tanda.co	2020-07-13 04:40:50.058237	2020-07-13 06:35:34.701264	\N	https://lh3.googleusercontent.com/a-/AOh14GiDjPufzMoerqrnIH5aM_4r9iJk3JqqZE9gUGS4=s96-c	M
267c8d8e-5ba7-5765-beff-fd7bd66052d6	Hugo Kawamata	hugokawamata@gmail.com	2020-06-22 07:37:06.421345	2020-07-20 04:01:22.711301	\N	https://lh3.googleusercontent.com/a-/AOh14GjQxff4bMXazZAMi7wrxGu_p7h56miymZmKn93dXQ=s96-c	M
e758a541-973b-5922-8090-339365f29818	Trang Ho	trang@tatoeba.org	2020-07-20 14:51:02.254908	2020-07-20 14:51:02.254908	\N	https://lh6.googleusercontent.com/-MLuDlsnC1-g/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclutCbJjpJ2s2Awrp7YXiCaxgcQhA/s96-c/photo.jpg	F
\.


--
-- Data for Name: character_results; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.character_results (id, user_id, character_id, answers, marks, created_at) FROM stdin;
653	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	{a,a,a}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:16.621684
654	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:16.621684
655	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:16.621684
656	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4	{e,e,e,e,e,e,e,e,e}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:16.621684
657	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:16.621684
658	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	{a,a,a}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
659	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka,ka,ka,ka}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
660	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
661	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7	{ki,ki,ki}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
662	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	{ku,ku,ku,ku,ku,ku}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
663	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
664	267c8d8e-5ba7-5765-beff-fd7bd66052d6	10	{ko,ko,ko}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
665	267c8d8e-5ba7-5765-beff-fd7bd66052d6	9	{ke,ke,ke}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
666	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:01:58.35025
667	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4	{e,e,e,e,e,e}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
668	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
669	267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	{ga,ga,ga}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
670	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka,ka,ka,ka,ka,ka,ka}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
671	267c8d8e-5ba7-5765-beff-fd7bd66052d6	17	{gi,gi,gi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
672	267c8d8e-5ba7-5765-beff-fd7bd66052d6	20	{go,go,go}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
673	267c8d8e-5ba7-5765-beff-fd7bd66052d6	19	{ge,ge,ge}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
674	267c8d8e-5ba7-5765-beff-fd7bd66052d6	18	{gu,gu,gu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:03:05.563748
675	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
676	267c8d8e-5ba7-5765-beff-fd7bd66052d6	15	{so,so,so}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
677	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
678	267c8d8e-5ba7-5765-beff-fd7bd66052d6	11	{sa,sa,sa}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
679	267c8d8e-5ba7-5765-beff-fd7bd66052d6	9	{ke,ke,ke}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
680	267c8d8e-5ba7-5765-beff-fd7bd66052d6	13	{su,su,su,su,su,su}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
681	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	{shi,shi,shi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
682	267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	{ga,ga,ga}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
683	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	{ku,ku,ku}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
684	267c8d8e-5ba7-5765-beff-fd7bd66052d6	14	{se,se,se}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
685	267c8d8e-5ba7-5765-beff-fd7bd66052d6	20	{go,go,go}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:04:02.322464
686	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka,ka,ka,ka}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
687	267c8d8e-5ba7-5765-beff-fd7bd66052d6	24	{ze,ze,ze}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
688	267c8d8e-5ba7-5765-beff-fd7bd66052d6	25	{zo,zo,zo}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
689	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
690	267c8d8e-5ba7-5765-beff-fd7bd66052d6	21	{za,za,za}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
691	267c8d8e-5ba7-5765-beff-fd7bd66052d6	105	{s,s,s}	{INCORRECT,INCORRECT,INCORRECT}	2020-06-25 09:05:01.870588
692	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	{shi,shi,shi,shi,shi,shi}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
693	267c8d8e-5ba7-5765-beff-fd7bd66052d6	23	{zu,zu,zu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
694	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	{a,a,a}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
695	267c8d8e-5ba7-5765-beff-fd7bd66052d6	22	{ji,ji,ji}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:05:01.870588
696	267c8d8e-5ba7-5765-beff-fd7bd66052d6	28	{tsu,tsu,tsu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
697	267c8d8e-5ba7-5765-beff-fd7bd66052d6	17	{gi,gi,gi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
698	267c8d8e-5ba7-5765-beff-fd7bd66052d6	30	{to,to,to}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
699	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	{shi,shi,shi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
700	267c8d8e-5ba7-5765-beff-fd7bd66052d6	27	{chi,chi,chi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
701	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
702	267c8d8e-5ba7-5765-beff-fd7bd66052d6	11	{sa,sa,sa}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
703	267c8d8e-5ba7-5765-beff-fd7bd66052d6	29	{te,te,te}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
704	267c8d8e-5ba7-5765-beff-fd7bd66052d6	26	{ta,ta,ta}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
705	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:06:25.196603
706	267c8d8e-5ba7-5765-beff-fd7bd66052d6	31	{da,da,da}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
707	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
708	267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	{ga,ga,ga}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
709	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	{ku,ku,ku}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
710	267c8d8e-5ba7-5765-beff-fd7bd66052d6	34	{de,de,de}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
711	267c8d8e-5ba7-5765-beff-fd7bd66052d6	13	{su,su,su}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:07:23.506213
712	267c8d8e-5ba7-5765-beff-fd7bd66052d6	35	{do,do}	{CORRECT,CORRECT}	2020-06-25 09:07:23.506213
713	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u}	{CORRECT,CORRECT}	2020-06-25 09:07:23.506213
714	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	{shi,shi}	{CORRECT,CORRECT}	2020-06-25 09:07:23.506213
715	267c8d8e-5ba7-5765-beff-fd7bd66052d6	29	{te,te}	{CORRECT,CORRECT}	2020-06-25 09:07:23.506213
716	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
717	267c8d8e-5ba7-5765-beff-fd7bd66052d6	38	{nu,nu,nu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
718	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7	{ki,ki,ki}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
719	267c8d8e-5ba7-5765-beff-fd7bd66052d6	40	{no,no,no}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
720	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
721	267c8d8e-5ba7-5765-beff-fd7bd66052d6	36	{na,na,na}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
722	267c8d8e-5ba7-5765-beff-fd7bd66052d6	37	{ni,ni,ni}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
723	267c8d8e-5ba7-5765-beff-fd7bd66052d6	39	{ne,ne,ne}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
724	267c8d8e-5ba7-5765-beff-fd7bd66052d6	10	{ko,ko,ko}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:09:50.492717
725	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:11:24.052739
726	267c8d8e-5ba7-5765-beff-fd7bd66052d6	71	{n,n,n,n,n,n,n,n}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:11:24.052739
727	267c8d8e-5ba7-5765-beff-fd7bd66052d6	14	{se,se,se}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:11:24.052739
728	267c8d8e-5ba7-5765-beff-fd7bd66052d6	19	{ge,ge,ge}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:11:24.052739
729	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7	{ki,ki,ki}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:11:24.052739
730	267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	{ga,ga}	{CORRECT,CORRECT}	2020-06-25 09:11:24.052739
731	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i}	{CORRECT,CORRECT}	2020-06-25 09:11:24.052739
732	267c8d8e-5ba7-5765-beff-fd7bd66052d6	10	{ko,ko}	{CORRECT,CORRECT}	2020-06-25 09:11:24.052739
733	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	{ku,ku}	{CORRECT,CORRECT}	2020-06-25 09:11:24.052739
734	267c8d8e-5ba7-5765-beff-fd7bd66052d6	22	{ji,ji}	{CORRECT,CORRECT}	2020-06-25 09:11:24.052739
735	267c8d8e-5ba7-5765-beff-fd7bd66052d6	42	{hi,hi,hi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
736	267c8d8e-5ba7-5765-beff-fd7bd66052d6	30	{to,to,to,to,to,to}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
737	267c8d8e-5ba7-5765-beff-fd7bd66052d6	41	{ha,ha,ha}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
738	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
739	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
740	267c8d8e-5ba7-5765-beff-fd7bd66052d6	43	{fu,fu,fu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
741	267c8d8e-5ba7-5765-beff-fd7bd66052d6	44	{he,he,he}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
742	267c8d8e-5ba7-5765-beff-fd7bd66052d6	71	{n,n,n,n,n,n}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
743	267c8d8e-5ba7-5765-beff-fd7bd66052d6	37	{ni,ni,ni}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
744	267c8d8e-5ba7-5765-beff-fd7bd66052d6	45	{ho,ho,ho}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:12:17.881725
745	267c8d8e-5ba7-5765-beff-fd7bd66052d6	46	{ba,ba,ba}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
746	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
747	267c8d8e-5ba7-5765-beff-fd7bd66052d6	50	{bo,bo,bo}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
748	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	{ku,ku,ku}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
749	267c8d8e-5ba7-5765-beff-fd7bd66052d6	42	{hi,hi,hi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
750	267c8d8e-5ba7-5765-beff-fd7bd66052d6	30	{to,to,to,to,to,to}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
751	267c8d8e-5ba7-5765-beff-fd7bd66052d6	47	{bi,bi,bi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
752	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	{a,a,a}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
753	267c8d8e-5ba7-5765-beff-fd7bd66052d6	48	{bu,bu,bu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
754	267c8d8e-5ba7-5765-beff-fd7bd66052d6	36	{na,na,na}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
755	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
756	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
757	267c8d8e-5ba7-5765-beff-fd7bd66052d6	49	{be,be,be}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
758	267c8d8e-5ba7-5765-beff-fd7bd66052d6	71	{n,n,n}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
759	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:15:23.261746
760	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
761	267c8d8e-5ba7-5765-beff-fd7bd66052d6	56	{ma,ma,ma,ma,ma,ma}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
762	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
763	267c8d8e-5ba7-5765-beff-fd7bd66052d6	13	{su,su,su,su,su,su}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
764	267c8d8e-5ba7-5765-beff-fd7bd66052d6	57	{mi,mi,mi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
765	267c8d8e-5ba7-5765-beff-fd7bd66052d6	14	{se,se,se}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
766	267c8d8e-5ba7-5765-beff-fd7bd66052d6	71	{n,n,n}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
767	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
768	267c8d8e-5ba7-5765-beff-fd7bd66052d6	59	{me,me,me}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
769	267c8d8e-5ba7-5765-beff-fd7bd66052d6	11	{sa,sa,sa}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
770	267c8d8e-5ba7-5765-beff-fd7bd66052d6	58	{mu,mu,mu}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
771	267c8d8e-5ba7-5765-beff-fd7bd66052d6	60	{mo,mo,mo}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
772	267c8d8e-5ba7-5765-beff-fd7bd66052d6	40	{no,no,no}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:16:21.912479
773	267c8d8e-5ba7-5765-beff-fd7bd66052d6	69	{wa,wa,wa,wa,wa,wa}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-06-25 09:17:03.322651
774	267c8d8e-5ba7-5765-beff-fd7bd66052d6	26	{ta,ta,ta}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:17:03.322651
775	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	{shi,shi,shi}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:17:03.322651
776	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	{ka,ka,ka}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:17:03.322651
777	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-06-25 09:17:03.322651
778	267c8d8e-5ba7-5765-beff-fd7bd66052d6	70	{wo,wo}	{CORRECT,CORRECT}	2020-06-25 09:17:03.322651
779	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:37:15.041385
780	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:37:15.041385
781	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:37:15.041385
782	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:37:15.041385
783	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,o,o}	{CORRECT,INCORRECT,INCORRECT}	2020-06-30 07:37:15.041385
784	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:06.585851
785	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:06.585851
786	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:06.585851
787	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:06.585851
788	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:06.585851
789	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:09.177435
790	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:09.177435
791	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:09.177435
792	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:09.177435
793	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:09.177435
794	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:11.50631
795	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:11.50631
796	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:11.50631
797	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:11.50631
798	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:11.50631
799	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:11.741833
800	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:11.741833
801	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:11.741833
802	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:11.741833
803	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:11.741833
804	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:11.964701
805	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:11.964701
806	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:11.964701
807	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:11.964701
808	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:11.964701
809	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:12.206004
810	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:12.206004
811	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:12.206004
812	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:12.206004
813	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:12.206004
814	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a}	{CORRECT}	2020-06-30 07:41:12.875973
815	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o}	{CORRECT}	2020-06-30 07:41:12.875973
816	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 07:41:12.875973
817	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:41:12.875973
818	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e,e}	{CORRECT,CORRECT,CORRECT}	2020-06-30 07:41:12.875973
819	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{k}	{INCORRECT}	2020-06-30 07:49:08.256036
820	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e}	{CORRECT}	2020-06-30 07:49:08.256036
821	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	7	{ki}	{CORRECT}	2020-06-30 07:49:08.256036
822	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	10	{ko}	{CORRECT}	2020-06-30 07:49:08.256036
823	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u}	{CORRECT}	2020-06-30 07:49:08.256036
824	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	9	{ke}	{CORRECT}	2020-06-30 07:49:08.256036
825	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i}	{CORRECT}	2020-06-30 07:49:08.256036
826	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{a,ka}	{INCORRECT,CORRECT}	2020-06-30 07:49:08.256036
827	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8	{ku,ku}	{CORRECT,CORRECT}	2020-06-30 07:49:08.256036
828	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	17	{gi}	{CORRECT}	2020-06-30 08:01:09.517248
829	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	20	{go}	{CORRECT}	2020-06-30 08:01:09.517248
830	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	19	{ge}	{CORRECT}	2020-06-30 08:01:09.517248
831	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{ka,ka,ka}	{CORRECT,CORRECT,CORRECT}	2020-06-30 08:01:09.517248
832	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	18	{gu}	{CORRECT}	2020-06-30 08:01:09.517248
833	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	{e,e}	{CORRECT,CORRECT}	2020-06-30 08:01:09.517248
834	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i}	{CORRECT,CORRECT}	2020-06-30 08:01:09.517248
835	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16	{ga}	{CORRECT}	2020-06-30 08:01:09.517248
836	267c8d8e-5ba7-5765-beff-fd7bd66052d6	44	{he,he,he}	{CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
837	267c8d8e-5ba7-5765-beff-fd7bd66052d6	61	{ya,ya,ya}	{CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
838	267c8d8e-5ba7-5765-beff-fd7bd66052d6	62	{yu,yu,yu}	{CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
839	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
840	267c8d8e-5ba7-5765-beff-fd7bd66052d6	59	{me,me,me}	{CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
841	267c8d8e-5ba7-5765-beff-fd7bd66052d6	28	{tsu,tsu}	{CORRECT,CORRECT}	2020-07-04 04:29:06.302009
842	267c8d8e-5ba7-5765-beff-fd7bd66052d6	63	{yo,yo}	{CORRECT,CORRECT}	2020-07-04 04:29:06.302009
843	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	{i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 04:29:06.302009
844	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
845	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	15	{so,so,so}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
846	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	11	{sa,sa,sa}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
847	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	9	{ke,ke,ke}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
848	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	{shi,shi,shi}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
849	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	13	{su,su,su,su,su}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
850	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	20	{go,go}	{CORRECT,CORRECT}	2020-07-04 06:05:53.998278
851	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16	{ga,ga,ga}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
852	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8	{ku,ku,ku}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
853	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	14	{se,se,se}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
854	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i,i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:05:53.998278
855	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	24	{ze,ze,ze}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
856	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	25	{zo,zo,zo}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
857	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
858	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	21	{za,za,za}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
859	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	105	{s,s,s}	{INCORRECT,INCORRECT,INCORRECT}	2020-07-04 06:17:01.311174
860	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	22	{ji,ji}	{CORRECT,CORRECT}	2020-07-04 06:17:01.311174
861	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	{shi,shi,shi,shi,shi,shi}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
862	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	23	{zu,zu,zu}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
863	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a,a,a,a}	{CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
864	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{ka,ka,ka,ka,ka,ka,ka,ka}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:17:01.311174
865	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	26	{ta,ta,ta}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
866	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{ka,ka,ka}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
867	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	27	{chi,chi,chi}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
868	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	11	{sa,sa,sa}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
869	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
870	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	28	{tsu,tsu,tsu}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
871	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	17	{gi,gi,gi}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
872	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	30	{to,to,to}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
873	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	{shi,shi,shi}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
874	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	29	{te,te,te}	{CORRECT,CORRECT,CORRECT}	2020-07-04 06:41:21.230646
875	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	31	{da,da,da}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
876	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
877	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16	{ga,ga,ga}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
878	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8	{ku,ku,ku}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
879	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	34	{de,de,de}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
880	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	13	{su,su,su}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:10:27.894555
881	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	35	{do,do}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
882	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u,u}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
883	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	{shi,shi}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
884	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	29	{te,te}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
885	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a,a}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
886	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{ka,ka}	{CORRECT,CORRECT}	2020-07-04 07:10:27.894555
887	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	{i,i,i}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
888	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	38	{nu,nu,nu}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
889	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	39	{ne,ne,ne}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
890	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	10	{ko,ko,ko}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
891	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	7	{ki,ki,ki}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
892	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	40	{no,no,no}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
893	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	{u,u,u}	{CORRECT,CORRECT,CORRECT}	2020-07-04 07:29:05.669917
894	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	36	{na,na}	{CORRECT,CORRECT}	2020-07-04 07:29:05.669917
895	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	37	{ni,ni}	{CORRECT,CORRECT}	2020-07-04 07:29:05.669917
896	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	{a,a}	{CORRECT,CORRECT}	2020-07-04 07:29:05.669917
897	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	{ka,ka}	{CORRECT,CORRECT}	2020-07-04 07:29:05.669917
898	e758a541-973b-5922-8090-339365f29818	1	{a,a,a}	{CORRECT,CORRECT,CORRECT}	2020-07-20 14:59:24.078711
899	e758a541-973b-5922-8090-339365f29818	5	{o,o,o}	{CORRECT,CORRECT,CORRECT}	2020-07-20 14:59:24.078711
900	e758a541-973b-5922-8090-339365f29818	3	{u,u}	{CORRECT,CORRECT}	2020-07-20 14:59:24.078711
901	e758a541-973b-5922-8090-339365f29818	2	{i,i,i,i,i,i}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-20 14:59:24.078711
902	e758a541-973b-5922-8090-339365f29818	4	{e,e,e,e,e,e,e,e}	{CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT,CORRECT}	2020-07-20 14:59:24.078711
\.


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.characters (id, "character", type, readings) FROM stdin;
1	あ	HIRAGANA	\N
2	い	HIRAGANA	\N
3	う	HIRAGANA	\N
4	え	HIRAGANA	\N
5	お	HIRAGANA	\N
6	か	HIRAGANA	\N
7	き	HIRAGANA	\N
8	く	HIRAGANA	\N
9	け	HIRAGANA	\N
10	こ	HIRAGANA	\N
11	さ	HIRAGANA	\N
12	し	HIRAGANA	\N
13	す	HIRAGANA	\N
14	せ	HIRAGANA	\N
15	そ	HIRAGANA	\N
16	が	HIRAGANA	\N
17	ぎ	HIRAGANA	\N
18	ぐ	HIRAGANA	\N
19	げ	HIRAGANA	\N
20	ご	HIRAGANA	\N
21	ざ	HIRAGANA	\N
22	じ	HIRAGANA	\N
23	ず	HIRAGANA	\N
24	ぜ	HIRAGANA	\N
25	ぞ	HIRAGANA	\N
26	た	HIRAGANA	\N
27	ち	HIRAGANA	\N
28	つ	HIRAGANA	\N
29	て	HIRAGANA	\N
30	と	HIRAGANA	\N
31	だ	HIRAGANA	\N
32	ぢ	HIRAGANA	\N
33	づ	HIRAGANA	\N
34	で	HIRAGANA	\N
35	ど	HIRAGANA	\N
36	な	HIRAGANA	\N
37	に	HIRAGANA	\N
38	ぬ	HIRAGANA	\N
39	ね	HIRAGANA	\N
40	の	HIRAGANA	\N
41	は	HIRAGANA	\N
42	ひ	HIRAGANA	\N
43	ふ	HIRAGANA	\N
44	へ	HIRAGANA	\N
45	ほ	HIRAGANA	\N
46	ば	HIRAGANA	\N
47	び	HIRAGANA	\N
48	ぶ	HIRAGANA	\N
49	べ	HIRAGANA	\N
50	ぼ	HIRAGANA	\N
51	ぱ	HIRAGANA	\N
52	ぴ	HIRAGANA	\N
53	ぷ	HIRAGANA	\N
54	ぺ	HIRAGANA	\N
55	ぽ	HIRAGANA	\N
56	ま	HIRAGANA	\N
57	み	HIRAGANA	\N
58	む	HIRAGANA	\N
59	め	HIRAGANA	\N
60	も	HIRAGANA	\N
61	や	HIRAGANA	\N
62	ゆ	HIRAGANA	\N
63	よ	HIRAGANA	\N
64	ら	HIRAGANA	\N
65	り	HIRAGANA	\N
66	る	HIRAGANA	\N
67	れ	HIRAGANA	\N
68	ろ	HIRAGANA	\N
69	わ	HIRAGANA	\N
70	を	HIRAGANA	\N
71	ん	HIRAGANA	\N
72	きゃ	HIRAGANA	\N
73	きゅ	HIRAGANA	\N
74	きょ	HIRAGANA	\N
75	ぎゃ	HIRAGANA	\N
76	ぎゅ	HIRAGANA	\N
77	ぎょ	HIRAGANA	\N
78	しゃ	HIRAGANA	\N
79	しゅ	HIRAGANA	\N
80	しょ	HIRAGANA	\N
81	じゃ	HIRAGANA	\N
82	じゅ	HIRAGANA	\N
83	じょ	HIRAGANA	\N
84	ちゃ	HIRAGANA	\N
85	ちゅ	HIRAGANA	\N
86	ちょ	HIRAGANA	\N
87	にゃ	HIRAGANA	\N
88	にゅ	HIRAGANA	\N
89	にょ	HIRAGANA	\N
90	ひゃ	HIRAGANA	\N
91	ひゅ	HIRAGANA	\N
92	ひょ	HIRAGANA	\N
93	びゃ	HIRAGANA	\N
94	びゅ	HIRAGANA	\N
95	びょ	HIRAGANA	\N
96	ぴゃ	HIRAGANA	\N
97	ぴゅ	HIRAGANA	\N
98	ぴょ	HIRAGANA	\N
99	みゃ	HIRAGANA	\N
100	みゅ	HIRAGANA	\N
101	みょ	HIRAGANA	\N
102	りゃ	HIRAGANA	\N
103	りゅ	HIRAGANA	\N
104	りょ	HIRAGANA	\N
105	っ	HIRAGANA	\N
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.courses (id, title, unlocks_ids) FROM stdin;
KATAKANA	Intro to Katakana	\N
GRAMMAR_1	Very Basic Conversation	\N
HIRAGANA	Hiragana - The Japanese Alphabet	KATAKANA,GRAMMAR_1
\.


--
-- Data for Name: lectures; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.lectures (id, text, image, "position", set_lesson_id, title) FROM stdin;
28	This next set is the "ka" set, which all start with K (and, of course, end in A, I, U, E, and O)	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ka/lecture-2.png	PRETEST	HIRAGANA_KA	The Next Set
38	A voiced consonant is a consonant that you need to move your vocal cords to make.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-1.png	PRETEST	HIRAGANA_GA	What is a "voiced" consonant?
27	Now you know あいうえお, which are the only Hiragana that don't start with a consonant sound.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ka/lecture-1.png	PRETEST	HIRAGANA_KA	The Next Set
35	The next set of hiragana is the "sa" set. They all start with an "s" sound.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-1.png	PRETEST	HIRAGANA_SA	The Sa Set
36	Well... that's not entirely true. Instead of "si", it's "shi".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-2.png	PRETEST	HIRAGANA_SA	The Sa Set
37	After all, we couldn't have sushi without the "shi" sound!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-sa/lecture-3.png	PRETEST	HIRAGANA_SA	The Sa Set
43	Remember, TenTens can be added to hiragana to make the consonant part "voiced".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-1.png	PRETEST	HIRAGANA_ZA	The Za Set
44	The "sa" set can also have a TenTen attached, which turns an S sound into a Z sound.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-2.png	PRETEST	HIRAGANA_ZA	The Za Set
45	The one exception, of course, is "し" (shi). Shi becomes *ji*. Let's get started!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-3.png	PRETEST	HIRAGANA_ZA	The Za Set
46	Sorry, just one more thing. This little character "っ" doubles consonant sounds.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-4.png	BEFORE_THIRD	HIRAGANA_ZA	The Consonant Doubler
47	It doesn't make any sound on its own, but it extends the consonant sound of the next hiragana.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-za/lecture-5.png	BEFORE_THIRD	HIRAGANA_ZA	The Consonant Doubler
50	The fourth set of hiragana is the "ta" set, which is the trickiest set of all.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-1.png	PRETEST	HIRAGANA_TA	The Ta Set
51	Instead of "ti" it's "chi", and instead of "tu" it's "tsu"	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-2.png	PRETEST	HIRAGANA_TA	The Ta Set
52	That's right, this character "つ" is "tsu". When it's small, it doubles consonants, but full sized it's a letter on its own	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-3.png	PRETEST	HIRAGANA_TA	Tsu?
53	Here they are side by side, so you can see the difference: "つっ".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ta/lecture-4.png	PRETEST	HIRAGANA_TA	Tsu?
54	The "ta" set is the second last set that can have TenTens added, but it's a bit different because of "chi" and "tsu".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-1.png	PRETEST	HIRAGANA_DA	Ta Set + TenTens
55	The T sound in the normal ones ("ta", "te" and "to") becomes a D sound.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-2.png	PRETEST	HIRAGANA_DA	Ta Set + TenTens
56	"chi" and "tsu" technically can have TenTens, but it's quite rare to see them. (They become second versions of "ji" and "zu")	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-3.png	PRETEST	HIRAGANA_DA	Ta Set + TenTens
58	There aren't any strange exceptions or new rules in the "na" set! Enjoy the lesson.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-na/lecture-1.png	PRETEST	HIRAGANA_NA	The Na Set
59	"n" is already a voiced consonant, so letters in the "na" line cannot have a TenTen. This bonus round is different.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-1.png	PRETEST	HIRAGANA_N	The Na Set Bonus Round
61	Since it's only one new letter, we'll cover three new, useful words which use it.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-3.png	PRETEST	HIRAGANA_N	The Letter N
39	For example, the K's in 'kick' are unvoiced, and the G's in 'gag' are voiced.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-2.png	PRETEST	HIRAGANA_GA	What is a "voiced" consonant?
40	Try it yourself! Put your hand on your throat and say 'kick' and 'gag'. You'll feel the G's vibrate.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-3.png	PRETEST	HIRAGANA_GA	What is a "voiced" consonant?
24	Hiragana each represent syllables, rather than single letters.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-2.png	PRETEST	HIRAGANA_A	What is Hiragana?
25	Because they represent syllables, they are always pronounced exactly the same way, unlike English letters.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-2.png	PRETEST	HIRAGANA_A	What is Hiragana?
26	Hiragana come in sets of 5. In this lesson, we'll learn the first 5 - A, I, U, E, and O.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-4.png	PRETEST	HIRAGANA_A	What is Hiragana?
42	In this lesson, we'll learn words with the "ga" set. That's the "ka" set plus TenTens.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-5.png	PRETEST	HIRAGANA_GA	The TenTen
66	The sixth hiragana set is the "ha" set. It only has one tricky character.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ha/lecture-1.png	PRETEST	HIRAGANA_HA	The Ha Set
68	The "ha" set is the last set that can have TenTens attached. When it does, it transforms the sound from "H" to "B".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ba/lecture-1.png	PRETEST	HIRAGANA_BA	Back to TenTens
69	Even though "ふ" is an exception, it gets changed to "bu", just like the rest of the set.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ba/lecture-2.png	PRETEST	HIRAGANA_BA	What About Fu?
70	The seventh set of hiragana is the "ma" set. Only 3 more to go!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ma/lecture-1.png	PRETEST	HIRAGANA_MA	The Ma Set
71	Just like the "な" set, it doesn't have any tricky characters. Enjoy!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ma/lecture-2.png	PRETEST	HIRAGANA_MA	The Ma Set
72	This bonus round is all about the "wa" set, although it's not much of a set.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-1.png	PRETEST	HIRAGANA_WA	The Wa "Set"
73	There are only "two" characters in the set, and one of them isn't even used in words (it's more like a punctuation mark).	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-2.png	PRETEST	HIRAGANA_WA	The Wa Set
76	We're getting to the end of the hiragana sets, and they do get a bit strange from here on.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-1.png	PRETEST	HIRAGANA_YA	The Ya Set
77	This set is the "ya" set, but it looks like it's missing two characters.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-2.png	PRETEST	HIRAGANA_YA	The Ya Set
78	Japanese doesn't actually have the yi and ye sounds. There are only three characters in this set.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ya/lecture-3.png	PRETEST	HIRAGANA_YA	The Ya Set
79	Just like "つ", "ya", "yu" and "yo" can also become smaller to do something different.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-1.png	PRETEST	HIRAGANA_LYA	Little Ya, Yu, and Yo
80	They can go after any hiragana that ends in "i" ("shi", "chi", "hi", "ni", etc.) to modify the sound.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-2.png	PRETEST	HIRAGANA_LYA	Little Ya, Yu and Yo
81	For example, "ki" + "ya" = "kya". There are lots of combinations, so they're not all listed here.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-3.png	PRETEST	HIRAGANA_LYA	Little Ya, Yu and Yo
82	Once you get the hang of how they combine, it will feel pretty intuitive!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-lya/lecture-4.png	PRETEST	HIRAGANA_LYA	Little Ya, Yu and Yo
83	This is the final set of hiragana! Well done for making it all the way here.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-1.png	PRETEST	HIRAGANA_RA	The Ra Set
84	The "ra" set is hard for English speakers to pronounce, in the same way the English "l" and "r" are hard for Japanese people	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-2.png	PRETEST	HIRAGANA_RA	The Ra Set
85	It's definitely worth checking out some videos to practice your pronunciation.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-3.png	PRETEST	HIRAGANA_RA	The Ra Set
86	Other than that, this set is pretty normal. Just one more bonus lesson after this!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ra/lecture-4.png	PRETEST	HIRAGANA_RA	The Ra Set
87	The "は" set has one last trick up its sleeve, besides the TenTen.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-1.png	PRETEST	HIRAGANA_PA	Return To The Ha Set
88	The Maru is sort of like the TenTen - it changes how hiragana is pronounced, but it only works with the "は" set.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-2.png	PRETEST	HIRAGANA_PA	The Maru
89	When a hiragana from the "は" set has a Maru, its consonant sound changes from "H" to "P".	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-pa/lecture-3.png	PRETEST	HIRAGANA_PA	The Maru
23	Hiragana is the Japanese alphabet. You need to be able to read Hiragana if you want to start learning Japanese.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-a/lecture-1.png	PRETEST	HIRAGANA_A	What is Hiragana?
41	Your mouth makes the same movements for G and K. The only difference is the vocal cords. In Japanese, you can turn a hiragana into a voiced hiragana by adding a TenTen.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-4.png	PRETEST	HIRAGANA_GA	The TenTen
48	It's hard to explain it fully here. All you need to know is that to write it, you write a second consonant.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-6.png	BEFORE_THIRD	HIRAGANA_ZA	The Consonant Doubler
49	If you'd like to know more, it might be worth checking out some YouTube videos that explain it.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ga/lecture-7.png	BEFORE_THIRD	HIRAGANA_ZA	The Consonant Doubler
57	For now, you can safely assume that they never get TenTens, so there's only 3 new characters in this lesson!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-da/lecture-4.png	PRETEST	HIRAGANA_DA	Ta Set + TenTens
60	In this lesson, you'll learn a new letter, "ん" "n". This is a special letter: It's the only Japanese letter that represents a single consonant, by itself.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-n/lecture-2.png	PRETEST	HIRAGANA_N	The Letter N
67	The tricky one is written as "fu", but it's pronounced more like "fhu". It's a combination of the H and F sounds.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-ha/lecture-2.png	PRETEST	HIRAGANA_HA	Fu? Hu? Fhu?
74	There's "wa", which is the real character, and "wo", which is the weird, semi-fake character.	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-3.png	PRETEST	HIRAGANA_WA	The Wa Set
75	It doesn't make much sense now, but once you start learning how to make Japanese sentences, "wo" will become very important!	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262011/lessons/hiragana-wa/lecture-4.png	PRETEST	HIRAGANA_WA	The Wa Set
92	You know "{me_furi}" is 'I' or 'me', and "です" is 'is' or 'am'. So what is the "は"?	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-3.png	PRETEST	GMR_WA_DESU	Your First Sentence Pattern
93	"は" is a "particle". Particles are hiragana that get added to the end of a word to tell you what the word's purpose is.	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-4.png	PRETEST	GMR_WA_DESU	Particles
94	"は" is the particle that marks the topic of the sentence. When you say 'I am something', *you* are the topic, so "は" goes after {me_furi}	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-4.png	PRETEST	GMR_WA_DESU	Particles
95	Also, "は" is pronounced wa, not ha - particles are the only place in Japanese where characters are pronounced differently.	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-4.png	PRETEST	GMR_WA_DESU	Particles
90	You already know a few words, but now it's time to learn how to say your first sentence in Japanese: 'I'm X'.	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-1.png	PRETEST	GMR_WA_DESU	Your First Sentence Pattern
91	To say 'I am _something_', you say '"{me_furi}"は something です'. The word for 'I' will be different depending on your gender.	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-2.png	PRETEST	GMR_WA_DESU	Your First Sentence Pattern
96	To summarise with an example, '{me_furi}は {fname} です' literally translates to 'I {fname} am'. In Japanese, the topic comes first, and the verb always comes last.	https://res.cloudinary.com/holistic-japanese/image/upload/v1593401161/lessons/grammar_1/gmr_wa_desu/lecture-4.png	PRETEST	GMR_WA_DESU	Summary
97	You now know how to describe yourself, and in this lesson you'll learn how to describe anything!	https://res.cloudinary.com/holistic-japanese/image/upload/v1595227615/lessons/grammar_1/gmr_wa_desu_2/lecture-1.png	PRETEST	GMR_WA_DESU_2	Describing Anything
98	Instead of saying "{me_furi}は ...", you can add any noun before the は, and it will become the topic of the sentence.	https://res.cloudinary.com/holistic-japanese/image/upload/v1595227831/lessons/grammar_1/gmr_wa_desu_2/lecture-2.png	PRETEST	GMR_WA_DESU_2	Describing Anything
99	In this lesson, you'll revise some words you learnt in the hiragana course, and learn some new ones: "これ", "それ", and "あれ".	https://res.cloudinary.com/holistic-japanese/image/upload/v1595227357/lessons/grammar_1/gmr_wa_desu_2/lecture-3.png	PRETEST	GMR_WA_DESU_2	Describing Anything
100	These words mean 'this', 'that' and 'that (over there)'. Which one you use depends on where the object is in relation to you.	https://res.cloudinary.com/holistic-japanese/image/upload/v1595227357/lessons/grammar_1/gmr_wa_desu_2/lecture-3.png	PRETEST	GMR_WA_DESU_2	これ、それ、あれ
101	Now you know how to describe anything using the "'Xは Yです'" pattern. In this lesson, you'll learn how to describe multiple things at once.	https://res.cloudinary.com/holistic-japanese/image/upload/v1595227831/lessons/grammar_1/gmr_wa_desu_2/lecture-2.png	PRETEST	GMR_MO_DESU	Multiple Things
102	We have some new "particles"! Remember, particles go at the end of a word and flag what the word's role is in the sentence, like "は".	https://res.cloudinary.com/holistic-japanese/image/upload/v1595821956/lessons/grammar_1/gmr_mo_desu/lecture-2.png	PRETEST	GMR_MO_DESU	New Particles
103	The particle "と" almost directly translates to "and". (But it can only be used to connect nouns, not adjectives or verbs)	https://res.cloudinary.com/holistic-japanese/image/upload/v1595821707/lessons/grammar_1/gmr_mo_desu/lecture-3.png	PRETEST	GMR_MO_DESU	Particle と
104	For example, 'すし"と" おべんとうは おいしい です' means 'Sushi "and" obento are delicious'.	https://res.cloudinary.com/holistic-japanese/image/upload/v1595821707/lessons/grammar_1/gmr_mo_desu/lecture-3.png	PRETEST	GMR_MO_DESU	Particle と
105	The particle "も" almost directly translates to "also" or "too". It needs context to make sense though.	https://res.cloudinary.com/holistic-japanese/image/upload/v1595822092/lessons/grammar_1/gmr_mo_desu/lecture-5.png	PRETEST	GMR_MO_DESU	Particle も
106	For example, if someone said 'すしは おいしいです' (sushi is delicious), you could say 'おべんとうも おいしいです' (obento is also delicious).	https://res.cloudinary.com/holistic-japanese/image/upload/v1595822092/lessons/grammar_1/gmr_mo_desu/lecture-5.png	PRETEST	GMR_MO_DESU	Particle も
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.session (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: set_lessons; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.set_lessons (id, title, image, unlocks_ids, course_id, skill_level, time_estimate) FROM stdin;
HIRAGANA_PA	Hiragana Lesson 9 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-pa/title.png	NEXT_COURSE	HIRAGANA	Beginner	420
HIRAGANA_A	Hiragana Lesson 1	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-a/title.png	HIRAGANA_KA	HIRAGANA	Beginner	420
HIRAGANA_KA	Hiragana Lesson 2	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ka/title.png	HIRAGANA_GA	HIRAGANA	Beginner	420
HIRAGANA_GA	Hiragana Lesson 2 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ga/title.png	HIRAGANA_SA	HIRAGANA	Beginner	420
HIRAGANA_SA	Hiragana Lesson 3	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-sa/title.png	HIRAGANA_ZA	HIRAGANA	Beginner	420
HIRAGANA_ZA	Hiragana Lesson 3 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-za/title.png	HIRAGANA_TA	HIRAGANA	Beginner	420
HIRAGANA_TA	Hiragana Lesson 4	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ta/title.png	HIRAGANA_DA	HIRAGANA	Beginner	420
HIRAGANA_DA	Hiragana Lesson 4 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-da/title.png	HIRAGANA_NA	HIRAGANA	Beginner	420
HIRAGANA_NA	Hiragana Lesson 5	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-na/title.png	HIRAGANA_N	HIRAGANA	Beginner	420
HIRAGANA_N	Hiragana Lesson 5 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-n/title.png	HIRAGANA_HA	HIRAGANA	Beginner	420
HIRAGANA_HA	Hiragana Lesson 6	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ha/title.png	HIRAGANA_BA	HIRAGANA	Beginner	420
HIRAGANA_BA	Hiragana Lesson 6 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ba/title.png	HIRAGANA_MA	HIRAGANA	Beginner	420
HIRAGANA_MA	Hiragana Lesson 7	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ma/title.png	HIRAGANA_WA	HIRAGANA	Beginner	420
HIRAGANA_WA	Hiragana Lesson 7 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-wa/title.png	HIRAGANA_YA	HIRAGANA	Beginner	420
HIRAGANA_YA	Hiragana Lesson 8	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ya/title.png	HIRAGANA_LYA	HIRAGANA	Beginner	420
HIRAGANA_LYA	Hiragana Lesson 8 - Bonus Round	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-lya/title.png	HIRAGANA_RA	HIRAGANA	Beginner	420
HIRAGANA_RA	Hiragana Lesson 9	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/hiragana-ra/title.png	HIRAGANA_PA	HIRAGANA	Beginner	420
KATAKANA_1	Katakana Lesson 1	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/katakana-1/title.png	KATAKANA_2	KATAKANA	Beginner	420
KATAKANA_2	Katakana Lesson 2	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/katakana-2/title.png	KATAKANA_3	KATAKANA	Beginner	420
GMR_WA_DESU	Talking about yourself	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/gmr-particle-wa/title.png	GMR_WA_DESU_2	GRAMMAR_1	Beginner	420
GMR_WA_DESU_2	This, that, and the other	https://res.cloudinary.com/holistic-japanese/image/upload/v1587262008/lessons/gmr-particle-wa-2/title.png	GMR_MO_DESU	GRAMMAR_1	Beginner	600
GMR_MO_DESU	And Also	todo: add image link	GMR_DESHITA	GRAMMAR_1	Beginner	600
\.


--
-- Data for Name: testable_results; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.testable_results (id, created_at, answers, marks, user_id, testable_id) FROM stdin;
7	2020-07-13 00:02:50.359541	{"im yuji"}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1
8	2020-07-13 00:02:50.359541	{ぼくはhugoです}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3
9	2020-07-13 00:02:50.359541	{"im ok"}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4
10	2020-07-13 00:02:50.359541	{ぼくはだいじょうぶです}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6
11	2020-07-13 00:02:50.359541	{"yes, im japanese"}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7
12	2020-07-13 00:02:50.359541	{ゆじはにほんじんです}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8
\.


--
-- Data for Name: testables; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.testables (id, set_lesson_id, person, location, context_jp, context_fg, context_en, possible_answers, question_text, question_text_fg, word_id, question_type, order_in_lesson, context_speaker, answer_type, question_prompt) FROM stdin;
2	GMR_WA_DESU	\N	\N	\N	\N	\N	\N	\N	\N	76	J_WORD	2	\N	ROMAJI	\N
5	GMR_WA_DESU	\N	\N	\N	\N	\N	\N	\N	\N	77	J_WORD	5	\N	ROMAJI	\N
7	GMR_WA_DESU	YUJI_CHATTING	HOSTEL_LOBBY	\N	\N	Are you Japanese?	Yes, I'm Japanese/Yes, Im Japanese/Yes, I am Japanese	はい、僕.は　日本人　です。	はい、ぼく.は　にほんじん　です。	77	J_SENTENCE	7	You	ENGLISH	Translate Yuji's reply
4	GMR_WA_DESU	CHIEKO_LUGGAGE	AIRPORT	\N	\N	Excuse me ma'am, do you need any help?	I'm ok/Im ok/I am ok/I'm alright/Im alright/I am alright	私.は　大丈夫　です。	わたし.は　だいじょうぶ　です。	76	J_SENTENCE	4	You	ENGLISH	Translate Chieko's reply
18	GMR_WA_DESU_2	\N	\N	\N	\N	\N	\N	\N	\N	78	J_WORD	1	\N	ROMAJI	\N
6	GMR_WA_DESU	HINAKO_SERVICE	AIRPORT	タクシー.と　呼んで　もらえます.か？	タクシー.と　よんで　もらえます.か？	Would you like me to call you a taxi?	{me}.は　大丈夫　です/{me_furi}.は　だいじょうぶ　です	I'm alright	\N	76	E_SENTENCE	6	Hinako (airport staff)	JAPANESE	Write your reply in Japanese
19	GMR_WA_DESU_2	\N	\N	\N	\N	\N	\N	\N	\N	79	J_WORD	2	\N	ROMAJI	\N
20	GMR_WA_DESU_2	YUJI_EATING	HOSTEL_LOBBY	\N	\N	What are you eating?	This is obento/This is bento/This is a bento/This is a bento box/This is obento box/This is an obento/This is an obento box	これ.は　お弁当　です。	これ.は　おべんとう　です。	\N	J_SENTENCE	3	You	ENGLISH	Translate Yuji's reply
21	GMR_WA_DESU_2	HINAKO_EATING	RESTAURANT	\N	\N	What is this?	That's tofu/That is tofu/That's toufu/That is toufu	それ.は　豆腐　です。	それ.は　とうふ  です。	\N	J_SENTENCE	4	You (confused about something on your plate)	ENGLISH	Translate Hinako's reply
22	GMR_WA_DESU_2	\N	\N	\N	\N	\N	\N	\N	\N	80	J_WORD	5	\N	ROMAJI	\N
23	GMR_WA_DESU_2	YUJI_CHATTING	HOSTEL_LOBBY	それ.は　何？	それ.は　なに？	What's that?	これ.は　ペン　です/これ.は　ぺん　です	This is a pen.	\N	\N	E_SENTENCE	6	Yuji	JAPANESE	Write your reply in Japanese
3	GMR_WA_DESU	YUJI_CHATTING	HOSTEL_LOBBY	君.の　名前.は？	きみ.の　なまえ.は？	What's your name?	{me}.は　{fname}　です/{me_furi}.は　{fname}　です	I'm {fname}	\N	\N	E_SENTENCE	3	Yuji (just met)	JAPANESE	Write your reply in Japanese (but write your name in English characters)
8	GMR_WA_DESU	\N	\N	\N	\N	\N	ゆじ.は　日本人　です/ゆじ.は　にほんじん　です/ゆじ.は　日本じん　です/ゆうじ.は　日本人　です/ゆうじ.は　にほんじん　です/ゆうじ.は　日本じん　です	Yuji is Japanese	\N	77	E_SENTENCE	8	\N	JAPANESE	Translate the sentence into Japanese
1	GMR_WA_DESU	YUJI_CHATTING	HOSTEL_LOBBY	\N	\N	What's your name?	I'm Yuji/Im Yuji/I am Yuji	僕.は　ゆうじ　です。	ぼく.は　ゆうじ　です。	\N	J_SENTENCE	1	You	ENGLISH	Translate Yuji's reply (Words in blue are ones you have already learnt)
24	GMR_WA_DESU_2	HINAKO_POINTING	TOKYO_STREET	\N	\N	Look at the size of that arcade!	It's big/It's so big/It's huge/It is big/It is so big/It is huge/That's big/That's so big/That's huge/That is big/That is so big/That is huge	あれ.は　大きい　です！	あれ.は　おおきい　です！	\N	J_SENTENCE	7	You	ENGLISH	Translate Hinako's reply
25	GMR_WA_DESU_2	HINAKO_CHATTING	TOKYO_STREET	これ.は　何　言語　ですか？	これ.は　なに　げんご　ですか？	What language is this in?	それ.は　英語　です/それ.は　えいご　です	That's English	\N	\N	E_SENTENCE	8	Hinako (holding a foreign travel brochure)	ENGLISH	Write your reply in English
26	GMR_WA_DESU_2	YUJI_POINTING	TOKYO_STREET	あれ.を　見える？	あれ.を　みえる？	Do you see that?	うん、あれは　ねこ　です/うん、あれは　猫　です/はい、あれは　ねこ　です/はい、あれは　猫　です	Yeah, that's a cat over there	\N	\N	E_SENTENCE	9	Yuji (seeing a blur in an alley)	ENGLISH	Write your reply in English
27	GMR_MO_DESU	YUJI_CHATTING	HOSTEL_LOBBY	\N	\N	Dogs are so cute.	Cats are also cute/Cats are cute too/Cats are also cute, right?/Cats are cute too, right?	猫.も　かわいい　です.ね。	ねこ.も　かわいい　です.ね。	\N	J_SENTENCE	1	You	ENGLISH	Translate Yuji's reply (don't worry about the ね at the end for now)
28	GMR_MO_DESU	\N	\N	\N	\N	\N	\N	\N	\N	85	J_WORD	2	\N	ROMAJI	\N
29	GMR_MO_DESU	HINAKO_EATING	RESTAURANT	\N	\N	What sushi is good here?	Tuna and salmon are good/Tuna and salmon are delicious/The tuna and salmon are good/The tuna and salmon are delicious	鮪.と　鮭.は　うまい　です.よ。	まぐろ.と　しゃけ.は　うまい　です.よ。	\N	J_SENTENCE	3	You (looking at restaurant menu)	ENGLISH	Translate Hinako's reply (again, don't worry about the よ particle at the end)
30	GMR_MO_DESU	\N	\N	\N	\N	\N	\N	\N	\N	82	J_WORD	4	\N	ROMAJI	\N
31	GMR_WA_DESU_2	\N	\N	\N	\N	\N	\N	\N	\N	83	J_WORD	5	\N	ROMAJI	\N
32	GMR_MO_DESU	YUJI_CHATTING	HOSTEL_LOBBY	まぁ、英語.は　難しい　です.ね。	まぁ、えいご.は　むずかしい　です.ね。	Man, English is hard.	日本語.も　難しい　です/日本語.も　難しい　です.よ/にほんご.も　むずかしい　です/にほんご.も　むずかしい　です.よ/日本語.も　むずかしい　です・日本語.も　むずかしい　です.よ/にほんご.も　難しい　です/にほんご.も　難しい　です.よ	Japanese is hard too.	\N	\N	E_SENTENCE	6	Yuji	JAPANESE	Write your reply in Japanese
33	GMR_MO_DESU	HINAKO_CHATTING	TRAIN_STATION	ここ.まで、日本.は　どう　です.か？	ここ.まで、にほん.は　どう　です.か？	What do you think of Japan so far?	空港.と　駅.は　凄い　です/くうこう.と　えき.は　すごい　です/空港.と　えき.は　すごい　です/くうこう.と　駅.は　すごい　です/くうこう.と　えき.は　凄い　です/空港.と　駅.は　すごい　です/空港.と　えき.は　凄い　です/くうこう.と　駅.は　凄い　です	The airport and the train station are amazing!	\N	\N	E_SENTENCE	7	Hinako	JAPANESE	Write your reply in Japanese.
34	GMR_MO_DESU	HINAKO_CHATTING	HOSTEL_LOBBY	ごめんね。ペンを頼んだことを知っているけど、鉛筆だけ見つけられた。	ごめんね。ぺんをたのんだことをしっているけど、えんぴつだけみつけられた。	Sorry. I know you asked for a pen, but I could only find a pencil.	大丈夫　です。鉛筆.も　いい　です/だいじょうぶ　です。えんぴつ.も　いい　です/大丈夫　です。鉛筆.も　いい　です.よ/だいじょうぶ　です。えんぴつ.も　いい　です.よ/大丈夫　です。えんぴつ.も　いい　です/だいじょうぶ　です。鉛筆.も　いい　です/大丈夫　です。えんぴつ.も　いい　です.よ/大丈夫　です。えんぴつ.も　いい　です.よ	It's ok. A pencil is good too.	\N	\N	E_SENTENCE	8	Hinako	JAPANESE	Write your reply in Japanese
\.


--
-- Data for Name: user_characters; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.user_characters (user_id, character_id, proficiency, result_ids, mnemonic) FROM stdin;
267c8d8e-5ba7-5765-beff-fd7bd66052d6	46	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	44	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	50	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	42	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	30	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	47	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	48	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	36	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	61	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	62	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	49	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	4	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	59	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	18	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	56	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	15	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	28	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	9	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	13	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	57	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	20	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	14	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	24	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	25	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	71	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	21	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	105	0.25	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	23	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	63	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	17	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	27	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	11	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	31	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	58	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	60	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	40	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	34	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	15	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	35	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	69	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	29	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	26	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	38	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	39	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	27	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	9	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	19	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	7	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	70	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	10	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	22	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	20	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	41	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	38	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	11	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	43	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	39	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	37	1	\N	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	45	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	14	1	\N	\N
e758a541-973b-5922-8090-339365f29818	1	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	10	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	24	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	28	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	25	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	7	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	21	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	105	0.25	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	22	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	19	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	17	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	18	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	0.933333337	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	30	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	23	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	40	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	26	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	31	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	34	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	13	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	35	1	\N	\N
e758a541-973b-5922-8090-339365f29818	5	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	29	1	\N	\N
e758a541-973b-5922-8090-339365f29818	3	1	\N	\N
e758a541-973b-5922-8090-339365f29818	2	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	36	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	37	1	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	0.950144589	\N	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	0.851720035	\N	\N
e758a541-973b-5922-8090-339365f29818	4	1	\N	\N
\.


--
-- Data for Name: user_courses; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.user_courses (user_id, course_id, status, completed_at) FROM stdin;
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA	AVAILABLE	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	GRAMMAR_1	AVAILABLE	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA	AVAILABLE	\N
2b7b56be-3bdb-5f38-b28b-6ee83bd89cbd	HIRAGANA	AVAILABLE	\N
0a893a59-2311-5c65-a908-c41a9b43aea7	HIRAGANA	AVAILABLE	\N
e758a541-973b-5922-8090-339365f29818	HIRAGANA	AVAILABLE	\N
3d7e40ad-3fe9-5f38-90d4-cd9ac653664f	HIRAGANA	AVAILABLE	\N
\.


--
-- Data for Name: user_set_lessons; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.user_set_lessons (user_id, set_lesson_id, status, completed_at) FROM stdin;
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_DA	COMPLETE	2020-07-04
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_NA	COMPLETE	2020-07-04
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_N	AVAILABLE	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	GMR_WA_DESU	AVAILABLE	\N
0a893a59-2311-5c65-a908-c41a9b43aea7	HIRAGANA_A	AVAILABLE	\N
e758a541-973b-5922-8090-339365f29818	HIRAGANA_A	COMPLETE	2020-07-20
e758a541-973b-5922-8090-339365f29818	HIRAGANA_KA	AVAILABLE	\N
3d7e40ad-3fe9-5f38-90d4-cd9ac653664f	HIRAGANA_A	AVAILABLE	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_A	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_KA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_GA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_SA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_ZA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_TA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_DA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_NA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_N	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_HA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_BA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_MA	COMPLETE	2020-06-25
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_WA	COMPLETE	2020-06-25
2b7b56be-3bdb-5f38-b28b-6ee83bd89cbd	HIRAGANA_A	AVAILABLE	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_A	COMPLETE	2020-06-30
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_KA	COMPLETE	2020-06-30
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_GA	COMPLETE	2020-06-30
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_YA	COMPLETE	2020-07-04
267c8d8e-5ba7-5765-beff-fd7bd66052d6	HIRAGANA_LYA	AVAILABLE	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_SA	COMPLETE	2020-07-04
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_ZA	COMPLETE	2020-07-04
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	HIRAGANA_TA	COMPLETE	2020-07-04
\.


--
-- Data for Name: user_testables; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.user_testables (proficiency, user_id, testable_id) FROM stdin;
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7
1	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8
\.


--
-- Data for Name: user_words; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.user_words (user_id, word_id, proficiency, mnemonic) FROM stdin;
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	10	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	11	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	13	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	9	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	56	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	57	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	58	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	14	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	15	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	18	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	17	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	19	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	20	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	21	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	23	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	22	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5	0.753573179	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	24	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	25	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	26	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	27	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	28	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	29	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	30	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	31	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	32	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	33	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	34	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	35	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	1	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	2	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	3	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	4	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	5	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	6	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	7	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	8	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	9	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	10	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	11	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	12	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	13	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	14	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	15	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	16	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	17	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	18	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	19	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	20	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	21	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	22	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	23	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	26	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	27	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	25	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	28	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	24	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	29	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	30	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	31	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	32	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	34	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	35	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	33	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	36	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	37	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	38	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	39	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	40	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	41	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	42	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	43	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	44	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	45	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	46	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	47	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	48	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	49	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	50	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	51	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	52	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	53	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	54	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	55	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	73	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	76	1	\N
267c8d8e-5ba7-5765-beff-fd7bd66052d6	77	1	\N
e758a541-973b-5922-8090-339365f29818	1	1	\N
e758a541-973b-5922-8090-339365f29818	2	1	\N
e758a541-973b-5922-8090-339365f29818	4	1	\N
e758a541-973b-5922-8090-339365f29818	3	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3	0.9375	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4	0.9375	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	7	1	\N
76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8	1	\N
\.


--
-- Data for Name: word_results; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.word_results (id, created_at, answers, marks, user_id, word_id) FROM stdin;
566	2020-06-25 09:01:16.621684	{"a,o","a,o","a,o"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	1
567	2020-06-25 09:01:16.621684	{"i,e","i,e","i,e"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	2
568	2020-06-25 09:01:16.621684	{"i,i,e","i,i,e","i,i,e"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	3
569	2020-06-25 09:01:16.621684	{"u,e","u,e","u,e"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	4
570	2020-06-25 09:01:58.35025	{"a,ka","a,ka","a,ka"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	5
571	2020-06-25 09:01:58.35025	{"e,ki","e,ki","e,ki"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	6
572	2020-06-25 09:01:58.35025	{"ku,u,ko,u","ku,u,ko,u","ku,u,ko,u"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	7
573	2020-06-25 09:01:58.35025	{"ke,i,ka,ku","ke,i,ka,ku","ke,i,ka,ku"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	8
574	2020-06-25 09:03:05.563748	{"e,i,ga","e,i,ga","e,i,ga"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	9
575	2020-06-25 09:03:05.563748	{"ka,gi","ka,gi","ka,gi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	10
576	2020-06-25 09:03:05.563748	{"e,i,go","e,i,go","e,i,go"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	11
577	2020-06-25 09:03:05.563748	{"ka,ge","ka,ge","ka,ge"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	12
578	2020-06-25 09:03:05.563748	{"ka,gu","ka,gu","ka,gu"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	13
579	2020-06-25 09:04:02.322464	{"o,so,i","o,so,i","o,so,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	14
580	2020-06-25 09:04:02.322464	{"sa,ke","sa,ke","sa,ke"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	15
581	2020-06-25 09:04:02.322464	{"su,shi","su,shi","su,shi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	16
582	2020-06-25 09:04:02.322464	{"ga,ku,se,i","ga,ku,se,i","ga,ku,se,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	17
583	2020-06-25 09:04:02.322464	{"su,go,i","su,go,i","su,go,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	18
584	2020-06-25 09:05:01.870588	{"ka,ze","ka,ze","ka,ze"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	19
585	2020-06-25 09:05:01.870588	{"zo,u","zo,u","zo,u"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	20
586	2020-06-25 09:05:01.870588	{"za,s,shi","za,s,shi","za,s,shi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	21
587	2020-06-25 09:05:01.870588	{"shi,zu,ka","shi,zu,ka","shi,zu,ka"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	22
588	2020-06-25 09:05:01.870588	{"a,ji","a,ji","a,ji"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	23
589	2020-06-25 09:06:25.196603	{"tsu,gi","tsu,gi","tsu,gi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	26
590	2020-06-25 09:06:25.196603	{"to,shi","to,shi","to,shi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	27
591	2020-06-25 09:06:25.196603	{"chi,i,sa,i","chi,i,sa,i","chi,i,sa,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	25
592	2020-06-25 09:06:25.196603	{te,te,te}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	28
593	2020-06-25 09:06:25.196603	{"ta,ka,i","ta,ka,i","ta,ka,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	24
594	2020-06-25 09:07:23.506213	{"da,i,ga,ku","da,i,ga,ku","da,i,ga,ku"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	29
595	2020-06-25 09:07:23.506213	{"de,su","de,su","de,su"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	30
596	2020-06-25 09:07:23.506213	{"do,u,shi,te","do,u,shi,te"}	{CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	31
597	2020-06-25 09:09:50.492717	{"i,nu","i,nu","i,nu"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	32
598	2020-06-25 09:09:50.492717	{"ki,no,u","ki,no,u","ki,no,u"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	34
599	2020-06-25 09:09:50.492717	{"na,ni","na,ni","na,ni"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	35
600	2020-06-25 09:09:50.492717	{"ne,ko","ne,ko","ne,ko"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	33
601	2020-06-25 09:11:24.052739	{"o,n,se,n","o,n,se,n","o,n,se,n"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	36
602	2020-06-25 09:11:24.052739	{"ge,n,ki","ge,n,ki","ge,n,ki"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	37
603	2020-06-25 09:11:24.052739	{"ga,i,ko,ku,ji,n","ga,i,ko,ku,ji,n"}	{CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	38
604	2020-06-25 09:12:17.881725	{"hi,to","hi,to","hi,to"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	39
605	2020-06-25 09:12:17.881725	{"ha,i","ha,i","ha,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	40
606	2020-06-25 09:12:17.881725	{"to,u,fu","to,u,fu","to,u,fu"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	41
607	2020-06-25 09:12:17.881725	{"he,n","he,n","he,n"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	42
608	2020-06-25 09:12:17.881725	{"ni,ho,n","ni,ho,n","ni,ho,n"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	43
609	2020-06-25 09:15:23.261746	{"ba,ka","ba,ka","ba,ka"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	44
610	2020-06-25 09:15:23.261746	{"bo,ku","bo,ku","bo,ku"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	45
611	2020-06-25 09:15:23.261746	{"hi,to,bi,to","hi,to,bi,to","hi,to,bi,to"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	46
612	2020-06-25 09:15:23.261746	{"a,bu,na,i","a,bu,na,i","a,bu,na,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	47
613	2020-06-25 09:15:23.261746	{"o,be,n,to,u","o,be,n,to,u","o,be,n,to,u"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	48
614	2020-06-25 09:16:21.912479	{"u,ma,i","u,ma,i","u,ma,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	49
615	2020-06-25 09:16:21.912479	{"su,mi,ma,se,n","su,mi,ma,se,n","su,mi,ma,se,n"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	50
616	2020-06-25 09:16:21.912479	{"o,su,su,me","o,su,su,me","o,su,su,me"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	51
617	2020-06-25 09:16:21.912479	{"sa,mu,i","sa,mu,i","sa,mu,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	52
618	2020-06-25 09:16:21.912479	{"mo,no","mo,no","mo,no"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	53
619	2020-06-25 09:17:03.322651	{"wa,ta,shi","wa,ta,shi","wa,ta,shi"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	54
620	2020-06-25 09:17:03.322651	{"ka,wa,i,i","ka,wa,i,i","ka,wa,i,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	55
621	2020-06-25 09:17:03.322651	{wo,wo}	{CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	73
622	2020-06-30 07:37:15.041385	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
623	2020-06-30 07:37:15.041385	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
624	2020-06-30 07:37:15.041385	{"i,i,o"}	{INCORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
625	2020-06-30 07:37:15.041385	{"u,o"}	{INCORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
626	2020-06-30 07:41:06.585851	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
627	2020-06-30 07:41:06.585851	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
628	2020-06-30 07:41:06.585851	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
629	2020-06-30 07:41:06.585851	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
630	2020-06-30 07:41:09.177435	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
631	2020-06-30 07:41:09.177435	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
632	2020-06-30 07:41:09.177435	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
633	2020-06-30 07:41:09.177435	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
634	2020-06-30 07:41:11.50631	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
635	2020-06-30 07:41:11.50631	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
636	2020-06-30 07:41:11.50631	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
637	2020-06-30 07:41:11.50631	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
638	2020-06-30 07:41:11.741833	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
639	2020-06-30 07:41:11.741833	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
640	2020-06-30 07:41:11.741833	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
641	2020-06-30 07:41:11.741833	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
642	2020-06-30 07:41:11.964701	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
643	2020-06-30 07:41:11.964701	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
644	2020-06-30 07:41:11.964701	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
645	2020-06-30 07:41:11.964701	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
646	2020-06-30 07:41:12.206004	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
647	2020-06-30 07:41:12.206004	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
648	2020-06-30 07:41:12.206004	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
649	2020-06-30 07:41:12.206004	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
650	2020-06-30 07:41:12.875973	{"a,o"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	1
651	2020-06-30 07:41:12.875973	{"i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	2
652	2020-06-30 07:41:12.875973	{"i,i,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	3
653	2020-06-30 07:41:12.875973	{"u,e"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	4
654	2020-06-30 07:49:08.256036	{"k,a"}	{INCORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5
655	2020-06-30 07:49:08.256036	{"e,ki"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	6
656	2020-06-30 07:49:08.256036	{"ku,u,ko,u"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	7
657	2020-06-30 07:49:08.256036	{"ke,i,ka,ku"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	8
658	2020-06-30 08:01:09.517248	{"ka,gi"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	10
659	2020-06-30 08:01:09.517248	{"e,i,go"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	11
660	2020-06-30 08:01:09.517248	{"ka,ge"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	12
661	2020-06-30 08:01:09.517248	{"ka,gu"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	13
662	2020-06-30 08:01:09.517248	{"e,i,ga"}	{CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	9
663	2020-07-04 04:29:06.302009	{"he,ya","he,ya","he,ya"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	56
664	2020-07-04 04:29:06.302009	{"yu,u,me,i","yu,u,me,i","yu,u,me,i"}	{CORRECT,CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	57
665	2020-07-04 04:29:06.302009	{"tsu,yo,i","tsu,yo,i"}	{CORRECT,CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	58
666	2020-07-04 06:05:53.998278	{"o,so,i","o,so,i","o,so,i"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	14
667	2020-07-04 06:05:53.998278	{"sa,ke","sa,ke","sa,ke"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	15
668	2020-07-04 06:05:53.998278	{"su,shi","su,shi","su,shi"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	16
669	2020-07-04 06:05:53.998278	{"su,go,i","su,go,i"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	18
670	2020-07-04 06:05:53.998278	{"ga,ku,se,i","ga,ku,se,i","ga,ku,se,i"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	17
671	2020-07-04 06:17:01.311174	{"ka,ze","ka,ze","ka,ze"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	19
672	2020-07-04 06:17:01.311174	{"zo,u","zo,u","zo,u"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	20
673	2020-07-04 06:17:01.311174	{"za,s,shi","za,s,shi","za,s,shi"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	21
674	2020-07-04 06:17:01.311174	{"a,ji","a,ji"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	23
675	2020-07-04 06:17:01.311174	{"shi,zu,ka","shi,zu,ka","shi,zu,ka"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	22
676	2020-07-04 06:17:01.311174	{"a,ka","a,ka"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5
677	2020-07-04 06:41:21.230646	{"ta,ka,i","ta,ka,i","ta,ka,i"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	24
678	2020-07-04 06:41:21.230646	{"chi,i,sa,i","chi,i,sa,i","chi,i,sa,i"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	25
679	2020-07-04 06:41:21.230646	{"tsu,gi","tsu,gi","tsu,gi"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	26
680	2020-07-04 06:41:21.230646	{"to,shi","to,shi","to,shi"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	27
681	2020-07-04 06:41:21.230646	{te,te,te}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	28
682	2020-07-04 07:10:27.894555	{"da,i,ga,ku","da,i,ga,ku","da,i,ga,ku"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	29
683	2020-07-04 07:10:27.894555	{"de,su","de,su","de,su"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	30
684	2020-07-04 07:10:27.894555	{"do,u,shi,te","do,u,shi,te"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	31
685	2020-07-04 07:10:27.894555	{"a,ka","a,ka"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5
686	2020-07-04 07:29:05.669917	{"i,nu","i,nu","i,nu"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	32
687	2020-07-04 07:29:05.669917	{"ne,ko","ne,ko","ne,ko"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	33
688	2020-07-04 07:29:05.669917	{"ki,no,u","ki,no,u","ki,no,u"}	{CORRECT,CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	34
689	2020-07-04 07:29:05.669917	{"na,ni","na,ni"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	35
690	2020-07-04 07:29:05.669917	{"a,ka","a,ka"}	{CORRECT,CORRECT}	76aaa9f3-f4d6-5f7e-85f4-ef9915d93bd3	5
703	2020-07-13 00:02:50.359541	{"da,i,jo,u,bu"}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	76
704	2020-07-13 00:02:50.359541	{"ni,ho,n,ji,n"}	{CORRECT}	267c8d8e-5ba7-5765-beff-fd7bd66052d6	77
705	2020-07-20 14:59:24.078711	{"a,o","a,o","a,o"}	{CORRECT,CORRECT,CORRECT}	e758a541-973b-5922-8090-339365f29818	1
706	2020-07-20 14:59:24.078711	{"i,e","i,e","i,e"}	{CORRECT,CORRECT,CORRECT}	e758a541-973b-5922-8090-339365f29818	2
707	2020-07-20 14:59:24.078711	{"u,e","u,e"}	{CORRECT,CORRECT}	e758a541-973b-5922-8090-339365f29818	4
708	2020-07-20 14:59:24.078711	{"i,i,e","i,i,e","i,i,e"}	{CORRECT,CORRECT,CORRECT}	e758a541-973b-5922-8090-339365f29818	3
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: hugokawamata
--

COPY public.words (id, japanese, hiragana, english, introduction, emoji, image, set_lesson_id) FROM stdin;
5	赤	あか	Red	This word means "red". The new hiragana character is "ka".	🔴	\N	HIRAGANA_KA
29	大学	だいがく	University, college	This word is university. I'm sure you've got the hang of tentens by now.	📚	\N	HIRAGANA_DA
36	温泉	おんせん	Onsen, Japanese hot spring	This word doesn't really have an English translation. The closest is "hot spring".	♨	\N	HIRAGANA_N
26	次	つぎ	Next	This word means "next". It's on some of the buttons in this very app!	⏭	\N	HIRAGANA_TA
25	小さい	ちいさい	Small	This means "small". Remember, this new letter is an exception - it's "chi", not ti.	🐜	\N	HIRAGANA_TA
31	どうして	どうして	Why?	This word means "why?". Just like in English, you put it at the start of a sentence to make it a question.	❓	\N	HIRAGANA_DA
2	家	いえ	House	This is "house". The first letter is "i" and the second letter is "e".	🏠	\N	HIRAGANA_A
3	いいえ	いいえ	No	This word means "no". It's very similar to "house" isn't it? The only difference is you say "ii" for longer.	🙅‍♀️	\N	HIRAGANA_A
4	上	うえ	Up	This word means "up". The first letter is "u". You should already know the second letter!	⬆️	\N	HIRAGANA_A
12	影	かげ	Shadow	This means "shadow". You might already know this word if you're a fan of Naruto.	👤	\N	HIRAGANA_GA
6	駅	えき	Train station	This word means "train station". The new letter is "ki".	🚉	\N	HIRAGANA_KA
7	空港	くうこう	Airport	This word means "airport". く is read as "ku" and こ is read as "ko".	🛫	\N	HIRAGANA_KA
8	計画	けいかく	Plan	This word means "plan" or "scheme". け is read as "ke". Just according to keikaku!	📑	\N	HIRAGANA_KA
35	何	なに	What?	This word is "what". If you like anime, you probably hear this a lot. "NANI?!"	❓	\N	HIRAGANA_NA
10	鍵	かぎ	Key	This is "key". Some homework: Try to say it in your head whenever you pick up your own keys!	🔑	\N	HIRAGANA_GA
11	英語	えいご	English (language)	This word means "English", as in the language. You'll probably use it a lot in conversation.	🇬🇧	\N	HIRAGANA_GA
9	映画	えいが	Movie	This word means "movie".	🎬	\N	HIRAGANA_GA
13	家具	かぐ	Furniture	This word means "furniture". Another good one to say in your head whenever you use furniture!	🛋	\N	HIRAGANA_GA
14	遅い	おそい	Slow, late	This word means "slow" or "late". そ is pronounced as "so".	⌛🐌️	\N	HIRAGANA_SA
15	酒	さけ	Sake	This word is so common it's almost English! In Japanese, "sake" can mean rice wine, or just alcohol in general. It's "sah-keh" not "saa-kee"!	🍶	\N	HIRAGANA_SA
16	寿司	すし	Sushi	You know this word already too! Remember to follow Japanese pronunciation: "su-shi" not "soo-shi".	🍣	\N	HIRAGANA_SA
17	学生	がくせい	School student	This is "school student". The new letter is "se".	👩‍🎓	\N	HIRAGANA_SA
37	元気	げんき	Lively, well	This word can mean "good/well" as in "How are you" = "げんき です". It can also mean "lively", like you might describe a festival.	😄	\N	HIRAGANA_N
20	像	ぞう	Elephant	This word means "elephant".	🐘	\N	HIRAGANA_ZA
21	雑誌	ざっし	Magazine	This is "magazine". Remember, the little っ makes a longer consonant sound for the character that follows it.	🗞	\N	HIRAGANA_ZA
22	静か	しずか	Quiet	This means "quiet". You might see this on signs in Japanese accomodation.	🤫	\N	HIRAGANA_ZA
23	味	あじ	Flavour	This means flavour, you see it on Japanese snacks a lot. Remember, し is different. Instead of becoming "zi", it becomes "ji".	😋	\N	HIRAGANA_ZA
27	年	とし	Year	This is "year". You'll see its kanji quite often in dates: 年. The first letter is と.	🗓	\N	HIRAGANA_TA
19	風邪	かぜ	Cold, flu	This word means "cold" or "flu". Watch for the TenTen. S turns into Z.	🤒	\N	HIRAGANA_ZA
28	手	て	Hand	Some letters are words just by themselves. This is "te": "hand".	✋	\N	HIRAGANA_TA
30	です	です	To be	Desu! Usually contracted and said "des" because it's said so often. It means "is" or "am". "たかい です" means "It is tall".	👉	\N	HIRAGANA_DA
34	昨日	きのう	Yesterday	This is "yesterday", and the new letter is "no"	⬅️📆	\N	HIRAGANA_NA
32	犬	いぬ	Dog	This word means "dog". It's actually snuck into English quite unnoticed. You know the Japanese breed, shiba *inu*?	🐕	\N	HIRAGANA_NA
33	猫	ねこ	Cat	This word is "cat". The first letter is "ne"	🐈	\N	HIRAGANA_NA
38	外国人	がいこくじん	Foreign person, non-Japanese person	If you're not Japanese by blood, you might get referred to as this when you visit Japan.	🙋‍♀️🚢	\N	HIRAGANA_N
39	人	ひと	Person	This word means "person", and the new letter is "hi". It's not pronounced "hie"!	👩	\N	HIRAGANA_HA
40	はい	はい	Yes	This word means "yes". The new letter is "は".	✅	\N	HIRAGANA_HA
41	豆腐	とうふ	Tofu	This is a word that's become a part of English: "Tofu". Make sure to read it with the correct pronunciation.	🍢	\N	HIRAGANA_HA
42	変	へん	Strange, weird	This means "strange" or "weird". The new letter is "he".	🤔	\N	HIRAGANA_HA
44	バカ	ばか	Idiot	If you watch any anime you'll know this one. It means "idiot".	🤬	\N	HIRAGANA_BA
45	僕	ぼく	I, me (male)	This is the pronoun for "I", or "me". It's usually only used by males. You'll learn the female one soon!	🙋‍♂️	\N	HIRAGANA_BA
46	人々	ひとびと	People, everybody	This means "people" or "everyone". Notice how similar it is to "ひと" (person).	👥	\N	HIRAGANA_BA
47	危ない	あぶない	Dangerous	This means "dangerous". You'll see it on Japanese signs a lot, near train stations.	⚠️	\N	HIRAGANA_BA
1	青	あお	Blue	This word means "blue". The first letter is "a" and the second letter is "o".	🔵	\N	HIRAGANA_A
18	凄い	すごい	Amazing	This is one of the most common words in Japanese. Sugoi! Amazing!	🤩	\N	HIRAGANA_SA
43	日本	にほん	Japan	You might know this word already: "nihon". It's the Japanese word for "Japan".	🇯🇵	\N	HIRAGANA_HA
48	お弁当	おべんとう	Bento box, Japanese lunch box	This is the word for "bento box". In Japanese, it's "obentō". The "O" at the start shows respect.	🍱	\N	HIRAGANA_BA
49	うまい	うまい	Delicious	The new character is "ma". This means "delicious". It's a *very* common word!	🤤	\N	HIRAGANA_MA
50	すみません	すみません	Excuse me	This means "excuse me". The new character is "mi". It's also one of the most common words!	🙇‍♂️	\N	HIRAGANA_MA
51	おすすめ	おすすめ	Recommendation	The new letter is "me". It means "recommendation", and you'll see it on every menu in Japan.	🌟	\N	HIRAGANA_MA
52	寒い	さむい	Cold (weather)	This means "cold", but only for weather. There's a different word for cold items. The new letter is "mu".	🥶	\N	HIRAGANA_MA
53	もの	もの	Thing	This means "thing". It can be used to refer to almost any physical object. The new letter is "mo".	📦	\N	HIRAGANA_MA
54	私	わたし	I, me (female)	This means "me", but the female version. Men can use it when they're being formal too.	🙋‍♀️	\N	HIRAGANA_WA
55	可愛い	かわいい	Cute	This means "cute". If you're learning Japanese, you'll definitely have seen this word already.	🎀	\N	HIRAGANA_WA
56	部屋	へや	Room	This is "room". The new letter is "ya". Very useful word for booking accomodation.	🏨	\N	HIRAGANA_YA
57	有名	ゆうめい	Famous	This word means "famous". The new letter is "yu".	👨‍🎤	\N	HIRAGANA_YA
58	強い	つよい	Strong	This means "strong". The new letter is "yo	💪	\N	HIRAGANA_YA
59	写真	しゃしん	Photo	This is "photo": "shashin". A very useful word for asking strangers to take tourist photos of you.	📷	\N	HIRAGANA_LYA
60	今日	きょう	Today	This means "today" and is written "kyou".	📅	\N	HIRAGANA_LYA
61	週	しゅう	Week	This means "week" and is written as "shuu".	🗓	\N	HIRAGANA_LYA
62	ちょっと	ちょっと	A little bit	This means "a little bit" and is written as "chotto". (It's an extremely common word)	👌	\N	HIRAGANA_LYA
63	なるほど	なるほど	I see!	This is a short phrase that means "I see!". The new letter is "ru"	😲	\N	HIRAGANA_RA
64	柔らかい	やわらかい	Soft, tender	This means "soft" (for anything) or "tender" (for food). The new letter is "ra".	🧸	\N	HIRAGANA_RA
65	綺麗	きれい	Pretty, clean	This means "pretty" or "clean". The new letter is "re".	✨	\N	HIRAGANA_RA
66	鮪	まぐろ	Tuna	This is the word for "tuna", either the live fish or the raw meat. The new letter is "ro".	🍣	\N	HIRAGANA_RA
67	ありがとう	ありがとう	Thanks	This means "thanks", but you already knew that! Make sure to learn the real pronunciation.	🎁	\N	HIRAGANA_RA
68	パチンコ	ぱちんこ	Pachinko	This is "pachinko", the Japanese gambling game with little metal balls.	🎰	\N	HIRAGANA_PA
69	鉛筆	えんぴつ	Pencil	This is the Japanese word for "pencil".	✏️	\N	HIRAGANA_PA
70	切符	きっぷ	Ticket	This means "ticket". You might need to know this one if you visit theme parks and similar places.	🎟	\N	HIRAGANA_PA
71	ペン	ぺん	Pen	This is the Japanese word for "pen"... it's the same as in English	🖋	\N	HIRAGANA_PA
72	散歩	さんぽ	A walk, stroll	This word means "a walk" or "a stroll".	🚶‍♂️	\N	HIRAGANA_PA
73	を	を	-	This new character is techinically "wo", but it's usually pronounced as "o". It's a special letter that's not really used in real words.	⁉️	\N	HIRAGANA_WA
76	大丈夫	だいじょうぶ	Ok, alright	This word means "ok" or "alright"	👌	\N	GMR_WA_DESU
77	日本人	にほんじん	Japanese person	You already know "日本" (にほん) is Japan. This word means "Japanese person".	🙋🏻‍♀️🇯🇵	\N	GMR_WA_DESU
24	高い	たかい	High, expensive	This word means "tall". The new letter is "ta".	🏔	\N	HIRAGANA_TA
78	これ	これ	This	This word means "this".	💁‍♀️	\N	\N
79	それ	それ	That	This word means "that". It's used for things that are close to the person you're talking to, but not close to you.	👉	\N	\N
80	あれ	あれ	That (over there)	This word means "that (over there)". It's used for things that aren't close to you or the person you're talking to.	👉🏙	\N	\N
81	美味しい	おいしい	Delicious	This word means "delicious" or "tasty". It's similar to one you already know, うまい.	🤤	\N	\N
82	難しい	むずかしい	Difficult, hard	This word means "difficult" or "hard".	‍😩	\N	\N
83	日本語	にほんご	Japanese (language)	This word means "Japanese" as in the language. Notice how both にほんご and えいご (English) end in ご. That complex kanji means "language".	🇯🇵	\N	\N
84	いい	いい	Good	This word means "good", but it can also mean "fine", "ok", etc. It basically conveys positive emotion.	👍	\N	\N
85	鮭	しゃけ	Salmon	This word means "salmon"	‍🍣	\N	\N
\.


--
-- Name: character_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.character_results_id_seq', 902, true);


--
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.characters_id_seq', 105, true);


--
-- Name: lectures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.lectures_id_seq', 106, true);


--
-- Name: testable_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.testable_results_id_seq', 12, true);


--
-- Name: testables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.testables_id_seq', 34, true);


--
-- Name: word_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.word_results_id_seq', 708, true);


--
-- Name: words_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hugokawamata
--

SELECT pg_catalog.setval('public.words_id_seq', 85, true);


--
-- Name: character_results character_results_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.character_results
    ADD CONSTRAINT character_results_pkey PRIMARY KEY (id);


--
-- Name: characters characters_character_key; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_character_key UNIQUE ("character");


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: lectures lectures_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT lectures_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: set_lessons set_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.set_lessons
    ADD CONSTRAINT set_lessons_pkey PRIMARY KEY (id);


--
-- Name: testable_results testable_results_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testable_results
    ADD CONSTRAINT testable_results_pkey PRIMARY KEY (id);


--
-- Name: testables testables_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testables
    ADD CONSTRAINT testables_pkey PRIMARY KEY (id);


--
-- Name: user_characters user_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_characters
    ADD CONSTRAINT user_characters_pkey PRIMARY KEY (user_id, character_id);


--
-- Name: user_courses user_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_courses
    ADD CONSTRAINT user_courses_pkey PRIMARY KEY (user_id, course_id);


--
-- Name: accounts user_email_key; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: accounts user_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_set_lessons user_set_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_set_lessons
    ADD CONSTRAINT user_set_lessons_pkey PRIMARY KEY (user_id, set_lesson_id);


--
-- Name: user_testables user_testables_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_testables
    ADD CONSTRAINT user_testables_pkey PRIMARY KEY (user_id, testable_id);


--
-- Name: user_words user_words_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_pkey PRIMARY KEY (user_id, word_id);


--
-- Name: word_results word_results_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.word_results
    ADD CONSTRAINT word_results_pkey PRIMARY KEY (id);


--
-- Name: words words_pkey; Type: CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: hugokawamata
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: character_results character_results_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.character_results
    ADD CONSTRAINT character_results_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: character_results character_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.character_results
    ADD CONSTRAINT character_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: lectures lectures_set_lesson_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT lectures_set_lesson_fkey FOREIGN KEY (set_lesson_id) REFERENCES public.set_lessons(id);


--
-- Name: set_lessons set_lessons_course_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.set_lessons
    ADD CONSTRAINT set_lessons_course_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: testable_results testable_results_testable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testable_results
    ADD CONSTRAINT testable_results_testable_id_fkey FOREIGN KEY (testable_id) REFERENCES public.testables(id);


--
-- Name: testable_results testable_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testable_results
    ADD CONSTRAINT testable_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: testables testables_set_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testables
    ADD CONSTRAINT testables_set_lesson_id_fkey FOREIGN KEY (set_lesson_id) REFERENCES public.set_lessons(id);


--
-- Name: testables testables_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.testables
    ADD CONSTRAINT testables_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.words(id);


--
-- Name: user_characters user_characters_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_characters
    ADD CONSTRAINT user_characters_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: user_characters user_characters_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_characters
    ADD CONSTRAINT user_characters_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: user_courses user_courses_course; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_courses
    ADD CONSTRAINT user_courses_course FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: user_courses user_courses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_courses
    ADD CONSTRAINT user_courses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: user_set_lessons user_set_lessons_set_lesson; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_set_lessons
    ADD CONSTRAINT user_set_lessons_set_lesson FOREIGN KEY (set_lesson_id) REFERENCES public.set_lessons(id);


--
-- Name: user_set_lessons user_set_lessons_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_set_lessons
    ADD CONSTRAINT user_set_lessons_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: user_testables user_testables_testable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_testables
    ADD CONSTRAINT user_testables_testable_id_fkey FOREIGN KEY (testable_id) REFERENCES public.testables(id);


--
-- Name: user_testables user_testables_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_testables
    ADD CONSTRAINT user_testables_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: user_words user_word_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_word_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.words(id);


--
-- Name: user_words user_words_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.user_words
    ADD CONSTRAINT user_words_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: word_results word_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.word_results
    ADD CONSTRAINT word_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: word_results word_results_word_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.word_results
    ADD CONSTRAINT word_results_word_id_fkey FOREIGN KEY (word_id) REFERENCES public.words(id);


--
-- Name: words words_set_lesson_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hugokawamata
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT words_set_lesson_fkey FOREIGN KEY (set_lesson_id) REFERENCES public.set_lessons(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: hugokawamata
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO hugokawamata;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


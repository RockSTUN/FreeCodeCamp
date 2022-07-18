--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: guesses; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guesses (
    username character varying(25),
    games_played integer,
    best_game integer
);


ALTER TABLE public.guesses OWNER TO freecodecamp;

--
-- Data for Name: guesses; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guesses VALUES ('user_1658152500425', 2, 66);
INSERT INTO public.guesses VALUES ('user_1658152500426', 5, 93);
INSERT INTO public.guesses VALUES ('user_1658152696081', 2, 137);
INSERT INTO public.guesses VALUES ('user_1658152553082', 2, 411);
INSERT INTO public.guesses VALUES ('user_1658152696082', 5, 440);
INSERT INTO public.guesses VALUES ('user_1658152553083', 5, 147);
INSERT INTO public.guesses VALUES ('user_1658152560807', 2, 58);
INSERT INTO public.guesses VALUES ('user_1658152704136', 2, 397);
INSERT INTO public.guesses VALUES ('user_1658152560808', 5, 12);
INSERT INTO public.guesses VALUES ('user_1658152704137', 5, 187);
INSERT INTO public.guesses VALUES ('user_1658152567935', 2, 339);
INSERT INTO public.guesses VALUES ('user_1658152567936', 5, 24);
INSERT INTO public.guesses VALUES ('user_1658152575380', 2, 19);
INSERT INTO public.guesses VALUES ('user_1658152735005', 2, 237);
INSERT INTO public.guesses VALUES ('user_1658152575381', 5, 163);
INSERT INTO public.guesses VALUES ('user_1658152735006', 5, 141);
INSERT INTO public.guesses VALUES ('user_1658152654978', 2, 262);
INSERT INTO public.guesses VALUES ('user_1658152654979', 5, 97);
INSERT INTO public.guesses VALUES ('user_1658152776837', 2, 203);
INSERT INTO public.guesses VALUES ('user_1658152665607', 2, 200);
INSERT INTO public.guesses VALUES ('user_1658152665608', 5, 210);
INSERT INTO public.guesses VALUES ('user_1658152776838', 5, 29);
INSERT INTO public.guesses VALUES ('user_1658152681375', 2, 422);
INSERT INTO public.guesses VALUES ('user_1658152681376', 5, 167);


--
-- PostgreSQL database dump complete
--


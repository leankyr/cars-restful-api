#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  BEGIN;
   CREATE TABLE IF NOT EXISTS public.cars
   (
       car_id serial PRIMARY KEY NOT NULL,
       plate character varying(50) COLLATE pg_catalog."default" NOT NULL,
       color character varying(20) COLLATE pg_catalog."default" NOT NULL,
       created_on timestamp without time zone NOT NULL,
       CONSTRAINT cars_plate_key UNIQUE (plate)
   );

   CREATE TABLE IF NOT EXISTS public.drivers
   (
       driver_id serial PRIMARY KEY NOT NULL,
       first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
       last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
       created_on timestamp without time zone NOT NULL,
       car_id integer,
       CONSTRAINT drivers_car_id_fkey FOREIGN KEY (car_id)
       REFERENCES public.cars (car_id) MATCH SIMPLE
                            ON UPDATE NO ACTION
                            ON DELETE NO ACTION
       );
  COMMIT;
EOSQL
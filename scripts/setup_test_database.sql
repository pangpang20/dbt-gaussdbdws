CREATE DATABASE dbt;

CREATE ROLE root WITH PASSWORD 'Password$123';
ALTER ROLE root WITH LOGIN;
GRANT CREATE, CONNECT ON DATABASE dbt TO root;

CREATE ROLE noaccess WITH PASSWORD 'Password$123' NOSYSADMIN;
ALTER ROLE noaccess WITH LOGIN; 
GRANT CONNECT ON DATABASE dbt TO noaccess;

CREATE ROLE dbt_test_user_1 WITH PASSWORD 'Password$123';
CREATE ROLE dbt_test_user_2 WITH PASSWORD 'Password$123';
CREATE ROLE dbt_test_user_3 WITH PASSWORD 'Password$123';

CREATE DATABASE "dbtMixedCase";
GRANT CREATE, CONNECT ON DATABASE "dbtMixedCase" TO root;
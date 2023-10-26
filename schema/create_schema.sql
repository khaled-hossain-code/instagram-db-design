-- create schema test;
-- show search_path;
-- set search_path TO test, public;
-- set search_path TO "$user", public;
create TABLE test.users(
	id serial PRIMARY KEY,
	username VARCHAR
)
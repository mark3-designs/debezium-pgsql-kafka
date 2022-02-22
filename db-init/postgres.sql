
CREATE DATABASE dbz;

\c dbz

CREATE ROLE cdc_kafka;
GRANT ALL PRIVILEGES ON DATABASE dbz to cdc_kafka;

CREATE ROLE debezium REPLICATION LOGIN PASSWORD 'test';
GRANT cdc_kafka TO debezium;

CREATE TABLE users (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
        last_login TIMESTAMP 
);

CREATE TABLE server (
	server_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	custom_name VARCHAR ( 50 ) NULL,
	create_time TIMESTAMP NOT NULL,
	update_time TIMESTAMP NOT NULL,
	deleted BOOLEAN NOT NULL DEFAULT FALSE
);

ALTER TABLE users OWNER to cdc_kafka;
ALTER TABLE server OWNER to cdc_kafka;

insert into server (name, custom_name, create_time, update_time) values
  ('oxygen',    null, current_timestamp, current_timestamp)
, ('aluminium', null, current_timestamp, current_timestamp)
, ('carbon',    null, current_timestamp, current_timestamp)
;

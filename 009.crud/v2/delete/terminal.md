-- CONNECTION INFO
\conninfo              -- show current connection info
\password              -- change user password
\q                     -- quit psql


-- TABLES
\dt                    -- list tables
\d table_name          -- describe table structure
\d+ table_name         -- detailed table info

SELECT * FROM "Task"


CREATE TABLE example (
    id SERIAL PRIMARY KEY,
    name TEXT
);
DROP TABLE example;

-- DATA
INSERT INTO example (name) VALUES ('Alice');
SELECT * FROM example;
UPDATE example SET name = 'Bob' WHERE id = 1;
DELETE FROM example WHERE id = 1;

-- SCHEMAS
\dn                    -- list schemas
SET search_path TO public;


-- HELP
\?                     -- help for psql commands
\h                     -- help for SQL syntax

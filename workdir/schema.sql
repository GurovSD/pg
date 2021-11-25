-- Сервис подбора специалистов для частных работ, вроде profi.ru
-- 
-- Use case: специалисты и пользователи регистрируются в сервисе и находят друг-друга

CREATE USER gopher
WITH PASSWORD 'pass';

CREATE DATABASE super_jobers
    WITH OWNER gopher
    TEMPLATE = 'template0'
    ENCODING = 'utf-8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
;

\c super_jobers

DROP TABLE IF EXISTS job_types CASCADE;
CREATE TABLE job_types(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    parent_id INT NOT NULL,
    job_type VARCHAR(200),

    FOREIGN KEY (parent_id) REFERENCES job_types (id) ON DELETE RESTRICT
        DEFERRABLE INITIALLY DEFERRED
);

DROP TABLE IF EXISTS jobers CASCADE;
CREATE TABLE jobers (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    job_type_id INT,
    first_name VARCHAR(200) NOT NULL,
    surname VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    exp_years INT,

    FOREIGN KEY (job_type_id) REFERENCES job_types (id) ON DELETE RESTRICT 
);

DROP TABLE IF EXISTS clients CASCADE;
CREATE TABLE clients(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(200) NOT NULL,
    surname VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE job_assigned(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    date_assigned DATE,
    client_id INT NOT NULL,
    jober_id INT NOT NULL,

    FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE RESTRICT,
    FOREIGN KEY (jober_id) REFERENCES jobers (id) ON DELETE RESTRICT
);
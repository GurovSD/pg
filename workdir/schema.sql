-- Сервис подбора специалистов для частных работ, вроде profi.ru
-- 
-- Use case: специалисты и пользователи регистрируются в сервисе и находят друг-друга

CREATE DATABASE super_jober
    TEMPLATE = 'template0'
    ENCODING = 'utf-8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
;
		
CREATE TABLE jobers (
    id INT GENERATED ALWAYS AS IDENTITY,
    job_type_id INT,
    name VARCHAR(200),
    exp_years INTs
);

CREATE TABLE job_types(
    id INT GENERATED ALWAYS AS IDENTITY,
    job_type VARCHAR(200)
);

CREATE TABLE users(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200),
    email VARCHAR(200)
);

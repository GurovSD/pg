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

    CONSTRAINT jober_id_pkey PRIMARY KEY (id),
    CONSTRAINT jober_fk_parent_id FOREIGN KEY (job_type_id) REFERENCES job_types (id) ON DELETE RESTRICT
    
);

CREATE TABLE job_types(
    id INT GENERATED ALWAYS AS IDENTITY,
    parent_id NOT NULL,
    job_type VARCHAR(200)

    CONSTRAINT job_type_id_pkey PRIMARY KEY (id),
    CONSTRAINT job_type_fk_parent_id FOREIGN KEY (parent_id) REFERENCES job_types (id) ON DELETE RESTRICT
);

CREATE TABLE clients(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200),
    email VARCHAR(200)
);

CREATE TABLE job_assigned(
    id INT GENERATED ALWAYS AS IDENTITY,
    date_assigned DATE,
    client_id INT NOT NULL,
    jober_id INT NOT NULL,

    CONSTRAINT job_assigned_id_pkey PRIMARY KEY (id),
    CONSTRAINT client_fk_parent_id FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE RESTRICT,
    CONSTRAINT jober_fk_parent_id FOREIGN KEY (jober_id) REFERENCES jobers (id) ON DELETE RESTRICT
)
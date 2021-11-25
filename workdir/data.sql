-- ######
-- ### Наполнение таблицы job_types ###
-- ######
-- 1. вариант с DEFERRABLE (оказался не нужен, т.к. постгрес дал добавить рутовый вид работы со ссылкой самого на себя)

-- BEGIN DEFERRABLE;
--     INSERT INTO job_types(id, parent_id, job_type)
--     OVERRIDING SYSTEM VALUES
--     VALUES
--         (
--             0,
--             0,
--             'root'
--         );
        
--     UPDATE job_types
--     SET parent_id = (
--         SELECT id,
--         FROM job_types
--         WHERE
--             job_type = 'root'
--     )
--     WHERE
--         job_type = 'root';

-- COMMIT;

-- 2. Вариант без DEFERRABLE
-- Создание корневого вида работы
INSERT INTO job_types(id, parent_id, job_type)
OVERRIDING SYSTEM VALUE
VALUES
    (0, 0, 'root');

-- Создание дерева работ
WITH
    job_type_root AS (
       SELECT id FROM job_types WHERE job_type = 'root'
    ),
    job_type_remont AS (
        INSERT INTO job_types (parent_id, job_type)
        VALUES
            (
                (SELECT id FROM job_type_root),
                'ремонт'
            )
            RETURNING id
    )
    INSERT INTO job_types (parent_id, job_type)
        VALUES
            (
                (SELECT id FROM job_type_remont),
                'обои'
            ),
            (
                (SELECT id FROM job_type_remont),
                'плитка'
            ),
            (
                (SELECT id FROM job_type_remont),
                'сантехника'
            );

-- ######
-- ### Наполнение таблицы jobers ###
-- ######
WITH
    job_type_oboi AS (
       SELECT id FROM job_types WHERE job_type = 'обои'
    )

    INSERT INTO jobers (job_type_id, first_name, surname, email, exp_years)
        VALUES
            (
                (SELECT id FROM job_type_oboi),
                'Сергей',
                'Иванов',
                'ivanov.s@gmail.com',
                10
            ),
            (
                (SELECT id FROM job_type_oboi),
                'Елена',
                'Сергеева',
                'sergeeva.e@gmail.com',
                6
            );

WITH
    job_type_oboi AS (
       SELECT id FROM job_types WHERE job_type = 'сантехника'
    )

    INSERT INTO jobers (job_type_id, first_name, surname, email, exp_years)
        VALUES
            (
                (SELECT id FROM job_type_oboi),
                'Иван',
                'Петров',
                'petrov.i@gmail.com',
                4
            ),
            (
                (SELECT id FROM job_type_oboi),
                'Василий',
                'Сидоров',
                'sidorov.v@gmail.com',
                7
            );

-- ######
-- ### Наполнение таблицы clients ###
-- ######
INSERT INTO clients (first_name, surname, email)
    VALUES
        (
            'Федор',
            'Сбруев',
            'sbruev.f@gmail.com'
        ),
        (
            'Мария',
            'Конева',
            'koneva.m@gmail.com'
        );

-- ######
-- ### Наполнение таблицы job_assigned ###
-- ######
INSERT INTO job_assigned (date_assigned, client_id, jober_id)
    VALUES
        (   '2021-11-24',
            (SELECT id FROM clients WHERE email = 'sbruev.f@gmail.com'),
            (SELECT id FROM jobers WHERE email = 'ivanov.s@gmail.com')
        ),
        (   '2021-11-25',
            (SELECT id FROM clients WHERE email = 'koneva.m@gmail.com'),
            (SELECT id FROM jobers WHERE email = 'sidorov.v@gmail.com')
        );

-- ### Наполнение таблицы job_types ###
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
                'remont'
            )
            RETURNING id
    )
    INSERT INTO job_types (parent_id, job_type)
        VALUES
            (
                (SELECT id FROM job_type_remont),
                'oboyi'
            ),
            (
                (SELECT id FROM job_type_remont),
                'plitka'
            ),
            (
                (SELECT id FROM job_type_remont),
                'santehnika'
            );
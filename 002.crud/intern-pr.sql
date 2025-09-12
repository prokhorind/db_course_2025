-- 1. Створення таблиці (один раз)
CREATE TABLE IF NOT EXISTS intern (
    id SERIAL PRIMARY KEY,
    name TEXT,
    grade INT
);

-- 2. Додавання даних
INSERT INTO intern (name, grade) VALUES ('Alice', 90);
INSERT INTO intern (name, grade) VALUES ('Bob', 75);

-- 3. Пошук (ось тут магія SQL!)
SELECT * FROM intern WHERE name = 'Bob';

-- 4. Оновлення
UPDATE intern SET grade = 95 WHERE name = 'Bob';

-- 5. Видалення
DELETE FROM intern WHERE name = 'Alice';

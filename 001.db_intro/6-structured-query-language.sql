-- 1. Створення таблиці (один раз)
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    name TEXT,
    grade INT
);

-- 2. Додавання даних
INSERT INTO students (name, grade) VALUES ('Alice', 90);
INSERT INTO students (name, grade) VALUES ('Bob', 75);

-- 3. Пошук (ось тут магія SQL!)
SELECT * FROM students WHERE name = 'Bob';

-- 4. Оновлення
UPDATE students SET grade = 95 WHERE name = 'Bob';

-- 5. Видалення
DELETE FROM students WHERE name = 'Alice';

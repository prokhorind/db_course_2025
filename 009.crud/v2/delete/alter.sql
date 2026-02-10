-- Додаємо колонку для "мʼякого видалення"
ALTER TABLE films
ADD COLUMN removed BOOLEAN DEFAULT false;

-- Перевіряємо структуру таблиці
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'films';

-- "Видаляємо" фільм Matrix
UPDATE films
SET removed = true
WHERE title = 'Matrix';

-- Позначаємо як видалені всі недоступні фільми
UPDATE films
SET removed = true
WHERE is_available = false;

-- Позначаємо як видалені фільми з рейтингом нижче 6
UPDATE films
SET removed = true
WHERE rating < 6.0;

-- Показати всі активні фільми (як у реальному застосунку)
SELECT *
FROM films
WHERE removed = false;

-- Показати "видалені" фільми (адмін-панель)
SELECT *
FROM films
WHERE removed = true;

-- Відновити фільм
UPDATE films
SET removed = false
WHERE title = 'Matrix';

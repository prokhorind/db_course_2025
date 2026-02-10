-- =====================================================
-- Файл: 03_select_examples.sql
-- Тема: SELECT у PostgreSQL
-- Контекст: таблиця films
-- =====================================================


-- 1. Подивитись всі фільми
SELECT * FROM films;


-- 2. Подивитись тільки назву і жанр
SELECT title, genre
FROM films;


-- 3. Тільки доступні фільми
SELECT *
FROM films
WHERE is_available = true;


-- 4. Тільки активні фільми (soft delete)
SELECT *
FROM films
WHERE removed = false;


-- 5. Фільми, які доступні І не видалені
SELECT *
FROM films
WHERE is_available = true
  AND removed = false;


-- 6. Фільми певного жанру
SELECT title, rating
FROM films
WHERE genre = 'Sci-Fi';


-- 7. Фільми з рейтингом вище 8
SELECT title, rating
FROM films
WHERE rating > 8.0;


-- 8. Фільми з рейтингом від 6 до 8
SELECT title, rating
FROM films
WHERE rating BETWEEN 6 AND 8;


-- 9. Недоступні або видалені фільми
SELECT *
FROM films
WHERE is_available = false
   OR removed = true;


-- 10. Сортування за рейтингом (від найкращих)
SELECT title, rating
FROM films
WHERE removed = false
ORDER BY rating DESC;


-- 11. Сортування за тривалістю (від найкоротших)
SELECT title, duration_minutes
FROM films
ORDER BY duration_minutes ASC;


-- 12. Топ-5 фільмів за рейтингом
SELECT title, rating
FROM films
WHERE removed = false
ORDER BY rating DESC
LIMIT 5;


-- 13. Пошук фільмів, де є слово 'The'
SELECT *
FROM films
WHERE title LIKE '%The%';


-- 14. Скільки всього фільмів у таблиці
SELECT COUNT(*) AS total_films
FROM films;


-- 15. Скільки активних фільмів
SELECT COUNT(*) AS active_films
FROM films
WHERE removed = false;


-- 16. Середній рейтинг фільмів
SELECT AVG(rating) AS average_rating
FROM films
WHERE removed = false;


-- 17. Максимальний і мінімальний рейтинг
SELECT
    MAX(rating) AS max_rating,
    MIN(rating) AS min_rating
FROM films;


-- 18. Групування за жанрами
SELECT genre, COUNT(*) AS films_count
FROM films
WHERE removed = false
GROUP BY genre;


-- 19. Групування + середній рейтинг по жанру
SELECT genre, AVG(rating) AS avg_rating
FROM films
WHERE removed = false
GROUP BY genre;


-- 20. Жанри, де середній рейтинг > 7
SELECT genre, AVG(rating) AS avg_rating
FROM films
WHERE removed = false
GROUP BY genre
HAVING AVG(rating) > 7;

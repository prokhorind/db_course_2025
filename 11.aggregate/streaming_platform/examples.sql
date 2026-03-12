-- =====================================================
-- ПРИКЛАДИ АНАЛІТИКИ ДЛЯ ДЕМОНСТРАЦІЇ
-- =====================================================



-- -----------------------------------------------------
-- 1. Найпопулярніші фільми
-- -----------------------------------------------------

SELECT
    m.title,
    COUNT(*) AS views
FROM watch_history w
JOIN movies m ON m.movie_id = w.movie_id
GROUP BY m.title
ORDER BY views DESC;



-- -----------------------------------------------------
-- 2. Топ користувачів по переглядам
-- -----------------------------------------------------

SELECT
    u.username,
    COUNT(*) AS watched_movies
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.username
ORDER BY watched_movies DESC;



-- -----------------------------------------------------
-- 3. Середній рейтинг кожного фільму
-- -----------------------------------------------------

SELECT
    m.title,
    AVG(w.rating) AS average_rating
FROM watch_history w
JOIN movies m ON m.movie_id = w.movie_id
GROUP BY m.title
ORDER BY average_rating DESC;



-- -----------------------------------------------------
-- 4. Найкращий рейтинг жанру
-- -----------------------------------------------------

SELECT
    m.genre,
    AVG(w.rating) AS avg_rating
FROM watch_history w
JOIN movies m ON m.movie_id = w.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;



-- -----------------------------------------------------
-- 5. Фільми які дивилися більше 3 разів
-- -----------------------------------------------------

SELECT
    m.title,
    COUNT(*) AS views
FROM watch_history w
JOIN movies m ON m.movie_id = w.movie_id
GROUP BY m.title
HAVING COUNT(*) > 3
ORDER BY views DESC;



-- -----------------------------------------------------
-- 6. Користувачі які поставили середній рейтинг > 9
-- -----------------------------------------------------

SELECT
    u.username,
    AVG(w.rating) AS avg_rating
FROM watch_history w
JOIN users u ON u.user_id = w.user_id
GROUP BY u.username
HAVING AVG(w.rating) > 9;
-- =========================================
-- Приклади LEFT JOIN та RIGHT JOIN
-- =========================================

SET search_path TO streaming_platform;

-- 1️⃣ LEFT JOIN
-- Показати ВСІХ користувачів і їх перегляди
-- (навіть якщо користувач нічого не дивився)

SELECT u.username, m.title
FROM users u
LEFT JOIN watch_history w ON u.user_id = w.user_id
LEFT JOIN movies m ON w.movie_id = m.movie_id;


-- 2️⃣ Знайти користувачів без переглядів

SELECT u.username
FROM users u
LEFT JOIN watch_history w ON u.user_id = w.user_id
WHERE w.watch_id IS NULL;


-- 3️⃣ RIGHT JOIN
-- Показати ВСІ фільми та хто їх дивився
-- (навіть якщо фільм ніхто не дивився)

SELECT m.title, u.username
FROM users u
RIGHT JOIN watch_history w ON u.user_id = w.user_id
RIGHT JOIN movies m ON w.movie_id = m.movie_id;


-- 4️⃣ Знайти фільми без переглядів

SELECT m.title
FROM movies m
LEFT JOIN watch_history w ON m.movie_id = w.movie_id
WHERE w.watch_id IS NULL;


-- Повернутися до стандартної схеми
SET search_path TO public;
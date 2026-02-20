SET search_path TO streaming_platform;

-- 1. Показати хто який фільм дивився
SELECT u.username, m.title, w.watch_date
FROM watch_history w
INNER JOIN users u ON w.user_id = u.user_id
INNER JOIN movies m ON w.movie_id = m.movie_id;

-- 2. Показати оцінки користувачів
SELECT u.username, m.title, w.rating
FROM watch_history w
INNER JOIN users u ON w.user_id = u.user_id
INNER JOIN movies m ON w.movie_id = m.movie_id;

-- 3. Показати тільки Sci-Fi фільми, які дивились
SELECT u.username, m.title
FROM watch_history w
INNER JOIN users u ON w.user_id = u.user_id
INNER JOIN movies m ON w.movie_id = m.movie_id
WHERE m.genre = 'Sci-Fi';

-- 4. Скільки фільмів подивився кожен користувач
SELECT u.username, COUNT(w.watch_id) AS total_movies
FROM users u
INNER JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.username;
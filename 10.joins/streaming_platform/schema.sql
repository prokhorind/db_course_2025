-- ============================================
-- 1. Створення окремої схеми
-- ============================================

CREATE SCHEMA streaming_platform;

-- щоб всі наступні об'єкти створювались у цій схемі
SET search_path TO streaming_platform;

-- ============================================
-- 2. Таблиця користувачів
-- ============================================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    subscription_type VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL
);

-- ============================================
-- 3. Таблиця фільмів
-- ============================================

CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL
);

-- ============================================
-- 4. Таблиця історії переглядів
-- ============================================

CREATE TABLE watch_history (
    watch_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    movie_id INT REFERENCES movies(movie_id),
    watch_date DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 10)
);
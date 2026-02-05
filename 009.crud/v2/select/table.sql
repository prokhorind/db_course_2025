-- Створення таблиці films

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    duration_minutes INT,
    rating NUMERIC(3, 1),
    is_available BOOLEAN
);

-- Перший фільм
INSERT INTO films (title, genre, duration_minutes, rating, is_available)
VALUES ('Matrix', 'Sci-Fi', 136, 8.7, true);


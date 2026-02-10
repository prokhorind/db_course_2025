-- Створення таблиці films

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    duration_minutes INT,
    rating NUMERIC(3, 1),
    is_available BOOLEAN
);

-- Дані для таблиці films

INSERT INTO films (title, genre, duration_minutes, rating, is_available)
VALUES
('Matrix', 'Sci-Fi', 136, 8.7, true),
('Inception', 'Sci-Fi', 148, 8.8, true),
('Interstellar', 'Sci-Fi', 169, 8.6, true),
('Titanic', 'Drama', 195, 7.9, false),
('Joker', 'Drama', 122, 8.4, true),
('The Room', 'Drama', 99, 3.7, false),
('Saw', 'Horror', 103, 6.2, false),
('It', 'Horror', 135, 7.3, true),
('Cars', 'Animation', 117, 7.1, true),
('Minions', 'Animation', 91, 6.4, false);


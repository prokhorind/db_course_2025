SET search_path TO streaming_platform;

-- USERS
INSERT INTO users (username, subscription_type, registration_date)
VALUES
('andrii', 'premium', '2024-01-10'),
('maria', 'basic', '2024-03-15'),
('oleh', 'premium', '2024-05-20'),
('sofia', 'basic', '2024-07-01'),
('max', 'premium', '2024-09-11');

-- MOVIES
INSERT INTO movies (title, genre, release_year)
VALUES
('Interstellar', 'Sci-Fi', 2014),
('Inception', 'Sci-Fi', 2010),
('Joker', 'Drama', 2019),
('Titanic', 'Romance', 1997),
('Matrix', 'Sci-Fi', 1999);

-- FOR RIGHT JOIN
INSERT INTO movies (title, genre, release_year)
VALUES
('Avatar', 'Sci-Fi', 2009),
('Gladiator', 'Action', 2000);

-- WATCH HISTORY
INSERT INTO watch_history (user_id, movie_id, watch_date, rating)
VALUES
(1, 1, '2024-10-01', 10),
(1, 2, '2024-10-03', 9),
(2, 3, '2024-10-05', 8),
(3, 1, '2024-10-07', 9),
(3, 5, '2024-10-10', 10),
(4, 4, '2024-10-11', 7);
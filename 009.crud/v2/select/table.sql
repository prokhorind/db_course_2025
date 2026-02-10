-- Створення таблиці films

CREATE TABLE films (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    duration_minutes INT,
    rating NUMERIC(3, 1),
    is_available BOOLEAN
);

-- Додаємо колонку для "мʼякого видалення"
ALTER TABLE films
ADD COLUMN removed BOOLEAN DEFAULT false;


insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (148, 'Sci-Fi', 6, true, '8.8', false, 'Inception');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (169, 'Sci-Fi', 7, true, '8.6', false, 'Interstellar');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (122, 'Drama', 9, true, '8.4', false, 'Joker');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (135, 'Horror', 12, true, '7.3', false, 'It');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (117, 'Animation', 23, true, '7.1', false, 'Cars');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (195, 'Drama', 8, false, '7.9', true, 'Titanic');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (103, 'Horror', 11, false, '6.2', true, 'Saw');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (91, 'Animation', 14, false, '6.4', true, 'Minions');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (99, 'Drama', 20, false, '3.7', true, 'The Room');
insert into "public"."films" ("duration_minutes", "genre", "id", "is_available", "rating", "removed", "title") values (136, 'Sci-Fi', 15, true, '8.7', false, 'Matrix');



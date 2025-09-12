-- Створення таблиці класів
CREATE TABLE Shevchenko_Class (
    class VARCHAR(255) PRIMARY KEY NOT NULL,
    students INT,
    class_teacher VARCHAR(255),
    sport INT
);

-- Додавання записів у таблицю класів
INSERT INTO Shevchenko_Class (class, students, class_teacher, sport)
VALUES
('10-А', 30, 'Mr. Ivanov', 15),
('11-Б', 25, 'Mrs. Petrova', 10),
('9-Г', 28, 'Mr. Kovalenko', 20);


-- Створення таблиці студентів
CREATE TABLE Shevchenko_Student (
    lastname VARCHAR(255) PRIMARY KEY,
    address VARCHAR(255),
    birthdate DATE,
    height FLOAT,
    favorite_subject VARCHAR(255),
    informatics INT,
    history INT,
    class VARCHAR(255)
);

-- Додавання записів у таблицю студентів
INSERT INTO Shevchenko_Student
(lastname, address, birthdate, height, favorite_subject, informatics, history, class)
VALUES
('Petrenko', 'Kyiv, Shevchenka St. 12', '2007-05-14', 170.5, 'Mathematics', 11, 9, '10-А'),
('Ivanova', 'Kyiv, Hrushevskoho St. 5', '2006-03-22', 165.0, 'Informatics', 12, 10, '11-Б'),
('Kovalenko', 'Kyiv, Lysenko St. 7', '2008-11-02', 172.3, 'History', 9, 12, '9-Г'),
('Shevchuk', 'Kyiv, Khreshchatyk St. 20', '2007-07-30', 168.7, 'Biology', 10, 11, '10-А');










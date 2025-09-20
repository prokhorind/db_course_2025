-- Видалення стовпця sport
ALTER TABLE Shevchenko_Class
DROP COLUMN sport;

-- Додавання стовпця sport назад
ALTER TABLE Shevchenko_Class
ADD COLUMN sport INT;

-- Відновлення даних
UPDATE Shevchenko_Class
SET sport = CASE class
    WHEN '10-А' THEN 15
    WHEN '11-Б' THEN 10
    WHEN '9-Г' THEN 20
END;

-- Видалення стовпця favorite_subject
ALTER TABLE Shevchenko_Student
DROP COLUMN favorite_subject;

-- Додавання стовпця favorite_subject назад
ALTER TABLE Shevchenko_Student
ADD COLUMN favorite_subject VARCHAR(255);

-- Відновлення даних
UPDATE Shevchenko_Student
SET favorite_subject = CASE lastname
    WHEN 'Petrenko' THEN 'Mathematics'
    WHEN 'Ivanova' THEN 'Informatics'
    WHEN 'Kovalenko' THEN 'History'
    WHEN 'Shevchuk' THEN 'Biology'
END;


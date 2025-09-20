ALTER TABLE Shevchenko_Student
ADD CONSTRAINT fk_class
FOREIGN KEY (class) REFERENCES Shevchenko_Class(class);

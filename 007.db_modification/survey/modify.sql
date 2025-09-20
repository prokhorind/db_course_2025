ALTER TABLE survey
            ADD CONSTRAINT unique_name_surname UNIQUE (surname, name);
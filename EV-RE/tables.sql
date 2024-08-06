--  Le examen do recuperación
--  Name: Erick Prado


--  Create tables (DLL)

CREATE TABLE routine (
    id SERIAL,
    description VARCHAR(50) NOT NULL,
    disclaimer VARCHAR(100) NOT NULL,
    sex BOOLEAN NOT NULL,               --  FALSE (0) is for male and TRUE (1) is for female
    PRIMARY KEY (id)
);

CREATE TABLE exercise (
    id SERIAL,
    series INT NOT NULL,
    repetitions INT NOT NULL,
    routine_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (routine_id) REFERENCES routine(id)
);

--  Create a view

CREATE VIEW  AS
    SELECT 
    routine_id,
    r.description,
    r.sex,
    e.series,
    e.repetitions
    FROM routine r, exercise e
    WHERE r.id = e.routine_id
    ;

--  Insert random data

INSERT INTO routine (description, disclaimer, sex) VALUES
('Saltos de rana 4', 'Hacer al fallo', FALSE),
('Deadlift Fem', 'Descansar tras cada serie', TRUE)
;

INSERT INTO exercise (series, repetitions, routine_id) VALUES
(4, 10, 1),
(3, 8, 2)
;

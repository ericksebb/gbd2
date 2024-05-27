# TAS7, events

> Indicaciones:
> 
> Estructurar la base de datos para almacenar información de eventos académicos desarrollados en una universidad. Los eventos contienen detalles como la descripción, las fechas en que se desarrollarán, la ciudad y el total de asistentes. Cada evento incluye múltiples conferencias, y cada conferencia tiene un título, un expositor (speaker), hora, día del congreso y la lista de asistentes. Además, se requiere almacenar información de los asistentes (members) a los congresos, incluyendo datos generales como el correo electrónico. Cada participante debe registrarse para las diferentes conferencias a las que asistirá, y este registro debe contener un código, el identificador del asistente, el identificador de la conferencia, la fecha y un estado que indique si asistió o no.

## **Creación de tablas:** 

1. member

```
CREATE TABLE member(
id SERIAL,
fullname VARCHAR (100) NOT NULL,
email VARCHAR (200) NOT NULL,
age INT NOT NULL,
UNIQUE (email),
PRIMARY KEY (id)
);
```

2. event

```
CREATE TABLE event(
id SERIAL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_attendees INT NOT NULL,
city VARCHAR (50) NOT NULL,
PRIMARY KEY (id)
);
```

3. conference

```
CREATE TABLE conference(
id SERIAL,
title VARCHAR (100) NOT NULL,
speaker VARCHAR (100) NOT NULL,
hour TIME NOT NULL,
day DATE NOT NULL,
total_attendees INT NOT NULL,
event_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (event_id) REFERENCES event (id)
);
```

4. register

```
CREATE TABLE register(
id SERIAL,
member_id INT NOT NULL,
conference_id INT NOT NULL,
code VARCHAR (20) NOT NULL,
registered_at DATE NOT NULL,
assisted BOOLEAN NOT NULL,
UNIQUE (code),
PRIMARY KEY (id),
FOREIGN KEY (member_id) REFERENCES member (id),
FOREIGN KEY (conference_id) REFERENCES conference (id)
);
```

## Inserción de valores _(5 por cada tabla)_

1. member

```
INSERT INTO member (fullname, email, age) VALUES
    ('John Doe', 'john@example.com', 30),
    ('Alice Smith', 'alice@example.com', 25),
    ('Bob Johnson', 'bob@example.com', 40),
    ('Emily Brown', 'emily@example.com', 35),
    ('Michael Wilson', 'michael@example.com', 28);
```


2. event

```
INSERT INTO event (start_date, end_date, total_attendees, city) VALUES 
	('2024-07-10', '2024-07-15', 500, 'New York'), 
	('2024-08-05', '2024-08-10', 300, 'Los Angeles'), 
	('2024-09-20', '2024-09-25', 700, 'Chicago'), 
	('2024-10-15', '2024-10-20', 400, 'Houston'),
	('2024-11-05', '2024-11-10', 600, 'Miami');
```

3. conference

```
INSERT INTO conference (title, speaker, hour, day, total_attendees, event_id) VALUES
    ('Keynote Address', 'John Smith', '09:00:00', '2024-07-10', 200, 1),
    ('Panel Discussion', 'Alice Johnson', '11:00:00', '2024-07-10', 150, 1),
    ('Workshop: Introduction to AI', 'Bob Brown', '14:00:00', '2024-07-11', 100, 1),
    ('Seminar: Marketing Trends', 'Emily Wilson', '10:00:00', '2024-07-12', 180, 1),
    ('Closing Ceremony', 'Michael Davis', '16:00:00', '2024-07-12', 250, 1);

```

4. register

```
INSERT INTO register (member_id, conference_id, code, registered_at, assisted) VALUES
    (1, 1, 'ABC123', '2024-07-09', true),
    (2, 2, 'DEF456', '2024-07-09', true),
    (3, 3, 'GHI789', '2024-07-10', true),
    (4, 4, 'JKL012', '2024-07-11', false),
    (5, 5, 'MNO345', '2024-07-11', true);
```

## CONSULTAS


1. Filtrar a los miembros mayores a 20 años de edad:
   
```
SELECT * FROM member
WHERE age > 20
ORDER BY age DESC;
```

2. Filtrar las conferencias que se realizaron dentro de un periodo de tiempo de manera descendente:

```
SELECT * FROM conference
WHERE day BETWEEN '2024-06-01' AND '2024-07-01'
ORDER BY day DESC
```

3. Filtrar los eventos en los cuales han asistido menos de 200 personas:
   
```
SELECT * FROM event
WHERE total_attendees<200
ORDER BY total_attendees DESC
```

4. Filtrar si un miembro asisió o no a la conferencia, filtrando el id del registro, id del miembro y si asistió o no:

```
SELECT id, member_id, assisted FROM register
WHERE assisted=true
ORDER BY id ASC
```

5. Filtrar las ciudades de manera ascendente en las que asistieron más de 500 personas:

```
SELECT city FROM register
WHERE total_attendees > 500
ORDER BY total_attendees DESC
```


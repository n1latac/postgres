CREATE TABLE students(
    id serial PRIMARY KEY,
    first_name varchar(128) NOT NULL CHECK(first_name != ''),
    last_name varchar(128) NOT NULL CHECK(last_name != ''),
    group_number int REFERENCES groups(id) ON DELETE CASCADE
);
CREATE TABLE groups(
    id serial PRIMARY KEY,
    facultet_is int REFERENCES facultets(id) ON DELETE CASCADE,
    number smallint NOT NULL CHECK(number > 0)
);
CREATE TABLE facultets(
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL CHECK(name != '')
);
CREATE TABLE disciplines(
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL CHECK(name != ''),
    teacher varchar(128) NOT NULL CHECK(teacher != '')
);
CREATE TABLE exams(
    student_is int REFERENCES students(id) ON DELETE CASCADE,
    discipline_is int REFERENCES disciplines(id) ON DELETE CASCADE,
    grade smallint DEFAULT NULL CHECK(grade >= 0),
    PRIMARY KEY(student_is,discipline_is)
);
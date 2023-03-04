DROP TABLE test;

CREATE TABLE test(
    first_name varchar(64) NOT NULL CONSTRAINT first_name_not_found CHECK (first_name != ''),
    last_name varchar(64) NOT NULL  CHECK (last_name != ''),
    email text NOT NULL CHECK (email != '') UNIQUE,
    gender varchar(30) NOT NULL CHECK (gender != ''),
    is_subscribed boolean NOT NULL,
    birthday date,
    foot_size smallint CHECK (foot_size > 0),
    height numeric(3,2) NOT NULL CHECK (height < 3)
);
INSERT INTO test VALUES('John', 'Doe', 'johndoe@mail.com', 'male', true, '1990-11-26', 42, 1.82);
INSERT INTO test VALUES('John', 'Doe', 'john@mail.com', 'male', true, '1990-11-26', -42, 2.82);

CREATE TABLE messages(
    id serial PRIMARY KEY,
    body text NOT NULL CHECK (body != ''),
    author varchar(256) NOT NULL CHECK (author != ''),
    created_at timestamp DEFAULT current_timestamp,
    is_read boolean DEFAULT false
);
INSERT INTO messages VALUES('hello text', 'Joe');
DROP TABLE messages;
INSERT INTO messages (author, body, is_read) VALUES
('Me', 'Text', false),
('Tim', 'Another text', true);


CREATE TABLE books(
    id serial PRIMARY KEY,
    author varchar(126),
    book_name varchar(256),
    writted_at date,
    publishing_house varchar(256),
    category varchar(126) NOT NULL CHECK (category != ''),
    describe text,
    quantity integer,
    status boolean DEFAULT false
);
INSERT INTO books (author, book_name, writted_at, publishing_house, category, quantity) VALUES
('tom', 'garry potter', '1972-06-22', 'kek', 'drama', -1);
ALTER TABLE books DROP CONSTRAINT books_quantity_check;

ALTER TABLE books ADD CONSTRAINT books_quantity_check CHECK (quantity >= 0);

ALTER TABLE books
ADD CONSTRAINT "author_name_unique" CHECK (author != '' AND book_name != '') UNIQUE(author, book_name);
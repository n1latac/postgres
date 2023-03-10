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

ALTER TABLE users ADD COLUMN id serial PRIMARY KEY;



ALTER TABLE users ADD COLUMN chat_id int REFERENCES chats(id);
CREATE TABLE chats(
    id serial PRIMARY KEY,
    owner int,
    description varchar(512),
    name varchar(100) NOT NULL UNIQUE
);
CREATE TABLE users_to_chats(
    users_id int REFERENCES users(id),
    chats_id int REFERENCES chats(id),
    quantity int,
    PRIMARY KEY(users_id, chats_id)
);
ALTER TABLE messages ADD COLUMN user_messages int REFERENCES users(id);
ALTER TABLE messages ADD COLUMN chat_messages int REFERENCES chats(id);
ALTER TABLE chats ADD COLUMN user_owner int REFERENCES users(id); 




CREATE TABLE content(
    id serial PRIMARY KEY,
    content_name varchar(40) NOT NULL CHECK (content_name != ''),
    describe varchar(256),
    author int REFERENCES users_test(id),
    created_at timestamp DEFAULT current_timestamp,
);

CREATE TABLE reaction(
    is_liked boolean DEFAULT NULL,
    user_is int REFERENCES users(id),
    content_is int REFERENCES content(id)
);













CREATE TABLE users1(
    id serial PRIMARY KEY,
    first_name varchar(128) NOT NULL CHECK (first_name != ''),
    last_name varchar(128) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL CHECK (email != ''),
    gender varchar(128) NOT NULL CHECK (gender != ''),
    is_subscribed boolean DEFAULT false,
    birthday date CHECK (birthday < current_date),
    foot_size smallint,
    height numeric(3,2)
)
ALTER TABLE users1 ADD CONSTRAINT users1_birthday_check CHECK(birthday < current_date);
CREATE TABLE orders1(
    id serial PRIMARY KEY,
    created_at timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES users1(id)
)
CREATE TABLE products1(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name != ''),
    brand varchar(128) NOT NULL CHECK(brand != ''),
    model varchar(128) NOT NULL CHECK(model != ''),
    description varchar(512),
    category varchar(128) NOT NULL CHECK(category != ''),
    price numeric(8,2) NOT NULL CHECK(price > 0),
    discount_price numeric(8,2),
    quantity int NOT NULL CHECK (quantity >= 0)
)
CREATE TABLE orders1_to_products1(
    orders1_id int REFERENCES orders1(id),
    products1_id int REFERENCES products1(id),
    quantity int NOT NULL CHECK(quantity > 0),
    PRIMARY KEY(orders1_id, products1_id)
)
CREATE TABLE chats1(
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL CHECK(name != ''),
    owner_id int REFERENCES users1(id) ON DELETE CASCADE,
    created_at timestamp DEFAULT current_timestamp
);
CREATE TABLE chats1_to_users1(
    chat_id int REFERENCES chats1(id) ON DELETE CASCADE,
    user_id int REFERENCES users1(id) ON DELETE CASCADE,
    join_at timestamp DEFAULT current_timestamp,
    PRIMARY KEY(chat_id, user_id)
)
CREATE TABLE messages1(
    body varchar(1500) NOT NULL CHECK(body != ''),
    is_read boolean DEFAULT false,
    author_id int,
    chat_id int,
    FOREIGN KEY(author_id, chat_id) REFERENCES chats1_to_users1(user_id, chat_id) ON DELETE CASCADE
)
CREATE TABLE content1(
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL CHECK(name != ''),
    description varchar(512),
    author_id int REFERENCES users1(id) ON DELETE CASCADE,
    created_at timestamp DEFAULT current_timestamp
)
CREATE TABLE reaction1(
    is_liked boolean DEFAULT NULL,
    user_is int REFERENCES users1(id),
    content_is int REFERENCES content1(id)
);

SELECT * FROM users1;
SELECT first_name, is_subscribed FROM users1 WHERE is_subscribed = true;

SELECT * FROM users1 WHERE id % 2 = 0;

SELECT * FROM users1 WHERE height > 1.5;

SELECT * FROM users1 WHERE gender = 'female' AND is_subscribed = true;

SELECT * FROM users1 WHERE id BETWEEN 1220 AND 1270;

SELECT * FROM users1 WHERE id >= 1220 AND id <= 1270;

SELECT * FROM users1 WHERE first_name LIKE '___';

SELECT * FROM users1 WHERE first_name LIKE 'K%';

ALTER TABLE users1 ADD COLUMN weight int CHECK (weight != 0);

UPDATE users1 SET weight = 60;

UPDATE users1 SET weight = 70 WHERE id BETWEEN 1220 AND 1290;

SELECT * FROM users1 WHERE id BETWEEN 1220 AND 1270;

UPDATE employees SET salary = salary * 1.2 WHERE work_hours >= 150;

SELECT * FROM users1 WHERE gender = 'male' AND age(birthday) > make_interval(18,0,0);

SELECT * FROM users1 WHERE gender = 'male' AND extract("years" from age(birthday)) >= 18;

SELECT * FROM users1 WHERE gender = 'female' AND first_name LIKE 'A%';

SELECT * FROM users1 WHERE extract("years" from age(birthday)) BETWEEN 20 AND 40;

SELECT * FROM users1 WHERE extract("month" from birthday) = 9;



//всем пользователям которые родились 1 ноября изменить подписку на true
UPDATE users1 SET is_subscribed = true WHERE extract("month" from birthday) = 11 AND extract("days" from birthday) = 1;
//удалить всех пользователей которые старше 65 лет
DELETE FROM users1 WHERE extract("years" from age(birthday) ) = 65;
//всем пользователям мужского рода возраста от 40 до 50 лет  установить вес = 80кг
UPDATE users1 SET weight = 80 WHERE gender = 'male' AND extract("years" from age(birthday)) BETWEEN 40 AND 50;

//найдите всех пользователей, полное имя которых > 5 символов
SELECT id, first_name || ' ' || last_name AS "full name" FROM users1 WHERE char_length(first_name || last_name) > 7;



CREATE TABLE workers1(
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL CHECK(name != ''),
    salary int NOT NULL CHECK(salary > 0),
    birthday date CHECK(birthday < current_date)
);

/1/Добавить работника с именем Олег, 90 г.р, зп 300
INSERT INTO workers1 (name, salary, birthday)
VALUES('Олег', 300, '03-09-1990');

/2/Добавить работника Ярославу, зп 1200
INSERT INTO workers1 (name, salary, birthday)
VALUES('Ярослава', 1200, '12-11-1087');

/3/Добавить двоих новых работников одним запросом - Сашу 85г.р, зп 1000 и Машу 95г.р, зп 900
INSERT INTO workers1 (name, salary, birthday)
VALUES ('Саша', 1000, '16-03-1985'),('Маша', 900, '11-01-1995');

/4/Установить Олегу зп = 500
UPDATE workers1 SET salary = 500 WHERE name = 'Олег';

/5/Работнику с id = 4 установить год рождения 87
UPDATE workers1 SET birthday = '01-11-1987' WHERE id = 4;
SELECT DATEPART(year, birthday) FROM workers1;

/6/Всем у кого зп > 500, поднять до 700
UPDATE workers1 
SET salary = 700
WHERE salary > 500;

/7/Работникам со 2 по 5 установить год рождения 99
UPDATE workers1
SET birthday = ...
WHERE id BETWEEN 2 AND 5;

/8/Поменять Сашу на Женю и повысить зп до 900
UPDATE workers1 SET name = 'Женя', salary = 900 WHERE name = 'Саша';

/9/Выбрать всех работников чья зп > 400
SELECT * FROM workers1 WHERE salary >400;

/10/Выбрать работника с id = 4
SELECT * FROM workers1 WHERE id = 4;

/11/Узнать зп и возраст Жени
SELECT salary, extract("years" from age(birthday)) AS years 
FROM workers1
WHERE name = 'Женя';

/12/Найти работника с именем Петя 
SELECT * FROM workers1 WHERE name = 'Петя';

/13/Выбрать работников возрастом 27 лет или зп > 800
SELECT * FROM workers1
WHERE extract("years" from age(birthday)) = 27 OR salary > 800;

/14/Выбрать работников возрастом от 25 до 28 лет включительно 
SELECT *, extract("years" from age(birthday)) AS years FROM workers1
WHERE extract("years" from age(birthday)) BETWEEN 25 AND 28;

/15/Выбрать всех работников которые родились в сентябре
SELECT * FROM 
(SELECT *, extract("month" from age(birthday)) AS "month" FROM workers1) AS "worker"
WHERE "worker"."month" = 9;

SELECT * FROM workers1 WHERE extract("month" from birthday) = 9;

/16/Удалить работника с ID = 4
DELETE workers1 WHERE id = 4;

/17/Удалить Олега
DELETE workers1 WHERE name = 'Олег';

/18/ Удалить всех работрников старше 30 лет
DELETE workers1 WHERE extract("years" from age(birthday)) > 30 


SELECT avg(extract('years' from age(birthday))) FROM users1;

//Минимальный и максимальный возраст пользователей
SELECT min(extract("year" from age(birthday))) AS "min age", max(extract("year" from age(birthday))) AS "max age"
FROM workers1;

//Минимальный и максимальный возраст мужчин и женщин отдельно
SELECT gender,min(extract("year" from age(birthday))) AS "min age", max(extract("year" from age(birthday))) AS "max age"
FROM users1 GROUP BY gender;

//Посчитать количество пользователей женского рода
SELECT count(id) FROM users1 WHERE gender = 'female';

//Количество пользователей, котороые родились после 1998 года
SELECT count(id) FROM users1 WHERE extract("year" from birthday) = 1998;

//Количество пользователей, возрастом от 20 до 40
SELECT count(id) FROM users1 WHERE extract("year" from age(birthday)) BETWEEN 20 AND 40;

SELECT sum(quantity) FROM orders1_to_products1;

//Количество телефонов которые есть на складе
SELECT sum(quantity) FROM products1;

//Средняя цена всех телефонов
SELECT avg(price) FROM products1;

//Средняя цена каждого бренда
SELECT brand, avg(price) AS "AVG price" FROM products1 GROUP BY brand

//Сума цен всех телефонов которые стоят в диапазоне от 1к до 2к
SELECT sum(price * quantity) FROM products1 WHERE price BETWEEN 1000 AND 2000;

//Количество моделей каждого бренда
SELECT brand, count(model) FROM products1 GROUP BY brand;

//Количество заказов каждого пользователя который делал заказы(по ордерсам и сгрупировать по id пользователя)
SELECT count(customer_id) AS "COUNT" FROM orders1 GROUP BY customer_id;

//Средняя цена Нокии
SELECT brand, avg(price) FROM products1 WHERE brand = 'Nokia' GROUP BY brand;

//Количество проданых моделей
SELECT products1_id, sum(products1_id * quantity) FROM orders1_to_products1
GROUP BY products1_id;

//Отсортировать юзеров за возрастом(количеством полных лет)
SELECT * 
FROM users1
ORDER BY birthday;

//Отсортируйте телефоны за ценой от самого дорогого до самого дешевого 
SELECT *
FROM products1
ORDER BY price DESC;

//Вывести топ 5 телефонов которых больше всего купили
SELECT products1_id, sum(products1_id * quantity)
FROM orders1_to_products1
GROUP BY products1_id
ORDER BY sum(products1_id * quantity) DESC
LIMIT 5;

//Вытянуть все бренды у которых количетсво телефонов > 1000
SELECT brand, sum(quantity)
FROM products1
GROUP BY brand
HAVING sum(quantity) > 1500;

//Вытащить все бренды, в которых продано больше 50 телефонов
SELECT products1_id, sum(quantity)
FROM orders1_to_products1
GROUP BY products1_id
HAVING sum(quantity) > 50;


CREATE TABLE A(
    v char(3),
    t int
);
CREATE TABLE B(
    v char(3)
);
INSERT INTO A VALUES
('XXX', 1),
('XXY', 1),
('XXZ', 1),
('XYX', 2),
('XYY', 2),
('XYZ', 2),
('YXX', 3),
('YXY', 3),
('YXZ', 3);

INSERT INTO B VALUES
('ZXX'),
('XXX'),
('ZXZ'),
('YXZ'),
('YXY');


INSERT INTO users1(
    first_name,
    last_name,
    email,
    gender,
    is_subscribed,
    birthday
) VALUES(
    'User1',
    'Test1',
    'mail@1',
    'male',
    true,
    '1990-11-01'
),
(
    'User2',
    'Test2',
    'mail@2',
    'female',
    true,
    '1990-11-01'
),
(
    'User3',
    'Test3',
    'mail@3',
    'male',
    false,
    '1990-11-01'
);

SELECT id FROM users1
EXCEPT
SELECT customer_id FROM orders1;

SELECT p.brand, sum(otp.quantity)
FROM products1 AS p
JOIN orders1_to_products1 AS otp
ON p.id = otp.products1_id
WHERE p.brand = 'Samsung'
GROUP BY p.brand;


SELECT u.id
FROM users1 AS U
EXCEPT 
SELECT o.customer_id
FROM orders1 AS o;

INSERT INTO products1(
    brand,
    model,
    category,
    price,
    quantity
) VALUES(
    'LG',
    '10',
    'phones',
    200,
    2
);

--Телефоны которые никто не заказывал 
SELECT p.* FROM products1 AS p 
LEFT JOIN orders1_to_products1 AS otp
ON p.id = otp.products1_id
WHERE otp.products1_id IS NULL;

--Полная стоимость каждого заказа
SELECT otp.orders1_id AS "ORDER", sum(otp.quantity * p.price) AS "SUM" FROM orders1_to_products1 AS otp
JOIN products1 AS p
ON otp.products1_id = p.id
GROUP BY otp.orders1_id;


--количетсво позиций в каждом заказе
SELECT otp.orders1_id, sum(otp.quantity) AS "Quantity" FROM orders1_to_products1 AS otp
GROUP BY otp.orders1_id
ORDER BY "Quantity";

--Найти самый популярный товар
SELECT p.brand, p.model, sum(otp.quantity) AS "count" 
FROM orders1_to_products1 AS otp
JOIN products1 AS p
ON otp.products1_id = p.id
GROUP BY p.id
ORDER BY "count" DESC
LIMIT 7;


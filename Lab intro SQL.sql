use sakila;
select * from film;
select * from actor;
select * from customer;
select * from rental;
select * from inventory;
select * from store;
select * from payment; 
select * from staff;


-- Get film titles.
select title
from film;

-- Get unique list of film languages under the alias language
select language_id as language
from film;

-- Find out how many stores does the company have?
select * from store;
select count(*) 
from store;
select count(store_id) from sakila.store;

-- Find out how many employees staff does the company have?
select * from staff;
select count(*)
from staff;
select count(staff_id) from sakila.staff;


-- Return a list of employee first names only?
select first_name from sakila.staff;
select first_name
from staff;









-- Lab 2
-- Select all the actors with the first name ‘Scarlett’
select first_name from sakila.actor where first_name = 'Scarlett';
select first_name 
from sakila.actor
where first_name = 'Scarlett';

-- Select all the actors with the last name ‘Johansson’
select last_name from sakila.actor where last_name = 'Johansson';
select last_name
from sakila.actor
where last_name = 'Johansson';

-- How many films (movies) are available for rent?
select count(inventory_id) as avaible_movies
from rental 
where return_date is null;

-- How many films have been rented?
select count(inventory_id) as 'rented_movies' from rental;

-- What is the shortest and longest rental period?
select max(rental_duration) from film;
select min(rental_duration) from film;


-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;


-- What's the average movie duration?
select avg(length)
from film;

-- What's the average movie duration expressed in format (hours, minutes)?

Select sec_to_time(avg(length)*60), left(sec_to_time(avg(length)*60), 8)
from film;

-- How many movies longer than 3 hours?
select count(film_id)
from film
where length>180;

-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org
select lower(email)
from customer;


-- What's the length of the longest film title? 
select title, length(title) from film order by length(title) desc, title limit 1;

select max(length) 
from sakila.film
where length(title) 
order by length(title) desc, title limit 1;











-- Lab 3
-- How many distinct (different) actors' last names are there?
select count(distinct(last_name)) from actor;


-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct(language_id)) from film;

-- How many movies were released with "PG-13" rating?
select count(rating)
from film
where rating = 'PG-13';

-- Get 10 the longest movies from 2006.

select count(distinct(release_year)) from film;

select title
from film
where release_year = 2006
order by length desc
limit 10;



-- How many days has been the company operating (check DATEDIFF() function)?
select max(rental_date), min(rental_date) from rental;

select datediff("2006-02-14", "2005-05-24");

-- Show rental info with additional columns month and weekday. Get 20
select * , weekday(rental_date) as rental_day, month(rental_date) as rental_month from rental limit 20;


-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.


select *, weekday(rental_date) as rental_day,
case
when weekday(rental_date) = 0 then 'workday'
when weekday(rental_date) = 1 then 'workday'
when weekday(rental_date) = 2 then 'workday'
when weekday(rental_date) = 3 then 'workday'
when weekday(rental_date) = 4 then 'workday'
when weekday(rental_date) = 5 then 'weekend'
when weekday(rental_date) = 6 then 'weekend'
end as 'day_type'
from rental; 

select *, weekday(rental_date) as rental_day,
case
when weekday(rental_date) between 0 and 4 then 'workday'
when weekday(rental_date) between 5 and 6 then 'weekend'
end as 'day_type'
from rental; 


-- How many rentals were in the last month of activity?

select max(rental_date) from rental;


select count(rental_id) as last_month_rentals from rental where rental_date like'2006-02%';





-- Lab 4 
-- Get film ratings
select rating
from film;




-- Get release years
select release_year
from film;



-- Get all films with ARMAGEDDON in the title
select title 
from film
where title like '%armageddon%';



-- Get all films with APOLLO in the title
select title
from film
where title like '%apollo%';



-- Get all films which title ends with APOLLO
select title
from film
where title like '%apollo';



-- Get all films with word DATE in the title

select * from film
where title regexp '(^|[[:space:]])date([[:space:]]|$)';



-- Get 10 films with the longest title
select title, length(title) from film order by length(title) desc, title limit 10;



-- Get 10 the longest films
select title from film order by length desc, title limit 10;



-- How many films include Behind the Scenes content ?
select count(special_features) 
from film
where special_features like '%Behind the Scenes%';



-- List films ordered by release year and title in alphabetical order
select *
from film
order by title and release_year asc;

select distinct title, release_year from film
order by title;



-- Lab 5
-- Drop column picture from staff.
alter table staff
drop picture;
select * from staff;



-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * 
from staff;

select first_name
from customer
where first_name like '%TAMMY%';

insert into sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update) 
values (3, 'Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.org', 2, 1, 'Tammy', null, '2006-02-15');

delete from staff where staff_id = 55;
delete from staff where staff_id = 3;

insert into sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update) 
values (3, 'Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.org', 2, 1, 'Tammy', null, '2006-02-15');


-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table.
-- Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well.

select * from rental;
select * from film;
select * from staff;
select * from inventory;

select film_id
from film
where title like '%academy%';

select *
from film
where title = 'Academy Dinosaur';


insert into rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) 
values (1002, curdate(), 5, 459, '2022-11-20', 1, curdate());


select * 
from rental
where rental_id = 1002;


-- Use similar method to get inventory_id, film_id, and staff_id.
select film_id
from film
where title = 'Academy Dinosaur';

select inventory_id
from rental
where rental_id = 1002;

select staff_id
from rental
where rental_id = 1002;

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
-- Step 1: Check if there are any non-active users
-- Step 2: Create a table backup table as suggested
-- Step 3: Insert the non active users in the table backup table
-- Step 4: Delete the non active users from the table customer


select *
from customer
where active = 0;

drop table if exists deleted_users;

create table deleted_users (
customer_id int UNIQUE NOT NULL,
email varchar(50) DEFAULT NULL,
active int DEFAULT NULL,
date varchar(50) DEFAULT NULL,
CONSTRAINT PRIMARY KEY (customer_id));



insert into deleted_users (customer_id, email, active, date) values
(16, 'SANDRA.MARTIN@sakilacustomer.org', 0,'2006-02-14'),
(64, 'JUDITH.COX@sakilacustomer.org', 0, '2006-02-14'),
(124, 'SHEILA.WELLS@sakilacustomer.org', 0, '2006-02-14'),
(169, 'ERICA.MATTHEWS@sakilacustomer.org', 0, '2006-02-14'),
(241, 'HEIDI.LARSON@sakilacustomer.org', 0, '2006-02-14'),
(271, 'PENNY.NEAL@sakilacustomer.org', 0, '2006-02-14'),
(315, 'KENNETH.GOODEN@sakilacustomer.org', 0, '2006-02-14'),
(368, 'HARRY.ARCE@sakilacustomer.org', 0, '2006-02-14'),
(406, 'NATHAN.RUNYON@sakilacustomer.org', 0, '2006-02-14'),
(446, 'THEODORE.CULP@sakilacustomer.org', 0, '2006-02-14'),
(482, 'MAURICE.CRAWLEY@sakilacustomer.org', 0, '2006-02-14'),
(510, 'BEN.EASTER@sakilacustomer.org', 0, '2006-02-14'),
(534, 'CHRISTIAN.JUNG@sakilacustomer.org', 0, '2006-02-14'),
(558, 'JIMMIE.EGGLESTON@sakilacustomer.org', 0, '2006-02-14'),
(592, 'TERRANCE.ROUSH@sakilacustomer.org', 0, '2006-02-14');

select * from deleted_users;



delete from customer where active = 0;




-- Lab 6


drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;




LOAD DATA INFILE '/Users/civicfab/Desktop/Documents/Ironhack/Unit2/lab/films_2020.csv'
into table films_2020
FIELDS TERMINATED BY ',';



show variables like 'local_infile';
set global local_infile = 1;
show variables like 'secure_file_priv';
set sql_safe_updates = 0;



LOAD DATA INFILE '/Users/civicfab/Desktop/Documents/Ironhack/Unit2/lab/films_2020.csv'
into table films_2020
FIELDS TERMINATED BY ',';

select * 
from films_2020;

update films_2020
set 
    rental_rate = 2.99,
    rental_duration = 3,
    replacement_cost = 8.99;







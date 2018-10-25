
SELECT first_name, last_name 
FROM actor;

SELECT CONCAT(first_name,  ' ', last_name) AS ' Actor Name'
FROM actor;

SELECT  first_name, last_name 
FROM actor
WHERE first_name = 'JOE';

SELECT  first_name, last_name 
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT  first_name, last_name 
FROM actor
WHERE last_name LIKE '%LI%'    ORDER BY last_name, first_name;

SELECT country_id,  country
FROM country   WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


ALTER TABLE actor
ADD COLUMN  description BLOB;
DESCRIBE actor;

ALTER TABLE actor
DROP COLUMN description;
DESCRIBE actor;

SELECT last_name, COUNT(*)  AS `COUNT`
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(*) AS `COUNT`
FROM actor
GROUP BY last_name
HAVING Count > 2;

UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

DESCRIBE sakila.address;
-- SHOW CREATE TABLE address 

SELECT staff.first_name, staff.last_name, address.address
FROM staff  LEFT JOIN address  ON staff.address_id = address.address_id;


SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL AMOUNT '
FROM staff s LEFT JOIN payment p  ON s.staff_id = p.staff_id
WHERE p.payment_date >='2005-08-01 00:00:00'
AND p.payment_date <'2005-09-01 00:00:00'
GROUP BY s.first_name, s.last_name;

SELECT f.title, COUNT(a.actor_id) AS 'COUNT'
FROM film f LEFT JOIN film_actor  a ON f.film_id = a.film_id
GROUP BY f.title;

SELECT COUNT(title) 
FROM film
 WHERE title = 'Hunchback Impossible'


SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount  Paid '
FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name

SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id=(SELECT language_id FROM language where name='English')

SELECT first_name, last_name
FROM actor
WHERE actor_id
IN (SELECT actor_id FROM film_actor WHERE film_id 
IN (SELECT film_id from film where title='ALONE TRIP'))

SELECT first_name, last_name, email 
FROM customer c
JOIN address a ON (c.address_id = a.address_id)
JOIN city ct ON (a.city_id=ct.city_id)
JOIN country cy ON (ct.country_id=cy.country_id)

SELECT title from film f
JOIN film_category ft on (f.film_id=ft.film_id)
JOIN category c on (ft.category_id=c.category_id);


SELECT title, COUNT(f.film_id) AS ' Rented-Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY  Rented-Movies ;

SELECT st.store_id, SUM(py.amount) 
FROM payment py
JOIN staff st ON (py.staff_id=st.staff_id)
GROUP BY store_id;

SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

SELECT c.name AS 'Top 5', SUM(py.amount) AS 'Total'
FROM category c
JOIN film_category f ON (c.category_id=f.category_id)
JOIN inventory iv ON (f.film_id=iv.film_id)
JOIN rental r ON (iv.inventory_id=r.inventory_id)
JOIN payment py ON (r.rental_id=py.rental_id)
GROUP BY c.name ORDER BY Total  LIMIT 5;

Create View CategoryView AS
SELECT c.name AS "Top_5", SUM(p.amount) AS "gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY gross  LIMIT 5;

Select * from CategoryView;

DROP VIEW CategoryView;
USE sakila;

SELECT first_name,last_name FROM actor;

SELECT CONCAT(first_name, " ", last_name) AS "Actor Name" FROM actor;

SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";

SELECT * FROM actor WHERE last_name LIKE "%GEN%";

SELECT * FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, count(last_name) FROM actor
GROUP BY last_name;

SELECT last_name, count(last_name) FROM actor
GROUP BY last_name
HAVING count(last_name) >= 2;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" and last_name = "WILLIAMS";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

SHOW CREATE TABLE address;

SELECT first_name, last_name, address
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id;

SELECT first_name, last_name, SUM(amount)
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment_date between "2005-08-01 00:00:00" and "2005-08-31 23:59:59"
GROUP BY staff.staff_id;

SELECT title, count(actor_id)
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

SELECT title, count(inventory_id)
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible"
GROUP BY film.film_id;

SELECT first_name, last_name, SUM(amount)
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name;

SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = "English"
    ) and (title LIKE "K%" OR title LIKE "Q%");

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN (
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
        )
    );
    
SELECT first_name, last_name, email
FROM customer
LEFT JOIN address ON customer.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id
WHERE country = "Canada";

SELECT title
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
WHERE name = "Family";

SELECT title, count(title)
FROM rental
LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY count(title) DESC;

SELECT store.store_id, SUM(amount) AS "Total Revenue ($)"
FROM store
LEFT JOIN customer ON store.store_id = customer.store_id
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

SELECT store.store_id, city, country
FROM store
LEFT JOIN address ON store.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id;

SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT name
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN inventory ON film_category.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

CREATE VIEW top_five_genres AS
SELECT name
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN inventory ON film_category.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;



    








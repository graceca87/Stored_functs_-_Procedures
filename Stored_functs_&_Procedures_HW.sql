--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating


-- Create Procedure (use existing film params for types needed)
CREATE OR REPLACE PROCEDURE add_new_film(
	title VARCHAR(255),
	description text,
	release_year YEAR,
	language_id INT2,
	rental_duration INT2,
	rental_rate NUMERIC(4,2),
	length INTEGER,
	replacement_cost NUMERIC(5,2),
	rating mpaa_rating
)
LANGUAGE plpgsql 
AS $$ 
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating);
END;
$$;


-- Execute procedure - use the CALL keyword
CALL add_new_film('Eternal Sunshine of the Spotless Mind','When their relationship turns sour, a couple undergoes a medical procedure to have each other erased from their memories', '2004', '1', '5', '4.99', '108', '25.99', 'R');

-- Check to see that procedure ran
SELECT *
FROM film
WHERE title = 'Eternal Sunshine of the Spotless Mind';

-- Success!


------------------------------------------------------------------------------------------------------------------------
--2. Create a Stored Function that will take in a category_id and return the number of films in that category

--*** So I originally misread the question and created a stored function that returns the category name when given
-- a category id. Thought i'd just leave it here...
--SELECT * 
--FROM category
--
--SELECT name
--FROM category
--WHERE category_id = num
--
--
--CREATE OR REPLACE FUNCTION get_category_name(num INTEGER)
--RETURNS VARCHAR(50)
--LANGUAGE plpgsql 
--AS $$
--	DECLARE name VARCHAR(50); 
--BEGIN 
--	SELECT category.name INTO name
--	FROM category
--	WHERE category_id = num;
--	RETURN name;
--END;
--$$; 
--
--
---- Execute the function - use SELECT 
--SELECT get_category_name(15);

-- Here is the answer to the ACTUAL question:

CREATE OR REPLACE FUNCTION get_numfilms_in_category(cat_num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql 
AS $$
	DECLARE numfilms INTEGER; 
BEGIN 
	SELECT count(film_id) INTO numfilms
	FROM film_category
	WHERE category_id = cat_num;
	RETURN numfilms;
END;
$$; 


-- Execute the function --
SELECT get_numfilms_in_category(10)


-- Hoozah it works!

SELECT *
FROM film_category
WHERE category_id = 10


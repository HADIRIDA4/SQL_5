WITH TOP_10_CUSTOMERS AS (
    SELECT
        c.customer_id,
        COUNT(DISTINCT r.rental_id) AS num_distinct_films_rented,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name
    FROM
        customer c
    INNER JOIN
        rental r
        ON r.customer_id = c.customer_id
    GROUP BY
        c.customer_id
    ORDER BY
        num_distinct_films_rented DESC
    LIMIT
        10
)

SELECT 
    tc.customer_id,
    tc.full_name, 
    AVG(p.amount) AS avg_payment_amount,
    tc.num_distinct_films_rented AS rentals_amount
FROM 
    TOP_10_CUSTOMERS AS tc
INNER JOIN 
    payment AS p
    ON tc.customer_id = p.customer_id
GROUP BY 
    tc.customer_id, tc.full_name, tc.num_distinct_films_rented;
	
---
CREATE TEMPORARY TABLE film_inventory_3 AS
SELECT
    f.film_id,
    f.title AS film_title,
    count(i.inventory_id) AS available_inventory_count
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
GROUP BY
    f.film_id, f.title;
----Create a Temporary Table named store_performance that stores store IDs, revenue, and the average payment amount per rental.
CREATE TEMPORARY TABLE store_performance AS
SELECT
    s.store_id,
    SUM(p.amount) AS revenue,
    AVG(p.amount) AS avg_payment_per_rental
FROM
    store s
JOIN
    staff st ON s.manager_staff_id = st.staff_id
JOIN
    payment p ON st.staff_id = p.staff_id
JOIN
    rental r ON p.rental_id = r.rental_id
GROUP BY
    s.store_id;
select * from store_performance
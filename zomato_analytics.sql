CREATE DATABASE zomato_analytics;

USE zomato_analytics;

SHOW TABLES;

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    locality VARCHAR(100),
    cuisine VARCHAR(100),
    cost_for_two DECIMAL(10,2),
    rating DECIMAL(2,1),
    votes INT,
    is_delivering VARCHAR(10),
    online_order VARCHAR(10),
    table_booking VARCHAR(10),
    opened_year YEAR
);

CREATE TABLE menu_items (
    menu_item_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    food_type VARCHAR(20),
    price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    signup_date DATE,
    is_premium_member VARCHAR(10)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    order_status VARCHAR(20),
    payment_method VARCHAR(30),
    delivery_time_mins INT,
    rating_given DECIMAL(2,1),
    discount_percent DECIMAL(5,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_item_id INT NOT NULL,
    item_name VARCHAR(100),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (menu_item_id)
        REFERENCES menu_items(menu_item_id)
);

SELECT COUNT(*) AS total_restaurants
FROM restaurants;

SELECT COUNT(*) AS total_menu_items
FROM menu_items;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SHOW TABLES;


DESCRIBE restaurants;

SELECT *
FROM restaurants
LIMIT 5;

DESCRIBE menu_items;

SELECT *
FROM menu_items
LIMIT 5;

DESCRIBE customers;

SELECT *
FROM customers
LIMIT 5;

DESCRIBE orders;

SELECT *
FROM orders
LIMIT 5;

DESCRIBE order_items;

SELECT *
FROM order_items
LIMIT 5;

DESCRIBE restaurants;



SELECT COUNT(*) AS null_restaurant_names
FROM restaurants
WHERE restaurant_name IS NULL;

SELECT COUNT(*) AS null_locations
FROM restaurants
WHERE locality IS NULL;

SELECT COUNT(*) AS null_ratings
FROM restaurants
WHERE rating IS NULL;

SELECT restaurant_name,
       city,
       locality,
       COUNT(*) AS duplicate_count
FROM restaurants
GROUP BY restaurant_name, city, locality
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS null_customer_names
FROM customers
WHERE customer_name IS NULL;

SELECT COUNT(*) AS null_customer_ids
FROM orders
WHERE customer_id IS NULL;

SELECT COUNT(*) AS null_restaurant_ids
FROM orders
WHERE restaurant_id IS NULL;

SELECT restaurant_name, rating
FROM restaurants
WHERE rating = (
    SELECT MAX(rating)
    FROM restaurants
);

SELECT AVG(rating) AS average_rating
FROM restaurants;

SELECT restaurant_name, rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM restaurants
)
ORDER BY rating DESC;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;
    
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT city,
       COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city
ORDER BY restaurant_count DESC;

SELECT city,
       locality,
       COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city, locality
ORDER BY restaurant_count DESC;

SELECT city,
       ROUND(AVG(rating), 2) AS average_rating
FROM restaurants
GROUP BY city
ORDER BY average_rating DESC;

SELECT city,
       ROUND(AVG(cost_for_two), 2) AS average_cost_for_two
FROM restaurants
GROUP BY city
ORDER BY average_cost_for_two DESC;

SELECT restaurant_name,
       city,
       cuisine,
       rating,
       votes
FROM restaurants
ORDER BY rating DESC, votes DESC
LIMIT 10;

SELECT restaurant_name,
       city,
       rating,
       votes
FROM restaurants
ORDER BY votes DESC
LIMIT 10;

SELECT restaurant_name,
       city,
       rating
FROM restaurants
WHERE rating > 4.5
ORDER BY rating DESC;

SELECT cuisine,
       COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY cuisine
ORDER BY restaurant_count DESC;

SELECT cuisine,
       ROUND(AVG(rating), 2) AS average_rating
FROM restaurants
GROUP BY cuisine
ORDER BY average_rating DESC;

SELECT cuisine,
       ROUND(AVG(cost_for_two), 2) AS average_cost_for_two
FROM restaurants
GROUP BY cuisine
ORDER BY average_cost_for_two DESC;

SELECT cuisine,
       COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY cuisine
ORDER BY restaurant_count DESC
LIMIT 5;

SELECT COUNT(*) AS total_menu_items
FROM menu_items;

SELECT item_name,
       food_type,
       price
FROM menu_items
ORDER BY price DESC
LIMIT 10;

SELECT item_name,
       food_type,
       price
FROM menu_items
ORDER BY price
LIMIT 10;

SELECT ROUND(AVG(price), 2) AS average_item_price
FROM menu_items;

SELECT food_type,
       COUNT(*) AS item_count
FROM menu_items
GROUP BY food_type
ORDER BY item_count DESC;

SELECT food_type,
       ROUND(AVG(price), 2) AS average_price
FROM menu_items
GROUP BY food_type
ORDER BY average_price DESC;

SELECT r.restaurant_name,
       r.city,
       COUNT(m.menu_item_id) AS menu_item_count
FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
ORDER BY menu_item_count DESC;

SELECT order_status,
       COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

SELECT payment_method,
       COUNT(*) AS order_count
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;

SELECT ROUND(AVG(delivery_time_mins), 2) AS average_delivery_time
FROM orders;

SELECT MAX(delivery_time_mins) AS maximum_delivery_time
FROM orders;

SELECT MIN(delivery_time_mins) AS minimum_delivery_time
FROM orders;

SELECT r.restaurant_name,
       ROUND(AVG(o.delivery_time_mins), 2) AS average_delivery_time
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY average_delivery_time;

SELECT r.restaurant_name,
       COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC;

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 10;

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

SELECT is_premium_member,
       COUNT(*) AS customer_count
FROM customers
GROUP BY is_premium_member;

SELECT city,
       COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

SELECT ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items;

SELECT order_id,
       ROUND(SUM(quantity * unit_price), 2) AS order_value
FROM order_items
GROUP BY order_id
ORDER BY order_value DESC;

SELECT ROUND(AVG(order_value), 2) AS average_order_value
FROM (
    SELECT order_id,
           SUM(quantity * unit_price) AS order_value
    FROM order_items
    GROUP BY order_id
) AS order_totals;

SELECT order_id,
       ROUND(SUM(quantity * unit_price), 2) AS order_value
FROM order_items
GROUP BY order_id
ORDER BY order_value DESC
LIMIT 1;

SELECT r.restaurant_name,
       r.city,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
ORDER BY total_revenue DESC;

SELECT r.restaurant_name,
       r.city,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
ORDER BY total_revenue DESC
LIMIT 10;

SELECT item_name,
       SUM(quantity) AS total_quantity
FROM order_items
GROUP BY item_name
ORDER BY total_quantity DESC
LIMIT 10;

SELECT item_name,
       ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items
GROUP BY item_name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT COUNT(DISTINCT menu_item_id) AS unique_items_ordered
FROM order_items;

SELECT r.restaurant_name,
       oi.item_name,
       SUM(oi.quantity) AS total_quantity
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY r.restaurant_id, r.restaurant_name, oi.item_name
ORDER BY total_quantity DESC;

SELECT c.customer_id,
       c.customer_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT c.customer_id,
       c.customer_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT YEAR(order_date) AS order_year,
       MONTH(order_date) AS order_month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

SELECT YEAR(o.order_date) AS order_year,
       MONTH(o.order_date) AS order_month,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

SELECT YEAR(o.order_date) AS order_year,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS yearly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY order_year;

SELECT ROUND(AVG(discount_percent), 2) AS average_discount
FROM orders;

SELECT COUNT(*) AS discounted_orders
FROM orders
WHERE discount_percent > 0;

SELECT order_id,
       customer_id,
       discount_percent
FROM orders
WHERE discount_percent > 20
ORDER BY discount_percent DESC;

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = 1;

WITH restaurant_revenue AS (
    SELECT r.restaurant_id,
           r.restaurant_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT restaurant_name,
       ROUND(total_revenue, 2) AS total_revenue
FROM restaurant_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM restaurant_revenue
)
ORDER BY total_revenue DESC;

SELECT restaurant_name,
       total_revenue,
       RANK() OVER (
           ORDER BY total_revenue DESC
       ) AS revenue_rank
FROM (
    SELECT r.restaurant_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY r.restaurant_id, r.restaurant_name
) AS restaurant_revenue;

SELECT restaurant_name,
       city,
       total_revenue,
       RANK() OVER (
           PARTITION BY city
           ORDER BY total_revenue DESC
       ) AS city_rank
FROM (
    SELECT r.restaurant_name,
           r.city,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY r.restaurant_id, r.restaurant_name, r.city
) AS restaurant_revenue;


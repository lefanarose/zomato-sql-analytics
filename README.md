# Zomato SQL Analytics

A MySQL project that analyzes Zomato-style restaurant, customer, and order data. It covers database design, data quality checks, and business analysis using SQL.

## Database Schema

The database `zomato_analytics` has 5 related tables:

| Table | Description |
|-------|-------------|
| `restaurants` | Restaurant details: city, locality, cuisine, cost for two, rating, votes, delivery/online order/table booking options, opened year |
| `menu_items` | Menu items for each restaurant: item name, food type, price |
| `customers` | Customer details: name, email, phone, city, signup date, premium membership |
| `orders` | Order details: customer, restaurant, date/time, status, payment method, delivery time, rating, discount |
| `order_items` | Items in each order: menu item, quantity, unit price |

**Relationships (foreign keys):**
- `menu_items.restaurant_id` → `restaurants.restaurant_id`
- `orders.customer_id` → `customers.customer_id`
- `orders.restaurant_id` → `restaurants.restaurant_id`
- `order_items.order_id` → `orders.order_id`
- `order_items.menu_item_id` → `menu_items.menu_item_id`

## Analysis Covered

### 1. Data Exploration and Validation
- Row counts for every table
- Table structure checks using `DESCRIBE`
- NULL checks on restaurant names, locations, ratings, and order IDs
- Duplicate restaurant detection

### 2. Restaurant Analysis
- Restaurants per city and locality
- Average rating and average cost for two by city
- Top 10 restaurants by rating and by votes
- Restaurants rated above 4.5 and above the overall average

### 3. Cuisine Analysis
- Number of restaurants per cuisine
- Average rating and cost by cuisine
- Top 5 most common cuisines

### 4. Menu Analysis
- Most and least expensive menu items
- Average item price
- Veg / non-veg item distribution and average price
- Menu size per restaurant

### 5. Order Analysis
- Orders by status and payment method
- Average, minimum, and maximum delivery time
- Average delivery time per restaurant
- Total orders per restaurant

### 6. Customer Analysis
- Customers ranked by number of orders
- Repeat customers vs. one-time customers
- Premium vs. non-premium members
- Customers by city
- Top 10 customers by total spend

### 7. Revenue Analysis
- Total revenue and average order value
- Highest value order
- Revenue by restaurant (and top 10)
- Top selling items by quantity and by revenue
- Monthly and yearly order and revenue trends

### 8. Discount Analysis
- Average discount percentage
- Number of discounted orders
- Orders with discounts above 20%

### 9. Advanced SQL
- **CTE:** restaurants earning above-average revenue
- **Window functions:** `RANK()` for overall revenue ranking and ranking within each city (`PARTITION BY city`)

## SQL Concepts Used
- `CREATE DATABASE`, `CREATE TABLE`, primary and foreign keys, `UNIQUE`, `NOT NULL`
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROUND`
- `GROUP BY` and `HAVING`
- `INNER JOIN` across multiple tables
- Subqueries
- Common Table Expressions (CTEs)
- Window functions (`RANK() OVER`)
- Date functions (`YEAR`, `MONTH`)

## Tools Used
- MySQL
- MySQL Workbench

## How to Run
1. Open MySQL Workbench (or any MySQL client).
2. Open `zomato_analytics.sql`.
3. Run the script to create the database and tables.
4. Insert or import your data into the tables (the script contains the schema and queries only).
5. Run the analysis queries and view the results.

## Files
- `zomato_analytics.sql` – database schema and all analysis queries

## Author
**Lefana Rose A**
GitHub: [lefanarose](https://github.com/lefanarose)

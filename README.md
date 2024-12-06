# MySQL Food Delivery Service Database Project

This repository contains a comprehensive MySQL project based on a **Food Delivery Service** case study. The project explores and implements essential MySQL concepts through a 15-day challenge that covers real-world data analysis and SQL queries. It includes the creation of a database, tables, and queries to manage customers, orders, menu items, deliveries, and more.

## Project Overview

The goal of this project is to design a relational database for **FoodCo**, a food delivery service, and solve various business logic and data analysis challenges related to customers, orders, restaurants, and delivery agents. The project covers a variety of SQL concepts, including:

- Basic SQL Queries
- Aggregation Functions
- Joins (INNER, LEFT, RIGHT)
- Subqueries and Views
- Stored Procedures and Triggers

## Database Structure

The database is designed with the following tables:

1. **Customers**
    - customer_id (Primary Key)
    - first_name
    - last_name
    - email
    - phone_number
    - address

2. **Restaurants**
    - restaurant_id (Primary Key)
    - restaurant_name
    - cuisine_type
    - address

3. **Menu_Items**
    - item_id (Primary Key)
    - restaurant_id (Foreign Key references Restaurants)
    - item_name
    - price

4. **Orders**
    - order_id (Primary Key)
    - customer_id (Foreign Key references Customers)
    - restaurant_id (Foreign Key references Restaurants)
    - order_date
    - total_price

5. **Order_Items**
    - order_item_id (Primary Key)
    - order_id (Foreign Key references Orders)
    - item_id (Foreign Key references Menu_Items)
    - quantity

6. **Delivery_Agents**
    - agent_id (Primary Key)
    - first_name
    - last_name
    - phone_number

7. **Deliveries**
    - delivery_id (Primary Key)
    - order_id (Foreign Key references Orders)
    - agent_id (Foreign Key references Delivery_Agents)
    - delivery_date
    - delivery_status

## SQL Concepts Covered

The following SQL concepts are covered through a series of tasks for each day:

- **Day 31 - Day 35**: Basic Queries, Filtering, Sorting, and Limiting Data
  - Using `DISTINCT`, `WHERE`, `ORDER BY`, and `LIMIT`
  - Arithmetic, Comparison, and Logical Operators
  - Using `IS NULL`, `IN`, `NOT IN`, `LIKE`

- **Day 36 - Day 40**: Aggregation and Joins
  - `COUNT()`, `SUM()`, `AVG()`
  - `GROUP BY`, `HAVING`
  - `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `UNION`, `UNION ALL`

- **Day 41 - Day 45**: Advanced SQL Functions and Automation
  - Mathematical, String, and Date Functions
  - Subqueries, Views, and Triggers
  - Creating and using stored procedures

## How to Use

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/mysql-food-delivery-service.git
    cd mysql-food-delivery-service
    ```

2. Set up your MySQL environment and run the SQL script files to create the database and tables:
    - `create_tables.sql`: Creates all necessary tables.
    - `insert_data.sql`: Inserts sample data into the tables.
    - `queries.sql`: Contains SQL queries for different tasks.

3. To see the queries and results, you can either:
    - Execute the queries manually in MySQL Workbench or any other SQL editor.
    - Or use a local MySQL server to run the database and perform data analysis.

4. Optionally, you can also explore the stored procedures and triggers implemented in this project to automate the updating of data and calculating prices.

## Project Files

- `create_tables.sql`: SQL script to create tables.
- `insert_data.sql`: SQL script to insert 100 random data entries into each table.
- `queries.sql`: SQL script with queries performed on the database.
- `stored_procedures.sql`: Contains the stored procedure and triggers to automate tasks.

## License

This project is open-source and available under the MIT License.

## Acknowledgments

- Thanks to all the resources and tutorials that helped me complete this challenge!
- Feel free to fork, modify, or use this project for learning or improvement.
- Contributions and feedback are welcome!

---

**Check out the project on my LinkedIn post for more details!**  
[GitHub Link]


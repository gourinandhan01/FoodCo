-- Create Database
CREATE DATABASE IF NOT EXISTS FoodDeliveryService;
USE FoodDeliveryService;

-- Create Tables
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    cuisine_type VARCHAR(50),
    address VARCHAR(255)
);

CREATE TABLE Menu_Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);

CREATE TABLE Delivery_Agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15)
);

CREATE TABLE Deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    agent_id INT,
    delivery_date DATE,
    delivery_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (agent_id) REFERENCES Delivery_Agents(agent_id)
);

-- Insert Procedures
DELIMITER $$

CREATE PROCEDURE InsertRealisticCustomers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Customers (first_name, last_name, email, phone_number, address)
        VALUES (
            ELT(FLOOR(1 + RAND() * 10), 'John', 'Emma', 'Michael', 'Sophia', 'William', 'Olivia', 'James', 'Isabella', 'Alexander', 'Mia'),
            ELT(FLOOR(1 + RAND() * 10), 'Smith', 'Johnson', 'Brown', 'Williams', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'),
            CONCAT(
                LOWER(ELT(FLOOR(1 + RAND() * 10), 'John', 'Emma', 'Michael', 'Sophia', 'William', 'Olivia', 'James', 'Isabella', 'Alexander', 'Mia')),
                '.',
                LOWER(ELT(FLOOR(1 + RAND() * 10), 'Smith', 'Johnson', 'Brown', 'Williams', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez')),
                '@gmail.com'
            ),
            CONCAT('+91', FLOOR(1000000000 + RAND() * 900000000)),
            CONCAT('House No. ', FLOOR(1 + RAND() * 100), ', Street ', FLOOR(1 + RAND() * 50), ', City')
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomRestaurants()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Restaurants (restaurant_name, cuisine_type, address)
        VALUES (
            CONCAT('Restaurant', FLOOR(1000 + RAND() * 9000)),
            ELT(FLOOR(1 + RAND() * 5), 'Italian', 'Chinese', 'Indian', 'Mexican', 'Japanese'),
            CONCAT('Street ', FLOOR(1 + RAND() * 100), ', Area ', FLOOR(1 + RAND() * 50))
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomMenuItems()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Menu_Items (restaurant_id, item_name, price)
        VALUES (
            FLOOR(1 + RAND() * 100), -- Random restaurant_id between 1 and 100
            CONCAT('Dish', FLOOR(1 + RAND() * 500)),
            ROUND(5 + (RAND() * 45), 2) -- Random price between 5 and 50
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Orders (customer_id, restaurant_id, order_date, total_price)
        VALUES (
            FLOOR(1 + RAND() * 100), -- Random customer_id between 1 and 100
            FLOOR(1 + RAND() * 100), -- Random restaurant_id between 1 and 100
            CURDATE() - INTERVAL FLOOR(RAND() * 30) DAY, -- Random date within the last 30 days
            ROUND(20 + (RAND() * 200), 2) -- Random total price between 20 and 220
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomOrderItems()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Order_Items (order_id, item_id, quantity)
        VALUES (
            FLOOR(1 + RAND() * 100), -- Random order_id between 1 and 100
            FLOOR(1 + RAND() * 100), -- Random item_id between 1 and 100
            FLOOR(1 + RAND() * 10)  -- Random quantity between 1 and 10
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomDeliveryAgents()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Delivery_Agents (first_name, last_name, phone_number)
        VALUES (
            CONCAT('AgentFirst', FLOOR(1000 + RAND() * 9000)),
            CONCAT('AgentLast', FLOOR(1000 + RAND() * 9000)),
            CONCAT('+91', FLOOR(1000000000 + RAND() * 900000000))
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE PROCEDURE InsertRandomDeliveries()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Deliveries (order_id, agent_id, delivery_date, delivery_status)
        VALUES (
            FLOOR(1 + RAND() * 100), -- Random order_id between 1 and 100
            FLOOR(1 + RAND() * 100), -- Random agent_id between 1 and 100
            CURDATE() - INTERVAL FLOOR(RAND() * 10) DAY, -- Random date within the last 10 days
            ELT(FLOOR(1 + RAND() * 3), 'Delivered', 'Pending', 'Failed') -- Random status
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Execute Insertion Procedures
CALL InsertRealisticCustomers();
CALL InsertRandomRestaurants();
CALL InsertRandomMenuItems();
CALL InsertRandomOrders();
CALL InsertRandomOrderItems();
CALL InsertRandomDeliveryAgents();
CALL InsertRandomDeliveries();

-- Start with the FoodDeliveryService database
USE FoodDeliveryService;

-- Day 31: DISTINCT, AS, WHERE
SELECT DISTINCT cuisine_type AS Unique_Cuisines FROM Restaurants;
SELECT first_name AS FirstName, last_name AS LastName FROM Customers;

-- Day 32: Operators (Arithmetic, Comparison, Logical)
SELECT * FROM Orders WHERE total_price > 25;
SELECT * FROM Order_Items WHERE quantity < 3 AND quantity > 1;

-- Day 33: IS NULL, IS NOT NULL, IN, NOT IN
SELECT * FROM Customers WHERE phone_number IS NULL;
SELECT * FROM Restaurants WHERE cuisine_type NOT IN ('Italian', 'Japanese');

-- Day 34: BETWEEN, NOT BETWEEN, LIKE, NOT LIKE
SELECT * FROM Orders WHERE order_date BETWEEN '2024-01-01' AND '2024-01-07';
SELECT * FROM Customers WHERE first_name LIKE 'J%' AND first_name LIKE '%n';

-- Day 35: ORDER BY, LIMIT
SELECT * FROM Menu_Items ORDER BY price DESC LIMIT 5;
SELECT customer_id, COUNT(order_id) AS TotalOrders 
FROM Orders 
GROUP BY customer_id 
ORDER BY TotalOrders DESC LIMIT 3;

-- Day 36: Aggregate Functions (COUNT, SUM, AVG)
SELECT COUNT(*) AS TotalOrders FROM Orders;
SELECT AVG(price) AS AveragePrice FROM Menu_Items;

-- Day 37: GROUP BY, HAVING
SELECT restaurant_id, SUM(total_price) AS TotalSales 
FROM Orders 
GROUP BY restaurant_id;
SELECT restaurant_id 
FROM Orders 
GROUP BY restaurant_id 
HAVING SUM(total_price) > 50;

-- Day 38: INNER JOIN
SELECT Orders.order_id, Customers.first_name, Restaurants.restaurant_name 
FROM Orders
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id
INNER JOIN Restaurants ON Orders.restaurant_id = Restaurants.restaurant_id;

-- Day 39: LEFT JOIN, RIGHT JOIN
SELECT Restaurants.restaurant_id, Orders.order_id 
FROM Restaurants
LEFT JOIN Orders ON Restaurants.restaurant_id = Orders.restaurant_id;
SELECT Deliveries.delivery_id, Delivery_Agents.agent_id 
FROM Deliveries
RIGHT JOIN Delivery_Agents ON Deliveries.agent_id = Delivery_Agents.agent_id;

-- Day 40: UNION, UNION ALL
SELECT first_name AS Name FROM Customers
UNION
SELECT first_name AS Name FROM Delivery_Agents;
SELECT first_name AS Name FROM Customers
UNION ALL
SELECT first_name AS Name FROM Delivery_Agents;

-- Day 41: Mathematical Functions
SELECT item_id, price, ROUND(price * 0.9, 2) AS DiscountedPrice FROM Menu_Items;

-- Day 42: String Functions
SELECT LOWER(email) AS LowercaseEmails FROM Customers;

-- Day 43: Date & Time Functions
SELECT Orders.order_id, 
       DATEDIFF(Deliveries.delivery_date, Orders.order_date) AS Duration
FROM Orders
INNER JOIN Deliveries ON Orders.order_id = Deliveries.order_id;

-- Day 44: Subqueries, Views
SELECT customer_id 
FROM (SELECT customer_id, COUNT(order_id) AS OrderCount 
      FROM Orders 
      GROUP BY customer_id) AS SubQuery 
WHERE OrderCount > 1;
CREATE OR REPLACE VIEW TopSpendingCustomers AS
SELECT customer_id, SUM(total_price) AS TotalSpent 
FROM Orders 
GROUP BY customer_id 
ORDER BY TotalSpent DESC LIMIT 3;

-- Day 45: Stored Procedures, Triggers
DELIMITER $$

-- Stored Procedure to Update Delivery Status
CREATE PROCEDURE UpdateDeliveryStatus(IN orderId INT, IN newStatus VARCHAR(20))
BEGIN
    UPDATE Deliveries 
    SET delivery_status = newStatus 
    WHERE order_id = orderId;
END$$

-- Trigger to Update Total Price Automatically
CREATE TRIGGER UpdateTotalPriceAfterInsert 
AFTER INSERT ON Order_Items 
FOR EACH ROW
BEGIN
    UPDATE Orders 
    SET total_price = total_price + (NEW.quantity * 
        (SELECT price FROM Menu_Items WHERE item_id = NEW.item_id))
    WHERE order_id = NEW.order_id;
END$$

DELIMITER ;

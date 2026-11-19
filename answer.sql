-- DATABASE NORMALIZATION ASSIGNMENT: 1NF AND 2NF
-- MySQL

CREATE DATABASE IF NOT EXISTS normalization_assignment;
USE normalization_assignment;

-- QUESTION 1: FIRST NORMAL FORM (1NF)
-- One product per row; composite primary key: (OrderID, Product).
DROP TABLE IF EXISTS ProductDetail_1NF;

CREATE TABLE ProductDetail_1NF (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Expected: 6 rows; each Products value is atomic.
SELECT OrderID, CustomerName, Product
FROM ProductDetail_1NF
ORDER BY OrderID, Product;


-- QUESTION 2: SECOND NORMAL FORM (2NF)
-- Original composite key: (OrderID, Product).
-- Partial dependency: OrderID -> CustomerName.
-- CustomerName depends only on part of the composite key.
-- Move CustomerName to Orders; store products and quantities in OrderItems.

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    CONSTRAINT fk_orderitems_orders
        FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Expected: 3 rows.
SELECT OrderID, CustomerName
FROM Orders
ORDER BY OrderID;

-- Expected: 6 rows.
SELECT OrderID, Product, Quantity
FROM OrderItems
ORDER BY OrderID, Product;

-- Verification JOIN: expected 6 rows.
SELECT o.OrderID, o.CustomerName, oi.Product, oi.Quantity
FROM Orders AS o
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
ORDER BY o.OrderID, oi.Product;

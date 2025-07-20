CREATE DATABASE SalesInsights;
USE SalesInsights;

CREATE TABLE Customers (
    customer_code VARCHAR(255) PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_type VARCHAR(255)
);

CREATE TABLE DateDimension (
    date DATE PRIMARY KEY,
    cy_date DATE DEFAULT NULL,
    year INT DEFAULT NULL,
    month_name VARCHAR(20) DEFAULT NULL,
    date_yy_mmm VARCHAR(20) DEFAULT NULL
);


CREATE TABLE Markets (
    market_code VARCHAR(255) PRIMARY KEY,
    markets_name VARCHAR(255) DEFAULT NULL,
    zone VARCHAR(255) DEFAULT NULL
);


CREATE TABLE Products (
    product_code VARCHAR(255) PRIMARY KEY,
    product_type VARCHAR(255) DEFAULT NULL
);


CREATE TABLE Transactions (
    product_code VARCHAR(255),
    customer_code VARCHAR(255),
    market_code VARCHAR(255),
    order_date DATE,
    sales_quantity INT,
    sales_amount DECIMAL(10,2),
    currency VARCHAR(255),
    profit_margin_percentage DECIMAL(5,2),
    profit_margin DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    FOREIGN KEY (product_code) REFERENCES Products(product_code),
    FOREIGN KEY (customer_code) REFERENCES Customers(customer_code),
    FOREIGN KEY (market_code) REFERENCES Markets(market_code),
    FOREIGN KEY (order_date) REFERENCES DateDimension(date)
);





INSERT INTO Customers VALUES ('C001', 'ABC Corp', 'Retail');
INSERT INTO Customers VALUES ('C002', 'XYZ Ltd', 'Wholesale');


INSERT INTO DateDimension VALUES 
('2020-01-15', NULL, 2020, 'January', '2020-Jan'),
('2020-05-10', NULL, 2020, 'May', '2020-May');


INSERT INTO Markets VALUES ('M001', 'Chennai', 'South'), ('M002', 'Mumbai', 'West');


INSERT INTO Products VALUES ('P001', 'Electronics'), ('P002', 'Furniture');


INSERT INTO Transactions VALUES 
('P001', 'C001', 'M001', '2020-01-15', 10, 1000.00, 'USD', 10.00, 100.00, 900.00),
('P002', 'C002', 'M002', '2020-05-10', 5, 2000.00, 'INR', 20.00, 400.00, 1600.00);





SELECT * FROM Customers;


SELECT COUNT(*) AS total_customers FROM Customers;

SELECT * FROM Transactions;


SELECT * FROM Transactions WHERE currency = 'USD';


SELECT * 
FROM Transactions t
JOIN DateDimension d ON t.order_date = d.date
WHERE d.year = 2020;


SELECT SUM(t.sales_amount) AS total_revenue_2020
FROM Transactions t
JOIN DateDimension d ON t.order_date = d.date
WHERE d.year = 2020;


SELECT SUM(t.sales_amount) AS jan_revenue_2020
FROM Transactions t
JOIN DateDimension d ON t.order_date = d.date
WHERE d.year = 2020 AND d.month_name = 'January';


SELECT SUM(t.sales_amount) AS chennai_revenue_2020
FROM Transactions t
JOIN DateDimension d ON t.order_date = d.date
JOIN Markets m ON t.market_code = m.market_code
WHERE d.year = 2020 AND m.markets_name = 'Chennai';

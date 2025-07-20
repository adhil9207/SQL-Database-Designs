CREATE DATABASE real_time_management;

use real_time_management;

CREATE TABLE Region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL
);

CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);


CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(100),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);


CREATE TABLE Warehouse (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(100),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);


CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    manager_id INT,
    job_title VARCHAR(100)
);


CREATE TABLE Product_Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    standard_cost DECIMAL(10,2),
    list_price DECIMAL(10,2),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Product_Categories(category_id)
);


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    website VARCHAR(100),
    credit_limit DECIMAL(10,2)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    status VARCHAR(50),
    salesman_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES Employees(employee_id)
);


CREATE TABLE Order_Items (
    order_id INT,
    item_id INT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Region VALUES (1, 'North America');
INSERT INTO Region VALUES (2, 'Europe');


INSERT INTO Countries VALUES (1, 'USA', 1);
INSERT INTO Countries VALUES (2, 'Germany', 2);


INSERT INTO Locations VALUES (1, '1234 Maple Street', '90210', 'Los Angeles', 'CA', 1);
INSERT INTO Locations VALUES (2, '56 Berlin Road', '10115', 'Berlin', 'Berlin', 2);


INSERT INTO Warehouse VALUES (1, 'Main Warehouse', 1);
INSERT INTO Warehouse VALUES (2, 'Europe Warehouse', 2);


INSERT INTO Employees VALUES (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2020-01-01', NULL, 'Sales Manager');
INSERT INTO Employees VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2021-03-15', 1, 'Sales Representative');


INSERT INTO Product_Categories VALUES (1, 'Electronics');
INSERT INTO Product_Categories VALUES (2, 'Furniture');


INSERT INTO Products VALUES (1, 'Laptop', '15-inch display laptop', 500.00, 800.00, 1);
INSERT INTO Products VALUES (2, 'Office Chair', 'Ergonomic office chair', 100.00, 150.00, 2);


INSERT INTO Customers VALUES (1, 'TechCorp', '789 Silicon Valley', 'www.techcorp.com', 10000.00);
INSERT INTO Customers VALUES (2, 'HomeLiving', '321 Downtown Ave', 'www.homeliving.com', 5000.00);


INSERT INTO Orders VALUES (1, 1, 'Shipped', 1, '2025-05-01');
INSERT INTO Orders VALUES (2, 2, 'Pending', 2, '2025-05-02');


INSERT INTO Order_Items VALUES (1, 1, 1, 2, 800.00);
INSERT INTO Order_Items VALUES (2, 1, 2, 4, 150.00);

SELECT * FROM Countries;

SELECT * FROM Region;

SELECT c.*
FROM Countries c
LEFT JOIN Region r ON c.region_id = r.region_id
WHERE r.region_name = 'Europe'; 

SELECT city
FROM Locations
WHERE country_id = 1; 

SELECT 
    l.city,
    l.country_id,
    r.region_id,
    r.region_name,
    c.country_name
FROM Locations l
JOIN Countries c ON l.country_id = c.country_id
JOIN Region r ON c.region_id = r.region_id;

SELECT * FROM Warehouse;

SELECT DISTINCT r.*
FROM Region r
JOIN Countries c ON r.region_id = c.region_id
JOIN Locations l ON c.country_id = l.country_id;

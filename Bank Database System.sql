Create database Bank;
use bank;
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    branch_city VARCHAR(100)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    phone_number VARCHAR(15)
);

CREATE TABLE Account (
    account_id INT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    balance DECIMAL(15, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    branch_id INT,
    amount DECIMAL(15, 2),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Depositor (
    customer_id INT,
    account_id INT,
    PRIMARY KEY (customer_id, account_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Borrower (
    customer_id INT,
    loan_id INT,
    PRIMARY KEY (customer_id, loan_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    branch_id INT,
    position VARCHAR(100),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
show tables;
select * from Employee;

INSERT INTO Branch (branch_id, branch_name, branch_city) VALUES
(1, 'Central Branch', 'New York'),
(2, 'Downtown Branch', 'Los Angeles'),
(3, 'Uptown Branch', 'Chicago');

INSERT INTO Customer (customer_id, customer_name, customer_address, phone_number) VALUES
(101, 'Alice Johnson', '123 Maple St, kochi, NY', '2125551234'),
(102, 'Bob Smith', '456 Oak St, calicut, CA', '3105555678'),
(103, 'Charlie Brown', '789 Pine St, kannur, IL', '7735559012');

INSERT INTO Account (account_id, customer_id, branch_id, balance) VALUES
(1001, 101, 1, 5000.00),
(1002, 102, 2, 3000.00),
(1003, 103, 3, 7000.00);


INSERT INTO Loan (loan_id, branch_id, amount) VALUES
(2001, 1, 10000.00),
(2002, 2, 15000.00),
(2003, 3, 12000.00);

INSERT INTO Depositor (customer_id, account_id) VALUES
(101, 1001),
(102, 1002),
(103, 1003);

INSERT INTO Borrower (customer_id, loan_id) VALUES
(101, 2001),
(102, 2002),
(103, 2003);

INSERT INTO Employee (employee_id, employee_name, branch_id, position) VALUES
(301, 'David Miller', 1, 'Manager'),
(302, 'Eva Green', 2, 'Clerk'),
(303, 'Frank Wright', 3, 'Accountant');

select * from Employee;

select customer_name from Customer;

select distinct(branch_name) from Branch;

select  * from Branch;

select account_id from Account where balance > 3000;

SELECT a.account_id, a.balance
FROM Account a
JOIN Branch b ON a.branch_id = b.branch_id
WHERE a.balance > 4000
  AND b.branch_city = 'New York';




                            
								
							


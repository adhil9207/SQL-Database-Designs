CREATE DATABASE AirportDB;
USE AirportDB;

CREATE TABLE Airplane_Type (
    A_ID INT PRIMARY KEY,
    Capacity INT,
    A_weight FLOAT,
    Company VARCHAR(100)
);

CREATE TABLE Route (
    Route_ID INT PRIMARY KEY,
    Take_off_point VARCHAR(100),
    Destination VARCHAR(100),
    R_type VARCHAR(50)
);

CREATE TABLE Flight (
    Flight_ID INT PRIMARY KEY,
    Departure TIME,
    Arrival TIME,
    Flight_date DATE,
    A_ID INT,
    FOREIGN KEY (A_ID) REFERENCES Airplane_Type(A_ID)
);

CREATE TABLE Airfare (
    Fare_ID INT PRIMARY KEY,
    Charge_Amount DECIMAL(10, 2),
    Description VARCHAR(255),
    Flight_ID INT,
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);

CREATE TABLE Passengers (
    Ps_ID INT PRIMARY KEY,
    Ps_Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    Sex CHAR(1),
    Contacts VARCHAR(20),
    Flight_ID INT,
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);

CREATE TABLE Countries (
    Country_code CHAR(3) PRIMARY KEY,
    Country_Name VARCHAR(100)
);

CREATE TABLE Airport (
    Air_code CHAR(5) PRIMARY KEY,
    Air_Name VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Country_code CHAR(3),
    FOREIGN KEY (Country_code) REFERENCES Countries(Country_code)
);

CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    E_Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    Email_ID VARCHAR(100),
    Contact VARCHAR(20),
    Air_code CHAR(5),
    FOREIGN KEY (Air_code) REFERENCES Airport(Air_code)
);

CREATE TABLE Can_Land (
    Reg_no VARCHAR(20),
    Faa_no VARCHAR(20),
    Ssn VARCHAR(20),
    Date DATE,
    Hours INT,
    Score FLOAT,
    Air_code CHAR(5),
    Flight_ID INT,
    FOREIGN KEY (Air_code) REFERENCES Airport(Air_code),
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);

CREATE TABLE Transactions (
    TS_ID INT PRIMARY KEY,
    Booking_Date DATE,
    Departure_Date DATE,
    TS_Type VARCHAR(50),
    Emp_ID INT,
    Ps_ID INT,
    Flight_ID INT,
    Fare_ID INT,
    Charge_Amount DECIMAL(10, 2),
    FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID),
    FOREIGN KEY (Ps_ID) REFERENCES Passengers(Ps_ID),
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID),
    FOREIGN KEY (Fare_ID) REFERENCES Airfare(Fare_ID)
);

CREATE TABLE Travels_On (
    Route_ID INT,
    Flight_ID INT,
    PRIMARY KEY (Route_ID, Flight_ID),
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID),
    FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);

INSERT INTO Airplane_Type VALUES 
    (1, 180, 75000.5, 'Boeing'),
    (2, 150, 65000.0, 'Airbus');

INSERT INTO Route VALUES 
    (101, 'New York', 'London', 'International'),
    (102, 'Paris', 'Berlin', 'Regional');

INSERT INTO Flight VALUES 
    (1001, '08:30:00', '18:45:00', '2025-06-01', 1),
    (1002, '12:00:00', '15:00:00', '2025-06-02', 2);

INSERT INTO Airfare VALUES 
    (201, 500.00, 'Economy class', 1001),
    (202, 800.00, 'Business class', 1002);

INSERT INTO Passengers VALUES 
    (301, 'Alice Johnson', '123 Main St, NY', 30, 'F', '1234567890', 1001),
    (302, 'Bob Smith', '456 Park Ave, NY', 45, 'M', '0987654321', 1002);

INSERT INTO Countries VALUES 
    ('USA', 'United States'),
    ('UK', 'United Kingdom');

INSERT INTO Airport VALUES 
    ('JFK01', 'John F. Kennedy International Airport', 'New York', 'NY', 'USA'),
    ('LHR01', 'Heathrow Airport', 'London', 'England', 'UK');

INSERT INTO Employees VALUES 
    (401, 'Emma Brown', '789 Elm St, NY', 29, 'emma@example.com', '1112223333', 'JFK01'),
    (402, 'John Doe', '321 Oak St, London', 35, 'john@example.com', '9998887777', 'LHR01');

INSERT INTO Can_Land VALUES 
    ('R123', 'FAA567', 'SSN890', '2025-05-10', 1000, 85.5, 'JFK01', 1001);

INSERT INTO Transactions VALUES 
    (501, '2025-05-15', '2025-06-01', 'Online', 401, 301, 1001, 201, 500.00),
    (502, '2025-05-16', '2025-06-02', 'Agent', 402, 302, 1002, 202, 800.00);

INSERT INTO Travels_On VALUES 
    (101, 1001),
    (102, 1002);

SELECT P.Flight_ID, P.Ps_Name
FROM Passengers P
JOIN Flight F ON P.Flight_ID = F.Flight_ID
JOIN Airplane_Type A ON F.A_ID = A.A_ID
WHERE A.Company = 'Indigo';

SELECT F.Flight_ID, R.*
FROM Flight F
JOIN Travels_On T ON F.Flight_ID = T.Flight_ID
JOIN Route R ON T.Route_ID = R.Route_ID;

SELECT Emp_ID
FROM Employees
WHERE E_Name LIKE '%John%';

SELECT TS_Type, SUM(Charge_Amount) AS Total_Charge
FROM Transactions
WHERE Flight_ID = 1001
GROUP BY TS_Type;

SELECT Ps_Name
FROM Passengers
WHERE Flight_ID = 1001
ORDER BY Ps_Name;

SELECT DISTINCT A.Company
FROM Airplane_Type A
JOIN Flight F ON A.A_ID = F.A_ID
JOIN Can_Land CL ON F.Flight_ID = CL.Flight_ID
JOIN Airport AP ON CL.Air_code = AP.Air_code
WHERE AP.City = 'Mumbai';

SELECT C.Country_Name
FROM Countries C
JOIN Airport A ON C.Country_code = A.Country_code
GROUP BY C.Country_Name
HAVING COUNT(A.Air_code) > 1;

SELECT TS_Type, MAX(Charge_Amount) AS Max_Charge
FROM Transactions
GROUP BY TS_Type;

SELECT Fare_ID
FROM Airfare
WHERE Charge_Amount BETWEEN 20000 AND 35000;

SELECT TS_Type, AVG(Charge_Amount) AS Avg_Charge
FROM Transactions
GROUP BY TS_Type
HAVING AVG(Charge_Amount) > 20000;

UPDATE Airfare
SET Charge_Amount = Charge_Amount * 1.05
WHERE Description = 'Superex Return';

SELECT C.Country_Name
FROM Countries C
LEFT JOIN Airport A ON C.Country_code = A.Country_code
WHERE A.Country_code IS NULL;

SELECT C.Country_Name, A.Air_Name
FROM Countries C
LEFT JOIN Airport A ON C.Country_code = A.Country_code;

UPDATE Airfare
SET Charge_Amount = Charge_Amount * 1.05
WHERE Fare_ID = 201;

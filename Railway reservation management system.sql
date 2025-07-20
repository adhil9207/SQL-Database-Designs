CREATE DATABASE railway_reservation;
USE railway_reservation;

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(250),
    address VARCHAR(250),
    gender ENUM('M', 'F'),
    mobile_no BIGINT,
    salary INT
);

CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    passengers_name VARCHAR(250),
    seat_number INT,
    gender ENUM('M', 'F'),
    phone_no BIGINT,
    employee_id INT,
    reservation_status VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);


CREATE TABLE Station (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(20),
    number_of_lines INT,
    number_of_platforms INT
);

CREATE TABLE Train (
    train_id INT PRIMARY KEY,
    station_id INT,
    train_name VARCHAR(20),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE Ticket (
    ticket_no INT PRIMARY KEY,
    source VARCHAR(50),
    destination VARCHAR(50),
    class_id VARCHAR(20),
    fare INT,
    train_id INT,
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Fare (
    receipt_no INT PRIMARY KEY,
    train_id INT,
    source VARCHAR(50),
    destination VARCHAR(50),
    class VARCHAR(20),
    fare INT,
    ticket_no INT,
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (ticket_no) REFERENCES Ticket(ticket_no)
);

CREATE TABLE Class (
    class VARCHAR(20),
    journey_date DATE,
    no_of_seats INT,
    train_id INT,
    PRIMARY KEY (class, journey_date, train_id),
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

CREATE TABLE Time (
    ref_no INT PRIMARY KEY,
    dep_time TIME,
    arr_time TIME,
    train_id INT,
    station_id INT,
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE Train_Route (
    train_id INT,
    station_id INT,
    stop_no INT,
    arr_time TIME,
    dep_time TIME,
    PRIMARY KEY (train_id, stop_no),
    FOREIGN KEY (train_id) REFERENCES Train(train_id),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

INSERT INTO Employee VALUES
(1, 'Arun Kumar', 'Thiruvananthapuram', 'M', 9876543210, 40000),
(2, 'Lekshmi Nair', 'Kochi', 'F', 9876543211, 42000);

INSERT INTO Station VALUES
(101, 'Trivandrum', 5, 6),
(102, 'Ernakulam', 6, 8),
(103, 'Kozhikode', 4, 5),
(104, 'Thrissur', 3, 4);

INSERT INTO Train VALUES
(201, 101, 'KeralaExp'),
(202, 102, 'MalabarExp'),
(203, 103, 'MaveliExp');

INSERT INTO Passenger VALUES
(1001, 'Anu Joseph', 12, 'F', 9876500011, 1, 'Confirmed'),
(1002, 'Ramesh Menon', 25, 'M', 9876500012, 2, 'Waiting');

INSERT INTO Ticket VALUES
(3001, 'Trivandrum', 'Ernakulam', 'SL', 150, 201),
(3002, 'Kozhikode', 'Thrissur', 'AC2', 300, 202);

INSERT INTO Fare VALUES
(4001, 201, 'Trivandrum', 'Ernakulam', 'SL', 150, 3001),
(4002, 202, 'Kozhikode', 'Thrissur', 'AC2', 300, 3002);

INSERT INTO Class VALUES
('SL', '2025-06-10', 100, 201),
('AC2', '2025-06-10', 60, 202);

INSERT INTO Time VALUES
(5001, '06:00:00', '10:00:00', 201, 101),
(5002, '11:00:00', '15:00:00', 202, 103);

INSERT INTO Train_Route VALUES
(201, 101, 1, '06:00:00', '06:05:00'),
(201, 102, 2, '09:55:00', '10:00:00'),
(202, 103, 1, '11:00:00', '11:05:00'),
(202, 104, 2, '14:55:00', '15:00:00');


SELECT employee_name, gender AS male_employees, salary
FROM Employee
WHERE gender = 'M' AND salary < (
    SELECT MIN(salary)
    FROM Employee
    WHERE gender = 'F'
);

SELECT passengers_name AS passenger_name, gender, reservation_status, employee_id
FROM Passenger
WHERE employee_id = 2;


SELECT train_id, source, destination, class, fare
FROM Fare
WHERE source = 'Dallas' AND fare > 10;


SELECT train_id, source, destination, class, fare
FROM Fare
WHERE source = 'Dallas' AND fare = (
    SELECT MAX(fare)
    FROM Fare
    WHERE source = 'Dallas'
);

SELECT station_name, number_of_lines, number_of_platforms
FROM Station
WHERE number_of_lines >= 1 AND number_of_platforms >= 10;

SELECT train_id, train_name, station_id
FROM Train
WHERE station_id IS NOT NULL;

SELECT Class.train_id, Train.train_name, Class.class
FROM Class
INNER JOIN Train ON Class.train_id = Train.train_id;

SELECT Employee.employee_name, Employee.mobile_no, Employee.gender,
       Passenger.passengers_name, Passenger.reservation_status
FROM Employee
JOIN Passenger ON Employee.employee_id = Passenger.employee_id;

SELECT Employee.employee_name, Employee.mobile_no, Employee.gender,
       Passenger.passengers_name, Passenger.reservation_status
FROM Employee
JOIN Passenger ON Employee.employee_id = Passenger.employee_id
WHERE CAST(Employee.mobile_no AS CHAR) LIKE '4%1';

SELECT Train.station_id, Train.train_name, Class.class, Class.no_of_seats, Class.journey_date
FROM Train
JOIN Class ON Train.train_id = Class.train_id
WHERE Class.journey_date LIKE '2019-01%';

SELECT 
    Fare.receipt_no,
    Fare.train_id,
    Train.train_name,
    Fare.source,
    Fare.destination,
    Fare.class,
    Fare.fare,
    Fare.ticket_no,
    Time.dep_time,
    Time.arr_time
FROM Fare
JOIN Ticket ON Fare.ticket_no = Ticket.ticket_no
JOIN Time ON Time.train_id = Ticket.train_id
JOIN Train ON Ticket.train_id = Train.train_id;

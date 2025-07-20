CREATE DATABASE payroll_management_system;
USE payroll_management_system;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(255),
    user_password VARCHAR(255),
    user_type VARCHAR(255)
);

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(255)
);

CREATE TABLE grade (
    grade_id INT PRIMARY KEY,
    grade_name VARCHAR(255),
    grade_short_name VARCHAR(255),
    grade_basic INT,
    grade_ta INT,
    grade_da INT,
    grade_hra INT,
    grade_ma INT,
    grade_bonus INT,
    grade_pf INT,
    grade_pt INT
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_title VARCHAR(255),
    emp_name VARCHAR(255),
    emp_dob DATE,
    emp_doj DATE,
    emp_address VARCHAR(255),
    emp_city VARCHAR(255),
    emp_pincode INT,
    emp_mobile_no BIGINT,
    emp_state VARCHAR(255),
    emp_mail_id VARCHAR(255),
    emp_pan_no VARCHAR(255)
);

CREATE TABLE Employee_Grade_Details (
    transaction_id INT PRIMARY KEY,
    emp_id INT,
    emp_dept_id INT,
    emp_grade_id INT,
    emp_from_date DATE,
    emp_to_date VARCHAR(255),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (emp_dept_id) REFERENCES department(dept_id),
    FOREIGN KEY (emp_grade_id) REFERENCES grade(grade_id)
);

CREATE TABLE Employee_Salary_Details (
    transaction_id INT PRIMARY KEY,
    emp_id INT,
    emp_salary_month VARCHAR(255),
    emp_salary_year VARCHAR(255),
    emp_salary_eimbursment_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


INSERT INTO users (user_id, user_name, user_password, user_type) VALUES
(1, 'admin_kerala', 'admin123', 'admin'),
(2, 'hr_ernakulam', 'hr2025', 'hr'),
(3, 'user_trivandrum', 'user456', 'employee');

INSERT INTO department (dept_id, dept_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT Support'),
(4, 'Research and Development');

INSERT INTO grade (grade_id, grade_name, grade_short_name, grade_basic, grade_ta, grade_da, grade_hra, grade_ma, grade_bonus, grade_pf, grade_pt) VALUES
(1, 'Grade A', 'A', 30000, 3000, 4000, 5000, 1000, 2000, 3600, 200),
(2, 'Grade B', 'B', 25000, 2500, 3500, 4000, 900, 1800, 3000, 180),
(3, 'Grade C', 'C', 20000, 2000, 3000, 3500, 800, 1500, 2400, 150);

INSERT INTO Employee (emp_id, emp_title, emp_name, emp_dob, emp_doj, emp_address, emp_city, emp_pincode, emp_mobile_no, emp_state, emp_mail_id, emp_pan_no) VALUES
(101, 'Mr.', 'Arun Kumar', '1990-05-15', '2020-06-01', 'Kumar Bhavan, MG Road', 'Thiruvananthapuram', 695001, 9895011122, 'Kerala', 'arun.kumar@example.com', 'ABCDE1234F'),
(102, 'Ms.', 'Neethu Nair', '1992-08-20', '2021-07-15', 'Nair House, Kaloor', 'Ernakulam', 682017, 9846123456, 'Kerala', 'neethu.nair@example.com', 'AXYZE5678G'),
(103, 'Dr.', 'Vineeth Varma', '1988-02-10', '2019-04-10', 'Varma Villa, Kozhikode', 'Kozhikode', 673001, 9947000001, 'Kerala', 'vineeth.varma@example.com', 'PQRSX4321H');

INSERT INTO Employee_Grade_Details (transaction_id, emp_id, emp_dept_id, emp_grade_id, emp_from_date, emp_to_date) VALUES
(1, 101, 1, 1, '2020-06-01', '2025-05-17'),
(2, 102, 2, 2, '2021-07-15', '2025-05-17'),
(3, 103, 4, 3, '2019-04-10', '2025-05-17');

INSERT INTO Employee_Salary_Details (transaction_id, emp_id, emp_salary_month, emp_salary_year, emp_salary_eimbursment_date) VALUES
(1, 101, 'May', '2025', '2025-05-05 10:30:00'),
(2, 102, 'May', '2025', '2025-05-06 11:00:00'),
(3, 103, 'May', '2025', '2025-05-07 09:45:00');

SELECT 
    e.transaction_id,
    e.emp_from_date,
    g.grade_name,
    g.grade_short_name
FROM
    Employee_Grade_Details e
        JOIN
    grade g ON e.emp_grade_id = g.grade_id;

SELECT 
    s.emp_salary_month, s.emp_salary_year, e.emp_id, e.emp_name
FROM
    Employee_Salary_Details s
        JOIN
    Employee e ON s.emp_id = e.emp_id;

alter table users add column grade_id int;
alter table users add foreign key(grade_id) references grade (grade_id);
INSERT INTO users (user_id, user_name, user_password, user_type, grade_id)
VALUES (4, 'user_clt', 'user455', 'employee', 1);

show tables;

SELECT 
    u.user_id, u.user_name, g.grade_id, g.grade_name
FROM
    users u
        JOIN
    grade g ON u.grade_id = g.grade_id;

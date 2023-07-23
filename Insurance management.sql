CREATE DATABASE Insurance_Company;
USE Insurance_Company;

CREATE TABLE Customers(
	Cust_ID varchar(5) PRIMARY KEY,
    Name varchar(30),
    Address varchar(50),
    Phone_Num varchar(10),
    Email varchar(50) );
DESC Customers;

CREATE TABLE Policies(
	Policy_ID varchar(5) PRIMARY KEY,
    Cust_ID varchar(5),
    Type varchar(10),
    Prem_Amt float,
    Start_Date date,
    End_Date date,
    FOREIGN KEY(Cust_ID) REFERENCES Customers(Cust_ID) );
DESC Policies;

CREATE TABLE Claims(
	Claim_ID varchar(5) PRIMARY KEY,
    Policy_ID varchar(5),
    DateFiled date,
    DateofLoss date,
    Type varchar(10),
    Descrpt varchar(25),
    Amt_Paid float,
    FOREIGN KEY(Policy_ID) REFERENCES Policies(Policy_ID) );
DESC Claims;

CREATE TABLE Agents(
	Agent_ID varchar(5) PRIMARY KEY,
    Name varchar(30),
    Address varchar(50),
    Phone_Num varchar(10),
    Email varchar(50) );
DESC Agents;

CREATE TABLE Transactions(
	Trans_ID varchar(5) PRIMARY KEY,
    Policy_ID varchar(5),
    Agent_ID varchar(5),
    Trans_Date date,
    Type varchar(10),
    Amt float,
    FOREIGN KEY(Policy_ID) REFERENCES Policies(Policy_ID),
    FOREIGN KEY(Agent_ID) REFERENCES Agents(Agent_ID) );
DESC Transactions;

CREATE TABLE Departments(
	Depart_ID varchar(5) PRIMARY KEY,
    Name varchar(20) );
DESC Departments;

CREATE TABLE Employees(
	Emp_ID varchar(5) PRIMARY KEY,
    Depart_ID varchar(5),
    Name varchar(30),
    Address varchar(50),
    Phone_Num varchar(10),
    Email varchar(50),
    FOREIGN KEY(Depart_ID) REFERENCES Departments(Depart_ID) );
DESC Employees;

INSERT INTO Customers VALUES
	('C1001','Rahul Nair','B-121, Sunflower Valley','8806391201','rahulnam@gmail.com'),
    ('C1002','Mahesh Pandey','G-802, Marigold Avenue','9789056821','MP1345@gmail.com'),
    ('C1003','Preeti Singh','67, Cloud Nine Avenue','8554432107','PreetSg@gmail.com'),
    ('C1004','Amit Yadav','G567, Trent Towers','7654239911','AmYd@gmail.com');

INSERT INTO Policies VALUES
	('P1011','C1002','Auto',25000.00,'2001-08-21','2021-08-21'),
	('P1022','C1003','Life',75000.00,'2002-07-13','2032-07-13'),
	('P1033','C1001','Home',100000.00,'1999-04-05','2029-04-05'),
	('P1044','C1003','Health',35000.00,'2001-11-30','2041-11-30'),
	('P1055','C1004','Life',45000.00,'2004-09-03','2054-09-03');

INSERT INTO Claims VALUES
	('CL111','P1055','2015-08-02','2015-07-25','Life','Died due to Heart Attack',1200000.00),
    ('CL222','P1033','2005-01-08','2004-12-26','Home','Destroyed by Tsunami',3500000.00);
    
INSERT INTO Agents VALUES
	('A1101','Ajay Kumar','G-102, Gulmohar Park','9452331100','Ajay1234@gmail.com'),
    ('A2201','Aditya Rajput','H-304, Maharana Street','8755663214','AdRj5567@gmail.com'),
    ('A3301','Reeta Bhattacharya','45, Green Park','7507443321','ReetaB@gmail.com');
    
INSERT INTO Transactions VALUES
	('T1111','P1033','A2201','2003-02-27','Home',12000.00),
    ('T2212','P1022','A3301','2005-01-18','Life',35000.00),
    ('T3313','P1011','A1101','2006-03-14','Auto',500000.00),
    ('T4414','P1044','A2201','2004-07-20','Health',20000.00);
    
INSERT INTO Departments VALUES
	('DE101','Sales and Marketing'),
    ('DE202','Customer Service'),
    ('DE303','Human Resources'),
    ('DE404','IT'),
    ('DE505','Legal');
    
INSERT INTO Employees VALUES
	('EN101','DE505','Rajesh Nambiar','Bangalore','9876643225','RajNam@gmail.com'),
    ('EN202','DE303','Sakshi Jaiswal','Jaipur','8773214456','SakJ1256@gmail.com'),
    ('EN303','DE404','Arun Selvaraj','Chennai','7765422011','ArunS@gmail.com'),
    ('EN404','DE101','Kavya Mathur','Lucknow','8990322446','KM1789@gmail.com'),
    ('EN505','DE202','Pravin Chatterjee','Kolkata','8675532221','PrvChj@gmail.com'),
    ('EN606','DE303','Divya Reddy','Hyderabad','9952348810','DvRd1178@gmail.com');
    
#Display the details of the customers and their respective policies
SELECT C.Cust_ID, C.Name, P.Policy_ID, P.Type, P.Prem_Amt, 
P.Start_Date, P.End_Date
FROM Customers C
JOIN Policies P
ON C.Cust_ID = P.Cust_ID;

/*Display the minimum value, maximum value and average value 
of the premium amount*/
SELECT MIN(Prem_Amt) as MIN_VAL, MAX(Prem_Amt) as MAX_VAL,
AVG(Prem_Amt) as AVG_VAL 
FROM Policies;

#Display the details of the agents and their respective transactions
SELECT A.Agent_ID, A.Name, T.Trans_ID, T.Policy_ID, T.Trans_Date
FROM Agents A
JOIN Transactions T
ON A.Agent_ID = T.Agent_ID;

#Display the details of the employees and their departments
SELECT E.Emp_ID, E.Name, E.Depart_ID, D.Name
FROM Employees E
JOIN Departments D
ON E.Depart_ID = D.Depart_ID;

/*Display the details of the policies that have been started after
1st December 2000*/
SELECT * FROM Policies
WHERE Start_Date > '2000-12-01';

#Count the number of policies of each type
SELECT Type, COUNT(*) FROM Policies
GROUP BY Type;

#Add a column Nominee to the table Policies
ALTER TABLE Policies
ADD COLUMN Nominee varchar(30);
DESC Policies;

#Add a Nominee for the policy id P1044
UPDATE Policies
SET Nominee = 'Suhas Chauhan'
WHERE Policy_ID = 'P1044';
SELECT * FROM Policies;
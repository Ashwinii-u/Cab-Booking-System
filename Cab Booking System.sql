create database cb;
use cb;

CREATE TABLE Customers (
 CustomerID INT PRIMARY KEY,
 Name VARCHAR(100),
 Email VARCHAR(100),
 RegistrationDate DATE
);

CREATE TABLE Drivers (
 DriverID INT PRIMARY KEY,
 Name VARCHAR(100),
 JoinDate DATE
);

CREATE TABLE Cabs (
 CabID INT PRIMARY KEY,
 DriverID INT,
 VehicleType VARCHAR(20),
 PlateNumber VARCHAR(20),
 FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
 );

CREATE TABLE Bookings (
 BookingID INT PRIMARY KEY,
 CustomerID INT,
 CabID INT,
 BookingDate DATETIME,
 Status VARCHAR(20),
 PickupLocation VARCHAR(100),
 DropoffLocation VARCHAR(100),
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
 FOREIGN KEY (CabID) REFERENCES Cabs(CabID)
);

CREATE TABLE TripDetails (
 TripID INT PRIMARY KEY,
 BookingID INT,
 StartTime DATETIME,
 EndTime DATETIME,
 DistanceKM FLOAT,
 Fare FLOAT,
 FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

CREATE TABLE Feedback (
 FeedbackID INT PRIMARY KEY,
 BookingID INT,
 Rating FLOAT,
 Comments TEXT,
 FeedbackDate DATE,
 FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Customers (CustomerID, Name, Email, RegistrationDate) VALUES
(1, 'Alice Johnson', 'alice@example.com', '2023-01-15'),
(2, 'Bob Smith', 'bob@example.com', '2023-02-20'),
(3, 'Charlie Brown', 'charlie@example.com', '2023-03-05'),
(4, 'Diana Prince', 'diana@example.com', '2023-04-10');
select * from Customers;

INSERT INTO Drivers (DriverID, Name, JoinDate) VALUES
(101, 'John Driver', '2022-05-10'),
(102, 'Linda Miles', '2022-07-25'),
(103, 'Kevin Road', '2023-01-01'),
(104, 'Sandra Swift', '2022-11-11');
select * from Drivers;

INSERT INTO Cabs (CabID, DriverID, VehicleType, PlateNumber) VALUES
(1001, 101, 'Sedan', 'ABC1234'),
(1002, 102, 'SUV', 'XYZ5678'),
(1003, 103, 'Sedan', 'LMN8901'),
(1004, 104, 'SUV', 'PQR3456');
SELECT * FROM Cabs;

INSERT INTO Bookings (BookingID, CustomerID, CabID, BookingDate, Status, PickupLocation, DropoffLocation) VALUES
(201, 1, 1001, '2024-10-01 08:30:00', 'Completed', 'Downtown', 'Airport'),
(202, 2, 1002, '2024-10-02 09:00:00', 'Completed', 'Mall', 'University'),
(203, 3, 1003, '2024-10-03 10:15:00', 'Canceled', 'Station', 'Downtown'),
(204, 4, 1004, '2024-10-04 14:00:00', 'Completed', 'Suburbs', 'Downtown'),
(205, 1, 1002, '2024-10-05 18:45:00', 'Completed', 'Downtown', 'Airport'),
(206, 2, 1001, '2024-10-06 07:20:00', 'Canceled', 'University', 'Mall');
SELECT * FROM Bookings;

INSERT INTO TripDetails (TripID, BookingID, StartTime, EndTime, DistanceKM, Fare) VALUES
(301, 201, '2024-10-01 08:45:00', '2024-10-01 09:20:00', 18.5, 250.00),
(302, 202, '2024-10-02 09:10:00', '2024-10-02 09:40:00', 12.0, 180.00),
(303, 204, '2024-10-04 14:10:00', '2024-10-04 14:40:00', 10.0, 150.00),
(304, 205, '2024-10-05 18:50:00', '2024-10-05 19:30:00', 20.0, 270.00);
SELECT * FROM TripDetails;

INSERT INTO Feedback (FeedbackID, BookingID, Rating, Comments, FeedbackDate) VALUES
(401, 201, 4.5, 'Smooth ride', '2024-10-01'),
(402, 202, 3.0, 'Driver was late', '2024-10-02'),
(403, 204, 5.0, 'Excellent service', '2024-10-04'),
(404, 205, 2.5, 'Cab was not clean', '2024-10-05');
SELECT * FROM Feedback;

SELECT * FROM Cabs WHERE VehicleType = 'Sedan';

SELECT * FROM Bookings WHERE Status = 'Completed';

SELECT MAX(Fare) FROM TripDetails;

SELECT Status, COUNT(*) FROM Bookings GROUP BY Status;

SELECT * FROM Customers WHERE Name LIKE 'A%';

SELECT * FROM TripDetails WHERE Fare > (SELECT AVG(Fare) FROM TripDetails);

SELECT * FROM Cabs WHERE CabID = (SELECT CabID FROM Bookings GROUP BY CabID ORDER BY COUNT(*) DESC LIMIT 1);

SELECT * FROM TripDetails WHERE DistanceKM = (SELECT MAX(DistanceKM) FROM TripDetails);

SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM Bookings WHERE BookingID IN (SELECT BookingID FROM Feedback));

SELECT Name FROM Customers WHERE CustomerID IN (SELECT CustomerID FROM Bookings WHERE BookingID IN (  
    SELECT BookingID FROM Feedback WHERE Rating < 3));   
    
SELECT c.Name, b.BookingDate, b.Status  
FROM Customers c  
INNER JOIN Bookings b ON c.CustomerID = b.CustomerID;  

SELECT c.Name, b.BookingDate  
FROM Customers c  
RIGHT JOIN Bookings b ON c.CustomerID = b.CustomerID;

SELECT f.Rating, b.Status  
FROM Feedback f  
CROSS JOIN Bookings b;

SELECT b1.BookingID AS B1, b2.BookingID AS B2, b1.CabID  
FROM Bookings b1  
JOIN Bookings b2 ON b1.CabID = b2.CabID AND b1.CustomerID <> b2.CustomerID;  

SELECT d.DriverID, d.Name, c.CabID  
FROM Drivers d  
LEFT JOIN Cabs c ON d.DriverID = c.DriverID  
UNION  
SELECT d.DriverID, d.Name, c.CabID  
FROM Drivers d  
RIGHT JOIN Cabs c ON d.DriverID = c.DriverID;

CREATE VIEW View_CustomerBookings AS  
SELECT c.Name, b.BookingID, b.BookingDate, b.Status  
FROM Customers c  
JOIN Bookings b ON c.CustomerID = b.CustomerID; 
Select * from View_CustomerBookings;

CREATE VIEW View_TripSummary AS  
SELECT TripID, DistanceKM, Fare,  
  (Fare / DistanceKM) AS FarePerKM  
FROM TripDetails; 
SELECT * FROM View_TripSummary; 

CREATE VIEW View_AverageFarePerKM AS  
SELECT AVG(Fare / NULLIF(DistanceKM, 0)) AS AvgFarePerKM  
FROM TripDetails; 
SELECT * FROM View_AverageFarePerKM;

CREATE VIEW View_CabUtilization AS  
SELECT c.CabID, COUNT(t.TripID) AS TotalTrips, SUM(t.Fare) AS TotalEarnings  
FROM Cabs c  
LEFT JOIN Bookings b ON c.CabID = b.CabID  
LEFT JOIN TripDetails t ON b.BookingID = t.BookingID  
GROUP BY c.CabID;
SELECT * FROM View_CabUtilization;
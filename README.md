## Cab Booking System
# Project Title
# Cab Booking System

# Objective
The Cab Booking System project simulates a real-world ride-hailing platform through the design and implementation of a relational database using SQL. The system models core components such as customers, drivers, cabs, bookings, trips, and feedback. It supports structured data storage, querying, and insightful analysis to enhance operational efficiency and user engagement.

## Dataset Description
# Source:
The dataset is custom-created with realistic sample data to replicate real-life cab booking scenarios.

# Structure & Tables:

Customers – Customer profile information

Drivers – Driver details and identifiers

Cabs – Vehicles and types (e.g., Sedan)

Bookings – Booking records with status

Trip Details – Trip distance, duration, and fare

Feedback – Customer ratings and comments

All tables include appropriate keys and relationships for normalized relational modeling.

# Tech Stack
Database Systems: MySQL 

Query Language: SQL (DDL, DML, DQL)

Optional Tools: MySQL Workbench for query execution and visualization

How to Run
Install and configure a relational database (MySQL).

Run the DDL scripts to create tables and relationships.

Insert sample data using DML scripts.

Execute queries and views to analyze the system.

# Project Highlights
# Key Queries:

Show all bookings with status 'Completed'

Retrieve all cabs of type 'Sedan'

Get the trip with the highest fare

Count bookings by each status

List customers whose names start with 'A'

Identify customers who gave a rating less than 3

List customers who never provided feedback

Find bookings with a fare above the average

# Joins and Subqueries:

Customer details with their bookings

All bookings with corresponding customer information

Cabs shared by different customers

Drivers with or without cab assignments (outer joins)

# Views Created:

View_CustomerBookings – Customers and their bookings

View_TripSummary – Aggregated fare and distance per trip

View_CabUtilization – Total earnings and trip count per cab

View_AverageFarePerKM – Efficiency measured by fare per kilometer

# Insights Gained:

Understanding of customer behavior, including preferences and feedback patterns

Identification of high and low utilization among cabs and drivers

Recognition of trips contributing to high revenue

Booking trends based on status and cab reusability

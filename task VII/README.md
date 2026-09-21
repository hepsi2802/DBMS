CREATE DATABASE ECommerce;
USE ECommerce;
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50)
);
CREATE TABLE Supplier (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    Contact_Number VARCHAR(15),
    City VARCHAR(50)
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category_ID INT,
    Supplier_ID INT,
    Price DECIMAL(10,2),
    Quantity INT,
    Availability VARCHAR(20),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Payment_Method VARCHAR(30),
    Payment_Status VARCHAR(30),
    Payment_Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Shipment (
    Shipment_ID INT PRIMARY KEY,
    Order_ID INT,
    Shipment_Date DATE,
    Delivery_Date DATE,
    Shipment_Status VARCHAR(30),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Review (
    Review_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Rating INT,
    Review_Text VARCHAR(200),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

INSERT INTO Customer VALUES
(1, 'Hepsi', 'hepsi@gmail.com', '9876543210', 'Chennai'),
(2, 'Priya', 'priya@gmail.com', '9876543211', 'Bangalore'),
(3, 'Alax', 'alax@gmail.com', '9876543212', 'Madurai'),
(4, 'Divya', 'divya@gmail.com', '9876543213', 'Chennai'),
(5, 'Danny', 'danny@gmail.com', '9876543214', 'Coimbatore');

INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances');

INSERT INTO Supplier VALUES
(101, 'ABC Suppliers', '9000000001', 'Chennai'),
(102, 'XYZ Traders', '9000000002', 'Bangalore'),
(103, 'Global Products', '9000000003', 'Mumbai'),
(104, 'Smart Suppliers', '9000000004', 'Coimbatore');

INSERT INTO Product VALUES
(201, 'Laptop', 1, 101, 55000, 10, 'Available'),
(202, 'Mobile Phone', 1, 102, 25000, 20, 'Available'),
(203, 'T-Shirt', 2, 103, 799, 50, 'Available'),
(204, 'Jeans', 2, 103, 1499, 0, 'Out of Stock'),
(205, 'Python Book', 3, 104, 599, 25, 'Available'),
(206, 'SQL Book', 3, 104, 499, 30, 'Available'),
(207, 'Microwave', 4, 101, 8500, 8, 'Available'),
(208, 'Air Conditioner', 4, 102, 35000, 0, 'Out of Stock');

INSERT INTO Orders VALUES
(301, 1, '2026-09-01', 55000),
(302, 2, '2026-09-03', 25000),
(303, 3, '2026-09-05', 1598),
(304, 1, '2026-09-10', 8500),
(305, 4, '2026-09-12', 499);

INSERT INTO Payment VALUES
(401, 301, 'UPI', 'Paid', 55000),
(402, 302, 'Credit Card', 'Paid', 25000),
(403, 303, 'Cash on Delivery', 'Pending', 1598),
(404, 304, 'UPI', 'Paid', 8500),
(405, 305, 'Debit Card', 'Paid', 499);

INSERT INTO Shipment VALUES
(501, 301, '2026-09-02', '2026-09-05', 'Delivered'),
(502, 302, '2026-09-04', '2026-09-07', 'Delivered'),
(503, 303, '2026-09-06', '2026-09-09', 'Delivered'),
(504, 304, '2026-09-11', NULL, 'Shipped'),
(505, 305, '2026-09-13', NULL, 'Processing');

INSERT INTO Review VALUES
(601, 1, 201, 5, 'Excellent laptop'),
(602, 2, 202, 4, 'Good phone'),
(603, 3, 203, 5, 'Good quality'),
(604, 4, 206, 4, 'Useful book'),
(605, 5, 207, 3, 'Average product');


SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Category;

SELECT * FROM Supplier;

SELECT * FROM Orders;

SELECT * FROM Payment;

SELECT * FROM Shipment;

SELECT * FROM Review;

SELECT Product_Name, Price
FROM Product;

SELECT Customer_Name, Email, City
FROM Customer;

SELECT Product_Name, Price
FROM Product
WHERE Price < 10000;

SELECT Product_Name, Price
FROM Product
WHERE Price BETWEEN 500 AND 5000;

SELECT Product_Name, Price, Availability
FROM Product
WHERE Availability = 'Available';

SELECT Product_Name, Price
FROM Product
WHERE Category_ID = 1;

SELECT Product_Name, Price
FROM Product
ORDER BY Price ASC;

SELECT Product_Name, Price
FROM Product
ORDER BY Price DESC;

SELECT DISTINCT City
FROM Customer;

SELECT DISTINCT Payment_Method
FROM Payment;

SELECT *
FROM Product
WHERE Quantity > 0
AND Price < 30000;

SELECT *
FROM Product
WHERE Availability = 'Available'
AND Price > 1000;

SELECT
    Customer_Name,
    Email,
    City
FROM Customer
WHERE City = 'Chennai';

SELECT
    Customer_Name,
    Email,
    Phone
FROM Customer
ORDER BY Customer_Name ASC;

SELECT
    p.Product_Name,
    p.Price,
    p.Quantity,
    c.Category_Name
FROM Product p
JOIN Category c
ON p.Category_ID = c.Category_ID;

SELECT
    p.Product_Name,
    p.Price,
    s.Supplier_Name
FROM Product p
JOIN Supplier s
ON p.Supplier_ID = s.Supplier_ID;

SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount
FROM Customer c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID;

SELECT
    o.Order_ID,
    c.Customer_Name,
    p.Payment_Method,
    p.Payment_Status,
    p.Payment_Amount
FROM Orders o
JOIN Customer c
ON o.Customer_ID = c.Customer_ID
JOIN Payment p
ON o.Order_ID = p.Order_ID;

SELECT
    o.Order_ID,
    c.Customer_Name,
    s.Shipment_Status,
    s.Shipment_Date,
    s.Delivery_Date
FROM Orders o
JOIN Customer c
ON o.Customer_ID = c.Customer_ID
JOIN Shipment s
ON o.Order_ID = s.Order_ID;

SELECT
    c.Customer_Name,
    r.Rating,
    r.Review_Text
FROM Customer c
JOIN Review r
ON c.Customer_ID = r.Customer_ID;

SELECT
    p.Product_Name,
    r.Rating,
    r.Review_Text
FROM Product p
JOIN Review r
ON p.Product_ID = r.Product_ID;

SELECT
    SUM(Total_Amount) AS Total_Sales
FROM Orders;

SELECT
    AVG(Total_Amount) AS Average_Order_Value
FROM Orders;

SELECT
    MAX(Total_Amount) AS Highest_Order_Value
FROM Orders;

SELECT
    MIN(Total_Amount) AS Lowest_Order_Value
FROM Orders;

SELECT
    COUNT(*) AS Total_Customers
FROM Customer;

SELECT
    COUNT(*) AS Total_Products
FROM Product;

SELECT
    COUNT(*) AS Total_Orders
FROM Orders;

SELECT
    Category_ID,
    COUNT(*) AS Number_Of_Products
FROM Product
GROUP BY Category_ID;

SELECT
    Availability,
    COUNT(*) AS Number_Of_Products
FROM Product
GROUP BY Availability;

SELECT
    Payment_Status,
    COUNT(*) AS Number_Of_Payments
FROM Payment
GROUP BY Payment_Status;

SELECT
    Shipment_Status,
    COUNT(*) AS Number_Of_Shipments
FROM Shipment
GROUP BY Shipment_Status;

SELECT
    c.Customer_Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM Customer c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Spent DESC;

<img width="1197" height="876" alt="WhatsApp Image 2026-09-21 at 8 48 46 PM" src="https://github.com/user-attachments/assets/3510f889-df1b-4212-bc4d-1694930adc43" />
<img width="1191" height="925" alt="WhatsApp Image 2026-09-21 at 8 48 33 PM" src="https://github.com/user-attachments/assets/747bcd41-4fc9-40c5-8c5c-c669084743d8" />
<img width="1185" height="877" alt="WhatsApp Image 2026-09-21 at 8 48 21 PM" src="https://github.com/user-attachments/assets/f0d4f47e-0a2f-4a58-ad26-964da21006b5" />
<img width="1192" height="876" alt="WhatsApp Image 2026-09-21 at 8 47 18 PM" src="https://github.com/user-attachments/assets/39f0e071-d3d2-4356-960c-97dc2ea6b314" />
<img width="1202" height="880" alt="WhatsApp Image 2026-09-21 at 8 47 33 PM" src="https://github.com/user-attachments/assets/24490d98-4a39-47c4-97b4-16fcfc04f3e6" />
<img width="1197" height="877" alt="WhatsApp Image 2026-09-21 at 8 47 47 PM" src="https://github.com/user-attachments/assets/c7125252-f31e-4f6b-a6f2-8a38b2f9982c" />
<img width="1207" height="952" alt="WhatsApp Image 2026-09-21 at 8 47 02 PM" src="https://github.com/user-attachments/assets/5c1ecc12-1368-4f7b-94c5-eba7a5173f1c" />
<img width="1285" height="952" alt="WhatsApp Image 2026-09-21 at 8 46 35 PM" src="https://github.com/user-attachments/assets/8593d177-04c2-4a21-b812-ceae10133993" />
<img width="1287" height="887" alt="WhatsApp Image 2026-09-21 at 8 46 17 PM" src="https://github.com/user-attachments/assets/f0a52646-d71f-487e-baaf-a9573fd7419d" />
<img width="1282" height="876" alt="WhatsApp Image 2026-09-21 at 8 45 57 PM" src="https://github.com/user-attachments/assets/557e40be-5bd9-446a-810d-2611c41cc466" />
<img width="1277" height="880" alt="WhatsApp Image 2026-09-21 at 8 45 39 PM" src="https://github.com/user-attachments/assets/fe160bac-4739-4e16-8371-48366307b14e" />
<img width="1291" height="845" alt="WhatsApp Image 2026-09-21 at 8 45 19 PM" src="https://github.com/user-attachments/assets/ac5216ba-2809-480c-8a43-bb473ecc2125" />
<img width="1276" height="851" alt="WhatsApp Image 2026-09-21 at 8 40 58 PM" src="https://github.com/user-attachments/assets/e81d4265-00c1-4961-b73f-14a50271c2dc" />














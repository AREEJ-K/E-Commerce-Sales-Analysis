USE EcommerceAnalysis;
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
GO

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Wireless Mouse', 'Accessories', 75.00),
(2, 'Keyboard', 'Accessories', 120.00),
(3, 'Headphones', 'Audio', 250.00),
(4, 'Laptop Stand', 'Accessories', 180.00),
(5, 'Webcam', 'Electronics', 220.00);
GO

SELECT * 
FROM Products;

SELECT ProductName, Price
FROM Products;

SELECT ProductName, Price
FROM Products
WHERE Price > 100;

SELECT ProductName, Price
FROM Products
ORDER BY Price DESC;

SELECT COUNT(*) AS NumberOfProducts
FROM Products;

SELECT AVG(Price) AS AveragePrice
FROM Products;

SELECT MAX(Price) AS HighestPrice
FROM Products;

SELECT Category, COUNT(*) AS NumberOfProducts
FROM Products
GROUP BY Category;

SELECT SUM(Price) AS TotalPrice
FROM Products;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);
GO

INSERT INTO Customers (CustomerID, CustomerName, Email, City)
VALUES
(1, 'Aisha', 'aisha@email.com', 'Riyadh'),
(2, 'Sara', 'sara@email.com', 'Dammam'),
(3, 'Nora', 'nora@email.com', 'Jeddah'),
(4, 'Reem', 'reem@email.com', 'Khobar'),
(5, 'Lama', 'lama@email.com', 'Riyadh');
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

USE EcommerceAnalysis;
GO

SELECT *
FROM Customers;

SELECT *
FROM Orders;

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
(101, 1, '2025-01-10'),
(102, 2, '2025-01-15'),
(103, 1, '2025-02-02'),
(104, 3, '2025-02-10'),
(105, 4, '2025-02-15');
GO


CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO


INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 101, 1, 2, 75.00),
(2, 101, 2, 1, 120.00),
(3, 102, 3, 1, 250.00),
(4, 103, 4, 1, 180.00),
(5, 103, 1, 1, 75.00),
(6, 104, 5, 2, 220.00),
(7, 105, 2, 1, 120.00);
GO

SELECT *
FROM OrderItems;

SELECT
    Orders.OrderID,
    Customers.CustomerName,
    Orders.OrderDate
FROM Orders
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID;

    SELECT
    Orders.OrderID,
    Customers.CustomerName,
    Products.ProductName,
    OrderItems.Quantity,
    OrderItems.UnitPrice,
    OrderItems.Quantity * OrderItems.UnitPrice AS Total
FROM Orders
JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
JOIN Products
    ON OrderItems.ProductID = Products.ProductID;

    SELECT
    Customers.CustomerName,
    SUM(OrderItems.Quantity * OrderItems.UnitPrice) AS TotalSpent
FROM Customers
JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
GROUP BY Customers.CustomerName
ORDER BY TotalSpent DESC;

SELECT
    Products.ProductName,
    SUM(OrderItems.Quantity) AS TotalQuantitySold
FROM Products
JOIN OrderItems
    ON Products.ProductID = OrderItems.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantitySold DESC;

SELECT
    SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderItems;

SELECT
    Products.Category,
    SUM(OrderItems.Quantity * OrderItems.UnitPrice) AS CategorySales
FROM Products
JOIN OrderItems
    ON Products.ProductID = OrderItems.ProductID
GROUP BY Products.Category
ORDER BY CategorySales DESC;

SELECT
    FORMAT(Orders.OrderDate, 'yyyy-MM') AS SalesMonth,
    SUM(OrderItems.Quantity * OrderItems.UnitPrice) AS MonthlySales
FROM Orders
JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID
GROUP BY FORMAT(Orders.OrderDate, 'yyyy-MM')
ORDER BY SalesMonth;




-- Creating a helper table

SELECT TOP (1000000)
ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number
INTO Numbers
FROM sys.all_objects a
CROSS JOIN sys.all_objects b;

SELECT COUNT(*) AS TotalRows FROM Numbers;

--Inserting small Dimension data first

 -- Countries
INSERT INTO Countries
SELECT TOP (10)
Number,
CONCAT('Country_',Number),
GETDATE()
FROM Numbers;

-- Regions
INSERT INTO Regions
SELECT TOP (25)
Number,
CONCAT('Region_',Number),
(Number%10)+1,
GETDATE()
FROM Numbers;

-- Categories
INSERT INTO Categories
SELECT TOP (50)
Number,
CONCAT('Category_',Number),
GETDATE()
FROM Numbers;

-- Departments
INSERT INTO Departments
SELECT TOP (20)
Number,
CONCAT('Department_',Number),
GETDATE()
FROM Numbers;

-- Suppliers
INSERT INTO Suppliers
SELECT TOP (1000)
Number,
CONCAT('Supplier_',Number),
'India',
GETDATE()
FROM Numbers;

-- Stores
INSERT INTO Stores
SELECT TOP (1000)
Number,
CONCAT('Store_',Number),
CHOOSE(Number%5+1,'Bangalore','Delhi','Mumbai','Kolkata','Hyderabad'),
CHOOSE(Number%5+1,'Karnataka','Delhi','Maharashtra','West Bengal','Telangana'),
(Number%25)+1,
GETDATE()
FROM Numbers;

 SELECT COUNT(*) AS Countries FROM Countries;
SELECT COUNT(*) AS Regions FROM Regions;
SELECT COUNT(*) AS Categories FROM Categories;
SELECT COUNT(*) AS Stores FROM Stores;
SELECT COUNT(*) AS Suppliers FROM Suppliers;


INSERT INTO Customers
SELECT TOP (250000)
    Number AS CustomerID,
    CONCAT('Customer_', Number) AS CustomerName,
    CONCAT('customer', Number, '@gmail.com') AS Email,
    CONCAT('98', RIGHT('00000000' + CAST(Number AS VARCHAR(8)), 8)) AS Phone,
    CASE Number % 5
        WHEN 0 THEN 'Bangalore'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Mumbai'
        WHEN 3 THEN 'Kolkata'
        ELSE 'Hyderabad'
    END AS City,
    CASE Number % 5
        WHEN 0 THEN 'Karnataka'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Maharashtra'
        WHEN 3 THEN 'West Bengal'
        ELSE 'Telangana'
    END AS State,
    DATEADD(DAY, -(Number % 1000), GETDATE()) AS CreatedDate,
    GETDATE() AS LastModifiedDate
FROM Numbers
ORDER BY Number;

SELECT COUNT(*) AS Customers FROM Customers;

USE RetailDW;
GO

-- Products
INSERT INTO Products
SELECT TOP (50000)
    Number,
    CONCAT('Product_', Number),
    (Number % 50) + 1,
    (Number % 1000) + 1,
    CAST(100 + (Number % 4900) AS DECIMAL(10,2)),
    CONCAT('Brand_', Number % 100),
    GETDATE()
FROM Numbers
ORDER BY Number;


-- Employees
INSERT INTO Employees
SELECT TOP (20000)
    Number,
    CONCAT('Employee_', Number),
    (Number % 20) + 1,
    (Number % 1000) + 1,
    CAST(25000 + (Number % 90000) AS DECIMAL(10,2)),
    DATEADD(DAY, -(Number % 2000), GETDATE()),
    GETDATE()
FROM Numbers
ORDER BY Number;


-- Vendors
INSERT INTO Vendors
SELECT TOP (15000)
    Number,
    CONCAT('Vendor_', Number),
    CASE Number % 5
        WHEN 0 THEN 'Bangalore'
        WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Mumbai'
        WHEN 3 THEN 'Pune'
        ELSE 'Chennai'
    END,
    GETDATE()
FROM Numbers
ORDER BY Number;

USE RetailDW;
GO

DECLARE @Start INT = 1;
DECLARE @End INT = 100000;

WHILE @Start <= 1000000
BEGIN

    INSERT INTO Orders
    (
        OrderID,
        CustomerID,
        StoreID,
        OrderDate,
        TotalAmount,
        PaymentMethod,
        Status,
        LastModifiedDate
    )
    SELECT
        Number,
        (Number % 250000) + 1,
        (Number % 1000) + 1,
        DATEADD(DAY, -(Number % 730), GETDATE()),
        CAST(100 + (Number % 4900) AS DECIMAL(10,2)),
        CASE Number % 4
            WHEN 0 THEN 'UPI'
            WHEN 1 THEN 'Card'
            WHEN 2 THEN 'Cash'
            ELSE 'NetBanking'
        END,
        CASE Number % 3
            WHEN 0 THEN 'Delivered'
            WHEN 1 THEN 'Pending'
            ELSE 'Cancelled'
        END,
        GETDATE()
    FROM Numbers
    WHERE Number BETWEEN @Start AND @End;

    PRINT CONCAT('Inserted Orders: ', @Start, ' - ', @End);

    SET @Start = @Start + 100000;
    SET @End = @End + 100000;
END;

select * from Orders;

USE RetailDW;
GO

DECLARE @Start BIGINT = 1;
DECLARE @End BIGINT = 100000;

WHILE @Start <= 1000000
BEGIN

    INSERT INTO OrderItems
    (
        OrderItemID,
        OrderID,
        ProductID,
        Quantity,
        UnitPrice,
        Discount,
        LastModifiedDate
    )
    SELECT
        Number,
        ((Number - 1) % 1000000) + 1,
        ((Number - 1) % 50000) + 1,
        (Number % 5) + 1,
        CAST(100 + (Number % 2900) AS DECIMAL(10,2)),
        CAST(Number % 30 AS DECIMAL(5,2)),
        GETDATE()
    FROM Numbers
    WHERE Number BETWEEN @Start AND @End;

    PRINT CONCAT('Inserted OrderItems: ', @Start, ' - ', @End);

    SET @Start = @Start + 100000;
    SET @End = @End + 100000;
END;

select * from OrderItems;

EXEC sp_spaceused;

USE RetailDW;
GO





SELECT * FROM Sales;

EXEC sp_spaceused 'Sales';

--uing select into because insert into was taking to much time
SELECT
    n.Number AS SaleID,
    n.Number AS OrderID,
    (n.Number % 50000) + 1 AS ProductID,
    (n.Number % 1000) + 1 AS StoreID,
    CAST(100 + (n.Number % 9900) AS DECIMAL(10,2)) AS SaleAmount,
    DATEADD(DAY, -(n.Number % 730), GETDATE()) AS SaleDate,
    GETDATE() AS LastModifiedDate
INTO Sales
FROM Numbers n
WHERE n.Number <= 250000;

--using select into because insert into was taking to much time
SELECT
    n.Number AS PaymentID,
    n.Number AS OrderID,
    CASE n.Number % 4
        WHEN 0 THEN 'UPI'
        WHEN 1 THEN 'Card'
        WHEN 2 THEN 'Cash'
        ELSE 'NetBanking'
    END AS PaymentType,
    CAST(100 + (n.Number % 4900) AS DECIMAL(10,2)) AS PaymentAmount,
    CASE n.Number % 3
        WHEN 0 THEN 'Success'
        WHEN 1 THEN 'Success'
        ELSE 'Failed'
    END AS PaymentStatus,
    DATEADD(DAY, -(n.Number % 730), GETDATE()) AS PaymentDate,
    GETDATE() AS LastModifiedDate
INTO Payments
FROM Numbers n
WHERE n.Number <= 250000;



-- DROP TABLE Shipment;

SELECT
    n.Number AS ShipmentID,
    n.Number AS OrderID,
    CASE n.Number % 4
        WHEN 0 THEN 'BlueDart'
        WHEN 1 THEN 'Delhivery'
        WHEN 2 THEN 'Ecom Express'
        ELSE 'DTDC'
    END AS Courier,
    CASE n.Number % 4
        WHEN 0 THEN 'Delivered'
        WHEN 1 THEN 'Shipped'
        WHEN 2 THEN 'In Transit'
        ELSE 'Pending'
    END AS ShipmentStatus,
    DATEADD(DAY, (n.Number % 10), GETDATE()) AS DeliveryDate,
    GETDATE() AS LastModifiedDate
INTO Shipment
FROM Numbers n
WHERE n.Number <= 250000;

--DROP TABLE Returns;

SELECT
    n.Number AS ReturnID,
    n.Number AS OrderID,
    (n.Number % 50000) + 1 AS ProductID,
    CASE n.Number % 4
        WHEN 0 THEN 'Damaged'
        WHEN 1 THEN 'Wrong Product'
        WHEN 2 THEN 'Size Issue'
        ELSE 'No Longer Needed'
    END AS ReturnReason,
    DATEADD(DAY, -(n.Number % 100), GETDATE()) AS ReturnDate,
    CAST(50 + (n.Number % 3000) AS DECIMAL(10,2)) AS RefundAmount,
    GETDATE() AS LastModifiedDate
INTO Returns
FROM Numbers n

--DROP TABLE Reviews;

SELECT
    n.Number AS ReviewID,
    (n.Number % 250000) + 1 AS CustomerID,
    (n.Number % 50000) + 1 AS ProductID,
    (n.Number % 5) + 1 AS Rating,
    CONCAT('Review for product ', n.Number) AS ReviewText,
    DATEADD(DAY, -(n.Number % 365), GETDATE()) AS ReviewDate,
    GETDATE() AS LastModifiedDate
INTO Reviews
FROM Numbers n
WHERE n.Number <= 250000;


 DROP TABLE Coupons;

SELECT
    n.Number AS CouponID,
    (n.Number % 250000) + 1 AS CustomerID,
    CONCAT('SAVE', n.Number) AS CouponCode,
    (n.Number % 100) + 1 AS DiscountID,
    DATEADD(DAY, -(n.Number % 180), GETDATE()) AS UsedDate,
    GETDATE() AS LastModifiedDate
INTO Coupons
FROM Numbers n
WHERE n.Number <= 250000;

 USE RetailDW;
GO

-- Drop the empty Inventory table (only if it's empty)
DROP TABLE Inventory;
GO

-- Create and populate Inventory with 250,000 rows
SELECT
    n.Number AS InventoryID,
    (n.Number % 50000) + 1 AS ProductID,
    (n.Number % 1000) + 1 AS StoreID,
    (n.Number % 500) + 1 AS QuantityAvailable,
    DATEADD(DAY, -(n.Number % 90), GETDATE()) AS LastRestocked,
    GETDATE() AS LastModifiedDate
INTO Inventory
FROM Numbers AS n
WHERE n.Number <= 250000;

 SELECT
 (SELECT COUNT(*) FROM Customers) AS Customers,
 (SELECT COUNT(*) FROM Products) AS Products,
 (SELECT COUNT(*) FROM Orders) AS Orders,
 (SELECT COUNT(*) FROM OrderItems) AS OrderItems,
 (SELECT COUNT(*) FROM Sales) AS Sales,
 (SELECT COUNT(*) FROM Payments) AS Payments,
 (SELECT COUNT(*) FROM Inventory) AS Inventory,
 (SELECT COUNT(*) FROM Shipment) AS Shipment,
 (SELECT COUNT(*) FROM Returns) AS Returns,
 (SELECT COUNT(*) FROM Reviews) AS Reviews,
 (SELECT COUNT(*) FROM Coupons) AS Coupons;
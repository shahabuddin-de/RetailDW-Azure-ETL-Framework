--CREATE DATABASE RetailDW;
--go


USE RetailDW;
GO


-- Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    CreatedDate DATETIME,
    LastModifiedDate DATETIME
);

-- Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150),
    CategoryID INT,
    SupplierID INT,
    Price DECIMAL(10,2),
    Brand VARCHAR(50),
    LastModifiedDate DATETIME
);

-- Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100),
    LastModifiedDate DATETIME
);

-- Orders
CREATE TABLE Orders (
    OrderID BIGINT PRIMARY KEY,
    CustomerID INT,
    StoreID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(20),
    Status VARCHAR(20),
    LastModifiedDate DATETIME
);

-- OrderItems
CREATE TABLE OrderItems (
    OrderItemID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    LastModifiedDate DATETIME
);



-- Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    Country VARCHAR(50),
    LastModifiedDate DATETIME
);

-- Stores
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    RegionID INT,
    LastModifiedDate DATETIME
);

-- Regions
CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50),
    CountryID INT,
    LastModifiedDate DATETIME
);

-- Countries
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50),
    LastModifiedDate DATETIME
);

-- Inventory
CREATE TABLE Inventory (
    InventoryID BIGINT PRIMARY KEY,
    ProductID INT,
    StoreID INT,
    QuantityAvailable INT,
    LastRestocked DATETIME,
    LastModifiedDate DATETIME
);

-- Sales
CREATE TABLE Sales (
    SaleID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    ProductID INT,
    StoreID INT,
    SaleAmount DECIMAL(10,2),
    SaleDate DATETIME,
    LastModifiedDate DATETIME
);

-- Payments
CREATE TABLE Payments (
    PaymentID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    PaymentType VARCHAR(20),
    PaymentAmount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    PaymentDate DATETIME,
    LastModifiedDate DATETIME
);

-- Shipment
CREATE TABLE Shipment (
    ShipmentID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    Courier VARCHAR(50),
    ShipmentStatus VARCHAR(30),
    DeliveryDate DATETIME,
    LastModifiedDate DATETIME
);

-- Returns
CREATE TABLE Returns (
    ReturnID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    ProductID INT,
    ReturnReason VARCHAR(100),
    ReturnDate DATETIME,
    RefundAmount DECIMAL(10,2),
    LastModifiedDate DATETIME
);

-- Reviews
CREATE TABLE Reviews (
    ReviewID BIGINT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT,
    ReviewText VARCHAR(200),
    ReviewDate DATETIME,
    LastModifiedDate DATETIME
);

-- Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    StoreID INT,
    Salary DECIMAL(10,2),
    JoiningDate DATETIME,
    LastModifiedDate DATETIME
);

-- Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    LastModifiedDate DATETIME
);

-- Vendors
CREATE TABLE Vendors (
    VendorID INT PRIMARY KEY,
    VendorName VARCHAR(100),
    City VARCHAR(50),
    LastModifiedDate DATETIME
);

-- Discounts
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY,
    DiscountName VARCHAR(100),
    DiscountPercent DECIMAL(5,2),
    StartDate DATETIME,
    EndDate DATETIME,
    LastModifiedDate DATETIME
);

-- Coupons
CREATE TABLE Coupons (
    CouponID BIGINT PRIMARY KEY,
    CustomerID INT,
    CouponCode VARCHAR(30),
    DiscountID INT,
    UsedDate DATETIME,
    LastModifiedDate DATETIME
);

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
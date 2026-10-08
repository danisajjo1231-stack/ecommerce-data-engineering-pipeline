USE ECommerceDW;
GO

-- =========================================
-- DIMENSION: CUSTOMER
-- =========================================

CREATE TABLE warehouse.DimCustomer
(
    Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Name VARCHAR(100),
    City VARCHAR(100),
    Gender VARCHAR(20),
    Email VARCHAR(150),
    Signup_Date DATE,
    Modified_Date DATETIME2
);
GO


-- =========================================
-- DIMENSION: PRODUCT
-- =========================================

CREATE TABLE warehouse.DimProduct
(
    Product_Key INT IDENTITY(1,1) PRIMARY KEY,
    Product_ID INT NOT NULL,
    Product_Name VARCHAR(200),
    Category VARCHAR(100),
    Price DECIMAL(18,2),
    Subcategory INT,
    Modified_Date DATETIME2
);
GO


-- =========================================
-- DIMENSION: DATE
-- =========================================

CREATE TABLE warehouse.DimDate
(
    Date_Key INT PRIMARY KEY,
    Full_Date DATE NOT NULL,
    Year INT,
    Quarter INT,
    Month INT,
    Month_Name VARCHAR(20),
    Day INT,
    Day_Name VARCHAR(20)
);
GO


-- =========================================
-- FACT: ORDERS
-- =========================================

CREATE TABLE warehouse.FactOrders
(
    Order_Key BIGINT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT NOT NULL,
    Customer_Key INT,
    Product_Key INT,
    Date_Key INT,
    Payment_ID INT,
    Quantity INT,
    Unit_Price DECIMAL(18,2),
    Total_Amount DECIMAL(18,2),
    City VARCHAR(100),
    Modified_Date DATETIME2
);
GO
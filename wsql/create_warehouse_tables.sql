```sql
USE [ECommerceDW];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

-- =========================================
-- DIMENSION TABLE: CUSTOMER
-- =========================================

CREATE TABLE warehouse.DimCustomer
(
    Customer_Key INT IDENTITY(1,1) NOT NULL,
    Customer_ID INT NOT NULL,
    Name VARCHAR(100) NULL,
    City VARCHAR(100) NULL,
    Gender VARCHAR(20) NULL,
    Email VARCHAR(150) NULL,
    Signup_Date DATE NULL,
    Modified_Date DATETIME2(7) NULL,

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY (Customer_Key)
);
GO


-- =========================================
-- DIMENSION TABLE: PRODUCT
-- =========================================

CREATE TABLE warehouse.DimProduct
(
    Product_Key INT IDENTITY(1,1) NOT NULL,
    Product_ID INT NOT NULL,
    Product_Name VARCHAR(200) NULL,
    Category VARCHAR(100) NULL,
    Price DECIMAL(18,2) NULL,
    Modified_Date DATETIME2(7) NULL,
    Subcategory VARCHAR(100) NULL,

    CONSTRAINT PK_DimProduct
        PRIMARY KEY (Product_Key)
);
GO


-- =========================================
-- DIMENSION TABLE: DATE
-- =========================================

CREATE TABLE warehouse.DimDate
(
    Date_Key INT NOT NULL,
    Full_Date DATE NOT NULL,
    Year INT NULL,
    Quarter INT NULL,
    Month INT NULL,
    Month_Name VARCHAR(20) NULL,
    Day INT NULL,
    Day_Name VARCHAR(20) NULL,

    CONSTRAINT PK_DimDate
        PRIMARY KEY (Date_Key)
);
GO


-- ==============
```

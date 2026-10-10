```sql
USE [ECommerceDW];
GO

/*
    PROJECT: E-Commerce Data Engineering Pipeline

    PURPOSE:
    Load dimension and fact tables from staging tables.

    IMPORTANT:
    This is a historical initial-load script.
    Do not rerun against an already populated warehouse
    without implementing a truncate/reload or incremental strategy.
*/


-- =====================================================
-- 1. LOAD CUSTOMER DIMENSION
-- =====================================================

INSERT INTO warehouse.DimCustomer
(
    Customer_ID,
    Name,
    City,
    Gender,
    Email,
    Signup_Date,
    Modified_Date
)
SELECT
    Customer_ID,
    Name,
    City,
    Gender,
    Email,
    NULL AS Signup_Date,
    GETDATE() AS Modified_Date
FROM staging.customers;
GO


-- =====================================================
-- 2. LOAD PRODUCT DIMENSION
-- =====================================================

INSERT INTO warehouse.DimProduct
(
    Product_ID,
    Product_Name,
    Category,
    Price,
    Modified_Date,
    Subcategory
)
SELECT
    Product_ID,
    Product_Name,
    Category,
    Price,
    Modified_Date,
    Subcategory
FROM staging.products;
GO


-- =====================================================
-- 3. GENERATE DATE DIMENSION
-- =====================================================

DECLARE @StartDate DATE = '2026-01-01';
DECLARE @EndDate   DATE = '2026-09-21';

;WITH DateSeries AS
(
    SELECT @StartDate AS Full_Date

    UNION ALL

    SELECT DATEADD(DAY, 1, Full_Date)
    FROM DateSeries
    WHERE Full_Date < @EndDate
)
INSERT INTO warehouse.DimDate
(
    Date_Key,
    Full_Date,
    Year,
    Quarter,
    Month,
    Month_Name,
    Day,
    Day_Name
)
SELECT
    CONVERT(INT, CONVERT(CHAR(8), Full_Date, 112)),
    Full_Date,
    YEAR(Full_Date),
    DATEPART(QUARTER, Full_Date),
    MONTH(Full_Date),
    DATENAME(MONTH, Full_Date),
    DAY(Full_Date),
    DATENAME(WEEKDAY, Full_Date)
FROM DateSeries
OPTION (MAXRECURSION 0);
GO


-- =====================================================
-- 4. LOAD FACT ORDERS
-- =====================================================

INSERT INTO warehouse.FactOrders
(
    Order_ID,
    Customer_Key,
    Product_Key,
    Date_Key,
    Payment_ID,
    Quantity,
    Unit_Price,
    Total_Amount,
    Modified_Date
)
SELECT
    o.Order_ID,
    c.Customer_Key,
    p.Product_Key,
    d.Date_Key,
    pay.Payment_ID,
    o.Quantity,
    o.Unit_Price,
    o.Total_Amount,
    o.Modified_Date
FROM staging.orders AS o

LEFT JOIN warehouse.DimCustomer AS c
    ON CAST(o.Customer_ID AS BIGINT) = c.Customer_ID

LEFT JOIN warehouse.DimProduct AS p
    ON o.Product_ID = p.Product_ID

LEFT JOIN warehouse.DimDate AS d
    ON CAST(o.Order_Date AS DATE) = d.Full_Date

LEFT JOIN staging.payments AS pay
    ON o.Order_ID = pay.Order_ID;
GO


-- =====================================================
-- 5. ADD UNKNOWN PRODUCT MEMBER
-- =====================================================

SET IDENTITY_INSERT warehouse.DimProduct ON;

INSERT INTO warehouse.DimProduct
(
    Product_Key,
    Product_ID,
    Product_Name,
    Category,
    Price,
    Modified_Date,
    Subcategory
)
VALUES
(
    -1,
    -1,
    'Unknown Product',
    'Unknown',
    NULL,
    GETDATE(),
    'Unknown'
);

SET IDENTITY_INSERT warehouse.DimProduct OFF;
GO


-- =====================================================
-- 6. HANDLE MISSING PRODUCT KEYS
-- =====================================================

UPDATE warehouse.FactOrders
SET Product_Key = -1
WHERE Product_Key IS NULL;
GO


-- =====================================================
-- 7. HANDLE MISSING PAYMENT IDS
-- =====================================================

UPDATE warehouse.FactOrders
SET Payment_ID = -1
WHERE Payment_ID IS NULL;
GO
```

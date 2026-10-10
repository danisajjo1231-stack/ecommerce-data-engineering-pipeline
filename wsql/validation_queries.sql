```sql
USE [ECommerceDW];
GO

-- =========================================
-- 1. ROW COUNT VALIDATION
-- =========================================

SELECT 'DimCustomer' AS TableName, COUNT(*) AS TotalRows
FROM warehouse.DimCustomer

UNION ALL

SELECT 'DimProduct', COUNT(*)
FROM warehouse.DimProduct

UNION ALL

SELECT 'DimDate', COUNT(*)
FROM warehouse.DimDate

UNION ALL

SELECT 'FactOrders', COUNT(*)
FROM warehouse.FactOrders;
GO


-- =========================================
-- 2. FACT TABLE NULL CHECKS
-- =========================================

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Customer_Key IS NULL THEN 1 ELSE 0 END)
        AS Missing_Customer,
    SUM(CASE WHEN Product_Key IS NULL THEN 1 ELSE 0 END)
        AS Missing_Product,
    SUM(CASE WHEN Date_Key IS NULL THEN 1 ELSE 0 END)
        AS Missing_Date,
    SUM(CASE WHEN Payment_ID IS NULL THEN 1 ELSE 0 END)
        AS Missing_Payment
FROM warehouse.FactOrders;
GO


-- =========================================
-- 3. DUPLICATE CUSTOMER CHECK
-- =========================================

SELECT
    Customer_ID,
    COUNT(*) AS Duplicate_Count
FROM warehouse.DimCustomer
GROUP BY Customer_ID
HAVING COUNT(*) > 1;
GO


-- =========================================
-- 4. DUPLICATE PRODUCT CHECK
-- =========================================

SELECT
    Product_ID,
    COUNT(*) AS Duplicate_Count
FROM warehouse.DimProduct
WHERE Product_Key <> -1
GROUP BY Product_ID
HAVING COUNT(*) > 1;
GO


-- =========================================
-- 5. SALES SUMMARY
-- =========================================

SELECT
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    SUM(Total_Amount) AS Total_Sales,
    AVG(Total_Amount) AS Average_Order_Value
FROM warehouse.FactOrders;
GO


-- =========================================
-- 6. UNKNOWN PRODUCT CHECK
-- =========================================

SELECT
    COUNT(*) AS Unknown_Product_Orders
FROM warehouse.FactOrders
WHERE Product_Key = -1;
GO


-- =========================================
-- 7. UNKNOWN PAYMENT CHECK
-- =========================================

SELECT
    COUNT(*) AS Unknown_Payment_Orders
FROM warehouse.FactOrders
WHERE Payment_ID = -1;
GO
```

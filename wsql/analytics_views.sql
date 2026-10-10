USE [ECommerceDW];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE VIEW [analytics].[vw_CategorySales]
AS
SELECT
p.Category,
COUNT(*) AS Total_Orders,
SUM(f.Quantity) AS Total_Quantity,
SUM(f.Total_Amount) AS Total_Sales,
AVG(f.Total_Amount) AS Average_Order_Value
FROM warehouse.FactOrders f
JOIN warehouse.DimProduct p
ON f.Product_Key = p.Product_Key
GROUP BY
p.Category;
GO

CREATE VIEW [analytics].[vw_CustomerSales]
AS
SELECT
c.Customer_ID,
c.Name,
c.City,
c.Gender,
COUNT(*) AS Total_Orders,
SUM(f.Quantity) AS Total_Quantity,
SUM(f.Total_Amount) AS Total_Sales,
AVG(f.Total_Amount) AS Average_Order_Value
FROM warehouse.FactOrders f
JOIN warehouse.DimCustomer c
ON f.Customer_Key = c.Customer_Key
GROUP BY
c.Customer_ID,
c.Name,
c.City,
c.Gender;
GO


CREATE VIEW [analytics].[vw_MonthlySales]
AS
SELECT
    d.Year,
    d.Month,
    d.Month_Name,
    COUNT(*) AS Total_Orders,
    SUM(f.Quantity) AS Total_Quantity,
    SUM(f.Total_Amount) AS Total_Sales,
    AVG(f.Total_Amount) AS Average_Order_Value
FROM warehouse.FactOrders f
JOIN warehouse.DimDate d
    ON f.Date_Key = d.Date_Key
GROUP BY
    d.Year,
    d.Month,
    d.Month_Name;
GO


CREATE VIEW [analytics].[vw_OverallKPIs]
AS
SELECT
    COUNT(*) AS Total_Orders,
    SUM(Quantity) AS Total_Quantity,
    SUM(Total_Amount) AS Total_Sales,
    AVG(Total_Amount) AS Average_Order_Value,
    COUNT(DISTINCT Customer_Key) AS Unique_Customers,
    COUNT(DISTINCT Product_Key) AS Unique_Products
FROM warehouse.FactOrders;
GO


CREATE VIEW [analytics].[vw_PaymentMethodSales]
AS
SELECT
    Payment_Method,
    COUNT(*) AS Total_Payments,
    SUM(Amount) AS Total_Payment_Amount,
    AVG(Amount) AS Average_Payment_Amount
FROM staging.payments
GROUP BY
    Payment_Method;
GO


CREATE VIEW [analytics].[vw_ProductSales]
AS
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,
    p.Subcategory,
    COUNT(*) AS Total_Orders,
    SUM(f.Quantity) AS Total_Quantity,
    SUM(f.Total_Amount) AS Total_Sales,
    AVG(f.Total_Amount) AS Average_Order_Value
FROM warehouse.FactOrders f
JOIN warehouse.DimProduct p
    ON f.Product_Key = p.Product_Key
WHERE f.Product_Key <> -1
GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category,
    p.Subcategory;
GO


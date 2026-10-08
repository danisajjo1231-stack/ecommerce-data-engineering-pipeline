USE ECommerceDW;
GO

CREATE TABLE staging.customers
(
    Customer_ID INT,
    Name VARCHAR(100),
    City VARCHAR(100),
    Contact_Number VARCHAR(50),
    Email VARCHAR(150),
    Gender VARCHAR(20),
    Signup_Date DATE,
    Modified_Date DATETIME2
);
GO

CREATE TABLE staging.products
(
    Product_ID INT,
    Product_Name VARCHAR(200),
    Category VARCHAR(100),
    Price DECIMAL(18,2),
    Stock INT,
    Modified_Date DATETIME2
);
GO

CREATE TABLE staging.orders
(
    Order_ID INT,
    Customer_ID INT,
    Product_ID INT,
    Order_Date DATE,
    Quantity INT,
    Unit_Price DECIMAL(18,2),
    Total_Amount DECIMAL(18,2),
    Payment_ID INT,
    City VARCHAR(100),
    Modified_Date DATETIME2
);
GO

CREATE TABLE staging.payments
(
    Payment_ID INT,
    Order_ID INT,
    Payment_Date DATE,
    Amount DECIMAL(18,2),
    Payment_Method VARCHAR(50),
    Payment_Status VARCHAR(50),
    Modified_Date DATETIME2
);
GO
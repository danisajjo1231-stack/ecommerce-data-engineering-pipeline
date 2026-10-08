# E-Commerce Data Engineering Pipeline

An end-to-end **E-Commerce Data Engineering project** built to demonstrate a real-world data pipeline from raw CSV data to a SQL Server data warehouse and Power BI analytics dashboard.

The project covers **ETL, data quality, data validation, SQL Server staging, dimensional modeling, analytics views, and business intelligence**.

---

## 📌 Project Overview

This project processes e-commerce data containing:

* Customers
* Products
* Orders
* Payments

The pipeline extracts raw data, cleans and validates it using Python, loads it into SQL Server staging tables, transforms it into a warehouse/star-schema structure, creates analytical SQL views, and finally connects the warehouse to Power BI for reporting.

### Pipeline Flow

```text
Raw CSV Data
     ↓
Python ETL
     ↓
Data Cleaning & Validation
     ↓
Rejected Records
     ↓
SQL Server Staging
     ↓
Data Warehouse
     ↓
Star Schema
     ↓
Analytics Views
     ↓
Power BI Dashboard
```

---

## 🛠️ Technologies Used

* Python
* Pandas
* NumPy
* SQL Server
* SQL
* SQL Server Management Studio (SSMS)
* Power BI
* DAX
* ETL / ELT concepts
* Data Quality & Validation
* Dimensional Data Modeling
* Star Schema

---

## 📂 Project Structure

```text
ecommerce_data_pipeline/
│
├── data/
│
├── output/
│   └── rejected/
│
├── Src/
│
├── wsql/
│
├── .gitignore
│
└── README.md
```

### Folder Description

| Folder/File        | Purpose                                                 |
| ------------------ | ------------------------------------------------------- |
| `data/`            | Raw project data                                        |
| `Src/`             | Python ETL and transformation code                      |
| `output/`          | Processed output data                                   |
| `output/rejected/` | Records rejected during data-quality checks             |
| `wsql/`            | SQL Server staging, warehouse and analytics SQL scripts |
| `.gitignore`       | Prevents unnecessary files from being committed         |
| `README.md`        | Project documentation                                   |

---

# 🔄 ETL Pipeline

## 1. Extract

The pipeline reads the raw e-commerce CSV files using Python and Pandas.

Source datasets include:

* Customers
* Products
* Orders
* Payments

---

## 2. Transform

The transformation process performs data-quality and cleaning operations such as:

* Missing-value detection
* Duplicate detection
* Invalid-value detection
* Data-type handling
* ID validation
* Price validation
* Payment validation
* Data consistency checks

Invalid records are separated into rejected datasets instead of silently being loaded into the warehouse.

---

## 3. Load

Cleaned data is loaded into **SQL Server staging tables**.

Staging tables include:

```text
staging.customers
staging.products
staging.orders
staging.payments
```

The staging layer provides a controlled area between raw data and the final warehouse.

---

# 🧹 Data Quality

Data-quality checks were performed before loading data into the warehouse.

Examples of issues identified during processing included:

* Missing product prices
* Invalid product prices
* Missing customer IDs
* Missing payment amounts
* Product IDs that could not be matched
* Invalid or incomplete payment records

Rejected records were stored separately for review.

Example:

```text
output/
└── rejected/
```

This approach helps prevent bad records from directly affecting analytical results.

---

# 🏗️ Data Warehouse

The cleaned staging data was transformed into a warehouse structure using a **dimensional/star-schema approach**.

The warehouse contains dimension and fact data designed for analytical queries and Power BI reporting.

### Key Concepts Implemented

* Surrogate keys
* Dimension tables
* Fact table
* Date dimension
* Product dimension
* Customer dimension
* Payment relationships
* Unknown-member handling

---

## 🔑 Unknown Product Handling

When an order contained a product ID that could not be matched with the product dimension, an **Unknown Product** surrogate record was used.

```text
Product_Key = -1
Product_ID  = -1
```

This prevents unmatched records from being completely lost from the fact table while maintaining referential consistency.

---

# 📊 Analytics Views

SQL Server analytics views were created to make reporting easier.

The project includes views for:

```text
vw_MonthlySales
analytics.vw_CategorySales
analytics.vw_ProductSales
analytics.vw_CustomerSales
analytics.vw_PaymentMethodSales
analytics.vw_OverallKPIs
```

These views provide business-level metrics for Power BI and analytical queries.

---

# 📈 Power BI Dashboard

The warehouse data was connected to Power BI to create an interactive e-commerce dashboard.

The dashboard provides analysis such as:

* Total Sales
* Total Orders
* Total Quantity
* Average Order Value
* Monthly Sales
* Category Sales
* Product Sales
* Customer Sales
* Payment Method Analysis

Power BI results were validated against SQL Server results.

---

# ✅ Final KPI Validation

The final SQL Server KPI results were:

| KPI                 |             Value |
| ------------------- | ----------------: |
| Total Orders        |            99,302 |
| Total Quantity      |           298,205 |
| Total Sales         | 21,848,312,913.16 |
| Average Order Value |    220,018.860779 |

The Power BI dashboard numbers were validated against the SQL Server results and matched exactly.

---

# 🔍 Data Warehouse Validation

Additional validation was performed on the final warehouse data, including:

* Fact-table row counts
* Missing dimension relationships
* Product matching
* Payment matching
* Date matching
* Sales totals
* Quantity totals
* Order totals
* Aggregation consistency

These checks helped ensure that the final analytical layer was reliable.

---

# 💡 Business Analysis

The final analytical layer can be used to answer questions such as:

* How much revenue was generated?
* How many orders were completed?
* Which categories generate the most sales?
* Which products generate the most revenue?
* Which customers contribute the most sales?
* How do sales change month by month?
* Which payment methods are most commonly used?
* Where do data-quality issues occur?

---

# 🚀 Skills Demonstrated

This project demonstrates practical experience with:

* Python ETL
* Pandas
* Data Cleaning
* Data Validation
* Data Quality
* SQL
* SQL Server
* SSMS
* Staging Tables
* Data Warehousing
* Star Schema
* Fact & Dimension Modeling
* Surrogate Keys
* Rejected Data Handling
* Analytics Views
* Power BI
* DAX
* KPI Validation
* End-to-End Data Pipelines

---

# ▶️ How to Run

## 1. Clone the Repository

Clone this repository to your local machine.

## 2. Install Python Dependencies

Create a Python environment and install the required packages.

Example:

```bash
pip install pandas numpy sqlalchemy pyodbc
```

## 3. Prepare the Data

Place the required source CSV files inside:

```text
data/
```

## 4. Run the Python Pipeline

Run the ETL scripts from the `Src/` directory according to the project pipeline.

The pipeline performs extraction, transformation, validation and output generation.

## 5. Load Data into SQL Server

Create the required SQL Server database and staging/warehouse structures using the SQL scripts inside:

```text
wsql/
```

## 6. Open Power BI

Connect Power BI to the final SQL Server analytical layer/views.

Refresh the data and use the dashboard for analysis.

---

# 📌 Project Outcome

This project demonstrates a complete data engineering workflow:

```text
Raw Data
   ↓
Extract
   ↓
Transform
   ↓
Data Quality
   ↓
Reject Invalid Records
   ↓
SQL Server Staging
   ↓
Data Warehouse
   ↓
Star Schema
   ↓
Analytics Views
   ↓
Power BI
   ↓
Business Insights
```

The project was designed to reflect a practical industry-style data pipeline rather than a simple data-analysis notebook.

---

## 👨‍💻 Author

**Danish Muhammad**

Data Engineering | Data Analytics | SQL | Python | Power BI | Machine Learning



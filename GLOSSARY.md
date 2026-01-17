# Glossary

## Data Architecture & Flow

**Data Flow**  
The path data follows from its original source (CRM / ERP files) through transformation layers (Bronze → Silver → Gold) until it is consumed in Power BI for reporting.

**Bronze Layer**  
The raw ingestion layer. Data is loaded from source files (CSV) into SQL tables with minimal or no transformation.  
Purpose: preserve original data exactly as received.

**Silver Layer**  
The cleansing and standardization layer. Data quality issues are handled here (data types, duplicates, missing values, naming consistency).  
Purpose: prepare clean, reliable data for analytics.

**Gold Layer**  
The analytical layer optimized for reporting and BI tools.  
It contains fact and dimension tables organized in a star schema.

**Star Schema**  
A data model where a central fact table is connected to multiple dimension tables to simplify analysis and improve performance.

---

## SQL & Data Modeling Terms

**DDL (Data Definition Language)**  
SQL statements used to define database objects such as tables, schemas, and views  
(e.g. `CREATE TABLE`, `CREATE VIEW`).

**ETL (Extract, Transform, Load)**  
A data pipeline process used to extract data from sources, transform it, and load it into analytical structures.

**Primary Key (PK)**  
A unique identifier for each row in a table.  
Example: `customer_key` in `dim_customers`.

**Foreign Key (FK)**  
A column that links one table to another table’s primary key.  
Example: `customer_key` in `fact_sales` linking to `dim_customers`.

**Fact Table**  
A table that stores measurable business events.  
In this project: `fact_sales` stores sales amount, quantity, and dates.

**Dimension Table**  
A table that provides descriptive context to facts.  
Examples: `dim_customers`, `dim_products`.

**Surrogate Key**  
An internally generated key (not from the source system) used as a primary key in dimension tables.

---

## Naming Conventions Used

**fact_**  
Prefix used for fact tables containing transactional data.  
Example: `fact_sales`.

**dim_**  
Prefix used for dimension tables containing descriptive attributes.  
Example: `dim_customers`, `dim_products`.

**crm_**  
Prefix used for tables originating from the CRM system.

**erp_**  
Prefix used for tables originating from the ERP system.

**gold.**  
Schema used for analytical, reporting-ready tables.

---

## Data Quality & Transformation Terms

**Data Cleansing**  
The process of fixing or removing incorrect, inconsistent, or missing data values.

**Standardization**  
Ensuring consistent formats (dates, text casing, numeric types) across datasets.

**Deduplication**  
Removing duplicate records to ensure each business entity is represented once.

**Null Handling**  
Managing missing values explicitly (keeping, replacing, or excluding them).

---

## Business & Analytics Terms

**Total Sales**  
Total revenue calculated as Quantity × Unit Price.

**Total Quantity**  
Total number of units sold.

**Order Count**  
Number of unique sales orders.

**Repeat Customer**  
A customer who placed more than one order during the analysis period.

**One-time Customer**  
A customer who placed exactly one order.

**Profit**  
Total Sales minus Total Cost.

**Profit Margin %**  
Profit divided by Total Sales, expressed as a percentage.

**Product Line**  
High-level grouping of products (e.g. Road, Mountain, Touring).

**Subcategory**  
More detailed classification within a category  
(e.g. Tires and Tubes, Helmets).

---

## Power BI & DAX Terms

**Measure**  
A dynamic calculation evaluated at query time in Power BI  
(e.g. Total Sales, Profit Margin).

**Calculated Column**  
A column computed at data refresh time and stored in the data model  
(e.g. Customer Age Group).

**Filter Context**  
The set of filters applied to a visual or calculation in Power BI.

**Slicer**  
An interactive filter control used to filter report visuals.

---

## Scope Note

This glossary applies to the SQL scripts, data model, and Power BI reports included in this repository.  
The dataset is used for educational and portfolio purposes only.
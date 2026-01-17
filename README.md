# Sales Data Warehouse & Power BI Analytics Project

## Overview
This project is an end-to-end Business Intelligence solution built using SQL Server and Power BI.  
It covers the full data lifecycle: ingestion, transformation, modeling, and visualization, with the goal of answering real business questions related to sales performance, customer behavior, product pricing, profitability, and seasonality.

The project follows a layered data architecture (Bronze → Silver → Gold) and delivers interactive dashboards for decision-making.

---

## Business Questions
The analysis focuses on answering the following questions:

### Sales & Performance
- How has total sales evolved over time?
- How do sales and quantity trends compare?
- Which product categories and product lines generate the most revenue?
- What is the overall profit margin?

### Customer Analysis
- What percentage of customers are repeat vs one-time buyers?
- Which countries contribute the most to total sales?
- Which age groups generate the highest revenue?

### Product & Pricing Analysis
- Which subcategories drive the highest sales volume?
- Are there products with high prices but low demand?
- Which product lines generate the highest profit?

### Time & Seasonality
- Are there seasonal peaks in sales and order volume?
- How do sales and quantity evolve month over month?

---

## Architecture & Data Flow

### Data Sources
- CRM system (sales transactions, customers, products)
- ERP system (product categories, customer demographics, locations)

### Data Layers
- **Bronze Layer**: Raw data ingestion from CSV files using BULK INSERT
- **Silver Layer**: Cleaned and standardized tables
- **Gold Layer**: Star schema optimized for analytics

### Gold Data Model
- `gold.fact_sales`
- `gold.dim_customers`
- `gold.dim_products`

(See diagrams in the `/docs` folder)

---

## Technologies Used
- SQL Server
- Stored Procedures & Views
- Power BI, DAX, Power Query

---

## How to Run the Project

1. Create the database and schemas  
   Run:

---

## Documentation
- See `PROJECT_REPORT.md` for business questions and outcomes
- See `GLOSSARY.md` for technical and business term definitions

---

## Dataset Source & License
The dataset used in this project was obtained from an external source and is used for educational/portfolio purposes.
This repository’s MIT License applies to my SQL scripts, documentation, and Power BI report, but **does not override the dataset’s original license**.
If required, please refer to the dataset provider’s license/terms.
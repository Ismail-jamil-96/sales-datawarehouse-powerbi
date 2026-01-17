/*
=============================================================
Create Database and Schemas
=============================================================
Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE DataWarehouse;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO

-- Drop tables if they already exist (safe)
DROP TABLE IF EXISTS bronze.crm_sales_details;
DROP TABLE IF EXISTS bronze.crm_prd_info;
DROP TABLE IF EXISTS bronze.crm_cust_info;

DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
DROP TABLE IF EXISTS bronze.erp_cust_az12;
DROP TABLE IF EXISTS bronze.erp_loc_a101;

-- Create tables
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id        INT,
    prd_key       NVARCHAR(50),
    prd_nm        NVARCHAR(50),
    prd_cost      INT,
    prd_line      NVARCHAR(50),
    prd_start_dt  DATETIME,
    prd_end_dt    DATETIME
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   NVARCHAR(50),
    sls_prd_key   NVARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  INT,
    sls_ship_dt   INT,
    sls_due_dt    INT,
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT
);

CREATE TABLE bronze.erp_loc_a101 (
    cid   NVARCHAR(50),
    cntry NVARCHAR(50)
);

CREATE TABLE bronze.erp_cust_az12 (
    cid   NVARCHAR(50),
    bdate DATE,
    gen   NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

SELECT COUNT(*) FROM bronze.crm_cust_info

GO
CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    PRINT '==============================================';
    PRINT 'Loading Bronze Layer';
    PRINT '==============================================';

    PRINT '----------------------------------------------';
    PRINT 'Loading CRM Tables';
    PRINT '----------------------------------------------';

    PRINT '>> Truncating Table:bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    PRINT '>> Inserting Data Into:bronze.crm_cust_info';
    BULK INSERT bronze.crm_cust_info
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );


    PRINT '>> Truncating Table:bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    PRINT '>> Inserting Data Into:bronze.crm_prd_info';
    BULK INSERT bronze.crm_prd_info
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );

    PRINT '>> Truncating Table:bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;

    PRINT '>> Inserting Data Into:bronze.crm_sales_details';
    BULK INSERT bronze.crm_sales_details
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );

    PRINT '----------------------------------------------';
    PRINT 'Loading ERP Tables';
    PRINT '----------------------------------------------';

    PRINT '>> Truncating Table:bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;

    PRINT '>> Inserting Data Into:bronze.erp_cust_az12';
    BULK INSERT bronze.erp_cust_az12
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );

    PRINT '>> Truncating Table:bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;

    PRINT '>> Inserting Data Into:bronze.erp_loc_a101';
    BULK INSERT bronze.erp_loc_a101
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );

    PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    PRINT '>> Inserting Data Into:bronze.erp_px_cat_g1v2';
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'D:\1. My Files\Self Study\Project SQL Data Warhouse\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );

    END

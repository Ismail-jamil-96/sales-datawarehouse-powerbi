-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No result

SELECT * FROM bronze.crm_cust_info
WHERE cst_id = 29449;
SELECT
[cst_id],
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check For unwanted spaces
-- Expectation: No result

SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

SELECT cst_material_status
FROM bronze.crm_cust_info
WHERE cst_material_status != TRIM(cst_material_status)

-- Data Standarization & Consistancy
-- Expectation: No result

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT DISTINCT cst_material_status
FROM bronze.crm_cust_info

-- After Cleansing
-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No result

SELECT
[cst_id],
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check For unwanted spaces
-- Expectation: No result

SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

SELECT cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)

-- Data Standarization & Consistancy
-- Expectation: No result

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT DISTINCT cst_material_status
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info






-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No result

SELECT * FROM bronze.crm_prd_info

SELECT
[prd_id],
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check For unwanted spaces
-- Expectation: No result

SELECT prd_key
FROM bronze.crm_prd_info
WHERE prd_key != TRIM(prd_key)

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT prd_line
FROM bronze.crm_prd_info
WHERE prd_line != TRIM(prd_line)

-- Data Standarization & Consistancy
-- Expectation: No result

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

SELECT DISTINCT cst_material_status
FROM bronze.crm_cust_info

--Check for nulls or Negative Numbers
-- Expectation: No result

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--Check for Invalide date Orders
-- Expectation: No result
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt



--[bronze][crm_sales_details][sls_prd_key][sls_cust_id][sls_order_dt][sls_ship_dt][sls_due_dt][sls_sales][sls_quantity][sls_price]
SELECT * 
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

SELECT * 
FROM bronze.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key)

--As we mention we have a connection btw table of sals and pdt so lets check it
SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details

--Check for invalid dates
SELECT
sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0

SELECT
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

--Check if date of shiping are > or < date of sales ...

SELECT
*
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Value must not be Null, zero, or negative.
SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_proce,

CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
THEN sls_quantity * ABS(sls_price)
ELSE sls_sales
END AS sls_sales,

CASE WHEN sls_price IS NULL OR sls_price <=0
THEN sls_sales / NULLIF(sls_quantity, 0)
ELSE sls_price
END AS sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity,sls_price -- here you should ask the expert to solve issues if they allows you to fix it then do


--[silver][crm_sales_details][sls_prd_key][sls_cust_id][sls_order_dt][sls_ship_dt][sls_due_dt][sls_sales][sls_quantity][sls_price]
SELECT * 
FROM silver.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

SELECT * 
FROM silver.crm_sales_details
WHERE sls_prd_key != TRIM(sls_prd_key)

--As we mention we have a connection btw table of sals and pdt so lets check it
SELECT
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details

--Check for invalid date
SELECT
sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <=0

SELECT
NULLIF(sls_order_dt,0) sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <=0
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

--Check if date of shiping are > or < date of sales ...
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Value must not be Null, zero, or negative.
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity,sls_price -- here you should ask the expert to solve issues if they allows you to fix it then do

SELECT * FROM silver.crm_sales_details

--Identify OUT-of-Range Dates
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

SELECT DISTINCT
gen
FROM silver.erp_cust_az12

SELECT* FROM silver.erp_cust_az12

SELECT
REPLACE(cid, '-', ''),
cntry
FROM bronze.erp_loc_a101

-- If we want to find unmatching data fro both table that have connection by a column like here by cid from table of erp_loc_a101 and cst_key from crm_cust_info
SELECT
REPLACE(cid, '-', ''),
cntry
FROM bronze.erp_loc_a101 WHERE REPLACE(cid, '-', '') NOT IN (SELECT cst_key FROM silver.crm_cust_info)

SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry

SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2
-- Because previously we split a colone to a two column cat_id & prd_key
SELECT id FROM bronze.erp_px_cat_g1v2 WHERE id NOT IN (SELECT cat_id FROM silver.crm_prd_info)

SELECT * FROM silver.erp_px_cat_g1v2 WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

SELECT * FROM silver.erp_px_cat_g1v2
--  Create an External Table in Athena (Referencing S3 Data)
CREATE EXTERNAL TABLE IF NOT EXISTS retail_sales_athena (
    order_id STRING,
    date DATE,
    status STRING,
    fulfilment STRING,
    sales_channel STRING,
    ship_service_level STRING,
    style STRING,
    sku STRING,
    category STRING,
    size STRING,
    asin STRING,
    courier_status STRING,
    qty INT,
    currency STRING,
    amount DECIMAL(10,2),
    ship_city STRING,
    ship_state STRING,
    ship_postal_code STRING,
    ship_country STRING,
    fulfilled_by STRING
)
PARTITIONED BY (ship_state STRING)
STORED AS PARQUET
LOCATION 's3://retailetlsales/athena_results/'
TBLPROPERTIES ("classification"="parquet");

-- Partition Data by Ship State for Faster Queries
ALTER TABLE retail_sales_athena ADD PARTITION (ship_state='KARNATAKA') LOCATION 's3://retailetlsales/athena_results/ship_state=KARNATAKA/';
ALTER TABLE retail_sales_athena ADD PARTITION (ship_state='TELANGANA') LOCATION 's3://retailetlsales/athena_results/ship_state=TELANGANA/';
ALTER TABLE retail_sales_athena ADD PARTITION (ship_state='MAHARASHTRA') LOCATION 's3://retailetlsales/athena_results/ship_state=MAHARASHTRA/';

-- Optimize Queries by Enabling Compression
MSCK REPAIR TABLE retail_sales_athena;

-- Query: Find Top 5 States by Total Sales
SELECT ship_state, SUM(amount) AS total_sales
FROM retail_sales_athena
GROUP BY ship_state
ORDER BY total_sales DESC
LIMIT 5;

--  Query: Identify High-Value Orders (Above INR 500)
SELECT order_id, amount, ship_state
FROM retail_sales_athena
WHERE amount > 500
ORDER BY amount DESC;

--  Query: Count Orders Per Fulfillment Type
SELECT fulfilled_by, COUNT(order_id) AS order_count
FROM retail_sales_athena
GROUP BY fulfilled_by
ORDER BY order_count DESC;

-- Query: Calculate Daily Sales Trend
SELECT date, SUM(amount) AS total_sales
FROM retail_sales_athena
GROUP BY date
ORDER BY date ASC;

-- Query: Find Most Ordered Product Categories
SELECT category, COUNT(sku) AS order_count
FROM retail_sales_athena
GROUP BY category
ORDER BY order_count DESC
LIMIT 5;

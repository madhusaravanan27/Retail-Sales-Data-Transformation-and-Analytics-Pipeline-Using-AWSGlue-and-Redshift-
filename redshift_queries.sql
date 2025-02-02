CREATE SCHEMA IF NOT EXISTS retail;

CREATE TABLE retail.sales_data (
    index INT,
    order_id VARCHAR(50),
    date DATE,
    ship_state VARCHAR(50),
    category VARCHAR(50),
    amount DECIMAL(10, 2),
    status VARCHAR(50),
    fulfilment VARCHAR(20),
    sales_channel VARCHAR(50),
    ship_service_level VARCHAR(20),
    style VARCHAR(50),
    sku VARCHAR(50),
    size VARCHAR(10),
    asin VARCHAR(20),
    courier_status VARCHAR(20),
    qty INT,
    currency VARCHAR(10),
    ship_city VARCHAR(50),
    ship_postal_code VARCHAR(10),
    ship_country VARCHAR(10),
    fulfilled_by VARCHAR(20),
    DISTKEY (order_id),
    SORTKEY (date, ship_state)
)
DISTSTYLE AUTO;

-- Load data from S3 to Redshift
COPY retail.sales_data
FROM 's3://retailetlsales/cleaned_amazon_sale_report.csv'
IAM_ROLE 'arn:aws:iam::418295680509:role/AmazonS3ReadOnlyAccess'
FORMAT AS CSV
DELIMITER ','
IGNOREHEADER 1
DATEFORMAT 'YYYY-MM-DD';


ANALYZE retail.sales_data;
VACUUM retail.sales_data;

-- Top 5 states by sales
SELECT ship_state, SUM(amount) AS total_sales
FROM retail.sales_data
GROUP BY ship_state
ORDER BY total_sales DESC
LIMIT 5;

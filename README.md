# Retail Sales Data Transformation and Analytics Pipeline Using AWS Glue and Redshift  
**Project Duration:** Nov 2024 – Dec 2024  

## **📌 Project Overview**
This project demonstrates an **end-to-end data pipeline** using **AWS Glue** and **Amazon Redshift** to transform, enrich, and analyze retail sales data. The goal is to **optimize data storage, enable efficient querying, and provide analytical insights** on sales performance.  

## **🚀 Key Features**
✅ **AWS Glue ETL**: Transforms raw sales data and enriches it with derived metrics (order value categories, state-wise rankings).  
✅ **Amazon Redshift**: Stores the transformed data for fast analytics with optimized **indexing and partitioning**.  
✅ **S3 Data Ingestion**: Loads cleaned data from Amazon S3 into Redshift using `COPY` command.  
✅ **SQL Query Optimization**: Uses **DISTKEY(order_id), SORTKEY(date, ship_state), and Partitioning** to improve query performance.  
✅ **Automated Workflows**:  
   - **AWS Glue Jobs** for ETL processing.  
   - **AWS Step Functions** to orchestrate Glue Jobs.  
   - **Amazon EventBridge** to schedule ETL executions.  
✅ **Data Analytics**: Redshift SQL queries to derive insights such as **top-selling states** and **order category distributions**.  

---

## **🛠️ Tech Stack**
- **Cloud & Compute**: AWS Glue, AWS Redshift, AWS Lambda, Amazon S3  
- **Database & Querying**: Amazon Redshift, SQL  
- **Programming & ETL**: PySpark, Python, AWS Glue Jobs  
- **Orchestration & Automation**: AWS Step Functions, AWS EventBridge  



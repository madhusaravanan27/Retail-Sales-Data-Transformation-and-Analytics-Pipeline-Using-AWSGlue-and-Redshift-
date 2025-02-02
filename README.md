Retail Sales Data Transformation and Analytics Pipeline Using AWS Glue and Redshift

Overview

This project demonstrates a serverless data pipeline using AWS Glue, Redshift, and S3 to process, transform, and analyze retail sales data. The pipeline is designed to optimize query performance, provide actionable insights, and automate ETL workflows.


Tech Stack

AWS Glue: ETL processing and data transformation.

Amazon Redshift: Data warehousing and analytics.

Amazon S3: Data storage and staging.

AWS Step Functions: Orchestration and automation.

AWS EventBridge: Scheduled Glue job execution.

PySpark: Data transformations.

SQL: Redshift queries and optimizations.

Workflow

Data Ingestion

Raw sales data is cleaned and uploaded to Amazon S3.

ETL Processing with AWS Glue

The data is extracted from S3 and transformed using PySpark in AWS Glue.

New derived metrics like order_value_category and state_rank are generated.

Transformed data is written back to Amazon Redshift.

Redshift Optimization

Partitioning by date improves query efficiency.

DISTKEY(order_id) & SORTKEY(date, ship_state) optimize analytical queries.

Indexing and VACUUM/ANALYZE operations enhance performance.

Automation and Scheduling

AWS Step Functions orchestrate the ETL workflow.

AWS EventBridge schedules periodic Glue jobs.

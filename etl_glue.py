from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, sum, rank
from pyspark.sql.window import Window


spark = SparkSession.builder.appName("RetailSalesETL").getOrCreate()

jdbc_url = "jdbc:redshift://<redshift-endpoint>:5439/dev"
properties = {"user": "your-username", "password": "your-password"}


df = spark.read.jdbc(jdbc_url, "retail.sales_data", properties=properties)
df = df.withColumn("order_value_category", when(col("amount") > 500, "High Value").otherwise("Low Value"))

# Aggregate sales by state
window_spec = Window.orderBy(col("total_sales").desc())
summary_df = df.groupBy("ship_state").agg(sum("amount").alias("total_sales"))
summary_df = summary_df.withColumn("state_rank", rank().over(window_spec))

# Optimize write by partitioning by ship_state
summary_df.write.partitionBy("ship_state").jdbc(jdbc_url, "retail.state_sales_summary", mode="overwrite", properties=properties)

print("ETL Job Completed Successfully")

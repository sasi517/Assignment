import snowflake.snowpark.functions as F
import holidays
 
def is_holiday(date_col):
    # Chez Jaffle
    french_holidays = holidays.France()
    is_holiday = (date_col in french_holidays)
    return is_holiday
 
def model(dbt, session):
 
    dbt.config(
        materialized = "table", schema = "reporting",
        packages = ["holidays"]
    )
 
    dim_customers_df = dbt.ref('dim_customers')
    fct_orders_df = dbt.ref('fct_orders')
 
    customer_orders_df = (
       fct_orders_df
       .group_by('customerid')
       .agg(
           F.min(F.col('orderdate')).alias('first_order'),
           F.max(F.col('orderdate')).alias('most_recent_order'),
           F.count(F.col('orderid')).alias('number_of_orders')
         
           
       )
   )
 
 
    final_df = (
       dim_customers_df
       .join(customer_orders_df, dim_customers_df.customerid == customer_orders_df.customerid, 'left')
       .select(dim_customers_df.customerid.alias('customerid'),
               dim_customers_df.companyname.alias('companyname'),
               dim_customers_df.contactname.alias('contactname'),
               customer_orders_df.first_order.alias('first_order'),
               customer_orders_df.most_recent_order.alias('most_recent_order'),
               customer_orders_df.number_of_orders.alias('number_of_orders'),
 
               
       )
   )
 
    final_removenulls_df = (
        final_df.filter(F.col("first_order").isNotNull())
    )
 
    holiday_df = final_removenulls_df.to_pandas()
 
    holiday_df["IS_ORDERDAY_HOLIDAY"] = (holiday_df["FIRST_ORDER"].astype(str)).apply(is_holiday)
 
    return holiday_df
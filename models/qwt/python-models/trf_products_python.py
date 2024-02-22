def add_profit(x, y):
    return x-y

def model(dbt, session):
    dbt.config(schema = "transforming")
    products_df = dbt.ref("stg_products")

    df = products_df.withColumn("profit", add_profit(products_df["UnitPrice"], products_df["UnitCost"]))

    return df
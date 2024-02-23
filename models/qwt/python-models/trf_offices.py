def model(dbt, session):
    dbt.config(materialized = "table", schema = "transforming")
    # dbt.config(materialized = "table", schema = env_var('dbt_trfschema', 'transforming')
    df = dbt.ref("stg_office")

    return df

# def model(dbt, session):
#     dbt.config(materialized = "table", schema = "transforming")
#     df = dbt.ref("stg_office")

#     if dbt.is_incremental:
#         max_from_this = f"select max()
#     return df
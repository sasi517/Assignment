{{config(materialized='table',alias = 'stg_customers')}}

-- select * from qwt.raw.customers

select * from {{env_var('dbt_sourcedb', 'qwt')}}.{{env_var('dbt_sourceschema', 'raw')}}.CUSTOMERS
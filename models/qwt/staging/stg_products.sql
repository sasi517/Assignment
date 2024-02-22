{{ config(materialized="table", alias = 'stg_products') }}
select
    productid,
    productname,
    supplierid,
    categoryid,
    quantityperunit,
    unitcost,
    unitprice,
    unitsinstock,
    unitsonorder
-- from qwt.raw.products
from {{env_var('dbt_sourcedb','qwt')}}.{{env_var('dbt_sourceschema','raw')}}.products
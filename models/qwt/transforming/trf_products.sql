-- {{ config(materialized="table",schema = 'TRANSFORMING') }}
{{ config(materialized="table",schema = env_var('DBT_TRFSCHEMA', 'TRANSFORMING')) }}
select * ,
IFF((unitsinstock - unitsonorder) > 0, 'yes', 'no') as productavailability,

(unitprice - unitcost) as profit

from {{ ref('stg_products') }}
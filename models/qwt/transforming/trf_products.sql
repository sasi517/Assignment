{{ config(materialized="table",schema = 'TRANSFORMING') }}
select * ,
IFF((unitsinstock - unitsonorder) > 0, 'yes', 'no') as productavailability,

(unitprice - unitcost) as profit

from {{ ref('stg_products') }}
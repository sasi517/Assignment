-- {{ config(materialized="table",schema = 'TRANSFORMING') }}
{{ config(materialized="table",schema = env_var('DBT_TRFSCHEMA', 'TRANSFORMING')) }}

select
od.*,
(od.Price * od.qty) * (1-od.Discount) as Linesalesamount,
(p.unitcost * od.qty) as costofgoodssold,
(((od.Price * od.qty)
* (1-od.Discount)) - (p.UnitCost
* od.qty)) as margin
from
{{ ref('stg_orderdetails')}} as od
inner join {{ref('stg_products')}} as p
on od.productid = p.productid
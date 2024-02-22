{{config(materialized='incremental',unique_key = ['OrderID','linenumber'])}}
-- select od.*
-- from qwt.raw.orderdetails od
-- inner join {{ ref('stg_orders') }} o on od.OrderID = o.OrderID
-- {% if is_incremental() %}
--  where o.OrderDate >= (select max(o.OrderDate) from {{ref('stg_orders')}})
-- {% endif %}

select od.*
from {{env_var('dbt_sourcedb','qwt')}}.{{env_var('dbt_sourceschema','raw')}}.orderdetails od
inner join {{ ref('stg_orders') }} o on od.OrderID = o.OrderID
{% if is_incremental() %}
 where o.OrderDate >= (select max(OrderDate) from {{ref('stg_orders')}}) 
{% endif %}
{{config(materialized='view',schema='reporting')}}

with products as (
    select
    PRODUCTID,
    PRODUCTNAME,
    CITY
from {{ ref('dim_products') }} 
)
,
orders as (
    select 
    PRODUCTID,
    sum(qty*PRICE) as total_order_amount
    from {{ ref('fct_orders') }}
    group by PRODUCTID
),
product_orders as (
select 
p.PRODUCTNAME,
p.CITY,
o.total_order_amount,
row_number() over (partition by p.CITY order by o.total_order_amount desc) as rn
from products p
inner join
orders o
on p.PRODUCTID = o.PRODUCTID)
select PRODUCTNAME,CITY,TOTAL_ORDER_AMOUNT from product_orders where rn = 1 order by city
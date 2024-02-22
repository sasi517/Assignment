{{ config(materialized = 'view', schema = 'reporting') }}

/*
select
orderid,
sum(case when linenumber = 1 then (qty * price) end) as lineno_1_amount,
sum(case when linenumber = 2 then (qty * price) end) as lineno_2_amount,
sum(case when linenumber = 3 then (qty * price) end) as lineno_3_amount,
sum(qty*price) as total_order_amount

from {{ref('stg_orderdetails')}}
group by orderid
*/

/*
-- jinja query
{% set linenumber = [1, 2, 3, 4] %}
select 
orderid,
{% for linenumber in linenos %}
sum(case when linenumber = {{linenumber}} then (qty*price) end) as lineno_{{linenumber}}_amount,
{% endfor %}
sum(qty*price) as total_order_amount
from {{ref('stg_orderdetails')}}
group by orderid
*/

-- jinja with macro
{% set linenumber = get_order_linenos() %}
select 
orderid,
{% for linenumber in linenos %}
sum(case when linenumber = {{linenumber}} then (qty*price) end) as lineno_{{linenumber}}_amount,
{% endfor %}
sum(qty*price) as total_order_amount
from {{ref('stg_orderdetails')}}
group by orderid
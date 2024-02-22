{{ config (materialized = 'view', schema = 'reporting') }}

select 
e.empid,
e.firstname,
month(fo.orderdate) as ordermonth,
year(fo.orderdate) as orderyear,
sum(fo.linesalesamount) as totalsales,
avg(fo.margin) as margin
from {{ ref('fct_orders')}} fo
inner join {{ ref('stg_employee')}} e
on fo.employeeid = e.empid
inner join {{ref ('stg_office')}} as o
on o.office = e.office
-- where o.officecity = '{{var('city')}}'
where o.OFFICECITY = '{{var('city','Nice')}}'
group  by e.empid, e.firstname, ordermonth, orderyear

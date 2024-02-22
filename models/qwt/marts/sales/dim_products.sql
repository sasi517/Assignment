{{config (materialized = 'view',schema ='sales_mart')}}

select 

p.*,
s.companyname,
s.contactname,
s.country,
s.city,
c.categoryname

from {{ref("trf_products")}} as p
inner join {{ref("trf_suppliers")}} as s on p.SUPPLIERID =s.SUPPLIERID
inner join {{ ref('productcategories') }} as c on c.categoryId = p.categoryId
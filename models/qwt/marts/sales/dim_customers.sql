{{config (materialized = 'view',schema ='sales_mart',alias = 'dim_customers')}}

select tc.*,d.divisionname
 from {{ref('trf_customers')}} as tc
 inner join {{ref('divisions')}} as d
 on tc.DivisionID =d.DivisionID
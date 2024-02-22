{{config(materialized='view',schema= 'sales_mart') }}
select 
ss.orderid,
ss.lineno,
ss.shipperid,
s.companyname as shipmentcompany,
ss.ShipmentDate,
ss.status,
ss.dbt_valid_from,
ss.dbt_valid_to
from
{{ ref('shipments_snapshot') }} as ss
inner join
{{ ref('shippers') }} as s 
on ss.shipperid = s.shipperid
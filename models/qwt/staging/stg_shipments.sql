{{config(materialized='table')}}

select
OrderID	,
LineNo	,
ShipperID,	
CustomerID,	
ProductID	,
EmployeeID	,
to_date(SUBSTR(ShipmentDate,1,regexp_instr(ShipmentDate,' ',1,1)-1)) AS ShipmentDate,
Status
-- from qwt.raw.shipments
from {{env_var('dbt_sourcedb','qwt')}}.{{env_var('dbt_sourceschema','raw')}}.shipments
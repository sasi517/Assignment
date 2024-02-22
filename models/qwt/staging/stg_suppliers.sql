{{config(materialized='table')}}
select * 
-- from qwt.raw.suppliers
from {{env_var('dbt_sourcedb','qwt')}}.{{env_var('dbt_sourceschema','raw')}}.SUPPLIERS
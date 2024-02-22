{{config(materialized='table')}}
-- select * from qwt.raw.employee
select * from {{env_var('dbt_sourcedb','qwt')}}.{{env_var('dbt_sourceschema','raw')}}.employees
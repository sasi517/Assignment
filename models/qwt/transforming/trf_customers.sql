-- {{ config(materialized="table",schema = 'TRANSFORMING') }}
{{ config(materialized="table",schema = env_var('DBT_TRFSCHEMA', 'TRANSFORMING')) }}
select 
CUSTOMERID,
COMPANYNAME,
CONTACTNAME,
CITY,
COUNTRY,
DIVISIONID,
ADDRESS,
FAX,
PHONE,
POSTALCODE,
CASE WHEN COALESCE(StateProvince,'')='' THEN 'NA' ELSE StateProvince END AS STATE
from {{ ref('stg_customers') }}
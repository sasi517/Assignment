{{ config(materialized="view", schema="reporting") }}

{% macro get_order_linenos() -%}

    {% set order_linenos_query %}
select distinct
linenumber
from {{ref('stg_orderdetails')}}
order by 1
    {% endset %}

    {% set results = run_query(order_linenos_query) %}

    {% if exeute %}
        {# Return the first column#}
        {% set results_list = results.columns[0].values() %}
    {% else %} {% set results_list = [] %}
    {% endif %}

    {{ return(results_list) }}
{%- endmacro %}


-- -- --- Macro for Category -----------
-- {{ config(materialized="view", schema="reporting") }}
-- {% set prodcategories = get_prod_categories() %}
-- select
--     od.orderid,
--     {% for categoryname in prodcategories %}
--         nvl(
--             sum(
--                 case
--                     when pc.categoryname = '{{categoryname}}'
--                     then (od.quantity * od.unitprice)
--                 end
--             ),
--             0
--         ) as "{{categoryname}}",
--     {% endfor %}
--     sum(od.quantity * od.unitprice) as total_order_amount
-- from {{ ref("stg_orderdetails") }} as od
-- inner join {{ ref("products") }} as p on od.productid = p.productid
-- inner join {{ ref("productcategories") }} as pc on pc.categoryid = p.categoryid
-- group by   1
--  {% endset %}

--     {% set results = run_query(order_linenos_query) %}

--     {% if exeute %}
--         {# Return the first column#}
--         {% set results_list = results.columns[0].values() %}
--     {% else %} {% set results_list = [] %}
--     {% endif %}

--     {{ return(results_list) }}
-- {%- endmacro %}



{% macro max_date() -%}
 
{% set query %}
select
max(ORDERDATE)
from {{ ref('stg_orders') }}
{% endset %}
{% set results = run_query(query) %}
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% endif %}
{{ return(results_list) }}
{%- endmacro %}
 
 
{% macro min_date() -%}
 
{% set query %}
select
min(ORDERDATE)
from {{ ref('stg_orders') }}
{% endset %}
{% set results = run_query(query) %}
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% endif %}
{{ return(results_list) }}
{%- endmacro %}
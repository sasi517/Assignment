{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%} {{ default_schema }}
    {%- else -%} {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}


{% macro build_snapshot_table(strategy, sql) %}

    select
        *,
        {{ strategy.scd_id }} as scd_id,
        {{ strategy.updated_at }} as updated_at,
        {{ strategy.updated_at }} as valid_from,
        nullif({{ strategy.updated_at }}, {{ strategy.updated_at }}) as valid_to
    from ({{ sql }}) sbq

{% endmacro %}

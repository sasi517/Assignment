{% test is_odd(model, column_name) %}

with validation as (
    select {{ column_name }} as even_field
    from {{ model }}
),
validation_errors as (
    select even_field 
    from validation where even_field % 2 = 1
)
select * from validation_errors


{% endtest %}
{% macro test_unique_combined(model) %}

{% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}

with validation as (
    select
        {{ column_name }}
    from {{ model }}

    group by {{ column_name }}
    having count(*) > 1
)

select count(*)
from validation

{% endmacro %}

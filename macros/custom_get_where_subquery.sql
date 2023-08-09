
{% macro get_where_subquery(relation) -%}
    {% set where = config.get('where') %}
    {% if where %}
        {% if "__three_days_ago__" in where %}
            {# replace placeholder string with result of custom macro #}
            {% set three_days_ago = dbt.dateadd('day', -3, current_timestamp()) %}
            {% set where = where | replace("__three_days_ago__", three_days_ago) %}
        {% endif %}
        {%- set filtered -%}
            (select * from {{ relation }} where {{ where }}) dbt_subquery
        {%- endset -%}
        {% do return(filtered) %}
    {%- else -%}
        {% do return(relation) %}
    {%- endif -%}
{%- endmacro %}
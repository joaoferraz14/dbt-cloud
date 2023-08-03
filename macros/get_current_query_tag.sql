{% macro get_current_query_tag() -%}
    {{ return(run_query("show query_tag")) }}
{%- endmacro %}

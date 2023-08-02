-- macros/model_query_tags.sql
{% macro model_query_tag() -%}
  {% set query_tag = model.name %}
{%- endmacro %}

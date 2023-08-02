/*
  Macro that takes in the alias for the column, column name, and decimal places.
  If no decimal places are passed, it defaults to 2.
  If no alias is provided, it just uses the column name.
*/
{% macro cents_to_dollars(column_name, column_alias=None, decimal_places=2) -%}
  {% if column_alias -%}
    /* If an alias is provided, convert cents to dollars using the alias and the specified decimal places */
    round(1.0 * {{column_alias}}.{{column_name}} / 100, {{decimal_places}})
  {%- else -%}
    /* If no alias is provided, convert cents to dollars using just the column name and the specified decimal places */
    round(1.0 * {{column_name}} / 100, {{decimal_places}})
  {%- endif %}
{%- endmacro %}

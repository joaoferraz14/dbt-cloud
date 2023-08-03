{% macro set_query_tag() -%}
  {% set new_query_tag =  config.get('alias') ~ '_' ~ target.user if  config.get('alias') else model.name ~ '_' ~ target.user%} 
  {{ log("Setting query_tag to '" ~ new_query_tag ~ "' after materialization.") }}
  {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}
{% endmacro %}
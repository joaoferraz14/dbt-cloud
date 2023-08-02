{% macro limit_dev_data( date_column_name, filter_key_word='WHERE', alias=None, days_to_filter=3) -%}
    /* Check if the target is the development environment ('dev') */
    {%- if target.name == 'dev' -%}
        {% if not alias -%}
            /* If no alias is provided, use the date_column_name directly */
            {{ filter_key_word }} {{ date_column_name }} >= dateadd('day', -{{ days_to_filter }}, current_timestamp)
        {%- else -%}
            /* If an alias is provided, use the alias along with the date_column_name */
            {{ filter_key_word }} {{ alias }}.{{ date_column_name }} >= dateadd('day', -{{ days_to_filter }}, current_timestamp)
        {%- endif %}
    {%- endif %}
{%- endmacro %}

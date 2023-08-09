{% macro clean_stale_models(database=target.database, schema=target.schema, days=180, dry_run=True) %}
    {% set get_drop_commands_query %}
        select
            case 
                when table_type = 'VIEW'
                    then table_type
                else 
                    'TABLE'
            end as drop_type, 
            'DROP ' || drop_type || ' {{ database | upper }}.' || table_schema || '.' || table_name || ';'
        from {{ database }}.information_schema.tables 
        where table_schema = '{{ schema | upper }}'
        and last_altered <=  DATEADD(days, {{  days }}, current_date) 
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n' ~ get_drop_commands_query, info=True) }}
{% if execute %}
    {% set drop_queries = run_query(get_drop_commands_query).columns[1].values() %} 
    {% if drop_queries %}
        {{ log('Creating cleanup queries...', info=True) }}
        {% for query in drop_queries %}
            {% if dry_run %}
                {{ log('Query that would be applied if dry run = False ' ~ query, info=True) }}
            {% else %}
                {{ log('Dropping object with command: ' ~ query, info=True) }}
                {% do run_query(query) %} 
            {% endif %}       
        {% endfor %}
    {% else %}
        {{ log('No cleanup queries to execute.', info=True) }}
    {% endif %}
{% endif %}
    
{% endmacro %} 
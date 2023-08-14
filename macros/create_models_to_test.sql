{% macro create_models_to_test(database=target.database, schema=target.schema, days=3, dry_run=True) %}
    {% set get_clone_commands_query %}
        select
            case 
                when table_type = 'VIEW'
                    then table_type
                else 
                    'TABLE'
            end as type_table, 
            'CREATE OR REPLACE ' || type_table || ' {{ database | upper }}.' || '{{ schema | upper}}' || '.' || table_name || ' AS (SELECT * FROM {{database}}.PRD.' || table_name || ' LIMIT 100);'
        from {{ database }}.information_schema.tables 
        where table_schema = 'PRD'
        and last_altered >=  DATEADD('day', {{ - days }}, current_date) 
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n' ~ get_clone_commands_query, info=True) }}
{% if execute %}
    {% set clone_queries = run_query(get_clone_commands_query).columns[1].values() %} 
    {% if clone_queries and target.name == 'dev' %}
        {{ log('Creating clone queries...', info=True) }}
        {% for query in drop_queries %}
            {% if dry_run %}
                {{ log('Query that would be applied if dry run = False ' ~ query, info=True) }}
            {% else %}
                {{ log('Clonning object with command: ' ~ query, info=True) }}
                {% do run_query(query) %} 
            {% endif %}       
        {% endfor %}
    {% else %}
        {{ log('No clone queries to execute.', info=True) }}
    {% endif %}
{% endif %}
    
{% endmacro %} 
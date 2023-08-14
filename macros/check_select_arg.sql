{% macro check_select_arg() %}
    {% do log('ON START ✅', info=True) %}
    {% if
        not invocation_args_dict.select
        and target.name not in ['prod']
        and invocation_args_dict.which in ['build', 'test', 'source', 'snapshot', 'seed']
    %}

        {{ exceptions.raise_compiler_error(" ❌ Error: You must provide at least one select argument") }}

    {% endif %}

{% endmacro %}
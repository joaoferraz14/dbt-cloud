{% macro check_select_arg() %}

    {% if not invocation_args_dict.select and target.name != 'prod' %}

        {{ exceptions.raise_compiler_error("Error: You must provide at least one select argument") }}

    {% endif %}

{% endmacro %}
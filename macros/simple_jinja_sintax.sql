{#
{% set my_cool_string = 'cool' %}
{% set my_cool_string_2 = 'this is jina' %}
{% set my_cool_number = 100 %}

{{ my_cool_string}} {{ my_cool_string_2}} i want to write jinja for {{my_cool_number}} years


{% set my_animals = ['lemur', 'wolf', 'panther', 'tadigrade'] %}
{% for animal in my_animals %} 
   my favourite animal is  {{animal}}
{%endfor %} 


{%set temperature = 85 %}

{% if temperature <65 %}
    time for a cappucino
{%else %}
    time for a cold brew
{%endif%}


{%- set foods =  ['carrot', 'hotdog', 'cocumber', 'bell pepper'] -%}

{%- for food in foods -%}
    {%- if food == 'hotdog' -%}
        {% set food_type =  'snack' %}
    {%else%}
        {% set food_type = 'vegetable'%}
    {% endif%}
    the humble {{ food }} is my favourite {{food_type}}
{%endfor%}
#}


{% set websters_dict = {
    'word': 'data',
    'speech_part': 'noun',
    'definition': 'if you know you know'
}%}

{% for key, value in websters_dict.items() %}

    this is the key {{ key }}, and this is the value {{value}}
{%endfor%}
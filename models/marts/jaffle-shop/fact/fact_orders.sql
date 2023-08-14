{{
  config(
    materialized='ephemeral'
  )
}}

{% set columns = ['order_id', 'customer_id', 'p.amount'] -%}
select
    {{ dbt_utils.generate_surrogate_key(['order_id', 'customer_id'])}} as unique_key,
    {% for col in columns -%}
      {{col}}
    {%- if not loop.last -%}
    ,
    {%- endif %}
    {% endfor -%}
    from {{ref('stg_orders')}} as o
    inner join {{ref('stg_payments')}} as p
    on o.order_id= p.orderid 
    where p.status = 'success'
    {{ limit_dev_data(date_column_name='CREATED', filter_key_word='and', alias='p', days_to_filter=640000) }}

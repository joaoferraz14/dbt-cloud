{{ config(
    materialization = 'incremental',
    unique_key='customer_id',
    incremental_strategy='delete+insert'
    ) 
}}

with customers as (
    select * from {{ref('stg_customers')}}
),
orders as (
    select * from {{ref('stg_orders')}}
),
employees as (
    select * from {{ ref('employees')}}
),
customer_orders as (

    select
        o.customer_id,

        min(o.order_date) as first_order_date,
        max(o.order_date) as most_recent_order_date,
        count(o.order_id) as number_of_orders,
        sum(p.amount) as amount

    from orders as o
    inner join {{ref('fact_orders')}} as p
    on o.order_id = p.order_id
    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        employees.employee_id is not null as is_employee,
        {{ dbt_privacy.mask_email("email") }} as email,
        coalesce({{cents_to_dollars(column_alias='customer_orders',column_name='amount', decimal_places=4)}},0) as life_time_value,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
    from customers

    left join customer_orders using (customer_id)
    left join employees using (customer_id)

)

select * from final
    {% if is_incremental() %}
    where true
    {% endif %}
{{ limit_dev_data(date_column_name= 'most_recent_order_date', filter_key_word='and', days_to_filter=640000) }}

{%- set payment_method = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}


with payments as 
(
select * from {{ ref ('stg_payments')}}
where status = 'success'
),
pivoted as (
    select orderid,
        {% for method in payment_method  -%}
        sum(case when PAYMENTMETHOD = '{{method}}' then amount/100 else 0 end) AS {{method}}_amount
        {%- if not loop.last -%}
        ,
        {%- endif %}
        {% endfor -%}
        , current_date as dbt_updated_at

    from payments
    group by 1
)

select * from pivoted
-- some comment
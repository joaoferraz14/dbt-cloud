
--dbt is set up to fail when the query retrives results that violate the assertion
with payments as 
(
    select orderid as order_id, sum(amount) as total_amount from {{ref('stg_payments')}}
    group by order_id 
)

select order_id, total_amount from payments
where total_amount < 0

with payment_data as (

    select status
        , amount
    from {{ ref('stg_payments')}}
)

select sum(amount) as total_successfull_payments 
from payment_data
where status = 'success'
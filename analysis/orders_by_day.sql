with order as (
select * from {{ ref('stg_orders')}}
),
daily as (
    select order_date
        , count(*) as order_num

    from order
    group by 1 
)

select * from daily
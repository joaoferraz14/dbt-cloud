select 
      order_id
    , customer_id
    , p.amount
    from {{ref('stg_orders')}} as o
    inner join {{ref('stg_payments')}} as p
    on o.order_id= p.orderid 
    where p.status = 'success'
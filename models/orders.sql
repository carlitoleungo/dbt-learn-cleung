SELECT orders.order_date,
	   orders.order_id,
	   orders.customer_id,
	   payments.amount AS payment_amount,
	   payments.status AS payment_status,
	   orders.status AS order_status

FROM {{ ref('stg_orders') }} orders
	LEFT JOIN {{ ref ('stg_payments') }} payments ON orders.order_id = payments.order_id
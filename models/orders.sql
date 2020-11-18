SELECT orders.order_date,
	   orders.order_id,
	   orders.customer_id,
	   orders.status AS order_status,
	   SUM(payments.amount) AS payment_amount

FROM {{ ref('stg_orders') }} orders
	LEFT JOIN {{ ref ('stg_payments') }} payments ON orders.order_id = payments.order_id

WHERE payments.status = 'success'

GROUP BY 1, 2, 3, 4
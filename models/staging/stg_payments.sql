SELECT id AS payment_id,
	   orderid AS order_id,
	   amount::float/100 AS amount,
	   paymentmethod AS payment_method,
	   created AS payment_time,
	   status

FROM {{ source('stripe', 'payment') }} AS payment
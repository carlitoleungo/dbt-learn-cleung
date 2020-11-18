{{
    config (
        materalized = 'view'
        )
}}

WITH customer_orders AS (
    SELECT customer_id,
           MAX(order_date) AS first_order_date,
           MAX(order_date) AS most_recent_order_date,
           COUNT(order_id) AS number_of_orders,
           SUM(payment_amount) AS total_order_value

    FROM {{ ref('orders')}} orders
        WHERE payment_status = 'success'

    GROUP BY 1
)

SELECT customers.customer_id,
       customers.first_name,
       customers.last_name,
       customer_orders.first_order_date,
       customer_orders.most_recent_order_date,
       COALESCE(customer_orders.number_of_orders, 0) AS number_of_orders,
       SUM(customer_orders.total_order_value::float) AS lifetime_value

FROM {{ ref('stg_customers')}} customers
    LEFT JOIN customer_orders USING (customer_id)

GROUP BY 1, 2, 3, 4, 5, 6
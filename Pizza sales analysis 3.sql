-- The percentage contribution of each pizza type to total revenue

select pizza_types.category,round((sum(order_details.quantity* pizzas.price) / 
(select round(sum(order_details.quantity* pizzas.price),2) as total_sales
from order_details 
join pizzas
on pizzas.pizza_id=order_details.pizza_id)*100) ,2) as revenue
from pizza_types
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by  pizza_types.category
order by revenue desc;

-- Analyze cummulative revenue generated over time

select order_date,sum(revenue) over (order by order_date)
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details
join pizzas 
on order_details.pizza_id=pizzas.pizza_id
join orders
on order_details.order_id=orders.order_id
group by orders.order_date) as sales ;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

select category, name ,revenue, rn
from
(select category, name, revenue,
rank() over (partition by category order by revenue desc) as rn
from 
(select pizza_types.category, pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on pizzas.pizza_id=order_details.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn <= 3;








-- Total quantity of each pizza category

select pizza_types.category, sum(order_details.quantity)
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category;

-- Distribution of orders by hour per day

select hour(order_time)as hour, count(order_id) order_count
from orders
group by hour(order_time)
order by hour;

-- Category wise distribution of pizzas

select category, count(name)
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day

select round(avg(quantity)) as avg_pizza_ordered_pday from 
(select orders.order_date, sum(order_details.quantity) as quantity
from orders
join order_details
on orders.order_id=order_details.order_id
group by orders.order_date) as quantity_ordered;

-- Determine top 3 most ordered pizzas by revenue

select pizza_types.name, sum(order_details.quantity* pizzas.price) as revenue
from pizza_types
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;






















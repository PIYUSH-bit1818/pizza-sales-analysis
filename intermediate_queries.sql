-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category, sum(od.quantity)  as quantity
from pizza_types pt 
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.category
order by quantity desc ;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) as hour,count(order_id)  as order_count
from orders
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) 
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) as avg_pizza_ordered_per_day
from
(select o.order_date,sum(od.quantity) as quantity
from orders o
join order_details od on o.order_id = od.order_id
group by o.order_date) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pt.name,sum(od.quantity*p.price) as revenue
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.name
order by revenue desc limit 3;
-- Retrieve the total number of orders placed.
select count(order_id) as total_orders
from orders;

-- Calculate the total revenue generated from pizza sales.
select round(sum(od.quantity * p.price),2) as total_sales
from pizzas p
join order_details od on p.pizza_id = od.pizza_id 
;

-- Identify the highest-priced pizza.
select p.price,pt.name
from pizzas p 
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
order by p.price desc limit 1;

-- Identify the most common pizza size ordered.
select quantity, count(order_details_id)
from order_details
group by quantity;

select p.size, count(od.order_details_id) as order_count
from pizzas p
join order_details od on p.pizza_id = od.pizza_id
group by p.size
order by order_count desc;

-- List the top 5 most ordered pizza types along with their quantities.
select pt.name, sum(od.quantity)  as quantity
from pizza_types pt 
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.name
order by quantity desc limit 5;

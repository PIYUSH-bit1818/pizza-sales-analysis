-- Calculate the percentage contribution of each pizza type to total revenue.
select pt.category,round(((sum(od.quantity*p.price))/(select round(sum(od.quantity * p.price),2) as total_sales
from pizzas p
join order_details od on p.pizza_id = od.pizza_id))*100,2) as revenue
from pizza_types pt
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details od on p.pizza_id = od.pizza_id
group by pt.category
order by revenue desc;

-- Analyze the cumulative revenue generated over time.
select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select o.order_date, round(sum(od.quantity* p.price),2) as revenue
from pizzas p 
join order_details od on  p.pizza_id = od.pizza_id
join orders o  on od.order_id = o.order_id
group by o.order_date) as sales;

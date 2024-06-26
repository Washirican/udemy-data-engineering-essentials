-- Review Key Terms Used in Explain Plans for SQL Queries

SELECT o.*,
	round(sum(oi.order_item_subtotal)::numeric, 2) AS revenue
FROM orders as o
	JOIN order_items as oi
		ON o.order_id = oi.order_item_id
WHERE o.order_id = 2
GROUP BY o.order_id,
		o.order_date,
		o.order_customer_id,
		o.order_status;

-- Section 85: Interpret Explain Plans for Basic SQL Queries
select count(*) from orders where order_id = 2;

select * from orders where order_id = 2;

select count(*) from order_items where order_item_order_id = 2;

-- Section 86: Review the Common Application Scenarios for Performance Tunning
select * from customers limit 10;

select * from orders where order_customer_id = 5;

select o.*, oi.*
from orders as o 
	join order_items as oi
		on o.order_id = oi.order_item_order_id
where o.order_customer_id = 5;

-- Section 87: Write SQL queries for Customer Orders
select count(*)
from orders as o 
	join order_items as oi
		on o.order_id = oi.order_item_order_id
where o.order_customer_id = 5;

-- Section 88: Performance Testing of SQL Queries using Stored Procedure
create or replace procedure perfdemo()
language plpgsql
as $$
declare
	cur_order_details cursor (a_customer_id int) for
		select count(*)
		from orders as o
			join order_items as oi
				on o.order_id = oi.order_item_order_id
		where o.order_customer_id = a_customer_id;
	v_customer_id int := 0;
	v_order_item_count int;
begin
	loop
		exit when v_customer_id >= 1000;
		open cur_order_details(v_customer_id);
		fetch cur_order_details into v_order_item_count;
		v_customer_id = v_customer_id + 1;
		close cur_order_details;
	end loop;
end;
$$;

do $$
begin
	call perfdemo();
end;
$$;

-- Section 89: Add Required Indexes to tune performance of SQL Queries


















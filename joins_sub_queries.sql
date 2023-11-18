-- 1. List all customers who live in Texas (use JOINs): 
-- Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still
select first_name, last_name, district
from customer
full join address 
on customer.address_id = address.address_id 
where address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name: 
-- 32 records from Ida Andrews, Alvin Deloach, Douglas Graf, Harold Martino, Alfredo Mcadams, Peter Menard, Mary Smith
select first_name, last_name, amount
from customer 
full join payment 
on customer.customer_id = payment.customer_id 
where amount > 6.99;

-- 3. Show all customers' names who have made payments over $175 (use subqueries):
-- Douglas Graf, Peter Menard, Mary Smith
select first_name, last_name FROM	
	(select first_name, last_name, amount
	from customer
	full join payment
	on customer.customer_id = payment.customer_id 
	where amount > 175) sub
group by first_name, last_name
order by last_name;

-- 4. List all customers that live in Nepal (use the city table): 
-- Kevin Schuler
select customer.first_name, customer.last_name, country
from customer 
full join address 
on customer.address_id = address.address_id
full join city 
on address.city_id = city.city_id
full join country 
on city.country_id = country.country_id 
where country = 'Nepal';

-- 5. Which staff member had the most transactions?: 
-- Jon Stephens
select first_name, last_name, count(payment.staff_id)
from staff
full join payment
on staff.staff_id = payment.staff_id 
group by first_name, last_name;

-- 6. How many movies of each rating are there?: 
-- G 178, PG 194, PG-13 224, R 196, NC-17 209
select rating, COUNT(rating)
from film
group by rating;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries): 
-- Ida Andrews, Alvin Deloach, Douglas Graf, Harold Martino, Alfredo McAdams
select first_name, last_name, amounts
from (
	select first_name, last_name, count(sub.amount) as amounts
	from (
		select customer.customer_id, first_name, last_name, amount 
		from customer
		full join payment
		on customer.customer_id = payment.customer_id 
		where amount > 6.99
		) sub
	group by (first_name, last_name)
	) sub2
where amounts = 1
order by last_name asc;



-- 8. How many free rentals did our stores give away?: 
-- 14,564
select COUNT(amount) as total_1
from payment 
where amount <= 0;



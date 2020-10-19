# Lab | SQL Joins on multiple tables

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.
use sakila;

### Instructions
#1. Write a query to display for each store its store ID, city, and country.
select s.store_id, city, country from sakila.store as s
left join sakila.address as a
on s.address_id=a.address_id
left join sakila.city as ci
on a.city_id=ci.city_id
left join sakila.country as co
on ci.country_id=co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) as "Business brought in" from sakila.inventory as i
left join sakila.rental as r
on i.inventory_id=r.inventory_id
left join sakila.payment as p
on r.rental_id=p.rental_id
group by store_id;

#3. What is the average running time of films by category?
select name as "Category", avg(length) as "Average running time"from sakila.category as c
left join sakila.film_category as fc
on c.category_id=fc.category_id
left join sakila.film as f
on fc.film_id=f.film_id
group by name;

#4. Which film categories are longest
#Category with the longest movie
select name as "Category", max(length) as "Longest movie" from sakila.category as c
left join sakila.film_category as fc
on c.category_id=fc.category_id
left join sakila.film as f
on fc.film_id=f.film_id
group by name
order by  max(length) desc;

#Longest category
select name as "Category", sum(length) as "Longest movie" from sakila.category as c
left join sakila.film_category as fc
on c.category_id=fc.category_id
left join sakila.film as f
on fc.film_id=f.film_id
group by name
order by  sum(length) desc;

#5. Display the most frequently rented movies in descending order.
select film_id, title, rental_rate from sakila.film
group by title, film_id
order by rental_rate desc;

#6. List the top five genres in gross revenue in descending order.
select c.name as "Category", sum(p.amount) as "Gross Revenue" from sakila.category as c
left join sakila.film_category as fc
on c.category_id=fc.category_id
left join sakila.inventory as i
on fc.film_id=i.film_id
left join sakila.rental as r
on i.inventory_id=r.inventory_id
left join sakila.payment as p
on r.rental_id=p.rental_id
group by name
order by sum(amount) desc
limit 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
select f.film_id, f.title, count(i.inventory_id) as "Movies in stock", count(r.rental_id) as "Times rented", count(r.return_date) as "Times returned", i.store_id from sakila.film as f
left join sakila.inventory as i
on f.film_id=i.film_id
left join sakila.rental as r
on i.inventory_id=r.inventory_id
where title="Academy Dinosaur" and store_id=1 and return_date is not null
group by title,f.film_id;


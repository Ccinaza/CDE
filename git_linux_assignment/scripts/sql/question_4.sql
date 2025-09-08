/*
Provide a table that shows the region for each sales rep along with their associated accounts.
Your final table should include three columns: region name, sales rep name, and account name. 
Sort the accounts alphabetically (A-Z) by account name.
*/

select r.name as region,
       s.name as sales_rep,
       a.name as account_name
from region r
join sales_reps as s on r.id = s.region_id
join accounts as a   on s.id = a.sales_rep_id
order by account_name asc;

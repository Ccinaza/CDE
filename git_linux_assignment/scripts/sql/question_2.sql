/*
Write a query that returns a list of orders where the standard_qty is zero 
and either the gloss_qty or poster_qty is over 1000.
*/

select *
from orders
where cast(standard_qty as int) = 0
  and (cast(gloss_qty as int) > 1000 or cast(poster_qty as int) > 1000);

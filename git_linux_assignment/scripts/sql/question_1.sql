/* 
Find a list of order IDs where either gloss_qty or poster_qty is greater than 4000. 
Only include the id field in the resulting table.
*/

select id as order_id
from orders
where cast(gloss_qty as int) > 4000
   or cast(poster_qty as int) > 4000;

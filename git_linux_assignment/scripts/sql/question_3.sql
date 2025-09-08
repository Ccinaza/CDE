/*
Find all the company names that start with a 'C' or 'W', 
and where the primary contact contains 'ana' or 'Ana', 
but does not contain 'eana'.
*/

select name as company_name
from accounts
where (name ILIKE 'C%' or name ILIKE 'W%')
  and (primary_poc ILIKE '%ana%')
  and (primary_poc not ILIKE '%eana%');

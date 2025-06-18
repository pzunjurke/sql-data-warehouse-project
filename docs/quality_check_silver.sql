-- Checck for Nulls or Duplicates in Primary Key
-- Exception: No result

select cst_id,COUNT(*)
from bronze.crm_cust_info
group by cst_id
having count(*) >1 or cst_id is NULL;

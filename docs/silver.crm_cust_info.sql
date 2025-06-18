INSERT INTO silver.crm_cust_info (
       cst_id
      ,cst_key
      ,cst_firstname
      ,cst_lastname
      ,cst_marital_status
      ,cst_gender
      ,cst_create_date
)

select  cst_id
      ,cst_key
      ,trim(cst_firstname) as cst_firstname
      ,trim(cst_lastname) as cst_firstname
  
      , case 
            when UPPER(TRIM(cst_marital_status))= 'S' then 'Single'
            when UPPER(TRIM(cst_marital_status))= 'M' then 'Married'
            else 'n/a'
        end as cst_material_status
      , case 
            when UPPER(TRIM(cst_gender))= 'M' then 'Male'
            when UPPER(TRIM(cst_gender))= 'F' then 'Female'
            else 'n/a'
        end as cst_gndr

      
      ,cst_create_date
from 
    (
    select *,
        ROW_NUMBER() OVER (PARTITION by cst_id order by cst_create_date) as flag_last
        FROM [DataWarehouse].[bronze].[crm_cust_info]
    ) t
where t.flag_last = 1 and cst_id is not null;




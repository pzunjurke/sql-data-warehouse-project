insert into  silver.crm_prd_info(
    prd_id,
    cat_id,
    prd_key,
    prd_name,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)

SELECT prd_id
    , SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key
      ,replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id
      ,prd_name
      ,ISNULL(prd_cost,0) as prd_cost
      ,case 
            when UPPER(TRIM(prd_line))='M' then 'Mountain' 
            when UPPER(TRIM(prd_line))='R' then 'Road' 
            when UPPER(TRIM(prd_line))='S' then 'Other Sales'
            when UPPER(TRIM(prd_line))='T' then 'Touring' 
            else 'n/a'
        end as prd_line
      ,cast(prd_start_dt as date) as prd_start_dt
      ,cast(LEAD(prd_start_dt) OVER ( PARTITION BY prd_key ORDER BY prd_start_dt) -1  as date) prd_end_dt -- calculate end date as one day before the next start date
FROM [DataWarehouse].[bronze].[crm_prd_info];

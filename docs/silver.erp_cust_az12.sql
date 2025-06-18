INSERT INTO silver.erp_cust_az12(cid,bdate,gen)
SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(CID))
ELSE cid
END AS cat_id

, CASE WHEN bdate > GETDATE() THEN NULL
    ELSE bdate
    END AS bdate

,CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
    WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
    else 'n/a'
    end as gen
FROM BRONZE.erp_cust_az12
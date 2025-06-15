/*
==================================================================================================
Script Procedure : Load bronze Layer( Source -> Bronze)
==================================================================================================
Script Purpose :
      This store procedure loads data into the 'bronze' schema from external CSV files.
      It perform a following actions:
          - Truncate the bronze tables before loading a data.
          - Uses the 'BULK INSERT' command to load data from csv files to bronze table

Parameter:
    None.
  This store procedure does not acceot any parameter or return any values.

Uses example:
   EXEC bronze.load_bronze;
==================================================================================================

*/



CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
    SET @batch_start_time = GETDATE();
    BEGIN TRY
        PRINT '=================================================';
        PRINT 'LOADINF BRONZE LAYER';
        PRINT '=================================================';

        PRINT '-------------------------------------------------';
        PRINT 'LOADING CRM TABLES';  
        PRINT '-------------------------------------------------';


        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info  ';
        BULK INSERT bronze.crm_cust_info
        FROM '/data/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'

        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;



        PRINT '>> Inserting Data Into: bronze.crm_prd_info  ';
        BULK INSERT bronze.crm_prd_info
        FROM '/data/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'



        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: bronze.crm_sales_details  ';
        BULK INSERT bronze.crm_sales_details
        FROM '/data/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'




        PRINT '-------------------------------------------------';
        PRINT 'LOADING ERP TABLES';  
        PRINT '-------------------------------------------------';
       
       
        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: bronze.erp_cust_az12  ';
        BULK INSERT bronze.erp_cust_az12
        FROM '/data/source_erp/CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'




        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: bronze.erp_loc_a101  ';
        BULK INSERT bronze.erp_loc_a101
        FROM '/data/source_erp/LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'





        SET @start_time= GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cate_glv2';
        TRUNCATE TABLE bronze.erp_px_cate_glv2;

        PRINT '>> Inserting Data Into: bronze.erp_px_cate_glv2';
        BULK INSERT bronze.erp_px_cate_glv2
        FROM '/data/source_erp/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
        SET @end_time= GETDATE();
        PRINT '>> Load Duration : '+ CAST ( DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '***********************************'

        SET @batch_end_time = GETDATE();
        PRINT  '==================================';
        PRINT   'Loading bronze Layer is completed';
        PRINT '>> Total load Duration : '+ CAST ( DATEDIFF(second,@Batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT  '==================================';


    END TRY
    BEGIN CATCH
        PRINT '=========================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST ( ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST ( ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================';
    END CATCH
END

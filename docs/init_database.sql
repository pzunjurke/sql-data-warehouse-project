USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
    ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;




-- Create the 'DataWarehouse' Database
 CREATE DATABASE DataWarehouse;
GO


 USE Datawarehouse;
Go


-- Create Schemas

 CREATE SCHEMA bronze;
 GO

 CREATE SCHEMA silver;
 GO

 CREATE SCHEMA gold;
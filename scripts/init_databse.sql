/*
=====================================================================
Create Dastabase ans Schemas
=====================================================================

script purpose :
This script creates a new datase names 'DataWarehouse' after checking iff it already exists.
If the database exists, it is droped and recreated . Additionally , the script sets up three schemas within the database: 'bronze','silver','gold'.

WARNING:
 Running this script will drop the entire 'DatWarehouse' database if it exists.
 All data in the database will be permantly deleted . Proceed with caution and ensure you have proper backups before running this script.

*/





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

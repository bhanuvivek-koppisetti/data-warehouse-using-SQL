/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Note:
    The BULK INSERT paths point to 'C:\sql\dwh_project\01_datasets\'.
    Change them to the folder where you saved the datasets.
===============================================================================
*/

EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @START_TIME DATETIME, @END_TIME DATETIME,@BATCH_START_TIME DATETIME, @BATCH_END_TIME DATETIME;
	BEGIN TRY
		PRINT '================================';
		PRINT 'LOADING THE BRONZE LAYER';
		PRINT '================================';

		PRINT '--------------------------------';
		PRINT 'lOADING CRM TABLES';
		PRINT '--------------------------------';

		SET @BATCH_START_TIME = GETDATE();
		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> INSERTING DATA INTO: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';

		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> INSERTING DATA INTO: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';

		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> INSERTING DATA INTO: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';

		PRINT '--------------------------------';
		PRINT 'lOADING ERP TABLES';
		PRINT '--------------------------------';

		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> INSERTING DATA INTO: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';

		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> INSERTING DATA INTO: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';

		SET @START_TIME = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> INSERTING DATA INTO: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\hp\OneDrive\Documents\Data Engineering Project\Sql data warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @END_TIME = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@START_TIME,@END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------';
		
		SET @BATCH_END_TIME = GETDATE();
		PRINT '----------------------------------------------------';
		PRINT 'LOADING BRONZE LAYER IS COMPLETED';
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@BATCH_START_TIME,@BATCH_END_TIME) AS NVARCHAR) + 'SECONDS';
		PRINT '----------------------------------------------------';
	END TRY
	BEGIN CATCH
		PRINT '----------------------------------------------------';
		PRINT 'ERROR OCCURED DURING LOADING THE BRONZE LAYER';
		PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
		PRINT 'ERROR NUMBER ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '----------------------------------------------------';
	END CATCH
END;

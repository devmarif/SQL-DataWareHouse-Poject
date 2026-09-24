/*==============================================================================
    PROCEDURE: bronze.load_bronze
==============================================================================

    Purpose:
        Loads raw data from CRM and ERP source files into the Bronze layer.

    Process:
        1. Capture the ETL start time.
        2. Truncate existing Bronze tables.
        3. Bulk load data from source CSV files.
        4. Display the number of rows loaded for each table.
        5. Capture the ETL end time.
        6. Display the total execution duration.
        7. Handle and report errors using TRY...CATCH.

    Load Strategy:
        FULL REFRESH

        Existing data is removed using TRUNCATE TABLE before each
        source file is loaded.

    Source Systems:
        CRM
        ERP

    Target Layer:
        Bronze

==============================================================================*/


CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    /*==========================================================================
        ETL EXECUTION VARIABLES
    ==========================================================================*/

    DECLARE @StartTime DATETIME2;
    DECLARE @EndTime   DATETIME2;
    DECLARE @RowsLoaded INT;


    BEGIN TRY

        /*======================================================================
            START ETL PROCESS
        ======================================================================*/

        SET @StartTime = SYSDATETIME();

        PRINT '==============================================================';
        PRINT 'BRONZE LAYER LOAD STARTED';
        PRINT '==============================================================';

        PRINT 'Start Time: '
            + CONVERT(VARCHAR(30), @StartTime, 121);


        /*======================================================================
            CRM CUSTOMER INFORMATION
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.crm_customer_info';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.crm_customer_info;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from cust_info.csv...';

        BULK INSERT Bronze.crm_customer_info
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'CRM customer information loaded successfully.';


        /*======================================================================
            CRM PRODUCT INFORMATION
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.crm_product_info';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.crm_product_info;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from prd_info.csv...';

        BULK INSERT Bronze.crm_product_info
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'CRM product information loaded successfully.';


        /*======================================================================
            CRM SALES INFORMATION
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.crm_sales_info';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.crm_sales_info;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from sales_details.csv...';

        BULK INSERT Bronze.crm_sales_info
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'CRM sales information loaded successfully.';


        /*======================================================================
            ERP CUSTOMER CATEGORIES
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.erp_customer_categories';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.erp_customer_categories;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from PX_CAT_G1V2.csv...';

        BULK INSERT Bronze.erp_customer_categories
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'ERP customer categories loaded successfully.';


        /*======================================================================
            ERP CUSTOMER INFORMATION
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.erp_customer_info';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.erp_customer_info;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from CUST_AZ12.csv...';

        BULK INSERT Bronze.erp_customer_info
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'ERP customer information loaded successfully.';


        /*======================================================================
            ERP CUSTOMER LOCATION
        ======================================================================*/

        PRINT '--------------------------------------------------------------';
        PRINT 'Loading: Bronze.erp_customer_location';

        PRINT 'Truncating table...';

        TRUNCATE TABLE Bronze.erp_customer_location;

        PRINT 'Table truncated successfully.';

        PRINT 'Loading data from LOC_A101.csv...';

        BULK INSERT Bronze.erp_customer_location
        FROM 'C:\UA3\Data WareHouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @RowsLoaded = @@ROWCOUNT;

        PRINT 'Rows Loaded: '
            + CAST(@RowsLoaded AS VARCHAR(20));

        PRINT 'ERP customer location loaded successfully.';


        /*======================================================================
            ETL COMPLETION
        ======================================================================*/

        SET @EndTime = SYSDATETIME();

        PRINT '==============================================================';
        PRINT 'BRONZE LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT '==============================================================';

        PRINT 'Start Time: '
            + CONVERT(VARCHAR(30), @StartTime, 121);

        PRINT 'End Time:   '
            + CONVERT(VARCHAR(30), @EndTime, 121);

        PRINT 'Total Duration: '
            + CAST(
                DATEDIFF(SECOND, @StartTime, @EndTime)
                AS VARCHAR(20)
              )
            + ' seconds';

        PRINT 'Status: SUCCESS';

        PRINT '==============================================================';

    END TRY


    /*==========================================================================
        ERROR HANDLING
    ==========================================================================*/

    BEGIN CATCH

        SET @EndTime = SYSDATETIME();

        PRINT '==============================================================';
        PRINT 'BRONZE LAYER LOAD FAILED';
        PRINT '==============================================================';

        PRINT 'Start Time: '
            + CONVERT(VARCHAR(30), @StartTime, 121);

        PRINT 'End Time:   '
            + CONVERT(VARCHAR(30), @EndTime, 121);

        PRINT 'Duration: '
            + CAST(
                DATEDIFF(SECOND, @StartTime, @EndTime)
                AS VARCHAR(20)
              )
            + ' seconds';

        PRINT '--------------------------------------------------------------';

        PRINT 'Error Number: '
            + CAST(ERROR_NUMBER() AS VARCHAR(20));

        PRINT 'Error Severity: '
            + CAST(ERROR_SEVERITY() AS VARCHAR(20));

        PRINT 'Error State: '
            + CAST(ERROR_STATE() AS VARCHAR(20));

        PRINT 'Error Line: '
            + CAST(ERROR_LINE() AS VARCHAR(20));

        PRINT 'Error Procedure: '
            + ISNULL(ERROR_PROCEDURE(), 'N/A');

        PRINT 'Error Message: '
            + ERROR_MESSAGE();

        PRINT 'Status: FAILED';

        PRINT '==============================================================';


        /*----------------------------------------------------------------------
            Re-throw the original error so SQL Server/SSMS also recognizes
            the procedure execution as failed.
        ----------------------------------------------------------------------*/

        THROW;

    END CATCH

END;
GO

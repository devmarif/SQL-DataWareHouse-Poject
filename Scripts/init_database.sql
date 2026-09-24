/*==============================================================================
    DATA WAREHOUSE DATABASE SETUP
==============================================================================

    Purpose:
        Creates and initializes the DataWarehouse database using a
        layered data warehouse architecture.

    Process:
        1. Switch to the master database.
        2. Check whether the DataWarehouse database already exists.
        3. If it exists:
            - Force existing connections to disconnect.
            - Roll back active transactions.
            - Drop the existing database.
        4. Create a new DataWarehouse database.
        5. Create the Bronze, Silver, and Gold schemas.

    Data Warehouse Architecture:

        Source Systems
              |
              v
        +-------------+
        |   BRONZE    |  Raw / source data
        +-------------+
              |
              v
        +-------------+
        |   SILVER    |  Cleaned & transformed data
        +-------------+
              |
              v
        +-------------+
        |    GOLD     |  Business-ready data
        +-------------+
              |
              v
        Reporting / Analytics

    Schema Responsibilities:

        BRONZE
            Stores raw data extracted from source systems.
            Data is preserved with minimal transformation.

        SILVER
            Stores cleaned, validated, standardized, and transformed data.
            This layer prepares data for analytical processing.

        GOLD
            Stores business-ready data designed for reporting,
            analytics, dashboards, and downstream consumption.

    WARNING:
        This script DROPS the existing DataWarehouse database if it exists.

        Dropping the database permanently removes:
            - Tables
            - Data
            - Views
            - Stored procedures
            - Functions
            - Other database objects

        Execute this script only when a database reset or rebuild
        is intentionally required.

==============================================================================*/


/*------------------------------------------------------------------------------
    STEP 1: Switch to the master database

    The master database is used because the DataWarehouse database may
    need to be dropped before it can be recreated.
------------------------------------------------------------------------------*/

USE Master;
GO


/*------------------------------------------------------------------------------
    STEP 2: Remove the existing DataWarehouse database

    Check whether the database exists.

    If it exists:
        1. Set the database to SINGLE_USER mode.
        2. Immediately terminate existing connections.
        3. Roll back active transactions.
        4. Drop the database.

    SINGLE_USER with ROLLBACK IMMEDIATE ensures that active connections
    are terminated and pending transactions are rolled back.
------------------------------------------------------------------------------*/

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
        SET SINGLE_USER
        WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO


/*------------------------------------------------------------------------------
    STEP 3: Create the DataWarehouse database
------------------------------------------------------------------------------*/

CREATE DATABASE DataWarehouse;
GO


/*------------------------------------------------------------------------------
    STEP 4: Switch to the newly created DataWarehouse database
------------------------------------------------------------------------------*/

USE DataWarehouse;
GO


/*==============================================================================
    STEP 5: Create Data Warehouse Schemas

    The database follows a layered architecture consisting of three
    primary data processing layers:

        Bronze -> Silver -> Gold

    Each layer has a specific responsibility in the data pipeline.
==============================================================================*/


/*------------------------------------------------------------------------------
    Bronze Schema

    Purpose:
        Stores raw data extracted from source systems.

    Transformation:
        Minimal transformation.
------------------------------------------------------------------------------*/

CREATE SCHEMA Bronze;
GO


/*------------------------------------------------------------------------------
    Silver Schema

    Purpose:
        Stores cleaned, validated, standardized, and transformed data.

    Transformation:
        Data quality and business transformation logic is applied here.
------------------------------------------------------------------------------*/

CREATE SCHEMA Silver;
GO


/*------------------------------------------------------------------------------
    Gold Schema

    Purpose:
        Stores business-ready data optimized for reporting and analytics.

    Consumption:
        BI dashboards, reports, analytical queries, and other
        downstream applications.
------------------------------------------------------------------------------*/

CREATE SCHEMA Gold;
GO


/*==============================================================================
    END OF DATA WAREHOUSE DATABASE SETUP
==============================================================================*/

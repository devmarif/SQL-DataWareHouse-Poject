/*==============================================================================
    BRONZE LAYER - TABLE DEFINITIONS
==============================================================================

    Purpose:
        Creates the raw/source tables for the Bronze layer of the
        DataWarehouse.

    Bronze Layer Responsibilities:
        - Stores raw data from source systems.
        - Preserves source-level information.
        - Applies minimal transformation.
        - Acts as the initial landing layer for data ingestion.
        - Provides source data for the Silver layer.

    Source Systems:
        CRM
            - Customer information
            - Product information
            - Sales information

        ERP
            - Customer information
            - Customer location
            - Customer categories

    Naming Convention:
        bronze.crm_* -> CRM source tables
        bronze.erp_* -> ERP source tables

==============================================================================*/


/*==============================================================================
    CRM CUSTOMER INFORMATION
==============================================================================

    Purpose:
        Stores customer demographic and account information
        received from the CRM source system.

==============================================================================*/

IF OBJECT_ID('bronze.crm_customer_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_customer_info;

CREATE TABLE bronze.crm_customer_info
(
    cst_id              INT,
    cst_key             nvarchar(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_maritalstatus   NVARCHAR(50),
    cst_gender          NVARCHAR(50),
    cst_create_date     DATE
);


/*==============================================================================
    CRM PRODUCT INFORMATION
==============================================================================

    Purpose:
        Stores product information received from the CRM source system.

==============================================================================*/

IF OBJECT_ID('bronze.crm_product_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_product_info;

CREATE TABLE bronze.crm_product_info
(
    prd_id          INT,
    prd_key         NVARCHAR(50),
    prd_name        NVARCHAR(50),
    prd_cost        DECIMAL(10,2),
    prd_line        NVARCHAR(50),
    prd_start_date  DATETIME,
    prd_end_date    DATETIME
);


/*==============================================================================
    CRM SALES INFORMATION
==============================================================================

    Purpose:
        Stores sales transaction information received from the CRM
        source system.

==============================================================================*/

IF OBJECT_ID('bronze.crm_sales_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_info;

CREATE TABLE bronze.crm_sales_info
(
    sales_ord_num      NVARCHAR(50),
    sales_order_key    NVARCHAR(50),
    sales_cst_id       INT,
    sales_order_date   NVARCHAR(50),
    sales_ship_date    NVARCHAR(50),
    sales_due_date    NVARCHAR(50),
    sales_sales       NVARCHAR(50),
    sales_quantity    NVARCHAR(50),
    sales_price       NVARCHAR(50),
);


/*==============================================================================
    ERP CUSTOMER INFORMATION
==============================================================================

    Purpose:
        Stores customer demographic information received from the ERP
        source system.

==============================================================================*/

IF OBJECT_ID('bronze.erp_customer_info', 'U') IS NOT NULL
    DROP TABLE bronze.erp_customer_info;

CREATE TABLE bronze.erp_customer_info
(
    cust_id      NVARCHAR(50),
    cust_bdate   DATE,
    cust_gender  NVARCHAR(50)
);


/*==============================================================================
    ERP CUSTOMER LOCATION
==============================================================================

    Purpose:
        Stores geographical information associated with customers.

==============================================================================*/

IF OBJECT_ID('bronze.erp_customer_location', 'U') IS NOT NULL
    DROP TABLE bronze.erp_customer_location;

CREATE TABLE bronze.erp_customer_location
(
    cust_id       NVARCHAR(50),
    cust_country  NVARCHAR(50)
);


/*==============================================================================
    ERP CUSTOMER CATEGORIES
==============================================================================

    Purpose:
        Stores customer classification and category information
        received from the ERP source system.

==============================================================================*/

IF OBJECT_ID('bronze.erp_customer_categories', 'U') IS NOT NULL
    DROP TABLE bronze.erp_customer_categories;

CREATE TABLE bronze.erp_customer_categories
(
    cust_id            NVARCHAR(50),
    cust_category      NVARCHAR(50),
    cust_sub_category  NVARCHAR(50),
    cust_maintenance   NVARCHAR(50)
);


/*==============================================================================
    END OF BRONZE LAYER TABLE DEFINITIONS
==============================================================================*/


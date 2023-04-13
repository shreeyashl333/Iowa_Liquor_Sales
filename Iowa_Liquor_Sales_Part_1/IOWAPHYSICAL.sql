/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Iowa_DimensionalModel.DM1
 *
 * Date Created : Friday, April 07, 2023 20:11:20
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: Dim_Date 
 */

CREATE TABLE Dim_Date(
    InvoiceDateSK    int            NOT NULL,
    Invoice_Date     datetime       NULL,
    Invoice_Year     varchar(10)    NULL,
    DI_CreateDate    datetime       DEFAULT getdate() NOT NULL,
    DI_JobID         varchar(10)    NULL,
    CONSTRAINT PK34 PRIMARY KEY NONCLUSTERED (InvoiceDateSK)
)

go


IF OBJECT_ID('Dim_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Date >>>'
go

/* 
 * TABLE: Dim_iowa_city 
 */

CREATE TABLE Dim_iowa_city(
    City_SK            int            IDENTITY(1,1),
    City               varchar(24)    NULL,
    FIPS               int            NULL,
    DateAsOf           datetime       NULL,
    Population         int            NULL,
    Population_Year    int            NULL,
    DI_JobID           varchar(20)    NULL,
    DI_CreateDate      datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK36 PRIMARY KEY NONCLUSTERED (City_SK)
)

go


IF OBJECT_ID('Dim_iowa_city') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_iowa_city >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_iowa_city >>>'
go

/* 
 * TABLE: Dim_iowa_county 
 */

CREATE TABLE Dim_iowa_county(
    County_SK          int            IDENTITY(1,1),
    County             varchar(80)    NULL,
    FIPS               int            NULL,
    DateAsOf           date           NOT NULL,
    Population         int            NULL,
    Population_Year    int            NOT NULL,
    DI_JobID           varchar(20)    NULL,
    DI_CreateDate      datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK35 PRIMARY KEY NONCLUSTERED (County_SK)
)

go


IF OBJECT_ID('Dim_iowa_county') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_iowa_county >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_iowa_county >>>'
go

/* 
 * TABLE: Dim_iowa_liquor_Product_Categories 
 */

CREATE TABLE Dim_iowa_liquor_Product_Categories(
    Category_SK        int            IDENTITY(1,1),
    Category_Number    int            NOT NULL,
    Category_Name      varchar(40)    NULL,
    DI_JobID           varchar(20)    NULL,
    DI_CreateDate      datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK29 PRIMARY KEY NONCLUSTERED (Category_SK)
)

go


IF OBJECT_ID('Dim_iowa_liquor_Product_Categories') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_iowa_liquor_Product_Categories >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_iowa_liquor_Product_Categories >>>'
go

/* 
 * TABLE: Dim_iowa_liquor_Products 
 */

CREATE TABLE Dim_iowa_liquor_Products(
    Item_SK                numeric(10, 0)    NOT NULL,
    Item_Number            int               NOT NULL,
    Item_Number_C          varchar(20)       NULL,
    Item_Description       varchar(80)       NULL,
    Category_SK            int               NULL,
    Vendor_SK              int               NULL,
    Bottle_Volume_ml       int               NULL,
    Pack                   int               NULL,
    Inner_Pack             int               NULL,
    Age                    int               NULL,
    Proof                  int               NULL,
    List_Date              date              NULL,
    UPC                    varchar(20)       NULL,
    SCC                    varchar(20)       NULL,
    State_Bottle_Cost      decimal(19, 4)    NULL,
    State_Case_Cost        decimal(19, 4)    NULL,
    State_Bottle_Retail    decimal(19, 4)    NULL,
    Report_Date            date              NULL,
    DI_JobID               varchar(20)       NULL,
    DI_CreateDate          datetime          DEFAULT getdate() NOT NULL,
    CONSTRAINT PK27 PRIMARY KEY NONCLUSTERED (Item_SK)
)

go


IF OBJECT_ID('Dim_iowa_liquor_Products') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_iowa_liquor_Products >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_iowa_liquor_Products >>>'
go

/* 
 * TABLE: Dim_Iowa_Liquor_Stores 
 */

CREATE TABLE Dim_Iowa_Liquor_Stores(
    Store_SK         int            NOT NULL,
    City_SK          int            NULL,
    County_SK        int            NULL,
    Store_ID         int            NOT NULL,
    Store_Name       varchar(80)    NULL,
    Store_Status     char(1)        NULL,
    Address          varchar(80)    NULL,
    Zip_Code         int            NULL,
    DI_JobID         varchar(20)    NULL,
    DI_CreateDate    datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK30 PRIMARY KEY NONCLUSTERED (Store_SK)
)

go


IF OBJECT_ID('Dim_Iowa_Liquor_Stores') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Iowa_Liquor_Stores >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Iowa_Liquor_Stores >>>'
go

/* 
 * TABLE: Dim_iowa_liquor_Vendors 
 */

CREATE TABLE Dim_iowa_liquor_Vendors(
    Vendor_SK        int            NOT NULL,
    Vendor_Number    int            NOT NULL,
    Vendor_Name      varchar(80)    NULL,
    DI_JobID         varchar(20)    NULL,
    DI_CreateDate    datetime       DEFAULT getdate() NOT NULL,
    CONSTRAINT PK28 PRIMARY KEY NONCLUSTERED (Vendor_SK)
)

go


IF OBJECT_ID('Dim_iowa_liquor_Vendors') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_iowa_liquor_Vendors >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_iowa_liquor_Vendors >>>'
go

/* 
 * TABLE: fct_iowa_liquor_sales_invoice_header 
 */

CREATE TABLE fct_iowa_liquor_sales_invoice_header(
    Invoice_Number                 varchar(24)       NOT NULL,
    Store_SK                       int               NULL,
    Store_Number                   int               NULL,
    Invoice_Bottles_Sold           int               NULL,
    Invoice_Sale_Dollars           numeric(19, 4)    NULL,
    Invoice_Volume_Sold_Liters     numeric(19, 4)    NULL,
    Invoice_Volume_Sold_Gallons    numeric(19, 4)    NULL,
    DI_JobID                       varchar(20)       NULL,
    DI_CreateDate                  datetime          DEFAULT getdate() NOT NULL,
    InvoiceDateSK                  int               NULL,
    CONSTRAINT PK25 PRIMARY KEY NONCLUSTERED (Invoice_Number)
)

go


IF OBJECT_ID('fct_iowa_liquor_sales_invoice_header') IS NOT NULL
    PRINT '<<< CREATED TABLE fct_iowa_liquor_sales_invoice_header >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE fct_iowa_liquor_sales_invoice_header >>>'
go

/* 
 * TABLE: fct_iowa_liquor_sales_invoice_lineitem 
 */

CREATE TABLE fct_iowa_liquor_sales_invoice_lineitem(
    Invoice_Item_Number       numeric(10, 0)    NOT NULL,
    Invoice_Number            varchar(24)       NULL,
    Invoice__Number_LineNo    numeric(10, 0)    NOT NULL,
    Item_Number               varchar(24)       NULL,
    Pack                      int               NULL,
    Bottle_Volume_ml          int               NULL,
    State_Bottle_Cost         numeric(19, 4)    NULL,
    State_Bottle_Retail       numeric(19, 4)    NULL,
    Bottles_Sold              int               NULL,
    Sale_Dollars              numeric(19, 4)    NULL,
    Volume_Sold_Liters        numeric(19, 4)    NULL,
    Volume_Sold_Gallons       numeric(19, 4)    NULL,
    DI_JobID                  varchar(20)       NULL,
    DI_CreateDate             datetime          DEFAULT getdate() NOT NULL,
    Item_SK                   numeric(10, 0)    NULL,
    CONSTRAINT PK26 PRIMARY KEY NONCLUSTERED (Invoice_Item_Number)
)

go


IF OBJECT_ID('fct_iowa_liquor_sales_invoice_lineitem') IS NOT NULL
    PRINT '<<< CREATED TABLE fct_iowa_liquor_sales_invoice_lineitem >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE fct_iowa_liquor_sales_invoice_lineitem >>>'
go

/* 
 * TABLE: Dim_iowa_liquor_Products 
 */

ALTER TABLE Dim_iowa_liquor_Products ADD CONSTRAINT RefDim_iowa_liquor_Product_Categories17 
    FOREIGN KEY (Category_SK)
    REFERENCES Dim_iowa_liquor_Product_Categories(Category_SK)
go

ALTER TABLE Dim_iowa_liquor_Products ADD CONSTRAINT RefDim_iowa_liquor_Vendors18 
    FOREIGN KEY (Vendor_SK)
    REFERENCES Dim_iowa_liquor_Vendors(Vendor_SK)
go


/* 
 * TABLE: Dim_Iowa_Liquor_Stores 
 */

ALTER TABLE Dim_Iowa_Liquor_Stores ADD CONSTRAINT RefDim_iowa_city29 
    FOREIGN KEY (City_SK)
    REFERENCES Dim_iowa_city(City_SK)
go

ALTER TABLE Dim_Iowa_Liquor_Stores ADD CONSTRAINT RefDim_iowa_county30 
    FOREIGN KEY (County_SK)
    REFERENCES Dim_iowa_county(County_SK)
go


/* 
 * TABLE: fct_iowa_liquor_sales_invoice_header 
 */

ALTER TABLE fct_iowa_liquor_sales_invoice_header ADD CONSTRAINT RefDim_Date28 
    FOREIGN KEY (InvoiceDateSK)
    REFERENCES Dim_Date(InvoiceDateSK)
go

ALTER TABLE fct_iowa_liquor_sales_invoice_header ADD CONSTRAINT RefDim_Iowa_Liquor_Stores14 
    FOREIGN KEY (Store_SK)
    REFERENCES Dim_Iowa_Liquor_Stores(Store_SK)
go


/* 
 * TABLE: fct_iowa_liquor_sales_invoice_lineitem 
 */

ALTER TABLE fct_iowa_liquor_sales_invoice_lineitem ADD CONSTRAINT Reffct_iowa_liquor_sales_invoice_header15 
    FOREIGN KEY (Invoice_Number)
    REFERENCES fct_iowa_liquor_sales_invoice_header(Invoice_Number)
go

ALTER TABLE fct_iowa_liquor_sales_invoice_lineitem ADD CONSTRAINT RefDim_iowa_liquor_Products23 
    FOREIGN KEY (Item_SK)
    REFERENCES Dim_iowa_liquor_Products(Item_SK)
go



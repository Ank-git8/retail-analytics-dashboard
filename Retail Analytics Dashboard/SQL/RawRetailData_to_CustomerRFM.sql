CREATE DATABASE RetailAnalytics;

USE RetailAnalytics;


-- Step 1: Creating Table for the Raw Data
CREATE TABLE RawRetailData (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);



 
-- Loading the data into the created table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Online Retail.csv'
INTO TABLE RawRetailData
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@InvoiceNo, @StockCode, @Description, @Quantity, @InvoiceDate, @UnitPrice, @CustomerID, @Country)
SET 
InvoiceNo = @InvoiceNo,
StockCode = @StockCode,
Description = @Description,
Quantity = @Quantity,
InvoiceDate = STR_TO_DATE(@InvoiceDate, '%d-%m-%Y %H:%i'),
UnitPrice = @UnitPrice,
CustomerID = @CustomerID,
Country = @Country;


-- For checking the health of the data / Data Quality of the raw data
SELECT 
    COUNT(*) AS Total_Imported_Rows,
    SUM(CASE WHEN CustomerID IS NULL OR CustomerID = '' THEN 1 ELSE 0 END) AS Missing_IDs,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS Invalid_Quantities,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS Invalid_Prices
FROM RawRetailData;


-- Step 2. Create the Cleaned table for the genuine orders
CREATE TABLE CleanedRetail AS 
SELECT 
    InvoiceNo,
    StockCode,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    ROUND((Quantity * UnitPrice), 2) AS Revenue
FROM RawRetailData
WHERE CustomerID IS NOT NULL				 -- excluding null customer_ids
  AND LOWER(CustomerID) != 'null' 			 
  AND LENGTH(TRIM(CustomerID)) > 0   		      
  AND Quantity > 0							 -- Taking only the genuine orders
  AND UnitPrice > 0.01;						 

--  Check the final count of cleaded data
SELECT COUNT(*) FROM CleanedRetail;



-- Step 3: Aggregate the data into the RFM format
CREATE TABLE Customer_RFM AS
SELECT 
    CustomerID,
    -- Recency: Days between "Today" (Dec 10, 2011) and their last purchase
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    
    -- Frequency: How many separate shopping trips did they make?
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    
    -- Monetary: What is the total revenue they generated?
    ROUND(SUM(Revenue), 2) AS Monetary
FROM CleanedRetail
GROUP BY CustomerID;


-- Check how many unique customers I have 
SELECT COUNT(*) FROM Customer_RFM;




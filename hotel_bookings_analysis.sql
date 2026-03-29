-- Hotel Booking Cancellation Analysis
-- Author: Fiker Desta
-- Description: SQL analysis of hotel booking cancellations using the Hotel Booking Demand
-- dataset from Kaggle

-- Use the database
USE hotel_bookings;

-- Clear existing data
TRUNCATE TABLE bookings;

-- Import the data
BULK INSERT bookings
FROM 'C:\Users\fiker\Documents\Data Analytics Projects\Project 1 - Hotel Bookings\hotel_bookings_cleaned.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Check total rows
SELECT COUNT(*) AS total_rows 
FROM bookings;

-- Check first 5 rows
SELECT TOP 5 * 
FROM bookings;

-- Check column names and data types
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'bookings';

-- Overall Cancellation Rate
SELECT COUNT(*) AS total_bookings,
	   SUM(is_canceled) AS total_cancellations, 
	   ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings;

-- Cancellation by Hotel Type
SELECT hotel,
	   COUNT(*) AS total_bookings,
	   SUM(is_canceled) AS total_cancellations,
	   ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY hotel
ORDER BY cancellation_rate DESC;

-- Cancellation by Month
SELECT arrival_date_month,
	COUNT(*) AS total_bookings,
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY arrival_date_month
ORDER BY cancellation_rate DESC;


-- Top 10 Countries by Cancellation Rate
SELECT TOP 10
	country,
	COUNT(*) AS total_bookings, 
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY country
HAVING COUNT(*) > 100
ORDER BY cancellation_rate DESC;

-- Cancellation by Market Segment
SELECT 
    market_segment,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY market_segment
ORDER BY cancellation_rate DESC;

-- Average ADR by Cancellation
SELECT
	is_canceled,
	COUNT(*) AS total_bookings,
	ROUND(AVG(adr), 2) AS avg_adr,
	ROUND(MIN(adr), 2) AS min_adr,
	ROUND(MAX(adr), 2) AS max_adr
FROM bookings
GROUP BY is_canceled
ORDER BY is_canceled;

-- Cancellation by Lead Time Buckets
-- Key Findings:
-- - Bookings made 180+ days in advance cancel 39.74% of the time
-- - Bookings made 0-30 days in advance cancel only 16.42% of the time
-- - The longer the lead time, the higher the cancellation rate

SELECT 
	CASE WHEN lead_time BETWEEN 0 and 30 THEN '0-30 days'
	 WHEN lead_time BETWEEN 31 and 60 THEN '31-60 days'
	 WHEN lead_time BETWEEN 61 AND 90 THEN '61-90 days'
	 WHEN lead_time BETWEEN 91 AND 180 THEN '91-180 days'
	 WHEN lead_time > 180 THEN '180+ days'
	END AS lead_time_bucket,
	COUNT(*) AS total_bookings,
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY
	CASE WHEN lead_time BETWEEN 0 and 30 THEN '0-30 days'
		 WHEN lead_time BETWEEN 31 and 60 THEN '31-60 days'
		 WHEN lead_time BETWEEN 61 AND 90 THEN '61-90 days'
		 WHEN lead_time BETWEEN 91 AND 180 THEN '91-180 days'
		 WHEN lead_time > 180 THEN '180+ days'
	END
ORDER BY cancellation_rate DESC;

-- Cancellation by Customer Type
SELECT customer_type,
	   COUNT(*) AS total_bookings,
	   SUM(is_canceled) AS total_cancellations,
	   ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY customer_type
ORDER BY cancellation_rate DESC;

-- Cancellation by Special Requests
-- Key Findings:
-- - Customers with 0 special requests cancel 33.21% of the time
-- - Customers with 5 special requests cancel only 5.56% of the time
-- - More special requests = more commited customer = less likely to cancel

SELECT total_of_special_requests,
	COUNT(*) AS total_bookings,
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY total_of_special_requests
ORDER BY total_of_special_requests ASC;

-- Cancellation by Deposit Type
-- One of the most surprising findings in this analysis is that 
-- non-refundable deposits have by far the highest cancellation rate at 94.70%.
 
 -- You would expect customers to think twice before cancelling a
 -- non-refundable booking, but the data suggests otherwise

 -- Refundable deposits are the most reliable at 24.30%, while
 -- no deposit bookings sit in the middle at 26.69%.

 -- This raises an important question for hotels: are
 -- non-refundable policies actually working as intended?

SELECT deposit_type,
	COUNT(*) AS total_bookings,
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM bookings
GROUP BY deposit_type
ORDER BY cancellation_rate DESC;

-- OVERALL SUMMARY
-- This final query brings together all the key metrics
-- from our analysis into one clean summary. It gives a 
-- quick snapshot of the overall booking and cancellation
-- performance across the entire dataset.

SELECT 
	COUNT(*) AS total_bookings,
	SUM(is_canceled) AS total_cancellations,
	ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate,
	ROUND(AVG(adr), 2) AS avg_price_per_night,
	ROUND(AVG(lead_time), 2) AS avg_lead_time_days,
	ROUND(AVG(total_of_special_requests), 2) AS avg_special_requests,
	ROUND(AVG(stays_in_week_nights + stays_in_weekend_nights), 2) AS avg_length_of_stay
FROM bookings;
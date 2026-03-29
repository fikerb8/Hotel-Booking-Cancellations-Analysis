# Hotel-Booking-Cancellations-Analysis

## Overview
This Project takes a deep dive into hotel booking data to understand 
why cancellations happen and what hotels can do about it. Using a real-world 
dataset of 87,389 bookings from Kaggle, I worked through the full data analytics
pipelinefrom raw data all the way to an interactive dashboard.

## Tools Used
- **Python** (Pandas, NumPy, Matplotlib, Seaborn) - data cleaning and exploration
- **SQL** (Microsoft SQL Server) - querying and analyzing the data
- **Power BI** - building the interactive dashboard
- **Jupyter Notebook** - documenting the analysis

  ## Dataset
  The dataset comes from kaggle's Hotel Booking Demand dataset and covers
  bookings from two hotels between 2015 and 2017. After cleaning, it contained
  87,389 rows and 32 columns.

  ## What I Found
  The overall cancellation rate sits at 27.49% which means roughly 1 in 4 bookings
  gets cancelled. City hotels cancel more often than resort hotels, and summer
  months like August and July see the highest cancellation rates. One of the
  most surprising findings was that non-refundable bookings has a 94.70%
  cancellation rate - customers cancel even when they lose their deposit money.

  Bookings made further in advance are also much more likely to cancel. Customers
  who booked 180+ days ahead cancelled nearly 40% of the time, compared to just
  16% for those who booked within 30 days.

  ## Business Recommendations
  Hotels looking to reduce cancellations should focus on attracting more
  direct and corporate bookings rather than relying heavily on online travel
  agencies. Encouraging customers to make special requests during booking also
  helps - the data shows that customers who made 5 special requests cancelled
  only 5.56% of the time compared to 33% for those who made none.

## Project Files
- 'Hotel Booking Analysis.ipynb' - Full Python Analysis
- 'hotel_bookings_analysis.sql' - SQL queries
- 'Hotel Booking Cancellations Dashboard.pbix' - Power BI dashboard
- 'hotel_bookings_cleaned.csv' - cleaned dataset

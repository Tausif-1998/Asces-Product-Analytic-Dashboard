# Asces-Product-Analytic-Dashboard

Developed a high-level Product Analytics Dashboard that provides insights into key product performance metrics. This dashboard will support strategic decision-making and allow business team to track performance trends effectively.

# Steps-to-follow
1. Build a Database: Extract data from CSV files.
2. Develop SQL: Create a SQL query to view required data.
2. Connect to Power BI : Import data from SQL to Power BI by using SQL query.
3. Create a Dashboard : Create Visualizations.

**SQL query to import data from SQL to Power BI**
with cte as(select 
pd.Product,pd.category,pd.brand, pd.description, pd.image_url, pd.sale_price, pd.Cost_price,
ps.customer_type, ps.Date, ps.units_sold, ps.discount_band, ps.country,
(pd.Sale_Price*ps.Units_Sold) as Revenue,
(pd.Cost_Price*ps.Units_Sold) as [Total Cost],
FORMAT(date,'MMMM') as Month,
FORMAT(date,'yyyy') as Year
from Product_data pd 
join product_sales ps 
on pd.Product_ID=ps.Product)
select * ,(1-Discount*1.0/100)*Revenue as Discounted_revenue
from cte
join discount_data dd on cte.Discount_Band=dd.Discount_Band and cte.Month=dd.Month

**Power BI Dashboard Overview**
1. Revenue by Country: Top-performing regions with corresponding revenue.
2. Revenue by Date and Year: Comparative trends
3. Profit and Unit Sales Year-over-Year (YoY) Change: High-level summary of YoY growth.
4. Revenue Breakdown by Discount Band: Distribution of revenue across different discount categories.
5. Detailed Table View: Revenue and profit details by country and year.
 
**To create a Date table**
DAX formula:   Calendar = CALENDAR("1/1/2022","12/31/2023")

**Custom Column*
1. Profit = Discounted_revenue - Total Cost
   
**DAX queries**
1. Profit YOY = 
  var last_year=CALCULATE(SUM(Query1[Profit]),DATEADD('Calendar'[Date].[Date],-1,YEAR))
  RETURN
  (SUM(Query1[Profit])-last_year)/last_year
2. Unit_Sold YOY = 
  var last_year=CALCULATE(SUM(Query1[units_sold]),DATEADD('Calendar'[Date].[Date],-1,YEAR))
  RETURN
  (SUM(Query1[units_sold])-last_year)/last_year


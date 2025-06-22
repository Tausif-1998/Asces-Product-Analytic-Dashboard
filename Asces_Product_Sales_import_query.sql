with cte as
(select 
pd.Product,pd.category,pd.brand, pd.description, pd.image_url, pd.sale_price, pd.Cost_price,
ps.customer_type, ps.Date, ps.units_sold, ps.discount_band, ps.country,
(pd.Sale_Price*ps.Units_Sold) as Revenue,
(pd.Cost_Price*ps.Units_Sold) as [Total Cost],
FORMAT(date,'MMMM') as Month,
FORMAT(date,'yyyy') as Year
from Product_data pd 
join product_sales ps 
on pd.Product_ID=ps.Product)

select * ,
(1-Discount*1.0/100)*Revenue as Discounted_revenue
from cte
join discount_data dd 
on cte.Discount_Band=dd.Discount_Band and cte.Month=dd.Month

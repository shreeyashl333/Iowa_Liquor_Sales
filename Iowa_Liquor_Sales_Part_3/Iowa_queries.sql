
-- Sales $
select sum([Invoice_Sale_Dollars]) as TotalSales from [dbo].fct_iowa_liquor_sales_invoice_header;

-- Sales volume (gallons)

select sum([Invoice_Volume_Sold_Gallons]) as TotalSalesbyVolumeinGallons from [dbo].fct_iowa_liquor_sales_invoice_header;

-- Sales volume (bottles)
select sum([Invoice_Bottles_Sold]) as SalesbyBottle from [dbo].fct_iowa_liquor_sales_invoice_header;

--Gross profit (retail price – cost)
select sum([State_Bottle_Retail]*[Bottles_Sold]) - sum([State_Bottle_Cost]*[Bottles_Sold]) as GrossProfit from [dbo].[fct_iowa_liquor_sales_invoice_lineitem];

--Sales $ per Capita (City)
select sum([Sale_Dollars])/(select sum([Population]) from [dbo].[FCT_iowa_city_population_by_year]) as Sales_per_capita_by_city from [dbo].[fct_iowa_liquor_sales_invoice_lineitem];

--Sales $ per Capita (County)
select sum([Sale_Dollars])/(select sum([Population]) from [dbo].[FCT_iowa_county_population_by_year]) as Sales_per_capita_by_county from [dbo].[fct_iowa_liquor_sales_invoice_lineitem];

-- Sales $ per Capita

Select YEAR(str_to_date(h.Invoice_Date, '%m/%d/%Y')) as Order_Date, y.City, ROUND(sum(h.Invoice_Sale_Dollars)/y.population,2) AS Total_Sales
from fct_iowa_liquor_sales_invoice_header h, FCT_iowa_city_population_by_year y, Dim_Iowa_Liquor_Stores st
where h.Store_SK = st.Store_SK and st.City_SK = y.City_SK
Group BY Order_Date, y.City
Order By Order_Date, y.City;

--Liquor sales by dimension - store
select top 10 s.[Store_Name],  (sum(h.[Invoice_Sale_Dollars])) from [dbo].[Dim_Iowa_Liquor_Stores] s 
join [dbo].[fct_iowa_liquor_sales_invoice_header] h on h.Store_SK = s.Store_SK group by s.[Store_Name]
order by 2 desc

----Liquor sales by dimension - County
-- County

select top 10 ct.County,ROUND(sum(h.Invoice_Sale_Dollars),2) AS Total_Sales
from fct_iowa_liquor_sales_invoice_header h, Dim_iowa_county ct, Dim_Iowa_Liquor_Stores st
where h.Store_SK = st.Store_SK and st.County_SK = ct.County_SK
group by ct.County
order by ct.County;



----Liquor sales by dimension - City

select top 10 c.City, ROUND(sum(h.[Invoice_Sale_Dollars]),2) AS Total_Sales
from [fct_iowa_liquor_sales_invoice_header] h, [Dim_iowa_city] c,[Dim_Iowa_Liquor_Stores] st
where h.Store_SK = st.Store_SK and c.City_SK = st.City_SK
group by c.City
order by c.City;




----Liquor sales by dimension - Category

select top 10
		pc.[Category_Name] as 'CategoryName',
		sum(h.[Invoice_Sale_Dollars]) as 'TotalSales'
	from	[dbo].[FCT_Iowa_Liquor_Sales_Invoice_Header] h	
		join [dbo].[FCT_Iowa_Liquor_Sales_Invoice_Lineitem] l on l.[Invoice_Number] = h.[Invoice_Number]
		join [dbo].[Dim_Iowa_Liquor_Products] p on l.[Item_SK] = p.[Item_SK]
		join [dbo].[Dim_Iowa_Liquor_Product_Categories] pc on pc.[Category_SK] = p.[Category_SK]
	group by pc.[Category_Name]
	order by 2 desc;

----Liquor sales by dimension - Item

Select top 10 p.Item_Description, ROUND(sum(il.Sale_Dollars),2) as Total_Sales
from [Dim_iowa_liquor_Products]p,[fct_iowa_liquor_sales_invoice_lineitem] il
where p.Item_SK = il.Item_SK
GROUP BY p.Item_Description
ORDER BY p.Item_Description;


----Liquor sales by dimension - Vendor

select top 10 v.Vendor_Name Vendor,concat('$',sum(i.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem i
join Dim_iowa_liquor_Products prd on (prd.Item_SK=i.Item_SK)
join Dim_iowa_liquor_Vendors v on (v.Vendor_SK=prd.Vendor_SK)
group by v.Vendor_Name
order by Sales;

-- Total
select top 10 FORMAT(hdr.Invoice_Date,'MM/dd/yyyy') Total ,concat('$',sum(i.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem i
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=i.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'MM/dd/yyyy')
order by Sales;



-- Year
select top 10 FORMAT(hdr.Invoice_Date,'yyyy') "Year" ,concat('$',sum(i.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem i
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=i.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy')
order by Sales;

--Year, Month
select top 10 FORMAT(hdr.Invoice_Date,'yyyy/MM') YearMonth ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy/MM')
order by Sales;

--YoY
select top 10 FORMAT(hdr.Invoice_Date,'yyyy') "Year" ,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
group by FORMAT(hdr.Invoice_Date,'yyyy')
order by Sales;



-- Top 20 stores (all-time)select top 20 lstr.Store_Name,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
group by lstr.Store_Name
order by Sales desc;

-- Top 20 cities (all-time)
select top 20 cty.City,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_city cty on (cty.City_SK=lstr.City_SK)
group by cty.City
order by Sales desc;

-- Top 10 counties (all-time)

select top 20 cnty.County,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join fct_iowa_liquor_sales_invoice_header hdr on (hdr.Invoice_Number=itm.Invoice_Number)
join Dim_Iowa_Liquor_Stores lstr on (lstr.Store_SK=hdr.Store_SK)
join Dim_iowa_county cnty on (cnty.County_SK=lstr.County_SK)
group by cnty.County
order by Sales desc;

-- Top 20 categories (all-time)
select top 20 cat.Category_Name Category,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Product_Categories cat on (cat.Category_SK=prd.Category_SK)
group by cat.Category_Name
order by Sales desc;

-- Top 50 items (all-time)
select  top 20 prd.Item_Description Item,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
group by prd.Item_Description
order by Sales desc;

--6 Top 20 vendor (all-time)
select top 20 vnd.Vendor_Name Vendor,concat('$',sum(itm.Sale_Dollars)) Sales
from fct_iowa_liquor_sales_invoice_lineitem itm
join Dim_iowa_liquor_Products prd on (prd.Item_SK=itm.Item_SK)
join Dim_iowa_liquor_Vendors vnd on (vnd.Vendor_SK=prd.Vendor_SK)
group by vnd.Vendor_Name
order by Sales desc;

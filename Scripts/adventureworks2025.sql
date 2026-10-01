USE AdventureWorks2025

SELECT 
*
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'Production' 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'Sales' 
ORDER BY TABLE_SCHEMA, TABLE_NAME;

SELECT * FROM Sales.CountryRegionCurrency 
SELECT * FROM Sales.CreditCard 
SELECT * FROM Sales.Currency
SELECT * FROM Sales.CurrencyRate
SELECT * FROM Sales.SalesPerson

SELECT * FROM Sales.Customer --CustomerID PersonID StoreID TerritoryID
SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesTerritory



SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product

SELECT 
od.SalesOrderID, od.ProductID, 
oh.OrderDate AS 'Order Date', oh.ShipDate AS 'Ship Date',
ppc.Name Category,
pps.Name SubCategory,
pp.Name AS 'Product Name', COALESCE(pp.color, 'Solid') Color, COALESCE(pp.size, 'All Size') Size,
st.Name Country,
od.OrderQty AS 'Quantity',od.LineTotal AS 'Total Sales', od.UnitPriceDiscount*od.OrderQty AS 'Total Discount', 
od.LineTotal AS 'Total Sales After Discount', pp.StandardCost*od.OrderQty AS 'Total Standard Cost'
FROM Sales.SalesOrderDetail od
LEFT JOIN Production.Product pp
ON od.ProductID = pp.ProductID 
LEFT JOIN Production.ProductSubcategory pps
ON pp.ProductSubcategoryID = pps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ppc
ON pps.ProductCategoryID = pps.ProductCategoryID
LEFT JOIN Sales.SalesOrderHeader oh
ON od.SalesOrderID = oh.SalesOrderID
LEFT JOIN Sales.SalesTerritory st
ON oh.TerritoryID = st.TerritoryID

IF OBJECT_ID('Sales.Vis_Looker', 'V') IS NOT NULL
	DROP VIEW Sales.Vis_Looker;
GO
CREATE VIEW Sales.Vis_Looker AS
(

	SELECT
		od.SalesOrderID, od.ProductID, 
		oh.OrderDate AS 'Order Date', oh.ShipDate AS 'Ship Date',
		ppc.Name Category,
		pps.Name SubCategory,
		TRIM(' -' FROM 
				REPLACE(
					CASE 
						WHEN CHARINDEX(',', pp.Name) > 0 
						THEN LEFT(pp.Name, CHARINDEX(',', pp.Name) - 1)
						ELSE pp.Name 
					END,
					ISNULL(pp.Color, ''), ''
				)
			) AS 'Product Name', COALESCE(pp.color, 'Solid') Color, COALESCE(pp.size, 'All Size') Size,
		CASE 
			WHEN st.Name IN ('Northwest','Northeast','Central','Southwest','Southeast') THEN 'United States'
			ELSE st.Name
			END AS Country,
		od.OrderQty AS 'Quantity',od.LineTotal AS 'Total Sales', FORMAT(od.UnitPriceDiscount * od.OrderQty, '0.0000', 'en-US') AS 'Total Discount',
		od.LineTotal-od.UnitPriceDiscount * od.OrderQty AS 'Total Sales After Discount', FORMAT(pp.StandardCost * od.OrderQty, '0.0000', 'en-US') AS 'Total Standard Cost'
	FROM Sales.SalesOrderDetail od
		LEFT JOIN Production.Product pp
		ON od.ProductID = pp.ProductID 
		LEFT JOIN Production.ProductSubcategory pps
		ON pp.ProductSubcategoryID = pps.ProductSubcategoryID
		LEFT JOIN Production.ProductCategory ppc
		ON pps.ProductCategoryID = ppc.ProductCategoryID
		LEFT JOIN Sales.SalesOrderHeader oh
		ON od.SalesOrderID = oh.SalesOrderID
		LEFT JOIN Sales.SalesTerritory st
		ON oh.TerritoryID = st.TerritoryID
)

SELECT MAX([Order Date]), MIN([Order Date])
FROM Sales.Vis_Looker;

SELECT * FROM Sales.Vis_Looker

SELECT TRIM('- ' FROM 'LL Road Frame -') AS Hasil;
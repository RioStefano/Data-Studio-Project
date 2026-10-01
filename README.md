# AdventureWorks Sales Dashboard

A small project where I took the AdventureWorks 2025 sample database, cleaned the data with SQL, and built a sales dashboard in Looker Studio.

Dashboard: [View the live dashboard](https://datastudio.google.com/reporting/26ce68e4-4d8f-4fe8-b9b7-1c96eede948d)

## About the data

The data comes from Microsoft's [AdventureWorks sample database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure) (2025 version). I mainly used tables from the `Sales` and `Production` schemas, like orders, products, categories, and territories.

## How I did it

1. **Explored the data in SQL Server.** I checked all the tables in the Sales and Production schemas to understand what's in there and how they connect (CustomerID, ProductID, TerritoryID, etc.).
2. **Wrote a draft query** to join order details with products, categories, order headers, and territories, just to see if the data made sense.
3. **Cleaned it and saved it as a view** (`Sales.Vis_Looker`). Some of the things I did:
   - cleaned up product names (removed the color part)
   - filled empty color and size with default values
   - grouped the 5 US territories into one "United States"
   - calculated quantity, sales, discount, and cost
4. **Exported the view as CSV** and uploaded it to Google Sheets.
5. **Connected the sheet to Looker Studio** (formerly Google Data Studio) and built the dashboard.

## Dashboard

![Dashboard View](Docs/Dashboard%20View.png)

## Files

- `Datasets/AdventureWorks2025.csv` - exported data from the cleaned view
- `Docs/Dashboard View.png` - dashboard screenshot

## Tools

SQL Server (SSMS), Google Sheets, Looker Studio

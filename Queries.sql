-- Query 1: Top-Selling Tracks by Revenue
SELECT 
    t.Name AS TrackName,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
FROM 
    InvoiceLine il
JOIN 
    Track t ON il.TrackId = t.TrackId
GROUP BY 
    t.Name
ORDER BY 
    TotalRevenue DESC
LIMIT 10;

-- Query 2: Revenue by Country
SELECT 
    c.Country,
    SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM 
    Customer c
JOIN 
    Invoice i ON c.CustomerId = i.CustomerId
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 
    c.Country
ORDER BY 
    Revenue DESC;

-- Query 3: Average Order Value (AOV)
SELECT 
    AVG(OrderTotal) AS AverageOrderValue
FROM (
    SELECT 
        i.InvoiceId,
        SUM(il.UnitPrice * il.Quantity) AS OrderTotal
    FROM 
        Invoice i
    JOIN 
        InvoiceLine il ON i.InvoiceId = il.InvoiceId
    GROUP BY 
        i.InvoiceId
) AS Orders;

-- Query 4: Repeat Customers
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    COUNT(DISTINCT i.InvoiceId) AS NumberOfOrders
FROM 
    Customer c
JOIN 
    Invoice i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId
HAVING 
    COUNT(DISTINCT i.InvoiceId) > 1
ORDER BY 
    NumberOfOrders DESC;

-- Query 5: Monthly Revenue Trends
SELECT 
    SUBSTR(i.InvoiceDate, 1, 7) AS InvoiceMonth,
    SUM(il.UnitPrice * il.Quantity) AS MonthlyRevenue
FROM 
    Invoice i
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 
    InvoiceMonth
ORDER BY 
    InvoiceMonth;

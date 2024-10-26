/*
GROUP BY + JOIN
1.A)Crie um agrupamento mostrando o total de vendas (SalesQuantity)
1.B) N tabela resultando, mostre apenas os anos com um total de vendas
1.c) Considere apenas o mes de janeiro
*/

--Considerando os anos
SELECT
	DimDate.CalendarYear AS 'Ano',
	SUM(FactSales.SalesQuantity) AS 'Total Vendido'
FROM	
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarYear
HAVING SUM(FactSales.SalesQuantity) >= 1200000
--Considerando somente o mes de janeiro
SELECT
	CalendarYear AS 'Ano',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM	
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
WHERE DimDate.CalendarMonthLabel = 'January'
GROUP BY CalendarYear

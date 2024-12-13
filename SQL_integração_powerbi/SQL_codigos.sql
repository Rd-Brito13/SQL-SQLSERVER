
--View que será utilizada para montar a dashboard
GO
CREATE OR ALTER VIEW RESULTADOS_ADW
AS
SELECT
	fis.SalesOrderNumber AS 'Numero da compra',
	fis.OrderDate AS 'Data da compra',
	dpc.EnglishProductCategoryName AS 'Caterogia',
	dc.CustomerKey AS 'Chave cliente',
	dc.FirstName + ' ' + dc.LastName  AS 'Cliente',
	dc.Gender AS 'Genero',
	dg.EnglishCountryRegionName AS 'Páis',
	fis.OrderQuantity  AS 'Quantidade da compra',
	fis.SalesAmount  AS 'Receita',
	fis.TotalProductCost AS 'Custo total produto',
	fis.SalesAmount - fis.TotalProductCost AS 'Lucro'
FROM 
	FactInternetSales fis
--Joins e renomeando colunas
INNER JOIN DimProduct dp
	ON  fis.ProductKey = dp.ProductKey
INNER JOIN DimProductSubcategory dps
	ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
INNER JOIN DimProductCategory dpc
	ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc
	ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimGeography dg
	ON dc.GeographyKey = dg.GeographyKey
GO
--exibindo a view

SELECT
	*
FROM
	RESULTADOS_ADW

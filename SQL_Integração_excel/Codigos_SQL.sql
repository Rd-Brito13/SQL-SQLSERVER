
--Receita total internet por categorias
SELECT
	YEAR(FactInternetSales.OrderDate) AS 'Ano',
	DimProductCategory.EnglishProductCategoryName AS 'Categorias',
	SUM(FactInternetSales.SalesAmount) AS 'Soma por categoria'

FROM
	FactInternetSales
RIGHT JOIN DimProduct
ON FactInternetSales.ProductKey = DimProduct.ProductKey
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductCategoryKey
RIGHT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY DimProductCategory.EnglishProductCategoryName, YEAR(FactInternetSales.OrderDate)
HAVING YEAR(FactInternetSales.OrderDate) = 2013




-- Receita total por meses
SELECT
	YEAR(OrderDate) AS 'Ano',
	MONTH(OrderDate) AS 'Meses',
	SUM(SalesAmount) AS 'Receita total'
FROM
	FactInternetSales
GROUP BY MONTH(OrderDate), YEAR(OrderDate)
HAVING YEAR(OrderDate) = 2013
ORDER BY MONTH(OrderDate) ASC



--receita total por paises

SELECT
	YEAR(FactInternetSales.OrderDate) AS 'Ano',
	DimSalesTerritory.SalesTerritoryCountry,
	SUM(FactInternetSales.SalesAmount) AS 'Receita total'

FROM
	FactInternetSales
INNER JOIN DimSalesTerritory
ON FactInternetSales.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
GROUP BY DimSalesTerritory.SalesTerritoryCountry, YEAR(FactInternetSales.OrderDate)
HAVING YEAR(OrderDate) = 2013


--Receita total por sexo
SELECT
	DimCustomer.Gender,
	YEAR(FactInternetSales.OrderDate) AS 'Ano',
	SUM(FactInternetSales.SalesAmount) AS 'Receita total'
FROM
	FactInternetSales
INNER JOIN DimCustomer
ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
GROUP BY DimCustomer.Gender, YEAR(FactInternetSales.OrderDate)
HAVING YEAR(FactInternetSales.OrderDate) = 2013




--Criando a view que será utilizada.
GO
CREATE OR ALTER VIEW VENDAS_INTERNET  AS
SELECT
	--Colunas selecionadas
	FactInternetSales.SalesOrderNumber AS 'Numero do Pedido',
	DimProductCategory.EnglishProductCategoryName  AS 'Categoria Produto' ,
	FactInternetSales.TotalProductCost AS 'Custo Total do Produto',
	FactInternetSales.OrderQuantity AS 'Quantidade Vendida',
	FactInternetSales.SalesAmount AS 'Receita Total',
	DimCustomer.FirstName + ' ' + DimCustomer.LastName AS 'Cliente',
	DimCustomer.Gender AS 'Genero',
	DimSalesTerritory.SalesTerritoryCountry AS 'País',
	YEAR(FactInternetSales.OrderDate) AS 'Ano',
	DATENAME(month,FactInternetSales.OrderDate) AS 'Mês'
--seleção de tabelas e os joins
FROM
	FactInternetSales
	--join para retornar a o nome da categoria
	INNER JOIN DimProduct
	ON FactInternetSales.ProductKey = DimProduct.ProductKey
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	INNER JOIN DimProductCategory
		ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
--join para retornar o país
INNER JOIN DimSalesTerritory
ON FactInternetSales.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
INNER JOIN DimCustomer
ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
--filtrando para o ano de 2013
WHERE YEAR(FactInternetSales.OrderDate) = 2013 
GO

--exibindo a view
SELECT
	*
FROM
	VENDAS_INTERNET


-- Modificando a orderquantity no product key = 361 e atualizando a planilha no excel.
BEGIN TRANSACTION T1
	UPDATE FactInternetSales
	SET OrderQuantity = 18
	WHERE ProductKey = 361
COMMIT TRANSACTION T1

	


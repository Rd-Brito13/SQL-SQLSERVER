/*
Exercicio de fixa��o 1 - FACT SALES
*/

/*
1. a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal
de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity,
em ordem decrescente.
b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e
quantidade total devolvida (Return Quantity) de acordo com o nome das lojas
(StoreName).
c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s
(CalendarMonthLabel) e ano (CalendarYear)
*/


SELECT
	TOP(100) * 
	
FROM	
	FactSales

SELECT
	*
FROM
	DimStore

-- (1.a)

SELECT 
	FactSales.SalesQuantity,
	DimChannel.ChannelName
FROM
	FactSales
INNER JOIN DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
ORDER BY FactSales.SalesQuantity DESC

-- (1.b)

SELECT 
	SUM(FactSales.SalesQuantity) AS 'Quantidade Total Vendida',
	SUM(FactSales.ReturnQuantity) AS 'Quantidade Total Devolvida',
	DimStore.StoreName
FROM
	FactSales
INNER JOIN DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY DimStore.StoreName


--(1.c)

SELECT
	SUM(FactSales.SalesAmount) AS 'Total Vendido',
	DimDate.CalendarMonthLabel,
	DimDate.CalendarYear
FROM	
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY DimDate.CalendarMonthLabel, DimDate.CalendarYear
ORDER BY DimDate.CalendarMonthLabel, DimDate.CalendarYear ASC

/*
2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor
total vendido (SalesQuantity) por produto.
a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).
b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
*/

--(2.a)

SELECT 
	TOP(100) *
FROM
	FactSales

SELECT 
	*
FROM
	DimProduct

SELECT
	SUM(FactSales.SalesQuantity) AS	'Total Vendido',
	DimProduct.ProductName AS 'Nome Produto',
	DimProduct.ColorName AS 'Nome das Cores'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY DimProduct.ProductName, DimProduct.ColorName
HAVING MAX(SUM(FactSales.SalesQuantity))

--(2.b)

/*
3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto
(ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o
entre FactSales e DimProductCategory n�o � direta.
*/

--3.A
SELECT
	TOP(100) *
FROM
	FactSales

SELECT 
	*
FROM
	DimProductCategory
SELECT
	*
FROM
	DimProduct
SELECT
	*
FROM
	DimProductSubcategory

SELECT
	SUM(FactSales.SalesQuantity) AS 'Total Vendido',
	DimProductCategory.ProductCategoryName AS 'Nome das categorias Produtos'
FROM
	FactSales
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey	
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
			INNER JOIN DimProductCategory
				ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

GROUP BY DimProductCategory.ProductCategoryName

/*
4 - Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo
do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais
comprados pelo cliente da letra a, considerando o nome do Produto
*/

--4.A

SELECT
	TOP(100) *
FROM
	FactOnlineSales
SELECT 
	*
FROM
	DimCustomer

SELECT
	TOP(1)
	DimCustomer.CustomerKey,
	DimCustomer.FirstName,
	DimCustomer.LastName,
	SUM(FactOnlineSales.SalesQuantity) AS 'Total Comprado'
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY DimCustomer.FirstName, DimCustomer.LastName, DimCustomer.CustomerKey
ORDER BY SUM(FactOnlineSales.SalesQuantity) DESC


--4.b
SELECT	TOP(10)
	FactOnlineSales.CustomerKey,
	DimProduct.ProductName AS 'Produto',
	SUM(FactOnlineSales.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactOnlineSales
INNER JOIN DimProduct
	ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE FactOnlineSales.CustomerKey = 7665
GROUP BY DimProduct.ProductName, FactOnlineSales.CustomerKey
ORDER BY SUM(SalesQuantity) DESC

/*
5- Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o
sexo dos clientes
*/

SELECT
	top(10) *	
FROM	
	FactOnlineSales

SELECT
	*
FROM
	DimCustomer

--5.a
SELECT
	SUM(FactOnlineSales.SalesQuantity) AS 'Total produtos Comprados' ,
	DimCustomer.Gender
FROM
	FactOnlineSales
INNER JOIN DimCustomer
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
GROUP BY DimCustomer.Gender, DimCustomer.CustomerType
HAVING DimCustomer.Gender IS NOT NULL AND DimCustomer.CustomerType = 'Person'

/*
 6 - Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada
CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.
*/

SELECT TOP(100)
	*
FROM
	FactExchangeRate

SELECT TOP(100)
	*
FROM
	DimCurrency


SELECT
	DimCurrency.CurrencyDescription,
	AVG(FactExchangeRate.AverageRate) AS 'Taxa Media'
FROM
	FactExchangeRate
INNER JOIN DimCurrency
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY DimCurrency.CurrencyDescription
HAVING AVG(FactExchangeRate.AverageRate) BETWEEN '10' AND '100'

/*
7. Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos
cen�rios: Actual e Budget.
*/

SELECT TOP(100)
	*
FROM
	FactStrategyPlan

SELECT TOP(100)
	*
FROM
	DimScenario

SELECT
	SUM(FactStrategyPlan.Amount) AS 'Valor Total',
	DimScenario.ScenarioName
FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY DimScenario.ScenarioName 

/*
8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.
*/

SELECT top(100)
	*
FROM
	FactStrategyPlan

SELECT
	*
FROM
	DimDate

SELECT
	SUM(FactStrategyPlan.Amount) AS 'Total Por Ano',
	DimDate.CalendarYear
FROM
	FactStrategyPlan
INNER JOIN DimDate
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY DimDate.CalendarYear

/*
9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em
considera��o em sua an�lise apenas a marca Contoso e a cor Silver.
*/

SELECT
	*
FROM
	DimProduct

SELECT
	*
FROM
	DimProductSubcategory


SELECT 
	DimProduct.BrandName,
	DimProduct.ColorName,
	DimProductSubcategory.ProductSubcategoryName,
	COUNT(*) AS 'Quantidade Produtos'
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE DimProduct.BrandName = 'Contoso' AND DimProduct.ColorName = 'Silver'
GROUP BY DimProductSubcategory.ProductSubcategoryName, DimProduct.BrandName, DimProduct.ColorName

/*
10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e
ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna
BrandName
*/


SELECT DISTINCT
	 BrandName
FROM
	DimProduct

SELECT DISTINCT
	ProductSubcategoryName
	
FROM
	DimProductSubcategory


SELECT 
	DimProduct.BrandName,
	DimProductSubcategory.ProductSubcategoryName,
	COUNT(*) AS 'Qtd. Produtos'
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY DimProduct.BrandName, DimProductSubcategory.ProductSubcategoryName
ORDER BY DimProduct.BrandName ASC










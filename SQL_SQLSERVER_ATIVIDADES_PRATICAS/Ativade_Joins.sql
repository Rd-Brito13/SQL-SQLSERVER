/*
Exercicios Joins
Os Joins têm como principal objetivo deixar as tabelas mais informativas, permitindo buscar
dados de uma tabela para outra, de acordo com uma coluna em comum que permita essa
relação.
*/

SELECT
	*
FROM
	DimProduct

SELECT
	*
FROM
	DimProductSubcategory

/*
1 - Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela
DimProductSubcategory para a tabela DimProduct
*/
SELECT 
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProductSubcategory.ProductSubcategoryName
	
FROM	
	DimProduct
INNER JOIN DimProductSubcategory	
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey


/*
2 - Identifique uma coluna em comum entre as tabelas DimProductSubcategory e
DimProductCategory. Utilize essa coluna para complementar informações na tabela
DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.
*/


SELECT
	 *
FROM
	DimProductCategory

SELECT
	 *
FROM
	DimProductSubcategory


SELECT
	*
FROM	
	DimProductSubcategory
LEFT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


/*
3 -Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados
(de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas:
StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT
JOIN neste exercício.
*/

SELECT
	TOP(100) * 
FROM
	DimStore

SELECT
	TOP(100) * 
FROM
	DimGeography

SELECT
	DimStore.StoreKey,	
	DimStore.StoreName,
	DimStore.EmployeeCount,
	DimGeography.ContinentName,
	DimGeography.RegionCountryName
FROM	
	DimStore
LEFT JOIN DimGeography
	ON DimStore.GeographyKey = DimGeography.GeographyKey
ORDER BY DimStore.StoreKey ASC 

/*
4- Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize
o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.
*/


SELECT
	TOP(100) * 
FROM
	DimProduct

SELECT
	TOP(100) * 
FROM
	DimProductCategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductDescription,
	DimProduct.ColorName,
	DimProductCategory.ProductCategoryDescription
FROM	
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	LEFT JOIN DimProductCategory
		ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey


/*
5- A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha
representa um montante destinado a uma determinada AccountKey.
*/

-- A) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.

SELECT
	TOP(100) * 
FROM
	FactStrategyPlan

SELECT
	*
FROM
	DimAccount

SELECT
	*
FROM
	DimScenario

 /* B)  Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada
AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• AccountName
• Amount
*/
SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.Datekey,
	DimAccount.AccountName,
	FactStrategyPlan.Amount

FROM
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey


/*
6) Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que
identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna
possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão.
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey
da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
• StrategyPlanKey
• DateKey
• ScenarioName
• Amount
*/

SELECT
	FactStrategyPlan.StrategyPlanKey,
	FactStrategyPlan.Datekey,
	DimScenario.ScenarioName,
	FactStrategyPlan.Amount

FROM
	FactStrategyPlan
INNER JOIN DimScenario
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
ORDER BY FactStrategyPlan.Datekey ASC

/*
7- Algumas subcategorias n possuem nenhum exemplar de produto. Identifique quais subcategorias são essas
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
	DimProduct.ProductName,
	DimProductSubcategory.ProductSubcategoryName
FROM	
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE DimProduct.ProductName IS NULL

/*
 8 - A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso,
Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado.
*/

SELECT
	*
FROM
	DimProduct
SELECT
	*
FROM
	DimChannel

SELECT
	BrandName,
	ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso','Fabrikam','Litware')

/*
 9 -Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion.
Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse
relacionamento.
Retorne uma tabela contendo as seguintes colunas:
• OnlineSalesKey
• DateKey
• PromotionName
• SalesAmount
*/

SELECT
	TOP(100) * 
FROM 
	FactOnlineSales
SELECT
	*
FROM
	DimPromotion

SELECT
	TOP(100)
	FactOnlineSales.OnlineSalesKey,
	FactOnlineSales.DateKey,
	DimPromotion.PromotionName,
	FactOnlineSales.SalesAmount
FROM 
	FactOnlineSales
INNER JOIN DimPromotion
	ON FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE DimPromotion.PromotionName <> 'No Discount'
ORDER BY FactOnlineSales.DateKey  ASC

/*
10 -  A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel,
DimStore e DimProduct.
Recrie esta consulta e classifique em ordem decrescente de acordo com SalesAmount.
*/

SELECT
	TOP(100)
	SalesKey,
	ChannelName,
	StoreName,
	ProductName,
	SalesAmount
FROM
	FactSales
INNER JOIN	DimChannel
	ON FactSales.channelKey = DimChannel.ChannelKey
INNER JOIN	DimStore
	ON FactSales.StoreKey = DimStore.StoreKey
INNER JOIN DimProduct
	ON FactSales.ProductKey = DimProduct.ProductKey
ORDER BY FactSales.SalesAmount ASC
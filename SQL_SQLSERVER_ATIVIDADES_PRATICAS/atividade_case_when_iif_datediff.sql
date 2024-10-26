--Exercicio Numero 1
DECLARE @Economico FLOAT = 0.05, @Regular FLOAT = 0.07, @Deluxe FLOAT = 0.09


SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	ClassName,
	FORMAT(IIF(ClassName = 'Economy', UnitPrice * (1 - @Economico),
		IIF(ClassName = 'Regular', UnitPrice * (1 - @Regular), UnitPrice * (1 - @Deluxe))),'N2') AS 'Desconto'
FROM
	DimProduct

--EXERCICIO NUMERO 2

SELECT
	BrandName,
	COUNT(ProductName) AS 'Quantidade de Produtos',
	CASE
		WHEN COUNT(ProductName) > 500 THEN 'Categoria A'
		WHEN COUNT(ProductName) BETWEEN 100 AND 500 THEN 'Categoria B'
		ELSE 'Categoria C'
	END
FROM
	DimProduct
GROUP BY BrandName

-- EXERCICIO 3


SELECT 
	StoreName,
	SUM(EmployeeCount) AS 'Total Funcionarios',
	CASE
		WHEN SUM(EmployeeCount) > 50 THEN 'Acima de 50'
		WHEN SUM(EmployeeCount) >= 40  AND SUM(EmployeeCount) <= 50 THEN 'entre 40 e 50'
		WHEN SUM(EmployeeCount) >= 30 AND SUM(EmployeeCount) < 40 THEN 'entre 30 e 39'
		WHEN SUM(EmployeeCount) >= 20 AND SUM(EmployeeCount) < 30 THEN 'entre 20 e 20 '
		WHEN SUM(EmployeeCount) >= 10 AND SUM(EmployeeCount) < 20 THEN 'entre 10 e 19' 
		WHEN SUM(EmployeeCount) IS NULL THEN 'Sem Funcionario'
		ELSE 'abaixo de 10'
	END AS 'Status'
					
FROM
	DimStore
GROUP BY StoreName

-- exercicio 4

SELECT
	DimProductSubcategory.ProductSubcategoryName,
	SUM(DimProduct.Weight) * 100 AS 'Peso Total',
	CASE
		WHEN SUM(DimProduct.Weight) * 100 < 1000 THEN 'Rota 1'
		WHEN SUM(DimProduct.Weight) * 100  >= 1000 THEN'Rota 2'
		ELSE 'INDEFINIDO'
	END AS 'Rota'
	
FROM
	DimProductSubcategory
INNER JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
INNER JOIN DimProduct
	ON DimProductCategory.ProductCategoryKey = DimProduct.ProductKey
GROUP BY DimProductSubcategory.ProductSubcategoryName

-- exercicio 5 

SELECT
	FirstName,
	Gender,
	TotalChildren,
	EmailAddress,
	CASE
		WHEN Gender = 'F' AND TotalChildren > 0 THEN 'Mãe do ano' 
		WHEN Gender = 'M' AND TotalChildren > 0 THEN 'Pai do ano'
		WHEN Gender  = 'M' OR GENDER = 'F' AND TotalChildren = 0 THEN 'Caminhão de premios'
		ELSE 'NÃO SE ENCAIXA EM NENHUM SORTEIO'
	END AS 'Classificação'
FROM	
	DimCustomer

-- exercicio 6
DECLARE @DataAtual DATETIME  = SYSDATETIME()
SELECT
	StoreName,
	OpenDate,
	DATEDIFF(DAY, OpenDate, @DataAtual) AS 'DiasAberta'

FROM
	DimStore
ORDER BY DiasAberta DESC
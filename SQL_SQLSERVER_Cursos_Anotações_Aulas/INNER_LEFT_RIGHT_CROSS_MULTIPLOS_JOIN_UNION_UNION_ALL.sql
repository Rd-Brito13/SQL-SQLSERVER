-- Selecionando as tabelas que serão utilizadas pelo LEFT JOIN
SELECT 
	*
FROM 
	DimProduct
SELECT 
	*
FROM
	DimProductSubcategory
--LEFT JOIN na pratica, especificando a tabela e selecionando as colunas dela.
--E selecionando a segunda tabela e coluna que será utilizada. 
--LEFT JOIN, criando a tabela com base na chave primaria da tabela que será puxada
-- e a chave estrangeira da tabela que esta puxando.
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductDescription,
	DimProduct.UnitPrice,
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductCategoryKey


--RIGHT JOIN

SELECT 
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.Manufacturer,
	DimProductSubcategory.ProductCategoryKey
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductCategoryKey

-- INNER JOIN
--Utilizado para extrair a informação das table puxando metade de cada.

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- FULL JOIN

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- LEFT ANTI JOIN - RIGHT e FULL
-- basicamente,os joins são utilizado com um filtro where no final.

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN DimProductSubcategory
	
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE ProductKey IS NULL


--EXEMPLOS PRATICOS - INNER JOIN, LEFT JOIN e RIGHT JOIN

SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey	
FROM
	DimProduct


SELECT
	ProductSubcategoryKey,
	ProductSubcategoryName
FROM	
	DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
	
FROM	
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- Caso o left join  e o inner join, não deem resultados iguais quando o left for execcutado.
-- significa que ngm existe nenhum valor que não exista nas duas tabelas
-- Utilidades maiores para o left join e right join, é muito util para averiguar informações entres as tables. Caso existam valores NULL

--LEFT JOIN 
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
	
FROM	
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- RIGHT JOIN
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
	
FROM	
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey


-- CROSSJOIN: com essa função, e neste exemplo, qualificamos cada produto baseado no seu nome de acordo com o nome da sua subcategoria

SELECT
	DimProduct.ProductName,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct CROSS JOIN DimProductSubcategory


-- MULTIPLOS JOINS

SELECT
	*
FROM
	DimProduct
SELECT
	*
FROM
	DimProductSubcategory

SELECT 
	*
FROM
	DimProductCategory


SELECT 
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductCategory.ProductCategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductSubcategoryKey = DimProductCategory.ProductCategoryKey


-- UNION 
-- SEMELHEMANTE AO pd.concat([]) do python, o comando UNION empilha as tabelas
-- No entanto, precisar ter a mesma estrutura as duas (quantidade de linhas e colunas iguais)
-- Caso as colunas sejam iguais o UNION, irá excluir as linhas duplicadas.

SELECT 
	*
FROM
	DimCustomer
WHERE Gender = 'F'

UNION
SELECT 
	*
FROM
	DimCustomer
WHERE Gender = 'M'


-- UNION ALL, Irá retornar todas as linhas presentes, considerando tbm as duplicadas.
-- Resumindo, irá concatenar toda as tabelas.
SELECT 
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE Gender = 'F'

UNION ALL
SELECT 
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE Gender = 'M'

/*
Fun��o GROUP BY utilizada para associar, por exemplo: uma coluna de nome dos produtos e suas quantidades. especificando a coluna e utilizando 
a fun��o COUNT para retornar os itens presentes e a suas quantidades.
*/

SELECT
	ProductName,
	COUNT(*) AS 'Quantidade Total Dos Produtos'
FROM
	DimProduct
GROUP BY ProductName
ORDER BY ProductName ASC


/*
Dessa vez o GROUP BY foi utilizado para fazer a associa��o da soma de cada tipo de funcionario a seus tipos de lojas. a fun��o SUM, foi utilizada para a soma.
*/
SELECT 
	SUM(EmployeeCount) AS 'Quantidade Funcionarios',
	StoreType AS 'Tipo de Loja'
FROM
	DimStore
GROUP BY StoreType
	
/*
GROUP BY para retornar a media do custo medio dos protudos, de cada marca.
*/

SELECT 
	BrandName,
	
	AVG(UnitCost) AS 'Custo Medio'

FROM
	DimProduct
GROUP BY BrandName

/*
Retornando os maiores pre�os  dos protudos por marca
*/

SELECT 
	ClassName AS 'Classes',
	MAX(UnitPrice) AS 'maiores precos por marca'
FROM
	DimProduct
GROUP BY ClassName

/*
Menores valores de produtos baseado nas classes
*/
SELECT 
	ClassName AS 'Classes',
	MIN(UnitPrice) AS 'maiores precos por marca'
FROM
	DimProduct
GROUP BY ClassName


/*
ORDER BY junto de GROUP BY, Desta maneira, 
utilizei como parametro de ordena��o a linha de c�digo utilizada para fazer a soma dos valores da coluna e ordenei a partir dela
*/

SELECT 
	StoreType AS 'Tipo de Loja',
	SUM(EmployeeCount) AS 'Quantidade Funcionarios'
	
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC


/*
Dsta maneira, utilizando o WHERE para filtar e depos agrupar as colunas. aqui.
estamos dando 2 parametros de filtro e deois agrupando as colunas com o GROUP BY
*/

SELECT
	BrandName AS 'Nome da Marca',
	ColorName AS 'Nome da Cor',
	COUNT(ProductName) AS 'Quantidade de Produtos'
FROM
	DimProduct
WHERE ColorName IN ('Orange', 'Purple', 'Black') AND BrandName = 'Litware'
GROUP BY ColorName, BrandName

/*
Utilizando a fun��o HEAVING para filtrar depois do agrupamento. A fun��o HAVING tem este trabalho de so ser utilizado para filtrar p�s agrupamento
*/

SELECT
	BrandName AS 'Marcas',
	COUNT(BrandName) AS 'Total Marcas'
FROM	
	DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) IN ('132','267','710')


/*
*/
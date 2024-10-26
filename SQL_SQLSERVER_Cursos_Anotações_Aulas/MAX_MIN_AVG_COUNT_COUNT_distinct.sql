/*
Exibindo as 100 primeiras linhas da tables
*/

SELECT TOP(100)
	*
FROM
	DimProduct

/*
Executando uma soma na coluna SalesQuantity inteira e retornando a quantidade vendida de tudo.
*/
SELECT 
	SUM(SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales

/*
Utilizando a Função Count para fazer uma contagem de valores presentes de uma coluna ou uma tabela, caso seja executado em uma coluna especifica e nesta coluna tenha valores Null.
ele n será contabilizado
1 = contando as linhas de toda a tabela e suas colunas
2 = contando as linhas de somente uma coluna
*/

/*
1
*/
SELECT 
	COUNT (*) AS 'Linhas na Tabela'
FROM
	DimProduct
/*
2.
*/
SELECT 
	COUNT (UnitPrice) AS 'Preço Unitário'
FROM	
	DimProduct

/*
COUNT + DINSTICNT: é utilizado para retornar a quantidade de valores destintos em uma coluna
*/

SELECT 
	COUNT (DISTINCT ColorName) AS 'Nome das Cores'
FROM
	DimProduct

/*
MAX e MIN, funções utilizadas para retornar os valores maior e menor de uma coluna. e AVG retorna o valor médio de uma coluna.
MAX
MIN
AVG
*/

SELECT 
	MAX(UnitCost) AS 'Custo Unitário Maximo',
	MIN(UnitCost) AS 'Custo Unitário Minimo',
	AVG(UnitCost) AS 'Custo Unitário Média'
FROM
	DimProduct




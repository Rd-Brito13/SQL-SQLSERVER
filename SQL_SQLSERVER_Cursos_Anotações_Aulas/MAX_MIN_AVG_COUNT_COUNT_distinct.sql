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
Utilizando a Fun��o Count para fazer uma contagem de valores presentes de uma coluna ou uma tabela, caso seja executado em uma coluna especifica e nesta coluna tenha valores Null.
ele n ser� contabilizado
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
	COUNT (UnitPrice) AS 'Pre�o Unit�rio'
FROM	
	DimProduct

/*
COUNT + DINSTICNT: � utilizado para retornar a quantidade de valores destintos em uma coluna
*/

SELECT 
	COUNT (DISTINCT ColorName) AS 'Nome das Cores'
FROM
	DimProduct

/*
MAX e MIN, fun��es utilizadas para retornar os valores maior e menor de uma coluna. e AVG retorna o valor m�dio de uma coluna.
MAX
MIN
AVG
*/

SELECT 
	MAX(UnitCost) AS 'Custo Unit�rio Maximo',
	MIN(UnitCost) AS 'Custo Unit�rio Minimo',
	AVG(UnitCost) AS 'Custo Unit�rio M�dia'
FROM
	DimProduct




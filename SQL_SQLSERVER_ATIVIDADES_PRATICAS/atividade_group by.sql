/*
1 - a) Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas
(channelkey).
b) Fa�a um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade
total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
c) Fa�a um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas
para o ano de 2007

*/

/*
A)
*/
SELECT 
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	channelKey
FROM
	FactSales
GROUP BY channelKey

/*
B)
*/

SELECT
	StoreKey,
	SUM(SalesQuantity) AS 'Quantidade Total Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Total Devolvida'
FROM
	FactSales
GROUP BY StoreKey 
ORDER BY StoreKey ASC

/*
C)
*/

SELECT
	Channelkey,
	SUM(SalesAmount) AS 'Valor Total Vendido'
	
FROM
	FactSales
WHERE DateKey BETWEEN '20070101' AND '20071231'
GROUP BY channelKey


/*
2 - 2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor
total vendido (SalesAmount) por produto (ProductKey).
a) A tabela final dever� estar ordenada de acordo com a quantidade vendida e, al�m disso,
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que
$5.000.000.
b) Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtos com mais vendas.
Desconsidere o filtro de $5.000.000 aplicado.
*/

/*a*/

SELECT 
	ProductKey,
	SUM(SalesAmount) AS 'Valor Total Vendido'	
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC

/*b*/

SELECT TOP(10)
	ProductKey,
	SUM(SalesAmount) AS 'Valor Total Vendido'	
FROM
	FactSales
GROUP BY ProductKey
ORDER BY SUM(SalesAmount) DESC

/*3 - a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o ID
(CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna
SalesQuantity).
b) Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por ID do produto
e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).
*/

SELECT TOP(1)
	CustomerKey AS 'Cliente ID',
	SUM(SalesQuantity) AS 'Compras Realizadas'
FROM
	FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC

/*b*/

SELECT TOP(3)
	ProductKey AS 'ID Produto',
	SUM(SalesQuantity) AS 'Compras Realizadas'
FROM
	FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC


/*4 - a) Fa�a um agrupamento e descubra a quantidade total de produtos por marca.
b) Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.
c) Fa�a um agrupamento de cores e descubra o peso total que cada cor de produto possui.
*/

--a

SELECT 
	BrandName,
	COUNT(ProductName) AS 'Quantidade Produto'
FROM
	DimProduct
GROUP BY BrandName

--b
SELECT
	ClassName AS 'Classes', 
	AVG(UnitPrice) AS 'Media dos Pre�os'
FROM	
	DimProduct

GROUP BY ClassName
--c
SELECT
	ColorName AS 'Cores',
	SUM(Weight) AS 'Peso dos Produtos'
FROM
	DimProduct
GROUP BY ColorName
/*5 - Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em
ordem decrescente.
*/


SELECT
	StockTypeName AS 'Tipo',
	SUM(Weight) AS 'Peso dos Produtos'
FROM
	DimProduct
GROUP BY StockTypeName

/*6- Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as
16 op��es de cores? 
*/

SELECT 
	BrandName AS 'Marca',
	COUNT(DISTINCT ColorName) AS 'Quantidade Cores'
FROM
	DimProduct
GROUP BY BrandName

/*
Exemplo caso queria saber quais as cores que cada marca possui
*/
SELECT DISTINCT
	BrandName,
	ColorName
FROM
	DimProduct
WHERE BrandName = 'Fabrikam'

/*7 - Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m a m�dia
salarial de acordo com o Sexo. Corrija qualquer resultado �inesperado� com os seus
conhecimentos em SQL.
*/

SELECT 
	Gender AS 'G�nero',
	COUNT(Gender) AS 'Total Clientes',
	AVG(YearlyIncome) AS 'Media Salarial de acordo com sexo'
FROM
	DimCustomer
GROUP BY Gender
HAVING Gender IS NOT NULL


/*8 - Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de
acordo com o seu n�vel escolar. Utilize a coluna Education da tabela DimCustomer para fazer
esse agrupamento.
*/

SELECT
	Education AS 'Nivel Educacional',
	COUNT(CustomerKey) AS 'Quantidade Total de clientes',
	AVG(YearlyIncome) AS 'Media salarial dos clietens'
FROM
	DimCustomer
GROUP BY Education
HAVING Education IS NOT NULL

/*9 - Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo com o
Departamento (DepartmentName). Importante: Voc� dever� considerar apenas os
funcion�rios ativos.
*/

SELECT 
	DepartmentName,
	COUNT(Status) AS 'Quantidade de Funcionaios'
FROM
	DimEmployee
WHERE Status LIKE 'Current'
GROUP BY DepartmentName 

/*10 - Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Voc�
deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.*/



SELECT
	Title AS 'Cargo',	
	SUM(VacationHours) AS 'Horas Somadas'
FROM
	DimEmployee
WHERE Gender LIKE 'F' AND DepartmentName IN ('Production','Marketing','Engineering','Finance') 
AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title


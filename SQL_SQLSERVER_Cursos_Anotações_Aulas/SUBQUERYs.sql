/*SUBQuery Utilizando o filtro WHERE*/


-- FILTRANDO A MEDIA DO UNITCOSt
SELECT
	*
FROM
	DimProduct
WHERE UnitCost > (SELECT AVG(UnitCost) FROM DimProduct)

-- Filtrando o SELECT a partir dos valores da subcategoria de produtos de outra tabela 
SELECT
	*
FROM
	DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')

-- Selecionando  os valores das lojas onde tem mais que 100 funcionarios

SELECT
	*
FROM
	FactSales
WHERE StoreKey IN
	(SELECT StoreKey FROM DimStore
		WHERE EmployeeCount > 100)
	
	

-- ANY: Qualquer, SOME , ALL

CREATE TABLE funcionarios(
	Id_Funcionarios INT,
	Nome VARCHAR(60),
	Idade INT,
	Sexo VARCHAR(50)
)

INSERT INTO funcionarios(Id_Funcionarios,Nome,Idade,Sexo)
VALUES 
	(1,'Julia',20,'F'),
	(2,'Daniel',21,'M'),
	(3,'Amanda',22,'F'),
	(4,'Pedro',27,'M'),
	(5,'Andre',28,'M'),
	(6,'Luisa',32,'F')

SELECT
	Id_Funcionarios
FROM
	funcionarios
WHERE Id_Funcionarios IN (SELECT Id_Funcionarios FROM funcionarios
	WHERE Sexo = 'F')

-- utilizando o operador ANY é adaptavel a uma situação e recebe uma lista de valore, caso queria retornar uma serie de valores baseado em uma lista de valores, se quiser retornar um valor maior,
--o ANY vai puxar o menor valor da lisa como parametro, caso contrario, irá retornar o maior valor da lista como parametros

SELECT
	Id_Funcionarios
FROM
	funcionarios
WHERE Id_Funcionarios = ANY (SELECT Id_Funcionarios FROM funcionarios
	WHERE Sexo = 'F')
-- utilizando o operador ALL ele vai utilizar uma lista como paramtro e vai retornar o valor que seja verdadeiro: por exemplo, retornar todas as idade que seja maior que a lista que se está sendo utilizada como parametro.
-- retorna o valor maior que todas as idade parametradas
SELECT
	*
FROM
	funcionarios
WHERE Idade = ANY (SELECT Idade FROM funcionarios
	WHERE Sexo = 'F')

-- EXISTS

SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE EXISTS (SELECT * FROM FactSales
	WHERE DateKey = '01/01/2007' AND FactSales.ProductKey = DimProduct.ProductKey)



/*Subqueries: SELECT*
Retorna uma tabela com todos os produtos (ID produto, Nome Produto)*/

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Quantidade de Vendas'
FROM	
	DimProduct


-- Subquries Aninhadas

SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM
	DimCustomer
WHERE YearlyIncome = (
	SELECT
		MAX(YearlyIncome)
	FROM 
		DimCustomer
	WHERE YearlyIncome < (
	SELECT
		MAX(YearlyIncome)
	FROM
		DimCustomer
	WHERE CustomerType = 'Person'))


-- CTE
WITH Cte AS(
SELECT
	ProductKey,
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
FROM
	DimProduct
WHERE BrandName = 'Contoso'
)
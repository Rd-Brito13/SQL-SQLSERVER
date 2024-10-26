/*
FUNÇÃO PARA SABER OS TIPOS DE DADOS DAS VARIAVEIS
SELECT SQL_VARIANT_PROPERTY(DADO,"BaseType")
SELECT CAST(DADO AS Tipo de dado a ser convertido)
*/

/*Inteiro*/
SELECT 10 AS 'VALOR INTEIRO'
SELECT SQL_VARIANT_PROPERTY(10,'BaseType')
/*Numeric ou Float/decimal*/
SELECT 38.44 AS 'float ou decimal'
SELECT SQL_VARIANT_PROPERTY(38.44,'BaseType')
/*Varchar ou string*/
SELECT 'RODRIGO' AS 'string'
SELECT SQL_VARIANT_PROPERTY('rodrigo','BaseType')
/*Varchar, Supostamente Date*/
SELECT '20/10/2002' AS 'supostamente data'
SELECT SQL_VARIANT_PROPERTY(CAST('20/10/2002' AS DATE),'BaseType')

/*CAST*/
--Convertendo para INT
SELECT CAST(100.85 AS INT)
--convertendo para FLOAT
SELECT CAST(100.85 AS FLOAT)
--Convertendo numero entre '' para float ou int
--FLOAT
SELECT CAST('15.66' AS FLOAT)
--INT
SELECT CAST('100' AS INT)
-- Convertendo para DATETIME ou DATE
--DATETIME
SELECT CAST('20/06/2021' AS DATETIME)
--DaTE
SELECT CAST('20/08/2031' AS DATE)


/*EXERCICIO 1
Printando um texto.*/
SELECT 'O preço do Pastel é: ' + CAST(30.99 AS VARCHAR(50))

/*EXERCICIO 2
SOMANDO +1 ao dia do tipo datetime*/
SELECT CAST('20/06/2024' AS DATETIME) + 1


/*
FUNÇÕES DE ARREDONDAMENTO 
ROUND - ROUND (truncar)- FLOOR (arredonda pra BAIXO) - CEILING (arredonda pra CIMA)
*/
-- ROUND (numero a ser arredondado, quantidade de casas decimais vizualizaveis)
SELECT ROUND(18.739130,2)

-- ROUND(truncando) (numero a ser arredondado, quantidade de casas decimais vizualizaveis, valor de casas decimais a ser cortado)
SELECT ROUND(18.739130,2, 1)

-- FLOOR(Numero a ser arredondado)
SELECT FLOOR(18.739130)

--CEILING(Numero a ser arredondado)
SELECT CEILING(18.739130)


/*DECLARE  - SET: Funções para declarar variaveis*/

/*Estrutura da declaração e rececpção de valor de uma variavel
DECLARE @variavel tipo da variavel
SET @variavel = valor 
SELECT @variavel*/

DECLARE @variavel INT
SET @variavel = 150	
SELECT @variavel AS 'Variavel'

--DECLARE variaveis simultaneas e atribuindo o valor na declaração, sem a necessidade do SET

DECLARE		
	@var1 INT = 15,
	@text VARCHAR(20)  = 'Barandão Bixiguento',
	@data DATETIME = '18/05/2023'
SELECT
	@var1 AS 'Valor',
	@text AS 'Texto',
	@data AS 'Data'

-- EXERCICIO 1: A sua loja fez uma venda de 100 camisas, cada uma custando 89.99, select para obter o valor total

SELECT 100 * 89.99 AS 'Valor Total'
	


-- EXERCICIO 2 Refaça utilizando variaveis.

DECLARE 
	@valor_camisa FLOAT = 89.99,
	@vendas INT = 100
SELECT 
	@valor_camisa * @vendas AS 'Valor Total Vendido'


--utilizando variavel em consulta (exemplos)
DECLARE @varDesconto FLOAT = 0.10 

SELECT
	ProductKey,
	ProductName,
	UnitPrice,
	UnitPrice * (1 - @varDesconto) AS 'Preço com Desconto'
	
FROM
	DimProduct

--utilizando variavel em consulta 2 (exemplos)

DECLARE 
	@data_inicial DATE = '01/01/1980',
	@data_final DATE = '31/12/1980'


SELECT
	FirstName,
	LastName,
	BirthDate,
	'Cliente' AS 'Tipo'
FROM
	DimCustomer
WHERE BirthDate BETWEEN @data_inicial AND @data_final

UNION

SELECT
	FirstName,
	LastName,
	BirthDate,
	'Funcionario' AS 'Tipo'
FROM
	DimEmployee
WHERE BirthDate BETWEEN @data_inicial AND @data_final 
ORDER BY BirthDate ASC


/*Armazenar resultado de um SELECT em uma variavel*/

-- Exemplo 1

DECLARE @total_funcionario INT = (SELECT COUNT(EmployeeKey)FROM DimEmployee)

SELECT 
	@total_funcionario  AS 'Total de Funcionarios'

-- Exemplo 2

SELECT
	COUNT(StoreKey) AS 'Lojas Off'
FROM
	DimStore
WHERE Status = 'off'

DECLARE @total_loja_off INT  = (SELECT COUNT(StoreKey)	FROM DimStore WHERE Status = 'off')
SELECT
	@total_loja_off AS 'Total de Lojas OFF'

/*Utilizando o PRINT para mostrar o resultado de uma consulta*/

SELECT 
	*
FROM
	DimProduct

SELECT 
	COUNT(*)
FROM 
	DimProduct

-- EXEMPLO 1
-- SET NOCOUNT ON: comando utilizado para excluir as contagems de linhas em uma consulta na aba Mensagens
SET NOCOUNT ON
DECLARE 
	@varlojason INT,
	@varlojasoff INT
SET @varlojason = (SELECT COUNT(*) FROM DimStore WHERE Status = 'on')
SET @varlojasoff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'off' )

SELECT
	@varlojason AS 'ON',
	@varlojasoff AS 'OFF'

PRINT 'Lojas ONLINE: ' + CAST(@varlojason AS VARCHAR(20))
PRINT 'Lojas OFFLINE: ' + CAST(@varlojasoff AS VARCHAR(20))




-- lista de variaveis --- Variaveis globais (@@ caracterizado por dois arrobas, para ser uma variavel global)

SELECT
	FirstName,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

-- Solução 

DECLARE @varListNames VARCHAR(50)
SET @varListNames = ''

SELECT 
	@varListNames = @varListNames + FirstName + ','
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'







	




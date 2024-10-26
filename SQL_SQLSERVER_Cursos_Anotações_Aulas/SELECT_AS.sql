-- Comando SELECT Retorna as de uma table.
SELECT * FROM DimAccount

-- Comando SELECT + Nome das colunas da tables especificada, Retorna somente as colunas desejadas
SELECT AccountName, AccountDescription FROM DimAccount

-- Comando SELECT TOP Retorna as primeiras linhas de um table (quantidade de linhas definida entre os parenteses)
SELECT TOP(50) FirstName, LastName FROM DimCustomer

-- Comando SELECT TOP PERCENT Retorna as primeiras linhas de um table (quantidade de linhas definida entre os parenteses e os valor � lido como porcentagem)
SELECT TOP(15) PERCENT * FROM FactSales

-- Comando SELECT DISTINCT � utilizado diretamente para retornar valores distintos(Valores que n�o se repetem na coluna) de uma colina especifica (ou de uma table inteira, por�m depende dos tipos de dados presente em algumas columns)
SELECT DISTINCT StoreDescription FROM DimStore

--  C�digo Identado
SELECT
	DISTINCT DepartmentName
FROM	
	DimEmployee


/*
Comando Aliasing, Utilizado para renomear colunas. Sempre que for renomear para um nome composto 
'' as �spas simples s�o obrigatorias, caso seja somente um nome. N�o te necessidade
e � importante notar que, essa modifica��o de nome na colunas, n modifica a tabela original, somente a vers�o que foi selecionada.
*/
SELECT 
	ProductName AS 'Nome do Produto',
	BrandName AS Marca,
	ColorName AS 'Cor'
FROM 
	DimProduct
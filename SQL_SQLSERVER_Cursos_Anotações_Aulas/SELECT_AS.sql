-- Comando SELECT Retorna as de uma table.
SELECT * FROM DimAccount

-- Comando SELECT + Nome das colunas da tables especificada, Retorna somente as colunas desejadas
SELECT AccountName, AccountDescription FROM DimAccount

-- Comando SELECT TOP Retorna as primeiras linhas de um table (quantidade de linhas definida entre os parenteses)
SELECT TOP(50) FirstName, LastName FROM DimCustomer

-- Comando SELECT TOP PERCENT Retorna as primeiras linhas de um table (quantidade de linhas definida entre os parenteses e os valor é lido como porcentagem)
SELECT TOP(15) PERCENT * FROM FactSales

-- Comando SELECT DISTINCT é utilizado diretamente para retornar valores distintos(Valores que não se repetem na coluna) de uma colina especifica (ou de uma table inteira, porém depende dos tipos de dados presente em algumas columns)
SELECT DISTINCT StoreDescription FROM DimStore

--  Código Identado
SELECT
	DISTINCT DepartmentName
FROM	
	DimEmployee


/*
Comando Aliasing, Utilizado para renomear colunas. Sempre que for renomear para um nome composto 
'' as áspas simples são obrigatorias, caso seja somente um nome. Não te necessidade
e é importante notar que, essa modificação de nome na colunas, n modifica a tabela original, somente a versão que foi selecionada.
*/
SELECT 
	ProductName AS 'Nome do Produto',
	BrandName AS Marca,
	ColorName AS 'Cor'
FROM 
	DimProduct
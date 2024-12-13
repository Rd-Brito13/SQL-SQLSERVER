--Criando uma PIVOT TABLE, com a sele��o de colunas manual


--Utilizando esse tratamento para facilitar no processo de sele��o de colunas para a pivot table, fun��o TRIM(remove os espa�os no come�o e no fim dos dados), '[' + BrandName + ']', concatena com colchetes os dados
SELECT DISTINCT
	'[' + TRIM(BrandName) + ']' AS 'Marcas'
FROM
	DimProduct


--faz um subconsulta com a tabela, DimProduct, BrandName e ProductKey
SELECT
	*
FROM
	(SELECT
		ProductKey,
		BrandName
	FROM
		DimProduct) AS Dados
--Criando a PIVOT TABLE, precisa sempre de uma fun��o de agrega��o em uma coluna  o FOR � utilizado para agrupar as outras colunas. IN � utilizado para especificar os dados que ser�o agrupados.
PIVOT(
	COUNT(ProductKey)
	FOR BrandName
	IN ([Adventure Works],
		[Fabrikam],
		[Tailspin Toys],
		[A. Datum],
		[Contoso],
		[Wide World Importers],
		[Southridge Video],
		[Proseware],
		[The Phone Company],
		[Litware],
		[Northwind Traders]
		)
) AS Tabele_Pivo



--Pivot TABLE agregando linhas

-- Utiliza a fun��o QUOTENAME(Inserir colchetes no final e come�o dos dados, TRIM(Retira os espa�amentos dos dados))
SELECT DISTINCT
	  QUOTENAME(TRIM(DepartmentName)) + ',' AS 'Nome Departamentos'
FROM
	DimEmployee
--Caso queria ordenar as colunas, pode ser feito desta maneira, ordenando antes os nomes no select distinct, e fazendo o processo normal
ORDER BY [Nome Departamentos] DESC


--Seleciona a tabela e faz a subconsulta com as colunas desejadas
SELECT
	*
FROM
	(SELECT
		EmployeeKey,
		--Aqui, utilizamos a colunas HireDate e extraimos seu ano, para utilizar como agrega��o de linhas.
		YEAR(HireDate) AS Ano,
		DepartmentName
		
	FROM
	DimEmployee) AS Dados
--Cria a tabela PIVO, contando as chaves de funcionarios e agrupando por nome de departamento, in colunas desejadas
PIVOT(
	COUNT(EmployeeKey)
	FOR DepartmentName
	IN([Tool Design],
	[Shipping and Receiving],
	[Sales],
	[Research and Development],
	[Quality Assurance],
	[Purchasing],
	[Production],
	[Production Control],
	[Marketing],
	[Information Services],
	[Human Resources],
	['Human Resources Contral],
	[Finance],
	[Facilities and Maintenance],
	[Executive],
	[Engineering],
	[Document Control])

) AS Tabela_Pivor
ORDER BY Ano




--Pivot TABLE agregando mais de um grupo d elinhas

-- Utiliza a fun��o QUOTENAME(Inserir colchetes no final e come�o dos dados, TRIM(Retira os espa�amentos dos dados))
SELECT DISTINCT
	  QUOTENAME(TRIM(DepartmentName)) + ',' AS 'Nome Departamentos'
FROM
	DimEmployee
--Caso queria ordenar as colunas, pode ser feito desta maneira, ordenando antes os nomes no select distinct, e fazendo o processo normal
ORDER BY [Nome Departamentos] DESC


--Seleciona a tabela e faz a subconsulta com as colunas desejadas
SELECT
	*
FROM
	(SELECT
		EmployeeKey,
		--Aqui, utilizamos a colunas HireDate e extraimos seu ano, para utilizar como agrega��o de linhas.
		YEAR(HireDate) AS Ano,
		--Aqui, utilizamos a coluna HireDate para extrair o mes, e transformar em extens�o (Nome), 
		DATENAME(MM, HireDate) AS Mes,
		DepartmentName
		
	FROM
	DimEmployee) AS Dados
--Cria a tabela PIVO, contando as chaves de funcionarios e agrupando por nome de departamento, in colunas desejadas
PIVOT(
	COUNT(EmployeeKey)
	FOR DepartmentName
	IN([Tool Design],
	[Shipping and Receiving],
	[Sales],
	[Research and Development],
	[Quality Assurance],
	[Purchasing],
	[Production],
	[Production Control],
	[Marketing],
	[Information Services],
	[Human Resources],
	['Human Resources Contral],
	[Finance],
	[Facilities and Maintenance],
	[Executive],
	[Engineering],
	[Document Control])

) AS Tabela_Pivor
ORDER BY Ano




--Trantando a liminta��o, utilizando uma variavel para conter todas as colunas que ser�o agrupadas
--Definindo a variavel que ir� armazena o nome das colunas
DECLARE @NomeColunas NVARCHAR(MAX) = ''
DECLARE @PivotTable_departamento NVARCHAR(MAX) = ''
--passando o valor das colunas para a variavel
SELECT 
	@NomeColunas += QUOTENAME(TRIM(DepartmentName)) + ','
--criando a subconsulta de onde ir� extrair a variavel
FROM
	(SELECT DISTINCT
		DepartmentName
	FROM
		DimEmployee) AS aux
--adicionando um novo valor a variavel, para tirar a ultima virgula
SET @NomeColunas = LEFT(@NomeColunas, LEN(@NomeColunas) - 1)


--Seleciona a tabela e faz a subconsulta com as colunas desejadas, utiliza a pivot table, como string e adiciona a uma variavel como valor, 
--utiliza o EXECUTE sp_executesql @PivotTable_departamento, para executar a fun��o, essa fun��o executa strings como c�digos.
SET @PivotTable_departamento = 
	'
	SELECT
		*
	FROM
		(SELECT
			EmployeeKey,
			--Aqui, utilizamos a colunas HireDate e extraimos seu ano, para utilizar como agrega��o de linhas.
			YEAR(HireDate) AS Ano,
			DepartmentName
		
		FROM
		DimEmployee) AS Dados
	--Cria a tabela PIVO, contando as chaves de funcionarios e agrupando por nome de departamento, in colunas desejadas
	PIVOT(
		COUNT(EmployeeKey)
		FOR DepartmentName
		IN(' + @NomeColunas + ')

	) AS Tabela_Pivor
	ORDER BY Ano

	'
--utiliza o EXECUTE sp_executesql @PivotTable_departamento, para executar a fun��o, essa fun��o executa strings como c�digos.
EXECUTE sp_executesql @PivotTable_departamento
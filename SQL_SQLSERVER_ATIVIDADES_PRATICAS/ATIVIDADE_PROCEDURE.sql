--EXERCICIOS PRODECURES
--Criando a PROCEDURE
CREATE OR ALTER PROCEDURE ResumirProdutos(@marca AS VARCHAR(MAX))
AS
BEGIN
--Corpo do PROCEDURE, um inner join, agrupando todos os itens de cada subcategoria e filtrando por marca
	SELECT
		COUNT(DimProduct.ProductName) AS 'Qtd Produtos',
		DimProductCategory.ProductCategoryName,
		DimProduct.BrandName
	FROM 
		Dimproduct	
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	INNER JOIN DimProductCategory
		ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
	GROUP BY DimProductCategory.ProductCategoryName, DimProduct.BrandName
	HAVING BrandName = @marca
END


--Executa a PROCEDURE com o parametro de marca existente no banco
EXECUTE ResumirProdutos 'Contoso'



--Cria a PROCEDURE
CREATE OR ALTER PROCEDURE TopClienteantigos(@Quantidade_cliente AS INT)
AS
BEGIN
--Corpo da procedure
	SELECT	TOP(@Quantidade_cliente)
		FirstName,
		LastName,
		EmailAddress,
		DateFirstPurchase
	FROM
		DimCustomer
	WHERE DateFirstPurchase IS NOT NULL
	ORDER BY DateFirstPurchase ASC
END

--Executa a procedure com dando valor ao TOP(N)
EXECUTE TopClienteantigos 100

--Criando a procedure para ver os clientes contratados 
CREATE OR ALTER PROCEDURE FunContrato(@mes AS INT, @ano AS INT)
AS
BEGIN
--Corpo da procedure
	SELECT
		*
	FROM	
	DimEmployee
	WHERE  MONTH(StartDate) =  @mes AND YEAR(StartDate) = @ano
	
END

--executa a procedure
EXECUTE FunContrato 01, 1999


DROP DATABASE AlugaFacil
CREATE DATABASE AlugaFacil
USE AlugaFacil

CREATE TABLE Carro(
Id_Carro INT IDENTITY (1,1),
Placa VARCHAR(100) NOT NULL,
Modelo VARCHAR(100) NOT NULL,
Tipo VARCHAR(100) NOT NULL,
Valor FLOAT NOT NULL

CONSTRAINT carro_id_carro_pk PRIMARY KEY (Id_Carro)
)

INSERT INTO Carro(Placa, Modelo, Tipo, Valor)
VALUES 
	('CRU-1111','Chevolet Cruze','Sedan', 140000),
	('ARG-2222','Fiat Argo','Hatch', 80000),
	('COR-3333','Toyata Corolla','Sedan',17000),
	('TIG-4444','Caoa Cherry Tiggo','SUV',198000)


SELECT
	*
FROM
	Carro

--Ciando a procedure para fazer o cadastro dos carros
CREATE OR ALTER PROCEDURE InserirCarro(@placa AS VARCHAR(8), @modelo AS VARCHAR(25), @tipo AS VARCHAR(15), @valor AS FLOAT)
AS
BEGIN
	BEGIN TRANSACTION
	INSERT INTO Carro(Placa,Modelo,Tipo,Valor)
	VALUES
		(@placa, @modelo, @tipo, @valor)
	PRINT 'Carro Cadastrado com sucesso!'
	COMMIT TRANSACTION
END
--executando a procedure
EXECUTE InserirCarro 'VGA-1250', 'Chevete', 'Antiguidade', 8500

--Resetar o identity
DBCC CHECKIDENT('Carro', RESEED, 5)
--exibindo a tabela
SELECT	
	*
FROM
	Carro

--Cria a procedure
CREATE OR ALTER PROCEDURE Atualizarvalor(@id_carro AS INT, @valor AS FLOAT)
AS 
BEGIN
	BEGIN TRANSACTION
-- Corpo da procedure
	UPDATE Carro
	SET Valor = @valor
	WHERE Id_Carro = @id_carro
	PRINT 'Valor atualizado!'
	COMMIT TRANSACTION
END
--Executa a procedure
EXECUTE Atualizarvalor 6, 12500

--exibe a tabela
SELECT	
	*
FROM
	Carro
-- Cria a procedure
CREATE OR ALTER PROCEDURE DeletarCarro(@id_carro AS INT)
AS 
--corpo da procedure
BEGIN	
	BEGIN TRANSACTION
	DELETE FROM Carro
	WHERE Id_Carro = @id_carro
	PRINT 'Carro Deletado da tabela!'
	COMMIT TRANSACTION
END
--executa a procedure
EXECUTE DeletarCarro 5
--exibe a tabela
SELECT
	*
FROM
	Carro








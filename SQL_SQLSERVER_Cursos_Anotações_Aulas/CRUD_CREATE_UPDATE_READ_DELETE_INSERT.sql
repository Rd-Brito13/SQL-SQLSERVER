/*
Criando um banco de dados
*/
CREATE DATABASE Teste

/*Excluindo um banco de dados*/
DROP DATABASE Teste


-- Banco de dados que será usado para fazer os exemplos do modulo 
CREATE DATABASE BDimpressionador

-- Criando uma tabela
CREATE TABLE Produtos(
	Id_Produto INT,
	Nome_Produto VARCHAR(50),
	Data_Validade DATETIME,
	Preco_Produto FLOAT
	)

-- observação: Aqui, estou alterando uma coluna da tabela Produtos e aumentando o tamanho do VARCHAR()
ALTER TABLE Produtos
ALTER COLUMN Nome_Produto VARCHAR(300)

-- Inserindo dados em uma tabala, do zero ou a partir de outra tabela
--	1: Desta maneira está sendo introduzido as colunas selecionadas os dados tirados das colunas especificadas na tabela DimProduct do banco de dados ContosoRetailDW.dbo.DimProduct 
INSERT INTO Produtos(Id_Produto, Nome_Produto, Data_Validade, Preco_Produto)
SELECT	
	ProductKey,
	ProductName,
	AvailableForSaleDate,	
	UnitPrice
	
FROM
	ContosoRetailDW.dbo.DimProduct

-- 2: Desta maneira está sendo inserido dados do 0 as colunas de ua tabela

INSERT INTO Produtos(Id_Produto,Nome_Produto,Data_Validade,Preco_Produto)
VALUES
	(2518,'Arroz','10/09/2024',15.85),
	(2519,'Feijão','10/09/2024',18.99)


--Observação: deletando linhas de uma tabela, utilizando o delete e deletando mais de uma linha com base em condições
DELETE FROM Produtos
WHERE Nome_Produto IN ('Arroz','Feijão')


-- UPDATE atualizando os dados de uma tabela
UPDATE Produtos
SET Nome_Produto = 'Goiaba'
--SET Preco_Produto = 13.49
WHERE Id_Produto = 2519

SELECT
	*
FROM
	Produtos

DROP TABLE Produtos



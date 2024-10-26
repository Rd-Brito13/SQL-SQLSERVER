-- CRIANDO UMA VIEW, A fun��o "GO" � utilizada para que o sql entenda, aonde ele come�a na cria��o da view e at� onde ele deve ir. para boas praticas, sempre que for criar ou alterar uma view, utilizar o "GO".
GO
CREATE VIEW vwClientess AS
SELECT
	FirstName,
	LastName,
	Education
	
FROM
	DimCustomer
GO

-- selecionando a VIEW
SELECT
	*
FROM
	vwClientess

-- deletando uma VIEW
DROP VIEW vwClientess


-- Utilizando a fun��o USE para selecionar o banco de dados de onde os dados est�o sendo selecionados
USE ContosoRetailDW
SELECT
	*
FROM
	DimProduct

-- alterando uma VIEW
GO
ALTER VIEW vwClientess AS
SELECT
	FirstName AS 'Primeiro Nome',
	LastName AS 'Ultimo Nome',
	Education AS 'Educa��o',
	Gender  AS 'Sexo'
FROM
	DimCustomer
WHERE Gender = 'F'
GO
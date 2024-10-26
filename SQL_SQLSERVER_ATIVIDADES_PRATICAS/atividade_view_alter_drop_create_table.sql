-- CRIANDO UMA VIEW, A função "GO" é utilizada para que o sql entenda, aonde ele começa na criação da view e até onde ele deve ir. para boas praticas, sempre que for criar ou alterar uma view, utilizar o "GO".
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


-- Utilizando a função USE para selecionar o banco de dados de onde os dados estão sendo selecionados
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
	Education AS 'Educação',
	Gender  AS 'Sexo'
FROM
	DimCustomer
WHERE Gender = 'F'
GO
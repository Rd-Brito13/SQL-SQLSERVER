-- Criando a view para responder a 1 questão
CREATE VIEW wProdutos AS
SELECT
	BrandName,
	ColorName,
	COUNT(*) AS 'Quantidade Vendida',
	ROUND(SUM(SalesAmount),2) AS 'Receita Total'
FROM
	DimProduct
INNER JOIN FactSales
	ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName

-- Exibindo a view
SELECT
	*
FROM 
	wProdutos
	
	--1, 2 e 3 questões
SELECT
	*,
	FORMAT(SUM([Quantidade Vendida]) OVER(), '0,0.00')  AS 'Quantidade Total Vendida dos Produtos',
	FORMAT(SUM([Quantidade Vendida]) OVER(PARTITION BY BrandName), '0,0.00') AS 'Quantidade Vendida por Marca',
	FORMAT( 1.0 * SUM([Quantidade Vendida]) OVER(PARTITION BY BrandName) / SUM([Quantidade Vendida]) OVER(), '0.00%') AS 'Percentual Por Marca'
FROM 
	wProdutos


-- QUESTÃO 4
SELECT
	*,
	DENSE_RANK() OVER(ORDER by [Quantidade Vendida] DESC) AS 'Rank'
FROM

	wProdutos
WHERE BrandName = 'Contoso'


-- Questão 4
CREATE VIEW vwHistoricoLojas AS
SELECT
	ROW_NUMBER() OVER(ORDER BY CalendarMonth) as 'ID',
	CalendarYear as 'Ano',
	CalendarMonthLabel as 'Mês',
	COUNT(OpenDate) as 'Quantidade lojas'
FROM
	DimDate
LEFT JOIN DimStore
	ON DimDate.Datekey = DimStore.OpenDate
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth


--questão 5
SELECT
	*,
	SUM([Quantidade lojas]) OVER( ORDER BY [Ano] ASC ROWS BETWEEN 2 PRECEDING  AND CURRENT ROW) as 'Soma MoM'
FROM
	vwHistoricoLojas


--questão 6

SELECT
	*,
	SUM([Quantidade lojas]) OVER(ORDER BY [ID] ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as 'lojas fechadas'
FROM
	vwHistoricoLojas



--DESAFIO 2 - CRIAR UM BANCO DE DADOS E UMA TABELA PARA SER O CALENDARIO

CREATE DATABASE Desafio
USE Desafio

CREATE TABLE Calendario(
data DATE

)

DECLARE @varAnoInicial INT = YEAR((SELECT MIN (DateFirstPurchase) FROM
ContosoRetailDW.DBO.DimCustomer))

DECLARE @varAnoFinal INT = YEAR((SELECT MAX (DateFirstPurchase) FROM
ContosoRetailDW.DBO.DimCustomer))


DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)

WHILE @varDataInicial <= @varDataFinal
BEGIN
	INSERT INTO Calendario(data) VALUES(@varDataInicial)
	SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END

SELECT
	*
FROM
	Calendario
-- passo 4
ALTER TABLE Calendario
ADD 
	Ano INT,
	Mes INT,
	Dia INT,
	AnoMes INT,
	NomeMes VARCHAR(50)


-- INSERINDO OS VALORES DE ANO, MES E DIA, EM VARIOS FORMATOS NA TABELA
UPDATE Calendario SET Ano = YEAR(data)
UPDATE Calendario SET Mes = MONTH(data)
UPDATE Calendario SET Dia = DAY(data)
UPDATE Calendario SET AnoMes = CONCAT(YEAR(data), FORMAT(MONTH(data), '00'))
UPDATE Calendario SET NomeMes = 
	CASE
		WHEN MONTH(data) = 1 THEN 'Janeiro'
		WHEN MONTH(data) = 2 THEN 'Fevereiro'
		WHEN MONTH(data) = 3 THEN 'Março'
		WHEN MONTH(data) = 4 THEN 'Abril'
		WHEN MONTH(data) = 5 THEN 'Maio'
		WHEN MONTH(data) = 6 THEN 'Junho'
		WHEN MONTH(data) = 7 THEN 'Julho'
		WHEN MONTH(data) = 8 THEN 'Agosto'
		WHEN MONTH(data) = 9 THEN 'Setembro'
		WHEN MONTH(data) = 10 THEN 'Outubro'
		WHEN MONTH(data) = 11 THEN 'Novembro'
		WHEN MONTH(data) = 12 THEN 'Dezembro'
	END


-- Criando a view para as proximas questões

CREATE VIEW vwNovosClientes AS
SELECT
	ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
	Ano,
	NomeMes,
	COUNT(DimCustomer.DateFirstPurchase) AS 'Novos_Clientes'
	
FROM
	Calendario
LEFT JOIN ContosoRetailDW.dbo.DimCustomer
	ON Calendario.data = DimCustomer.DateFirstPurchase
GROUP BY Ano, NomeMes, AnoMes

SELECT
	*
FROM
	vwNovosClientes


-- questão 7, a,b,c,d

SELECT
	*,
	--Soma moóvel quantidade de cliente nos ultimos 2 meses
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS  BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Movel Clientes',
	--Média móvel de clientes nos ultimos 2 meses
	FORMAT(AVG(Novos_Clientes) OVER(ORDER BY ID ROWS  BETWEEN 2 PRECEDING AND CURRENT ROW),'0') AS 'MÉDIA movel',
	--Calculo de acumulado, total de clientes durante todo o periodo de tempo
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Calculos acumulado ',
	-- Calculo de acumulado intra-ano, recomeçando a cada inicio de ano até o seu fim
	SUM(Novos_Clientes) OVER(PARTITION BY Ano ORDER BY ID) as 'Calculo ACUMULADO por ano'

FROM
	vwNovosClientes

	




-- questão 8

SELECT
	*,
	FORMAT( 1.0 * Novos_Clientes/NULLIF(LAG(Novos_Clientes, 1) OVER(ORDER bY ID), 0) - 1, '0.00%') AS 'Calculo MoM',
	FORMAT( 1.0 * Novos_Clientes/NULLIF(LAG(Novos_Clientes, 12) OVER(ORDER bY ID), 0) - 1, '0.00%') AS 'Calculo YoY'
FROM
	vwNovosClientes



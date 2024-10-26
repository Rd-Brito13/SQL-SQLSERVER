-- Criando o banco de dados 
CREATE DATABASE WF

USE WF

CREATE TABLE Lojas(
ID_Loja INT,
Nome_Loja VARCHAR(100),
Regiao VARCHAR(100),
Qtd_Vendida Float
)

INSERT INTO Lojas(ID_Loja,Nome_Loja,Regiao,Qtd_Vendida)
VALUES
	(1,'C&A','Sudeste',1822),
	(2,'Renner','Sudeste',19485),
	(3,'Maria Bonita','Sudeste',32548),
	(4,'Vivara','Sudeste',48594),
	(5,'Marisa','Sudeste',651778),
	(6,'Farm','Sul',365218),
	(7,'Prada','Sul',41258),
	(8,'Dior','Norte',992),
	(9,'Gucci','Norte',14785),
	(10,'Loius Vuitton','Norte',96542),
	(11,'Shein','Nordeste',74859),
	(12,'Shopee','Nordeste',35684),
	(13,'Riachuelo','Nordeste',14965)

SELECT
	*
FROM
	Lojas


-- Aplicando as fun��es de agrega��es, SUM, COUNT, AVG, MAX MIN
-- SUM

SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM
	Lojas

-- Com o parametro PARITTION BY = Regiao, est� fazendo a soma a partir das regi�es
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido'
FROM
	Lojas


-- COUNT
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	COUNT(*) OVER() AS 'Total Vendido'
FROM
	Lojas

-- PARTITION BY Regiao
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Total Vendido'
FROM
	Lojas

-- PARTITION BY
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido'
FROM
	Lojas

-- MAX
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	MAX(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM
	Lojas


-- MIN
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	MIN(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM
	Lojas


-- PARTITION BY
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido'
FROM
	Lojas





--Calculo de percentual do total 
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	FORMAT(SUM(Qtd_Vendida) OVER(),'0,0.00') AS 'Total Vendido',
	FORMAT(Qtd_Vendida/SUM(Qtd_Vendida) OVER(),'0.00%') AS 'Participa��o das lojas ao total'
FROM
	Lojas


-- percentual por regi�o
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	FORMAT(SUM(Qtd_Vendida) OVER(PARTITION BY Regiao),'0,0.00') AS 'Total Vendido',
	FORMAT(Qtd_Vendida/SUM(Qtd_Vendida) OVER(PARTITION BY Regiao),'0.00%') AS 'Participa��o das lojas POR REGI�O'
FROM
	Lojas



-- Fun��es de classifica��o : ROW_NUMBER, RANK, DENSE_RANK, NTILE

--ROW NUMBER() OVER(ORDER BY Qtd_Vendida DESC) cria uma nova coluna e numera em uma ordem ASC ou DESC. basicamente, cria uma coluna de coloca��es

SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'ROWNUMBER',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Regi�es rank'
FROM
	Lojas

-- RANK: Cria uma coluna (com as posi��es do rank) e ordena a minha tabela baseado na coluna passada ao ORDER BY
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	RANK() OVER(ORDER BY Qtd_Vendida asc) AS 'Regi�es rank'
FROM
	Lojas


--DENSE_RANK: melhor utilizada para posicionar os ranks, pois segue a ordem l�gica de posi��es em um rank
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	Dense_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'dense' 
FROM
	Lojas

-- NTILE: Utiliza o parametro de numero inteiro para dividir a tabela em grupos. grupo 1, grupo2, grupo 3, grupo 4
SELECT
	ID_Loja,
	Nome_Loja,
	Regiao,
	FORMAT(Qtd_Vendida,'0,0.00') AS 'Quantidade Vendida',
	NTILE(4) OVER(ORDER BY Qtd_Vendida DESC) AS 'ntile'
FROM
	Lojas


-- Criando um rank do maior para o menor a partir da soma das quantidades vendidas
SELECT
	Regiao,
	FORMAT(SUM(Qtd_Vendida),'0,0.00') AS 'Quantidade Vendida',
	DENSE_RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'Rank'
	
FROM
	Lojas
GROUP BY Regiao
ORDER BY [Quantidade Vendida] DESC


--Calculo de soma m�vel e media m�vel, criar nova tabela para fazer os calculos 
CREATE TABLE Resultado(
Data_Fechamento DATETIME,
Mes_Ano VARCHAR(100),
Faturamento_MM FLOAT
)

INSERT INTO Resultado(Data_Fechamento,Mes_Ano,Faturamento_MM)
VALUES
	('01/01/2020','JAN-20', 8),
	('01/02/2020','FEV-20', 10),
	('01/03/2020','MAR-20', 6),
	('01/04/2020','ABR-20', 9),
	('01/05/2020','MAI-20', 5),
	('01/06/2020','JUN-20', 4),
	('01/07/2020','JUL-20', 7),
	('01/08/2020','AGO-20', 11),
	('01/09/2020','SET-20', 9),
	('01/10/2020','OUT-20', 12),
	('01/11/2020','NOV-20', 11),
	('01/12/2020','DEZ-20', 10)

-- Soma M�vel: O parametro ROW BETWEEN 1 PRECEDING AND CURRENT ROW, considera as linhas que ser�o somadas, a linha atual e anterior � ela. O valor '1' pode ser modificado, para capturar um valor maior de linhas anteriores.
SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma M�vel',
	format(AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),'0.00') AS 'm�dia M�vel'
FROM
	Resultado


-- Calculo de acumulado: Utilizando o UNBOUNDED, conseguimos fazer a soma de todas as linha atr�s da linha corrente, retornando assim, no nosso caso, uma soma da linha atual com todas as passadas.

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Acumulada'

FROM
	Resultado


-- Fun��es de deslocamentos: LAG: retorna o valor da linha anterior, 'O VALOR  1 DENTRO DA FU~��O, � A QUANTIDADE DE LINHAS CAPTURADAS '. LEAD: o mesmo conceito, mas, captura as linhas � frente. o terceiro valor definido na fun��o, � utilizado para substituir os valores NULL
SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	LAG(Faturamento_MM, 2,0) OVER(ORDER BY Data_Fechamento),
	LEAD(Faturamento_MM, 1, 0)OVER(ORDER BY Data_Fechamento)
FROM
	Resultado


-- C�lculo MoM
SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FORMAT(Faturamento_MM/LAG(Faturamento_MM,1) OVER (ORDER BY Data_fechamento)-1, '0.00%') AS 'Porcentagem de Crescimento'

FROM
	Resultado






-- fUN��O DE DESLOCAMENTO FIRST_VALUE e LAST_VALUES, retorna o primiero e ultimo valor

SELECT
	Data_Fechamento,
	Mes_Ano,
	Faturamento_MM,
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_fechamento) AS 'Primeiro',
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_fechamento  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'ULTIMO'

FROM
	Resultado 
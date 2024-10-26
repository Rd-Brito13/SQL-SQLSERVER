-- LEN: Contabiliza a quantidade de caracteres
-- DATALENGTH: Contabiliza a quantidade de caracteres inclusive os espaços juntos das caracteres

SELECT 
	LEN('AAAAAA  '),
	DATALENGTH('AAAAAAAA     ')

-- CONCAT: permite juntar mais de um texto em uma única palavra

SELECT 
	CONCAT(FirstName , '',
	' ', MiddleName, ' ',
	LastName)
FROM 
	DimCustomer



-- LEFT: Extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
-- RIGHT: Extrai uma determianda quantidade de caracteres de um texto, da direita para a esquerda

SELECT 
	LEFT('BABOLHAA1578', 4),
	RIGHT('BABOLHA157821',7)

SELECT 
	ProductName,
	UnitPrice,
	ProductDescription,
	LEFT(StyleName,7),
	RIGHT(StyleName, 7)
FROM
	DimProduct

-- REPLACE: Substitui um determinado texto por outro texto
SELECT 
	REPLACE('O excel é o melhor', 'EXCEL', 'sql')
-- DESTA MANEIRA, SO CONSEGUE MODIFICAR UM TIPO DE VALOR NA COLUNA
SELECT 
	FirstName,
	LastName,
	Gender,
	REPLACE(Gender,'M', 'Masculino')
FROM 
	DimCustomer

-- E desta maneira, conseguesse substituir 2 ou mais valores dentro da mesma coluna, de vez.
SELECT 
	FirstName,
	LastName,
	Gender,
	REPLACE(REPLACE(Gender,'M', 'Masculino'),'F','Feminino')
FROM 
	DimCustomer


-- TRANSLATE E STUFF

--TRANSLATE: Substitui cada caractere na ordem encontrada no texto

SELECT 
	TRANSLATE('10.416.787/8794-8745@5484','.-/@','-*--')


-- UPPER: Transforma todas as letras em maiusculas
-- LOWER: Transforma todas as letras em minusculas

SELECT
	UPPER(FirstName),
	LOWER(LastName)
FROM
	DimCustomer

-- CHARINDEX: Descobre a posição de uma determinada caractere dentro de um texto
-- SUBSTRING: Extrai alguns caracteres de dentro de um texto

SELECT 
	'Raquel Moreno' AS 'Nome'
-- Usando o CHARINDEX para descobrir a posição em que começa o sobrenome do alvo, 1 parametro: A partir de que letra do texto, 2 parametro: qual o texto alvo
SELECT
	CHARINDEX('M','Raquel Moreno' )
-- Usando SUBSTRING para extrair o sobrenome do alvo. 1 parametro: texto alvo que será extraido os dados, 2 parametro: apartir de que posição, 3 paramtro: qual a quantidade de caracteres ou a posição que desejo extrair
SELECT 
	SUBSTRING( 'Raquel Moreno', 8, 10)

-- TRIM: Retira todos os espaços (esquerda e direita) do texto especificado
-- LTRIM: Retira somente os espaços da esquerda
-- RTRIM: Retira somente os espaços da direita

DECLARE @Nome VARCHAR(100)
SET @Nome ='   UGÃO        '

-- TRIM
SELECT
	TRIM(@Nome) AS 'NOME'

-- LTRIM
SELECT
	LTRIM(@Nome) AS 'NOME'

-- RTRIM
SELECT
	RTRIM(@Nome) AS 'NOME'

-- DAY: Extrai o dia de uma data em uma celula ou texto ou varaivel
-- MONTH: Extrai o mes
-- YEAR: Extrai o ANO

DECLARE @Data DATETIME
SET @Data = '25/09/2035'

SELECT 
	DAY(@Data) AS 'DIA',
	MONTH(@Data) AS 'MÊS',
	YEAR(@Data) AS 'ANO'

-- DATEFROMPARTS para obter uma data a apartir do dia,mes e ano
DECLARE @DIA INT, @MES INT, @ANO INT
SET @ANO = 2025 
SET @MES = 05  
SET @DIA = 10 
	
SELECT
	DATEFROMPARTS(@ANO,@MES,@DIA)


-- GETDATE: retorna data/hora atual do sistema
-- SYSDATETIME: mesma coisa que o GETDATE so que é mais preciso
-- DATENAME e DATEPART: Retornam informações (dia,mes,ano,semana, etc) de uma data

SELECT
	GETDATE() AS 'Data',
	SYSDATETIME() AS 'DATA SYS'

-- Criando uma variavel e testando o DATENAME para extrair diversas informações de data, exige 2 parametros: 1: o tipo de informação que quer extrair daquela data (day,month,minute,year,weeked), 2: a data que quer que extraia. 
-- DATEPART faz a mesma coisa e é utilizada da mesma maneira
DECLARE @DataExata DATETIME
SET @DataExata = GETDATE()

SELECT
	DATENAME(MINUTE, @DataExata)

-- DATEADD: Adiciona ou Subtrai uma determinada quantidade de dias, meses ou anos á uma data: Requer 3 argumentos,1: o tipo de data mes ou ano que quer inserir na data ou subtrair, 2: a quantidade do primeiro argumento, 3: a data expecifica
-- DATEDIFF: Calcula a diferença entre duas datas: requer 3 argumentos: 1: o tipo de dado que quero trazer a diferença entre duas datas, Dia, mes ou ano, 2: A primeira data, 3: e a segunda data

DECLARE @varData1 DATETIME, @varData2 DATETIME, @varData3 DATETIME
SET @varData1 = '19/11/1999'
SET @varData2 = '13/10/1983'
SET @varData3 = SYSDATETIME()
-- DATEADD
SELECT 
	DATEADD(DAY, 1, @varData1),
	DATEADD(YEAR,-2,@varData1)

-- DATEDIFF
SELECT
	DATEDIFF(DAY, @varData3, @varData2)
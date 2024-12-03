--Exercicios Functions
/*
1. Crie uma Function que calcule o tempo (em anos) entre duas datas. Essa function deve
receber dois argumentos: data_inicial e data_final. Caso a data_final n�o seja informada, a
function deve automaticamente considerar a data atual do sistema. Essa function ser� usada
para calcular o tempo de casa de cada funcion�rio.
Obs: a fun��o DATEDIFF n�o � suficiente para resolver este problema

*/
--Fun��o para calcular a diferen�a entre os anos dos funcionarios
--Cria a fun��o e define os parametros
CREATE OR ALTER FUNCTION Calcular_Tempo(@data_inicial AS DATE, @data_final AS DATE)
--define o tipo do valor do retorno
RETURNS INT
--define a funcionalidade dela
AS
BEGIN
--Define o resultado, partindo de condi��es.
RETURN 
	CASE
	WHEN @data_inicial IS NOT NULL AND @data_final IS NOT NULL THEN YEAR(@data_inicial)  - YEAR(@data_final)  
		ELSE YEAR(@data_inicial) -  YEAR(GETDATE()) 
	END

END


--seleciona a tabela
SELECT 
	*,
	--chama a fun��o e passa os parametros
	[dbo].[Calcular_Tempo](StartDate, EndDate) as  'Diferen�a de anos' 
	
FROM
	DimEmployee


/*2. Crie uma function que calcula a bonifica��o de cada funcion�rio (5% a mais em rela��o ao
BaseRate). Por�m, tome cuidado! Nem todos os funcion�rios dever�o receber b�nus...*/

--Fun��o para calcular a bonifica��o, caso o funcionario ainda esteja no quadro de colaboradores, caso n�o
CREATE OR ALTER FUNCTION Bonificacao(@base_avaliar AS FLOAT, @status AS VARCHAR(100))
RETURNS FLOAT
AS
BEGIN
	

RETURN CASE
		WHEN @status IN ('Current') THEN @base_avaliar + (@base_avaliar * 0.5 )
		ELSE 0
	END

END

--Chamando e aplicando a function
SELECT
	*,
	[dbo].[Bonificacao](BaseRate, Status) AS 'Valor Bonificado'
	
FROM
	DimEmployee



/*3. Crie uma Function que retorna uma tabela. Esta function deve receber como par�metro o
g�nero do cliente e retornar todos os clientes que s�o do g�nero informado na function.
Observe que esta function ser� utilizada particularmente com a tabela DimCustomer.
*/
--Cria a tabela
CREATE OR ALTER FUNCTION FiltrarGenero()
--Define o tipo do retorno
RETURNS TABLE
AS
--resultando da fun��o
RETURN (SELECT * FROM DimCustomer WHERE Gender = 'M')

--Exibe a fun��o
SELECT
	*
FROM
	[dbo].[FiltrarGenero]()


/*4. Crie uma Function que retorna uma tabela resumo com o total de produtos por cores. Sua
function deve receber 1 argumento, onde ser� poss�vel especificar de qual marca voc� deseja o
resumo.*/

--Criando a fun��o
CREATE OR ALTER FUNCTION FiltrarPorMarca(@Marca AS VARCHAR(100))
--Definindo que o retorno ser� uma tabela
RETURNS TABLE
AS
--Retornando a consulta
RETURN  SELECT COUNT(*) AS 'Quantidade Total de Produtos', ColorName, BrandName FROM DimProduct GROUP BY ColorName, BrandName HAVING BrandName = @Marca
-- Retornando a tabela com a fun��o aplicada e o nome da marca desejado
SELECT
	*
FROM
	[dbo].[FiltrarPorMarca]('Contoso')


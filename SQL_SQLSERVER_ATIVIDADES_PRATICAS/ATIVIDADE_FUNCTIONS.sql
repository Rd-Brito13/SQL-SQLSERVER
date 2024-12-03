--Exercicios Functions
/*
1. Crie uma Function que calcule o tempo (em anos) entre duas datas. Essa function deve
receber dois argumentos: data_inicial e data_final. Caso a data_final não seja informada, a
function deve automaticamente considerar a data atual do sistema. Essa function será usada
para calcular o tempo de casa de cada funcionário.
Obs: a função DATEDIFF não é suficiente para resolver este problema

*/
--Função para calcular a diferença entre os anos dos funcionarios
--Cria a função e define os parametros
CREATE OR ALTER FUNCTION Calcular_Tempo(@data_inicial AS DATE, @data_final AS DATE)
--define o tipo do valor do retorno
RETURNS INT
--define a funcionalidade dela
AS
BEGIN
--Define o resultado, partindo de condições.
RETURN 
	CASE
	WHEN @data_inicial IS NOT NULL AND @data_final IS NOT NULL THEN YEAR(@data_inicial)  - YEAR(@data_final)  
		ELSE YEAR(@data_inicial) -  YEAR(GETDATE()) 
	END

END


--seleciona a tabela
SELECT 
	*,
	--chama a função e passa os parametros
	[dbo].[Calcular_Tempo](StartDate, EndDate) as  'Diferença de anos' 
	
FROM
	DimEmployee


/*2. Crie uma function que calcula a bonificação de cada funcionário (5% a mais em relação ao
BaseRate). Porém, tome cuidado! Nem todos os funcionários deverão receber bônus...*/

--Função para calcular a bonificação, caso o funcionario ainda esteja no quadro de colaboradores, caso não
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



/*3. Crie uma Function que retorna uma tabela. Esta function deve receber como parâmetro o
gênero do cliente e retornar todos os clientes que são do gênero informado na function.
Observe que esta function será utilizada particularmente com a tabela DimCustomer.
*/
--Cria a tabela
CREATE OR ALTER FUNCTION FiltrarGenero()
--Define o tipo do retorno
RETURNS TABLE
AS
--resultando da função
RETURN (SELECT * FROM DimCustomer WHERE Gender = 'M')

--Exibe a função
SELECT
	*
FROM
	[dbo].[FiltrarGenero]()


/*4. Crie uma Function que retorna uma tabela resumo com o total de produtos por cores. Sua
function deve receber 1 argumento, onde será possível especificar de qual marca você deseja o
resumo.*/

--Criando a função
CREATE OR ALTER FUNCTION FiltrarPorMarca(@Marca AS VARCHAR(100))
--Definindo que o retorno será uma tabela
RETURNS TABLE
AS
--Retornando a consulta
RETURN  SELECT COUNT(*) AS 'Quantidade Total de Produtos', ColorName, BrandName FROM DimProduct GROUP BY ColorName, BrandName HAVING BrandName = @Marca
-- Retornando a tabela com a função aplicada e o nome da marca desejado
SELECT
	*
FROM
	[dbo].[FiltrarPorMarca]('Contoso')


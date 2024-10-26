/*

1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:
valor1 = 10
valor2 = 5
valor3 = 34
valor4 = 7
a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame
essa variável de soma.
b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4.
Chame essa variável de subtracao.
c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o
valor4. Chame essa variável de multiplicacao.
d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame
essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.
e) Arredonde o resultado da letra d) para 2 casas decimais.
*/


DECLARE 
	@Valor1 FLOAT = 10,
	@Valor2 FLOAT = 5,
	@Valor3 FLOAT = 34,
	@Valor4 FLOAT = 7

-- A)
DECLARE 
	@Soma FLOAT
SET @Soma = @Valor1 + @Valor2
SELECT @Soma AS 'Soma'

--B) 
DECLARE 
	@Subtracao FLOAT
SET @Subtracao = @Valor3 - @Valor4
SELECT @Subtracao AS 'Subtração'

--C) 
DECLARE
	@Multiplicacao FLOAT
SET @Multiplicacao = @Valor1 * @Valor4
SELECT @Multiplicacao AS 'Multiplicação'

--D)
DECLARE 
	@Divisao FLOAT 
SET @Divisao = @Valor3 / @Valor1
SELECT @Divisao AS 'Divisão'


/*
Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser
especificado.
a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.
b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.
c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99.
d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre
‘quantidade’ e ‘preco’.
e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.
*/

DECLARE 
	@Produto VARCHAR(350),
	@Quantidade FLOAT,
	@Preco FLOAT,
	@Faturamento FLOAT


SET @Produto = 'Celular'
SET	@Quantidade = 12
SET @Preco = 9.99
SET @Faturamento = @Quantidade * @Preco

SELECT
	@Produto AS 'Produto',
	@Quantidade AS 'Quantidade',
	@Preco AS 'Preço',
	@Faturamento AS 'Faturamento Total'


/*
3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de
usuários. Em resumo, esses dados são:
- Nome do usuário
- Data de nascimento
- Quantidade de pets que aquele usuário possui
Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este
usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e
num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.
O resultado final a ser alcançado é mostrado no print abaixo:
*/

DECLARE 
	@Nome VARCHAR(50),
	@Nascimento DATETIME,
	@QtdPets INT

SET @Nome = 'Andre Macaco'
SET @Nascimento = '02/09/2015'
SET @QtdPets = 8

SELECT 'Meu Nome é:' + @Nome + 'Nascido em: ' + FORMAT(@Nascimento, 'dd/mm/yyyy') + ' Pai de:' + CAST(@QtdPets AS VARCHAR(5)) + 'Petz'


/*
4. Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as
lojas da empresa.
A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a
empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir
o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e
mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.
O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:
‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas
Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado.

*/

-- 1 passo da solução
SELECT 
	
	StoreName,
	CloseDate,
	Status
FROM 
	DimStore
WHERE Status = 'Off' AND FORMAT(CloseDate, 'yyyy') = 2008

-- maneira alternativa 
DECLARE 
	@VarListaLojas VARCHAR(90)
SET @VarListaLojas = ''

SELECT 
	@VarListaLojas = @VarListaLojas + StoreName
FROM
	DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram:' + @VarListaLojas


/*
5. Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para
uma subcategoria específica: ‘Lamps’.
Utilize o conceito de variáveis para chegar neste resultado
*/

--Forma Convencional
SELECT 
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProductSubcategory.ProductSubcategoryName
FROM 
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE DimProductSubcategory.ProductSubcategoryName = 'Lamps'

--Forma com variaveis e sem joins

DECLARE		
	@VarIDsubcaregoria INT,
	@VarNomeSubcategoria VARCHAR(30)
SET @VarNomeSubcategoria = 'Lamps'
SET @VarIDsubcaregoria = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @VarNomeSubcategoria)

SELECT 
	*
FROM 
	DimProduct
WHERE ProductSubcategoryKey = @VarIDsubcaregoria
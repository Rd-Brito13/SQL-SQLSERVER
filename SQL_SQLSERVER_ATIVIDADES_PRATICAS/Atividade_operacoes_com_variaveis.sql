/*

1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas:
valor1 = 10
valor2 = 5
valor3 = 34
valor4 = 7
a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame
essa vari�vel de soma.
b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4.
Chame essa vari�vel de subtracao.
c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o
valor4. Chame essa vari�vel de multiplicacao.
d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame
essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro.
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
SELECT @Subtracao AS 'Subtra��o'

--C) 
DECLARE
	@Multiplicacao FLOAT
SET @Multiplicacao = @Valor1 * @Valor4
SELECT @Multiplicacao AS 'Multiplica��o'

--D)
DECLARE 
	@Divisao FLOAT 
SET @Divisao = @Valor3 / @Valor1
SELECT @Divisao AS 'Divis�o'


/*
Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser
especificado.
a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�.
b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.
c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99.
d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre
�quantidade� e �preco�.
e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.
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
	@Preco AS 'Pre�o',
	@Faturamento AS 'Faturamento Total'


/*
3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de
usu�rios. Em resumo, esses dados s�o:
- Nome do usu�rio
- Data de nascimento
- Quantidade de pets que aquele usu�rio possui
Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este
usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e
num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente.
O resultado final a ser alcan�ado � mostrado no print abaixo:
*/

DECLARE 
	@Nome VARCHAR(50),
	@Nascimento DATETIME,
	@QtdPets INT

SET @Nome = 'Andre Macaco'
SET @Nascimento = '02/09/2015'
SET @QtdPets = 8

SELECT 'Meu Nome �:' + @Nome + 'Nascido em: ' + FORMAT(@Nascimento, 'dd/mm/yyyy') + ' Pai de:' + CAST(@QtdPets AS VARCHAR(5)) + 'Petz'


/*
4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as
lojas da empresa.
A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a
empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir
o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e
mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho.
O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura:
�As lojas fechadas no ano de 2008 foram: � + nome_das_lojas
Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado.

*/

-- 1 passo da solu��o
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
5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para
uma subcategoria espec�fica: �Lamps�.
Utilize o conceito de vari�veis para chegar neste resultado
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
/* Exercicio 1
1. Voc� � respons�vel por controlar os dados de clientes e de produtos da sua empresa.
O que voc� precisar� fazer � confirmar se:

a. Existem 2.517 produtos cadastrados na base e, se n�o tiver, voc� dever� reportar ao seu
gestor para saber se existe alguma defasagem no controle dos produtos.

b. At� o m�s passado, a empresa tinha um total de 19.500 clientes na base de controle.
Verifique se esse n�mero aumentou ou reduziu.
*/

-- Resposta Letra A, busquei o tatal de ID's de itens cadastados no banco
SELECT TOP(100) PERCENT 
	ProductKey
FROM 
	DimProduct
-- Resposta Letra B: Teve uma queda de 464 Clientes
SELECT 
	CustomerKey
FROM
	DimCustomer
/*
2. Voc� trabalha no setor de marketing da empresa Contoso e acaba de ter uma ideia de oferecer
descontos especiais para os clientes no dia de seus anivers�rios. Para isso, voc� vai precisar
listar todos os clientes e as suas respectivas datas de nascimento, al�m de um contato.

a) Selecione as colunas: CustomerKey, FirstName, EmailAddress, BirthDate da tabela
dimCustomer.

b) Renomeie as colunas dessa tabela usando o alias (comando AS)
*/
-- Resposta segunda quest�o.
SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Primeiro Nome',
	EmailAddress AS 'Endereco de E-mail',
	BirthDate AS 'Data de Anivers�rio'
FROM	
	DimCustomer

/*
3. A Contoso est� comemorando anivers�rio de inaugura��o de 10 anos e pretende fazer uma
a��o de premia��o para os clientes. A empresa quer presentear os primeiros clientes desde
a inaugura��o.
Voc� foi alocado para levar adiante essa a��o. Para isso, voc� ter� que fazer o seguinte:

a) A Contoso decidiu presentear os primeiros 100 clientes da hist�ria com um vale compras
de R$ 10.000. Utilize um comando em SQL para retornar uma tabela com os primeiros
100 primeiros clientes da tabela dimCustomer (selecione todas as colunas).

b) A Contoso decidiu presentear os primeiros 20% de clientes da hist�ria com um vale
compras de R$ 2.000. Utilize um comando em SQL para retornar 10% das linhas da sua
tabela dimCustomer (selecione todas as colunas).

c) Adapte o c�digo do item a) para retornar apenas as 100 primeiras linhas, mas apenas as
colunas FirstName, EmailAddress, BirthDate.

d) Renomeie as colunas anteriores para nomes em portugu
*/
-- Resposta da Letra A
SELECT TOP(100)
	*
FROM
	DimCustomer

-- Resposta Letra B
SELECT TOP(20) PERCENT
	*
FROM
	DimCustomer

-- Resposta da Letra C e D
SELECT TOP(100)
	FirstName AS 'Primeiro Nome',
	EmailAddress AS 'Endereco de E-mail',
	BirthDate AS 'Data de Anivers�rio'
FROM
	DimCustomer

/*
4. A empresa Contoso precisa fazer contato com os fornecedores de produtos para repor o
estoque. Voc� � da �rea de compras e precisa descobrir quem s�o esses fornecedores.
Utilize um comando em SQL para retornar apenas os nomes dos fornecedores na tabela
dimProduct e renomeie essa nova coluna da tabela.
*/

-- Resposta Quest�o 4
SELECT DISTINCT
	Manufacturer AS 'Fornecedores'
FROM
	DimProduct

/*
5. O seu trabalho de investiga��o n�o para. Voc� precisa descobrir se existe algum produto
registrado na base de produtos que ainda n�o tenha sido vendido. Tente chegar nessa
informa��o.
Obs: caso tenha algum produto que ainda n�o tenha sido vendido, voc� n�o precisa descobrir
qual �, � suficiente saber se teve ou n�o algum produto que ainda n�o foi vendido.
*/

-- Resposta Quest�o 5. Foi utilizado o comando DISTINCT na coluna Productkey da tabl FactSales, para saber quais ID's de itens vendidos apareciam na lista. o que n aparceu, n�o foi vendido
SELECT DISTINCT
	ProductKey
FROM	
	FactSales
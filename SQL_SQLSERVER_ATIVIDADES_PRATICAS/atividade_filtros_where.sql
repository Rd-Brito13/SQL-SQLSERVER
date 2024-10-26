/*
1- Voc� � o gerente da �rea de compras e precisa criar um relat�rio com as TOP 100 vendas, de
acordo com a quantidade vendida. Voc� precisa fazer isso em 10min pois o diretor de compras
solicitou essa informa��o para apresentar em uma reuni�o.
Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total
vendido (SalesAmount).
*/

SELECT TOP(100)
	*	
FROM
	FactSales
ORDER BY SalesAmount DESC

/*
2- Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo pre�o. Por�m, a
empresa quer diferenciar esses pre�os de acordo com o peso (Weight) de cada um
*/

SELECT TOP(10)
	*	
FROM	
	DimProduct 
ORDER BY UnitPrice DESC, Weight DESC


/*
3- Voc� � respons�vel pelo setor de log�stica da empresa Contoso e precisa dimensionar o
transporte de todos os produtos em categorias, de acordo com o peso.
Os produtos da categoria A, com peso acima de 100kg, dever�o ser transportados na primeira
leva.
Fa�a uma consulta no banco de dados para descobrir quais s�o estes produtos que est�o na
categoria A.
*/

SELECT 
	ProductName AS 'Nome do Produto',
	Weight AS 'Peso Produto'
FROM
	DimProduct
WHERE Weight > 100
ORDER BY Weight DESC


/*
4- Voc� foi alocado para criar um relat�rio das lojas registradas atualmente na Contoso.
a) Descubra quantas lojas a empresa tem no total. Na consulta que voc� dever� fazer � tabela
DimStore, retorne as seguintes informa��es: StoreName, OpenDate, EmployeeCount
b) Renomeeie as colunas anteriores para deixar a sua consulta mais intuitiva.
c) Dessas lojas, descubra quantas (e quais) lojas ainda est�o ativas.
*/

SELECT 
	StoreName AS 'Nome da Loja',
	StoreType AS 'Tipo da Loja',
	OpenDate AS 'Data de abertura',
	EmployeeCount AS 'Quantidade Funcion�rio',
	Status
	
FROM
	DimStore
WHERE Status LIKE '%on%' AND StoreType LIKE '%Store%'

/*
5. O gerente da �rea de controle de qualidade notificou � Contoso que todos os produtos Home
Theater da marca Litware, disponibilizados para venda no dia 15 de mar�o de 2009, foram
identificados com defeitos de f�brica.
O que voc� dever� fazer � identificar os ID�s desses produtos e repassar ao gerente para que ele
possa notificar as lojas e consequentemente solicitar a suspens�o das vendas desses produtos.
*/

SELECT 
	ProductKey,
	ProductName AS 'Nome Produto',
	BrandName AS 'Marca Produto',
	AvailableForSaleDate AS 'Data Disponibilizada'
	
FROM
	DimProduct
WHERE ProductName LIKE '%Home Theater%' AND BrandName = 'Litware' AND AvailableForSaleDate = '20090315'

/*
6-magine que voc� precise extrair um relat�rio da tabela DimStore, com informa��es de lojas.
Mas voc� precisa apenas das lojas que n�o est�o mais funcionando atualmente.
a) Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que n�o est�o mais
funcionando.
b) Agora imagine que essa coluna de Status n�o existe na sua tabela. Qual seria a outra forma
que voc� teria de descobrir quais s�o as lojas que n�o est�o mais funcionando
*/

/*
Resolvendo Letra A
*/
SELECT 
	StoreKey AS 'Chave da Loja',
	StoreName  AS 'Nome da Loja',
	Status 
FROM
	DimStore
WHERE Status LIKE 'OFF'
/*
Letra B
*/
SELECT
	StoreKey AS 'Chave da Loja',
	StoreName  AS 'Nome da Loja',
	CloseDate AS 'Data Encerramento Loja'
FROM
	DimStore
WHERE CloseDate IS NOT NULL

/*
7-De acordo com a quantidade de funcion�rios, cada loja receber� uma determinada quantidade
de m�quinas de caf�. As lojas ser�o divididas em 3 categorias:
*/

/*
Categoria 1
*/
SELECT 
	StoreKey,
	StoreName,
	EmployeeCount
FROM
	DimStore
WHERE EmployeeCount >= 1 AND EmployeeCount <= 20

/*
Categoria 2
*/
SELECT 
	StoreKey,
	StoreName,
	EmployeeCount
FROM
	DimStore
WHERE EmployeeCount >= 21 AND EmployeeCount <= 50

/*
Categoria 3
*/

SELECT 
	StoreKey,
	StoreName,
	EmployeeCount
FROM
	DimStore
WHERE EmployeeCount > 51 

/*
 8 - A empresa decidiu que todas as televis�es de LCD receber�o um super desconto no pr�ximo
m�s. O seu trabalho � fazer uma consulta � tabela DimProduct e retornar os ID�s, Nomes e
Pre�os de todos os produtos LCD existentes.
*/
SELECT 
	ProductKey,
	ProductName,
	UnitPrice
FROM 
	DimProduct
WHERE ProductName LIKE '%lcd%'

/*
9- Fa�a uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes
produtos devem ser exclusivamente das marcas: Contoso, Litware e Fabrikam.
*/

SELECT 
	ProductKey,
	ColorName,
	BrandName
	
FROM
	DimProduct
WHERE ColorName IN ('Green','Orange','Black','Silver','Pink') AND BrandName IN ('Contoso','Litware','Fabrikam') 

/*
10 - A empresa possui 16 produtos da marca Contoso, da cor Silver e com um UnitPrice entre 10 e
30. Descubra quais s�o esses produtos e ordene o resultado em ordem decrescente de acordo
com o pre�o (UnitPrice)
*/

SELECT 
	ProductKey,
	ColorName,
	BrandName,
	UnitPrice
	
FROM
	DimProduct
WHERE ColorName LIKE '%Silver%' AND BrandName LIKE '%Contoso%' AND UnitPrice >= 10 AND UnitPrice <=30 
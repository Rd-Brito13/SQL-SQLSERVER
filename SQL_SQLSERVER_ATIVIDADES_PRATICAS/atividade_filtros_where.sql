/*
1- Você é o gerente da área de compras e precisa criar um relatório com as TOP 100 vendas, de
acordo com a quantidade vendida. Você precisa fazer isso em 10min pois o diretor de compras
solicitou essa informação para apresentar em uma reunião.
Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de acordo com o total
vendido (SalesAmount).
*/

SELECT TOP(100)
	*	
FROM
	FactSales
ORDER BY SalesAmount DESC

/*
2- Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo preço. Porém, a
empresa quer diferenciar esses preços de acordo com o peso (Weight) de cada um
*/

SELECT TOP(10)
	*	
FROM	
	DimProduct 
ORDER BY UnitPrice DESC, Weight DESC


/*
3- Você é responsável pelo setor de logística da empresa Contoso e precisa dimensionar o
transporte de todos os produtos em categorias, de acordo com o peso.
Os produtos da categoria A, com peso acima de 100kg, deverão ser transportados na primeira
leva.
Faça uma consulta no banco de dados para descobrir quais são estes produtos que estão na
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
4- Você foi alocado para criar um relatório das lojas registradas atualmente na Contoso.
a) Descubra quantas lojas a empresa tem no total. Na consulta que você deverá fazer à tabela
DimStore, retorne as seguintes informações: StoreName, OpenDate, EmployeeCount
b) Renomeeie as colunas anteriores para deixar a sua consulta mais intuitiva.
c) Dessas lojas, descubra quantas (e quais) lojas ainda estão ativas.
*/

SELECT 
	StoreName AS 'Nome da Loja',
	StoreType AS 'Tipo da Loja',
	OpenDate AS 'Data de abertura',
	EmployeeCount AS 'Quantidade Funcionário',
	Status
	
FROM
	DimStore
WHERE Status LIKE '%on%' AND StoreType LIKE '%Store%'

/*
5. O gerente da área de controle de qualidade notificou à Contoso que todos os produtos Home
Theater da marca Litware, disponibilizados para venda no dia 15 de março de 2009, foram
identificados com defeitos de fábrica.
O que você deverá fazer é identificar os ID’s desses produtos e repassar ao gerente para que ele
possa notificar as lojas e consequentemente solicitar a suspensão das vendas desses produtos.
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
6-magine que você precise extrair um relatório da tabela DimStore, com informações de lojas.
Mas você precisa apenas das lojas que não estão mais funcionando atualmente.
a) Utilize a coluna de Status para filtrar a tabela e trazer apenas as lojas que não estão mais
funcionando.
b) Agora imagine que essa coluna de Status não existe na sua tabela. Qual seria a outra forma
que você teria de descobrir quais são as lojas que não estão mais funcionando
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
7-De acordo com a quantidade de funcionários, cada loja receberá uma determinada quantidade
de máquinas de café. As lojas serão divididas em 3 categorias:
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
 8 - A empresa decidiu que todas as televisões de LCD receberão um super desconto no próximo
mês. O seu trabalho é fazer uma consulta à tabela DimProduct e retornar os ID’s, Nomes e
Preços de todos os produtos LCD existentes.
*/
SELECT 
	ProductKey,
	ProductName,
	UnitPrice
FROM 
	DimProduct
WHERE ProductName LIKE '%lcd%'

/*
9- Faça uma lista com todos os produtos das cores: Green, Orange, Black, Silver e Pink. Estes
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
30. Descubra quais são esses produtos e ordene o resultado em ordem decrescente de acordo
com o preço (UnitPrice)
*/

SELECT 
	ProductKey,
	ColorName,
	BrandName,
	UnitPrice
	
FROM
	DimProduct
WHERE ColorName LIKE '%Silver%' AND BrandName LIKE '%Contoso%' AND UnitPrice >= 10 AND UnitPrice <=30 
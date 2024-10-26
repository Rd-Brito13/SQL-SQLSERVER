/*
ORDER BY: comando utilizado para ordenar a tabela de acordo com uma coluna, ordem crescente (ASC = Padrão), ordem decrescente(DESC = precisa deste comando caso seja desejado)
*/

SELECT 
	* 
FROM 
	DimStore
ORDER BY 
	EmployeeCount
DESC

/*
Aqui o ORDER BY está sendo utilizado para ordenar a tabela em apartir do criterio difinido por duas colunas, UnitCost e Weight. Ambos em ordem Decrescente
*/
SELECT TOP(100)
	ProductName,
	UnitCost,
	Weight
FROM
	DimProduct
ORDER BY 
	UnitCost DESC, Weight DESC

/*
Selecionando colunas e utilizando o comando WHERE para fazer a filtragem, retornando somente os produtos de toda a tabela onde os valores da colunas UnitPrice são maior que 1500
e por fim, ordernando a tabela com o ORDER BY baseado na coluna UnitPrice em ordem Decrescente.
*/

SELECT
	ProductKey,
	ProductName,
	UnitPrice
FROM 
	DimProduct
WHERE UnitPrice > 1500

ORDER BY
	UnitPrice DESC
/*
Utilizando o comando WHERE para selecionar somente as linhas da colunas BrandName que correspondem ao valor em texto 'Litware' 
e utilizando o AND para aplicar um novo parametro de filtro.
*/
SELECT 
	*
FROM	
	DimProduct
WHERE BrandName ='Litware' AND UnitPrice >=50



/*
Utilizando o comando WHERE agora para filtrar datas, as datas devem ser adicionadas no formato americano = yyyy/mm/dd
Ano, mes e dia
*/

SELECT 
	*
FROM
	DimCustomer
WHERE BirthDate >= '1970/12/31'

ORDER BY
	BirthDate DESC


/*
Filtros utilizando o operador AND em conjunto com a função WHERE
*/
SELECT 
	*	
FROM
	DimProduct
WHERE Manufacturer ='Litware, inc.' AND ColorName = 'Purple'
/*
Filtros utilizando o operador OR em conjunto com a função WHERE
*/
SELECT
	*
FROM
	DimProduct
WHERE BrandName = 'RODRIGO' OR ColorID = 7
/*
Filtros utilizando o operador NOT em conjunto com a função WHERE
*/

SELECT 
	*
FROM
	DimCustomer
WHERE  NOT FirstName = 'Jon'




/*
Este tipo de cuidado com os (oq estiver dentro do paratentese, terá prioridade, assim como no python) 
é com objetivo de fazer uma priorização na hora em que o filtro for aplicado
*/

SELECT
	*
FROM
	DimProduct
WHERE  (ColorName = 'Black' OR ColorName = 'Red') AND BrandName = 'Fabrikam' 


/*
Filtrando com IN, desta maneira. retornei do banco somente as linhas tem esses valores presente na coluna ColorName
*/

SELECT
	*	
FROM
	DimProduct
WHERE ColorName IN ('Black', 'Purple','Orange','White','Silver')

/*
WHERE LIKE, LIKE substitui o sinal de =. é muito utilizado os valores de uma coluna que será retornada somente em partes do texto. 
o sinal de (%) no começo e no fim do valor buscado é utilizado para esclarecer para o sql que. 
o texto que tiver antes e depois do texto buscado deve retonar tudo oq tiver o texto especificado
*/

SELECT
	*
FROM
	DimProduct
WHERE ProductName LIKE '%MP3%'

/*
Desta forma o filtro está sendo  aplicado baseado na palavra Type encontrado no inicio dos valores que contem a palavra especificada
*/

SELECT
	*
FROM
	DimProduct
WHERE ProductDescription LIKE 'Type%'


/*
BETWEEN, NOT BETWEEN.
No Primeiro exemplo, foi retornado as linhas da coluna UnitePrice, onde os valores presentes estão somente entre 50 e 150
No segundo exemplo, o operador NOT foi utilizado para dizer ao SQL que retornasse somente as linhas das colunas em que o UnitPrice n estão entre 50 AND 150]
No terceiro exemplo, foi utilizado para filtrar baseado na coluna HireDate. foi filtrado para retornar entre o ano todo de 2000
*/

SELECT
	*
FROM
	DimProduct
WHERE UnitPrice BETWEEN 50 AND 150
/*
Segundo Exemplo
*/
SELECT
	*
FROM
	DimProduct
WHERE UnitPrice NOT BETWEEN 50 AND 150


/*
Terceiro exemplo
*/

SELECT
	*
FROM
	DimEmployee
WHERE HireDate BETWEEN '2000/01/01' AND '2000/12/31'

/*
WHERE com IS NULL e IS NOT NULL
IS NULL é o operador que define todos os valores que são nulos, no 2 exemplo, ele pe utilizado para retornar todos as linhas da coluna ComapnyName que são nulos
IS NOT  NULL é o operador que define todos os valores não são nulos, no 1 exemplo, ele é utilizado para retornar todos as linhas da coluna ComapnyName que não são nulos

*/
/*
Primeiro exemplo
*/
SELECT 
	*
FROM
	DimCustomer
WHERE CompanyName IS  NOT NULL
/*
Segundo exemplo
*/
SELECT 
	*
FROM
	DimCustomer
WHERE CompanyName IS NULL
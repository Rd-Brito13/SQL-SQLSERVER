
/*
1. O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade
Devolvida para o canal de venda mais importante da empresa: Store.
Utilize uma fun��o SQL para fazer essas consultas no seu banco de dados. Obs: Fa�a essa
an�lise considerando a tabela FactSales.

*/
SELECT
	COUNT (DISTINCT SalesAmount) AS 'Quantidade Vendida',
	COUNT (DISTINCT ReturnAmount) AS 'Quantidade Devolvida'
FROM
	FactSales
/*
2. Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes
da empresa, mas apenas de ocupa��o Professional. Utilize um comando SQL para atingir esse
resultado.
*/
SELECT 
	AVG(YearlyIncome) AS 'Renda Anual'
FROM
	DimCustomer
WHERE Occupation = 'Professional'

/*
3. Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na
empresa. O seu gerente te pediu os seguintes n�meros e informa��es:
a) Quantos funcion�rios tem a loja com mais funcion�rios?
b) Qual � o nome dessa loja?
c) Quantos funcion�rios tem a loja com menos funcion�rios?
d) Qual � o nome dessa loja?
*/
/*
Retornando a quantidade de funcion�rio somente
*/
SELECT 
	MAX(EmployeeCount) AS 'Quantidade de Funcionarios'
	
FROM
	DimStore
/*
Retornando o nome da loja e a quantidade de funcionarios
*/
SELECT TOP(1)
	StoreName AS 'Nome da Loja',
	EmployeeCount 'Quantidade de Funcion�rios'
FROM
	DimStore
ORDER BY EmployeeCount DESC

/*
B
*/

/*
Retornando o valor minimo
*/
SELECT 
	MIN(EmployeeCount) AS 'Quantidade de Funcionarios'	
FROM
	DimStore
/*
Retornando o valor minimo e a loja
*/
SELECT TOP(1)
	StoreName AS 'Nome da Loja',
	EmployeeCount 'Quantidade de Funcion�rios'
FROM
	DimStore
WHERE EmployeeCount IS NOT NULL 
ORDER BY EmployeeCount ASC


/*
4. A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade
total de funcion�rios do sexo Masculino e do sexo Feminino.
a) Descubra essas duas informa��es utilizando o SQL.
b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Des
*/
/*
A
*/
/*
Quantidade de colaboradores masculinos
*/
SELECT 
	COUNT(Gender) AS 'G�nero'
FROM
	DimEmployee
WHERE Gender = 'M'

/*
Quantidade de colaboradores femininos
*/
SELECT 
	COUNT(Gender) AS 'G�nero'
FROM
	DimEmployee
WHERE Gender = 'F'


/*
B
*/

/*
Colaborador mais velho Feminino
*/
SELECT TOP(1)
	FirstName AS 'Primeiro Nome',
	LastName AS 'Ultimo Nome',
	EmailAddress AS 'Endere�o de E-mail',
	HireDate AS 'Data de Contrata��o',
	Gender AS 'G�nero'
FROM
	DimEmployee
WHERE Gender = 'F'
ORDER BY HireDate ASC

/*
Colaborador mais velhor masculino
*/
SELECT TOP(1)
	FirstName AS 'Primeiro Nome',
	LastName AS 'Ultimo Nome',
	EmailAddress AS 'Endere�o de E-mail',
	HireDate AS 'Data de Contrata��o',
	Gender AS 'G�nero'
FROM
	DimEmployee
WHERE Gender = 'M'
ORDER BY HireDate ASC

/*
5. Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes
informa��es:
a) Quantidade distinta de cores de produtos.
b) Quantidade distinta de marcas
c) Quantidade distinta de classes de produto
Para simplificar, voc� pode fazer isso em uma mesma consult
*/

SELECT 
	COUNT (DISTINCT BrandName) AS 'Nome da Marca',
	COUNT (DISTINCT ClassName) AS 'Nome da Classe',
	COUNT (DISTINCT ColorName) AS 'Nome das Cores'
FROM
	DimProduct
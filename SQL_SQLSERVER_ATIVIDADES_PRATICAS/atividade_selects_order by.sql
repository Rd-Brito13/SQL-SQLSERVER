
/*
1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade
Devolvida para o canal de venda mais importante da empresa: Store.
Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa
análise considerando a tabela FactSales.

*/
SELECT
	COUNT (DISTINCT SalesAmount) AS 'Quantidade Vendida',
	COUNT (DISTINCT ReturnAmount) AS 'Quantidade Devolvida'
FROM
	FactSales
/*
2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes
da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse
resultado.
*/
SELECT 
	AVG(YearlyIncome) AS 'Renda Anual'
FROM
	DimCustomer
WHERE Occupation = 'Professional'

/*
3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na
empresa. O seu gerente te pediu os seguintes números e informações:
a) Quantos funcionários tem a loja com mais funcionários?
b) Qual é o nome dessa loja?
c) Quantos funcionários tem a loja com menos funcionários?
d) Qual é o nome dessa loja?
*/
/*
Retornando a quantidade de funcionário somente
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
	EmployeeCount 'Quantidade de Funcionários'
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
	EmployeeCount 'Quantidade de Funcionários'
FROM
	DimStore
WHERE EmployeeCount IS NOT NULL 
ORDER BY EmployeeCount ASC


/*
4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade
total de funcionários do sexo Masculino e do sexo Feminino.
a) Descubra essas duas informações utilizando o SQL.
b) O funcionário e a funcionária mais antigos receberão uma homenagem. Des
*/
/*
A
*/
/*
Quantidade de colaboradores masculinos
*/
SELECT 
	COUNT(Gender) AS 'Gênero'
FROM
	DimEmployee
WHERE Gender = 'M'

/*
Quantidade de colaboradores femininos
*/
SELECT 
	COUNT(Gender) AS 'Gênero'
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
	EmailAddress AS 'Endereço de E-mail',
	HireDate AS 'Data de Contratação',
	Gender AS 'Gênero'
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
	EmailAddress AS 'Endereço de E-mail',
	HireDate AS 'Data de Contratação',
	Gender AS 'Gênero'
FROM
	DimEmployee
WHERE Gender = 'M'
ORDER BY HireDate ASC

/*
5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes
informações:
a) Quantidade distinta de cores de produtos.
b) Quantidade distinta de marcas
c) Quantidade distinta de classes de produto
Para simplificar, você pode fazer isso em uma mesma consult
*/

SELECT 
	COUNT (DISTINCT BrandName) AS 'Nome da Marca',
	COUNT (DISTINCT ClassName) AS 'Nome da Classe',
	COUNT (DISTINCT ColorName) AS 'Nome das Cores'
FROM
	DimProduct
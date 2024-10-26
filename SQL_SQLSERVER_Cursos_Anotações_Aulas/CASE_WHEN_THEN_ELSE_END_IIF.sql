
--CASE: a função CASE permite tratar condições no SQL

/*
CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'Resultado2'
*/

DECLARE @varnota1 FLOAT
SET @varnota1 = 7.5

SELECT
	CASE
		WHEN @varnota1 >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'


DECLARE @varDataVenc DATETIME, @varDataAtual DATETIME
SET @varDataVenc = '10/05/2018'
SET @varDataAtual = '11/05/2035'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVenc THEN 'Inválido'
		ELSE 'Valido'
	END AS 'Data Validade'


-- EXEMPLO CASE, WHEN, ELSE

/*
selectionar as colunas da tabela DimCustumer (Gender, FirstName, Custumerkey)
e criar uma quarta coluna com a informação de masculino e feminino
*/

DECLARE @macho varchar(50), @femea VARCHAR(50)
SET @macho = 'MACHO'
SET @femea = 'FEMEA'

SELECT 
	CustomerKey,
	FirstName,
	Gender,
	CASE
		WHEN Gender = 'M' THEN @macho
		ELSE @femea
	END AS 'MACHO E FEMEA'

FROM
	DimCustomer
-- CASE com varias situações

DECLARE @aluno1 FLOAT, @aluno2 FLOAT, @aluno3 FLOAT
SET @aluno1 = 5
SET @aluno2 = 7.5
SET @aluno3 = 1.5

SELECT
	CASE
		WHEN @aluno1 >= 7 THEN 'recuperação'
		WHEN @aluno2 >= 7 THEN 'Aprovado'
		
		ELSE 'Reprovado'
	END AS 'Notas'


-- UTILIZANDO os operadores logicos

SELECT 
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	CASE 
		WHEN BrandName = 'Contoso' AND ColorName =  'Red' THEN 0.1
		WHEN BrandName = 'Contoso' AND ColorName = 'Blue' THEN 0.2
		ELSE 0
	END AS 'Porgentagem'
FROM
	DimProduct


-- CASE ANINHADO, um CASE dentro de outro, para ficar mais flexiviel para impor certas condicções

SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN 
		Case
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title =  'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'Bonificação'
FROM
	DimEmployee


-- CASE ADITIVO:
/*
Os produtos da categoria "tv e video" terão 10%
os produto com a caregoria tv e video + subcateroai televisions, teerão 15%
o CASE ADITIVO se baseia em somar um case ao outro atraves do sinald e "+"
*/

SELECT
	Dimproduct.ProductKey,
	DimProduct.ProductName,
	DimProductCategory.ProductCategoryName,
	DimProductSubcategory.ProductSubcategoryName,
	DimProduct.UnitPrice,
	CASE
		WHEN DimProductCategory.ProductCategoryName = 'TV and Video' THEN 0.10
		ELSE 0
	END 
	+ CASE WHEN DimProductSubcategory.ProductSubcategoryName = 'Televisions' THEN 0.05
		ELSE 0
	  END AS 'Desconto'
FROM 
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
INNER JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey	
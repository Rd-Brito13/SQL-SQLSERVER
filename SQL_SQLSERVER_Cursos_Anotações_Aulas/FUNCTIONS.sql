-- FUNCTIONS

SELECT
	*
FROM	
	dCliente
--Criando uma função para extrair o extendo os valores de uma data
--Cria a função, define o nome dela, o parametro e o tipo do parametro. (Comando CREATE OR ALTER, especifica que, ou ele vai criar a função no banco de dados ou vai alterar uma ja existente)
CREATE OR ALTER FUNCTION DataExtenso(@Data AS DATE)
--Tipo do retorno 
RETURNS VARCHAR(MAX)
--o AS serve para sinalizar que a função irá ser composta pelo código abaixo
AS
--Marca o começo do bloco da função
BEGIN
--O resultado da função
	RETURN DATENAME(DW,@Data)+', ' + 
	DATENAME(D,@Data)+ '' + ' de ' + 
	DATENAME(M,@Data) + ' de ' +  
	DATENAME(YY, @Data) +  ' - ' +
	CASE
		WHEN MONTH(@Data) <= 6 THEN '(1 Semestre)'
		ELSE '(2 Semestre)'
	END
--Marca o fim do bloco da função 
END

--Aplicando a função a tabela, passando a coluna Data_Nascimento, como parametro
SELECT
	*,
	--Chama a função e aplica o parametro
	[dbo].[DataExtenso](Data_Nascimento) AS 'Data Extenso'
FROM
	dCliente


--Exclui a função criada
DROP FUNCTION DataExtenso
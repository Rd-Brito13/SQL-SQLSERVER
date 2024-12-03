-- FUNCTIONS

SELECT
	*
FROM	
	dCliente
--Criando uma fun��o para extrair o extendo os valores de uma data
--Cria a fun��o, define o nome dela, o parametro e o tipo do parametro. (Comando CREATE OR ALTER, especifica que, ou ele vai criar a fun��o no banco de dados ou vai alterar uma ja existente)
CREATE OR ALTER FUNCTION DataExtenso(@Data AS DATE)
--Tipo do retorno 
RETURNS VARCHAR(MAX)
--o AS serve para sinalizar que a fun��o ir� ser composta pelo c�digo abaixo
AS
--Marca o come�o do bloco da fun��o
BEGIN
--O resultado da fun��o
	RETURN DATENAME(DW,@Data)+', ' + 
	DATENAME(D,@Data)+ '' + ' de ' + 
	DATENAME(M,@Data) + ' de ' +  
	DATENAME(YY, @Data) +  ' - ' +
	CASE
		WHEN MONTH(@Data) <= 6 THEN '(1 Semestre)'
		ELSE '(2 Semestre)'
	END
--Marca o fim do bloco da fun��o 
END

--Aplicando a fun��o a tabela, passando a coluna Data_Nascimento, como parametro
SELECT
	*,
	--Chama a fun��o e aplica o parametro
	[dbo].[DataExtenso](Data_Nascimento) AS 'Data Extenso'
FROM
	dCliente


--Exclui a fun��o criada
DROP FUNCTION DataExtenso
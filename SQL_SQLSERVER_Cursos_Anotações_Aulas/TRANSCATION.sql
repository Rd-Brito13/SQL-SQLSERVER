--Transactions

/*
Uma Transaction � uma a��o realizada dentro do banco de dados. 
Essa a��o pode ser uma atualiza��o, inser��o ou exclus�o de dados do banco. Precisamos de transa��es quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, n�o temos muito controle sovre transa��es, a menos que a gente explicite no nosso c�digo que queremos fazer isso. Assim, a ideia de uma transa��o � agrupar um conjunto de instru��es a serem executadas no banco de dados, e ter a flexibilidade de:
A) Se algo der errado, desfazer aquela transa��o
B) Se tudo der certo, salvar aquela transa��o

O que podemos fazer com uma transaction?
BEGIN TRANSACTION: inicar uma transaction
ROLLBACK TRANSACTION: desfazer uma transaction
COMMIT: Salvar uma transaction
*/

--Criando uma nova tabela e inserindo os dados da tabela dCliente atrav�s do comando INTO para cliente_aux
SELECT 
	*
INTO cliente_aux
FROM
	dCliente

--Exibindo a tabela
SELECT
	*
FROM
	cliente_aux

--Inserindo dados
INSERT INTO cliente_aux(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Maria Julia','F','30/04/1995','987.654.321-00')

--Atualizando dados
UPDATE cliente_aux
	SET CPF = '009.849.115-61'
	WHERE Id_Cliente = 11

--Deletando dados
DELETE FROM cliente_aux
	WHERE Id_Cliente = 21


-- Quando executamos as a��es acima, n�o temos controle se escolhemos salvar ou reverter
-- COMMIT comando TCL salva as transa��es
-- ROLLBACK comando TCL reverte as transa��es

-- ININICIANDO TRANSA��ES

SELECT
	*
FROM
	cliente_aux

BEGIN TRANSACTION
INSERT INTO cliente_aux(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Maria Julia','F','30/04/1995','987.654.321-00')
--Desfazendo as altera��es
ROLLBACK TRANSACTION
--salvando as altera��es
COMMIT TRANSACTION

--Atualizando o cpf de uma tabela com uma transa��o nomeada
BEGIN TRANSACTION Transacao_1
UPDATE cliente_aux
SET CPF = '000.000.000.-00'
WHERE Id_Cliente = 4
--desfazendo a altera��o
ROLLBACK TRANSACTION Transacao_1


--TRANSACTION CONDICIONAIS
SELECT
	*
FROM
	cliente_aux

--Declarando a variavel que ser� o contador
DECLARE @contador INT
--Iniciando a transa��o
BEGIN TRANSACTION Transacao_1
--Inserindo valor na tabela
INSERT INTO cliente_aux(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Ruth Campos','Outro','19/05/1985','008.586.254.78')
--Utilizando o contador para saber quantos vezes o nome 'Ruth Campos' aparece na tabela
SELECT @contador = COUNT(*) FROM cliente_aux WHERE Nome_Cliente = 'Ruth Campos'
--Realizando o teste condicional, para decidir se �r� salvar a transa��o ou desfazer ela. (Com base se existir ou n�o o usuario na tabela)
IF @contador = 1
--Inicia o IF, caso a condi��o seja verdadeira, Salva a mudan�a com o commit e printa
	BEGIN
		COMMIT TRANSACTION Transacao_1
		PRINT 'Ruth Campos, Cadastrada com sucesso.'
	END

ELSE
--Caso seja falsa, desfaz a inser��o e printa na tela
	BEGIN
		ROLLBACK TRANSACTION Trasacao_1
		PRINT 'Cadastro n�o foi finalizado, Ruth Campos, j� existe no banco de dados'
	END


--TRATAMENTO DE ERRO EM EXCE��ES TRY CATCH

BEGIN TRY
	BEGIN TRANSACTION T1

		UPDATE cliente_aux
		SET Data_Nascimento = '15/03/1992'
		WHERE Id_Cliente = 4

	COMMIT TRANSACTION T1
	PRINT 'Data atualizada'
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION T1
	PRINT 'Formato Invalido'

END CATCH


-- TRANCOUNT e Transa��es aninhadas 
--Come�a uma Transa��o
BEGIN TRANSACTION T2
--Salva e fecha a transa��o
COMMIT TRANSACTION T2

--PRINT @@TRANCOUNT � um comando utilizado para contar a quantidade de transa��es que est�o abertas, que n foram finalizada com um rollback ou commit
PRINT @@TRANCOUNT
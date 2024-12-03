--Transactions

/*
Uma Transaction é uma ação realizada dentro do banco de dados. 
Essa ação pode ser uma atualização, inserção ou exclusão de dados do banco. Precisamos de transações quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, não temos muito controle sovre transações, a menos que a gente explicite no nosso código que queremos fazer isso. Assim, a ideia de uma transação é agrupar um conjunto de instruções a serem executadas no banco de dados, e ter a flexibilidade de:
A) Se algo der errado, desfazer aquela transação
B) Se tudo der certo, salvar aquela transação

O que podemos fazer com uma transaction?
BEGIN TRANSACTION: inicar uma transaction
ROLLBACK TRANSACTION: desfazer uma transaction
COMMIT: Salvar uma transaction
*/

--Criando uma nova tabela e inserindo os dados da tabela dCliente através do comando INTO para cliente_aux
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


-- Quando executamos as ações acima, não temos controle se escolhemos salvar ou reverter
-- COMMIT comando TCL salva as transações
-- ROLLBACK comando TCL reverte as transações

-- ININICIANDO TRANSAÇÕES

SELECT
	*
FROM
	cliente_aux

BEGIN TRANSACTION
INSERT INTO cliente_aux(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Maria Julia','F','30/04/1995','987.654.321-00')
--Desfazendo as alterações
ROLLBACK TRANSACTION
--salvando as alterações
COMMIT TRANSACTION

--Atualizando o cpf de uma tabela com uma transação nomeada
BEGIN TRANSACTION Transacao_1
UPDATE cliente_aux
SET CPF = '000.000.000.-00'
WHERE Id_Cliente = 4
--desfazendo a alteração
ROLLBACK TRANSACTION Transacao_1


--TRANSACTION CONDICIONAIS
SELECT
	*
FROM
	cliente_aux

--Declarando a variavel que será o contador
DECLARE @contador INT
--Iniciando a transação
BEGIN TRANSACTION Transacao_1
--Inserindo valor na tabela
INSERT INTO cliente_aux(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Ruth Campos','Outro','19/05/1985','008.586.254.78')
--Utilizando o contador para saber quantos vezes o nome 'Ruth Campos' aparece na tabela
SELECT @contador = COUNT(*) FROM cliente_aux WHERE Nome_Cliente = 'Ruth Campos'
--Realizando o teste condicional, para decidir se írá salvar a transação ou desfazer ela. (Com base se existir ou não o usuario na tabela)
IF @contador = 1
--Inicia o IF, caso a condição seja verdadeira, Salva a mudança com o commit e printa
	BEGIN
		COMMIT TRANSACTION Transacao_1
		PRINT 'Ruth Campos, Cadastrada com sucesso.'
	END

ELSE
--Caso seja falsa, desfaz a inserção e printa na tela
	BEGIN
		ROLLBACK TRANSACTION Trasacao_1
		PRINT 'Cadastro não foi finalizado, Ruth Campos, já existe no banco de dados'
	END


--TRATAMENTO DE ERRO EM EXCEÇÕES TRY CATCH

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


-- TRANCOUNT e Transações aninhadas 
--Começa uma Transação
BEGIN TRANSACTION T2
--Salva e fecha a transação
COMMIT TRANSACTION T2

--PRINT @@TRANCOUNT é um comando utilizado para contar a quantidade de transações que estão abertas, que n foram finalizada com um rollback ou commit
PRINT @@TRANCOUNT
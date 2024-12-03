--TRIGGER DML -AFTER

--Criando a TRIGGER ou Gatilho, que � ativado, ap�s um INSERT, UPDATE ou DELETE, na tabela dCliente
CREATE OR ALTER TRIGGER tgClienteAlterado
--Define a qual tabela a trigger vai estar atrelada
ON dCliente
--Define a condi��o para a trigger ser chamada, se vai ser chamanda AFER(Depois) que houver uma das 3 altera��es, UPDATE, INSERT ou DELETE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	--Oq ser� exibido quando a trigger for ativada
	PRINT 'Os dados da tabela dCliente foram alterados!'

END


--Insere uma nova linha na tabela
BEGIN TRANSACTION 
INSERT INTO dCliente(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Jo�o Alberto Freire','Outro','13/10/1983','878.985.412-72')
COMMIT TRANSACTION

--Atualiza o cliente na tabela
UPDATE dCliente
SET Genero = 'M'
WHERE Id_Cliente = 24

--Deleta o cliente da tabela
DELETE FROM dCliente
WHERE Id_Cliente = 24

--Exibe a tabela
SELECT
	*
FROM
	dCliente



--Criando a TRIGGER ou Gatilho, que � ativado, ap�s um INSERT, UPDATE ou DELETE, na tabela dCliente
CREATE OR ALTER TRIGGER tgClienteAlterado
--Define a qual tabela a trigger vai estar atrelada
ON dCliente
--Define a condi��o para a trigger ser chamada, se vai ser chamanda AFER(Depois) que houver uma das 3 altera��es, UPDATE, INSERT ou DELETE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN 
	--VAI ATIVAR SE HOUVER UM UPDATE NA TABELA , UM UPDATE � COMPOSTO POR UM INSERT E DELATE, POR ISSO � FEITO DESTA MANEIRA
	IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
	--Oq ser� exibido quando a trigger for ativada
		PRINT 'Dados foram Atualizados na tabela dCliente'
	--Ativa se houver um insert na tabela
	ELSE IF EXISTS (SELECT * FROM INSERTED)
	--Oq ser� exibido quando a trigger for ativada
		PRINT 'Dados foram inseridos na tabela dCliente'
	--VAI ATIVAR SE HOUVER UM DELETE NA TABELA
	ELSE IF EXISTS (SELECT * FROM DELETED)
	--Oq ser� exibido quando a trigger for ativada
		PRINT 'Dados foram deletados na tabela dCliente'

END


--Utilizando o INSTEAD OF
--Impede que os dados seja inseridos aos sabado e domingo
CREATE OR ALTER TRIGGER ImpedirCadastro
ON dCliente
-- INSTEAD OF � utilizado para impedir que aconte�a uma a��o na tabela, pr� definida, seja insert, delete, update
INSTEAD OF INSERT
AS 
BEGIN
	IF FORMAT(GETDATE(), 'dddd') IN ('sabado', 'domingo')
	BEGIN 
		RAISERROR('O cadastro de clientes s� pode se feito de segunda � sexta',1,1)
		ROLLBACK
	END

	ELSE
	BEGIN
		--Utiliza a tabela inserted para inserir o valor na tabela dCliente.
		INSERT INTO dCliente(Nome_Cliente,Genero,Data_Nascimento,CPF) 
		--selectiona as colunas da tabela inserted com i.colunas, para definir
		SELECT i.Nome_Cliente, i.Genero, i.Data_Nascimento, i.CPF FROM inserted i
	END

END

--insere os valores
INSERT INTO dCliente(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Jo�o Grand�o', 'PND', '08/09/2002', '979.455.285.72')

--Utilizado para habilitar e desabilitar somente 1 trigger
ENABLE TRIGGER ImpedirCadastro ON dCliente 

--utilizado para habilitar ou desabilitar todas as trigger
ENABLE TRIGGER ALL ON dCliente

--utilizado para excluir uma triggar
DROP TRIGGER ImpedirCadastro


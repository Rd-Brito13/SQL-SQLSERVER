--CRIA A TRIGGER DDL
CREATE OR ALTER TRIGGER TgRecusarTabelas
-- DEFINE QUE SERA NA DATABASE
ON DATABASE
--Define as especifica��es que trigger ir� agir
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS 
BEGIN
	
	PRINT'N�o � permitido cria��o, altera��o ou exclus�o de tabelas'
	ROLLBACK
END
--tenta criar a tabela
CREATE TABLE teste(id INT)

--desabilita a trigger
DISABLE TRIGGER tgRecusarTabelas ON DATABASE
--ativa a trigger
ENABLE TRIGGER tgRecusarTabelas ON DATABASE

--descarta a trigger
DROP TRIGGER tgRecusarTabelas ON DATABASE
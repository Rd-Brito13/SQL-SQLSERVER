--CRIA A TRIGGER DDL
CREATE OR ALTER TRIGGER TgRecusarTabelas
-- DEFINE QUE SERA NA DATABASE
ON DATABASE
--Define as especificações que trigger irá agir
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS 
BEGIN
	
	PRINT'Não é permitido criação, alteração ou exclusão de tabelas'
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
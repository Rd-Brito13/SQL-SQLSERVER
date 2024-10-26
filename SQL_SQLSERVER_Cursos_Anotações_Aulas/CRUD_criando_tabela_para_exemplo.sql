/*Criando a tabela que será utilizada para fazer os exercicios deste modulo CRUD*/
USE BDimpressionador

CREATE TABLE Funcionarios(
	Id_Funcionario INT,
	Nome_Funcionario VARCHAR(100),
	Salario FLOAT,
	Data_Nascimento DATETIME
	)

INSERT INTO Funcionarios(Id_Funcionario, Nome_Funcionario,Salario,Data_Nascimento)
VALUES
	(1,'João',8578,'10/12/1983'),
	(2,'Fernanda',15578.10,'05/07/1983'),
	(3,'Layla',1578.13,'01/01/2004'),
	(4,'Rafael',28578.99,'28/04/1963'),
	(5,'Pedro',2300.30,'10/10/1999'),
	(6,'Paulo Daniel',5830.35,'10/02/2002'),
	(7,'João Paulo',14000,'08/12/1983'),
	(8,'Gil',858.59,'10/11/1949'),
	(9,'Thaina',1250.85,'05/12/1973'),
	(10,'Cassia',0.1,'15/12/1943')

-- Adicionando duas novas colunas a tabela funcionarios com o ALTER TABLE comando "ADD coluna tipo da coluna"
ALTER TABLE Funcionarios
ADD Cargo VARCHAR(50), Bonus FLOAT

-- Atualizando  tabela
UPDATE Funcionarios
SET Cargo = 'Assistente RH', Bonus = 0.5
WHERE Id_Funcionario = 3
SELECT
	*
FROM
	Funcionarios
-- Atividade Transactions
--Criando a tabela
CREATE TABLE Carro(
--Criando as colunas e definindo os tipos
Id_Carro INT IDENTITY(1,1),
Placa VARCHAR(100) NOT NULL,
Modelo VARCHAR(100) NOT NULL,
Tipo VARCHAR(100) NOT NULL
)
USE Exercicios
--INSERINDO VALORES NA TABELA
INSERT Carro(Placa,	Modelo,Tipo)
VALUES
	('DAS-1412','Hyundai HB20','Hatch'),
	('JHG-3902','Fiat Cronos','Sedan'),
	('IPW-9018', 'Citroen C4 Cactus','SUV'),
	('JKR-8991','NIssa Kicks','SUV'),
	('TRF-5904','Cherolet Onix','Sedan')

--TRANSAÇÃO PARA INSERIR DADOS
BEGIN TRANSACTION InserirLinha
INSERT Carro(Placa, Modelo, Tipo)
VALUES
	('DFG-1923', 'Corsa 2.0','Chevrolet')

COMMIT TRANSACTION InserirLinha
--TRANSAÇÃO PARA ATUALIZAR A LINHA
BEGIN TRANSACTION AlterarTipo
UPDATE Carro
SET Tipo = 'Sedan'
WHERE Id_Carro = 1
COMMIT TRANSACTION AlterarTipo

--tRANSAÇÃO PARA DELETAR A LINHA
BEGIN TRANSACTION DeletarLinha
DELETE FROM Carro		
WHERE Id_Carro = 6
COMMIT TRANSACTION DeletarLinha
--EXEBINDO A TABELA
SELECT
	*
FROM
	Carro
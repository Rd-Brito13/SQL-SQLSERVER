--Criando a base de ados e as tabelas
CREATE DATABASE PythonSql
USE PythonSql

--Criando a Tabela
CREATE TABLE Vendas(
Id_Venda INT IDENTITY(1,1),
Data_Venda DATE NOT NULL,
Cliente VARCHAR(100) NOT NULL,
Produto VARCHAR(100) NOT NULL,
Preco FLOAT NOT NULL,
Quantidade INT NOT NULL

--Criando as constraints
CONSTRAINT	cliente_id_pk PRIMARY KEY(Id_Venda),
 )

 --INSERINDO VALORES NA TABELA, antes da constraint para a coluna data
INSERT INTO Vendas(Data_Venda, Cliente, Produto, Preco,Quantidade)
VALUES
	(CONVERT(date,GETDATE()),'Romão Santana','Celular',1500,1)


--Alterei a tabela vendas e adicionei uma nova contraint a coluna Data_Venda, para que seja padrão a captura de data pelo sistema (somente, data, dia mes e ano )
ALTER TABLE Vendas
ADD CONSTRAINT data_padrao_df
DEFAULT CONVERT(date,GETDATE()) FOR Data_Venda

SELECT
	*
FROM
	Vendas

DBCC CHECKIDENT ('Vendas', RESEED, 6)



--Criando o banco de dados
CREATE DATABASE AlugaFacil
--Utilizando ele
USE AlugaFacil

--Criando a tabela Cliente
CREATE TABLE Cliente(
--Definindo as colunas e os tipos das colunas
Id_Cliente INT,
Nome_Cliente VARCHAR(100) NOT NULL,
CNH VARCHAR(100) NOT NULL,
Cartao VARCHAR(100) NOT NULL,

--Criando Constraints para as colunas
CONSTRAINT Id_Cliente_pk PRIMARY KEY(Id_Cliente),
CONSTRAINT CNH_un UNIQUE(CNH)
)

--Criando a tabela Carro
CREATE TABLE Carro(
--Criando as colunas e os tipos
Id_Carro INT,
Placa VARCHAR(100) NOT NULL,
Modelo VARCHAR(100) NOT NULL,
Tipo VARCHAR(100) NOT NULL,

--Criando as constraints para as colunas
CONSTRAINT Id_Carro_pk PRIMARY KEY(Id_Carro),
CONSTRAINT Tipo_ck CHECK(Tipo IN ('Hatch', 'Sedan', 'SUV')),
CONSTRAINT Placa_un UNIQUE(Tipo)
)

DROP TABLE Carro

--Criando a tabela Locacoes
CREATE TABLE Locacoes(
Id_Locacao INT,
Data_Locacao DATETIME DEFAULT GETDATE(),
Data_Devolucao DATETIME DEFAULT GETDATE(),
Id_Carro INT NOT NULL,
Id_Cliente INT NOT NULL,

--Criando as constraints para as colunas
CONSTRAINT Id_Locacao_pk PRIMARY KEY(Id_Locacao),
CONSTRAINT Id_Carro_fk FOREIGN KEY(Id_Carro) REFERENCES Carro(Id_Carro),
CONSTRAINT Id_Cliente_fk FOREIGN KEY(Id_Cliente) REFERENCES Cliente(Id_Cliente)
)

DROP TABLE Locacoes
--criar as sequences
--clientes
CREATE SEQUENCE Cliente_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE

--carro
CREATE SEQUENCE Carro_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE

--locacoes
CREATE SEQUENCE Locacoes_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
drop sequence Locacoes_seq


-- INSERINDO VALORES A CLIENTE

INSERT INTO Cliente(Id_Cliente, Nome_Cliente,CNH, Cartao)
VALUES 
	(NEXT VALUE FOR Cliente_seq, 'Thainá Barbosa','73381530365','5258506494857620'),
	(NEXT VALUE FOR Cliente_seq, 'Fernando Batista','86982793608','342270140544525')

-- INSERINDO VALORES A CARRO
INSERT INTO Carro(Id_Carro,Placa,Modelo,Tipo)
VALUES
	(NEXT VALUE FOR Carro_seq,'JIF9860','Z8','Hatch'),
	(NEXT VALUE FOR Carro_seq,'HVW2219','g450','Sedan'),
	(NEXT VALUE FOR Carro_seq,'NEB7010','Z8020','SUV')

-- INSERINDO VALORES A LOCACOES
INSERT INTO Locacoes(Id_Locacao, Data_Locacao,Data_Devolucao, Id_Carro, Id_Cliente)
VALUES
	(NEXT VALUE FOR Locacoes_seq,'12/05/2022','15/05/2022',1,2),
	(NEXT VALUE FOR Locacoes_seq, '05/08/2023','10/08/2023',3,1),
	(NEXT VALUE FOR Locacoes_seq,'','23/11/2024',2,1)


--EXIBINDO AS TABELAS

--carro
SELECT
	*
FROM
	Carro

--cliente
select
	*
from
	Cliente

--Locacoes
SELECT
	*
FROM
	Locacoes
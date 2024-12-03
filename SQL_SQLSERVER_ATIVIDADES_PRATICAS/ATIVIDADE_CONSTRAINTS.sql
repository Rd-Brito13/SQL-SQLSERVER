--exercicio CONSTRAINTS

--Criando o banco de dados
CREATE DATABASE AlugaFacil
--Utilizando ele
USE AlugaFacil

--Criando a tabela Cliente
CREATE TABLE Cliente(
--Definindo as colunas e os tipos das colunas
Id_Cliente INT IDENTITY(1,1),
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
Id_Carro INT IDENTITY(1,1),
Placa VARCHAR(100) NOT NULL,
Modelo VARCHAR(100) NOT NULL,
Tipo VARCHAR(100) NOT NULL,

--Criando as constraints para as colunas
CONSTRAINT Id_Carro_pk PRIMARY KEY(Id_Carro),
CONSTRAINT Tipo_ck CHECK(Tipo IN ('Hatch, Sedan, SUV')),
CONSTRAINT Placa_un UNIQUE(Tipo)
)


--Criando a tabela Locacoes
CREATE TABLE Locacoes(
Id_Locacao INT IDENTITY(1,1),
Data_Locacao DATETIME DEFAULT GETDATE(),
Data_Devolucao DATETIME DEFAULT GETDATE(),
Id_Carro INT NOT NULL,
Id_Cliente INT NOT NULL,

--Criando as constraints para as colunas
CONSTRAINT Id_Locacao_pk PRIMARY KEY(Id_Locacao),
CONSTRAINT Id_Carro_fk FOREIGN KEY(Id_Carro) REFERENCES Carro(Id_Carro),
CONSTRAINT Id_Cliente_fk FOREIGN KEY(Id_Cliente) REFERENCES Cliente(Id_Cliente)
)



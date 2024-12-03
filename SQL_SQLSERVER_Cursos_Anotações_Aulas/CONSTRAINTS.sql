--constraints 
--Criando a tabela
CREATE TABLE dCliente(
--Definindo as colunas e seus tipos
Id_Cliente INT IDENTITY(1,1),
Nome_Cliente VARCHAR(100) NOT NULL,
Genero VARCHAR(10)  NOT NULL,
Data_Nascimento DATE NOT NULL,
CPF VARCHAR(30) NOT NULL,

--construindo as constraints
CONSTRAINT dCliente_Generos_CK CHECK(Genero IN ('M','F','Outro','PND')),
CONSTRAINT dCliente_IDCliente_PK PRIMARY KEY(Id_Cliente),
CONSTRAINT dCliente_CPF_unique UNIQUE(CPF)
)
-- Inserindo valores em dCliente
INSERT INTO dCliente(Nome_Cliente,Genero,Data_Nascimento,CPF)
VALUES
	('Matias Santiago','M','14/11/1985','794.657.534-32'),
	('Juliana Daniela Farias','F','11/07/1956','316.353.576-32'),
	('Heitor Renato Aragão','Outro','04/06/1961','428.237.430-65'),
	('Daniel Enrico Assunção','PND','25/07/1981','119.400.704-06'),
	('Fernanda Andreia Luna Barros','F','05/08/1972','087.121.745-72'),
	('Emanuel Victor Moraes','M','01/04/2002','369.948.623-05'),
	('Tânia Mariane Betina Viana','Outro','20/04/1967','038.604.127-01'),
	('Luiza Malu da Conceição','F','23/09/1976','262.729.237-40'),
	('Betina Jennifer Gonçalves','PND','22/09/1976','077.166.126-62'),
	('Natália Catarina Márcia Almeida','F','06/03/1948','038.749.897-47'),
	('Luna Luana da Luz','PND','08/11/1945','Luna Luana da Luz'),
	('Edson Marcelo Novaes','M','19/04/1981','223.138.653-47'),
	('Valentina Jennifer Daiane Fogaça','M','07/11/1971','262.481.440-01'),
	('Sabrina Isis Raimunda Gomes','M','03/06/1954','787.918.381-77'),
	('Silvana Fátima Barros','M','09/11/2005','255.943.412-18'),
	('Bryan Caleb Souza','M','12/07/1950','150.484.956-67'),
	('Lorenzo Manoel Ricardo da Mata','PND','04/03/1990','019.356.304-58'),
	('Manuela Marcela Jesus','PND','01/11/1954','978.484.553-94'),
	('Carlos Eduardo Victor Viana','M','19/06/2000','741.232.182-02'),
	('Joana Alícia Rezende','F','18/10/1989','606.846.241-25')



-- Criando a tabela
CREATE TABLE dGerente(
-- Definiando as colunas das tabelas e seus tipos
Id_Gerente INT IDENTITY (1,1),
Nome_Gerente VARCHAR(100) NOT NULL,
Data_Contratacao VARCHAR(100) NOT NULL,
Salario FLOAT NOT NULL,
-- construindo as constraints
CONSTRAINT dGerente_Id_Gerente_PK PRIMARY KEY(Id_Gerente),
CONSTRAINT dGerente_Salario CHECK(Salario > 0)
)

INSERT INTO dGerente(Nome_Gerente,Data_Contratacao,Salario)
VALUES
	('Lucas Sampaio','21/03/2015',6758),
	('Mariana Padilha','10/01/2011',9900),
	('Nathália Santos','03/10/2018',7200),
	('Otávio Costa','18/04/2017',11599)



-- Criando a tabela
CREATE TABLE fContratos(
Id_Contratos INT IDENTITY (1,1),
Data_Assinatura DATE DEFAULT GETDATE(),
Id_Cliente INT,
Id_Gerente INT,
Valor_Contrato FLOAT NOT NULL,
--Criando as contraints
CONSTRAINT fContratos_Id_Contratos_pk PRIMARY KEY(Id_Contratos),
CONSTRAINT fContratos_Id_Cliente_fk FOREIGN KEY(Id_Cliente) REFERENCES dCliente(Id_Cliente),
CONSTRAINT fContratos_Id_Gerente_fk FOREIGN KEY(Id_Gerente) REFERENCES dGerente(Id_Gerente),
CONSTRAINT fContratos_Valor_Contrato_ck CHECK(Valor_Contrato > 0)

)
-- Inserindo os valores na tabela
INSERT INTO fContratos(Data_Assinatura, Id_Cliente, Id_Gerente, Valor_Contrato)
VALUES 
	('12/01/2019',8,1,2350000),
	('10/02/2019',3,2,155000),
	('07/03/2019',7,2,6500),
	('15/08/2019',15,3,330000),
	('21/03/2019',10,4,459000),
	('23/05/2019',9,2,55000),
	('28/03/2019',6,4,170000),
	('04/04/2019',2,1,751000),
	('17/09/2019',1,4,180000),
	('02/02/2019',5,2,17000),
	('16/01/2019',4,1,156328),
	('01/01/2019',11,3,149586),
	('30/12/2019',13,3,189000),
	('14/03/2019',14,1,1500),
	('12/01/2019',12,4,18000),
	('26/02/2019',19,2,1000),
	('28/05/2019',16,1,165000),
	('01/03/2019',18,3,19890),
	('20/02/2019',20,4,15400),
	('17/08/2019',17,4,650000)



-- Gerenciando Constraints 
-- Removendo da tabela fContratos a constraint fContratos_Id_Cliente_pk
ALTER TABLE fContratos
DROP CONSTRAINT fContratos_Id_Contratos_pk

-- Removendo da tabela fContratos a constraint fContratos_Id_Cliente_fk
ALTER TABLE fContratos
DROP CONSTRAINT fContratos_Id_Cliente_fk

-- adicionando a constraint a tabela fContratos fContratos_Id_Cliente_pk
ALTER TABLE  fContratos
ADD CONSTRAINT fContratos_Id_Contrato_pk PRIMARY KEY(Id_Contratos)

--adicionando a constraint a tabela fcontratos fContratos_Id_Cliente_fk
ALTER TABLE  fContratos
ADD CONSTRAINT fContratos_Id_Cliente_fk FOREIGN KEY(Id_Cliente) REFERENCES dCliente(Id_Cliente)
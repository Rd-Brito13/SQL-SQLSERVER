/*a) Crie um banco de dados chamado BD_Teste.
b) Exclua o banco de dados criado no item anterior.
c) Crie um banco de dados chamado Exercicios.
*/
-- A
CREATE DATABASE BD_Teste
-- B
DROP DATABASE BD_Teste

-- C
CREATE DATABASE Exercicios
/*2. No banco de dados criado no exercício anterior, crie 3 tabelas, cada uma contendo as seguintes colunas:
Tabela 1: dCliente
- ID_Cliente
- Nome_Cliente
- Data_de _Nascimento
Tabela 2: dGerente
- ID_Gerente
- Nome_Gerente
- Data_de_Contratacao
- Salario
Tabela 3: fContratos
- ID_Contrato
- Data_de_Assinatura
- ID_Cliente
- ID_Gerente
- Valor_do_Contrato
Lembre-se dos seguintes pontos:
a) Garantir que o Banco de Dados Exercicios está selecionado.
b) Definir qual será o tipo de dados mais adequado para cada coluna das tabelas. Lembrando que os tipos de dados mais comuns são: INT, FLOAT, VARCHAR e DATETIME.
Por fim, faça um SELECT para visualizar cada tabela. 

*/
USE Exercicios

CREATE TABLE dCliente(
	ID_Cliente INT,
	Nome_Cliente VARCHAR(60),
	Data_de_Nascimento DATETIME
)

CREATE TABLE dGerente(
	ID_Gerente INT,
	Nome_Gerente VARCHAR(60),
	Data_de_Contratacao DATETIME,
	Salario FLOAT
)

CREATE TABLE fContratos(
	ID_Contrato INT,
	Data_de_Assinatura DATETIME,
	ID_Cliente INT,
	ID_GERENTE INT,
	Valor_do_Contrato FLOAT
)

SELECT
	*
FROM
	dCliente

SELECT
	*
FROM
	dGerente

SELECT
	*
FROM
	fContratos

/*3. Em cada uma das 3 tabelas, adicione os seguintes valores:
*/
--inserindo valores para clientes
GO
INSERT INTO dCliente(ID_Cliente, Nome_Cliente,Data_de_Nascimento)
VALUES
	(1,'João','10/12/1983'),
	(2,'Fernanda','05/07/1983'),
	(3,'Layla','01/01/2004'),
	(4,'Rafael','28/04/1963'),
	(5,'Pedro','10/10/1999'),
	(6,'Paulo Daniel','10/02/2002'),
	(7,'João Paulo','08/12/1983'),
	(8,'Gil','10/11/1949')
GO

-- inserindo valores para gerentes
GO
INSERT INTO dGerente(ID_Gerente, Nome_Gerente,Salario,Data_de_Contratacao)
VALUES
	(1,'João',8578,'10/12/2015'),
	(2,'Fernanda',15578.10,'05/07/2011'),
	(3,'Layla',15780.13,'01/01/2007'),
	(4,'Rafael',28578.99,'28/04/2019')
GO
-- inserindo valores para contratos
GO
INSERT INTO fContratos(ID_Contrato,Valor_do_Contrato ,Data_de_Assinatura,ID_Cliente,ID_GERENTE)
VALUES
	(1,8578,'10/12/2019',8,1),
	(2,15578.10,'05/07/2019',3,2),
	(3,157802.13,'01/01/2019',7,2),
	(4,2857812.99,'28/04/2019',1,3),
	(5,2300695.30,'10/10/2019',5,4),
	(6,5830214.35,'10/02/2019',4,2),
	(7,14000,'08/12/2019',2,3),
	(8,858694.59,'10/11/2019',2,1),
	(9,10250.85,'05/12/2019',6,4),
	(10,1024578,'15/12/2019',8,2)
GO





/*
4. Novos dados deverão ser adicionados nas tabelas dCliente, dGerente e fContratos. Fique livre para adicionar uma nova linha em cada tabela contendo, respectivamente, 
(1) um novo cliente (id cliente, nome e data de nascimento)
(2) um novo gerente (id gerente, nome, data de contratação e salário)
(3) um novo contrato (id, data assinatura, id cliente, id gerente, valor do contrato)


*/
GO

INSERT INTO dCliente(ID_Cliente,Nome_Cliente,Data_de_Nascimento)
VALUES
	(9, 'Abdias', '10/05/1940')
GO

GO
INSERT INTO dGerente(ID_Gerente,Nome_Gerente,Data_de_Contratacao,Salario)
VALUES
	(5,'Pedro','02/07/2019',89154.15)
GO

GO
INSERT INTO fContratos(ID_Contrato, Data_de_Assinatura,ID_Cliente,ID_GERENTE,Valor_do_Contrato)
VALUES
	(11,'10/09/2020',9,5,154782.45)
GO

/*5. O contrato de ID igual a 4 foi registrado com alguns erros na tabela fContratos. Faça uma
alteração na tabela atualizando os seguintes valores:
Data_de_Assinatura: 17/03/2019
ID_Gerente: 2
Valor_do_Contrato: 33500*/
UPDATE  fContratos
SET ID_GERENTE = 2, Data_de_Assinatura = '17/3/2019', Valor_do_Contrato = 33500
WHERE Valor_do_Contrato = 8578


DROP TABLE fContratos
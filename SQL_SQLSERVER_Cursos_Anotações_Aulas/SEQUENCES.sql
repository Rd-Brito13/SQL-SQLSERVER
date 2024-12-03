-- SEQUENCES
 --Sinxtaxe SEQUENCES
/*
CREATE SEQUENCE Clientes_seq
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 99
NO CYCLE
*/

-- Criando a sequence
CREATE SEQUENCE Clientes_seq
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 99
NO CYCLE

--Selecionando o proximo valor da sequencia
SELECT NEXT VALUE FOR Clientes_seq AS 'Sequencia'

--Excluindo a sequencia
DROP SEQUENCE clientes_seq


USE Exercicios

-- sequence na pratica
CREATE SEQUENCE projeto_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE

CREATE TABLE dProjeto(

-- Definindo as colunas da tabela
Id_Projeto INT,
Nome_Projeto VARCHAR(100) NOT NULL,

--Criando a CONSTRAINT
CONSTRAINT Id_Projeto_pk PRIMARY KEY(Id_Projeto)
)
-- inserindo os ID com a sequence na coluna Id_Projeto na tabela dProjeto
INSERT INTO dProjeto
VALUES
	(NEXT VALUE FOR projeto_seq, 'Planejgamento Estratégico'),
	(NEXT VALUE FOR projeto_seq, 'Desenvolvimento de app'),
	(NEXT VALUE FOR projeto_seq, 'Plano de negócios'),
	(NEXT VALUE FOR projeto_seq, 'Visualização 3D')

SELECT
	*
FROM
	dProjeto
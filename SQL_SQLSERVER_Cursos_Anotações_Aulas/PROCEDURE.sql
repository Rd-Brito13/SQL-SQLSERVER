--Procedures
--
--Criando a PROCEDURES sem parametro
CREATE PROCEDURE prOrdenaGerentes
AS
BEGIN
	SELECT
		*
	FROM
		dGerente
	order by Id_Gerente desc
END
--Executa a PROCEDURE criada
EXECUTE prOrdenaGerentes

--Criando a procedure com parametro
CREATE OR ALTER PROCEDURE FiltrarClientes(@genero AS VARCHAR(100))
AS
BEGIN
--Definindo a estrututra da procedure
	SELECT
		*
	FROM
		dCliente
	WHERE Genero = @genero
END
--Executando e satisfazendo o parametro
EXECUTE FiltrarClientes 'Outro'


--Procedures com 2 parametros
CREATE OR ALTER PROCEDURE FiltrarClientes2condicoes(@genero AS VARCHAR(MAX), @id INT)
AS
BEGIN
--Definindo a procedure
	SELECT
		*
	FROM
		dCliente
	WHERE Genero = @genero AND Id_Cliente IN (@id)
END
--Executando a procedure com 2 parametros
EXECUTE FiltrarClientes2condicoes 'M', 1



--Porcedures com valor de parametro padrão, default
CREATE OR ALTER PROCEDURE FiltrarClientes2condicoesDefault(@genero AS VARCHAR(MAX) = 'F', @id INT)
AS
BEGIN
--Definindo a procedure
	SELECT
		*
	FROM
		dCliente
	WHERE Genero = @genero AND Id_Cliente = @id
END
--Executando a procedure com 2 parametros
EXECUTE FiltrarClientes2condicoesDefault @id = 2



/*Criando uma PROCEDURE mais complexa para Cadastro de Contratos*/

--Exemplo: Crie uma procedure para cadastrar uma nova assinatura de um contrato na tabela FContratos (Com parametros)

--Gerente: Lucas Sampaio
--Cliente: Gustavo Barbosa
--Valor do contratos: 5000

--Cria a PROCEDURE
CREATE OR ALTER PROCEDURE CadastrarContrato(@IDgerente AS VARCHAR(MAX), @IDcliente AS VARCHAR(MAX), @Valorcontrato AS FLOAT)
AS
--cria o corpo
BEGIN
	--Criando uma transaction para formalizar e salvar a alteração na tabela
	BEGIN TRANSACTION 
	DECLARE @gerente INT = (SELECT Id_Gerente FROM dGerente WHERE Nome_Gerente = @IDgerente)
	DECLARE @cliente INT = (SELECT Id_Cliente FROM dCliente WHERE Nome_Cliente = @IDcliente)
	DECLARE @data DATE = GETDATE()
	DECLARE @valor FLOAT = @ValorContrato
	--oq sera inserido na tabela
		INSERT INTO fContratos(Id_Gerente,Id_Cliente,Data_Assinatura,Valor_Contrato)
		VALUES
			(@gerente, @cliente, @data,@valor)
	-- salva a atualização 
	COMMIT 
END


--Executa a procedure
EXECUTE CadastrarContrato 'Mariana Padilha','Bryan Caleb Souza', 15800

--Exibe a tabela
SELECT	
	*
FROM
	fContratos


--Comando para desativar todas as constraints
ALTER TABLE fContratos NOCHECK CONSTRAINT ALL
-- Reseta o contador do identity, para o maior numero selecionado
DBCC CHECKIDENT ('fContratos', RESEED, 21)
--reativa as contraints
ALTER TABLE fContratos CHECK CONSTRAINT ALL




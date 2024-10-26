--1

DECLARE @Valorinicial INT = 0, @Valorfinal INT = 100

WHILE @Valorinicial < @Valorfinal
BEGIN

SET @Valorinicial += 1
PRINT 'O valor inicial é: ' + CONVERT(VARCHAR,@Valorinicial)

END
--2
DECLARE @anoinicial INT = 1996, @anofinal int = 2003

WHILE @anoinicial <= @anofinal
BEGIN
DECLARE @QTDfuncionarios INT = (SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HireDate) = @anoinicial)
PRINT 'Ano: ' + Convert(VARCHAR, @anoinicial) + ' - Quantidade: ' + CONVERT(VARCHAR,@QTDfuncionarios)
SET @anoinicial = @anoinicial + 1
END
	


-- 3

CREATE TABLE Calendario (
	Locale DATE
)

DECLARE @datainicio DATE = '01/01/2024', @datafim DATE = '31/12/2024'

WHILE @datainicio <= @datafim

BEGIN
	INSERT INTO Calendario (Locale) VALUES (@datainicio)
	SET @datainicio = DATEADD(DAY, 1, @datainicio)

END

SELECT
	*
FROM
	Calendario


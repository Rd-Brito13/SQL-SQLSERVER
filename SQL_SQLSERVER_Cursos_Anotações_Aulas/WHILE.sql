-- Construindo um while

DECLARE @contar INT
SET @contar = 1

WHILE @contar <= 10
	BEGIN
		PRINT @contar
		SET @contar += 1
	END



--BREAK
WHILE @contar <= 100
BEGIN	
	PRINT'O valor do contador é:' + CONVERT(VARCHAR, @contar)
	IF @contar = 15
	BREAK
	SET @contar = @contar +1 
END

-- CONTINUE
DECLARE @contador INT
SET @contador = 1

WHILE @contador <=10
BEGIN 
	SET @contador +=1
	IF @contador = 3 OR @contador = 6
	CONTINUE
	PRINT 'O valor da variavel é: '+ CONVERT(VARCHAR, @Contador)
END
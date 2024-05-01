-- TASK 1

USE [SoftUni]
GO

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE [Salary] > 35000

EXEC usp_GetEmployeesSalaryAbove35000
GO

-- TASK 2

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18, 4))
AS
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE [Salary] >= @number

EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

-- TASK 3

CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith(@substr VARCHAR(50))
AS
	DECLARE @nameLength INT
	SET @nameLength = LEN(@substr)
	SELECT [Name] FROM [Towns]
	WHERE SUBSTRING([Name], 1, @nameLength) = @substr

EXEC usp_GetTownsStartingWith S
GO

-- TASK 4

CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
	SELECT e.[FirstName] AS [First Name],
	e.[LastName] AS [Last Name]
	FROM [Employees] AS e
	INNER JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	INNER JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
	WHERE t.[Name] = @townName

EXEC usp_GetEmployeesFromTown Sofia
GO

-- TASK 5

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @level VARCHAR(10)
	IF (@salary < 30000)
	BEGIN
		SET @level = 'Low'
	END
	ELSE IF (@salary BETWEEN 30000 AND 50000)
	BEGIN
		SET @level = 'Average'
	END
	ELSE
	BEGIN
		SET @level = 'High'
	END
	RETURN @level
END
GO

SELECT [Salary],
dbo.ufn_GetSalaryLevel([Salary]) AS [Salary Level]
FROM [Employees]
GO

-- TASK 6

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel(@levelOfSalary VARCHAR(10))
AS
	SELECT [FirstName] AS [First Name],
	[LastName] AS [Last Name]
	FROM [Employees]
	WHERE dbo.ufn_GetSalaryLevel([Salary]) = @levelOfSalary
GO

EXEC usp_EmployeesBySalaryLevel [High]
GO

-- TASK 7

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @wordLength INT = LEN(@word)
	DECLARE @index INT = 1
	DECLARE @currentLetter CHAR(1)
	WHILE (@index <= @wordLength)
		BEGIN
			SET @currentLetter = SUBSTRING(@word, @index, 1)
			IF (CHARINDEX(@currentLetter, @setOfLetters) > 0)
			BEGIN
				SET @index = @index + 1
			END
			ELSE
			BEGIN
				RETURN 0
			END		
		END
	RETURN 1
END
GO

-- TASK 9

USE [Bank]
GO

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName 
AS
	SELECT CONCAT_WS(' ', [FirstName], [LastName]) 
	AS [Full Name]
	FROM [AccountHolders]
GO

EXEC usp_GetHoldersFullName

-- TASK 10

SELECT * FROM [AccountHolders]
SELECT * FROM [Accounts]
GO

CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan(@searchedBalance MONEY)
AS
	SELECT ah.[FirstName], ah.[LastName] 
	FROM [AccountHolders] AS ah
	JOIN [Accounts] AS a ON ah.[Id] = a.[AccountHolderId]
	GROUP BY ah.[FirstName], ah.[LastName]
	HAVING SUM(a.[Balance]) > @searchedBalance
	ORDER BY ah.[FirstName] ASC, ah.[LastName] ASC
GO

EXEC usp_GetHoldersWithBalanceHigherThan 60000
GO

-- TASK 11

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@sum DECIMAL (15, 4), @interestRate FLOAT, @years INT)
RETURNS DECIMAL (15, 4)
AS
BEGIN	
	DECLARE @fv DECIMAL (15, 4)
	SET @fv = @sum * POWER((1 + @interestRate), @years)
	RETURN @fv
END
GO

-- TASK 12

CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount(@accountId INT, @interestRate FLOAT)
AS
	SELECT a.[Id] AS [Account Id],
	ah.[FirstName], ah.[LastName],
	a.[Balance] AS [CurrentBalance],
	dbo.ufn_CalculateFutureValue(a.[Balance], @interestRate, 5) AS [Balance in 5 years]
	FROM [AccountHolders] AS ah
	JOIN [Accounts] AS a ON a.[AccountHolderId] = ah.[Id]
	WHERE a.[id] = @accountId
GO

EXEC usp_CalculateFutureValueForAccount 1, 0.1
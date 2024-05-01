GO
CREATE OR ALTER FUNCTION udf_projectDurationInWeeks (@startDate DATETIME, @endDate DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @durationInWeeks INT
		IF (@endDate IS NULL)
		BEGIN
			SET @endDate = GETDATE()
		END
	SET @durationInWeeks = DATEDIFF(WEEK, @startDate, @endDate)
	RETURN @durationInWeeks
END
GO

SELECT [ProjectID], [StartDate], [EndDate],
dbo.udf_projectDurationInWeeks([StartDate], [EndDate])
AS [ProjectWeeks]
FROM [Projects]

-- TASK 5
GO
CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @estimate VARCHAR(10)
	IF (@salary < 30000)
		SET @estimate = 'Low'
	ELSE IF (@salary BETWEEN 30000 AND 50000)	
		SET @estimate = 'Average'
	ELSE
		SET @estimate = 'High'
	RETURN @estimate
END

GO
SELECT [FirstName], [LastName], [Salary],
dbo.ufn_GetSalaryLevel([Salary])
AS [SalaryLevel]
FROM [Employees]

USE [SoftUni]
GO

CREATE OR ALTER PROCEDURE usp_SelectEmployeesBySeniority
AS
SELECT * FROM [Employees]
WHERE DATEDIFF(YEAR, [HireDate], GETDATE()) > 20
GO

EXEC usp_SelectEmployeesBySeniority
GO

ALTER PROCEDURE usp_SelectEmployeesBySeniority
AS
SELECT [FirstName], [LastName], [HireDate],
DATEDIFF(YEAR, [HireDate], GETDATE()) AS [Years]
FROM [Employees]
WHERE DATEDIFF(YEAR, [HireDate], GETDATE()) > 20
ORDER BY [HireDate] ASC
GO

EXEC usp_SelectEmployeesBySeniority
EXEC sp_depends 'usp_SelectEmployeesBySeniority'

DROP PROCEDURE usp_SelectEmployeesBySeniority
GO

CREATE OR ALTER PROCEDURE usp_SelectBySeniority (@minYearsWork INT = 5)
AS
SELECT [FirstName], [LastName], [HireDate],
DATEDIFF(YEAR, [HireDate], GETDATE()) AS [Years]
FROM [Employees]
WHERE DATEDIFF(YEAR, [HireDate], GETDATE()) > @minYearsWork
ORDER BY [HireDate] ASC
GO

EXEC usp_SelectBySeniority 21;
GO

-- TASK 4

CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown (@selectedTown VARCHAR(50))
AS
SELECT e.[FirstName], e.[LastName]
FROM [Employees] AS e
JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
JOIN [Towns] AS t ON t.[TownID] = a.[TownID]
WHERE t.[Name] = @selectedTown
GO

EXEC usp_GetEmployeesFromTown Sofia
GO

-- TASK 3

CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith (@pattern VARCHAR(50))
AS
DECLARE @stringLength INT = LEN(@pattern)
SELECT [Name] FROM [Towns]
WHERE SUBSTRING([Name], 1, @stringLength) IN (@pattern)
GO

EXEC usp_GetTownsStartingWith B
GO

-- TASK 2

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber (@number DECIMAL (18, 4))
AS
	SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE [Salary] >= @number
GO

EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

-- TASK 1

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE [Salary] > 35000

EXEC usp_GetEmployeesSalaryAbove35000
GO

-- TASK 6

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel (@level VARCHAR(10))
AS	
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE dbo.ufn_GetSalaryLevel([Salary]) = @level

EXEC usp_EmployeesBySalaryLevel "High"
GO

-- TASK 7

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @index INT = 1
	DECLARE @currentLetter CHAR(1)
	WHILE (@index <= LEN(@word))
	BEGIN
		SET @currentLetter = SUBSTRING(@word, @index, 1)
		IF (CHARINDEX(@currentLetter, @setOfLetters, 1) > 0)
			SET @index += 1
		ELSE
			RETURN 0
	END
	RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob')
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')
GO

-- TASK 9

USE [Bank]
GO

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT
	CONCAT([FirstName], ' ', [LastName])
	AS [Full Name]
	FROM [AccountHolders]
END

EXEC usp_GetHoldersFullName
GO

-- TASK 10

CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan
@number MONEY
AS
BEGIN
	SELECT dt.[First Name], dt.[Last Name] FROM
		(SELECT ah.[FirstName] AS [First Name],
		ah.[LastName] AS [Last Name],
		SUM(a.[Balance]) AS [Total Balance]
		FROM [AccountHolders] AS ah
		INNER JOIN [Accounts] AS a ON ah.[Id] IN (a.[AccountHolderId])
		GROUP BY [FirstName], [LastName]) as [dt]
	WHERE [Total Balance] > @number
	ORDER BY [First Name] ASC, [Last Name] ASC
END

EXEC usp_GetHoldersWithBalanceHigherThan 40000
GO

-- TASK 11

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(20, 4), @interestRate FLOAT, @numberOfYears INT)
RETURNS DECIMAL (20, 4)
AS
BEGIN
	DECLARE @fv DECIMAL (20, 4)
	SET @fv = @sum * POWER((1 + @interestRate), @numberOfYears)
	RETURN @fv
END
GO

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

-- TASK 12

CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount
@accountId INT, @interestRate FLOAT
AS
BEGIN
	DECLARE @years INT = 5
	SELECT [ac].[Id] AS [Account Id],
	[ah].[FirstName] AS [First Name],
	[ah].[LastName] AS [Last Name],
	[ac].[Balance] AS [Current Balance],
	dbo.ufn_CalculateFutureValue([ac].[Balance], @interestRate, @years) 
	AS [Balance in 5 years]
	FROM [Accounts] AS ac
	INNER JOIN [AccountHolders] AS ah ON [ac].[AccountHolderId] = [ah].[Id]
	WHERE [ac].[Id] = @accountId
END
GO

EXEC usp_CalculateFutureValueForAccount 1, 0.1
GO

-- TASK 13

USE [Diablo]
GO

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@game NVARCHAR(50))
RETURNS TABLE
AS
RETURN
	SELECT SUM(dt.[Cash]) AS [SumCash]
	FROM
	(SELECT g.[Name], ug.[Cash] AS [Cash], ROW_NUMBER() OVER (PARTITION BY g.[Name] ORDER BY ug.[Cash] DESC) AS [RowNum]
	FROM dbo.[Games] AS g
	JOIN dbo.[UsersGames] AS ug ON g.[Id] = ug.[GameId]
	WHERE g.[Name] = @game) AS dt
	WHERE dt.[RowNum] % 2 = 1
GO

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist')
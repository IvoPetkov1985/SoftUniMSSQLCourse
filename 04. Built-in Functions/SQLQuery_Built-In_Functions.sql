USE SoftUni
GO

-- TASK 1

SELECT FirstName, LastName
FROM Employees
WHERE LEFT(FirstName, 2) = 'Sa';

SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'Sa%';

-- TASK 2

SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%ei%';

-- TASK 3

SELECT FirstName
FROM Employees
WHERE DepartmentID IN (3, 10)
	AND DATEPART(YEAR, HireDate) 
	BETWEEN 1995 AND 2005;

-- TASK 4

SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%';

-- TASK 5

SELECT [Name] 
FROM Towns
WHERE LEN([Name]) IN (5, 6)
ORDER BY [Name] ASC;

-- TASK 6

SELECT * FROM Towns
WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name] ASC;

SELECT TownID, [Name]
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name] ASC;

-- TASK 7

SELECT * FROM Towns
WHERE [Name] LIKE '[^RBD]%'
ORDER BY [Name] ASC;

SELECT TownID, [Name]
FROM Towns
WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name] ASC;
GO

-- TASK 8

CREATE VIEW v_EmployeesHiredAfter2000
AS
SELECT FirstName, LastName
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000;
GO

SELECT * FROM v_EmployeesHiredAfter2000

-- TASK 9

SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5;

-- TASK 10

SELECT EmployeeID, FirstName, LastName, Salary,
	DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC;

-- TASK 11

WITH CTE_RankedSalaries (EmployeeID, FirstName, LastName, Salary, [Rank])
AS
	(SELECT EmployeeID, FirstName, LastName, Salary,
		DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000)

SELECT * FROM CTE_RankedSalaries
WHERE [Rank] = 2
ORDER BY Salary DESC;

-- TASK 12

USE [Geography]
GO

SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode ASC;

-- TASK 13

SELECT PeakName, RiverName,
	LOWER(CONCAT(SUBSTRING(PeakName, 1, LEN(PeakName) - 1), RiverName)) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix;

-- TASK 14

USE Diablo
GO

SELECT TOP (50)
	[Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
ORDER BY [Start] ASC, [Name] ASC;

-- TASK 15

SELECT Username, 
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) AS 
	[Email Provider]
FROM Users
ORDER BY [Email Provider] ASC, Username ASC;

-- TASK 16

SELECT Username, IpAddress AS [IP Address]
FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username ASC;

-- TASK 17

SELECT [Name] AS Game,
	CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
	END AS
	[Part of the Day],
	CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS
	Duration
FROM Games
ORDER BY [Name] ASC, Duration ASC, [Part of the Day] ASC;

-- TASK 18

USE Orders
GO

SELECT ProductName, OrderDate,
	DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
FROM Orders;
USE [SoftUni]

SELECT * FROM [Departments]
SELECT [Name] FROM [Departments]

SELECT [FirstName], [LastName], [Salary] FROM [Employees]
SELECT [FirstName], [MiddleName], [LastName] FROM [Employees]

SELECT CONCAT([FirstName], '.', [LastName], '@softuni.bg') 
AS [Full Email Address] FROM [Employees]

SELECT [FirstName] + '.' + [LastName] + '@softuni.bg'
AS [Full Email Address]
FROM [Employees]

SELECT DISTINCT [Salary] FROM [Employees]

SELECT * FROM [Employees]
WHERE [JobTitle] = 'Sales Representative'

SELECT * FROM [Employees]
WHERE [JobTitle] IN('Sales Representative')

SELECT [FirstName], [LastName], [JobTitle] FROM [Employees]
WHERE [Salary] BETWEEN 20000 AND 30000

SELECT [FirstName], [LastName], [JobTitle] FROM [Employees]
WHERE [Salary] >= 20000 AND [Salary] <= 30000

SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName]) 
AS [Full Name] FROM [Employees]
WHERE [Salary] IN(25000, 14000, 12500, 23600)

SELECT CONCAT([FirstName], ' ', [MiddleName], ' ', [LastName])
AS [Full Name] FROM [Employees]
WHERE [Salary] IN(25000, 14000, 12500, 23600)

SELECT [FirstName], [LastName] FROM [Employees]
WHERE [ManagerID] IS NULL

SELECT [FirstName], [LastName], [Salary] FROM [Employees]
WHERE [Salary] > 50000
ORDER BY [Salary] DESC

SELECT TOP(5) [FirstName], [LastName]
FROM [Employees]
ORDER BY [Salary] DESC

SELECT [FirstName], [LastName] FROM [Employees]
WHERE NOT [DepartmentID] = 4

SELECT [FirstName], [LastName] FROM [Employees]
WHERE [DepartmentID] <> 4

SELECT * FROM [Employees]
ORDER BY [Salary] DESC, [FirstName] ASC, [LastName] DESC, [MiddleName] ASC

CREATE VIEW V_EmployeesSalaries
AS
SELECT [FirstName], [LastName], [Salary] FROM [Employees]
SELECT * FROM [V_EmployeesSalaries]

CREATE VIEW V_EmployeeNameJobTitle
AS
SELECT CONCAT([FirstName], ' ', ISNULL([MiddleName], ''), ' ', [LastName]) AS [Full Name], [JobTitle]
FROM [Employees]
SELECT * FROM V_EmployeeNameJobTitle

SELECT DISTINCT [JobTitle] FROM [Employees]

SELECT TOP(10) * FROM [Projects]
ORDER BY [StartDate] ASC, [Name] ASC

SELECT TOP(7)
[FirstName], [LastName], [HireDate]
FROM [Employees]
ORDER BY [HireDate] DESC

UPDATE [Employees]
SET [Salary] *= 1.12
WHERE [DepartmentID] IN(
	SELECT [DepartmentID] FROM [Departments]
	WHERE [Name] IN('Engineering', 'Tool Design', 'Marketing', 'Information Services'))
SELECT [Salary] FROM [Employees]

USE [Geography]

SELECT [PeakName] FROM [Peaks]
ORDER BY [PeakName] ASC

SELECT TOP(30) [CountryName], [Population]
FROM [Countries]
WHERE [ContinentCode] IN('EU')
ORDER BY [Population] DESC

SELECT [CountryName], [CountryCode], [Currency] = 
	CASE [CurrencyCode] WHEN 'EUR' THEN 'Euro' ELSE 'Not Euro' END
	FROM [Countries]
	ORDER BY [CountryName] ASC

USE [Diablo]

SELECT [Name] FROM [Characters]
ORDER BY [Name] ASC

USE [master]

USE [Geography]
SELECT 
[PeakName],
[Estimation] = CASE [Elevation] WHEN 8848 THEN 'High' ELSE 'Not High' END
FROM [Peaks]

USE [SoftUni]

SELECT [FirstName], [LastName], [DepartmentID] FROM [Employees]
	WHERE [DepartmentID] IN(
	SELECT [DepartmentID] FROM [Departments]
	WHERE [Name] IN('Engineering', 'Marketing'))

SELECT [FirstName], [MiddleName], [LastName], [Est] = 
	CASE [DepartmentID] WHEN 1 THEN 'yes' ELSE 'no' END
FROM [Employees]
ORDER BY [Est] DESC

-- TASK 2

USE [SoftUni]

SELECT * FROM [Departments]

-- TASK 3

SELECT [Name] 
FROM [Departments]

-- TASK 4

SELECT [FirstName], [LastName], [Salary] 
FROM [Employees]

-- TASK 5

SELECT [FirstName], [MiddleName], [LastName]
FROM [Employees]

-- TASK 6

SELECT CONCAT([FirstName], '.', [LastName], '@softuni.bg') 
AS [Full Email Address]
FROM [Employees]

-- TASK 7

SELECT [Salary] 
FROM [Employees]
GROUP BY [Salary]
ORDER BY [Salary] ASC

SELECT DISTINCT [Salary]
FROM [Employees]

-- TASK 8

SELECT * FROM [Employees]
WHERE [JobTitle] IN ('Sales Representative')

-- TASK 9

SELECT [FirstName], [LastName], [JobTitle]
FROM [Employees]
WHERE [Salary] BETWEEN 20000 AND 30000

-- TASK 10

SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName]) 
AS [Full Name]
FROM [Employees]
WHERE [Salary] IN (25000, 14000, 12500, 23600)

-- TASK 11

SELECT [FirstName], [LastName] 
FROM [Employees]
WHERE [ManagerID] IS NULL

SELECT e.[FirstName], e.[LastName] FROM [Employees] AS e
LEFT JOIN [Employees] AS m ON e.[ManagerID] IN (m.[EmployeeID])
WHERE m.[FirstName] IS NULL AND m.[LastName] IS NULL

-- TASK 12

SELECT [FirstName], [LastName], [Salary] 
FROM [Employees]
WHERE [Salary] > 50000
ORDER BY [Salary] DESC

-- TASK 13

SELECT TOP (5) 
[FirstName], [LastName] 
FROM [Employees]
ORDER BY [Salary] DESC

-- TASK 14

SELECT [FirstName], [LastName] 
FROM [Employees]
WHERE [DepartmentID] NOT IN (
	SELECT [DepartmentID] FROM [Departments]
	WHERE [Name] IN ('Marketing'))

SELECT [FirstName], [LastName] 
FROM [Employees]
WHERE [DepartmentID] <> 4

-- TASK 15

SELECT * FROM [Employees]
ORDER BY 
[Salary] DESC,
[FirstName] ASC,
[LastName] DESC,
[MiddleName] ASC

-- TASK 16

CREATE VIEW [V_EmployeesSalaries]
AS
SELECT [FirstName], [LastName], [Salary] 
FROM [Employees]

-- TASK 17

CREATE VIEW [V_EmployeeNameJobTitle]
AS
SELECT CONCAT([FirstName], ' ', ISNULL([MiddleName], ''), ' ', [LastName])
AS [Full Name],
[JobTitle]
FROM [Employees]

SELECT * FROM [V_EmployeeNameJobTitle]

-- TASK 18

SELECT [JobTitle] 
FROM [Employees]
GROUP BY [JobTitle]

SELECT DISTINCT [JobTitle]
FROM [Employees]

-- TASK 19

SELECT TOP (10) * 
FROM [Projects]
ORDER BY
[StartDate] ASC, 
[Name] ASC

-- TASK 20

SELECT TOP (7)
[FirstName], [LastName], [HireDate] 
FROM [Employees]
ORDER BY [HireDate] DESC

-- TASK 21

UPDATE [Employees]
SET [Salary] = [Salary] * 1.12
	WHERE [DepartmentID] IN (
	SELECT [DepartmentID] FROM [Departments]
	WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services'))

SELECT [Salary] FROM [Employees]

-- TASK 22

USE [Geography]

SELECT [PeakName] FROM [Peaks]
GROUP BY [PeakName]

-- TASK 23

SELECT TOP (30)
c.[CountryName], c.[Population] FROM [Countries] AS c
	INNER JOIN [Continents] AS co ON c.[ContinentCode] IN (co.[ContinentCode])
	AND co.[ContinentName] IN ('Europe')
ORDER BY c.[Population] DESC, c.[CountryName] ASC

-- TASK 24

SELECT [CountryName], [CountryCode],
	CASE
		WHEN [CurrencyCode] IN ('EUR')
		THEN 'Euro'
		WHEN [CurrencyCode] NOT IN ('EUR') OR [CurrencyCode] IS NULL
		THEN 'Not Euro'
	END AS [Currency]
FROM [Countries]
ORDER BY [CountryName] ASC

-- TASK 25

USE [Diablo]

SELECT DISTINCT [Name]
FROM [Characters]

SELECT [Name] 
FROM [Characters]
GROUP BY [Name]

-- ADDITIONAL

USE [Geography]

CREATE VIEW [v_HighestPeak]
AS
SELECT TOP (1) * FROM [Peaks]
ORDER BY [Elevation] DESC

SELECT * FROM [v_HighestPeak]
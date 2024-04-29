CREATE DATABASE [Database2023.09.25]

USE [Database2023.09.25]

CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[Birthdate] DATETIME2 NOT NULL)

INSERT INTO [People] ([Name], [Birthdate])
	VALUES
	('Victor', '2000-12-07'),
	('Steven', '1992-09-10'),
	('Stephen', '1910-09-19'),
	('John', '2010-01-06')

SELECT * FROM [People]

SELECT [Name],
	DATEDIFF(YEAR, [Birthdate], GETDATE()) AS [Age in Years],
	DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
FROM [People]

SELECT [Name],
	DATEDIFF(YEAR, [Birthdate], CURRENT_TIMESTAMP) AS [Age in Years],
	DATEDIFF(MONTH, [Birthdate], CURRENT_TIMESTAMP) AS [Age in Months],
	DATEDIFF(DAY, [Birthdate], CURRENT_TIMESTAMP) AS [Age in Days],
	DATEDIFF(MINUTE, [Birthdate], CURRENT_TIMESTAMP) AS [Age in Minutes]
FROM [People]

SELECT ISDATE(2011-01-05)

USE [Diablo]

SELECT TOP(50) [Name],
	FORMAT(CAST([Start] AS DATETIME2), 'yyyy-MM-dd') AS [Start]
FROM [Games]
	WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
	ORDER BY [Start] ASC, [Name] ASC

USE [Geography]

SELECT p.[PeakName], r.[RiverName],
	LOWER(CONCAT(LEFT([PeakName], LEN([PeakName]) - 1), [RiverName])) AS [Mix]
FROM[Peaks] AS p
JOIN [Rivers] AS r 
ON RIGHT([PeakName], 1) IN(LEFT([RiverName], 1))
ORDER BY [Mix] ASC

SELECT p.[PeakName], r.[RiverName],
	LOWER(CONCAT_WS('', LEFT(p.[PeakName], LEN(p.[PeakName]) - 1), r.[RiverName])) AS [Mix]
FROM [Peaks] AS p, [Rivers] AS r
	WHERE RIGHT(p.[PeakName], 1) = LEFT(r.[RiverName], 1)
	ORDER BY [Mix] ASC

USE [Diablo]

SELECT [Username], [IpAddress] AS [IP Address] 
FROM [Users]
WHERE [IpAddress] LIKE '___.1_%._%.___'
ORDER BY [Username] ASC

SELECT [Name] AS [Game],
	CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11
		THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17
		THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23
		THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN [Duration] BETWEEN 0 AND 3
		THEN 'Extra Short'
		WHEN [Duration] BETWEEN 4 AND 6
		THEN 'Short'
		WHEN [Duration] > 6
		THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
FROM [Games]
ORDER BY [Game] ASC, [Duration] ASC, [Part of the Day] ASC

USE [SoftUni]

SELECT * FROM (
	SELECT [EmployeeID], [FirstName], [LastName], [Salary],
	DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
	FROM [Employees]
	WHERE [Salary] BETWEEN 10000 AND 50000) 
	AS [SomeTable]
WHERE [Rank] IN(2)
ORDER BY [Salary] DESC

USE [Orders]

SELECT [ProductName], [OrderDate],
	DATEADD(HOUR, 7, [OrderDate]) AS [AddedHours],
	DATEADD(WEEK, 3, [OrderDate]) AS [AddedWeeks],
	DATEADD(YEAR, 4, [OrderDate]) AS [AddedYears],
	DATEDIFF(YEAR, [OrderDate], CURRENT_TIMESTAMP) AS [AgeInYears],
	DATEDIFF(MONTH, [OrderDate], CURRENT_TIMESTAMP) AS [AgeInMonths],
	DATEDIFF(MINUTE, [OrderDate], CURRENT_TIMESTAMP) AS [AgeInMinutes],
	DATEPART(QUARTER, [OrderDate]) AS [QuarterOfTheYear]
FROM [Orders]
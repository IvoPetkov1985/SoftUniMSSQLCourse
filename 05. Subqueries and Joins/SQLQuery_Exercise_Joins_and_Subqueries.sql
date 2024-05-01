USE [SoftUni]

-- TASK 1

SELECT TOP(5) e.[EmployeeID]
,e.[JobTitle]
,a.[AddressID]
,a.[AddressText]
FROM [Employees] AS e
JOIN [Addresses] AS a 
ON e.[AddressID] = a.[AddressID]
ORDER BY e.[AddressID] ASC

SELECT TOP(5) e.[EmployeeID], e.[JobTitle], a.[AddressID], a.[AddressText]
FROM [Employees] AS e
	INNER JOIN [Addresses] AS a 
ON e.[AddressID] IN(a.[AddressID])
ORDER BY a.AddressID ASC

-- TASK 2

SELECT TOP(50) e.[FirstName]
,e.[LastName]
,t.[Name]
,a.[AddressText]
FROM [Employees] AS e
JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
ORDER BY e.[FirstName] ASC, e.[LastName] ASC

SELECT TOP(50) e.[FirstName], e.[LastName], t.[Name] AS [Town], a.[AddressText] 
FROM [Employees] AS e
	INNER JOIN [Addresses] AS a ON e.[AddressID] IN(a.[AddressID])
	INNER JOIN [Towns] AS t ON a.[TownID] IN(t.[TownID])
ORDER BY e.[FirstName] ASC, e.[LastName] ASC

-- TASK 3

SELECT e.[EmployeeID]
,e.[FirstName]
,e.[LastName]
,d.[Name]
FROM [Employees] AS e
INNER JOIN [Departments] AS d 
ON e.[DepartmentID] = d.[DepartmentID] AND d.[Name] = 'Sales'
ORDER BY e.[EmployeeID] ASC

SELECT e.[EmployeeID], e.[FirstName], e.[LastName], d.[Name] AS [DepartmentName]
FROM [Employees] AS e
	INNER JOIN [Departments] AS d ON e.[DepartmentID] IN(d.[DepartmentID])
	AND d.[Name] IN('Sales')
ORDER BY e.[EmployeeID] ASC

-- TASK 4

SELECT TOP(5) e.[EmployeeID]
,e.[FirstName]
,e.[Salary]
,d.[Name]
FROM [Employees] AS e
INNER JOIN [Departments] AS d
ON e.[DepartmentID] = d.[DepartmentID]
WHERE e.[Salary] > 15000
ORDER BY d.[DepartmentID] ASC

SELECT TOP(5) 
e.[EmployeeID], e.[FirstName], e.[Salary], d.[Name]
FROM [Employees] AS e
INNER JOIN [Departments] AS d 
ON e.[DepartmentID] IN(d.[DepartmentID])
AND e.[Salary] > 15000
ORDER BY d.[DepartmentID] ASC

-- TASK 5

SELECT TOP (3) e.[EmployeeID]
,e.[FirstName]
FROM [Employees] as e
LEFT JOIN [EmployeesProjects] AS ep 
ON e.[EmployeeID] = ep.[EmployeeID]
WHERE ep.[ProjectID] IS NULL
ORDER BY e.[EmployeeID]

SELECT TOP (3) em.[EmployeeID], em.[FirstName]
FROM [EmployeesProjects] AS ep
RIGHT OUTER JOIN [Employees] AS em
ON em.[EmployeeID] = ep.[EmployeeID]
WHERE ep.[ProjectID] IS NULL
ORDER BY em.[EmployeeID]

SELECT TOP (3) e.[EmployeeID], e.[FirstName]
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep 
ON e.[EmployeeID] = ep.[EmployeeID]
WHERE ep.[ProjectID] IS NULL
ORDER BY e.[EmployeeID] ASC

-- TASK 6

SELECT e.[FirstName], e.[LastName], e.[HireDate], d.[Name] 
FROM [Employees] AS e
INNER JOIN [Departments] AS d ON e.[DepartmentID] IN(d.[DepartmentID])
WHERE d.[Name] IN('Sales', 'Finance') AND e.[HireDate] > '1999-01-01'
ORDER BY e.[HireDate] ASC

SELECT e.[FirstName], e.[LastName], e.[HireDate],
d.[Name] AS [DeptName]
FROM [Employees] AS e
INNER JOIN [Departments] AS d ON e.[DepartmentID] IN(d.[DepartmentID])
AND e.[HireDate] > '1/1/1999'
AND d.[Name] IN('Sales', 'Finance')
ORDER BY e.[HireDate] ASC

SELECT e.[FirstName], e.[LastName], e.[HireDate], d.[Name] FROM [Employees] AS e
INNER JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
WHERE e.[HireDate] > '1999-01-01'
AND d.[Name] IN ('Sales', 'Finance')
ORDER BY e.[HireDate] ASC

-- TASK 7

SELECT TOP(5) ep.[EmployeeID], e.[FirstName], p.[Name]
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE p.[EndDate] IS NULL AND p.[StartDate] > '2002-08-13'
ORDER BY ep.[EmployeeID] ASC

SELECT TOP(5) e.[EmployeeID], e.[FirstName], pr.[Name] AS [ProjectName]
FROM [Employees] AS e
INNER JOIN [EmployeesProjects] AS ep
ON e.[EmployeeID] IN(ep.[EmployeeID])
INNER JOIN [Projects] AS pr
ON ep.[ProjectID] IN(pr.[ProjectID]) 
AND pr.[StartDate] > '2002-08-13' 
AND pr.[EndDate] IS NULL
ORDER BY e.[EmployeeID] ASC

-- TASK 8

SELECT e.[EmployeeID], e.[FirstName],
	CASE
		WHEN DATEPART(YEAR, p.[StartDate]) >= 2005
		THEN NULL
		ELSE p.[Name]
	END AS [ProjectName]
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
LEFT JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE e.[EmployeeID] = 24

SELECT em.[EmployeeID], em.[FirstName], 
	CASE
		WHEN DATEPART(YEAR, pr.[StartDate]) >= 2005
		THEN NULL
		WHEN DATEPART(YEAR, pr.[StartDate]) < 2005
		THEN pr.[Name]
	END AS [ProjectName]
FROM [Employees] AS em
INNER JOIN [EmployeesProjects] AS ep ON em.[EmployeeID] IN(ep.[EmployeeID]) 
AND em.[EmployeeID] IN(24)
LEFT OUTER JOIN [Projects] AS pr ON ep.[ProjectID] IN(pr.[ProjectID])

SELECT e.[EmployeeID], e.[FirstName],
	CASE 
		WHEN YEAR(p.[StartDate]) >= 2005 THEN NULL
		ELSE p.[Name]
	END AS [ProjectName]
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS ep ON e.EmployeeID = ep.[EmployeeID]
LEFT JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
WHERE e.[EmployeeID] = 24

-- TASK 9

SELECT e.[EmployeeID], e.[FirstName], e.[ManagerID], m.[FirstName] AS [ManagerName]
FROM [Employees] AS e
INNER JOIN [Employees] AS m 
ON e.[ManagerID] = m.[EmployeeID] 
AND e.[ManagerID] IN(3, 7)
ORDER BY e.[EmployeeID] ASC

SELECT e.[EmployeeID], e.[FirstName], e.[ManagerID], 
m.[FirstName] AS [ManagerName]
FROM [Employees] AS e
INNER JOIN [Employees] AS m
ON e.[ManagerID] IN(m.[EmployeeID]) 
AND e.[ManagerID] IN(3, 7)
ORDER BY e.[EmployeeID] ASC

-- TASK 10

SELECT TOP(50) e.[EmployeeID],
	CONCAT(e.[FirstName], ' ', e.[LastName]) AS [EmployeeName],
	CONCAT (m.[FirstName], ' ', m.[LastName]) AS [ManagerName],
	d.[Name] AS [DepartmentName]
FROM [Employees] AS e
	INNER JOIN [Employees] AS m ON e.[ManagerID] = m.[EmployeeID]
	INNER JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
ORDER BY e.[EmployeeID]

SELECT TOP(50) e.[EmployeeID],
	CONCAT_WS(' ', e.[FirstName], e.[LastName]) AS [EmployeeName],
	CONCAT_WS(' ', m.[FirstName], m.[LastName]) AS [ManagerName],
	d.[Name] AS [DepartmentName]
FROM [Employees] AS e
	INNER JOIN [Employees] AS m ON e.[ManagerID] IN(m.[EmployeeID])
	INNER JOIN [Departments] AS d ON e.[DepartmentID] IN(d.[DepartmentID])
ORDER BY e.[EmployeeID] ASC

-- TASK 11

SELECT MIN([AverageSalary]) AS [MinAverageSalary] 
FROM
	(SELECT AVG(e.[Salary]) AS [AverageSalary] 
	FROM [Employees] AS e
	GROUP BY e.[DepartmentID]) 
AS [MyTable]

SELECT MIN([AverageSalary]) AS [MinAverageSalary]
FROM
	(SELECT AVG([Salary]) AS [AverageSalary]
	FROM [Employees]
	GROUP BY [DepartmentID]) AS [dt]

-- TASK 12

USE [Geography]

SELECT c.[CountryCode], m.[MountainRange], p.[PeakName], p.[Elevation]
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc ON mc.[CountryCode] IN(c.[CountryCode])
	JOIN [Mountains] AS m ON mc.[MountainId] IN(m.[Id])
	LEFT JOIN [Peaks] AS p ON m.[Id] IN(p.[MountainId])
WHERE c.[CountryCode] = 'BG' AND p.[Elevation] > 2835
ORDER BY p.[Elevation] DESC

SELECT c.[CountryCode], m.[MountainRange], p.[PeakName], p.[Elevation]
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] as mc ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	LEFT JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
WHERE c.[CountryName] IN ('Bulgaria') AND p.[Elevation] > 2835
ORDER BY p.[Elevation] DESC

-- TASK 13

SELECT c.[CountryCode], COUNT(mc.[MountainId]) AS [MountainRanges] 
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc 
	ON c.[CountryCode] = mc.[CountryCode]
WHERE c.[CountryCode] IN ('RU', 'BG', 'US')
GROUP BY c.[CountryCode]

SELECT c.[CountryCode], COUNT(mc.[MountainId]) AS [MountainRanges]
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc 
	ON c.[CountryCode] = mc.[CountryCode]
GROUP BY c.[CountryCode]
HAVING c.[CountryCode] IN ('BG', 'RU', 'US')

-- TASK 14

SELECT TOP(5) c.[CountryName], r.[RiverName] 
FROM [Countries] AS c
	LEFT OUTER JOIN [CountriesRivers] AS cr ON c.CountryCode = cr.[CountryCode]
	LEFT OUTER JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
WHERE c.[ContinentCode] = 'AF'
ORDER BY c.[CountryName] ASC

SELECT TOP (5) c.[CountryName], r.[RiverName]
FROM [Countries] AS c
LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
RIGHT JOIN [Continents] AS co ON c.[ContinentCode] = co.[ContinentCode]
WHERE co.[ContinentName] = 'Africa'
ORDER BY c.[CountryName] ASC

-- TASK 15*

SELECT [ContinentCode], [CurrencyCode], [CurrencyUsage]
	FROM
	(SELECT *, DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC) AS [CurrencyRank]
		FROM
		(SELECT [ContinentCode], [CurrencyCode], COUNT(CurrencyCode) AS [CurrencyUsage] 
		FROM [Countries]
		GROUP BY [ContinentCode], [CurrencyCode]) AS [CoreQuery]
	WHERE [CurrencyUsage] > 1) AS [SecondaryQuery]
WHERE [CurrencyRank] = 1
ORDER BY [ContinentCode]

SELECT [ContinentCode], [CurrencyCode], [CurrencyUsage]
FROM
	(SELECT *, DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC) AS [Rank]
	FROM
		(SELECT [ContinentCode], [CurrencyCode], COUNT([CurrencyCode]) AS [CurrencyUsage]
		FROM [Countries]
		GROUP BY [ContinentCode], [CurrencyCode]) AS [InnerQuery]
		WHERE [CurrencyUsage] > 1) AS [OuterQuery]
	WHERE [Rank] = 1
ORDER BY [ContinentCode]

-- TASK 16

SELECT COUNT(c.[CountryName]) AS [Count] FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc
	ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Mountains] AS m
	ON mc.[MountainId] = m.[Id]
WHERE m.[MountainRange] IS NULL

-- TASK 17

SELECT TOP (5) c.[CountryName], 
	MAX(p.[Elevation]) AS [HighestPeakElevation], 
	MAX(r.[Length]) AS [LongestRiverLength]
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	LEFT JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
	LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
	LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
GROUP BY c.[CountryName]
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.[CountryName] ASC

SELECT TOP (5) dt.[CountryName], 
dt.[Elevation] AS [HighestPeakElevation],
dt.[Length] AS [LongestRiverLength]
FROM
(SELECT c.[CountryName], p.[Elevation], r.[Length],
	DENSE_RANK() OVER (PARTITION BY c.[CountryName] ORDER BY p.[Elevation] DESC) AS [PeakRank],
	DENSE_RANK() OVER (PARTITION BY c.[CountryName] ORDER BY r.[Length] DESC) AS [RiverRank]
FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	LEFT JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
	LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
	LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
	) AS [dt]
WHERE dt.[PeakRank] = 1 AND dt.[RiverRank] = 1
ORDER BY dt.[Elevation] DESC, dt.[Length] DESC, dt.[CountryName] ASC

-- TASK 18

SELECT TOP (5) dt.[CountryName] AS [Country],
	CASE
		WHEN dt.[PeakName] IS NULL
		THEN '(no highest peak)'
		ELSE dt.[PeakName]
	END AS [Highest Peak Name],
	CASE
		WHEN dt.[Elevation] IS NULL
		THEN 0
		ELSE dt.[Elevation]
	END AS [Highest Peak Elevation],
	CASE
		WHEN dt.[MountainRange] IS NULL
		THEN '(no mountain)'
		ELSE dt.[MountainRange]
	END AS [Mountain]
FROM
	(SELECT c.[CountryName],
	DENSE_RANK() OVER (PARTITION BY [CountryName] ORDER BY p.[Elevation] DESC) AS [PeakRank],
	p.[PeakName],
	p.[Elevation],
	m.[MountainRange]
	FROM [Countries] AS c
	LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	LEFT JOIN [Peaks] AS p ON p.[MountainId] = m.[Id]
	) AS [dt]
WHERE dt.[PeakRank] = 1
ORDER BY [Country] ASC, [Highest Peak Name] ASC


SELECT TOP (5) dt.[CountryName] AS [Country],
	ISNULL(dt.[PeakName], '(no highest peak)') AS [Highest Peak Name],
	ISNULL(dt.[Elevation], 0) AS [Highest Peak Elevation],
	ISNULL(dt.[MountainRange], '(no mountain)') AS [Mountain]
FROM
	(SELECT c.[CountryName],
	p.[PeakName],
	p.[Elevation],
	m.[MountainRange],
	DENSE_RANK() OVER (PARTITION BY c.[CountryName] ORDER BY p.[Elevation] DESC) AS [PeakRank]
	FROM [Countries] AS c
		LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] IN(mc.[CountryCode])
		LEFT JOIN [Mountains] AS m ON mc.[MountainId] IN(m.[Id])
		LEFT JOIN [Peaks] AS p ON m.[Id] IN(p.[MountainId])
		) AS [dt]
WHERE dt.[PeakRank] IN (1)
ORDER BY [Country] ASC, [PeakName] ASC

-- OTHER START

USE [SoftUni]
SELECT e.[FirstName], e.[LastName], e.[DepartmentID]
FROM [Employees] AS e
	WHERE e.[DepartmentID] IN
	(SELECT d.[DepartmentID] 
	FROM [Departments] AS d
	WHERE d.[Name] = 'Sales')

SELECT TOP (1) AVG(e.[Salary]) AS [AverageSalary], t.[Name]
FROM [Employees] AS e
	JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
GROUP BY t.[Name]
ORDER BY [AverageSalary] DESC

USE [Geography]

SELECT c.[CountryName], 
ISNULL(m.[MountainRange], 'no mountains'),
ISNULL(p.[PeakName], 'no peaks'),
ISNULL(p.[Elevation], -1)
FROM 
	[Countries] AS c
	FULL JOIN [MountainsCountries] AS mc ON c.[CountryCode] IN(mc.[CountryCode])
	FULL JOIN [Mountains] AS m ON mc.[MountainId] IN(m.[Id])
	FULL JOIN [Peaks] AS p ON p.[MountainId] IN(m.[Id])

SELECT dt.[MountainRange], dt.[PeakName], dt.[Elevation]
FROM
	(SELECT m.[Id], m.[MountainRange], p.[PeakName], p.[Elevation],
	DENSE_RANK() OVER (PARTITION BY m.[MountainRange] ORDER BY p.[Elevation] DESC) AS [PeakRank]
	FROM [Mountains] AS m
	FULL JOIN [Peaks] AS p ON m.[Id] IN(p.[MountainId])
	) AS [dt]
WHERE dt.[PeakRank] = 1
ORDER BY dt.[MountainRange] ASC

-- OTHER END
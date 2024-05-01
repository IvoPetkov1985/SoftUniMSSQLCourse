USE [Gringotts]

-- TASK 1

SELECT COUNT(*) AS [Count]
FROM [WizzardDeposits]

-- TASK 2

SELECT MAX([MagicWandSize]) 
AS [LongestMagicWand]
FROM [WizzardDeposits]

-- TASK 3

SELECT [DepositGroup], MAX([MagicWandSize]) 
AS [LongestMagicWand]
FROM [WizzardDeposits]
GROUP BY [DepositGroup]

SELECT DISTINCT [DepositGroup] 
FROM [WizzardDeposits]

-- TASK 4

SELECT ft.[DepositGroup] FROM
	(SELECT dt.[DepositGroup], DENSE_RANK() OVER (ORDER BY dt.[Average]) AS [GroupRank]
	FROM
		(SELECT [DepositGroup], AVG([MagicWandSize]) AS [Average]
		FROM [WizzardDeposits]
		GROUP BY [DepositGroup]) AS [dt]) AS [ft]
WHERE [GroupRank] = 1

-- TASK 5

SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
GROUP BY [DepositGroup]

-- TASK 6

SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]

-- TASK 7

SELECT [DepositGroup], SUM([DepositAmount]) AS [TotalSum] 
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family' 
GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
ORDER BY SUM([DepositAmount]) DESC

-- TASK 8

SELECT [DepositGroup], [MagicWandCreator],
MIN([DepositCharge]) AS [MinDepositCharge]
FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator] ASC, [DepositGroup] ASC

SELECT [DepositGroup], [MagicWandCreator], MIN([DepositCharge])
FROM [WizzardDeposits]
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator] ASC, [DepositGroup] ASC

-- TASK 9

SELECT dt.[AgeGroup], COUNT(*) AS [WizardCount] 
FROM
	(SELECT
		CASE
			WHEN [Age] BETWEEN 0 AND 10
			THEN '[0-10]'
			WHEN [Age] BETWEEN 11 AND 20
			THEN '[11-20]'
			WHEN [Age] BETWEEN 21 AND 30
			THEN '[21-30]'
			WHEN [Age] BETWEEN 31 AND 40
			THEN '[31-40]'
			WHEN [Age] BETWEEN 41 AND 50
			THEN '[41-50]'
			WHEN [Age] BETWEEN 51 AND 60
			THEN '[51-60]'
			ELSE '[61+]'
		END AS [AgeGroup]
	FROM [WizzardDeposits]) AS [dt]
GROUP BY dt.[AgeGroup]
ORDER BY dt.[AgeGroup] ASC

-- TASK 10

SELECT 
LEFT([FirstName], 1) AS [FirstLetter]
FROM [WizzardDeposits]
WHERE [DepositGroup] = 'Troll Chest'
GROUP BY LEFT([FirstName], 1)
ORDER BY [FirstLetter] ASC

SELECT
DISTINCT SUBSTRING([FirstName], 1, 1) AS [FirstLetter]
FROM [WizzardDeposits]
WHERE [DepositGroup] IN ('Troll Chest')
ORDER BY [FirstLetter] ASC

-- TASK 11

SELECT [DepositGroup], [IsDepositExpired], 
AVG([DepositInterest]) AS [AverageInterest]
FROM [WizzardDeposits]
WHERE [DepositStartDate] > '1985-01-01'
GROUP BY [DepositGroup], [IsDepositExpired]
ORDER BY [DepositGroup] DESC, [IsDepositExpired] ASC

-- TASK 12

SELECT SUM([Difference]) AS [SumDifference]
FROM
	(SELECT [FirstName] AS [Host Wizard],
	[DepositAmount] AS [Host Wizard Deposit],
	LEAD([FirstName]) OVER (ORDER BY [Id]) AS [Guest Wizard],
	LEAD([DepositAmount]) OVER (ORDER BY [Id]) AS [Guest Wizard Deposit],
	[DepositAmount] - LEAD([DepositAmount]) OVER (ORDER BY [Id]) AS [Difference]
	FROM [WizzardDeposits]
	) AS [dt]

SELECT SUM(dt.[Difference]) AS [SumDifference]
FROM
	(SELECT w1.[FirstName] AS [Host Wizard],
	w1.[DepositAmount] AS [Host Wizard Deposit],
	w2.[FirstName] AS [Guest Wizard],
	w2.[DepositAmount] AS [Guest Wizard Deposit],
	w1.[DepositAmount] - w2.[DepositAmount] AS [Difference]
	FROM [WizzardDeposits] AS w1
	INNER JOIN [WizzardDeposits] AS w2 ON w1.[Id] + 1 = w2.[Id]
	) AS [dt]

-- TASK 13

USE [SoftUni]

SELECT [DepartmentID], SUM([Salary]) AS [TotalSalary]
FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID] ASC

-- TASK 14

SELECT [DepartmentID], MIN([Salary]) AS [MinimumSalary]
FROM [Employees]
WHERE [DepartmentID] IN (2, 5, 7) AND [HireDate] > '2000-01-01'
GROUP BY [DepartmentID]

-- TASK 15

SELECT * INTO [NewEmployeeTable] FROM [Employees]
WHERE [Salary] > 30000

DELETE FROM [NewEmployeeTable]
WHERE [ManagerID] IN (42)

UPDATE [NewEmployeeTable]
SET [Salary] = [Salary] + 5000
WHERE [DepartmentID] IN (1)

SELECT [DepartmentID], AVG([Salary])
FROM [NewEmployeeTable]
GROUP BY [DepartmentID]

-- TASK 16

SELECT [MyTable].[DepartmentID], [MyTable].[MaxSalary]
FROM
	(SELECT [DepartmentID], MAX([Salary]) AS [MaxSalary]
	FROM [Employees]
	GROUP BY [DepartmentID]) AS [MyTable]
WHERE [MaxSalary] NOT BETWEEN 30000 AND 70000

-- TASK 17

SELECT COUNT([Salary]) AS [Count]
FROM [Employees]
WHERE [ManagerID] IS NULL

-- TASK 18

SELECT DISTINCT dt.[DepartmentID], dt.[Salary] AS [ThirdHighestSalary]
FROM
	(SELECT [DepartmentID], [Salary], 
	DENSE_RANK() OVER (PARTITION BY [DepartmentID] ORDER BY [Salary] DESC) AS [SalaryRank]
	FROM [Employees]) AS [dt]
WHERE [SalaryRank] IN (3)

-- TASK 19

SELECT TOP (10) e.[FirstName], e.[LastName], e.[DepartmentID]
FROM [Employees] AS e
	WHERE e.[Salary] > (
	SELECT AVG(em.[Salary]) 
	FROM [Employees] AS em
	WHERE e.[DepartmentID] = em.[DepartmentID])
ORDER BY e.[DepartmentID]

-- ADDITIONAL EXERCISE

USE [SoftUni]

SELECT [DepartmentID], [FirstName], [LastName], [Salary] FROM [Employees]

SELECT AVG(MyQuery.[AverageSalary]) AS [TotalAvarage]
FROM
(SELECT [DepartmentID], AVG([Salary]) AS [AverageSalary]
FROM [Employees]
GROUP BY [DepartmentID]) AS [MyQuery]

SELECT 
STRING_AGG(CONCAT([FirstName], ' ', [Salary]), ', ')
FROM [Employees]
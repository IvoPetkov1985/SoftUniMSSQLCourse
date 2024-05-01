USE Gringotts
GO

-- TASK 1

SELECT COUNT(Id) AS [Count]
FROM WizzardDeposits;

-- TASK 2

SELECT 
MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits;

-- TASK 3

SELECT 
	DepositGroup,
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup;

-- TASK 4

WITH CTE_Deposits_Averages (DepositGroup, AverageWand) AS
	(SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup)

SELECT TOP(2) 
	DepositGroup
FROM CTE_Deposits_Averages
ORDER BY AverageWand;

---------

SELECT dt.DepositGroup FROM
	(SELECT DepositGroup, AVG(MagicWandSize) AS AverageWS,
	DENSE_RANK() OVER (ORDER BY AVG(MagicWandSize)) AS WandRank
	FROM WizzardDeposits
	GROUP BY DepositGroup) AS dt
WHERE dt.WandRank = 1;

-- TASK 5

SELECT DepositGroup, 
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup;

-- TASK 6

SELECT DepositGroup, 
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup;

-- TASK 7

SELECT DepositGroup, 
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC;

-- TASK 8

SELECT 
	DepositGroup,
	MagicWandCreator,
	MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator ASC, DepositGroup ASC;

-- TASK 9

SELECT dt.AgeGroup,
COUNT(*) AS WizardCount
FROM
(SELECT
	CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		ELSE '[61+]'
	END
AS AgeGroup
FROM WizzardDeposits) AS dt
GROUP BY dt.AgeGroup;

-- TASK 10

SELECT LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1);

-- TASK 11

SELECT DepositGroup, IsDepositExpired,
	AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC;

-- TASK 12

SELECT SUM(dt.[Difference]) AS SumDifference
FROM
(SELECT wd.FirstName AS [Host Wizard],
	wd.DepositAmount AS [Host Wizard Deposit],
	zd.FirstName AS [Guest Wizard],
	zd.DepositAmount AS [Guest Wizard Deposit],
	zd.DepositAmount - wd.DepositAmount AS [Difference]
FROM WizzardDeposits AS wd
	INNER JOIN WizzardDeposits AS zd ON wd.Id = zd.Id + 1) AS dt;

WITH CTE_Differences (HostWizz, HostWizzDep, GuestWizz, GuestWizzDep, Diff)
AS
	(SELECT FirstName AS [Host Wizard],
		DepositAmount AS [Host Wizard Deposit],
		LEAD(FirstName) OVER (ORDER BY Id) AS [Guest Wizard],
		LEAD(DepositAmount) OVER (ORDER BY Id) AS [Guest Wizard Deposit],
		DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id) AS [Difference]
	FROM WizzardDeposits)

SELECT SUM(Diff) AS SumDifference
FROM CTE_Differences;

-- TASK 13

USE SoftUni
GO

SELECT DepartmentID, 
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;

-- TASK 14

SELECT DepartmentID,
	MIN(Salary) AS MinimumSalary
FROM Employees
WHERE HireDate > '2000-01-01'
GROUP BY DepartmentID
HAVING DepartmentID IN (2, 5, 7);

-- TASK 15

SELECT * INTO NewEmployees 
FROM Employees
WHERE Salary > 30000;

DELETE FROM NewEmployees
WHERE ManagerID = 42;

UPDATE NewEmployees
SET Salary = Salary + 5000
WHERE DepartmentID = 1;

SELECT DepartmentID, 
	AVG(Salary) AS AverageSalary
FROM NewEmployees
GROUP BY DepartmentID;

-- TASK 16

SELECT DepartmentID,
	MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;

-- TASK 17

SELECT COUNT(Salary) AS [Count]
FROM Employees
WHERE ManagerID IS NULL;

-- TASK 18

WITH CTE_SalaryRanks (Dep, Salary, SRank)
AS
	(SELECT DepartmentID, 
		Salary, 
		DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS SalaryRank
	FROM Employees
	GROUP BY DepartmentID, Salary)

SELECT Dep AS DepartmentID,
	Salary AS ThirdHighestSalary
FROM CTE_SalaryRanks
WHERE SRank = 3;

-- TASK 19

SELECT TOP (10)
	e.FirstName, e.LastName, e.DepartmentID
FROM Employees AS e
WHERE e.Salary > (SELECT AVG(z.Salary) 
	FROM Employees AS z
	WHERE z.DepartmentID = e.DepartmentID
	GROUP BY z.DepartmentID);
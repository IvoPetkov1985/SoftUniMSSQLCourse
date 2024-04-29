USE [SoftUni]

SELECT a.AddressText, a.TownID FROM [Addresses] AS a 
JOIN [Employees] AS e 
ON e.AddressID = a.AddressID
WHERE a.TownID = 5

SELECT e.FirstName, e.LastName, e.Salary, a.AddressText, a.TownID 
FROM [Employees] AS e
JOIN [Addresses] AS a ON a.AddressID = e.AddressID
ORDER BY [FirstName], [LastName]

USE [Geography]

SELECT m.Id, m.MountainRange, p.PeakName , p.Elevation
FROM [Mountains] AS m
JOIN [Peaks] AS p ON p.MountainId = m.Id
ORDER BY [MountainId] DESC, [Elevation] ASC

SELECT c.CountryName AS [Държава], cont.ContinentName AS [Континент], c.Capital AS [Столица]
FROM [Continents] AS cont
JOIN [Countries] AS c ON c.ContinentCode = cont.ContinentCode
WHERE [ContinentName] IN('Europe', 'North America')
ORDER BY [CountryName] ASC

SELECT CONCAT(c.CountryName, ' ', '[', c.Capital, ']') AS [Държава + Столица], curr.CurrencyCode, curr.[Description], c.ContinentCode
FROM [Countries] AS c
JOIN [Currencies] AS curr ON c.CurrencyCode = curr.CurrencyCode
WHERE [ContinentCode] IN('EU') OR [ContinentCode] IN('NA')
ORDER BY [CountryName] ASC

USE [Database2023.09.17]

CREATE TABLE [Mountains] (
	[MountainId] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[RangeHeight] SMALLINT NOT NULL,
	[DistanceFromSofia] SMALLINT NOT NULL)

CREATE TABLE [Peaks] (
	[PeakId] INT PRIMARY KEY IDENTITY,
	[PeakName] VARCHAR(50) NOT NULL,
	[Height] SMALLINT NOT NULL,
	[MountainID] INT FOREIGN KEY REFERENCES [Mountains] ([MountainID]))

ALTER TABLE [Peaks]
	ALTER COLUMN [MountainID] INT NOT NULL

INSERT INTO [Mountains] ([Name], [RangeHeight], [DistanceFromSofia])
	VALUES
	('Vitosha', 1800, 5),
	('Rila', 2500, 60),
	('Stara planina', 1700, 30),
	('Lyulin', 1150, 15)

INSERT INTO [Peaks] ([PeakName], [Height], [MountainID])
	VALUES
	('Cherni vrah', 2290, 1),
	('Golyam rezen', 2277, 1),
	('Malak rezen', 2190, 1),
	('Kamen del', 1862, 1),
	('Ushite', 1910, 1),
	('Mussala', 2925, 2),
	('Malyovica', 2790, 2),
	('Malka mussala', 2910, 2),
	('Bezbog', 2650, 2),
	('Botev', 2376, 3),
	('Kom', 2050, 3),
	('Petrohan', 1650, 3),
	('Mourgash', 1680, 3),
	('Shipka', 1360, 3)

SELECT m.[MountainId], m.[Name], p.[PeakName], p.[Height]
	FROM [Mountains] AS m
	JOIN [Peaks] AS p ON p.MountainID = m.MountainId
	WHERE [Height] > 1500
	ORDER BY [MountainId] ASC, [Height] DESC

SELECT * FROM [Peaks]
ORDER BY [Height] DESC

INSERT INTO [Peaks] ([PeakName], [Height], [MountainID])
	VALUES
	('Dupevica', 1240, 4),
	('Etropolska baba', 1900, 3)

SELECT CONCAT(m.[Name], ' ', '[', m.[RangeHeight], ']') AS [Mountain Info],
m.[DistanceFromSofia], p.PeakName, p.Height, p.MountainID
FROM [Mountains] AS m
JOIN [Peaks] AS p ON p.MountainID = m.MountainId
ORDER BY [Mountain Info] ASC

SELECT 313 * 4.15
SELECT 'hello world!'

CREATE VIEW [V_PeaksInfo]
AS
SELECT [PeakName], [Height] 
FROM [Peaks]

SELECT * FROM [V_PeaksInfo]
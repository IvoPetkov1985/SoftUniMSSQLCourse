CREATE DATABASE [Database2023.09.17]

USE [Database2023.09.17]

CREATE TABLE [TownsInfo] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(20) NOT NULL,
	[Population] INT NOT NULL,
	[DistanceFromSofia] INT,
	[Notes] VARCHAR(150))

INSERT INTO [TownsInfo] ([Name], [Population], [DistanceFromSofia])
	VALUES
	('Sofia City', 1350000, 5),
	('Plovdiv', 400000, 130),
	('Pazardzhik', 110000, 95),
	('Stara Zagora', 220000, 210),
	('Burgas', 350000, 360),
	('Varna', 390000, 450)

INSERT INTO [TownsInfo] ([Name], [Population], [DistanceFromSofia], [Notes])
	VALUES
	('Radnevo', 18000, 235, 'The miners town')

SELECT * FROM [TownsInfo]
SELECT [Population] FROM [TownsInfo] ORDER BY [Id], [Name] ASC

UPDATE [TownsInfo] SET [Population] = 20000 WHERE [Name] = 'Radnevo'
UPDATE [TownsInfo] SET [Notes] = 'OLD RADNEVO' WHERE [Name] = 'Radnevo' AND [Population] = 18000
UPDATE [TownsInfo] SET [Notes] = 'NEW RADNEVO' WHERE [Name] = 'Radnevo' AND [Population] = 20000

UPDATE [TownsInfo] SET [Population] = 1250000 WHERE [Id] = 1

ALTER TABLE [TownsInfo]
ADD [AirQuality] BIT

UPDATE [TownsInfo] SET [AirQuality] = 1 WHERE [Id] = 2
UPDATE [TownsInfo] SET [AirQuality] = 0 WHERE [Id] = 7
UPDATE [TownsInfo] SET [AirQuality] = 1 WHERE [Id] = 8
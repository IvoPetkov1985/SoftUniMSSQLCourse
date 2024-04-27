CREATE DATABASE [Minions]

USE Minions

CREATE TABLE [Minions] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] INT)

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR(70) NOT NULL)

ALTER TABLE [Minions]
	ADD [TownId] INT FOREIGN KEY REFERENCES [Towns]([Id]) NOT NULL

INSERT INTO [Towns]([Id], [Name])
	VALUES
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')

INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
	VALUES
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)

TRUNCATE TABLE [Minions]
DROP TABLE [Minions]
DROP TABLE [Towns]

CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY,
	CHECK (DATALENGTH ([Picture]) <= 2048000),
	[Height] DECIMAL (3, 2),
	[Weight] DECIMAL (5, 2),
	[Gender] CHAR(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX))

INSERT INTO [People] ([Name], [Height], [Weight], [Gender], [Birthdate])
	VALUES
	('Peter', 1.88, 90.10, 'm', '1988-03-08'),
	('Gosho', 1.78, 81.15, 'm', '1998-11-10'),
	('Albena', 1.74, 60.55, 'f', '1978-09-16'),
	('Maria', 1.69, 55.14, 'f', '1999-04-14'),
	('Petranka', 1.70, 59.14, 'f', '2004-07-07')

CREATE TABLE [Users] (
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY,
	CHECK (DATALENGTH ([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL)

INSERT INTO [Users] ([Username], [Password], [LastLoginTime], [IsDeleted])
	VALUES
	('goshko', 'georgi14', '2020-04-04 09:14:17', 0),
	('niki', 'nikolai810', '2020-04-05 17:17:58', 0),
	('kiko', 'kiril168', '2020-04-03 20:15:51', 1),
	('milena', 'milencheto111', '2020-04-04 15:33:30', 0),
	('atanaska', 'nasito', '2020-03-31 16:31:44', 1)

CREATE DATABASE [Movies]

USE Movies

CREATE TABLE [Directors] (
	[Id] INT PRIMARY KEY IDENTITY,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR (MAX))

CREATE TABLE [Genres] (
	[Id] INT PRIMARY KEY IDENTITY,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR (MAX))

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(50))

CREATE TABLE [Movies] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Title] NVARCHAR(70) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors] ([Id]) NOT NULL,
	[CopyWrightYear] DATE,
	[Length] TIME NOT NULL,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres] ([Id]) NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[Rating] DECIMAL (2, 1),
	[Notes] NVARCHAR (MAX))

INSERT INTO [Directors] ([DirectorName])
	VALUES
	('Pesho'),
	('Gosho'),
	('Stamat'),
	('Mariyka'),
	('Albena')

INSERT INTO [Genres] ([GenreName])
	VALUES
	('Comedy'),
	('Drama'),
	('Action'),
	('Thriller'),
	('Horror')

INSERT INTO [Categories] ([CategoryName])
	VALUES
	('Kids'),
	('Adults'),
	('Misc'),
	('Animation'),
	('Parody')

INSERT INTO [Movies] ([Title], [DirectorId], [CopyWrightYear], [Length], [GenreId], [CategoryId], [Rating])
	VALUES
	('Movie1', 3, '2002-10-10', '01:37:40', 1, 1, 5.5),
	('Movie2', 1, '2004-10-31', '02:01:56', 2, 2, 5.9),
	('Movie3', 2, '2010-06-07', '01:55:10', 2, 4, 6.0),
	('Movie4', 4, '1999-05-05', '00:55:00', 5, 5, 5.0),
	('Movie5', 5, '2001-11-26', '03:00:30', 5, 1, 3.8)
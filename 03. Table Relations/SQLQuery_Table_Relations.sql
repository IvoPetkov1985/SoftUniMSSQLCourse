CREATE DATABASE [TableRelations]

USE [TableRelations]

CREATE TABLE [Passports] (
	[PassportID] INT PRIMARY KEY IDENTITY (101, 1),
	[PassportNumber] VARCHAR(10) NOT NULL)

CREATE TABLE [Persons] (
	[PersonID] INT PRIMARY KEY IDENTITY (1, 1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[Salary] DECIMAL (8, 2) NOT NULL,
	[PassportID] INT UNIQUE FOREIGN KEY REFERENCES [Passports] ([PassportID]))

INSERT INTO [Passports] ([PassportNumber])
	VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2')

INSERT INTO [Persons] ([FirstName], [Salary], [PassportID])
	VALUES
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

SELECT * FROM [Persons]
SELECT * FROM [Passports]

CREATE TABLE [Manufacturers] (
	[ManufacturerID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	[EstablishedOn] DATE NOT NULL)

CREATE TABLE [Models] (
	[ModelID] INT PRIMARY KEY IDENTITY (101, 1),
	[Name] NVARCHAR(30) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers] ([ManufacturerID]) NOT NULL)

INSERT INTO [Manufacturers] ([Name], [EstablishedOn])
	VALUES
	('BMW', '07/03/1916'),
	('Tesla', '01/01/2003'),
	('Lada', '01/05/1966')

INSERT INTO [Models] ([Name], [ManufacturerID])
	VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

SELECT * FROM [Manufacturers]
SELECT * FROM [Models]

CREATE TABLE [Students] (
	[StudentID] INT PRIMARY KEY IDENTITY (1, 1),
	[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE [Exams] (
	[ExamID] INT PRIMARY KEY IDENTITY (101, 1),
	[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE [StudentsExams] (
	[StudentID] INT FOREIGN KEY REFERENCES [Students] ([StudentID]) NOT NULL,
	[ExamID] INT FOREIGN KEY REFERENCES [Exams] ([ExamID]) NOT NULL,
	PRIMARY KEY (StudentID, ExamID))

INSERT INTO [Students] ([Name])
	VALUES
	('Mila'),
	('Toni'),
	('Ron')

INSERT INTO [Exams] ([Name])
	VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

INSERT INTO [StudentsExams] ([StudentID], [ExamID])
	VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

SELECT * FROM [Students]
SELECT * FROM [Exams]
SELECT * FROM [StudentsExams]

CREATE TABLE [Teachers] (
	[TeacherID] INT PRIMARY KEY IDENTITY (101, 1),
	[Name] NVARCHAR(50) NOT NULL,
	[ManagerID] INT REFERENCES [Teachers] ([TeacherID]))

INSERT INTO [Teachers] ([Name], [ManagerID])
	VALUES
	('John', NULL),
	('Maya', 106),
	('Silvia', 106),
	('Ted', 105),
	('Mark', 101),
	('Greta', 101)

SELECT * FROM [Teachers]

USE [TableRelations]

CREATE TABLE [Cities] (
	[CityID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL)

CREATE TABLE [Customers] (
	[CustomerID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Birthday] DATE NOT NULL,
	[CityID] INT FOREIGN KEY REFERENCES [Cities] ([CityID]) NOT NULL)

CREATE TABLE [Orders] (
	[OrderID] INT PRIMARY KEY IDENTITY,
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers] ([CustomerID]) NOT NULL)

CREATE TABLE [ItemTypes] (
	[ItemTypeID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE [Items] (
	[ItemID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes] ([ItemTypeID]) NOT NULL)

CREATE TABLE [OrderItems] (
	[OrderID] INT FOREIGN KEY REFERENCES [Orders] ([OrderID]) NOT NULL,
	[ItemID] INT FOREIGN KEY REFERENCES [Items] ([ItemID]) NOT NULL,
	PRIMARY KEY ([OrderID], [ItemID]))

CREATE TABLE [Majors] (
	[MajorID] INT PRIMARY KEY IDENTITY (1, 1),
	[Name] NVARCHAR(70) NOT NULL)

CREATE TABLE [StudentsS] (
	[StudentID] INT PRIMARY KEY IDENTITY (1, 1),
	[StudentNumber] INT UNIQUE NOT NULL,
	[StudentName] NVARCHAR(70) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES [Majors] ([MajorID]) NOT NULL)

CREATE TABLE [Payments] (
	[PaymentID] INT PRIMARY KEY IDENTITY (1001, 1),
	[PaymentDate] DATETIME2 NOT NULL,
	[PaymentAmount] DECIMAL (6, 2) NOT NULL,
	[StudentID] INT FOREIGN KEY REFERENCES [StudentsS] ([StudentID]) NOT NULL)

CREATE TABLE [Subjects] (
	[SubjectID] INT PRIMARY KEY IDENTITY (101, 1),
	[SubjectName] NVARCHAR(35) NOT NULL)

CREATE TABLE [Agenda] (
	[StudentID] INT FOREIGN KEY REFERENCES [StudentsS] ([StudentID]) NOT NULL,
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects] ([SubjectID]) NOT NULL,
	PRIMARY KEY ([StudentID], [SubjectID]))

USE [Geography]

SELECT m.[MountainRange], p.[PeakName] , p.[Elevation] 
	FROM [Peaks] AS p
JOIN [Mountains] AS m ON p.MountainId = m.Id
	WHERE [MountainId] = (
	SELECT [Id] FROM [Mountains]
	WHERE [MountainRange] IN('Rila'))
	ORDER BY [Elevation] DESC
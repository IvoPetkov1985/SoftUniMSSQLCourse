CREATE DATABASE [Database2023.09.20]

USE [Database2023.09.20]

CREATE TABLE [Minions] (
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] SMALLINT)

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL)

ALTER TABLE [Minions]
	ADD [TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]) NOT NULL

INSERT INTO [Towns] ([Id], [Name])
	VALUES
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')

INSERT INTO [Minions] ([Id], [Name], [Age], [TownId])
	VALUES
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)

CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY(1, 1),
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY,
	CHECK([Picture] <= 2048000),
	[Height] DECIMAL (3, 2),
	[Weight] DECIMAL (5, 2),
	[Gender] CHAR(1) NOT NULL,
	CHECK([Gender] IN('m', 'f')),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(400))

INSERT INTO [People] ([Name], [Height], [Weight], [Gender], [Birthdate])
	VALUES
	('John Doe', 1.77, 66.33, 'm', '1978-03-07'),
	('Elena Kemmer', 1.69, 59.70, 'f', '1977-10-25'),
	('Kevin Summer', 1.88, 91.10, 'm', '1980-12-12'),
	('Steward New', 1.79, 69.30, 'm', '1992-07-31'),
	('Maria Herbst', 1.70, 70.10, 'f', '1991-01-30')

SELECT * FROM [People]

CREATE TABLE [Users] (
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY,
	CHECK ([ProfilePicture] <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL)

INSERT INTO [Users] ([Username], [Password], [LastLoginTime], [IsDeleted])
	VALUES
	('Maria_Ivanova', 'mar4eto', '2022-10-22', 0),
	('Lyubo_G', 'hermes14', '2022-11-15', 0),
	('Nikoleta_zo', 'nikolecka', '2022-11-09', 0),
	('Dimitrichko', 'miteto1999', '2023-01-03', 0),
	('Albena-Yordanova', 'beni999', '2022-12-10', 1)

SELECT * FROM [Users]

UPDATE [Users] 
SET [LastLoginTime] = GETDATE() 
WHERE [IsDeleted] = 0

CREATE DATABASE [Movies2]

USE [Movies2]

CREATE TABLE [Directors] (
	[Id] INT PRIMARY KEY IDENTITY,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(150))

CREATE TABLE [Genres] (
	[Id] INT PRIMARY KEY IDENTITY,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(150))

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(150))

CREATE TABLE [Movies] (
	[Id] INT PRIMARY KEY IDENTITY (1001, 1),
	[Title] NVARCHAR(70) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors] ([Id]) NOT NULL,
	[CopyrightYear] SMALLINT NOT NULL,
	[Length] TIME NOT NULL,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres] ([Id]) NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[Rating] DECIMAL (3, 1) NOT NULL,
	CHECK ([Rating] <= 10.0),
	[Notes] NVARCHAR(250))

INSERT INTO [Directors] ([DirectorName])
	VALUES
	('Pesho Ivanov'),
	('Ivan Borisov'),
	('Darina Petrova'),
	('Maya Stoilova'),
	('Dimitrichko Martinov')

INSERT INTO [Genres] ([GenreName])
	VALUES
	('Action'),
	('Thriller'),
	('Horror'),
	('Comedy'),
	('Animation')

INSERT INTO [Categories] ([CategoryName])
	VALUES
	('Kids'),
	('Adults'),
	('FamilyMovie'),
	('Biographic'),
	('Documentary')

INSERT INTO [Movies] ([Title], [GenreId], [CategoryId], [DirectorId], [CopyrightYear], [Length], [Rating])
	VALUES
	('Title1', 2, 2, 3, 2012, '01:13:55', 10.0),
	('Title2', 1, 3, 1, 2022, '03:00:45', 9.8),
	('Title3', 4, 3, 2, 2014, '02:55:10', 9.9),
	('Title4', 5, 1, 5, 2020, '01:45:00', 7.7),
	('Title5', 3, 4, 4, 2019, '03:02:03', 4.5)

SELECT * FROM [Movies]

SELECT AVG([Rating]) AS [Average] FROM [Movies]
SELECT MIN([Rating]) AS [Minimum] FROM [Movies]
SELECT MAX([Rating]) AS [Maximum] FROM [Movies]
SELECT AVG([CopyrightYear]) FROM [Movies]
SELECT COUNT(*) AS [TotalCount] FROM [Movies]
SELECT [Title], [Length], ROW_NUMBER() OVER (ORDER BY [Id]) AS [NumberOfRow] FROM [Movies]
SELECT DENSE_RANK() OVER (ORDER BY [Title]) AS [TitleRanks], [Title], [Length] FROM [Movies]

CREATE DATABASE [CarRental2]

USE [CarRental2]

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] VARCHAR(20) NOT NULL,
	[DailyRate] DECIMAL (4, 2) NOT NULL,
	[WeeklyRate] DECIMAL (5, 2) NOT NULL,
	[MonthlyRate] DECIMAL (6, 2) NOT NULL,
	[WeekendRate] DECIMAL (5, 2) NOT NULL)

CREATE TABLE [Cars] (
	[Id] INT PRIMARY KEY IDENTITY,
	[PlateNumber] CHAR(10) NOT NULL,
	[Manufacturer] NVARCHAR(25) NOT NULL,
	[Model] NVARCHAR(25) NOT NULL,
	[CarYear] SMALLINT NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[Doors] SMALLINT NOT NULL,
	[Picture] VARBINARY,
	[Condition] VARCHAR(25),
	[Available] BIT NOT NULL)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY (1001, 1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] VARCHAR(25) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [Customers] (
	[Id] INT PRIMARY KEY IDENTITY (2001, 1),
	[DriverLicenceNumber] NCHAR(10) NOT NULL,
	[FullName] NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[ZIPCode] SMALLINT NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [RentalOrders] (
	[Id] INT PRIMARY KEY IDENTITY (10001, 1),
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES [Cars] ([Id]) NOT NULL,
	[TankLevel] DECIMAL (3, 1) NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NOT NULL,
	[TotalDays] SMALLINT NOT NULL,
	[RateApplied] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[TaxRate] DECIMAL (4, 2) NOT NULL,
	[OrderStatus] BIT NOT NULL,
	[Notes] VARCHAR(200))

INSERT INTO [Categories] ([CategoryName], [DailyRate], [WeekendRate], [WeeklyRate], [MonthlyRate])
	VALUES
	('Regular', 30.50, 55.10, 170.00, 400.00),
	('Premium', 45.20, 88.00, 250.00, 810.10),
	('Lux', 85.00, 160.00, 400.00, 1100.00)

INSERT INTO [Cars] ([Manufacturer], [Model], [PlateNumber], [Doors], [CarYear], [Condition], [CategoryId], [Available])
	VALUES
	('VW', 'Golf', 'PK 8888 TT', 4, 2012, 'Tuned', 3, 1),
	('Mercedes', 'A150', 'CA 1298 KK', 4, 2010, 'Used a lot', 2, 1),
	('Zhiguli', '1300', 'KH 5631 MM', 5, 1981, 'Old but gold', 1, 1)

INSERT INTO [Employees] ([FirstName], [LastName], [Title])
	VALUES
	('Nedelcho', 'Zhelqzkov', 'Mechanic'),
	('Antoaneta', 'Velikova', 'Clients Service'),
	('Zhechka', 'Zhekova', 'Uncategorized')

INSERT INTO [Customers] ([FullName], [DriverLicenceNumber], [City], [Address], [ZIPCode])
	VALUES
	('Dimitrichko Ivanov', 'DI654388LK', 'Sofia', 'Krasno selo', 1612),
	('Petranka Cheburashkova', 'ZZ177815ZZ', 'Montana', 'Center', 3400),
	('Ivancho Georgievski', 'MK888999MK', 'Blagoevgrad', 'Center', 2700)

INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId], [TankLevel], [KilometrageStart],
	[KilometrageEnd], [TotalKilometrage], [StartDate], [EndDate], [TotalDays], [RateApplied], [TaxRate], [OrderStatus])
	VALUES
	(1003, 2003, 3, 45.2, 75000, 76100, 1100, '2022-05-28', '2022-05-31', 3, 1, 33.00, 1),
	(1001, 2002, 1, 65.0, 111000, 111750, 750, '2022-06-13', '2022-06-23', 10, 2, 45.50, 1),
	(1002, 2001, 2, 55.5, 89500, 89650, 150, '2022-05-30', '2022-06-02', 4, 1, 25.10, 0)

SELECT * FROM [RentalOrders]

SELECT [Id], [StartDate], [EndDate], 
DATEDIFF(DAY, [StartDate], [EndDate]) 
AS [Days] 
FROM [RentalOrders]
ORDER BY [Days] DESC

SELECT MIN([TotalKilometrage]) AS [Total] FROM [RentalOrders]

CREATE DATABASE [Hotel2]

USE [Hotel2]

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY (101, 1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] VARCHAR(25) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [Customers] (
	[Id] INT PRIMARY KEY IDENTITY (201, 1),
	[AccountNumber] NCHAR(15) UNIQUE NOT NULL,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[PhoneNumber] VARCHAR(15) NOT NULL,
	[EmergencyName] NVARCHAR(50),
	[EmergencyNumber] VARCHAR(15),
	[Notes] VARCHAR(200))

CREATE TABLE [RoomStatus] (
	[Id] INT PRIMARY KEY IDENTITY,
	[RoomStatus] VARCHAR(25) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [RoomTypes] (
	[Id] INT PRIMARY KEY IDENTITY,
	[RoomType] VARCHAR(25) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [BedTypes] (
	[Id] INT PRIMARY KEY IDENTITY,
	[BedType] VARCHAR(25) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [Rooms] (
	[Id] INT PRIMARY KEY IDENTITY(501, 1),
	[RoomNumber] SMALLINT UNIQUE NOT NULL,
	[RoomType] INT FOREIGN KEY REFERENCES [RoomTypes] ([Id]) NOT NULL,
	[BedType] INT FOREIGN KEY REFERENCES [BedTypes] ([Id]) NOT NULL,
	[Rate] DECIMAL (5, 2) NOT NULL,
	[RoomStatus] INT FOREIGN KEY REFERENCES [RoomStatus] ([Id]) NOT NULL,
	[Notes] VARCHAR(200))

CREATE TABLE [Payments] (
	[Id] INT PRIMARY KEY IDENTITY (1001, 1),
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[FirstDateOccupied] DATE NOT NULL,
	[LastDateOccupied] DATE NOT NULL,
	[TotalDays] SMALLINT NOT NULL,
	[AmountCharged] SMALLINT NOT NULL,
	[TaxRate] DECIMAL (5, 2) NOT NULL,
	[TaxAmount] SMALLINT NOT NULL,
	[PaymentTotal] DECIMAL (6, 2) NOT NULL,
	[Notes]	VARCHAR(200))

CREATE TABLE [Occupancies] (
	[Id] INT PRIMARY KEY IDENTITY(5001, 1),
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[DateOccupied] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[RoomNumber] INT FOREIGN KEY REFERENCES [Rooms] ([Id]),
	[RateApplied] DECIMAL (5, 2) NOT NULL,
	[PhoneCharge] DECIMAL (5, 2) NOT NULL,
	[Notes] VARCHAR(200))

INSERT INTO [Employees] ([FirstName], [LastName], [Title])
	VALUES
	('Gyuro', 'Mihailov', 'Receptionist'),
	('Penka', 'Petkova', 'HR'),
	('Kiril', 'Kokorov', 'Hygienist')

INSERT INTO [Customers] ([FirstName], [LastName], [AccountNumber], [PhoneNumber])
	VALUES
	('Mitko', 'Stoimenov', 'ËËÊ8103331ÂÏ', '+35928651100'),
	('Doncho', 'Donchev', 'ÄÄÌ8103132ÌÌ', '+359878556662'),
	('Stanoika', 'Lumpenova', 'ËÊÌ1115512ÐÏ', '+48279744411')

INSERT INTO [RoomStatus] ([RoomStatus])
	VALUES
	('Normal'),
	('Premium'),
	('Luxory')

INSERT INTO [RoomTypes] ([RoomType])
	VALUES
	('Studio'),
	('Apartment'),
	('Attelier')

INSERT INTO [BedTypes] ([BedType])
	VALUES
	('Single'),
	('Double'),
	('KingSize')

INSERT INTO [Rooms] ([RoomNumber], [RoomStatus], [RoomType], [BedType], [Rate])
	VALUES
	(810, 3, 3, 3, 115.50),
	(525, 2, 1, 1, 56.25),
	(114, 1, 2, 2, 70.30)

INSERT INTO [Payments] ([EmployeeId], [PaymentDate], [AccountNumber], [FirstDateOccupied], [LastDateOccupied],
			[TotalDays], [AmountCharged], [TaxRate], [TaxAmount], [PaymentTotal])
	VALUES
	(102, '2023-07-14', 201, '2023-08-01', '2023-08-14', 14, 13, 25.20, 2, 440.50),
	(101, '2023-06-21', 203, '2023-07-21', '2023-07-27', 7, 6, 45.20, 1, 250.00),
	(103, '2023-06-28', 202, '2023-08-02', '2023-08-22', 20, 15, 110.00, 3, 2280.00)

INSERT INTO [Occupancies] ([EmployeeId], [RoomNumber], [AccountNumber], [DateOccupied], [PhoneCharge], [RateApplied])
	VALUES
	(101, 502, 202, '2023-09-10', 12.10, 42.20),
	(103, 501, 201, '2023-09-07', 0.00, 34.80),
	(102, 503, 203, '2023-09-14', 116.20, 55.13)

SELECT o.[RoomNumber], o.[DateOccupied], o.[EmployeeId], e.[FirstName], e.[LastName]
FROM [Occupancies] AS o
JOIN [Employees] AS e 
ON e.Id = o.EmployeeId
ORDER BY [RoomNumber] DESC

SELECT CONCAT_WS('--', [FirstName], [LastName]) 
AS [FullName], [Title] FROM [Employees]

SELECT CONCAT(SUBSTRING([FirstName], 1, 1), REPLICATE('*', LEN([FirstName]) - 1)) FROM [Employees]

SELECT [RateApplied], FLOOR([RateApplied]), CEILING([RateApplied]), ROUND([RateApplied], -1) FROM [Occupancies]

SELECT [DateOccupied], DATEPART(YEAR, [DateOccupied]) AS [Year] FROM [Occupancies]
SELECT [DateOccupied], DATEPART(DAYOFYEAR, [DateOccupied]) AS [DayOfYear] FROM [Occupancies]
SELECT [DateOccupied], DATEPART(DAY, [DateOccupied]) AS [Day] FROM [Occupancies]
SELECT [DateOccupied], DATEPART(WEEK, [DateOccupied]) AS [Week] FROM [Occupancies]
SELECT [DateOccupied], DATEPART(MONTH, [DateOccupied]) AS [Month] FROM [Occupancies]
SELECT [DateOccupied], DATEPART(QUARTER, [DateOccupied]) AS [Quarter] FROM [Occupancies]

SELECT DATEDIFF(HOUR, [FirstDateOccupied], [LastDateOccupied]) AS [Hours] FROM [Payments]
SELECT DATEDIFF(DAY, [FirstDateOccupied], [LastDateOccupied]) AS [Days] FROM [Payments]
SELECT DATEDIFF(MINUTE, [FirstDateOccupied], [LastDateOccupied]) AS [Minutes] FROM [Payments]

SELECT GETDATE()

SELECT DATEADD(WEEK, 6, GETDATE())
SELECT DATEADD(MONTH, 12, '2023-10-01T12:45:50')
SELECT DATEADD(DAY, 414, '2023-07-28')
SELECT EOMONTH(GETDATE(), 1)
SELECT DATEADD(MONTH, 76, GETDATE())

SELECT DATENAME(MONTH, GETDATE()) AS [NameOfMonth]
SELECT DATENAME(WEEKDAY, [DateOccupied]) AS [NameOfDay] FROM [Occupancies]

SELECT SIGN(-19)
SELECT SIGN(1914)
SELECT SIGN(0)
SELECT ROUND(PI(), 2)
SELECT RAND() AS [RandomizedNumber]
SELECT RAND(1914)
SELECT POWER(2, 8)
SELECT LOG10(515) AS [Äåñåòè÷í ëîãàðèòúì]
SELECT LOWER('ÑòÎÉÍÎÑÒ Ñ ãÎëÅìÈ è ÌÀËêè ÁÓÊâè')
SELECT UPPER('ÑòÎÉÍÎÑÒ Ñ ãÎëÅìÈ è ÌÀËêè ÁÓÊâè')
SELECT FLOOR(810.15) AS [LowerInt]
SELECT CEILING(810.15) AS [UpperInt]

CREATE DATABASE [SoftUniEx1]

USE [SoftUniEx1]

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY IDENTITY (1, 1),
	[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE [Addresses] (
	[Id] INT PRIMARY KEY IDENTITY (1, 1),
	[AddressText] NVARCHAR(150) NOT NULL,
	[TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]) NOT NULL)

CREATE TABLE [Departments] (
	[Id] INT PRIMARY KEY IDENTITY (1, 1),
	[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY (1, 1),
	[FirstName] NVARCHAR(50) NOT NULL,
	[MiddleName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[JobTitle] NVARCHAR(50) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments] ([Id]) NOT NULL,
	[HireDate] DATE NOT NULL,
	[Salary] DECIMAL (7, 2) NOT NULL,
	[AddressId] INT FOREIGN KEY REFERENCES [Addresses] ([Id]))

INSERT INTO [Towns] ([Name])
	VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO [Departments] ([Name])
	VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

--ALTER TABLE [Employees]
--ALTER COLUMN [AddressId] INT

INSERT INTO [Employees] ([FirstName], [MiddleName], [LastName], [JobTitle], [DepartmentId], [HireDate], [Salary])
	VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
	('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
	('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

SELECT * FROM [Towns]
SELECT * FROM [Departments]
SELECT * FROM [Employees]

SELECT [Name] FROM [Towns]
ORDER BY [Name] ASC

SELECT [Name] FROM [Departments]
ORDER BY [Name] ASC

SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees]
ORDER BY [Salary] DESC

USE [SoftUniEx1]

SELECT CONCAT_WS(' ', CONCAT(SUBSTRING([FirstName], 1, 2), REPLICATE('*', LEN([FirstName]) - 2)), 
[MiddleName], [LastName]) 
AS [FullName], 
DENSE_RANK() OVER (ORDER BY [Salary]) AS [SalaryRank], 
ROW_NUMBER() OVER (ORDER BY [Salary]) AS [NumBySalaryRank] 
FROM [Employees]
ORDER BY [LastName]

SELECT ROUND([DepartmentId] * [Salary], -3) 
AS [Product] FROM [Employees]

SELECT NTILE(3) OVER (ORDER BY [Salary]) 
AS [Tile], [FirstName], [LastName] 
FROM [Employees]

SELECT ROUND(SUM([Salary] * 12), 0) AS [AnnualSalaryExpenses] FROM [Employees]

SELECT d.[Name], e.[FirstName], e.[LastName], e.[HireDate]
FROM [Employees] AS e
JOIN [Departments] AS d ON d.[Id] = e.[DepartmentId]
WHERE [Salary] <> 3000
ORDER BY d.[Name], e.[FirstName], e.[LastName]

SELECT DATALENGTH([FirstName]) AS [Bytes],
LEN([FirstName]) AS [Symbols] FROM [Employees]

SELECT DATEPART(DAYOFYEAR, [HireDate]) FROM [Employees]
SELECT DATEPART(QUARTER, [HireDate]) FROM [Employees]
SELECT DATEDIFF(YEAR, [HireDate], CURRENT_TIMESTAMP) FROM [Employees]
SELECT EOMONTH([HireDate]) FROM [Employees]
SELECT DATENAME(WEEKDAY, [HireDate]) AS [Name of the Day] FROM [Employees]

SELECT CURRENT_TIMESTAMP
SELECT GETDATE()
SELECT SYSDATETIME()
SELECT GETUTCDATE()

SELECT ISDATE('2012-12-10')

SELECT SQUARE(12)
SELECT SQRT(81)
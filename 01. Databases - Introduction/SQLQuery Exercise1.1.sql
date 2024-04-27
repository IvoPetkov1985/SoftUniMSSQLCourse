CREATE DATABASE [SoftUni]

USE [SoftUni]

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(75) NOT NULL)

CREATE TABLE [Addresses] (
	[Id] INT PRIMARY KEY IDENTITY,
	[AddressText] NVARCHAR(200) NOT NULL,
	[TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]) NOT NULL)

CREATE TABLE [Departments] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[MiddleName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(60) NOT NULL,
	[JobTitle] NVARCHAR(30) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments] ([Id]) NOT NULL,
	[HireDate] DATE NOT NULL,
	[Salary] DECIMAL (6, 2) NOT NULL,
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

SELECT * FROM [Towns] ORDER BY [Name]
SELECT * FROM [Departments] ORDER BY [Name]
SELECT * FROM [Employees] ORDER BY [Salary] DESC

CREATE DATABASE [CarRental]

USE [CarRental]

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[DailyRate] DECIMAL (2, 1) NOT NULL,
	[WeeklyRate] DECIMAL (2, 1) NOT NULL,
	[MonthlyRate] DECIMAL (2, 1) NOT NULL,
	[WeekendRate] DECIMAL (2, 1) NOT NULL)

CREATE TABLE [Cars] (
	[Id] INT PRIMARY KEY IDENTITY,
	[PlateNumber] VARCHAR(10) NOT NULL,
	[Manufacturer] NVARCHAR(30) NOT NULL,
	[Model] NVARCHAR(30) NOT NULL,
	[CarYear] SMALLINT NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[Doors] SMALLINT NOT NULL,
	[Picture] VARBINARY,
	[Condition] NVARCHAR(20) NOT NULL,
	[Available] BIT NOT NULL)

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(40) NOT NULL,
	[LastName] NVARCHAR(40) NOT NULL,
	[Title] NVARCHAR(40) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [Customers] (
	[Id] INT PRIMARY KEY IDENTITY,
	[DriverLicenceNumber] NVARCHAR(30) NOT NULL,
	[FullName] NVARCHAR(80) NOT NULL,
	[Address] NVARCHAR(200),
	[City] NVARCHAR(60) NOT NULL,
	[ZIPCode] NVARCHAR(8),
	[Notes] NVARCHAR(200))

CREATE TABLE [RentalOrders] (
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES [Cars] ([Id]) NOT NULL,
	[TankLevel] DECIMAL (3, 1) NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NOT NULL,
	[TotalDays] INT,
	[RateApplied] INT FOREIGN KEY REFERENCES [Categories] ([Id]) NOT NULL,
	[TaxRate] DECIMAL (5, 2) NOT NULL,
	[OrderStatus] BIT NOT NULL,
	[Notes] NVARCHAR(200))

INSERT INTO [Categories] ([CategoryName], [DailyRate], [WeekendRate], [WeeklyRate], [MonthlyRate])
	VALUES
	('Regilar', 3.9, 4.2, 4.1, 4.0),
	('Premium', 4.9, 5.0, 5.0, 5.1),
	('Luxory', 5.9, 6.0, 6.0, 6.0)

INSERT INTO [Cars] ([PlateNumber], [Manufacturer], [Model], [CarYear], [Doors], [Condition], [Available], [CategoryId])
	VALUES
	('PK 1313 KT', 'VW', 'Golf', 2010, 4, 'Tuned', 1, 3),
	('A 7777 AA', 'Audi', 'Q7', 2022, 5, 'Brand new', 0, 3),
	('B 8724 HH', 'Lada', '1300', 1980, 4, 'Rusted', 1, 1)

INSERT INTO [Employees] ([FirstName], [LastName], [Title])
	VALUES
	('Pesho', 'Goshov', 'Mechanic'),
	('Penka', 'Valentinova', 'Engineer'),
	('Stefan', 'Stoyanov', 'Worker')

INSERT INTO [Customers] ([FullName], [DriverLicenceNumber], [City], [Address], [ZIPCode])
	VALUES
	('Stefan Velichkov', 'KDZ144999777TT', 'Sofia', 'Druzhba', 1766),
	('Ivan Ivanov', 'TKR101099922KL', 'Plovdiv', 'Botev', 4000),
	('Niki Petkov', 'SRT0999888777YY', 'Stara Zagora', 'Samara', 6000)

INSERT INTO [RentalOrders] ([CarId], [CustomerId], [EmployeeId], [StartDate], [EndDate], [TotalDays], [KilometrageStart],
[KilometrageEnd], [TotalKilometrage], [TankLevel], [TaxRate], [OrderStatus], [RateApplied])
	VALUES
	(1, 3, 2, '2022-04-15', '2022-04-18', 3, 25000, 25500, 500, 45.5, 75.00, 1, 2),
	(2, 2, 3, '2022-04-10', '2022-04-20', 10, 176100, 177100, 1000, 78.0, 110.00, 0, 1),
	(1, 1, 3, '2022-05-01', '2022-05-07', 6, 77050, 77150, 100, 55.0, 78.50, 1, 3)

USE [SoftUni]

SELECT [Name] FROM [Towns] ORDER BY [Name] ASC
SELECT [Name] FROM [Departments] ORDER BY [Name] ASC
SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees] ORDER BY [Salary] DESC

UPDATE [Employees] SET [Salary] = [Salary] * 1.10

SELECT [Salary] FROM [Employees]
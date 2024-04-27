CREATE DATABASE [Hotel]

USE [Hotel]

CREATE TABLE [Employees] (
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(40) NOT NULL,
	[LastName] NVARCHAR(40) NOT NULL,
	[Title] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [Customers] (
	[Id] INT PRIMARY KEY IDENTITY,
	[AccountNumber] NVARCHAR(20) NOT NULL,
	[FirstName] NVARCHAR(40) NOT NULL,
	[LastName] NVARCHAR(40) NOT NULL,
	[PhoneNumber] VARCHAR(12) NOT NULL,
	[EmergencyName] NVARCHAR(40),
	[EmergencyNumber] VARCHAR(12),
	[Notes] NVARCHAR(200))

CREATE TABLE [RoomStatus] (
	[Id] INT PRIMARY KEY IDENTITY,
	[RoomStatus] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [RoomTypes] (
	[Id] INT PRIMARY KEY IDENTITY,
	[RoomType] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [BedTypes] (
	[Id] INT PRIMARY KEY IDENTITY,
	[BedType] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [Rooms] (
	[Id] INT PRIMARY KEY IDENTITY,
	[RoomNumber] SMALLINT NOT NULL,
	[RoomType] INT FOREIGN KEY REFERENCES [RoomTypes] ([Id]) NOT NULL,
	[BedType] INT FOREIGN KEY REFERENCES [BedTypes] ([Id]) NOT NULL,
	[Rate] DECIMAL (2, 1) NOT NULL,
	[RoomStatus] INT FOREIGN KEY REFERENCES [RoomStatus] ([Id]) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [Payments] (
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[FirstDateOccupied] DATE NOT NULL,
	[LastDateOccupied] DATE NOT NULL,
	[TotalDays] INT NOT NULL,
	[AmountCharged] INT NOT NULL,
	[TaxRate] DECIMAL (5, 2) NOT NULL,
	[TaxAmount] DECIMAL (5, 2) NOT NULL,
	[PaymentTotal] DECIMAL (5, 2) NOT NULL,
	[Notes] NVARCHAR(200))

CREATE TABLE [Occupancies] (
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees] ([Id]) NOT NULL,
	[DateOccupied] DATE NOT NULL,
	[AccountNumber] INT FOREIGN KEY REFERENCES [Customers] ([Id]) NOT NULL,
	[RoomNumber] SMALLINT NOT NULL,
	[RateApplied] DECIMAL (2, 1) NOT NULL,
	[PhoneCharge] DECIMAL (4, 2),
	[Notes] NVARCHAR(200))

INSERT INTO [Employees] ([FirstName], [LastName], [Title])
	VALUES
	('Gosho', 'Petkov', 'Manager'),
	('Peter', 'Ivanov', 'Barman'),
	('Hrisi', 'Parvanova', 'Receptionist')

INSERT INTO [Customers] ([FirstName], [LastName], [PhoneNumber], [AccountNumber])
	VALUES
	('Pencho', 'Ivanov', '0788125125', 'KK313777000HH'),
	('Ivan', 'Borisov', '+35928553555', 'LL888999000LM'),
	('Albena', 'Krastanova', '0878888999', 'KL898999000912MM')

INSERT INTO [RoomStatus] ([RoomStatus])
	VALUES
	('Normal'),
	('Extra'),
	('Ultra')

INSERT INTO [RoomTypes] ([RoomType])
	VALUES
	('Small'),
	('Big'),
	('Apartment')

INSERT INTO [BedTypes] ([BedType])
	VALUES
	('Single'),
	('Double'),
	('KingsBed')

INSERT INTO [Rooms] ([RoomNumber], [RoomStatus], [RoomType], [BedType], [Rate])
	VALUES
	(310, 2, 3, 1, 8.9),
	(321, 1, 1, 3, 7.8),
	(110, 3, 3, 2, 9.9)

INSERT INTO [Payments] ([AccountNumber], [AmountCharged], [EmployeeId], [FirstDateOccupied], [LastDateOccupied],
			[PaymentDate], [PaymentTotal], [TaxAmount], [TaxRate], [TotalDays])
	VALUES
	(2, 3, 3, '2023-01-11', '2023-01-20', '2023-01-20', 300.00, 50.00, 60.00, 9),
	(1, 2, 2, '2022-10-10', '2023-11-05', '2023-09-12', 250.10, 13.00, 190.50, 25),
	(3, 2, 1, '2023-06-05', '2023-06-07', '2023-06-07', 80.00, 5.50, 19.50, 2)

INSERT INTO [Occupancies] ([RoomNumber], [AccountNumber], [DateOccupied], [EmployeeId], [PhoneCharge], [RateApplied])
	VALUES
	(310, 2, '2023-07-07', 3, 13.30, 8.8),
	(204, 1, '2023-09-09', 2, 10.00, 8.9),
	(111, 3, '2023-08-20', 1, 0, 9.9)

UPDATE [Payments] SET [TaxRate] = [TaxRate] * 0.97

SELECT [TaxRate] FROM [Payments]
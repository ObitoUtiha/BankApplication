USE [master]
GO
/****** Object:  Database [BankDb]    Script Date: 11.09.2024 3:43:00 ******/
CREATE DATABASE [BankDb]
 CONTAINMENT = NONE

 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BankDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BankDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BankDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BankDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BankDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BankDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [BankDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BankDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BankDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BankDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BankDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BankDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BankDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BankDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BankDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BankDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BankDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BankDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BankDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BankDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BankDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BankDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BankDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BankDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BankDb] SET  MULTI_USER 
GO
ALTER DATABASE [BankDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BankDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BankDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BankDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BankDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BankDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BankDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [BankDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BankDb]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[CurrencyId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [nvarchar](50) NOT NULL,
	[CurrencyCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderId] [int] NOT NULL,
	[GenderName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Age] [int] NULL,
	[Gender] [int] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonStatistic]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonStatistic](
	[PersonStatisticId] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_PersonStatistic] PRIMARY KEY CLUSTERED 
(
	[PersonStatisticId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NULL,
	[TransactionTypeId] [int] NOT NULL,
	[Date] [datetime] NULL,
	[Currency] [int] NOT NULL,
	[Value] [float] NOT NULL,
	[TransferAccount] [int] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionType]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
	[TransactionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoney]    Script Date: 11.09.2024 3:43:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMoney](
	[UserMoneyId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyId] [int] NULL,
	[Value] [float] NOT NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_UserMoney] PRIMARY KEY CLUSTERED 
(
	[UserMoneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Currency] ON 

INSERT [dbo].[Currency] ([CurrencyId], [CurrencyName], [CurrencyCode]) VALUES (1, N'Доллар США', N'USD')
INSERT [dbo].[Currency] ([CurrencyId], [CurrencyName], [CurrencyCode]) VALUES (2, N'Российский рубль', N'RUB')
INSERT [dbo].[Currency] ([CurrencyId], [CurrencyName], [CurrencyCode]) VALUES (3, N'Евро', N'EUR')
SET IDENTITY_INSERT [dbo].[Currency] OFF
GO
INSERT [dbo].[Gender] ([GenderId], [GenderName]) VALUES (1, N'Мужчина')
INSERT [dbo].[Gender] ([GenderId], [GenderName]) VALUES (2, N'Женщина')
GO
SET IDENTITY_INSERT [dbo].[Person] ON 

INSERT [dbo].[Person] ([PersonId], [Name], [Age], [Gender], [UserId]) VALUES (1, N'Иван', 12, 1, 1)
INSERT [dbo].[Person] ([PersonId], [Name], [Age], [Gender], [UserId]) VALUES (2, N'Дмитрий', 18, 1, 2)
INSERT [dbo].[Person] ([PersonId], [Name], [Age], [Gender], [UserId]) VALUES (4, N'Евгений', 22, 1, 3)
SET IDENTITY_INSERT [dbo].[Person] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (1, 1, 1, CAST(N'2024-09-11T01:25:59.557' AS DateTime), 1, 2, 2)
INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (2, 1, 2, CAST(N'2024-09-11T02:13:00.093' AS DateTime), 2, 12, NULL)
INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (3, 1, 2, CAST(N'2024-09-11T02:14:04.730' AS DateTime), 2, 22, NULL)
INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (4, 1, 2, CAST(N'2024-09-11T02:14:40.153' AS DateTime), 2, 1, NULL)
INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (5, 1, 2, CAST(N'2024-09-11T03:20:27.310' AS DateTime), 2, 33, NULL)
INSERT [dbo].[Transaction] ([TransactionId], [PersonId], [TransactionTypeId], [Date], [Currency], [Value], [TransferAccount]) VALUES (6, 1, 2, CAST(N'2024-09-11T03:20:42.950' AS DateTime), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionType] ON 

INSERT [dbo].[TransactionType] ([TransactionTypeId], [TransactionTypeName]) VALUES (1, N'Перевод')
INSERT [dbo].[TransactionType] ([TransactionTypeId], [TransactionTypeName]) VALUES (2, N'Оплата')
SET IDENTITY_INSERT [dbo].[TransactionType] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (1, N'1', N'1')
INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (2, N'2', N'2')
INSERT [dbo].[User] ([UserId], [Login], [Password]) VALUES (3, N'3', N'3')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserMoney] ON 

INSERT [dbo].[UserMoney] ([UserMoneyId], [CurrencyId], [Value], [PersonId]) VALUES (3, 1, 17, 1)
INSERT [dbo].[UserMoney] ([UserMoneyId], [CurrencyId], [Value], [PersonId]) VALUES (4, 2, 262, 1)
INSERT [dbo].[UserMoney] ([UserMoneyId], [CurrencyId], [Value], [PersonId]) VALUES (5, 1, 14, 2)
INSERT [dbo].[UserMoney] ([UserMoneyId], [CurrencyId], [Value], [PersonId]) VALUES (8, 3, 22, 4)
SET IDENTITY_INSERT [dbo].[UserMoney] OFF
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([GenderId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Gender]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_User]
GO
ALTER TABLE [dbo].[PersonStatistic]  WITH CHECK ADD  CONSTRAINT [FK_PersonStatistic_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[PersonStatistic] CHECK CONSTRAINT [FK_PersonStatistic_Person]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Currency] FOREIGN KEY([Currency])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Currency]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Person]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Person1] FOREIGN KEY([TransferAccount])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Person1]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_TransactionType] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[TransactionType] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_TransactionType]
GO
ALTER TABLE [dbo].[UserMoney]  WITH CHECK ADD  CONSTRAINT [FK_UserMoney_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[UserMoney] CHECK CONSTRAINT [FK_UserMoney_Currency]
GO
ALTER TABLE [dbo].[UserMoney]  WITH CHECK ADD  CONSTRAINT [FK_UserMoney_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[UserMoney] CHECK CONSTRAINT [FK_UserMoney_Person]
GO
USE [master]
GO
ALTER DATABASE [BankDb] SET  READ_WRITE 
GO

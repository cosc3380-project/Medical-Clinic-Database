USE [master]
GO
/****** Object:  Database [Clinic_DB]    Script Date: 4/22/2019 09:34:20 PM ******/
CREATE DATABASE [Clinic_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Clinic_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Clinic_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Clinic_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Clinic_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Clinic_DB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Clinic_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Clinic_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Clinic_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Clinic_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Clinic_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Clinic_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [Clinic_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Clinic_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Clinic_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Clinic_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Clinic_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Clinic_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Clinic_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Clinic_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Clinic_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Clinic_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Clinic_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Clinic_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Clinic_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Clinic_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Clinic_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Clinic_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Clinic_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Clinic_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [Clinic_DB] SET  MULTI_USER 
GO
ALTER DATABASE [Clinic_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Clinic_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Clinic_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Clinic_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Clinic_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Clinic_DB', N'ON'
GO
ALTER DATABASE [Clinic_DB] SET QUERY_STORE = OFF
GO
USE [Clinic_DB]
GO
/****** Object:  Table [dbo].[APPOINTMENT]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPOINTMENT](
	[Appt_ID] [int] IDENTITY(1,1) NOT NULL,
	[Appt_Doc_ID] [int] NOT NULL,
	[Appt_Pat_ID] [int] NOT NULL,
	[Appt_Office_ID] [int] NOT NULL,
	[Appt_Date] [datetime] NULL,
	[Appt_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Appt_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APPROVAL]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPROVAL](
	[App_ID] [int] IDENTITY(1,1) NOT NULL,
	[App_Doc_ID] [int] NOT NULL,
	[App_Pat_ID] [int] NOT NULL,
	[App_Spec_ID] [int] NOT NULL,
	[App_Given] [bit] NULL,
	[App_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[App_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BLOOD_TEST]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BLOOD_TEST](
	[BT_ID] [int] IDENTITY(1,1) NOT NULL,
	[BT_APPT_ID] [int] NOT NULL,
	[BT_RBC] [float] NULL,
	[BT_WBC] [float] NULL,
	[BT_Platelet_Cnt] [float] NULL,
	[BT_Hgb] [float] NULL,
	[BT_Hct] [float] NULL,
	[BT_MCV] [float] NULL,
	[BT_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[BT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIAGNOSIS]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIAGNOSIS](
	[Diag_ID] [int] IDENTITY(1,1) NOT NULL,
	[Diag_Appt_ID] [int] NOT NULL,
	[Diag_Desc] [varchar](50) NULL,
	[Diag_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Diag_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOCTOR]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOCTOR](
	[Doc_ID] [int] IDENTITY(1,1) NOT NULL,
	[Doc_Name_F] [varchar](20) NULL,
	[Doc_Name_L] [varchar](20) NULL,
	[Doc_Email] [varchar](35) NULL,
	[Doc_DOB] [date] NULL,
	[Doc_Phone] [varchar](10) NULL,
	[Doc_Gender] [char](1) NULL,
	[Doc_Specialization] [varchar](40) NULL,
	[Doc_Addr_Street] [varchar](30) NULL,
	[Doc_Addr_2] [varchar](20) NULL,
	[Doc_Addr_City] [varchar](10) NULL,
	[Doc_Addr_State] [char](2) NULL,
	[Doc_Addr_Zip] [int] NULL,
	[Doc_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Doc_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EMAIL]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMAIL](
	[Email_ID] [int] IDENTITY(1,1) NOT NULL,
	[Email_Message] [varchar](70) NULL,
	[Email_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Email_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGIN]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGIN](
	[Log_User_Name] [varchar](20) NOT NULL,
	[Log_Pass] [varchar](25) NOT NULL,
	[Log_EID] [int] NOT NULL,
	[Log_User_Type] [char](1) NOT NULL,
	[Log_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Log_User_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OFFICE]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OFFICE](
	[Off_ID] [int] IDENTITY(1,1) NOT NULL,
	[Off_Doc_Mon] [int] NULL,
	[Off_Doc_Tue] [int] NULL,
	[Off_Doc_Wed] [int] NULL,
	[Off_Doc_Thu] [int] NULL,
	[Off_Doc_Fri] [int] NULL,
	[Off_Doc_Sat] [int] NULL,
	[Off_Doc_Sun] [int] NULL,
	[Off_Addr_Street] [varchar](30) NOT NULL,
	[Off_Addr_2] [varchar](20) NULL,
	[Off_Addr_City] [varchar](10) NOT NULL,
	[Off_Addr_State] [varchar](10) NOT NULL,
	[Off_Addr_Zip] [int] NOT NULL,
	[Off_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Off_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OFFICE_ADMIN]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OFFICE_ADMIN](
	[OA_ID] [int] IDENTITY(1,1) NOT NULL,
	[OA_Role] [varchar](15) NOT NULL,
	[OA_Off_ID] [int] NULL,
	[OA_Name_F] [varchar](20) NOT NULL,
	[OA_Name_L] [varchar](20) NOT NULL,
	[OA_Gender] [char](1) NULL,
	[OA_Email] [varchar](35) NOT NULL,
	[OA_Phone] [varchar](10) NULL,
	[OA_DOB] [date] NULL,
	[OA_Addr_Street] [varchar](30) NOT NULL,
	[OA_Addr_2] [varchar](20) NULL,
	[OA_Addr_City] [varchar](10) NOT NULL,
	[OA_Addr_State] [varchar](2) NOT NULL,
	[OA_Addr_Zip] [int] NOT NULL,
	[OA_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[OA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PATIENT]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PATIENT](
	[Pat_ID] [int] IDENTITY(1,1) NOT NULL,
	[Pat_Name_F] [varchar](20) NULL,
	[Pat_Name_L] [varchar](20) NULL,
	[Pat_Height] [float] NULL,
	[Pat_Weight] [float] NULL,
	[Pat_Gender] [char](1) NULL,
	[Pat_Email] [varchar](35) NULL,
	[Pat_Phone] [varchar](10) NULL,
	[Pat_DOB] [date] NULL,
	[Pat_Addr_Street] [varchar](30) NULL,
	[Pat_Addr_2] [varchar](20) NULL,
	[Pat_Addr_City] [varchar](10) NULL,
	[Pat_Addr_State] [char](2) NULL,
	[Pat_Addr_Zip] [int] NULL,
	[Pat_Created_By] [varchar](20) NOT NULL,
	[Pat_Updated_By] [varchar](20) NOT NULL,
	[Pat_Created_Date] [date] NULL,
	[Pat_Updated_Date] [date] NULL,
	[Pat_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Pat_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRESCRIPTION]    Script Date: 4/22/2019 09:34:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRESCRIPTION](
	[Pre_ID] [int] IDENTITY(1,1) NOT NULL,
	[Pre_Appt_ID] [int] NOT NULL,
	[Pre_Name] [varchar](30) NULL,
	[Pre_Refills_Allowed] [int] NULL,
	[Pre_Refills_Filled] [int] NULL,
	[Pre_Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Pre_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[APPOINTMENT] ON 

INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (1, 3, 1, 1, CAST(N'2019-04-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (2, 1, 2, 3, CAST(N'2019-04-29T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (3, 2, 3, 2, CAST(N'2019-04-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (4, 5, 4, 4, CAST(N'2019-04-29T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (5, 4, 5, 5, CAST(N'2019-04-30T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (6, 4, 5, 5, CAST(N'2019-04-22T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (7, 4, 5, 5, CAST(N'2019-04-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (8, 4, 5, 5, CAST(N'2019-04-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (9, 4, 5, 5, CAST(N'2019-04-25T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (10, 4, 5, 5, CAST(N'2019-04-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (11, 4, 5, 5, CAST(N'2019-04-27T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[APPOINTMENT] ([Appt_ID], [Appt_Doc_ID], [Appt_Pat_ID], [Appt_Office_ID], [Appt_Date], [Appt_Deleted]) VALUES (12, 4, 5, 5, CAST(N'2019-05-01T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[APPOINTMENT] OFF
SET IDENTITY_INSERT [dbo].[APPROVAL] ON 

INSERT [dbo].[APPROVAL] ([App_ID], [App_Doc_ID], [App_Pat_ID], [App_Spec_ID], [App_Given], [App_Deleted]) VALUES (1, 1, 1, 1, NULL, 0)
INSERT [dbo].[APPROVAL] ([App_ID], [App_Doc_ID], [App_Pat_ID], [App_Spec_ID], [App_Given], [App_Deleted]) VALUES (2, 2, 2, 1, NULL, 0)
INSERT [dbo].[APPROVAL] ([App_ID], [App_Doc_ID], [App_Pat_ID], [App_Spec_ID], [App_Given], [App_Deleted]) VALUES (3, 3, 3, 1, NULL, 0)
INSERT [dbo].[APPROVAL] ([App_ID], [App_Doc_ID], [App_Pat_ID], [App_Spec_ID], [App_Given], [App_Deleted]) VALUES (4, 4, 4, 1, NULL, 0)
INSERT [dbo].[APPROVAL] ([App_ID], [App_Doc_ID], [App_Pat_ID], [App_Spec_ID], [App_Given], [App_Deleted]) VALUES (5, 5, 5, 1, NULL, 0)
SET IDENTITY_INSERT [dbo].[APPROVAL] OFF
SET IDENTITY_INSERT [dbo].[BLOOD_TEST] ON 

INSERT [dbo].[BLOOD_TEST] ([BT_ID], [BT_APPT_ID], [BT_RBC], [BT_WBC], [BT_Platelet_Cnt], [BT_Hgb], [BT_Hct], [BT_MCV], [BT_Deleted]) VALUES (1, 1, 5, 4600, 300, 15.2, 45, 87, 0)
INSERT [dbo].[BLOOD_TEST] ([BT_ID], [BT_APPT_ID], [BT_RBC], [BT_WBC], [BT_Platelet_Cnt], [BT_Hgb], [BT_Hct], [BT_MCV], [BT_Deleted]) VALUES (2, 2, 5.1, 9900, 250, 14.2, 45, 90, 0)
INSERT [dbo].[BLOOD_TEST] ([BT_ID], [BT_APPT_ID], [BT_RBC], [BT_WBC], [BT_Platelet_Cnt], [BT_Hgb], [BT_Hct], [BT_MCV], [BT_Deleted]) VALUES (3, 3, 5.2, 6700, 244, 15.1, 40, 81, 0)
INSERT [dbo].[BLOOD_TEST] ([BT_ID], [BT_APPT_ID], [BT_RBC], [BT_WBC], [BT_Platelet_Cnt], [BT_Hgb], [BT_Hct], [BT_MCV], [BT_Deleted]) VALUES (4, 4, 4.8, 10399, 441, 14.5, 47, 95, 0)
INSERT [dbo].[BLOOD_TEST] ([BT_ID], [BT_APPT_ID], [BT_RBC], [BT_WBC], [BT_Platelet_Cnt], [BT_Hgb], [BT_Hct], [BT_MCV], [BT_Deleted]) VALUES (5, 5, 4.9, 7600, 399, 13.9, 45, 89, 0)
SET IDENTITY_INSERT [dbo].[BLOOD_TEST] OFF
SET IDENTITY_INSERT [dbo].[DIAGNOSIS] ON 

INSERT [dbo].[DIAGNOSIS] ([Diag_ID], [Diag_Appt_ID], [Diag_Desc], [Diag_Deleted]) VALUES (1, 1, N'Cold, coughing, slight fever', 0)
INSERT [dbo].[DIAGNOSIS] ([Diag_ID], [Diag_Appt_ID], [Diag_Desc], [Diag_Deleted]) VALUES (2, 2, N'Bacterial infection', 0)
INSERT [dbo].[DIAGNOSIS] ([Diag_ID], [Diag_Appt_ID], [Diag_Desc], [Diag_Deleted]) VALUES (3, 1, N'Flu', 0)
INSERT [dbo].[DIAGNOSIS] ([Diag_ID], [Diag_Appt_ID], [Diag_Desc], [Diag_Deleted]) VALUES (4, 1, N'Gastroenteritis', 0)
INSERT [dbo].[DIAGNOSIS] ([Diag_ID], [Diag_Appt_ID], [Diag_Desc], [Diag_Deleted]) VALUES (5, 1, N'Fecal incontinence', 0)
SET IDENTITY_INSERT [dbo].[DIAGNOSIS] OFF
SET IDENTITY_INSERT [dbo].[DOCTOR] ON 

INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (1, N'William', N'Knighton', N'w.knighton@starcare.com', CAST(N'1965-02-25' AS Date), N'5431287931', N'M', N'General Doctor', N'370 Kings Ct.', NULL, N'Houston', N'TX', 77092, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (2, N'Vanessa', N'Durner', N'v.durner@starcare.com', CAST(N'1976-06-12' AS Date), N'5431281576', N'F', N'Pediatrician', N'701 New Haven Rd.', NULL, N'Houston', N'TX', 77009, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (3, N'Herbert', N'Higginbotham', N'h.higginbotham@starcare.com', CAST(N'1970-01-18' AS Date), N'5431283579', N'M', N'Psychologist', N'20 Cosmos Blvd.', NULL, N'Houston', N'TX', 77007, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (4, N'Hannibal', N'Lecter', N'h.lecter@starcare.com', CAST(N'1960-03-12' AS Date), N'7139491192', N'M', N'Psychiatrist', N'4412 Insane St.', NULL, N'Fulshear', N'TX', 77441, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (5, N'Larry', N'Garfield', N'l.garfield@starcare.com', CAST(N'1966-06-16' AS Date), N'9794485918', N'M', N'Cardiologist', N'666 Satans Maw Rd.', NULL, N'Fulshear', N'TX', 77441, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (6, N'Cameron', N'Burke', N'c.burke@starcare.com', CAST(N'1955-01-31' AS Date), N'9373911820', N'M', N'General Doctor', N'4812 Burkeville Dr', NULL, N'Waco', N'TX', 76633, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (7, N'Clarissa', N'Turner', N'c.turner@starcare.com', CAST(N'1969-06-19' AS Date), N'8829181882', N'F', N'Pediatrician', N'440 Sharp Turn Ct.', NULL, N'Corpus', N'TX', 78336, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (8, N'Tessa', N'Angel', N't.angel@starcare.com', CAST(N'1977-07-17' AS Date), N'7192991337', N'F', N'Psychologist', N'18292 Beach Drift Ln.', NULL, N'Corpus', N'TX', 78336, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (9, N'Lorraine', N'Day', N'l.day@starcare.com', CAST(N'1959-03-29' AS Date), N'7139931829', N'F', N'Psychiatrist', N'4912 Deus Ex Rd.', NULL, N'Braunfels', N'TX', 78130, 0)
INSERT [dbo].[DOCTOR] ([Doc_ID], [Doc_Name_F], [Doc_Name_L], [Doc_Email], [Doc_DOB], [Doc_Phone], [Doc_Gender], [Doc_Specialization], [Doc_Addr_Street], [Doc_Addr_2], [Doc_Addr_City], [Doc_Addr_State], [Doc_Addr_Zip], [Doc_Deleted]) VALUES (10, N'Klaus', N'Kaiser', N'k.kaiser@starcare.com', CAST(N'1940-02-07' AS Date), N'7134845928', N'M', N'Cardiologist', N'1922 Fincastle Dr.', NULL, N'Braunfels', N'TX', 78130, 0)
SET IDENTITY_INSERT [dbo].[DOCTOR] OFF
SET IDENTITY_INSERT [dbo].[EMAIL] ON 

INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (1, N'Appointment Scheduled Mail sent for Patient 1 with Doctor3', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (2, N'Appointment Scheduled Mail sent for Patient 2 with Doctor1', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (3, N'Appointment Scheduled Mail sent for Patient 3 with Doctor2', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (4, N'Appointment Scheduled Mail sent for Patient 4 with Doctor5', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (5, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (6, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (7, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (8, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (9, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (10, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (11, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (12, N'Appointment Scheduled Mail sent for Patient 5 with Doctor4', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (13, N'Email sent for patient prescription refill request', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (14, N'Email sent for patient prescription refill request', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (15, N'Email sent for patient prescription refill request', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (16, N'Email sent for patient prescription refill request', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (17, N'Email sent for patient prescription refill request', 0)
INSERT [dbo].[EMAIL] ([Email_ID], [Email_Message], [Email_Deleted]) VALUES (18, N'Message has been sent', 0)
SET IDENTITY_INSERT [dbo].[EMAIL] OFF
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'acraft', N'craft101', 3, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'hcraft', N'craft101', 5, N'P', 1)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'hhigginbotham', N'higginbotham101', 3, N'D', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'joajones', N'jones72joanna', 1, N'A', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'jsmith', N'smith101', 1, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'jsmith2', N'smith101', 2, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'lmario', N'mario101', 6, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'mmario', N'mario101', 7, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'patrick', N'spongebob', 8, N'A', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'scraft', N'craft101', 4, N'P', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'vdurner', N'durner101', 2, N'D', 0)
INSERT [dbo].[LOGIN] ([Log_User_Name], [Log_Pass], [Log_EID], [Log_User_Type], [Log_Deleted]) VALUES (N'wknighton', N'knighton101', 1, N'D', 0)
SET IDENTITY_INSERT [dbo].[OFFICE] ON 

INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (1, 3, 3, 3, 3, 3, 3, NULL, N'1200 Strawberry Ln', NULL, N'Houston', N'TX', 77077, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (2, 2, 1, 2, 1, 2, 1, NULL, N'3003 Chocolate Dr', NULL, N'Cypress', N'TX', 77433, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (3, 1, 2, 1, 2, 1, 2, NULL, N'15200 Katy Freeway', NULL, N'Katy', N'TX', 77450, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (4, 5, 4, 5, 4, 5, 4, NULL, N'15591 Warthog Dr', NULL, N'Fulshear', N'TX', 77441, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (5, 4, 5, 4, 5, 4, 5, NULL, N'1337 Delaville Dr.', NULL, N'Brookshire', N'TX', 77423, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (6, 6, 6, 6, 6, 6, 6, NULL, N'1336 Almost Leet Dr.', NULL, N'Waco', N'TX', 76633, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (7, 7, 8, 7, 8, 7, 8, NULL, N'3838 Seahorse Bend Dr', NULL, N'Corpus', N'TX', 78336, 0)
INSERT [dbo].[OFFICE] ([Off_ID], [Off_Doc_Mon], [Off_Doc_Tue], [Off_Doc_Wed], [Off_Doc_Thu], [Off_Doc_Fri], [Off_Doc_Sat], [Off_Doc_Sun], [Off_Addr_Street], [Off_Addr_2], [Off_Addr_City], [Off_Addr_State], [Off_Addr_Zip], [Off_Deleted]) VALUES (8, 9, 10, 9, 10, 9, 10, NULL, N'223 Budweiser Rd.', NULL, N'Braunfels', N'TX', 78130, 0)
SET IDENTITY_INSERT [dbo].[OFFICE] OFF
SET IDENTITY_INSERT [dbo].[OFFICE_ADMIN] ON 

INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (1, N'Nurse', 1, N'Joanna', N'Jones', N'F', N'joannajones@starcare.com', N'0987654321', CAST(N'1972-07-28' AS Date), N'3100 Main St', NULL, N'Houston', N'TX', 77009, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (2, N'Nurse', 2, N'Princess', N'Peach', N'F', N'princesspeach@starcare.com', N'0864297531', CAST(N'1965-08-28' AS Date), N'1200 Mushroom Rd', NULL, N'Cypress', N'TX', 77433, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (3, N'Admin', 3, N'Patrick', N'Y', N'M', N'p.yee@starcare.com', N'7133136969', CAST(N'1901-01-01' AS Date), N'777 Lucky Sevens Rd.', NULL, N'Fulshear', N'TX', 77441, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (4, N'Nurse', 4, N'Stacy', N'Merlow', N'F', N's.merlow@starcare.com', N'9791428934', CAST(N'1999-11-20' AS Date), N'4112 Terra St.', NULL, N'Houston', N'TX', 77009, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (5, N'Nurse', 5, N'Jerry', N'Fitzler', N'M', N'j.fitzler@starcare.com', N'2815598119', CAST(N'1991-11-30' AS Date), N'1911 Candleston Ln.', NULL, N'Katy', N'TX', 77449, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (6, N'Nurse', 6, N'Jenny', N'Tilly', N'F', N'j.tilly@starcare.com', N'2819910291', CAST(N'1988-03-27' AS Date), N'333 Cornelius Ln.', NULL, N'Waco', N'TX', 76633, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (7, N'Nurse', 7, N'Harry', N'Muffin', N'M', N'h.muffin@starcare.com', N'2810019221', CAST(N'1976-11-25' AS Date), N'1333 Almost Leet Street', NULL, N'Corpus', N'TX', 78336, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (8, N'Nurse', 8, N'Cory', N'Adams', N'M', N'c.adams@starcare.com', N'2819937291', CAST(N'1971-11-01' AS Date), N'334 Green Beach Rd.', NULL, N'Corpus', N'TX', 78336, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (9, N'Admin', 9, N'Iris', N'Steiner', N'F', N'i.steiner@starcare.com', N'7139942839', CAST(N'1985-04-10' AS Date), N'1822 Oktober Street', NULL, N'Braunfels', N'TX', 78130, NULL)
INSERT [dbo].[OFFICE_ADMIN] ([OA_ID], [OA_Role], [OA_Off_ID], [OA_Name_F], [OA_Name_L], [OA_Gender], [OA_Email], [OA_Phone], [OA_DOB], [OA_Addr_Street], [OA_Addr_2], [OA_Addr_City], [OA_Addr_State], [OA_Addr_Zip], [OA_Deleted]) VALUES (10, N'Nurse', 10, N'Kelly', N'Broccoli', N'F', N'k.broccoli@starcare.com', N'7139179898', CAST(N'1979-02-12' AS Date), N'912 Bratwurst Dr.', NULL, N'Braunfels', N'TX', 78130, NULL)
SET IDENTITY_INSERT [dbo].[OFFICE_ADMIN] OFF
SET IDENTITY_INSERT [dbo].[PATIENT] ON 

INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (1, N'John', N'Smith', 69, 135, N'M', N'john.smith@gmail.com', N'1111111111', CAST(N'1995-07-21' AS Date), N'3100 Main St', NULL, N'Houston', N'TX', 77009, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (2, N'Jane', N'Smith', 65, 130, N'F', N'jane.smith@gmail.com', N'1111111111', CAST(N'1994-08-05' AS Date), N'3100 Main St', NULL, N'Houston', N'TX', 77009, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (3, N'Alex', N'Craft', 76, 130, N'F', N'alex@microsoft.com', N'1111111111', CAST(N'1976-02-13' AS Date), N'1 Diamond Rd.', N'A', N'Houston', N'TX', 77092, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (4, N'Steve', N'Craft', 76, 130, N'M', N'steve@microsoft.com', N'1111111111', CAST(N'1976-02-13' AS Date), N'1 Diamond Rd.', N'B', N'Houston', N'TX', 77092, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (5, N'Herobrine', N'Craft', 76, 130, N'M', N'herob@microsoft.com', N'1111111111', CAST(N'1976-02-13' AS Date), N'1 Diamond Rd.', N'B', N'Houston', N'TX', 77092, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, 1)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (6, N'Mario', N'Mario', 61, 130, N'M', N'mario@nintendo.com', N'1111111111', CAST(N'1985-09-13' AS Date), N'23 Mushroom Way', NULL, N'Houston', N'TX', 77004, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (7, N'Luigi', N'Mario', 65, 120, N'M', N'luigi@nintendo.com', N'1111111111', CAST(N'1985-09-13' AS Date), N'23 Mushroom Way', NULL, N'Houston', N'TX', 77004, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (8, N'Patrick', N'Star', 100, 120, N'M', N'patrick.star@gmail.com', N'1112223333', CAST(N'1985-09-13' AS Date), N'1234 Fake Street', NULL, N'Fulshear', N'TX', 12345, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (9, N'Razzle', N'Dazzle', 150, 177, N'F', N'razzle.dazzle@gmail.com', N'7133892201', CAST(N'1999-12-12' AS Date), N'14992 Baguette Street', NULL, N'Waco', N'TX', 76633, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
INSERT [dbo].[PATIENT] ([Pat_ID], [Pat_Name_F], [Pat_Name_L], [Pat_Height], [Pat_Weight], [Pat_Gender], [Pat_Email], [Pat_Phone], [Pat_DOB], [Pat_Addr_Street], [Pat_Addr_2], [Pat_Addr_City], [Pat_Addr_State], [Pat_Addr_Zip], [Pat_Created_By], [Pat_Updated_By], [Pat_Created_Date], [Pat_Updated_Date], [Pat_Deleted]) VALUES (10, N'Salami', N'Man', 111, 300, N'M', N'iLoveSalami@gmail.com', N'8829901928', CAST(N'1977-01-23' AS Date), N'333 Sausage Rd', NULL, N'Corpus', N'TX', 78336, N'Self', N'none', CAST(N'2019-04-11' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[PATIENT] OFF
SET IDENTITY_INSERT [dbo].[PRESCRIPTION] ON 

INSERT [dbo].[PRESCRIPTION] ([Pre_ID], [Pre_Appt_ID], [Pre_Name], [Pre_Refills_Allowed], [Pre_Refills_Filled], [Pre_Deleted]) VALUES (1, 1, N'Theraflu', 1, 0, 0)
INSERT [dbo].[PRESCRIPTION] ([Pre_ID], [Pre_Appt_ID], [Pre_Name], [Pre_Refills_Allowed], [Pre_Refills_Filled], [Pre_Deleted]) VALUES (2, 2, N'Metronidazole', 1, 0, 0)
INSERT [dbo].[PRESCRIPTION] ([Pre_ID], [Pre_Appt_ID], [Pre_Name], [Pre_Refills_Allowed], [Pre_Refills_Filled], [Pre_Deleted]) VALUES (3, 3, N'Tamiflu', 1, 0, 0)
INSERT [dbo].[PRESCRIPTION] ([Pre_ID], [Pre_Appt_ID], [Pre_Name], [Pre_Refills_Allowed], [Pre_Refills_Filled], [Pre_Deleted]) VALUES (4, 4, N'Loperamide ', 1, 0, 0)
INSERT [dbo].[PRESCRIPTION] ([Pre_ID], [Pre_Appt_ID], [Pre_Name], [Pre_Refills_Allowed], [Pre_Refills_Filled], [Pre_Deleted]) VALUES (5, 5, N'Bismuth Subsalicylate ', 1, 0, 0)
SET IDENTITY_INSERT [dbo].[PRESCRIPTION] OFF
ALTER TABLE [dbo].[APPOINTMENT]  WITH CHECK ADD  CONSTRAINT [FK_APPOINTMENT_DOCTOR] FOREIGN KEY([Appt_Doc_ID])
REFERENCES [dbo].[DOCTOR] ([Doc_ID])
GO
ALTER TABLE [dbo].[APPOINTMENT] CHECK CONSTRAINT [FK_APPOINTMENT_DOCTOR]
GO
ALTER TABLE [dbo].[APPOINTMENT]  WITH CHECK ADD  CONSTRAINT [FK_APPOINTMENT_OFFICE] FOREIGN KEY([Appt_Office_ID])
REFERENCES [dbo].[OFFICE] ([Off_ID])
GO
ALTER TABLE [dbo].[APPOINTMENT] CHECK CONSTRAINT [FK_APPOINTMENT_OFFICE]
GO
ALTER TABLE [dbo].[APPOINTMENT]  WITH CHECK ADD  CONSTRAINT [FK_APPOINTMENT_PATIENT] FOREIGN KEY([Appt_Pat_ID])
REFERENCES [dbo].[PATIENT] ([Pat_ID])
GO
ALTER TABLE [dbo].[APPOINTMENT] CHECK CONSTRAINT [FK_APPOINTMENT_PATIENT]
GO
ALTER TABLE [dbo].[APPROVAL]  WITH CHECK ADD  CONSTRAINT [FK_APPROVAL_DOCTOR] FOREIGN KEY([App_Doc_ID])
REFERENCES [dbo].[DOCTOR] ([Doc_ID])
GO
ALTER TABLE [dbo].[APPROVAL] CHECK CONSTRAINT [FK_APPROVAL_DOCTOR]
GO
ALTER TABLE [dbo].[APPROVAL]  WITH CHECK ADD  CONSTRAINT [FK_APPROVAL_PATIENT] FOREIGN KEY([App_Pat_ID])
REFERENCES [dbo].[PATIENT] ([Pat_ID])
GO
ALTER TABLE [dbo].[APPROVAL] CHECK CONSTRAINT [FK_APPROVAL_PATIENT]
GO
ALTER TABLE [dbo].[DIAGNOSIS]  WITH CHECK ADD  CONSTRAINT [FK_DIAGNOSIS_APPOINTMENT] FOREIGN KEY([Diag_Appt_ID])
REFERENCES [dbo].[APPOINTMENT] ([Appt_ID])
GO
ALTER TABLE [dbo].[DIAGNOSIS] CHECK CONSTRAINT [FK_DIAGNOSIS_APPOINTMENT]
GO
ALTER TABLE [dbo].[PRESCRIPTION]  WITH CHECK ADD  CONSTRAINT [FK_PRESCRIPTION_APPOINTMENT] FOREIGN KEY([Pre_Appt_ID])
REFERENCES [dbo].[APPOINTMENT] ([Appt_ID])
GO
ALTER TABLE [dbo].[PRESCRIPTION] CHECK CONSTRAINT [FK_PRESCRIPTION_APPOINTMENT]
GO
ALTER TABLE [dbo].[APPOINTMENT]  WITH CHECK ADD CHECK  (([Appt_ID]>(0)))
GO
ALTER TABLE [dbo].[APPROVAL]  WITH CHECK ADD CHECK  (([App_ID]>=(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_Hct]>(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_Hgb]>(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_MCV]>(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_Platelet_Cnt]>(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_RBC]>(0)))
GO
ALTER TABLE [dbo].[BLOOD_TEST]  WITH CHECK ADD CHECK  (([BT_WBC]>(0)))
GO
ALTER TABLE [dbo].[DIAGNOSIS]  WITH CHECK ADD CHECK  (([Diag_ID]>=(0)))
GO
ALTER TABLE [dbo].[DOCTOR]  WITH CHECK ADD CHECK  (([Doc_Addr_State]='WY' OR [Doc_Addr_State]='WV' OR [Doc_Addr_State]='WI' OR [Doc_Addr_State]='WA' OR [Doc_Addr_State]='VT' OR [Doc_Addr_State]='VA' OR [Doc_Addr_State]='UT' OR [Doc_Addr_State]='TX' OR [Doc_Addr_State]='TN' OR [Doc_Addr_State]='SD' OR [Doc_Addr_State]='SC' OR [Doc_Addr_State]='RI' OR [Doc_Addr_State]='PA' OR [Doc_Addr_State]='OR' OR [Doc_Addr_State]='OK' OR [Doc_Addr_State]='OH' OR [Doc_Addr_State]='NY' OR [Doc_Addr_State]='NV' OR [Doc_Addr_State]='NM' OR [Doc_Addr_State]='NJ' OR [Doc_Addr_State]='NH' OR [Doc_Addr_State]='NE' OR [Doc_Addr_State]='ND' OR [Doc_Addr_State]='NC' OR [Doc_Addr_State]='MT' OR [Doc_Addr_State]='MS' OR [Doc_Addr_State]='MO' OR [Doc_Addr_State]='MN' OR [Doc_Addr_State]='MI' OR [Doc_Addr_State]='ME' OR [Doc_Addr_State]='MD' OR [Doc_Addr_State]='MA' OR [Doc_Addr_State]='LA' OR [Doc_Addr_State]='KY' OR [Doc_Addr_State]='KS' OR [Doc_Addr_State]='IN' OR [Doc_Addr_State]='IL' OR [Doc_Addr_State]='ID' OR [Doc_Addr_State]='IA' OR [Doc_Addr_State]='HI' OR [Doc_Addr_State]='GA' OR [Doc_Addr_State]='FL' OR [Doc_Addr_State]='DE' OR [Doc_Addr_State]='CT' OR [Doc_Addr_State]='CO' OR [Doc_Addr_State]='CA' OR [Doc_Addr_State]='AZ' OR [Doc_Addr_State]='AR' OR [Doc_Addr_State]='AL' OR [Doc_Addr_State]='AK'))
GO
ALTER TABLE [dbo].[DOCTOR]  WITH CHECK ADD CHECK  (([Doc_Addr_Zip]>=(0) AND [Doc_Addr_Zip]<=(99999)))
GO
ALTER TABLE [dbo].[DOCTOR]  WITH CHECK ADD CHECK  (([Doc_Email] like '%@%'))
GO
ALTER TABLE [dbo].[DOCTOR]  WITH CHECK ADD CHECK  (([Doc_Gender]='F' OR [Doc_Gender]='M'))
GO
ALTER TABLE [dbo].[DOCTOR]  WITH CHECK ADD CHECK  (([Doc_ID]>(0)))
GO
ALTER TABLE [dbo].[LOGIN]  WITH CHECK ADD  CONSTRAINT [CK__LOGIN__Log_Pass__5FB337D6] CHECK  ((len([Log_Pass])>=(8)))
GO
ALTER TABLE [dbo].[LOGIN] CHECK CONSTRAINT [CK__LOGIN__Log_Pass__5FB337D6]
GO
ALTER TABLE [dbo].[LOGIN]  WITH CHECK ADD  CONSTRAINT [CK__LOGIN__Log_User___60A75C0F] CHECK  ((len([Log_User_Name])>=(5)))
GO
ALTER TABLE [dbo].[LOGIN] CHECK CONSTRAINT [CK__LOGIN__Log_User___60A75C0F]
GO
ALTER TABLE [dbo].[LOGIN]  WITH CHECK ADD  CONSTRAINT [CK__LOGIN__Log_User___619B8048] CHECK  (([Log_User_Type]='A' OR [Log_User_Type]='D' OR [Log_User_Type]='P'))
GO
ALTER TABLE [dbo].[LOGIN] CHECK CONSTRAINT [CK__LOGIN__Log_User___619B8048]
GO
ALTER TABLE [dbo].[OFFICE]  WITH CHECK ADD  CONSTRAINT [CK_OFFICE_ZIP] CHECK  (([off_addr_zip]>=(0) AND [off_addr_zip]<=(99999) AND len([off_addr_zip])=(5)))
GO
ALTER TABLE [dbo].[OFFICE] CHECK CONSTRAINT [CK_OFFICE_ZIP]
GO
ALTER TABLE [dbo].[OFFICE_ADMIN]  WITH CHECK ADD  CONSTRAINT [CK_OFFICE_ADMIN] CHECK  (([oa_addr_zip]>=(0) AND [oa_addr_zip]<=(99999) AND len([oa_addr_zip])=(5)))
GO
ALTER TABLE [dbo].[OFFICE_ADMIN] CHECK CONSTRAINT [CK_OFFICE_ADMIN]
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Addr_State]='WY' OR [Pat_Addr_State]='WV' OR [Pat_Addr_State]='WI' OR [Pat_Addr_State]='WA' OR [Pat_Addr_State]='VT' OR [Pat_Addr_State]='VA' OR [Pat_Addr_State]='UT' OR [Pat_Addr_State]='TX' OR [Pat_Addr_State]='TN' OR [Pat_Addr_State]='SD' OR [Pat_Addr_State]='SC' OR [Pat_Addr_State]='RI' OR [Pat_Addr_State]='PA' OR [Pat_Addr_State]='OR' OR [Pat_Addr_State]='OK' OR [Pat_Addr_State]='OH' OR [Pat_Addr_State]='NY' OR [Pat_Addr_State]='NV' OR [Pat_Addr_State]='NM' OR [Pat_Addr_State]='NJ' OR [Pat_Addr_State]='NH' OR [Pat_Addr_State]='NE' OR [Pat_Addr_State]='ND' OR [Pat_Addr_State]='NC' OR [Pat_Addr_State]='MT' OR [Pat_Addr_State]='MS' OR [Pat_Addr_State]='MO' OR [Pat_Addr_State]='MN' OR [Pat_Addr_State]='MI' OR [Pat_Addr_State]='ME' OR [Pat_Addr_State]='MD' OR [Pat_Addr_State]='MA' OR [Pat_Addr_State]='LA' OR [Pat_Addr_State]='KY' OR [Pat_Addr_State]='KS' OR [Pat_Addr_State]='IN' OR [Pat_Addr_State]='IL' OR [Pat_Addr_State]='ID' OR [Pat_Addr_State]='IA' OR [Pat_Addr_State]='HI' OR [Pat_Addr_State]='GA' OR [Pat_Addr_State]='FL' OR [Pat_Addr_State]='DE' OR [Pat_Addr_State]='CT' OR [Pat_Addr_State]='CO' OR [Pat_Addr_State]='CA' OR [Pat_Addr_State]='AZ' OR [Pat_Addr_State]='AR' OR [Pat_Addr_State]='AL' OR [Pat_Addr_State]='AK'))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Addr_Zip]>=(0) AND [Pat_Addr_Zip]<=(99999)))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Email] like '%@%'))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Gender]='F' OR [Pat_Gender]='M'))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Height]>(0)))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_ID]>(0)))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Phone] like '__________'))
GO
ALTER TABLE [dbo].[PATIENT]  WITH CHECK ADD CHECK  (([Pat_Weight]>(0)))
GO
ALTER TABLE [dbo].[PRESCRIPTION]  WITH CHECK ADD CHECK  (([Pre_ID]>(0)))
GO
ALTER TABLE [dbo].[PRESCRIPTION]  WITH CHECK ADD CHECK  (([Pre_Refills_Allowed]>=(0)))
GO
ALTER TABLE [dbo].[PRESCRIPTION]  WITH CHECK ADD CHECK  (([Pre_Refills_Filled]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [Clinic_DB] SET  READ_WRITE 
GO

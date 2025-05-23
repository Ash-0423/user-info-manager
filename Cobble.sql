USE [master]
GO
/****** Object:  Database [Cobble]    Script Date: 2025/5/9 18:05:01 ******/
CREATE DATABASE [Cobble]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cobble', FILENAME = N'/var/opt/mssql/data\Cobble.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Cobble_log', FILENAME = N'/var/opt/mssql/data\Cobble_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Cobble] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cobble].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cobble] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cobble] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cobble] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cobble] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cobble] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cobble] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cobble] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cobble] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cobble] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cobble] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cobble] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cobble] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cobble] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cobble] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cobble] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Cobble] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cobble] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cobble] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cobble] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cobble] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cobble] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cobble] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cobble] SET RECOVERY FULL 
GO
ALTER DATABASE [Cobble] SET  MULTI_USER 
GO
ALTER DATABASE [Cobble] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cobble] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cobble] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cobble] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Cobble] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Cobble] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Cobble', N'ON'
GO
ALTER DATABASE [Cobble] SET QUERY_STORE = ON
GO
ALTER DATABASE [Cobble] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Cobble]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
GO
/****** Object:  Table [dbo].[glb_Awards]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_Awards](
	[AwardID] [bigint] NOT NULL,
	[PostMemberID] [nchar](64) NOT NULL,
	[RespMemberID] [nchar](64) NULL,
	[Points] [int] NULL,
	[PlugIn] [varchar](3) NULL,
	[Reference] [varchar](10) NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_glb_Awards] PRIMARY KEY CLUSTERED 
(
	[AwardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_Lookups]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_Lookups](
	[LookupID] [bigint] NULL,
	[LookupSrc] [char](1) NULL,
	[LookupType] [varchar](15) NULL,
	[LookupCode] [varchar](15) NULL,
	[Description] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_Noticebrd]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_Noticebrd](
	[NoticebrdID] [bigint] NOT NULL,
	[PostMemberID] [nchar](64) NOT NULL,
	[Notice] [varchar](max) NULL,
	[PlugIn] [varchar](3) NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_glb_Noticebrd] PRIMARY KEY CLUSTERED 
(
	[NoticebrdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_SecMod]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_SecMod](
	[SecModID] [bigint] IDENTITY(1000,5) NOT NULL,
	[Module] [char](3) NOT NULL,
	[ModuleCode] [varchar](10) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[SecurityLevel] [int] NOT NULL,
 CONSTRAINT [PK_glb_SecMod] PRIMARY KEY CLUSTERED 
(
	[SecModID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_SecUser]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_SecUser](
	[SecUserID] [bigint] NOT NULL,
	[MemberID] [nchar](64) NULL,
	[SecModID] [bigint] NULL,
	[SecurityLevel] [int] NULL,
 CONSTRAINT [PK_glb_SecUser] PRIMARY KEY CLUSTERED 
(
	[SecUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_Setup]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_Setup](
	[SetupID] [bigint] IDENTITY(1000,5) NOT NULL,
	[Module] [char](3) NOT NULL,
	[AttributeKey] [varchar](50) NOT NULL,
	[AttributeValue] [varchar](50) NOT NULL,
 CONSTRAINT [PK_glb_Setup] PRIMARY KEY CLUSTERED 
(
	[SetupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glb_Users]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glb_Users](
	[MemberID] [nchar](64) NOT NULL,
	[UserName] [nvarchar](225) NOT NULL,
	[Password] [nchar](64) NOT NULL,
	[UserPoints] [int] NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_glb_Users] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hip_HiveHeader]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hip_HiveHeader](
	[HiveID] [bigint] NOT NULL,
	[MemberID] [nchar](64) NOT NULL,
	[HiveCode] [varchar](10) NULL,
	[AddressID] [bigint] NULL,
	[Supers_Cnt] [int] NULL,
	[Frames] [int] NULL,
	[QType] [nchar](10) NULL,
	[QDOB] [date] NULL,
	[QClipped] [bit] NULL,
	[QMarked] [bit] NULL,
	[Notes] [nvarchar](max) NULL,
	[PostDate] [date] NULL,
	[Images] [varbinary](max) NULL,
 CONSTRAINT [PK_hip_HiveHeader] PRIMARY KEY CLUSTERED 
(
	[HiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hip_HiveHealth]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hip_HiveHealth](
	[HealthID] [bigint] NOT NULL,
	[InspectionID] [bigint] NOT NULL,
	[Date] [date] NULL,
	[Irregularity] [int] NULL,
	[Seriousness] [int] NULL,
	[Notes] [varchar](max) NULL,
 CONSTRAINT [PK_hip_HiveHealth] PRIMARY KEY CLUSTERED 
(
	[HealthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hip_HiveInspectionDetail]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hip_HiveInspectionDetail](
	[InspectionID] [bigint] NOT NULL,
	[HiveID] [bigint] NULL,
	[InspDate] [date] NULL,
	[InspTime] [time](7) NULL,
	[Condition] [varchar](10) NULL,
	[Temperament] [varchar](10) NULL,
	[Population] [varchar](10) NULL,
	[FCnt_Honey] [int] NULL,
	[FCnt_Brood] [int] NULL,
	[FCnt_Pollen] [int] NULL,
	[FCnt_Empty] [int] NULL,
	[FCnt_Drone] [int] NULL,
	[FCon_Honey] [bigint] NULL,
	[FCon_Brood] [bigint] NULL,
	[FCon_BroodPattern] [bigint] NULL,
	[FCon_Eggs] [bigint] NULL,
	[FCon_Pollen] [bigint] NULL,
	[FCon_Empty] [bigint] NULL,
	[FCon_Drone] [bigint] NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_hip_HiveInspectionDetail] PRIMARY KEY CLUSTERED 
(
	[InspectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hip_HiveInspectionNotes]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hip_HiveInspectionNotes](
	[InspectionNoteID] [bigint] NOT NULL,
	[InspectionID] [bigint] NULL,
	[Images] [varbinary](max) NULL,
	[Notes] [varbinary](max) NULL,
 CONSTRAINT [PK_hip_HiveInspectionNotes] PRIMARY KEY CLUSTERED 
(
	[InspectionNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hip_Users]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hip_Users](
	[MemberID] [nchar](64) NOT NULL,
	[UserType] [nvarchar](20) NULL,
	[RegNo] [varchar](15) NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_hip_Users] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Course]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Course](
	[c] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Instructor]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Instructor](
	[b] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_InstructorCourseAssignment]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_InstructorCourseAssignment](
	[d] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Messages]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Messages](
	[k] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Options]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Options](
	[i] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Questions]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Questions](
	[h] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Quiz]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Quiz](
	[f] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_QuizQuestions]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_QuizQuestions](
	[l] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Result]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Result](
	[j] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_Student]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_Student](
	[a] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lms_StudentCourseAssignment]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lms_StudentCourseAssignment](
	[e] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mms_Address]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mms_Address](
	[AddressID] [bigint] IDENTITY(10,1000) NOT NULL,
	[MemberID] [nchar](64) NOT NULL,
	[AddressType] [varchar](10) NOT NULL,
	[Address1] [varchar](50) NULL,
	[Address2] [varchar](50) NULL,
	[Address3] [varchar](50) NULL,
	[City] [varchar](25) NULL,
	[PostCode] [varchar](5) NULL,
	[RegionalCouncil] [varchar](25) NULL,
	[State] [varchar](5) NULL,
	[Country] [bigint] NULL,
	[PublicPrivate] [tinyint] NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_mms_Address] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mms_Contact]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mms_Contact](
	[ContactID] [bigint] NOT NULL,
	[MemberID] [nchar](64) NOT NULL,
	[ContactType] [varchar](10) NOT NULL,
	[ContactDetail] [varchar](50) NULL,
	[Verified] [tinyint] NULL,
	[Notes] [varchar](max) NULL,
	[PublicPrivate] [tinyint] NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_mms_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mms_Members]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mms_Members](
	[MemberID] [nchar](64) NOT NULL,
	[UserName] [nchar](225) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Name_Visible] [bit] NULL,
	[Name_Last] [nvarchar](50) NULL,
	[NameLast_Visible] [bit] NULL,
	[ProfileIntroduction] [nvarchar](max) NULL,
	[Type] [nvarchar](10) NULL,
	[Status] [varchar](10) NULL,
	[UserPoints] [int] NULL,
	[PostDate] [date] NULL,
 CONSTRAINT [PK_mms_Members] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mms_Relationship]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mms_Relationship](
	[RelationshipNo] [bigint] IDENTITY(1,1000) NOT NULL,
	[MemberID_Parent] [nchar](64) NOT NULL,
	[MemberID_Child] [nchar](64) NOT NULL,
	[Notes] [varchar](max) NULL,
	[Timestamp] [datetime] NULL,
 CONSTRAINT [PK_mms_Relationship] PRIMARY KEY CLUSTERED 
(
	[RelationshipNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msb_Skills]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msb_Skills](
	[SkillsID] [bigint] NULL,
	[Industry] [nvarchar](50) NULL,
	[Domain] [nvarchar](50) NULL,
	[Dmn_Attribute] [nvarchar](100) NULL,
	[Skill] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msb_SkillsRelationship]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msb_SkillsRelationship](
	[MemberID] [nchar](64) NOT NULL,
	[SkillID] [bigint] NULL,
	[Level] [smallint] NULL,
 CONSTRAINT [PK_msb_SkillsRelationship] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qbm_QRelationship]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qbm_QRelationship](
	[QuestionaireRelationshipID] [bigint] NOT NULL,
	[QuestionaireID] [bigint] NOT NULL,
	[QuestionaireDetailID] [bigint] NOT NULL,
	[QuestionaireResponseID] [bigint] NULL,
	[MemberID] [nchar](64) NULL,
	[Notes] [varchar](max) NULL,
 CONSTRAINT [PK_qbm_QRelationship] PRIMARY KEY CLUSTERED 
(
	[QuestionaireRelationshipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qbm_QuestionaireDetails]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qbm_QuestionaireDetails](
	[QuestionaireDetailID] [bigint] NULL,
	[QuestionaireID] [bigint] NULL,
	[QuestionNumber] [varchar](10) NULL,
	[QuestionDataType] [varchar](10) NULL,
	[Question] [varchar](max) NULL,
	[Hasdependents] [bit] NULL,
	[PostScript] [varchar](max) NULL,
	[Weighting] [int] NULL,
	[Notes] [varchar](max) NULL,
	[PostDate] [timestamp] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qbm_QuestionaireResponse]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qbm_QuestionaireResponse](
	[QuestionaireResponseID] [bigint] NULL,
	[QuestionaireDetailID] [bigint] NULL,
	[ResponseNumber] [varchar](10) NULL,
	[ResponseDataType] [varchar](5) NULL,
	[Response] [varchar](max) NULL,
	[Notes] [varchar](max) NULL,
	[PostDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qbm_QuestionHeader]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qbm_QuestionHeader](
	[QuestionaireHeadID] [bigint] NULL,
	[QuestionaireTitle] [varchar](100) NULL,
	[QuestionaireNotes] [varchar](max) NULL,
	[QuestionaireStatus] [varchar](10) NULL,
	[Notes] [varchar](max) NULL,
	[PostDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[qbm_Setup]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[qbm_Setup](
	[SetupID] [bigint] NULL,
	[TabID] [nchar](10) NULL,
	[Visible] [bit] NULL,
	[Notes] [varchar](max) NULL,
	[PostDate] [nchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 2025/5/9 18:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
 CONSTRAINT [PK__sysdiagr__C2B05B61D6FC1060] PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10000, N'S', N'Country', N'AU', N'Australia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10005, N'S', N'Country', N'NZ', N'New Zealand')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10010, N'S', N'Country', N'AF', N'Afghanistan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10015, N'S', N'Country', N'AX', N'Aland Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10020, N'S', N'Country', N'AL', N'Albania')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10025, N'S', N'Country', N'DZ', N'Algeria')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10030, N'S', N'Country', N'AS', N'American Samoa')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10035, N'S', N'Country', N'AD', N'Andorra')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10040, N'S', N'Country', N'AO', N'Angola')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10045, N'S', N'Country', N'AI', N'Anguilla')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10050, N'S', N'Country', N'AQ', N'Antarctica')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10055, N'S', N'Country', N'AG', N'Antigua and Barbuda')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10060, N'S', N'Country', N'AR', N'Argentina')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10065, N'S', N'Country', N'AM', N'Armenia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10070, N'S', N'Country', N'AW', N'Aruba')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10075, N'S', N'Country', N'AT', N'Austria')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10080, N'S', N'Country', N'AZ', N'Azerbaijan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10085, N'S', N'Country', N'BS', N'Bahamas')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10090, N'S', N'Country', N'BH', N'Bahrain')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10095, N'S', N'Country', N'BD', N'Bangladesh')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10100, N'S', N'Country', N'BB', N'Barbados')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10105, N'S', N'Country', N'BY', N'Belarus')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10110, N'S', N'Country', N'BE', N'Belgium')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10115, N'S', N'Country', N'BZ', N'Belize')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10120, N'S', N'Country', N'BJ', N'Benin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10125, N'S', N'Country', N'BM', N'Bermuda')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10130, N'S', N'Country', N'BT', N'Bhutan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10135, N'S', N'Country', N'BO', N'Bolivia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10140, N'S', N'Country', N'BQ', N'Bonaire')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10145, N'S', N'Country', N'BA', N'Bosnia and Herzegovina')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10150, N'S', N'Country', N'BW', N'Botswana')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10155, N'S', N'Country', N'BV', N'Bouvet Island')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10160, N'S', N'Country', N'BR', N'Brazil')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10165, N'S', N'Country', N'BN', N'Brunei Darussalam')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10170, N'S', N'Country', N'BG', N'Bulgaria')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10175, N'S', N'Country', N'BF', N'Burma')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10180, N'S', N'Country', N'BI', N'Burundi')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10185, N'S', N'Country', N'CV', N'Cabo Verde')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10190, N'S', N'Country', N'KH', N'Cambodia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10195, N'S', N'Country', N'CM', N'Cameroon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10200, N'S', N'Country', N'CA', N'Canada')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10205, N'S', N'Country', N'KY', N'Cayman Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10210, N'S', N'Country', N'CF', N'Central African Republic')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10215, N'S', N'Country', N'TD', N'Chad')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10220, N'S', N'Country', N'CL', N'Chile')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10225, N'S', N'Country', N'CN', N'China')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10230, N'S', N'Country', N'CX', N'Christmas Island')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10235, N'S', N'Country', N'CC', N'Cocos (Keeling) Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10240, N'S', N'Country', N'CO', N'Colombia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10245, N'S', N'Country', N'KM', N'Comoros')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10250, N'S', N'Country', N'CK', N'Cook Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10255, N'S', N'Country', N'CR', N'Costa Rica')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10260, N'S', N'Country', N'HR', N'Croatia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10265, N'S', N'Country', N'CU', N'Cuba')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10270, N'S', N'Country', N'CW', N'Curaçao')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10275, N'S', N'Country', N'CY', N'Cyprus')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10280, N'S', N'Country', N'CZ', N'Czechia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10285, N'S', N'Country', N'CI', N'Cote d''Ivoire')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10290, N'S', N'Country', N'DK', N'Denmark')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10295, N'S', N'Country', N'DJ', N'Djibouti')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10300, N'S', N'Country', N'DM', N'Dominica')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10305, N'S', N'Country', N'DO', N'Dominican Republic')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10310, N'S', N'Country', N'EC', N'Ecuador')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10315, N'S', N'Country', N'EG', N'Egypt')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10320, N'S', N'Country', N'SV', N'El Salvador')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10325, N'S', N'Country', N'GQ', N'Equatorial Guinea')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10330, N'S', N'Country', N'ER', N'Eritrea')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10335, N'S', N'Country', N'EE', N'Estonia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10340, N'S', N'Country', N'SZ', N'Eswatini?[k]')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10345, N'S', N'Country', N'ET', N'Ethiopia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10350, N'S', N'Country', N'FK', N'Falkland Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10355, N'S', N'Country', N'FO', N'Faroe Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10360, N'S', N'Country', N'FJ', N'Fiji')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10365, N'S', N'Country', N'FI', N'Finland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10370, N'S', N'Country', N'FR', N'France?[m]')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10375, N'S', N'Country', N'GF', N'French Guiana')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10380, N'S', N'Country', N'PF', N'French Polynesia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10385, N'S', N'Country', N'TF', N'French Sourn Territories')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10390, N'S', N'Country', N'GA', N'Gabon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10395, N'S', N'Country', N'GM', N'Gambia ')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10400, N'S', N'Country', N'GE', N'Georgia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10405, N'S', N'Country', N'DE', N'Germany')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10410, N'S', N'Country', N'GH', N'Ghana')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10415, N'S', N'Country', N'GI', N'Gibraltar')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10420, N'S', N'Country', N'GR', N'Greece')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10425, N'S', N'Country', N'GL', N'Greenland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10430, N'S', N'Country', N'GD', N'Grenada')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10435, N'S', N'Country', N'GP', N'Guadeloupe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10440, N'S', N'Country', N'GU', N'Guam')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10445, N'S', N'Country', N'GT', N'Guatemala')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10450, N'S', N'Country', N'GG', N'Guernsey')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10455, N'S', N'Country', N'GN', N'Guinea')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10460, N'S', N'Country', N'GW', N'Guinea-Bissau')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10465, N'S', N'Country', N'GY', N'Guyana')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10470, N'S', N'Country', N'HT', N'Haiti')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10475, N'S', N'Country', N'HM', N'Heard Island and McDonald Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10480, N'S', N'Country', N'HN', N'Honduras')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10485, N'S', N'Country', N'HK', N'Hong Kong')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10490, N'S', N'Country', N'HU', N'Hungary')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10495, N'S', N'Country', N'IS', N'Iceland')
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10500, N'S', N'Country', N'IN', N'India')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10505, N'S', N'Country', N'ID', N'Indonesia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10510, N'S', N'Country', N'IR', N'Iran')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10515, N'S', N'Country', N'IQ', N'Iraq')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10520, N'S', N'Country', N'IE', N'Ireland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10525, N'S', N'Country', N'IM', N'Isle of Man')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10530, N'S', N'Country', N'IL', N'Israel')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10535, N'S', N'Country', N'IT', N'Italy')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10540, N'S', N'Country', N'JM', N'Jamaica')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10545, N'S', N'Country', N'JP', N'Japan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10550, N'S', N'Country', N'JE', N'Jersey')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10555, N'S', N'Country', N'JO', N'Jordan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10560, N'S', N'Country', N'KZ', N'Kazakhstan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10565, N'S', N'Country', N'KE', N'Kenya')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10570, N'S', N'Country', N'KI', N'Kiribati')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10575, N'S', N'Country', N'KP', N'Korea ( Democratic People''s Republic of)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10580, N'S', N'Country', N'KR', N'Korea ( Republic of)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10585, N'S', N'Country', N'KW', N'Kuwait')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10590, N'S', N'Country', N'KG', N'Kyrgyzstan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10595, N'S', N'Country', N'LA', N'Lao People''s Democratic Republic')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10600, N'S', N'Country', N'LV', N'Latvia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10605, N'S', N'Country', N'LB', N'Lebanon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10610, N'S', N'Country', N'LS', N'Lesotho')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10615, N'S', N'Country', N'LR', N'Liberia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10620, N'S', N'Country', N'LY', N'Libya')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10625, N'S', N'Country', N'LI', N'Liechtenstein')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10630, N'S', N'Country', N'LT', N'Lithuania')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10635, N'S', N'Country', N'LU', N'Luxembourg')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10640, N'S', N'Country', N'MO', N'Macao')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10645, N'S', N'Country', N'MG', N'Madagascar')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10650, N'S', N'Country', N'MW', N'Malawi')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10655, N'S', N'Country', N'MY', N'Malaysia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10660, N'S', N'Country', N'MV', N'Maldives')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10665, N'S', N'Country', N'ML', N'Mali')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10670, N'S', N'Country', N'MT', N'Malta')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10675, N'S', N'Country', N'MH', N'Marshall Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10680, N'S', N'Country', N'MQ', N'Martinique')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10685, N'S', N'Country', N'MR', N'Mauritania')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10690, N'S', N'Country', N'MU', N'Mauritius')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10695, N'S', N'Country', N'YT', N'Mayotte')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10700, N'S', N'Country', N'MX', N'Mexico')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10705, N'S', N'Country', N'FM', N'Micronesia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10710, N'S', N'Country', N'MD', N'Moldova')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10715, N'S', N'Country', N'MC', N'Monaco')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10720, N'S', N'Country', N'MN', N'Mongolia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10725, N'S', N'Country', N'ME', N'Montenegro')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10730, N'S', N'Country', N'MS', N'Montserrat')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10735, N'S', N'Country', N'MA', N'Morocco')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10740, N'S', N'Country', N'MZ', N'Mozambique')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10745, N'S', N'Country', N'MM', N'Myanmar?')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10750, N'S', N'Country', N'NA', N'Namibia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10755, N'S', N'Country', N'NR', N'Nauru')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10760, N'S', N'Country', N'NP', N'Nepal')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10765, N'S', N'Country', N'NC', N'New Caledonia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10770, N'S', N'Country', N'NI', N'Nicaragua')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10775, N'S', N'Country', N'NE', N'Niger')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10780, N'S', N'Country', N'NG', N'Nigeria')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10785, N'S', N'Country', N'NU', N'Niue')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10790, N'S', N'Country', N'NF', N'Norfolk Island')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10795, N'S', N'Country', N'MK', N'North Macedonia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10800, N'S', N'Country', N'MP', N'Norrn Mariana Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10805, N'S', N'Country', N'NO', N'Norway')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10810, N'S', N'Country', N'OM', N'Oman')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10815, N'S', N'Country', N'PK', N'Pakistan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10820, N'S', N'Country', N'PW', N'Palau')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10825, N'S', N'Country', N'PA', N'Panama')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10830, N'S', N'Country', N'PG', N'Papua New Guinea')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10835, N'S', N'Country', N'PY', N'Paraguay')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10840, N'S', N'Country', N'PE', N'Peru')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10845, N'S', N'Country', N'PH', N'Philippines')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10850, N'S', N'Country', N'PN', N'Pitcairn?')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10855, N'S', N'Country', N'PL', N'Poland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10860, N'S', N'Country', N'PT', N'Portugal')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10865, N'S', N'Country', N'PR', N'Puerto Rico')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10870, N'S', N'Country', N'QA', N'Qatar')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10875, N'S', N'Country', N'RO', N'Romania')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10880, N'S', N'Country', N'RU', N'Russian Federation')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10885, N'S', N'Country', N'RW', N'Rwanda')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10890, N'S', N'Country', N'RE', N'Reunion')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10895, N'S', N'Country', N'BL', N'Saint Barthelemy')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10900, N'S', N'Country', N'SH', N'Saint Helena')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10905, N'S', N'Country', N'KN', N'Saint Kitts and Nevis')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10910, N'S', N'Country', N'LC', N'Saint Lucia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10915, N'S', N'Country', N'MF', N'Saint Martin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10920, N'S', N'Country', N'PM', N'Saint Pierre and Miquelon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10925, N'S', N'Country', N'VC', N'Saint Vincent and Grenadines')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10930, N'S', N'Country', N'WS', N'Samoa')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10935, N'S', N'Country', N'SM', N'San Marino')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10940, N'S', N'Country', N'ST', N'Sao Tome and Principe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10945, N'S', N'Country', N'SA', N'Saudi Arabia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10950, N'S', N'Country', N'SN', N'Senegal')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10955, N'S', N'Country', N'RS', N'Serbia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10960, N'S', N'Country', N'SC', N'Seychelles')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10965, N'S', N'Country', N'SL', N'Sierra Leone')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10970, N'S', N'Country', N'SG', N'Singapore')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10975, N'S', N'Country', N'SX', N'Sint Maarten')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10980, N'S', N'Country', N'SK', N'Slovakia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10985, N'S', N'Country', N'SI', N'Slovenia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10990, N'S', N'Country', N'SB', N'Solomon Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (10995, N'S', N'Country', N'SO', N'Somalia')
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11000, N'S', N'Country', N'ZA', N'South Africa')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11005, N'S', N'Country', N'GS', N'South Georgia and South Sandwich Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11010, N'S', N'Country', N'SS', N'South Sudan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11015, N'S', N'Country', N'ES', N'Spain')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11020, N'S', N'Country', N'LK', N'Sri Lanka')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11025, N'S', N'Country', N'SD', N'Sudan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11030, N'S', N'Country', N'SR', N'Suriname')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11035, N'S', N'Country', N'SJ', N'Svalbard')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11040, N'S', N'Country', N'SE', N'Sweden')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11045, N'S', N'Country', N'CH', N'Switzerland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11050, N'S', N'Country', N'SY', N'Syrian Arab Republic')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11055, N'S', N'Country', N'TW', N'Taiwan?')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11060, N'S', N'Country', N'TJ', N'Tajikistan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11065, N'S', N'Country', N'TH', N'Thailand')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11070, N'S', N'Country', N'TL', N'Timor-Leste')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11075, N'S', N'Country', N'TG', N'Togo')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11080, N'S', N'Country', N'TK', N'Tokelau')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11085, N'S', N'Country', N'TO', N'Tonga')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11090, N'S', N'Country', N'TT', N'Trinidad and Tobago')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11095, N'S', N'Country', N'TN', N'Tunisia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11100, N'S', N'Country', N'TM', N'Turkmenistan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11105, N'S', N'Country', N'TC', N'Turks and Caicos Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11110, N'S', N'Country', N'TV', N'Tuvalu')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11115, N'S', N'Country', N'TR', N'Turkiye')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11120, N'S', N'Country', N'UG', N'Uganda')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11125, N'S', N'Country', N'UA', N'Ukraine')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11130, N'S', N'Country', N'AE', N'United Arab Emirates ')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11135, N'S', N'Country', N'GB', N'United Kingdom of Great Britain and Norrn Ireland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11140, N'S', N'Country', N'UM', N'United States Minor Outlying Islands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11145, N'S', N'Country', N'US', N'United States of America')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11150, N'S', N'Country', N'UY', N'Uruguay')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11155, N'S', N'Country', N'UZ', N'Uzbekistan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11160, N'S', N'Country', N'VU', N'Vanuatu')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11165, N'S', N'Country', N'VE', N'Venezuela (Bolivarian Republic of)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11170, N'S', N'Country', N'VN', N'Viet Nam?')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11175, N'S', N'Country', N'IO', N'Virgin Islands (British)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11180, N'S', N'Country', N'VG', N'Virgin Islands (British)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11185, N'S', N'Country', N'VI', N'Virgin Islands (U.S.)')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11190, N'S', N'Country', N'WF', N'Wallis and Futuna')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11195, N'S', N'Country', N'EH', N'Western Sahara?')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11200, N'S', N'Country', N'YE', N'Yemen')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11205, N'S', N'Country', N'ZM', N'Zambia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11210, N'S', N'Country', N'ZW', N'Zimbabwe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11215, N'S', N'Country', N'TZ', N'Tanzania')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11220, N'S', N'MemberType', N'ORG', N'Organisation')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11225, N'S', N'MemberType', N'UNT', N'Organisation Unit')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11230, N'S', N'MemberType', N'TEM', N'Team')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11235, N'S', N'MemberType', N'MBR', N'Individual Member')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11240, N'S', N'ContactType', N'MB1', N'Mobile 1')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11245, N'S', N'ContactType', N'MB2', N'Mobile 2')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11250, N'S', N'ContactType', N'BS1', N'Business 1')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11255, N'S', N'ContactType', N'BS2', N'Business 2')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11260, N'S', N'ContactType', N'PV1', N'Private 1')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11265, N'S', N'ContactType', N'PV2', N'Private 2')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11270, N'S', N'ContactType', N'HME', N'Home')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11275, N'S', N'AddressType', N'PST', N'Postal')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11280, N'S', N'AddressType', N'POB', N'P.O.Box')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11285, N'S', N'AddressType', N'BS1', N'Business 1')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11290, N'S', N'AddressType', N'BS2', N'Business 2')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11295, N'S', N'AddressType', N'OTH', N'Other')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11300, N'S', N'AddressType', N'IT2', N'Other 2')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11305, N'S', N'UserType', N'UT1', N'Hobbiest')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11310, N'S', N'UserType', N'UT2', N'Professional')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11315, N'S', N'UserType', N'UT3', N'Breeder')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11320, N'S', N'UserType', N'UT4', N'Vendor')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11325, N'S', N'Queen_Type', N'Q1', N'IT')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11330, N'S', N'Queen_Type', N'Q2', N'CA')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11335, N'S', N'Queen_Type', N'Q3', N'EU')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11340, N'S', N'Queen_Type', N'Q4', N'OT')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11345, N'S', N'YN', N'Y', N'Y')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11350, N'S', N'YN', N'N', N'N')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11355, N'S', N'Population', N'POP1', N'Low')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11360, N'S', N'Population', N'POP2', N'Nml')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11365, N'S', N'Population', N'POP3', N'Crowded')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11370, N'S', N'HAL', N'HAL1', N'High')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11375, N'S', N'HAL', N'HAL2', N'Ave')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11380, N'S', N'HAL', N'HAL3', N'Low')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11385, N'S', N'Hdesease', N'HD1', N'HB')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11390, N'S', N'Hdesease', N'HD2', N'MTH')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11395, N'S', N'Hdesease', N'HD3', N'Mold')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11400, N'S', N'Hdesease', N'HD4', N'Other')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11405, N'S', N'Hdesease', N'HD5', N'Other')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11410, N'S', N'Councils', N'ACT', N'ACT')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11415, N'S', N'Councils', N'NSW', N'Woollahra')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11420, N'S', N'Councils', N'NSW', N'Yass Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11425, N'S', N'Councils', N'NSW', N'Albury city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11430, N'S', N'Councils', N'NSW', N'Armidale Regional')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11435, N'S', N'Councils', N'NSW', N'Ballina')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11440, N'S', N'Councils', N'NSW', N'Balranald')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11445, N'S', N'Councils', N'NSW', N'Bathurst Regional')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11450, N'S', N'Councils', N'NSW', N'Bega Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11455, N'S', N'Councils', N'NSW', N'Bellingen')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11460, N'S', N'Councils', N'NSW', N'Blacktown city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11465, N'S', N'Councils', N'NSW', N'Bland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11470, N'S', N'Councils', N'NSW', N'Blue Mountains city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11475, N'S', N'Councils', N'NSW', N'Broken Hill city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11480, N'S', N'Councils', N'NSW', N'Byron')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11485, N'S', N'Councils', N'NSW', N'Cabonne')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11490, N'S', N'Councils', N'NSW', N'Campbelltown city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11495, N'S', N'Councils', N'NSW', N'Canada Bay')
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11500, N'S', N'Councils', N'NSW', N'Canterbury-Bankstown')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11505, N'S', N'Councils', N'NSW', N'Carrathool')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11510, N'S', N'Councils', N'NSW', N'Central Coast city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11515, N'S', N'Councils', N'NSW', N'Cessnock city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11520, N'S', N'Councils', N'NSW', N'Cobar')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11525, N'S', N'Councils', N'NSW', N'Coffs Harbour city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11530, N'S', N'Councils', N'NSW', N'Cumberland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11535, N'S', N'Councils', N'NSW', N'Dungog')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11540, N'S', N'Councils', N'NSW', N'Edward River')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11545, N'S', N'Councils', N'NSW', N'Eurobodalla')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11550, N'S', N'Councils', N'NSW', N'Fairfield city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11555, N'S', N'Councils', N'NSW', N'Federation')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11560, N'S', N'Councils', N'NSW', N'Gunnedah')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11565, N'S', N'Councils', N'NSW', N'Gwydir')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11570, N'S', N'Councils', N'NSW', N'Hunters Hill')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11575, N'S', N'Councils', N'NSW', N'Inner West')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11580, N'S', N'Councils', N'NSW', N'Kyogle')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11585, N'S', N'Councils', N'NSW', N'Lachlan')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11590, N'S', N'Councils', N'NSW', N'Lithgow city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11595, N'S', N'Councils', N'NSW', N'Liverpool city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11600, N'S', N'Councils', N'NSW', N'Moree Plains')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11605, N'S', N'Councils', N'NSW', N'Mosman')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11610, N'S', N'Councils', N'NSW', N'Murray River')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11615, N'S', N'Councils', N'NSW', N'North Sydney')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11620, N'S', N'Councils', N'NSW', N'Northern Beaches')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11625, N'S', N'Councils', N'NSW', N'Parramatta city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11630, N'S', N'Councils', N'NSW', N'Snowy Monaro Regional')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11635, N'S', N'Councils', N'NSW', N'Strathfield')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11640, N'S', N'Councils', N'NSW', N'Sydney city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11645, N'S', N'Councils', N'NSW', N'Tamworth Regional')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11650, N'S', N'Councils', N'NSW', N'Upper Hunter Shire')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11655, N'S', N'Councils', N'NSW', N'Weddin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11660, N'S', N'Councils', N'NSW', N'Wollondilly')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11665, N'S', N'Councils', N'NSW', N'Wollongong city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11670, N'S', N'Councils', N'NT', N'Barkly')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11675, N'S', N'Councils', N'NT', N'Central Desert')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11680, N'S', N'Councils', N'NT', N'Coomalie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11685, N'S', N'Councils', N'NT', N'Darwin city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11690, N'S', N'Councils', N'NT', N'East Arnhem')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11695, N'S', N'Councils', N'NT', N'MacDonnell')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11700, N'S', N'Councils', N'NT', N'Wagait')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11705, N'S', N'Councils', N'NT', N'West Daly')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11710, N'S', N'Councils', N'NT', N'Alice Springs')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11715, N'S', N'Councils', N'SA', N'Adelaide city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11720, N'S', N'Councils', N'SA', N'Adelaide Hills')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11725, N'S', N'Councils', N'SA', N'Alexandrina')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11730, N'S', N'Councils', N'SA', N'Barossa')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11735, N'S', N'Councils', N'SA', N'Barunga West')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11740, N'S', N'Councils', N'SA', N'Berri and Barmera')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11745, N'S', N'Councils', N'SA', N'Burnside city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11750, N'S', N'Councils', N'SA', N'Campbelltown city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11755, N'S', N'Councils', N'SA', N'Charles Sturt city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11760, N'S', N'Councils', N'SA', N'Clare and Gilbert Valleys')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11765, N'S', N'Councils', N'SA', N'Cleve')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11770, N'S', N'Councils', N'SA', N'Goyder')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11775, N'S', N'Councils', N'SA', N'Loxton Waikerie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11780, N'S', N'Councils', N'SA', N'Playford city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11785, N'S', N'Councils', N'SA', N'Salisbury city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11790, N'S', N'Councils', N'SA', N'Unley city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11795, N'S', N'Councils', N'SA', N'Yorke Peninsula')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11800, N'S', N'Councils', N'TAS', N'Burnie city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11805, N'S', N'Councils', N'TAS', N'Central Coast')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11810, N'S', N'Councils', N'TAS', N'Circular Head')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11815, N'S', N'Councils', N'TAS', N'Clarence city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11820, N'S', N'Councils', N'TAS', N'Derwent Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11825, N'S', N'Councils', N'TAS', N'Devonport city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11830, N'S', N'Councils', N'TAS', N'Dorset')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11835, N'S', N'Councils', N'TAS', N'Hobart city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11840, N'S', N'Councils', N'TAS', N'Huon Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11845, N'S', N'Councils', N'TAS', N'Northern Midlands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11850, N'S', N'Councils', N'TAS', N'Sorell')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11855, N'S', N'Councils', N'TAS', N'Southern Midlands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11860, N'S', N'Councils', N'TAS', N'West Coast')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11865, N'S', N'Councils', N'TAS', N'West Tamar')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11870, N'S', N'Councils', N'VIC', N'Alpine')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11875, N'S', N'Councils', N'VIC', N'Ararat')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11880, N'S', N'Councils', N'VIC', N'Ballarat city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11885, N'S', N'Councils', N'VIC', N'Banyule city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11890, N'S', N'Councils', N'VIC', N'Bass Coast')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11895, N'S', N'Councils', N'VIC', N'Baw Baw')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11900, N'S', N'Councils', N'VIC', N'Bayside city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11905, N'S', N'Councils', N'VIC', N'Benalla')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11910, N'S', N'Councils', N'VIC', N'Boroondara city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11915, N'S', N'Councils', N'VIC', N'Brimbank city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11920, N'S', N'Councils', N'VIC', N'Campaspe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11925, N'S', N'Councils', N'VIC', N'Cardinia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11930, N'S', N'Councils', N'VIC', N'Casey city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11935, N'S', N'Councils', N'VIC', N'Colac-Otway')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11940, N'S', N'Councils', N'VIC', N'Corangamite')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11945, N'S', N'Councils', N'VIC', N'East Gippsland')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11950, N'S', N'Councils', N'VIC', N'Frankston city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11955, N'S', N'Councils', N'VIC', N'Gannawarra')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11960, N'S', N'Councils', N'VIC', N'Glen Eira city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11965, N'S', N'Councils', N'VIC', N'Golden Plains')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11970, N'S', N'Councils', N'VIC', N'Greater Bendigo city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11975, N'S', N'Councils', N'VIC', N'Greater Dandenong city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11980, N'S', N'Councils', N'VIC', N'Greater Geelong city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11985, N'S', N'Councils', N'VIC', N'Greater Shepparton city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11990, N'S', N'Councils', N'VIC', N'Hepburn')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (11995, N'S', N'Councils', N'VIC', N'Indigo')
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12000, N'S', N'Councils', N'VIC', N'Kingston city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12005, N'S', N'Councils', N'VIC', N'Loddon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12010, N'S', N'Councils', N'VIC', N'Macedon Ranges')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12015, N'S', N'Councils', N'VIC', N'Maroondah city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12020, N'S', N'Councils', N'VIC', N'Melbourne city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12025, N'S', N'Councils', N'VIC', N'Mildura')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12030, N'S', N'Councils', N'VIC', N'Mitchell')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12035, N'S', N'Councils', N'VIC', N'Port Phillip city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12040, N'S', N'Councils', N'VIC', N'Queenscliffe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12045, N'S', N'Councils', N'VIC', N'Strathbogie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12050, N'S', N'Councils', N'VIC', N'Wellington')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12055, N'S', N'Councils', N'VIC', N'Wodonga city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12060, N'S', N'Councils', N'VIC', N'Wyndham city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12065, N'S', N'Councils', N'VIC', N'Yarra city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12070, N'S', N'Councils', N'WA', N'Albany city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12075, N'S', N'Councils', N'WA', N'Armadale city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12080, N'S', N'Councils', N'WA', N'Ashburton')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12085, N'S', N'Councils', N'WA', N'Augusta-Margaret River')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12090, N'S', N'Councils', N'WA', N'Bassendean')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12095, N'S', N'Councils', N'WA', N'Bayswater city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12100, N'S', N'Councils', N'WA', N'Beverley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12105, N'S', N'Councils', N'WA', N'Boddington')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12110, N'S', N'Councils', N'WA', N'Brookton')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12115, N'S', N'Councils', N'WA', N'Broome')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12120, N'S', N'Councils', N'WA', N'Bruce Rock')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12125, N'S', N'Councils', N'WA', N'Busselton city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12130, N'S', N'Councils', N'WA', N'Cambridge')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12135, N'S', N'Councils', N'WA', N'Capel')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12140, N'S', N'Councils', N'WA', N'Carnarvon')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12145, N'S', N'Councils', N'WA', N'Chapman Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12150, N'S', N'Councils', N'WA', N'Chittering')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12155, N'S', N'Councils', N'WA', N'Claremont')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12160, N'S', N'Councils', N'WA', N'Cockburn city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12165, N'S', N'Councils', N'WA', N'Collie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12170, N'S', N'Councils', N'WA', N'Coolgardie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12175, N'S', N'Councils', N'WA', N'Coorow')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12180, N'S', N'Councils', N'WA', N'Corrigin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12185, N'S', N'Councils', N'WA', N'Cottesloe')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12190, N'S', N'Councils', N'WA', N'Cranbrook')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12195, N'S', N'Councils', N'WA', N'Cuballing')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12200, N'S', N'Councils', N'WA', N'Donnybrook-Balingup')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12205, N'S', N'Councils', N'WA', N'Dundas')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12210, N'S', N'Councils', N'WA', N'Fremantle city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12215, N'S', N'Councils', N'WA', N'Harvey')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12220, N'S', N'Councils', N'WA', N'Jerramungup')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12225, N'S', N'Councils', N'WA', N'Joondalup city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12230, N'S', N'Councils', N'WA', N'Kent')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12235, N'S', N'Councils', N'WA', N'Koorda')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12240, N'S', N'Councils', N'WA', N'Peppermint Grove')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12245, N'S', N'Councils', N'WA', N'Perenjori')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12250, N'S', N'Councils', N'WA', N'Rockingham city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12255, N'S', N'Councils', N'WA', N'Serpentine-Jarrahdale')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12260, N'S', N'Councils', N'WA', N'Swan city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12265, N'S', N'Councils', N'WA', N'Wanneroo city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12270, N'S', N'Councils', N'WA', N'Wickepin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12275, N'S', N'Councils', N'WA', N'York')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12280, N'S', N'Councils', N'QLD', N'Barcoo')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12285, N'S', N'Councils', N'QLD', N'Boulia')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12290, N'S', N'Councils', N'QLD', N'Brisbane city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12295, N'S', N'Councils', N'QLD', N'Burdekin')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12300, N'S', N'Councils', N'QLD', N'Cairns')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12305, N'S', N'Councils', N'QLD', N'Cassowary Coast')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12310, N'S', N'Councils', N'QLD', N'Central Highlands')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12315, N'S', N'Councils', N'QLD', N'Charters Towers')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12320, N'S', N'Councils', N'QLD', N'Cook')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12325, N'S', N'Councils', N'QLD', N'Doomadgee')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12330, N'S', N'Councils', N'QLD', N'Douglas')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12335, N'S', N'Councils', N'QLD', N'Etheridge')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12340, N'S', N'Councils', N'QLD', N'Flinders')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12345, N'S', N'Councils', N'QLD', N'Fraser Coast')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12350, N'S', N'Councils', N'QLD', N'Gladstone')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12355, N'S', N'Councils', N'QLD', N'Gold Coast city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12360, N'S', N'Councils', N'QLD', N'Gympie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12365, N'S', N'Councils', N'QLD', N'Ipswich city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12370, N'S', N'Councils', N'QLD', N'Isaac')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12375, N'S', N'Councils', N'QLD', N'Livingstone')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12380, N'S', N'Councils', N'QLD', N'Lockyer Valley')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12385, N'S', N'Councils', N'QLD', N'Logan city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12390, N'S', N'Councils', N'QLD', N'Mareeba')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12395, N'S', N'Councils', N'QLD', N'Moreton Bay')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12400, N'S', N'Councils', N'QLD', N'Paroo')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12405, N'S', N'Councils', N'QLD', N'Quilpie')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12410, N'S', N'Councils', N'QLD', N'Redland city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12415, N'S', N'Councils', N'QLD', N'Toowoomba')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12420, N'S', N'Councils', N'QLD', N'Torres')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12425, N'S', N'Councils', N'QLD', N'Townsville city')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12430, N'S', N'Councils', N'QLD', N'Western Downs')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12435, N'S', N'Councils', N'QLD', N'Whitsunday')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12440, N'S', N'Councils', N'QLD', N'Yarrabah')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12445, N'S', N'OrgType', N'ORG', N'Organisation')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12450, N'S', N'OrgType', N'Unit', N'Organisational Unit')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12455, N'S', N'OrgType', N'Team', N'Team ')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12460, N'S', N'OrgType', N'Memb', N'Member')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12465, N'S', N'Status', N'Status', N'Archived')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12470, N'S', N'Status', N'Status', N'Active')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (12475, N'S', N'Status', N'Status', N'Read')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62465, N'S', N'Module', N'glb', N'Global Platform')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62475, N'S', N'Module', N'mms', N'Membership Management')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62480, N'S', N'Module', N'mnb', N'Noticeboard Managment')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62485, N'S', N'Module', N'msb', N'SkillsBuilder')
GO
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62490, N'S', N'Module', N'mtb', N'TeamBuilder')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62495, N'S', N'Module', N'mpb', N'ProfileBuilder')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62500, N'S', N'Module', N'hip', N'HiveInspection')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62505, N'S', N'Module', N'qbm', N'QueryBuilder')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62510, N'S', N'Module', N'dfm', N'Discussion Forum')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62515, N'S', N'Module', N'fim', N'Flora Identification')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62520, N'S', N'Module', N'olm', N'Online Learning')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62525, N'S', N'Module', N'mob', N'Mobile Platform')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62530, N'S', N'Module', N'tbd', N'** Future use ***')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62535, N'S', N'Module', N'tbd', N'** Future use ***')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62540, N'S', N'Module', N'tbd', N'** Future use ***')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62545, N'S', N'AddressType', N'AP01', N'Apiary 01')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62550, N'S', N'AddressType', N'AP02', N'Apiary 02')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62555, N'S', N'AddressType', N'AP03', N'Apiary 03')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62560, N'S', N'AddressType', N'AP04', N'Apiary 04')
INSERT [dbo].[glb_Lookups] ([LookupID], [LookupSrc], [LookupType], [LookupCode], [Description]) VALUES (62565, N'S', N'AddressType', N'AP05', N'Apiary 05')
GO
SET IDENTITY_INSERT [dbo].[glb_SecMod] ON 

INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1000, N'glb', N'01', N'Module Setup Menu', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1005, N'glb', N'0101', N'Module defaults', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1010, N'glb', N'0102', N'Tab Security', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1015, N'glb', N'0103', N'User Security', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1020, N'mms', N'01', N'Module Setup Menu', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1025, N'mms', N'0101', N'Module defaults', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1030, N'mms', N'0102', N'Tab Security', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1035, N'mms', N'0103', N'User Security', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1040, N'mms', N'02', N'Member Details Menu', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1045, N'mms', N'0201', N'Member Details', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1050, N'mms', N'0202', N'Contact Details', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1055, N'mms', N'03', N'Relationship Menu', 7)
INSERT [dbo].[glb_SecMod] ([SecModID], [Module], [ModuleCode], [Description], [SecurityLevel]) VALUES (1060, N'mms', N'0301', N'Relationship Details', 7)
SET IDENTITY_INSERT [dbo].[glb_SecMod] OFF
GO
SET IDENTITY_INSERT [dbo].[glb_Setup] ON 

INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1000, N'glb', N'NoticeBrdDays', N'7')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1005, N'glb', N'Prefix', N'glb')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1010, N'olm', N'Prefix', N'olm
')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1015, N'dfm', N'Prefix', N'dfm')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1020, N'fim', N'Prefix', N'fim')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1025, N'hip', N'Prefix', N'hip')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1030, N'mms', N'Prefix', N'mms')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1035, N'qbm', N'Prefix', N'qbm')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1040, N'smi', N'Prefix', N'smi')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1045, N'msb', N'Prefix', N'msb')
INSERT [dbo].[glb_Setup] ([SetupID], [Module], [AttributeKey], [AttributeValue]) VALUES (1050, N'mms', N'NoticeBrdDays', N'7')
SET IDENTITY_INSERT [dbo].[glb_Setup] OFF
GO
INSERT [dbo].[mms_Contact] ([ContactID], [MemberID], [ContactType], [ContactDetail], [Verified], [Notes], [PublicPrivate], [PostDate]) VALUES (2, N'QoImac76nJa9MMt7pAD2llUQBE92sLttjoOxuLal3H9BOAZ52vaHWavE43vRpd29', N'Email', N'n11753331@qut.edu.au', 0, N'ibS2a9', NULL, CAST(N'2025-05-08' AS Date))
INSERT [dbo].[mms_Contact] ([ContactID], [MemberID], [ContactType], [ContactDetail], [Verified], [Notes], [PublicPrivate], [PostDate]) VALUES (3, N'6f94ag3aEdNzig9NDqt9MBqhivjcomnLtbmidteqCcuw4pwjeAasX6I9WuIZD6WA', N'Email', N'2205459363@qq.com', 1, N'GbCtui', NULL, CAST(N'2025-05-08' AS Date))
INSERT [dbo].[mms_Contact] ([ContactID], [MemberID], [ContactType], [ContactDetail], [Verified], [Notes], [PublicPrivate], [PostDate]) VALUES (4, N'US7QUIV8UIYS5UUBZIT30HURFHF5C3KAQDSS356EE2ZN76EXOBS9YKKTZQA5M0KI', N'Email', N'271520594@qq.com', 1, N'YXM908', NULL, CAST(N'2025-05-09' AS Date))
GO
INSERT [dbo].[mms_Members] ([MemberID], [UserName], [Name], [Name_Visible], [Name_Last], [NameLast_Visible], [ProfileIntroduction], [Type], [Status], [UserPoints], [PostDate]) VALUES (N'6f94ag3aEdNzig9NDqt9MBqhivjcomnLtbmidteqCcuw4pwjeAasX6I9WuIZD6WA', N'Dong                                                                                                                                                                                                                             ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-05-08' AS Date))
INSERT [dbo].[mms_Members] ([MemberID], [UserName], [Name], [Name_Visible], [Name_Last], [NameLast_Visible], [ProfileIntroduction], [Type], [Status], [UserPoints], [PostDate]) VALUES (N'QoImac76nJa9MMt7pAD2llUQBE92sLttjoOxuLal3H9BOAZ52vaHWavE43vRpd29', N'Donghao Zheng                                                                                                                                                                                                                    ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2025-05-08' AS Date))
INSERT [dbo].[mms_Members] ([MemberID], [UserName], [Name], [Name_Visible], [Name_Last], [NameLast_Visible], [ProfileIntroduction], [Type], [Status], [UserPoints], [PostDate]) VALUES (N'US7QUIV8UIYS5UUBZIT30HURFHF5C3KAQDSS356EE2ZN76EXOBS9YKKTZQA5M0KI', N'ddj                                                                                                                                                                                                                              ', N'21', NULL, N'121', NULL, N'1221', N'2121', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[mms_Relationship] ON 

INSERT [dbo].[mms_Relationship] ([RelationshipNo], [MemberID_Parent], [MemberID_Child], [Notes], [Timestamp]) VALUES (4001, N'6f94ag3aEdNzig9NDqt9MBqhivjcomnLtbmidteqCcuw4pwjeAasX6I9WuIZD6WA', N'US7QUIV8UIYS5UUBZIT30HURFHF5C3KAQDSS356EE2ZN76EXOBS9YKKTZQA5M0KI', N'YXM908', CAST(N'2025-05-09T16:43:35.897' AS DateTime))
SET IDENTITY_INSERT [dbo].[mms_Relationship] OFF
GO
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'_global', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000003A00000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF3D000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000310000003200000033000000340000003500000036000000370000003800000039000000FEFFFFFFFEFFFFFF3C0000003E000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000A0EFFE27CF48DA013B000000400400000000000044006400730058004D004C00530074007200650061006D00000000000000000000000000000000000000000000000000000000000000000000000000000000001A000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000716F00000000000053006300680065006D00610020005500440056002000440065006600610075006C00740000000000000000000000000000000000000000000000000000000000260002010100000003000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C000201FFFFFFFF04000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000001000000B4030000000000003C6464733E3C6469616772616D20666F6E74636C7369643D227B37374432433932442D373737392D313144382D393037302D3030303635423834304439437D22206D6F75736569636F6E636C7369643D227B30424533353230342D384639312D313143452D394445332D3030414130303442423835317D222064656661756C746C61796F75743D224D534444532E52656374696C696E656172222064656661756C746C696E65726F7574653D224D534444532E52656374696C696E656172222076657273696F6E3D223722206E6578746F626A6563743D22313922207363616C653D22313030222070616765627265616B616E63686F72783D2230222070616765627265616B616E63686F72793D2230222070616765627265616B73697A65783D2230222070616765627265616B73697A65793D223022207363726F6C6C6C6566743D222D3333313322207363726F6C6C746F703D2230222067726964783D22313530222067726964793D2231353022206D617267696E783D223530303022206D617267696E793D223530303022207A6F6F6D3D223130302220783D2233313330302220793D22313931303322206261636B636F6C6F723D222D32313437343833363433222064656661756C7470657273697374656E63653D223322205072696E74506167654E756D626572734D6F64653D223322205072696E744D617267696E546F703D223022205072696E744D617267696E426F74746F6D3D2236333522205072696E744D617267696E4C6566743D223022205072696E744D617267696E52696768743D223022206D61727175656573656C656374696F6E6D6F64653D223122206D6F757365706F696E7465723D22302220736E6170746F677269643D223122206175746F74797065616E6E6F746174696F6E3D2231222073686F777363726F6C6C626172733D223122207669657770616765627265616B733D22302220646F6E6F74666F726365636F6E6E6563746F7273626568696E647368617065733D2231223E3C666F6E743E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D22303030303038303033303030303030303030303230303030222F3E3C2F666F6E743E3C6D6F75736569636F6E3E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D2236633734303030303030303030303030222F3E3C2F6D6F75736569636F6E3E3C2F6469616772616D3E3C6C61796F75746D616E616765723E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D227363685F6C6162656C735F76697369626C65222076616C75653D22302220766172747970653D223131222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746D616E616765723E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F41776172647322206C6566743D22373830302220746F703D223438303022206C6F676963616C69643D22312220636F6E74726F6C69643D223122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223536333622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030303431363030303037383536333431323037303030303030313430313030303036373030366330303632303035663030343130303737303036313030373230303634303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303066313139303030303030303030303030326430313030303030393030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303030343136303030303030303030303030303730303030303030373030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303035653030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030623030303030303637303036633030363230303566303034313030373730303631303037323030363430303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F4C6F6F6B75707322206C6566743D2232313135302220746F703D223439353022206C6F676963616C69643D22322220636F6E74726F6C69643D223222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223433363622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303030653131303030303738353633343132303730303030303031343031303030303637303036633030363230303566303034633030366630303666303036623030373530303730303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303635313530303030303030303030303032643031303030303037303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303065313130303030303030303030303030353030303030303035303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303630303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303063303030303030363730303663303036323030356630303463303036663030366630303662303037353030373030303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F4E6F7469636562726422206C6566743D223135302220746F703D223538353022206C6F676963616C69643D22332220636F6E74726F6C69643D223322206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223433363622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030306531313030303037383536333431323037303030303030313430313030303036373030366330303632303035663030346530303666303037343030363930303633303036353030363230303732303036343030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303036353135303030303030303030303030326430313030303030373030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303030653131303030303030303030303030303530303030303030353030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303036343030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030653030303030303637303036633030363230303566303034653030366630303734303036393030363330303635303036323030373230303634303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F5365634D6F6422206C6566743D2231343835302220746F703D2236303022206C6F676963616C69643D22342220636F6E74726F6C69643D223422206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223433363622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030306531313030303037383536333431323037303030303030313430313030303036373030366330303632303035663030353330303635303036333030346430303666303036343030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303036353135303030303030303030303030326430313030303030373030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303030653131303030303030303030303030303530303030303030353030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030376130353030303030303030303030303031303030303030303130303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303035653030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303030623030303030303637303036633030363230303566303035333030363530303633303034643030366630303634303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F5365635573657222206C6566743D22373830302220746F703D2234353022206C6F676963616C69643D22352220636F6E74726F6C69643D223522206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223337333122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303039333065303030303738353633343132303730303030303031343031303030303637303036633030363230303566303035333030363530303633303035353030373330303635303037323030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303635313530303030303030303030303032643031303030303037303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303933306530303030303030303030303030343030303030303034303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303630303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303063303030303030363730303663303036323030356630303533303036353030363330303535303037333030363530303732303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F536574757022206C6566743D2232313135302220746F703D2237353022206C6F676963616C69643D22362220636F6E74726F6C69643D223622206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223337333122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303038383136303030303933306530303030373835363334313230373030303030303134303130303030363730303663303036323030356630303533303036353030373430303735303037303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030363531353030303030303030303030303264303130303030303730303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030303838313630303030393330653030303030303030303030303034303030303030303430303030303030323030303030303032303030303030316330313030303066353061303030303030303030303030303130303030303033393133303030303761303530303030303030303030303030313030303030303031303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030356330303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030306130303030303036373030366330303632303035663030353330303635303037343030373530303730303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D22676C625F557365727322206C6566743D22302220746F703D223022206C6F676963616C69643D22372220636F6E74726F6C69643D223722206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223433363622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303038383136303030303065313130303030373835363334313230373030303030303134303130303030363730303663303036323030356630303535303037333030363530303732303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030363531353030303030303030303030303264303130303030303730303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030303838313630303030306531313030303030303030303030303035303030303030303530303030303030323030303030303032303030303030316330313030303066353061303030303030303030303030303130303030303033393133303030306330303730303030303030303030303030323030303030303032303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030356330303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030306130303030303036373030366330303632303035663030353530303733303036353030373230303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031303032373030303130303030303036343030363230303666303030303030343630303462303035663030363730303663303036323030356630303533303036353030363330303535303037333030363530303732303035663030363730303663303036323030356630303535303037333030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F676C625F536563557365725F676C625F557365727327206265747765656E2027676C625F55736572732720616E642027676C625F536563557365722722206C6566743D22353436382220746F703D2231393322206C6F676963616C69643D22382220636F6E74726F6C69643D223822206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223236333222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393530373837343031353734382220636F6E74726F6C69643D2239222077696474683D223337343922206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D223130313522206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22343931302220793D22373735222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22352220736F75726365617474616368706F696E743D223831222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22353736382220793D22363030222F3E3C706F696E7420783D22373830302220793D22363030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353330306337626632662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22343931302220746F703D2237373522206C6F676963616C69643D22392220636F6E74726F6C69643D223922206D617374657269643D2238222068696E74313D2230222068696E74323D2230222077696474683D223337343922206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030613530653030303035383031303030303033303030303030303030303035303030303830303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631313830303436303034623030356630303637303036633030363230303566303035333030363530303633303035353030373330303635303037323030356630303637303036633030363230303566303035353030373330303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303130303237303030313030303030303634303036323030366630303030303034363030346230303566303036373030366330303632303035663030353330303635303036333030353530303733303036353030373230303566303036373030366330303632303035663030353330303635303036333030346430303666303036343030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F676C625F536563557365725F676C625F5365634D6F6427206265747765656E2027676C625F5365634D6F642720616E642027676C625F536563557365722722206C6566743D2231333236382220746F703D2233343322206C6F676963616C69643D2231312220636F6E74726F6C69643D22313122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223138383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235302220636F6E74726F6C69643D223132222077696474683D223430333722206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2236343122206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D2231323139312220793D22323331222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223422206465737469643D22352220736F75726365617474616368706F696E743D223734222064657374617474616368706F696E743D22373722207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D2231343835302220793D22373530222F3E3C706F696E7420783D2231333536382220793D22373530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353361383036396432662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D2231323139312220746F703D2232333122206C6F676963616C69643D2231322220636F6E74726F6C69643D22313222206D617374657269643D223131222068696E74313D2230222068696E74323D2230222077696474683D223430333722206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22303030323030303063353066303030303538303130303030303330303030303030303030666666666666303030383030303038303031303030303030313530303031303030303030393030313434343230313030303635343631363836663664363131393030343630303462303035663030363730303663303036323030356630303533303036353030363330303535303037333030363530303732303035663030363730303663303036323030356630303533303036353030363330303464303036663030363430303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230316139333435343031303030303030363430303632303036663030303030303436303034623030356630303637303036633030363230303566303034313030373730303631303037323030363430303733303035663030363730303663303036323030356630303535303037333030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F676C625F4177617264735F676C625F557365727327206265747765656E2027676C625F55736572732720616E642027676C625F4177617264732722206C6566743D22353436382220746F703D223336343322206C6F676963616C69643D2231332220636F6E74726F6C69643D22313322206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223236333222206865696768743D223138333722206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D223130302220636F6E74726F6C69643D223134222077696474683D223336363222206865696768743D223334342220736964653D223122206265686176696F723D2233222068696D65747269633D223330383222206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22343133382220793D2234353831222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22312220736F75726365617474616368706F696E743D22313237222064657374617474616368706F696E743D22373622207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22353736382220793D2234303530222F3E3C706F696E7420783D22363738342220793D2234303530222F3E3C706F696E7420783D22363738342220793D2235313030222F3E3C706F696E7420783D22373830302220793D2235313030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353338383633386332662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22343133382220746F703D223435383122206C6F676963616C69643D2231342220636F6E74726F6C69643D22313422206D617374657269643D223133222068696E74313D2230222068696E74323D2230222077696474683D223336363222206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030303465306530303030353830313030303030333030303030303030303066666666666630303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313137303034363030346230303566303036373030366330303632303035663030343130303737303036313030373230303634303037333030356630303637303036633030363230303566303035353030373330303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031303032373030303130303030303036343030363230303666303030303030343630303462303035663030363730303663303036323030356630303431303037373030363130303732303036343030373330303566303036373030366330303632303035663030353530303733303036353030373230303733303033313030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F676C625F4177617264735F676C625F55736572733127206265747765656E2027676C625F55736572732720616E642027676C625F4177617264732722206C6566743D22353436382220746F703D223337393322206C6F676963616C69643D2231352220636F6E74726F6C69643D22313522206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223236333222206865696768743D223135333722206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D223130302220636F6E74726F6C69643D223136222077696474683D223338333522206865696768743D223334342220736964653D223122206265686176696F723D2233222068696D65747269633D223237383222206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22333936352220793D2234343331222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22312220736F75726365617474616368706F696E743D22313239222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22353736382220793D2234323030222F3E3C706F696E7420783D22363738342220793D2234323030222F3E3C706F696E7420783D22363738342220793D2234393530222F3E3C706F696E7420783D22373830302220793D2234393530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353338306361626632662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22333936352220746F703D223434333122206C6F676963616C69643D2231362220636F6E74726F6C69643D22313622206D617374657269643D223135222068696E74313D2230222068696E74323D2230222077696474683D223338333522206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030666230653030303035383031303030303033303030303030303030306666666666663030303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631313830303436303034623030356630303637303036633030363230303566303034313030373730303631303037323030363430303733303035663030363730303663303036323030356630303535303037333030363530303732303037333030333130303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313163313036313031303030303030363430303632303036663030303030303436303034623030356630303637303036633030363230303566303034653030366630303734303036393030363330303635303036323030373230303634303035663030363730303663303036323030356630303535303037333030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F676C625F4E6F746963656272645F676C625F557365727327206265747765656E2027676C625F55736572732720616E642027676C625F4E6F746963656272642722206C6566743D222D3130372220746F703D223336373122206C6F676963616C69643D2231372220636F6E74726F6C69643D22313722206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D2238313522206865696768743D223238373922206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2236332E383138353136383132353238382220636F6E74726F6C69643D223138222077696474683D223339353122206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2239343722206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D222D333832362220793D2235303933222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223722206465737469643D22332220736F75726365617474616368706F696E743D2233222064657374617474616368706F696E743D223022207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D223330302220793D2234333636222F3E3C706F696E7420783D223330302220793D2235383530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353362303835383032662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D222D333832362220746F703D223530393322206C6F676963616C69643D2231382220636F6E74726F6C69643D22313822206D617374657269643D223137222068696E74313D2230222068696E74323D2230222077696474683D223339353122206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030303666306630303030353830313030303030333030303030303030303066666666666630303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313161303034363030346230303566303036373030366330303632303035663030346530303666303037343030363930303633303036353030363230303732303036343030356630303637303036633030363230303566303035353030373330303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C2F6464733E0D0A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEFFFFFF02000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F5739000002006071F927CF48DA01020200001048450000000000000000000000000000000000CC0100004400610074006100200053006F0075007200630065003D005700410059004E0045005F0048005000320037003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0043006F00620062006C0065003B0049006E00740065006700720061007400650064002000530065006300750072006900740079003D0054007200750065003B004D0075006C007400690070006C0065002000410063007400690076006500200052006500730075006C007400200053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B005400720075007300740020005300650072007600650072002000430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F0022000000008005001400000030002E00200047006C006F00620061006C000000000226001600000067006C0062005F00410077006100720064007300000008000000640062006F000000000226001800000067006C0062005F004C006F006F006B00750070007300000008000000640062006F000000000226001C00000067006C0062005F004E006F007400690063006500620072006400000008000000640062006F000000000226001600000067006C0062005F005300650063004D006F006400000008000000640062006F000000000226001800000067006C0062005F005300650063005500730065007200000008000000640062006F000000000226001400000067006C0062005F0053006500740075007000000008000000640062006F000000000224001400000067006C0062005F0055007300650072007300000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001000000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'mms', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000002800000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF2B000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000220000002300000024000000250000002600000027000000FEFFFFFFFEFFFFFF2A000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000305BE8FBCF48DA0129000000C00300000000000044006400730058004D004C00530074007200650061006D00000000000000000000000000000000000000000000000000000000000000000000000000000000001A000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000754B00000000000053006300680065006D00610020005500440056002000440065006600610075006C00740000000000000000000000000000000000000000000000000000000000260002010100000003000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C000201FFFFFFFF04000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000100000036030000000000003C6464733E3C6469616772616D20666F6E74636C7369643D227B37374432433932442D373737392D313144382D393037302D3030303635423834304439437D22206D6F75736569636F6E636C7369643D227B30424533353230342D384639312D313143452D394445332D3030414130303442423835317D222064656661756C746C61796F75743D224D534444532E52656374696C696E656172222064656661756C746C696E65726F7574653D224D534444532E52656374696C696E656172222076657273696F6E3D223722206E6578746F626A6563743D22313422207363616C653D22313030222070616765627265616B616E63686F72783D2230222070616765627265616B616E63686F72793D2230222070616765627265616B73697A65783D2230222070616765627265616B73697A65793D223022207363726F6C6C6C6566743D222D3432353022207363726F6C6C746F703D2230222067726964783D22313530222067726964793D2231353022206D617267696E783D223530303022206D617267696E793D223530303022207A6F6F6D3D223130302220783D2233313330302220793D22313931303322206261636B636F6C6F723D222D32313437343833363433222064656661756C7470657273697374656E63653D223322205072696E74506167654E756D626572734D6F64653D223322205072696E744D617267696E546F703D223022205072696E744D617267696E426F74746F6D3D2236333522205072696E744D617267696E4C6566743D223022205072696E744D617267696E52696768743D223022206D61727175656573656C656374696F6E6D6F64653D223122206D6F757365706F696E7465723D22302220736E6170746F677269643D223122206175746F74797065616E6E6F746174696F6E3D2231222073686F777363726F6C6C626172733D223122207669657770616765627265616B733D22302220646F6E6F74666F726365636F6E6E6563746F7273626568696E647368617065733D2231223E3C666F6E743E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D22303030303038303033303030303030303030303230303030222F3E3C2F666F6E743E3C6D6F75736569636F6E3E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D2236633734303030303030303030303030222F3E3C2F6D6F75736569636F6E3E3C2F6469616772616D3E3C6C61796F75746D616E616765723E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D227363685F6C6162656C735F76697369626C65222076616C75653D22302220766172747970653D223131222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746D616E616765723E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226D6D735F4164647265737322206C6566743D22383730302220746F703D2233303022206C6F676963616C69643D22312220636F6E74726F6C69643D223122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223934343622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303065363234303030303738353633343132303730303030303031343031303030303664303036643030373330303566303034313030363430303634303037323030363530303733303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303039323330303030303030303030303032643031303030303064303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030306536323430303030303030303030303030643030303030303063303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303037613035303030303030303030303030303130303030303030313030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303630303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303063303030303030366430303664303037333030356630303431303036343030363430303732303036353030373330303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226D6D735F436F6E7461637422206C6566743D2231353630302220746F703D223135303022206C6F676963616C69643D22322220636F6E74726F6C69643D223222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223632373122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303037663138303030303738353633343132303730303030303031343031303030303664303036643030373330303566303034333030366630303665303037343030363130303633303037343030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303337316330303030303030303030303032643031303030303061303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303766313830303030303030303030303030383030303030303038303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303037613035303030303030303030303030303130303030303030313030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303630303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303063303030303030366430303664303037333030356630303433303036663030366530303734303036313030363330303734303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226D6D735F4D656D6265727322206C6566743D223735302220746F703D2233303022206C6F676963616C69643D22332220636F6E74726F6C69643D223322206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223831373622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303066303166303030303738353633343132303730303030303031343031303030303664303036643030373330303566303034643030363530303664303036323030363530303732303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303039323330303030303030303030303032643031303030303064303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030306630316630303030303030303030303030623030303030303062303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303037613035303030303030303030303030303130303030303030313030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303630303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303063303030303030366430303664303037333030356630303464303036353030366430303632303036353030373230303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226D6D735F52656C6174696F6E7368697022206C6566743D223735302220746F703D223931353022206C6F676963616C69643D22342220636F6E74726F6C69643D223422206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223433363622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22323134333334313230383030303030303838313630303030306531313030303037383536333431323037303030303030313430313030303036643030366430303733303035663030353230303635303036633030363130303734303036393030366630303665303037333030363830303639303037303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303130303030303030353030303030303534303030303030326330303030303032633030303030303263303030303030333430303030303030303030303030303030303030303030323232393030303036353135303030303030303030303030326430313030303030373030303030303063303030303030303730303030303031633031303030303036303930303030363230373030303034383033303030303161303430303030646630323030303065633034303030303237303630303030623130333030303032373036303030306362303730303030353530353030303030303030303030303031303030303030383831363030303030653131303030303030303030303030303530303030303030353030303030303032303030303030303230303030303031633031303030306635306130303030303030303030303030313030303030303339313330303030376130353030303030303030303030303031303030303030303130303030303030323030303030303032303030303030316330313030303030363039303030303031303030303030303030303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030303030303030303030303030303030643133313030303030393233303030303030303030303030303030303030303030643030303030303034303030303030303430303030303031633031303030303036303930303030616130613030303039303036303030303738353633343132303430303030303036613030303030303031303030303030303130303030303030623030303030303030303030303030303130303030303030323030303030303033303030303030303430303030303030353030303030303036303030303030303730303030303030383030303030303039303030303030306130303030303030343030303030303634303036323030366630303030303031313030303030303664303036643030373330303566303035323030363530303663303036313030373430303639303036663030366530303733303036383030363930303730303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313030303130303031303030303030363430303632303036663030303030303436303034623030356630303664303036643030373330303566303034313030363430303634303037323030363530303733303037333030356630303664303036643030373330303566303034643030363530303664303036323030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6D6D735F416464726573735F6D6D735F4D656D6265727327206265747765656E20276D6D735F4D656D626572732720616E6420276D6D735F416464726573732722206C6566743D22363231382220746F703D22343322206C6F676963616C69643D22362220636F6E74726F6C69643D223622206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223237383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393534313730343835373932392220636F6E74726F6C69643D2237222077696474683D223436313322206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D223130393022206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22353330332220793D22363235222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22312220736F75726365617474616368706F696E743D223735222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22363531382220793D22343530222F3E3C706F696E7420783D22383730302220793D22343530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353333306562616432662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22353330332220746F703D2236323522206C6F676963616C69643D22372220636F6E74726F6C69643D223722206D617374657269643D2236222068696E74313D2230222068696E74323D2230222077696474683D223436313322206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030303035313230303030353830313030303030333030303030303030303030353030303038303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313161303034363030346230303566303036643030366430303733303035663030343130303634303036343030373230303635303037333030373330303566303036643030366430303733303035663030346430303635303036643030363230303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230313030323730303031303030303030363430303632303036663030303030303436303034623030356630303664303036643030373330303566303034333030366630303665303037343030363130303633303037343030356630303664303036643030373330303566303034643030363530303664303036323030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6D6D735F436F6E746163745F6D6D735F4D656D6265727327206265747765656E20276D6D735F4D656D626572732720616E6420276D6D735F436F6E746163742722206C6566743D22363231382220746F703D223132343322206C6F676963616C69643D22382220636F6E74726F6C69643D223822206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223936383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235302E303131303130373930353734382220636F6E74726F6C69643D2239222077696474683D223435383522206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D223435343222206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22383736372220793D2231383235222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22322220736F75726365617474616368706F696E743D223931222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22363531382220793D2231363530222F3E3C706F696E7420783D2231353630302220793D2231363530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353336383739393232662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22383736372220746F703D223138323522206C6F676963616C69643D22392220636F6E74726F6C69643D223922206D617374657269643D2238222068696E74313D2230222068696E74323D2230222077696474683D223435383522206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030306539313130303030353830313030303030333030303030303030303030353030303038303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313161303034363030346230303566303036643030366430303733303035663030343330303666303036653030373430303631303036333030373430303566303036643030366430303733303035663030346430303635303036643030363230303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303161393334353430313030303030303634303036323030366630303030303034363030346230303566303036643030366430303733303035663030353230303635303036633030363130303734303036393030366630303665303037333030363830303639303037303030356630303664303036643030373330303566303034643030363530303664303036323030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6D6D735F52656C6174696F6E736869705F6D6D735F4D656D6265727327206265747765656E20276D6D735F4D656D626572732720616E6420276D6D735F52656C6174696F6E736869702722206C6566743D223439332220746F703D223737383122206C6F676963616C69643D2231302220636F6E74726F6C69643D22313022206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D2238313522206865696768743D223230363922206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235302220636F6E74726F6C69643D223131222077696474683D223531363222206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2233333722206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D222D343433372220793D2238363431222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22342220736F75726365617474616368706F696E743D2231222064657374617474616368706F696E743D223022207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D223930302220793D2238343736222F3E3C706F696E7420783D223930302220793D2239313530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353364383762656532662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D222D343433372220746F703D223836343122206C6F676963616C69643D2231312220636F6E74726F6C69643D22313122206D617374657269643D223130222068696E74313D2230222068696E74323D2230222077696474683D223531363222206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D22303030323030303032613134303030303538303130303030303330303030303030303030666666666666303030383030303038303031303030303030313530303031303030303030393030313434343230313030303635343631363836663664363131663030343630303462303035663030366430303664303037333030356630303532303036353030366330303631303037343030363930303666303036653030373330303638303036393030373030303566303036643030366430303733303035663030346430303635303036643030363230303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D2230316431313335343031303030303030363430303632303036663030303030303436303034623030356630303664303036643030373330303566303035323030363530303663303036313030373430303639303036663030366530303733303036383030363930303730303035663030366430303664303037333030356630303464303036353030366430303632303036353030373230303733303033313030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6D6D735F52656C6174696F6E736869705F6D6D735F4D656D626572733127206265747765656E20276D6D735F4D656D626572732720616E6420276D6D735F52656C6174696F6E736869702722206C6566743D223634332220746F703D223737383122206C6F676963616C69643D2231322220636F6E74726F6C69643D22313222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D2238313522206865696768743D223230363922206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2235302220636F6E74726F6C69643D223133222077696474683D223533333522206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2233333722206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D222D343436302220793D2238363431222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22342220736F75726365617474616368706F696E743D2233222064657374617474616368706F696E743D223222207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22313035302220793D2238343736222F3E3C706F696E7420783D22313035302220793D2239313530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353331383832656532662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D222D343436302220746F703D223836343122206C6F676963616C69643D2231332220636F6E74726F6C69643D22313322206D617374657269643D223132222068696E74313D2230222068696E74323D2230222077696474683D223533333522206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2230303032303030306437313430303030353830313030303030333030303030303030303066666666666630303038303030303830303130303030303031353030303130303030303039303031343434323031303030363534363136383666366436313230303034363030346230303566303036643030366430303733303035663030353230303635303036633030363130303734303036393030366630303665303037333030363830303639303037303030356630303664303036643030373330303566303034643030363530303664303036323030363530303732303037333030333130303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C2F6464733E0D0A00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEFFFFFF02000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200B022E7FBCF48DA01020200001048450000000000000000000000000000000000CC0100004400610074006100200053006F0075007200630065003D005700410059004E0045005F0048005000320037003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0043006F00620062006C0065003B0049006E00740065006700720061007400650064002000530065006300750072006900740079003D0054007200750065003B004D0075006C007400690070006C0065002000410063007400690076006500200052006500730075006C007400200053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B005400720075007300740020005300650072007600650072002000430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500080000006D006D007300000000022600180000006D006D0073005F004100640064007200650073007300000008000000640062006F00000000022600180000006D006D0073005F0043006F006E007400610063007400000008000000640062006F00000000022600180000006D006D0073005F004D0065006D006200650072007300000008000000640062006F00000000022400220000006D006D0073005F00520065006C006100740069006F006E007300680069007000000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000E00000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'hip', 1, 3, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000002E00000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF31000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D000000FEFFFFFFFEFFFFFF3000000032000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000B03B87370349DA012F000000400400000000000044006400730058004D004C00530074007200650061006D00000000000000000000000000000000000000000000000000000000000000000000000000000000001A000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000020000004A5700000000000053006300680065006D00610020005500440056002000440065006600610075006C00740000000000000000000000000000000000000000000000000000000000260002010100000003000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C000201FFFFFFFF04000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000100000092030000000000003C6464733E3C6469616772616D20666F6E74636C7369643D227B37374432433932442D373737392D313144382D393037302D3030303635423834304439437D22206D6F75736569636F6E636C7369643D227B30424533353230342D384639312D313143452D394445332D3030414130303442423835317D222064656661756C746C61796F75743D224D534444532E52656374696C696E656172222064656661756C746C696E65726F7574653D224D534444532E52656374696C696E656172222076657273696F6E3D223722206E6578746F626A6563743D22313422207363616C653D22313030222070616765627265616B616E63686F72783D2230222070616765627265616B616E63686F72793D2230222070616765627265616B73697A65783D2230222070616765627265616B73697A65793D223022207363726F6C6C6C6566743D222D3531353022207363726F6C6C746F703D2230222067726964783D22313530222067726964793D2231353022206D617267696E783D223530303022206D617267696E793D223530303022207A6F6F6D3D223130302220783D2233303236382220793D22313934373322206261636B636F6C6F723D222D32313437343833363433222064656661756C7470657273697374656E63653D223322205072696E74506167654E756D626572734D6F64653D223322205072696E744D617267696E546F703D223022205072696E744D617267696E426F74746F6D3D2236333522205072696E744D617267696E4C6566743D223022205072696E744D617267696E52696768743D223022206D61727175656573656C656374696F6E6D6F64653D223122206D6F757365706F696E7465723D22302220736E6170746F677269643D223122206175746F74797065616E6E6F746174696F6E3D2231222073686F777363726F6C6C626172733D223122207669657770616765627265616B733D22302220646F6E6F74666F726365636F6E6E6563746F7273626568696E647368617065733D2231223E3C666F6E743E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D22303030303038303033303030303030303030303230303030222F3E3C2F666F6E743E3C6D6F75736569636F6E3E3C646473786D6C6F626A65637473747265616D777261707065722062696E6172793D2236633734303030303030303030303030222F3E3C2F6D6F75736569636F6E3E3C2F6469616772616D3E3C6C61796F75746D616E616765723E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D227363685F6C6162656C735F76697369626C65222076616C75653D22302220766172747970653D223131222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746D616E616765723E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226869705F4869766548656164657222206C6566743D22343230302220746F703D2236303022206C6F676963616C69643D22312220636F6E74726F6C69643D223122206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223934343622206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303065363234303030303738353633343132303730303030303031343031303030303638303036393030373030303566303034383030363930303736303036353030343830303635303036313030363430303635303037323030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303039323330303030303030303030303032643031303030303064303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030306536323430303030303030303030303030643030303030303063303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303636303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303066303030303030363830303639303037303030356630303438303036393030373630303635303034383030363530303631303036343030363530303732303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226869705F486976654865616C746822206C6566743D2231383435302220746F703D223733353022206C6F676963616C69643D22322220636F6E74726F6C69643D223222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223530303122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303038393133303030303738353633343132303730303030303031343031303030303638303036393030373030303566303034383030363930303736303036353030343830303635303036313030366330303734303036383030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030306162313730303030303030303030303032643031303030303038303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303839313330303030303030303030303030363030303030303036303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303636303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303066303030303030363830303639303037303030356630303438303036393030373630303635303034383030363530303631303036633030373430303638303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226869705F48697665496E7370656374696F6E44657461696C22206C6566743D2231313835302220746F703D2233303022206C6F676963616C69643D22332220636F6E74726F6C69643D223322206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537393522206865696768743D22313338393122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303061333136303030303433333630303030373835363334313230373030303030303134303130303030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030343430303635303037343030363130303639303036633030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030303932333030303030303030303030303264303130303030306430303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030306133313630303030343333363030303030303030303030303134303030303030306330303030303030323030303030303032303030303030316330313030303030343062303030303030303030303030303130303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030376130303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030313930303030303036383030363930303730303035663030343830303639303037363030363530303439303036653030373330303730303036353030363330303734303036393030366630303665303034343030363530303734303036313030363930303663303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323832302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226869705F48697665496E7370656374696F6E4E6F74657322206C6566743D2231383735302220746F703D223130353022206C6F676963616C69643D22342220636F6E74726F6C69643D223422206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223337333122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D2232313433333431323038303030303030383831363030303039333065303030303738353633343132303730303030303031343031303030303638303036393030373030303566303034383030363930303736303036353030343930303665303037333030373030303635303036333030373430303639303036663030366530303465303036663030373430303635303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030313030303030303035303030303030353430303030303032633030303030303263303030303030326330303030303033343030303030303030303030303030303030303030303032323239303030303635313530303030303030303030303032643031303030303037303030303030306330303030303030373030303030303163303130303030303630393030303036323037303030303438303330303030316130343030303064663032303030306563303430303030323730363030303062313033303030303237303630303030636230373030303035353035303030303030303030303030303130303030303038383136303030303933306530303030303030303030303030343030303030303034303030303030303230303030303030323030303030303163303130303030663530613030303030303030303030303031303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303130303030303030303030303030303339313330303030333430333030303030303030303030303030303030303030303030303030303030323030303030303032303030303030316330313030303030363039303030303030303030303030303030303030303064313331303030303039323330303030303030303030303030303030303030303064303030303030303430303030303030343030303030303163303130303030303630393030303061613061303030303930303630303030373835363334313230343030303030303738303030303030303130303030303030313030303030303062303030303030303030303030303030313030303030303032303030303030303330303030303030343030303030303035303030303030303630303030303030373030303030303038303030303030303930303030303030613030303030303034303030303030363430303632303036663030303030303138303030303030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030346530303666303037343030363530303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C20636F6E74726F6C70726F6769643D227B36323341433037352D324337372D343837332D383833442D3933304234333634423442437D2220746F6F6C7469703D226869705F557365727322206C6566743D222D323730302220746F703D2234353022206C6F676963616C69643D22352220636F6E74726F6C69643D223522206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223537363822206865696768743D223337333122206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223022206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2231223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223231343333343132303830303030303038383136303030303933306530303030373835363334313230373030303030303134303130303030363830303639303037303030356630303535303037333030363530303732303037333030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303031303030303030303530303030303035343030303030303263303030303030326330303030303032633030303030303334303030303030303030303030303030303030303030303232323930303030363531353030303030303030303030303264303130303030303730303030303030633030303030303037303030303030316330313030303030363039303030303632303730303030343830333030303031613034303030306466303230303030656330343030303032373036303030306231303330303030323730363030303063623037303030303535303530303030303030303030303030313030303030303838313630303030393330653030303030303030303030303034303030303030303430303030303030323030303030303032303030303030316330313030303066353061303030303030303030303030303130303030303033393133303030303334303330303030303030303030303030303030303030303030303030303030303230303030303030323030303030303163303130303030303630393030303030313030303030303030303030303030333931333030303033343033303030303030303030303030303030303030303030303030303030303032303030303030303230303030303031633031303030303036303930303030303030303030303030303030303030306431333130303030303932333030303030303030303030303030303030303030306430303030303030343030303030303034303030303030316330313030303030363039303030306161306130303030393030363030303037383536333431323034303030303030356330303030303030313030303030303031303030303030306230303030303030303030303030303031303030303030303230303030303030333030303030303034303030303030303530303030303030363030303030303037303030303030303830303030303030393030303030303061303030303030303430303030303036343030363230303666303030303030306130303030303036383030363930303730303035663030353530303733303036353030373230303733303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A3E3C70726F7065727479206E616D653D224163746976655461626C65566965774D6F6465222076616C75653D22312220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A30222076616C75653D22342C302C3238342C302C323331302C312C313839302C352C313236302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A31222076616C75653D22322C302C3238342C302C323830352220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A32222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A33222076616C75653D22322C302C3238342C302C323331302220766172747970653D2238222F3E3C70726F7065727479206E616D653D225461626C65566965774D6F64653A34222076616C75653D22342C302C3238342C302C323331302C31322C323733302C31312C313638302220766172747970653D2238222F3E3C2F646473786D6C6F626A3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031313064663534303130303030303036343030363230303666303030303030343630303462303035663030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030343430303635303037343030363130303639303036633030356630303638303036393030373030303566303034383030363930303736303036353030343830303635303036313030363430303635303037323030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6869705F48697665496E7370656374696F6E44657461696C5F6869705F4869766548656164657227206265747765656E20276869705F486976654865616465722720616E6420276869705F48697665496E7370656374696F6E44657461696C2722206C6566743D22393636382220746F703D2233343322206C6F676963616C69643D22362220636F6E74726F6C69643D223622206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223234383222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393436383635303337313934352220636F6E74726F6C69643D2237222077696474683D223632383722206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2239343022206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22373736362220793D22393235222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223122206465737469643D22332220736F75726365617474616368706F696E743D223735222064657374617474616368706F696E743D22373822207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22393936382220793D22373530222F3E3C706F696E7420783D2231313835302220793D22373530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353364383832656532662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22373736362220746F703D2239323522206C6F676963616C69643D22372220636F6E74726F6C69643D223722206D617374657269643D2236222068696E74313D2230222068696E74323D2230222077696474683D223632383722206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030386631383030303035383031303030303033303030303030303030303035303030303830303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631326130303436303034623030356630303638303036393030373030303566303034383030363930303736303036353030343930303665303037333030373030303635303036333030373430303639303036663030366530303434303036353030373430303631303036393030366330303566303036383030363930303730303035663030343830303639303037363030363530303438303036353030363130303634303036353030373230303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031303030303030303130303030303036343030363230303666303030303030343630303462303035663030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030346530303666303037343030363530303733303035663030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030343430303635303037343030363130303639303036633030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6869705F48697665496E7370656374696F6E4E6F7465735F6869705F48697665496E7370656374696F6E44657461696C27206265747765656E20276869705F48697665496E7370656374696F6E44657461696C2720616E6420276869705F48697665496E7370656374696F6E4E6F7465732722206C6566743D2231373334352220746F703D2237393322206C6F676963616C69643D22382220636F6E74726F6C69643D223822206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223137303522206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393534373531313331323231372220636F6E74726F6C69643D2239222077696474683D223735323722206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2235353222206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D2231343433342220793D2231333735222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22342220736F75726365617474616368706F696E743D223835222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D2231373634352220793D2231323030222F3E3C706F696E7420783D2231383735302220793D2231323030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353336383761393232662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D2231343433342220746F703D223133373522206C6F676963616C69643D22392220636F6E74726F6C69643D223922206D617374657269643D2238222068696E74313D2230222068696E74323D2230222077696474683D223735323722206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030363731643030303035383031303030303033303030303030303030306666666666663030303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631333330303436303034623030356630303638303036393030373030303566303034383030363930303736303036353030343930303665303037333030373030303635303036333030373430303639303036663030366530303465303036663030373430303635303037333030356630303638303036393030373030303566303034383030363930303736303036353030343930303665303037333030373030303635303036333030373430303639303036663030366530303434303036353030373430303631303036393030366330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031313064663534303130303030303036343030363230303666303030303030343630303462303035663030363830303639303037303030356630303438303036393030373630303635303034383030363530303631303036633030373430303638303035663030363830303639303037303030356630303438303036393030373630303635303034393030366530303733303037303030363530303633303037343030363930303666303036653030343430303635303037343030363130303639303036633030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6869705F486976654865616C74685F6869705F48697665496E7370656374696F6E44657461696C27206265747765656E20276869705F48697665496E7370656374696F6E44657461696C2720616E6420276869705F486976654865616C74682722206C6566743D2231373334352220746F703D223730393322206C6F676963616C69643D2231302220636F6E74726F6C69643D22313022206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223134303522206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393337383838313938373537382220636F6E74726F6C69643D223131222077696474683D223631373122206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2234303222206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D2231343936322220793D2237363735222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223322206465737469643D22322220736F75726365617474616368706F696E743D22313639222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D2231373634352220793D2237353030222F3E3C706F696E7420783D2231383435302220793D2237353030222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353364383737656532662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D2231343936322220746F703D223736373522206C6F676963616C69643D2231312220636F6E74726F6C69643D22313122206D617374657269643D223130222068696E74313D2230222068696E74323D2230222077696474683D223631373122206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030316231383030303035383031303030303033303030303030303030306666666666663030303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631326130303436303034623030356630303638303036393030373030303566303034383030363930303736303036353030343830303635303036313030366330303734303036383030356630303638303036393030373030303566303034383030363930303736303036353030343930303665303037333030373030303635303036333030373430303639303036663030366530303434303036353030373430303631303036393030366330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D223031303032373030303130303030303036343030363230303666303030303030343630303462303035663030363830303639303037303030356630303438303036393030373630303635303034383030363530303631303036343030363530303732303035663030363830303639303037303030356630303535303037333030363530303732303037333030303030302220636F6E74726F6C70726F6769643D224D534444532E506F6C796C696E652E3038302E312220746F6F6C7469703D2252656C6174696F6E736869702027464B5F6869705F486976654865616465725F6869705F557365727327206265747765656E20276869705F55736572732720616E6420276869705F486976654865616465722722206C6566743D22323736382220746F703D2233343322206C6F676963616C69643D2231322220636F6E74726F6C69643D22313222206D617374657269643D2230222068696E74313D2230222068696E74323D2230222077696474683D223137333222206865696768743D2238313522206E6F726573697A653D223022206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2230222075736564656661756C7469646473686170653D2230222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22302220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2230222067726F7570636F6C6C61707365643D2230222074616273746F703D2231222076697369626C653D22312220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A3E3C706F6C796C696E6520656E64747970656473743D22302220656E64747970657372633D2232222075736572636F6C6F723D22313537393033323022206C696E657374796C653D223022206C696E6572656E6465723D22302220637573746F6D656E647479706564737469643D22302220637573746F6D656E647479706573726369643D2230222061646F726E7376697369626C653D2231223E3C61646F726E6D656E742070657263656E74706F733D2234392E393131363630373737333835322220636F6E74726F6C69643D223133222077696474683D223432333922206865696768743D223334342220736964653D223022206265686176696F723D2233222068696D65747269633D2235363522206469737466726F6D6C696E653D22313735222073746172746F626A3D22302220783D22313531352220793D22393235222076697369626C653D22302220616C6C6F776F7665726C61703D2231222075736570657263656E743D2231222F3E3C2F706F6C796C696E653E3C2F646473786D6C6F626A3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C636F6E6E6563746F7220736F7572636569643D223522206465737469643D22312220736F75726365617474616368706F696E743D223737222064657374617474616368706F696E743D22373422207365676D656E74656469746D6F64653D2230222062656E64706F696E74656469746D6F64653D2230222062656E64706F696E747669736962696C6974793D2230222072656C6174656469643D223022207669727475616C3D2230223E3C706F696E7420783D22333036382220793D22373530222F3E3C706F696E7420783D22343230302220793D22373530222F3E3C2F636F6E6E6563746F723E3C2F646473636F6E74726F6C3E3C646473636F6E74726F6C2073656D616E746963636F6F6B69653D22303166363933353334306339626632662220636F6E74726F6C70726F6769643D224D534444532E546578742E3038302E3122206C6566743D22313531352220746F703D2239323522206C6F676963616C69643D2231332220636F6E74726F6C69643D22313322206D617374657269643D223132222068696E74313D2230222068696E74323D2230222077696474683D223432333922206865696768743D2233343422206E6F726573697A653D223122206E6F6D6F76653D223022206E6F64656661756C74617474616368706F696E74733D223122206175746F647261673D2231222075736564656661756C7469646473686170653D2231222073656C65637461626C653D2231222073686F7773656C656374696F6E68616E646C65733D22312220616C6C6F776E756467696E673D223122206973616E6E6F746174696F6E3D22302220646F6E746175746F6C61796F75743D2231222067726F7570636F6C6C61707365643D2230222074616273746F703D2230222076697369626C653D22302220736E6170746F677269643D2230223E3C636F6E74726F6C3E3C646473786D6C6F626A65637473747265616D696E6974777261707065722062696E6172793D223030303230303030386631303030303035383031303030303033303030303030303030306666666666663030303830303030383030313030303030303135303030313030303030303930303134343432303130303036353436313638366636643631316230303436303034623030356630303638303036393030373030303566303034383030363930303736303036353030343830303635303036313030363430303635303037323030356630303638303036393030373030303566303035353030373330303635303037323030373330303030303030303030222F3E3C2F636F6E74726F6C3E3C6C61796F75746F626A6563743E3C646473786D6C6F626A2F3E3C2F6C61796F75746F626A6563743E3C73686170652067726F7570736861706569643D2230222067726F75706E6F64653D2230222F3E3C2F646473636F6E74726F6C3E3C2F6464733E0D0A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEFFFFFF02000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200402A86370349DA01020200001048450000000000000000000000000000000000CC0100004400610074006100200053006F0075007200630065003D005700410059004E0045005F0048005000320037003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0043006F00620062006C0065003B0049006E00740065006700720061007400650064002000530065006300750072006900740079003D0054007200750065003B004D0075006C007400690070006C0065002000410063007400690076006500200052006500730075006C007400200053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F00750074003D00330030003B005400720075007300740020005300650072007600650072002000430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500080000006800690070000000000226001E0000006800690070005F004800690076006500480065006100640065007200000008000000640062006F000000000226001E0000006800690070005F0048006900760065004800650061006C0074006800000008000000640062006F00000000022600320000006800690070005F00480069007600650049006E007300700065006300740069006F006E00440065007400610069006C00000008000000640062006F00000000022600300000006800690070005F00480069007600650049006E007300700065006300740069006F006E004E006F00740065007300000008000000640062006F00000000022400140000006800690070005F0055007300650072007300000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001000000012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_glb_UserName]    Script Date: 2025/5/9 18:05:49 ******/
ALTER TABLE [dbo].[glb_Users] ADD  CONSTRAINT [IX_glb_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_qbm_QuestionaireID]    Script Date: 2025/5/9 18:05:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_qbm_QuestionaireID] ON [dbo].[qbm_QRelationship]
(
	[QuestionaireID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 2025/5/9 18:05:49 ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[glb_SecMod] ADD  DEFAULT ((1)) FOR [SecurityLevel]
GO
ALTER TABLE [dbo].[glb_Awards]  WITH CHECK ADD  CONSTRAINT [FK_glb_Awards_glb_Users] FOREIGN KEY([PostMemberID])
REFERENCES [dbo].[glb_Users] ([MemberID])
GO
ALTER TABLE [dbo].[glb_Awards] CHECK CONSTRAINT [FK_glb_Awards_glb_Users]
GO
ALTER TABLE [dbo].[glb_Awards]  WITH CHECK ADD  CONSTRAINT [FK_glb_Awards_glb_Users1] FOREIGN KEY([RespMemberID])
REFERENCES [dbo].[glb_Users] ([MemberID])
GO
ALTER TABLE [dbo].[glb_Awards] CHECK CONSTRAINT [FK_glb_Awards_glb_Users1]
GO
ALTER TABLE [dbo].[glb_Noticebrd]  WITH CHECK ADD  CONSTRAINT [FK_glb_Noticebrd_glb_Users] FOREIGN KEY([PostMemberID])
REFERENCES [dbo].[glb_Users] ([MemberID])
GO
ALTER TABLE [dbo].[glb_Noticebrd] CHECK CONSTRAINT [FK_glb_Noticebrd_glb_Users]
GO
ALTER TABLE [dbo].[glb_SecUser]  WITH CHECK ADD  CONSTRAINT [FK_glb_SecUser_glb_SecMod] FOREIGN KEY([SecModID])
REFERENCES [dbo].[glb_SecMod] ([SecModID])
GO
ALTER TABLE [dbo].[glb_SecUser] CHECK CONSTRAINT [FK_glb_SecUser_glb_SecMod]
GO
ALTER TABLE [dbo].[glb_SecUser]  WITH CHECK ADD  CONSTRAINT [FK_glb_SecUser_glb_Users] FOREIGN KEY([MemberID])
REFERENCES [dbo].[glb_Users] ([MemberID])
GO
ALTER TABLE [dbo].[glb_SecUser] CHECK CONSTRAINT [FK_glb_SecUser_glb_Users]
GO
ALTER TABLE [dbo].[hip_HiveHeader]  WITH CHECK ADD  CONSTRAINT [FK_hip_HiveHeader_hip_Users] FOREIGN KEY([MemberID])
REFERENCES [dbo].[hip_Users] ([MemberID])
GO
ALTER TABLE [dbo].[hip_HiveHeader] CHECK CONSTRAINT [FK_hip_HiveHeader_hip_Users]
GO
ALTER TABLE [dbo].[hip_HiveHealth]  WITH CHECK ADD  CONSTRAINT [FK_hip_HiveHealth_hip_HiveInspectionDetail] FOREIGN KEY([InspectionID])
REFERENCES [dbo].[hip_HiveInspectionDetail] ([InspectionID])
GO
ALTER TABLE [dbo].[hip_HiveHealth] CHECK CONSTRAINT [FK_hip_HiveHealth_hip_HiveInspectionDetail]
GO
ALTER TABLE [dbo].[hip_HiveInspectionDetail]  WITH CHECK ADD  CONSTRAINT [FK_hip_HiveInspectionDetail_hip_HiveHeader] FOREIGN KEY([HiveID])
REFERENCES [dbo].[hip_HiveHeader] ([HiveID])
GO
ALTER TABLE [dbo].[hip_HiveInspectionDetail] CHECK CONSTRAINT [FK_hip_HiveInspectionDetail_hip_HiveHeader]
GO
ALTER TABLE [dbo].[hip_HiveInspectionNotes]  WITH CHECK ADD  CONSTRAINT [FK_hip_HiveInspectionNotes_hip_HiveInspectionDetail] FOREIGN KEY([InspectionID])
REFERENCES [dbo].[hip_HiveInspectionDetail] ([InspectionID])
GO
ALTER TABLE [dbo].[hip_HiveInspectionNotes] CHECK CONSTRAINT [FK_hip_HiveInspectionNotes_hip_HiveInspectionDetail]
GO
ALTER TABLE [dbo].[mms_Address]  WITH CHECK ADD  CONSTRAINT [FK_mms_Address_mms_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[mms_Members] ([MemberID])
GO
ALTER TABLE [dbo].[mms_Address] CHECK CONSTRAINT [FK_mms_Address_mms_Members]
GO
ALTER TABLE [dbo].[mms_Contact]  WITH CHECK ADD  CONSTRAINT [FK_mms_Contact_mms_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[mms_Members] ([MemberID])
GO
ALTER TABLE [dbo].[mms_Contact] CHECK CONSTRAINT [FK_mms_Contact_mms_Members]
GO
ALTER TABLE [dbo].[mms_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_mms_Relationship_mms_Members] FOREIGN KEY([MemberID_Parent])
REFERENCES [dbo].[mms_Members] ([MemberID])
GO
ALTER TABLE [dbo].[mms_Relationship] CHECK CONSTRAINT [FK_mms_Relationship_mms_Members]
GO
ALTER TABLE [dbo].[mms_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_mms_Relationship_mms_Members1] FOREIGN KEY([MemberID_Child])
REFERENCES [dbo].[mms_Members] ([MemberID])
GO
ALTER TABLE [dbo].[mms_Relationship] CHECK CONSTRAINT [FK_mms_Relationship_mms_Members1]
GO
/****** Object:  StoredProcedure [dbo].[sp_Address_AddUserAddress]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Address_AddUserAddress]
    @MemberID NVARCHAR(64),
    @AddressType NVARCHAR(10),
    @Address1 NVARCHAR(50) = NULL,
    @Address2 NVARCHAR(50) = NULL,
    @Address3 NVARCHAR(50) = NULL,
    @City NVARCHAR(25) = NULL,
    @PostCode NVARCHAR(5) = NULL,
    @RegionalCouncil NVARCHAR(25) = NULL,
    @State NVARCHAR(5) = NULL,
    @Country BIGINT = NULL,
    @PublicPrivate INT = NULL,
    @PostDate DATETIME = NULL
AS
BEGIN
    INSERT INTO mms_Address (
        MemberID, 
        AddressType, 
        Address1, 
        Address2, 
        Address3, 
        City, 
        PostCode, 
        RegionalCouncil, 
        State, 
        Country, 
        PublicPrivate, 
        PostDate
    )
    VALUES (
        @MemberID,
        @AddressType,
        @Address1,
        @Address2,
        @Address3,
        @City,
        @PostCode,
        @RegionalCouncil,
        @State,
        @Country,
        @PublicPrivate,
        @PostDate
    );
    
    -- 返回插入的AddressID（可选）
    SELECT SCOPE_IDENTITY() AS AddressID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Address_DeleteUserAddress]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Address_DeleteUserAddress]
    @AddressID INT
AS
BEGIN
    DELETE FROM mms_Address WHERE AddressID = @AddressID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Address_GetData]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 用户地址存储过程
CREATE PROCEDURE [dbo].[sp_Address_GetData]
    @AddressID INT = NULL,
    @MemberID NVARCHAR(64) = NULL
AS
BEGIN
    SELECT mms_Address.*,glb_Lookups.Description FROM mms_Address left join glb_Lookups on mms_Address.Country=glb_Lookups.LookupID
    WHERE 
        (@AddressID IS NULL OR AddressID = @AddressID)
        AND (@MemberID IS NULL OR MemberID = @MemberID)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Address_UpdateUserAddress]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Address_UpdateUserAddress]
    @AddressID BIGINT,
    @MemberID NVARCHAR(64),
    @AddressType NVARCHAR(10),
    @Address1 NVARCHAR(255) = NULL,
    @Address2 NVARCHAR(255) = NULL,
    @Address3 NVARCHAR(255) = NULL,
    @City NVARCHAR(100) = NULL,
    @PostCode NVARCHAR(20) = NULL,
    @RegionalCouncil NVARCHAR(100) = NULL,
    @State NVARCHAR(100) = NULL,
    @Country BIGINT = NULL,
    @PublicPrivate INT = NULL,
    @PostDate DATETIME = NULL
AS
BEGIN
    UPDATE mms_Address
    SET
        MemberID = @MemberID,
        AddressType = @AddressType,
        Address1 = @Address1,
        Address2 = @Address2,
        Address3 = @Address3,
        City = @City,
        PostCode = @PostCode,
        RegionalCouncil = @RegionalCouncil,
        State = @State,
        Country = @Country,
        PublicPrivate = @PublicPrivate,
        PostDate = @PostDate
    WHERE
        AddressID = @AddressID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Contact_AddUserContact]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Contact_AddUserContact]
    @MemberID NVARCHAR(64),
    @ContactType NVARCHAR(50),
    @ContactDetail NVARCHAR(255) = NULL,
    @Verified BIT = NULL,
    @Notes NVARCHAR(255) = NULL,
    @PublicPrivate INT = NULL,
    @PostDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- 自动生成 ContactID（原子操作，避免并发冲突）
    DECLARE @ContactID BIGINT;
    
    -- 使用 OUTPUT 子句返回插入的 ContactID
    INSERT INTO mms_Contact (
        ContactID, 
        MemberID, 
        ContactType, 
        ContactDetail, 
        Verified, 
        Notes, 
        PublicPrivate, 
        PostDate
    )
    VALUES (
        -- 生成下一个 ContactID（使用事务+锁确保唯一性）
        (SELECT ISNULL(MAX(ContactID), 0) + 1 FROM mms_Contact WITH (TABLOCKX, HOLDLOCK)),
        @MemberID,
        @ContactType,
        @ContactDetail,
        @Verified,
        @Notes,
        @PublicPrivate,
        @PostDate
    );

    -- 返回插入的 ContactID（可选）
    SELECT SCOPE_IDENTITY() AS ContactID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Contact_CheckEmailExists]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Contact_CheckEmailExists]
    @Email NVARCHAR(100)
AS
BEGIN
    SELECT COUNT(1) 
    FROM mms_Contact 
    WHERE ContactDetail = @Email AND ContactType = 'Email';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Contact_DeleteUserContact]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Contact_DeleteUserContact]
    @ContactID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- 删除指定ContactID的联系人记录
    DELETE FROM mms_Contact 
    WHERE ContactID = @ContactID;
    
    -- 返回受影响的行数
    SELECT @@ROWCOUNT AS RowsAffected;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Contact_GetData]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 用户联系信息存储过程
CREATE PROCEDURE [dbo].[sp_Contact_GetData]
    @Code varchar(max) = NULL,
    @Verified BIT = NULL,
    @MemberID NVARCHAR(64) = NULL,
    @ContactID INT = NULL
AS
BEGIN
    SELECT * FROM mms_Contact 
    WHERE 
        (@Code IS NULL OR Notes = @Code)
        AND (@Verified IS NULL OR Verified = @Verified)
        AND (@MemberID IS NULL OR MemberID = @MemberID)
        AND (@ContactID IS NULL OR ContactID = @ContactID)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Contact_UpdateUserContact]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Contact_UpdateUserContact]
    @ContactID BIGINT,
    @MemberID NVARCHAR(64),
    @ContactType NVARCHAR(50),
    @ContactDetail NVARCHAR(50) = NULL,
    @Verified BIT = NULL,
    @Notes varchar(max) = NULL,
    @PublicPrivate INT = NULL
AS
BEGIN
    UPDATE mms_Contact 
    SET MemberID = @MemberID,
        ContactType = @ContactType,
        ContactDetail = @ContactDetail,
        Verified = @Verified,
        Notes = @Notes,
        PublicPrivate = @PublicPrivate
    WHERE ContactID = @ContactID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUnverifiedUsers]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_DeleteUnverifiedUsers]
    @SevenDaysAgo DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- 开启事务确保数据一致性
    BEGIN TRANSACTION;

    BEGIN TRY
        -- 声明临时表存储待删除的用户ID
        DECLARE @UsersToDelete TABLE (MemberID NVARCHAR(64));

        -- 插入未验证的用户ID到临时表
        INSERT INTO @UsersToDelete (MemberID)
        SELECT MemberID
        FROM mms_Contact
        WHERE Verified = 0 
            AND PostDate < @SevenDaysAgo 
            AND ContactType = 'Email';

        -- 删除关联的联系人记录
        DELETE FROM mms_Contact
        WHERE MemberID IN (SELECT MemberID FROM @UsersToDelete);

        -- 删除用户记录
        DELETE FROM mms_Members
        WHERE MemberID IN (SELECT MemberID FROM @UsersToDelete);

        -- 提交事务
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- 回滚事务
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- 记录错误信息（实际项目中建议添加日志记录）
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Lookups_GetData]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 数据字典存储过程
CREATE PROCEDURE [dbo].[sp_Lookups_GetData]
    @Keyword NVARCHAR(50) = NULL,
    @LookupType NVARCHAR(50) = NULL
AS
BEGIN
    SELECT * FROM glb_Lookups 
    WHERE 
        (@Keyword IS NULL OR (LookupCode LIKE '%' + @Keyword + '%' OR LookupType LIKE '%' + @Keyword + '%' OR Description LIKE '%' + @Keyword + '%'))
        AND (@LookupType IS NULL OR LookupType = @LookupType)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_AddUser]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 用户管理存储过程：添加用户
CREATE PROCEDURE [dbo].[sp_Members_AddUser]
    @MemberID NVARCHAR(64),
    @UserName NVARCHAR(255),
    @Name NVARCHAR(50) = NULL,
    @Name_Visible BIT = NULL,
    @Name_Last NVARCHAR(50) = NULL,
    @NameLast_Visible BIT = NULL,
    @ProfileIntroduction NVARCHAR(MAX) = NULL,
    @Type NVARCHAR(10) = NULL,
    @Status NVARCHAR(10) = NULL,
    @UserPoints INT = NULL,
    @PostDate DATETIME = NULL
AS
BEGIN
    INSERT INTO mms_Members (MemberID, UserName, Name, Name_Visible, Name_Last, NameLast_Visible, ProfileIntroduction, Type, Status, UserPoints, PostDate)
    VALUES (@MemberID, @UserName, @Name, @Name_Visible, @Name_Last, @NameLast_Visible, @ProfileIntroduction, @Type, @Status, @UserPoints, @PostDate)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_Authenticate]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Members_Authenticate]
    @Email NVARCHAR(50)
AS
BEGIN
    SELECT c.*, m.* 
    FROM mms_Contact c 
    JOIN mms_Members m ON c.MemberID = m.MemberID
    WHERE c.ContactType = 'Email' AND c.ContactDetail = @Email;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_CheckMemberIdExists]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Members_CheckMemberIdExists]
    @MemberID NVARCHAR(64)
AS
BEGIN
    SELECT COUNT(1) 
    FROM mms_Members 
    WHERE MemberID = @MemberID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_GetUserById]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 用户管理存储过程
CREATE PROCEDURE [dbo].[sp_Members_GetUserById]
    @MemberID NVARCHAR(64)
AS
BEGIN
    SELECT * FROM mms_Members WHERE MemberID = @MemberID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_GetUserByUserName]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Members_GetUserByUserName]
    @UserName NVARCHAR(225)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        MemberID,
        UserName,
        Name,
        Name_Visible,
        Name_Last,
        NameLast_Visible,
        ProfileIntroduction,
        Type,
        Status,
        UserPoints,
        PostDate
    FROM 
        mms_Members
    WHERE 
        UserName = @UserName;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Members_UpdateUser]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Members_UpdateUser]
    @MemberID NVARCHAR(64),
    @UserName NVARCHAR(225),
    @Name NVARCHAR(50) = NULL,
    @Name_Visible BIT = NULL,
    @Name_Last NVARCHAR(50) = NULL,
    @NameLast_Visible BIT = NULL,
    @ProfileIntroduction NVARCHAR(MAX) = NULL,
    @Type NVARCHAR(10) = NULL,
    @Status NVARCHAR(10) = NULL,
    @UserPoints INT = NULL,
    @PostDate DATETIME = NULL
AS
BEGIN
    UPDATE mms_Members 
    SET UserName = @UserName,
        Name = @Name,
        Name_Visible = @Name_Visible,
        Name_Last = @Name_Last,
        NameLast_Visible = @NameLast_Visible,
        ProfileIntroduction = @ProfileIntroduction,
        Type = @Type,
        Status = @Status,
        UserPoints = @UserPoints,
        PostDate = @PostDate
    WHERE MemberID = @MemberID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Relationship_AddRelationship]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 关系管理存储过程
CREATE PROCEDURE [dbo].[sp_Relationship_AddRelationship]
    @MemberID_Parent NVARCHAR(64),
    @MemberID_Child NVARCHAR(64),
    @Notes varchar(max) = NULL,
    @Timestamp DATETIME = NULL
AS
BEGIN
    INSERT INTO mms_Relationship (MemberID_Parent, MemberID_Child, Notes, Timestamp)
    VALUES (@MemberID_Parent, @MemberID_Child, @Notes, @Timestamp)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 2025/5/9 18:05:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'eMail hashed: SHA-256' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glb_Users', @level2type=N'COLUMN',@level2name=N'MemberID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'eMail Address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glb_Users', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Password Hashed: SHA-256' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glb_Users', @level2type=N'COLUMN',@level2name=N'Password'
GO
USE [master]
GO
ALTER DATABASE [Cobble] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [Vidu]    Script Date: 14/02/2024 14:01:02 PM ******/
CREATE DATABASE [Vidu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Vidu', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Vidu.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Vidu_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Vidu_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Vidu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Vidu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Vidu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Vidu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Vidu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Vidu] SET ARITHABORT OFF 
GO
ALTER DATABASE [Vidu] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Vidu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Vidu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Vidu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Vidu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Vidu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Vidu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Vidu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Vidu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Vidu] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Vidu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Vidu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Vidu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Vidu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Vidu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Vidu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Vidu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Vidu] SET RECOVERY FULL 
GO
ALTER DATABASE [Vidu] SET  MULTI_USER 
GO
ALTER DATABASE [Vidu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Vidu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Vidu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Vidu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Vidu] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Vidu', N'ON'
GO
USE [Vidu]
GO
/****** Object:  User [vy]    Script Date: 14/02/2024 14:01:02 PM ******/
CREATE USER [vy] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Nguoidung]    Script Date: 14/02/2024 14:01:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nguoidung](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](20) NULL,
	[pass] [nvarchar](50) NULL,
 CONSTRAINT [PK_Nguoidung] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhomSP]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomSP](
	[Manhom] [int] IDENTITY(1,1) NOT NULL,
	[Tennhom] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhomSP] PRIMARY KEY CLUSTERED 
(
	[Manhom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sanpham](
	[IDSP] [int] IDENTITY(1,1) NOT NULL,
	[Manhom] [int] NULL,
	[MaSP] [nvarchar](20) NULL,
	[TenSP] [nvarchar](50) NULL,
	[Dvt] [nvarchar](10) NULL,
	[Giaban] [decimal](18, 0) NULL,
	[img] [nvarchar](255) NULL,
 CONSTRAINT [PK_Sanpham] PRIMARY KEY CLUSTERED 
(
	[IDSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Nguoidung] ON 

INSERT [dbo].[Nguoidung] ([ID], [username], [pass]) VALUES (1, N'admin', N'12345')
INSERT [dbo].[Nguoidung] ([ID], [username], [pass]) VALUES (2, N'annv', N'12345')
SET IDENTITY_INSERT [dbo].[Nguoidung] OFF
GO
SET IDENTITY_INSERT [dbo].[NhomSP] ON 

INSERT [dbo].[NhomSP] ([Manhom], [Tennhom]) VALUES (1, N'Cafe')
INSERT [dbo].[NhomSP] ([Manhom], [Tennhom]) VALUES (2, N'Nuoc uong')
SET IDENTITY_INSERT [dbo].[NhomSP] OFF
GO
SET IDENTITY_INSERT [dbo].[Sanpham] ON 

INSERT [dbo].[Sanpham] ([IDSP], [Manhom], [MaSP], [TenSP], [Dvt], [Giaban], [img]) VALUES (3, 1, N'02', N'Cafe sữa đá', N'ly', CAST(14000 AS Decimal(18, 0)), N'giaynam723089.jpg')
INSERT [dbo].[Sanpham] ([IDSP], [Manhom], [MaSP], [TenSP], [Dvt], [Giaban], [img]) VALUES (4, 1, N'01', N'Cafe đen đá', N'ly', CAST(12000 AS Decimal(18, 0)), N'giaynam723089.jpg')
INSERT [dbo].[Sanpham] ([IDSP], [Manhom], [MaSP], [TenSP], [Dvt], [Giaban], [img]) VALUES (5, 2, N'03', N'Pepsi', N'chai', CAST(11000 AS Decimal(18, 0)), N'giaynam723089.jpg')
SET IDENTITY_INSERT [dbo].[Sanpham] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Sanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Sanpham] ON [dbo].[Sanpham]
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sanpham]  WITH CHECK ADD  CONSTRAINT [FK_Sanpham_NhomSP] FOREIGN KEY([Manhom])
REFERENCES [dbo].[NhomSP] ([Manhom])
GO
ALTER TABLE [dbo].[Sanpham] CHECK CONSTRAINT [FK_Sanpham_NhomSP]
GO
/****** Object:  StoredProcedure [dbo].[usp_DelSanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_UpdCompany
	@ID				= 6,
	@CompanyName	= 'Zulu-Yanke Company',
	@CompAddress	= null,
	@CompContactNo	= '(777) 852 7401'

select * from dbo.Companies;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to Delete a single Company based on its ID

Create   PROCEDURE [dbo].[usp_DelSanpham]
	@ID		int
AS
BEGIN
	DELETE	FROM dbo.Sanpham
	WHERE	IDSP = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetNhoms]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_GetNhoms]
AS
BEGIN
	SELECT	Manhom
			,Tennhom
	FROM	dbo.NhomSP
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetProducts]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************
	Create Stored Procedures for Companies table
*/
----------------------------------------------------------------------------
--	Stored Procedure to return a list of all the companies
CREATE PROCEDURE [dbo].[usp_GetProducts]
(@NhomID int)
AS
BEGIN
	SELECT dbo.Sanpham.IDSP, dbo.NhomSP.Tennhom, dbo.Sanpham.MaSP, dbo.Sanpham.TenSP, dbo.Sanpham.Dvt, dbo.Sanpham.Giaban, dbo.Sanpham.img
	FROM     dbo.Sanpham INNER JOIN
					dbo.NhomSP ON dbo.Sanpham.Manhom = dbo.NhomSP.Manhom
	where dbo.Sanpham.Manhom=@NhomID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*	To run the Stored Procedure you would execute the following:
EXEC dbo.usp_GetCompanies;
go
*/

----------------------------------------------------------------------------
--	Stored Procedure to return a single Company based on an ID

CREATE  PROCEDURE [dbo].[usp_GetSanpham]
	@ID		int
AS
BEGIN
	SELECT	IDSP
			,TenSP
			,MaSP
			,Dvt
			,Giaban
			,img
			,dbo.Sanpham.Manhom
	FROM	dbo.Sanpham inner join NhomSP on dbo.Sanpham.Manhom=dbo.NhomSP.Manhom
	WHERE	IDSP = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_InsSanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_InsSanpham]
	@TenSP	nvarchar(50),
	@MaSP	nvarchar(20),
	@Dvt	nvarchar(10),
	@Gia	decimal,
	@NhomID			int
AS
BEGIN
	INSERT INTO [dbo].[Sanpham]
				([TenSP]
				,[MaSP]
				,[Dvt]
				,[Giaban]
				,[Manhom])
		 VALUES
				(@TenSP
				,@MaSP
				,@Dvt
				,@Gia
				,@NhomID)
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdSanpham]    Script Date: 14/02/2024 14:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_UpdSanpham]
	@ID				int			= null,
	@TenSP	nvarchar(50)	= null,
	@MaSP		nvarchar(20) = null,
	@Dvt			nvarchar(10) = null,
	@Gia			decimal = null,
	@NhomID			int = null
AS
BEGIN
	UPDATE	[dbo].[Sanpham]
	SET		TenSP		= ISNULL(@TenSP	,TenSP)
			,MaSP			= ISNULL(@MaSP, MaSP)
			,Dvt				= ISNULL(@Dvt			,Dvt)
			,Giaban	= ISNULL(@Gia	, Giaban)
			,Manhom	= ISNULL(@NhomID,  Manhom	)
	WHERE	IDSP = @ID
END;
GO
USE [master]
GO
ALTER DATABASE [Vidu] SET  READ_WRITE 
GO

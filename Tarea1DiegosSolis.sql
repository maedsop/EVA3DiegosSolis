USE [master]
GO
/****** Object:  Database [Tarea1]    Script Date: 18-07-2022 12:33:30 ******/
CREATE DATABASE [Tarea1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tarea1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Tarea1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tarea1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Tarea1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Tarea1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tarea1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tarea1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tarea1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tarea1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tarea1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tarea1] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tarea1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tarea1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tarea1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tarea1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tarea1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tarea1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tarea1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tarea1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tarea1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tarea1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Tarea1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tarea1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tarea1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tarea1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tarea1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tarea1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tarea1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tarea1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Tarea1] SET  MULTI_USER 
GO
ALTER DATABASE [Tarea1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tarea1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tarea1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tarea1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tarea1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Tarea1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Tarea1] SET QUERY_STORE = OFF
GO
USE [Tarea1]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 18-07-2022 12:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[Id] [int] NOT NULL,
	[Nombre] [nchar](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 18-07-2022 12:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[Id] [int] NOT NULL,
	[Nombre] [nchar](30) NOT NULL,
	[Descripcion] [nchar](200) NOT NULL,
	[Precio] [int] NOT NULL,
	[Stock] [int] NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[Imagen] [nchar](200) NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 18-07-2022 12:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[email] [nchar](320) NOT NULL,
	[nombre] [nchar](100) NOT NULL,
	[pass] [nchar](15) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (1, N'Laptoppp                                          ')
INSERT [dbo].[Categoria] ([Id], [Nombre]) VALUES (2, N'Categoria                                         ')
GO
INSERT [dbo].[Producto] ([Id], [Nombre], [Descripcion], [Precio], [Stock], [IdCategoria], [Imagen]) VALUES (1, N'Nombre                        ', N'Desc                                                                                                                                                                                                    ', 1234, 12, 1, NULL)
INSERT [dbo].[Producto] ([Id], [Nombre], [Descripcion], [Precio], [Stock], [IdCategoria], [Imagen]) VALUES (2, N'Demo                          ', N'Demo                                                                                                                                                                                                    ', 1990, 20, 1, N'2.png                                                                                                                                                                                                   ')
GO
INSERT [dbo].[Usuario] ([email], [nombre], [pass]) VALUES (N'm@s.com                                                                                                                                                                                                                                                                                                                         ', N'martin                                                                                              ', N'123123         ')
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Categoria] FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[Categoria] ([Id])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Categoria]
GO
USE [master]
GO
ALTER DATABASE [Tarea1] SET  READ_WRITE 
GO

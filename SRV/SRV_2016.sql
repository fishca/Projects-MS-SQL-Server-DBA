ALTER DATABASE [SRV] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SRV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SRV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SRV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SRV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SRV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SRV] SET ARITHABORT OFF 
GO
ALTER DATABASE [SRV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SRV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SRV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SRV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SRV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SRV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SRV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SRV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SRV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SRV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SRV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SRV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SRV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SRV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SRV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SRV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SRV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SRV] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SRV] SET  MULTI_USER 
GO
ALTER DATABASE [SRV] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [SRV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SRV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SRV] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SRV] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SRV', N'ON'
GO
ALTER DATABASE [SRV] SET QUERY_STORE = OFF
GO
USE [SRV]
GO
--ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
--GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [SRV]
GO
/****** Object:  Schema [dll]    Script Date: 07.03.2018 11:22:32 ******/
CREATE SCHEMA [dll]
GO
/****** Object:  Schema [inf]    Script Date: 07.03.2018 11:22:32 ******/
CREATE SCHEMA [inf]
GO
/****** Object:  Schema [nav]    Script Date: 07.03.2018 11:22:32 ******/
CREATE SCHEMA [nav]
GO
/****** Object:  Schema [rep]    Script Date: 07.03.2018 11:22:32 ******/
CREATE SCHEMA [rep]
GO
/****** Object:  Schema [srv]    Script Date: 07.03.2018 11:22:32 ******/
CREATE SCHEMA [srv]
GO
/****** Object:  UserDefinedFunction [rep].[GetDateFormat]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [rep].[GetDateFormat] 
(
	@dt datetime, -- ������� ����
	@format int=0 -- �������� ������
)
RETURNS nvarchar(255)
AS
/*
	15.04.2014 ���:
	���������� ���� � ���� ������ �� ��������� ������� � ������� ����
	����������� ����������� ����:
	������	������� ����	���������
	0		17.4.2014		"17.04.2014"
	1		17.4.2014		"04.2014"
	1		8.11.2014		"11.2014"
	2		17.04.2014		"2014"
*/
BEGIN
	DECLARE @res nvarchar(255);
	DECLARE @day int=DAY(@dt);
	DECLARE @month int=MONTH(@dt);
	DECLARE @year int=YEAR(@dt);

	if(@format=0)
	begin
		set @res=IIF(@day<10,'0'+cast(@day as nvarchar(1)), cast(@day as nvarchar(2)))+'.';
		set @res=@res+IIF(@month<10,'0'+cast(@month as nvarchar(1)), cast(@month as nvarchar(2)))+'.';
		set @res=@res+cast(@year as nvarchar(255));
	end
	else if(@format=1)
	begin
		set @res=IIF(@month<10,'0'+cast(@month as nvarchar(1)), cast(@month as nvarchar(2)))+'.';
		set @res=@res+cast(@year as nvarchar(255));
	end
	else if(@format=2)
	begin
		set @res=cast(@year as nvarchar(255));
	end

	RETURN @res;

END


GO
/****** Object:  UserDefinedFunction [rep].[GetNameMonth]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [rep].[GetNameMonth]
(
	@Month_Num int -- �������� ����� ������
)
RETURNS nvarchar(256)
AS
/*
	15.04.2014 ���:
	���������� ������� �������� ������ �� ��������� ��� ������
*/
BEGIN
	declare @Month_Name nvarchar(256);
	set @Month_Name=case @Month_Num
					when 1 then '������'
					when 2 then '�������'
					when 3 then '����'
					when 4 then '������'
					when 5 then '���'
					when 6 then '����'
					when 7 then '����'
					when 8 then '������'
					when 9 then '��������'
					when 10 then '�������'
					when 11 then '������'
					when 12 then '�������'
					end
	return @Month_Name;

END


GO
/****** Object:  UserDefinedFunction [rep].[GetNumMonth]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [rep].[GetNumMonth]
(
	@Month_Name nvarchar(256) -- �������� �������� ������ ��-������
)
RETURNS int
AS
/*
	15.04.2014 ���:
	���������� ����� ������ �� ��� ��������� �������� ��-������
*/
BEGIN
	declare @Month_Num int;
	set @Month_Num=case ltrim(rtrim(@Month_Name))
					when '������' then 1
					when '�������' then 2
					when '����' then 3
					when '������' then 4
					when '���' then 5
					when '����' then 6
					when '����' then 7
					when '������' then 8
					when '��������' then 9
					when '�������' then 10
					when '������' then 11
					when '�������' then 12
					end
	return @Month_Num;

END


GO
/****** Object:  UserDefinedFunction [rep].[GetTimeFormat]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [rep].[GetTimeFormat] 
(
	@dt datetime, -- ������� �����
	@format int=0 -- �������� ������
)
RETURNS nvarchar(255)
AS
/*
	15.04.2014 ���:
	���������� ����� � ���� ������ �� ��������� ������� � �������� �������
	����������� ����������� ����:
	������	������� �����	���������
	0		17:04			"17:04:00"
	1		17:04			"17:04"
	1		8:04			"08:04"
	2		17:04			"17"
*/
BEGIN
	DECLARE @res nvarchar(255);
	DECLARE @hour int=DATEPART(HOUR, @dt);
	DECLARE @min int=DATEPART(MINUTE, @dt);
	DECLARE @sec int=DATEPART(SECOND, @dt);

	if(@format=0)
	begin
		set @res=IIF(@hour<10,'0'+cast(@hour as nvarchar(1)), cast(@hour as nvarchar(2)))+':';
		set @res=@res+IIF(@min<10,'0'+cast(@min as nvarchar(1)), cast(@min as nvarchar(2)))+':';
		set @res=@res+IIF(@sec<10,'0'+cast(@sec as nvarchar(1)), cast(@sec as nvarchar(2)));
	end
	else if(@format=1)
	begin
		set @res=IIF(@hour<10,'0'+cast(@hour as nvarchar(1)), cast(@hour as nvarchar(2)))+':';
		set @res=@res+IIF(@min<10,'0'+cast(@min as nvarchar(1)), cast(@min as nvarchar(2)));
	end
	else if(@format=2)
	begin
		set @res=IIF(@hour<10,'0'+cast(@hour as nvarchar(1)), cast(@hour as nvarchar(2)));
	end

	RETURN @res;

END

GO
/****** Object:  UserDefinedFunction [srv].[GetNumericNormalize]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [srv].[GetNumericNormalize]
(
	@str nvarchar(256) -- ������� ����� � ���� ������
)
RETURNS nvarchar(256)
AS
/*
	15.04.2014 ���:
	� �������� ����� � ���� ������ �������� ������ ���� ����� �������
*/
BEGIN
	declare @ind int;
	set @ind=0;
	declare @result nvarchar(256);

	if(PATINDEX('%.%', @str)>0)
	begin
		while(substring(@str, len(@str)-@ind,1)='0') set @ind=@ind+1;
		set @result=left(@str, len(@str)-@ind);
		if(right(@result,1)='.') set @result=left(@result, len(@result)-1);
	end
	
	RETURN @result;
END

GO
/****** Object:  Table [srv].[Defrag]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[Defrag](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[db] [nvarchar](100) NOT NULL,
	[shema] [nvarchar](100) NOT NULL,
	[table] [nvarchar](100) NOT NULL,
	[IndexName] [nvarchar](100) NOT NULL,
	[frag_num] [int] NOT NULL,
	[frag] [decimal](6, 2) NOT NULL,
	[page] [int] NOT NULL,
	[rec] [int] NULL,
	[ts] [datetime] NOT NULL,
	[tf] [datetime] NOT NULL,
	[frag_after] [decimal](6, 2) NOT NULL,
	[object_id] [int] NOT NULL,
	[idx] [int] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Defrag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vStatisticDefrag]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [srv].[vStatisticDefrag] as
SELECT top 1000
	  [db]
	  ,[shema]
      ,[table]
      ,[IndexName]
      ,avg([frag]) as AvgFrag
      ,avg([frag_after]) as AvgFragAfter
	  ,avg(page) as AvgPage
  FROM [srv].[Defrag]
  group by [db], [shema], [table], [IndexName]
  order by abs(avg([frag])-avg([frag_after])) desc




GO
/****** Object:  Table [srv].[TableStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[TableStatistics](
	[Row_GUID] [uniqueidentifier] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[DBName] [nvarchar](255) NOT NULL,
	[SchemaName] [nvarchar](255) NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[CountRows] [bigint] NOT NULL,
	[DataKB] [int] NOT NULL,
	[IndexSizeKB] [int] NOT NULL,
	[UnusedKB] [int] NOT NULL,
	[ReservedKB] [int] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[Date]  AS (CONVERT([date],[InsertUTCDate])) PERSISTED,
	[CountRowsBack] [bigint] NULL,
	[CountRowsNext] [bigint] NULL,
	[DataKBBack] [int] NULL,
	[DataKBNext] [int] NULL,
	[IndexSizeKBBack] [int] NULL,
	[IndexSizeKBNext] [int] NULL,
	[UnusedKBBack] [int] NULL,
	[UnusedKBNext] [int] NULL,
	[ReservedKBBack] [int] NULL,
	[ReservedKBNext] [int] NULL,
	[AvgCountRows]  AS ((([CountRowsBack]+[CountRows])+[CountRowsNext])/(3)) PERSISTED,
	[AvgDataKB]  AS ((([DataKBBack]+[DataKB])+[DataKBNext])/(3)) PERSISTED,
	[AvgIndexSizeKB]  AS ((([IndexSizeKBBack]+[IndexSizeKB])+[IndexSizeKBNext])/(3)) PERSISTED,
	[AvgUnusedKB]  AS ((([UnusedKBBack]+[UnusedKB])+[UnusedKBNext])/(3)) PERSISTED,
	[AvgReservedKB]  AS ((([ReservedKBBack]+[ReservedKB])+[ReservedKBNext])/(3)) PERSISTED,
	[DiffCountRows]  AS (([CountRowsNext]+[CountRowsBack])-(2)*[CountRows]) PERSISTED,
	[DiffDataKB]  AS (([DataKBNext]+[DataKBBack])-(2)*[DataKB]) PERSISTED,
	[DiffIndexSizeKB]  AS (([IndexSizeKBNext]+[IndexSizeKBBack])-(2)*[IndexSizeKB]) PERSISTED,
	[DiffUnusedKB]  AS (([UnusedKBNext]+[UnusedKBBack])-(2)*[UnusedKB]) PERSISTED,
	[DiffReservedKB]  AS (([ReservedKBNext]+[ReservedKBBack])-(2)*[ReservedKB]) PERSISTED,
	[TotalPageSizeKB] [int] NULL,
	[TotalPageSizeKBBack] [int] NULL,
	[TotalPageSizeKBNext] [int] NULL,
	[UsedPageSizeKB] [int] NULL,
	[UsedPageSizeKBBack] [int] NULL,
	[UsedPageSizeKBNext] [int] NULL,
	[DataPageSizeKB] [int] NULL,
	[DataPageSizeKBBack] [int] NULL,
	[DataPageSizeKBNext] [int] NULL,
	[AvgDataPageSizeKB]  AS ((([DataPageSizeKBBack]+[DataPageSizeKB])+[DataPageSizeKBNext])/(3)) PERSISTED,
	[AvgUsedPageSizeKB]  AS ((([UsedPageSizeKBBack]+[UsedPageSizeKB])+[UsedPageSizeKBNext])/(3)) PERSISTED,
	[AvgTotalPageSizeKB]  AS ((([TotalPageSizeKBBack]+[TotalPageSizeKB])+[TotalPageSizeKBNext])/(3)) PERSISTED,
	[DiffDataPageSizeKB]  AS (([DataPageSizeKBNext]+[DataPageSizeKBBack])-(2)*[DataPageSizeKB]) PERSISTED,
	[DiffUsedPageSizeKB]  AS (([UsedPageSizeKBNext]+[UsedPageSizeKBBack])-(2)*[UsedPageSizeKB]) PERSISTED,
	[DiffTotalPageSizeKB]  AS (([TotalPageSizeKBNext]+[TotalPageSizeKBBack])-(2)*[TotalPageSizeKB]) PERSISTED,
 CONSTRAINT [PK_TableStatistics] PRIMARY KEY CLUSTERED 
(
	[Row_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vTableStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [srv].[vTableStatistics] as
SELECT [ServerName]
	  ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,MIN([CountRows]) as MinCountRows
	  ,MAX([CountRows]) as MaxCountRows
	  ,AVG([CountRows]) as AvgCountRows
	  ,MAX([CountRows])-MIN([CountRows]) as AbsDiffCountRows
	  ,MIN([DataKB]) as MinDataKB
	  ,MAX([DataKB]) as MaxDataKB
	  ,AVG([DataKB]) as AvgDataKB
	  ,MAX([DataKB])-MIN([DataKB]) as AbsDiffDataKB
	  ,MIN([IndexSizeKB]) as MinIndexSizeKB
	  ,MAX([IndexSizeKB]) as MaxIndexSizeKB
	  ,AVG([IndexSizeKB]) as AvgIndexSizeKB
	  ,MAX([IndexSizeKB])-MIN([IndexSizeKB]) as AbsDiffIndexSizeKB
	  ,MIN([UnusedKB]) as MinUnusedKB
	  ,MAX([UnusedKB]) as MaxUnusedKB
	  ,AVG([UnusedKB]) as AvgUnusedKB
	  ,MAX([UnusedKB])-MIN([UnusedKB]) as AbsDiffUnusedKB
	  ,MIN([ReservedKB]) as MinReservedKB
	  ,MAX([ReservedKB]) as MaxReservedKB
	  ,AVG([ReservedKB]) as AvgReservedKB
	  ,MAX([ReservedKB])-MIN([ReservedKB]) as AbsDiffReservedKB
	  ,MIN([TotalPageSizeKB]) as MinTotalPageSizeKB
	  ,MAX([TotalPageSizeKB]) as MaxTotalPageSizeKB
	  ,AVG([TotalPageSizeKB]) as AvgTotalPageSizeKB
	  ,MAX([TotalPageSizeKB])-MIN([TotalPageSizeKB]) as AbsDiffTotalPageSizeKB
	  ,count(*) as CountRowsStatistic
	  ,MIN(InsertUTCDate) as StartInsertUTCDate
	  ,MAX(InsertUTCDate) as FinishInsertUTCDate
  FROM [srv].[TableStatistics]
  group by [ServerName]
	  ,[DBName]
      ,[SchemaName]
      ,[TableName]


GO
/****** Object:  View [srv].[vDBSizeStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [srv].[vDBSizeStatistics] as 
SELECT [ServerName]
      ,[DBName]
      ,SUM([MinCountRows])			as [MinCountRows]
      ,SUM([MaxCountRows])			as [MaxCountRows]
      ,SUM([AvgCountRows])			as [AvgCountRows]
      ,SUM([MinDataKB])				as [MinDataKB]
      ,SUM([MaxDataKB])				as [MaxDataKB]
      ,SUM([AvgDataKB])				as [AvgDataKB]
      ,SUM([MinIndexSizeKB])		as [MinIndexSizeKB]
      ,SUM([MaxIndexSizeKB])		as [MaxIndexSizeKB]
      ,SUM([AvgIndexSizeKB])		as [AvgIndexSizeKB]
      ,SUM([MinUnusedKB])			as [MinUnusedKB]
      ,SUM([MaxUnusedKB])			as [MaxUnusedKB]
      ,SUM([AvgUnusedKB])			as [AvgUnusedKB]
      ,SUM([MinReservedKB])			as [MinReservedKB]
      ,SUM([MaxReservedKB])			as [MaxReservedKB]
      ,SUM([AvgReservedKB])			as [AvgReservedKB]
	  ,SUM([MinTotalPageSizeKB])	as [MinTotalPageSizeKB]
      ,SUM([MaxTotalPageSizeKB])	as [MaxTotalPageSizeKB]
      ,SUM([AvgTotalPageSizeKB])	as [AvgTotalPageSizeKB]
      ,SUM([CountRowsStatistic])	as [CountRowsStatistic]
      ,MIN([StartInsertUTCDate])	as [StartInsertUTCDate]
      ,MAX([FinishInsertUTCDate])	as [FinishInsertUTCDate]
  FROM [srv].[vTableStatistics]
  group by [ServerName], [DBName]
GO
/****** Object:  View [inf].[ServerDBFileInfo]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[ServerDBFileInfo] as
SELECT  @@Servername AS Server ,
        File_id ,--������������� ����� � ���� ������. �������� �������� file_id ������ ����� 1
        Type_desc ,--�������� ���� �����
        Name as [FileName] ,--���������� ��� ����� � ���� ������
        LEFT(Physical_Name, 1) AS Drive ,--����� ����, ��� ������������� ���� ��
        Physical_Name ,--������ ��� ����� � ������������ �������
        RIGHT(physical_name, 3) AS Ext ,--���������� �����
        Size as CountPage, --������� ������ ����� � ��������� �� 8 ��
		round((cast(Size*8 as float))/1024,3) as SizeMb, --������ ����� � ��
		round((cast(Size*8 as float))/1024/1024,3) as SizeGb, --������ ����� � ��
        case when is_percent_growth=0 then Growth*8 else 0 end as Growth, --������� ����� � ��������� �� 8 ��
		case when is_percent_growth=0 then round((cast(Growth*8 as float))/1024,3) end as GrowthMb, --������� ����� � ��
		case when is_percent_growth=0 then round((cast(Growth*8 as float))/1024/1024,3) end as GrowthGb, --������� ����� � ��
		case when is_percent_growth=1 then Growth else 0 end as GrowthPercent, --������� ����� � ����� ���������
		is_percent_growth, --������� ����������� ����������
		database_id,
		DB_Name(database_id) as [DB_Name],
		State,--��������� �����
		state_desc as StateDesc,--�������� ��������� �����
		is_media_read_only as IsMediaReadOnly,--���� ��������� �� �������� ������ ��� ������ (0-� ��� ������)
		is_read_only as IsReadOnly,--���� ������� ��� ���� ������ ��� ������ (0-� ������)
		is_sparse as IsSpace,--����������� ����
		is_name_reserved as IsNameReserved,--1 - ��� ���������� �����, �������� ��� �������������.
		--���������� �������� ��������� ����� �������, ������ ��� ������� �������� ������������ ��� (��������� name ��� physical_name) ��� ������ ����� �����
		--0 - ��� �����, ���������� ��� ������������
		create_lsn as CreateLsn,--��������������� ����� ���������� � ������� (LSN), �� ������� ������ ����
		drop_lsn as DropLsn,--����� LSN, � ������� ���� ������
		read_only_lsn as ReadOnlyLsn,--����� LSN, �� ������� �������� ������, ���������� ����, �������� ��� � ���� ������ � ������ �� ������� ��� ������� (����� ��������� ���������)
		read_write_lsn as ReadWriteLsn,--����� LSN, �� ������� �������� ������, ���������� ����, �������� ��� � ������� ��� ������� �� ���� ������ � ������ (����� ��������� ���������)
		differential_base_lsn as DifferentialBaseLsn,--������ ��� ���������� ��������� �����. �������� ������, ���������� ����� ����, ��� ���� ����� LSN ����� ������� � ���������� ��������� �����
		differential_base_guid as DifferentialBaseGuid,--���������� ������������� ������� ��������� �����, �� ������� ����� ������������ ���������� ��������� �����
		differential_base_time as DifferentialBaseTime,--�����, ��������������� differential_base_lsn
		redo_start_lsn as RedoStartLsn,--����� LSN, � �������� ������ �������� ��������� �����
		--����� NULL, �� ����������� �������, ����� �������� ��������� state = RESTORING ��� �������� ��������� state = RECOVERY_PENDING
		redo_start_fork_guid as RedoStartForkGuid,--���������� ������������� ����� ����� ��������������.
		--�������� ��������� first_fork_guid ��������� ��������������� ��������� ����� ������� ������ ��������������� ����� ��������. ��� �������� ������� ��������� ����������
		redo_target_lsn as RedoTargetLsn,--����� LSN, �� ������� ����� � ������ �� ���� �� ������� ����� ����� ������������
		--����� NULL, �� ����������� �������, ����� �������� ��������� state = RESTORING ��� �������� ��������� state = RECOVERY_PENDING
		redo_target_fork_guid as RedoTargetForkGuid,--����� ��������������, �� ������� ����� ���� ������������ ���������. ������������ � ���� � redo_target_lsn
		backup_lsn as BackupLsn--����� LSN ����� ����� ������ ��� ���������� ��������� ����� �����
FROM    sys.master_files--database_files

GO
/****** Object:  View [srv].[vDBSizeShortStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vDBSizeShortStatistics] as
with tbl1 as (
SELECT [DBName]
      ,cast([MinTotalPageSizeKB] as decimal(18,3))/1024 as [MinTotalPageSizeMB]
      ,cast([MaxTotalPageSizeKB] as decimal(18,3))/1024 as [MaxTotalPageSizeMB]
	  ,cast(([MaxTotalPageSizeKB]-[MinTotalPageSizeKB]) as decimal(18,3))/1024 as [DiffTotalPageSizeMB]
      ,cast([StartInsertUTCDate] as DATE) as [StartDate]
      ,cast([FinishInsertUTCDate] as DATE) as [FinishDate]
  FROM [srv].[vDBSizeStatistics]
  where [ServerName]=@@SERVERNAME
)
SELECT [DB_Name] as [DBName]
      ,sum([SizeMb]) as [CurrentSizeMb]
      ,sum([SizeGb]) as [CurrentSizeGb]
	  ,min([MinTotalPageSizeMB]) as [MinTotalPageSizeMB]
	  ,min([MaxTotalPageSizeMB]) as [MaxTotalPageSizeMB]
	  ,min([DiffTotalPageSizeMB]) as [DiffTotalPageSizeMB]
	  ,min([StartDate]) as [StartDate]
	  ,min([FinishDate]) as [FinishDate]
  FROM tbl1
  inner join [inf].[ServerDBFileInfo] as tbl2 on tbl1.[DBName]=tbl2.[DB_Name]
  group by [DB_Name]
GO
/****** Object:  Table [srv].[QueryRequestGroupStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[QueryRequestGroupStatistics](
	[DBName] [nvarchar](max) NULL,
	[TSQL] [nvarchar](max) NOT NULL,
	[Count] [bigint] NOT NULL,
	[mintotal_elapsed_timeSec] [decimal](23, 3) NOT NULL,
	[maxtotal_elapsed_timeSec] [decimal](23, 3) NOT NULL,
	[mincpu_timeSec] [decimal](23, 3) NOT NULL,
	[maxcpu_timeSec] [decimal](23, 3) NOT NULL,
	[minwait_timeSec] [decimal](23, 3) NOT NULL,
	[maxwait_timeSec] [decimal](23, 3) NOT NULL,
	[row_count] [bigint] NOT NULL,
	[SumCountRows] [bigint] NOT NULL,
	[min_reads] [bigint] NOT NULL,
	[max_reads] [bigint] NOT NULL,
	[min_writes] [bigint] NOT NULL,
	[max_writes] [bigint] NOT NULL,
	[min_logical_reads] [bigint] NOT NULL,
	[max_logical_reads] [bigint] NOT NULL,
	[min_open_transaction_count] [bigint] NOT NULL,
	[max_open_transaction_count] [bigint] NOT NULL,
	[min_transaction_isolation_level] [bigint] NOT NULL,
	[max_transaction_isolation_level] [bigint] NOT NULL,
	[Unique_nt_user_name] [nvarchar](max) NULL,
	[Unique_nt_domain] [nvarchar](max) NULL,
	[Unique_login_name] [nvarchar](max) NULL,
	[Unique_program_name] [nvarchar](max) NULL,
	[Unique_host_name] [nvarchar](max) NULL,
	[Unique_client_tcp_port] [nvarchar](max) NULL,
	[Unique_client_net_address] [nvarchar](max) NULL,
	[Unique_client_interface_name] [nvarchar](max) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[sql_handle] [varbinary](64) NOT NULL,
 CONSTRAINT [PK_QueryRequestGroupStatistics] PRIMARY KEY CLUSTERED 
(
	[sql_handle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [srv].[vQueryRequestGroupStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vQueryRequestGroupStatistics] as
SELECT [DBName]
      ,[TSQL]
      ,[Count]
      ,[mintotal_elapsed_timeSec]
      ,[maxtotal_elapsed_timeSec]
      ,[mincpu_timeSec]
      ,[maxcpu_timeSec]
      ,[minwait_timeSec]
      ,[maxwait_timeSec]
      ,[row_count]
      ,[SumCountRows]
      ,[min_reads]
      ,[max_reads]
      ,[min_writes]
      ,[max_writes]
      ,[min_logical_reads]
      ,[max_logical_reads]
      ,[min_open_transaction_count]
      ,[max_open_transaction_count]
      ,[min_transaction_isolation_level]
      ,[max_transaction_isolation_level]
      ,[Unique_nt_user_name]
      ,[Unique_nt_domain]
      ,[Unique_login_name]
      ,[Unique_program_name]
      ,[Unique_host_name]
      ,[Unique_client_tcp_port]
      ,[Unique_client_net_address]
      ,[Unique_client_interface_name]
      ,[InsertUTCDate]
  FROM [srv].[QueryRequestGroupStatistics]
GO
/****** Object:  Table [srv].[BackupSettings]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[BackupSettings](
	[DBID] [int] NOT NULL,
	[FullPathBackup] [nvarchar](255) NOT NULL,
	[DiffPathBackup] [nvarchar](255) NULL,
	[LogPathBackup] [nvarchar](255) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BackupSettings_1] PRIMARY KEY CLUSTERED 
(
	[DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vBackupSettings]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [srv].[vBackupSettings]
as
SELECT [DBID]
      ,DB_Name([DBID]) as [DBName]
	  ,[FullPathBackup]
      ,[DiffPathBackup]
      ,[LogPathBackup]
      ,[InsertUTCDate]
  FROM [srv].[BackupSettings]
GO
/****** Object:  Table [srv].[RestoreSettings]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[RestoreSettings](
	[DBName] [nvarchar](255) NOT NULL,
	[FullPathRestore] [nvarchar](255) NOT NULL,
	[DiffPathRestore] [nvarchar](255) NOT NULL,
	[LogPathRestore] [nvarchar](255) NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RestoreSettings_1] PRIMARY KEY CLUSTERED 
(
	[DBName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vRestoreSettings]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vRestoreSettings]
as
SELECT [DBName]
      ,[FullPathRestore]
      ,[DiffPathRestore]
      ,[LogPathRestore]
      ,[InsertUTCDate]
  FROM [srv].[RestoreSettings]
GO
/****** Object:  Table [srv].[TableIndexStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[TableIndexStatistics](
	[Row_GUID] [uniqueidentifier] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[DBName] [nvarchar](255) NULL,
	[SchemaName] [nvarchar](255) NULL,
	[TableName] [nvarchar](255) NULL,
	[IndexUsedForCounts] [nvarchar](255) NULL,
	[CountRows] [bigint] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TableIndexStatistics] PRIMARY KEY CLUSTERED 
(
	[Row_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vTableIndexStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [srv].[vTableIndexStatistics] as
SELECT [ServerName]
	  ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[IndexUsedForCounts]
      ,MIN([CountRows]) as MinCountRows
	  ,MAX([CountRows]) as MaxCountRows
	  ,AVG([CountRows]) as AvgCountRows
	  ,MAX([CountRows])-MIN([CountRows]) as AbsDiffCountRows
	  ,count(*) as CountRowsStatistic
	  ,MIN(InsertUTCDate) as StartInsertUTCDate
	  ,MAX(InsertUTCDate) as FinishInsertUTCDate
  FROM [srv].[TableIndexStatistics]
  group by [ServerName]
	  ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[IndexUsedForCounts]


GO
/****** Object:  Table [srv].[PlanQuery]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[PlanQuery](
	[PlanHandle] [varbinary](64) NOT NULL,
	[SQLHandle] [varbinary](64) NOT NULL,
	[QueryPlan] [xml] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[dop] [smallint] NULL,
	[request_time] [datetime] NULL,
	[grant_time] [datetime] NULL,
	[requested_memory_kb] [bigint] NULL,
	[granted_memory_kb] [bigint] NULL,
	[required_memory_kb] [bigint] NULL,
	[used_memory_kb] [bigint] NULL,
	[max_used_memory_kb] [bigint] NULL,
	[query_cost] [float] NULL,
	[timeout_sec] [int] NULL,
	[resource_semaphore_id] [smallint] NULL,
	[queue_id] [smallint] NULL,
	[wait_order] [int] NULL,
	[is_next_candidate] [bit] NULL,
	[wait_time_ms] [bigint] NULL,
	[pool_id] [int] NULL,
	[is_small] [bit] NULL,
	[ideal_memory_kb] [bigint] NULL,
	[reserved_worker_count] [int] NULL,
	[used_worker_count] [int] NULL,
	[max_used_worker_count] [int] NULL,
	[reserved_node_bitmap] [bigint] NULL,
	[bucketid] [int] NULL,
	[refcounts] [int] NULL,
	[usecounts] [int] NULL,
	[size_in_bytes] [int] NULL,
	[memory_object_address] [varbinary](8) NULL,
	[cacheobjtype] [nvarchar](50) NULL,
	[objtype] [nvarchar](20) NULL,
	[parent_plan_handle] [varbinary](64) NULL,
	[creation_time] [datetime] NULL,
	[execution_count] [bigint] NULL,
	[total_worker_time] [bigint] NULL,
	[min_last_worker_time] [bigint] NULL,
	[max_last_worker_time] [bigint] NULL,
	[min_worker_time] [bigint] NULL,
	[max_worker_time] [bigint] NULL,
	[total_physical_reads] [bigint] NULL,
	[min_last_physical_reads] [bigint] NULL,
	[max_last_physical_reads] [bigint] NULL,
	[min_physical_reads] [bigint] NULL,
	[max_physical_reads] [bigint] NULL,
	[total_logical_writes] [bigint] NULL,
	[min_last_logical_writes] [bigint] NULL,
	[max_last_logical_writes] [bigint] NULL,
	[min_logical_writes] [bigint] NULL,
	[max_logical_writes] [bigint] NULL,
	[total_logical_reads] [bigint] NULL,
	[min_last_logical_reads] [bigint] NULL,
	[max_last_logical_reads] [bigint] NULL,
	[min_logical_reads] [bigint] NULL,
	[max_logical_reads] [bigint] NULL,
	[total_clr_time] [bigint] NULL,
	[min_last_clr_time] [bigint] NULL,
	[max_last_clr_time] [bigint] NULL,
	[min_clr_time] [bigint] NULL,
	[max_clr_time] [bigint] NULL,
	[min_last_elapsed_time] [bigint] NULL,
	[max_last_elapsed_time] [bigint] NULL,
	[min_elapsed_time] [bigint] NULL,
	[max_elapsed_time] [bigint] NULL,
	[total_rows] [bigint] NULL,
	[min_last_rows] [bigint] NULL,
	[max_last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[min_last_dop] [bigint] NULL,
	[max_last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[min_last_grant_kb] [bigint] NULL,
	[max_last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[min_last_used_grant_kb] [bigint] NULL,
	[max_last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[min_last_ideal_grant_kb] [bigint] NULL,
	[max_last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[min_last_reserved_threads] [bigint] NULL,
	[max_last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[min_last_used_threads] [bigint] NULL,
	[max_last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL,
 CONSTRAINT [PK_PlanQuery] PRIMARY KEY CLUSTERED 
(
	[SQLHandle] ASC,
	[PlanHandle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[TSQL_DAY_Statistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[TSQL_DAY_Statistics](
	[command] [nvarchar](32) NOT NULL,
	[DBName] [nvarchar](128) NOT NULL,
	[PlanHandle] [varbinary](64) NOT NULL,
	[SqlHandle] [varbinary](64) NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[min_wait_timeSec] [decimal](23, 8) NOT NULL,
	[min_estimated_completion_timeSec] [decimal](23, 8) NOT NULL,
	[min_cpu_timeSec] [decimal](23, 8) NOT NULL,
	[min_total_elapsed_timeSec] [decimal](23, 8) NOT NULL,
	[min_lock_timeoutSec] [decimal](23, 8) NOT NULL,
	[max_wait_timeSec] [decimal](23, 8) NOT NULL,
	[max_estimated_completion_timeSec] [decimal](23, 8) NOT NULL,
	[max_cpu_timeSec] [decimal](23, 8) NOT NULL,
	[max_total_elapsed_timeSec] [decimal](23, 8) NOT NULL,
	[max_lock_timeoutSec] [decimal](23, 8) NOT NULL,
	[DATE] [date] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indClustered]    Script Date: 07.03.2018 11:22:32 ******/
CREATE CLUSTERED INDEX [indClustered] ON [srv].[TSQL_DAY_Statistics]
(
	[PlanHandle] ASC,
	[SqlHandle] ASC,
	[DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [srv].[SQLQuery]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[SQLQuery](
	[SQLHandle] [varbinary](64) NOT NULL,
	[TSQL] [nvarchar](max) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SQLQuery] PRIMARY KEY CLUSTERED 
(
	[SQLHandle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [srv].[vTSQL_DAY_Statistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [srv].[vTSQL_DAY_Statistics] as
SELECT tds.[DATE]
	  ,tds.[command]
      ,tds.[DBName]
	  ,tds.[execution_count]
	  ,tds.[max_total_elapsed_timeSec]
	  ,(tds.[min_total_elapsed_timeSec]+tds.[max_total_elapsed_timeSec])/2 as [avg_total_elapsed_timeSec]
	  ,tds.[max_cpu_timeSec]
	  ,(tds.[min_cpu_timeSec]+tds.[max_cpu_timeSec])/2 as [avg_cpu_timeSec]
	  ,tds.[max_wait_timeSec]
	  ,(tds.[min_wait_timeSec]+tds.[max_wait_timeSec])/2 as [avg_wait_timeSec]
      ,tds.[max_estimated_completion_timeSec]
	  ,(tds.[min_estimated_completion_timeSec]+tds.[max_estimated_completion_timeSec])/2 as [avg_estimated_completion_timeSec]
      ,tds.[max_lock_timeoutSec]
	  ,(tds.[min_lock_timeoutSec]+tds.[max_lock_timeoutSec])/2 as [avg_lock_timeoutSec]
      ,tds.[min_wait_timeSec]
      ,tds.[min_estimated_completion_timeSec]
      ,tds.[min_cpu_timeSec]
      ,tds.[min_total_elapsed_timeSec]
      ,tds.[min_lock_timeoutSec]
	  ,tds.[PlanHandle]
      ,tds.[SqlHandle]
	  ,sq.[TSQL]
	  ,pq.[QueryPlan]
  FROM [srv].[TSQL_DAY_Statistics] as tds
  inner join [srv].[PlanQuery] as pq on pq.[PlanHandle]=tds.[PlanHandle] and pq.[SQLHandle]=tds.[SqlHandle]
  inner join [srv].[SQLQuery] as sq on sq.[SqlHandle]=tds.[SqlHandle]
GO
/****** Object:  Table [srv].[QueryStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[QueryStatistics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[creation_time] [datetime] NOT NULL,
	[last_execution_time] [datetime] NOT NULL,
	[execution_count] [bigint] NOT NULL,
	[CPU] [bigint] NULL,
	[AvgCPUTime] [money] NULL,
	[TotDuration] [bigint] NULL,
	[AvgDur] [money] NULL,
	[Reads] [bigint] NOT NULL,
	[Writes] [bigint] NOT NULL,
	[AggIO] [bigint] NULL,
	[AvgIO] [money] NULL,
	[sql_handle] [varbinary](64) NOT NULL,
	[plan_handle] [varbinary](64) NOT NULL,
	[statement_start_offset] [int] NOT NULL,
	[statement_end_offset] [int] NOT NULL,
	[database_name] [nvarchar](128) NULL,
	[object_name] [nvarchar](257) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_QueryStatistics] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [indClustQueryStatistics]    Script Date: 07.03.2018 11:22:32 ******/
CREATE CLUSTERED INDEX [indClustQueryStatistics] ON [srv].[QueryStatistics]
(
	[creation_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [srv].[vQueryStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [srv].[vQueryStatistics] as
SELECT qs.[creation_time]
      ,qs.[last_execution_time]
      ,qs.[execution_count]
      ,qs.[CPU]
      ,qs.[AvgCPUTime]/1000 as [AvgCPUTimeSec]
      ,qs.[TotDuration]
      ,qs.[AvgDur]/1000 as [AvgDurSec]
      ,qs.[Reads]
      ,qs.[Writes]
      ,qs.[AggIO]
      ,qs.[AvgIO]
      ,qs.[sql_handle]
      ,qs.[plan_handle]
      ,qs.[statement_start_offset]
      ,qs.[statement_end_offset]
      ,sq.[TSQL] as [query_text]
      ,qs.[database_name]
      ,qs.[object_name]
      ,pq.[QueryPlan] as [query_plan]
      ,qs.[InsertUTCDate]
  FROM [srv].[QueryStatistics] as qs
  inner join [srv].[PlanQuery] as pq on qs.[sql_handle]=pq.[SqlHandle] and qs.[plan_handle]=pq.[PlanHandle]
  inner join [srv].[SQLQuery] as sq on sq.[SqlHandle]=pq.[SqlHandle]
GO
/****** Object:  Table [srv].[ActiveConnectionStatistics]    Script Date: 07.03.2018 11:22:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ActiveConnectionStatistics](
	[Row_GUID] [uniqueidentifier] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[SessionID] [int] NOT NULL,
	[LoginName] [nchar](128) NOT NULL,
	[DBName] [nvarchar](128) NULL,
	[ProgramName] [nvarchar](255) NULL,
	[Status] [nchar](30) NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[EndRegUTCDate] [datetime] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ActiveConnectionStatistics] PRIMARY KEY CLUSTERED 
(
	[Row_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vActiveConnectionStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [srv].[vActiveConnectionStatistics] as
SELECT [ServerName]
	  ,[DBName]
      ,[ProgramName]
      ,[LoginName]
      ,[Status]
      ,[SessionID]
	  ,[LoginTime]
	  ,[EndRegUTCDate]
	  ,[InsertUTCDate]
  FROM [srv].[ActiveConnectionStatistics] with(readuncommitted)
GO
/****** Object:  View [srv].[vActiveConnectionShortStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vActiveConnectionShortStatistics] as
with tbl0 as (
	select [ServerName]
      ,[DBName]
	  ,[Status]
	FROM [srv].[vActiveConnectionStatistics]
	group by [ServerName]
      ,[DBName]
	  ,[Status]
	  ,YEAR([InsertUTCDate])
	  ,MONTH([InsertUTCDate])
	  ,DAY([InsertUTCDate])
	  ,DATEPART(hour,[InsertUTCDate])
	  ,DATEPART(minute,[InsertUTCDate])
)
, tbl1 as (
	select [ServerName]
      ,[DBName]
	  ,[Status]
	  ,count(*) as [count]
	FROM tbl0
	group by [ServerName]
      ,[DBName]
	  ,[Status]
)
SELECT [ServerName]
      ,[DBName]
	  ,[Status]
	  , count(*)/(select [count] from tbl1 where tbl1.[ServerName]=t.[ServerName] and tbl1.[DBName]=t.[DBName] and tbl1.[Status]=t.[Status]) as [AvgCount]
	  , min(InsertUTCDate) as MinInsertUTCDate
  FROM [srv].[vActiveConnectionStatistics] as t
  group by [ServerName]
      ,[DBName]
	  ,[Status]
 --order by [ServerName]
 --     ,[DBName]
	--  ,[Status]
GO
/****** Object:  Table [srv].[IndicatorStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[IndicatorStatistics](
	[execution_count] [bigint] NOT NULL,
	[max_total_elapsed_timeSec] [decimal](38, 6) NOT NULL,
	[max_total_elapsed_timeLastSec] [decimal](38, 6) NOT NULL,
	[execution_countStatistics] [bigint] NOT NULL,
	[max_AvgDur_timeSec] [decimal](38, 6) NOT NULL,
	[max_AvgDur_timeLastSec] [decimal](38, 6) NOT NULL,
	[DATE] [date] NOT NULL,
 CONSTRAINT [PK_IndicatorStatistics] PRIMARY KEY CLUSTERED 
(
	[DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vIndicatorStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [srv].[vIndicatorStatistics] as
SELECT [DATE]
	  ,[execution_count]
      ,[max_total_elapsed_timeSec]
      ,[max_total_elapsed_timeLastSec]
	  ,[max_total_elapsed_timeLastSec]-[max_total_elapsed_timeSec] as [DiffSnapshot]
	  ,([max_total_elapsed_timeLastSec]-[max_total_elapsed_timeSec])*100/[max_total_elapsed_timeSec] as [% Snapshot]
	  , case when ([max_total_elapsed_timeLastSec]<[max_total_elapsed_timeSec]) then N'����������'
		else case when ([max_total_elapsed_timeLastSec]>[max_total_elapsed_timeSec]) then N'����������'
		else N'�� ����������' end
	   end as 'IndicatorSnapshot'
      ,[execution_countStatistics]
      ,[max_AvgDur_timeSec]
      ,[max_AvgDur_timeLastSec]
	  ,[max_AvgDur_timeLastSec]-[max_AvgDur_timeSec] as [DiffStatistics]
	  ,([max_AvgDur_timeLastSec]-[max_AvgDur_timeSec])*100/[max_AvgDur_timeSec] as [% Statistics]
	  , case when ([max_AvgDur_timeLastSec]<[max_AvgDur_timeSec]) then N'����������'
		else case when ([max_AvgDur_timeLastSec]>[max_AvgDur_timeSec]) then N'����������'
		else N'�� ����������' end
	   end as 'IndicatorStatistics'
  FROM [srv].[IndicatorStatistics]
GO
/****** Object:  View [inf].[vDBFilesOperationsStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vDBFilesOperationsStat]
as
select	t2.[DB_Name] as [DBName]
			,t1.FileId 
			,t1.NumberReads
			,t1.BytesRead
			,t1.IoStallReadMS
			,t1.NumberWrites
			,t1.BytesWritten
			,t1.IoStallWriteMS 
			,t1.IoStallMS
			,t1.BytesOnDisk
			,t1.[TimeStamp]
			,t1.FileHandle
			,t2.[Type_desc]
			,t2.[FileName]
			,t2.[Drive]
			,t2.[Physical_Name]
			,t2.[Ext]
			,t2.[CountPage]
			,t2.[SizeMb]
			,t2.[SizeGb]
			,t2.[Growth]
			,t2.[GrowthMb]
			,t2.[GrowthGb]
			,t2.[GrowthPercent]
			,t2.[is_percent_growth]
			,t2.[database_id]
			,t2.[State]
			,t2.[StateDesc]
			,t2.[IsMediaReadOnly]
			,t2.[IsReadOnly]
			,t2.[IsSpace]
			,t2.[IsNameReserved]
			,t2.[CreateLsn]
			,t2.[DropLsn]
			,t2.[ReadOnlyLsn]
			,t2.[ReadWriteLsn]
			,t2.[DifferentialBaseLsn]
			,t2.[DifferentialBaseGuid]
			,t2.[DifferentialBaseTime]
			,t2.[RedoStartLsn]
			,t2.[RedoStartForkGuid]
			,t2.[RedoTargetLsn]
			,t2.[RedoTargetForkGuid]
			,t2.[BackupLsn]
from fn_virtualfilestats(NULL, NULL) as t1
inner join [inf].[ServerDBFileInfo] as t2 on t1.[DbId]=t2.[database_id] and t1.[FileId]=t2.[File_Id]
--order by IoStallReadMS desc
GO
/****** Object:  View [srv].[vPlanQuery]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [srv].[vPlanQuery] as 
SELECT pq.[PlanHandle]
      ,pq.[SQLHandle]
      ,pq.[QueryPlan]
      ,sq.[TSQL]
      ,pq.[InsertUTCDate]
	  ,pq.[dop]
      ,pq.[request_time]
      ,pq.[grant_time]
      ,pq.[requested_memory_kb]
      ,pq.[granted_memory_kb]
      ,pq.[required_memory_kb]
      ,pq.[used_memory_kb]
      ,pq.[max_used_memory_kb]
      ,pq.[query_cost]
      ,pq.[timeout_sec]
      ,pq.[resource_semaphore_id]
      ,pq.[queue_id]
      ,pq.[wait_order]
      ,pq.[is_next_candidate]
      ,pq.[wait_time_ms]
      ,pq.[pool_id]
      ,pq.[is_small]
      ,pq.[ideal_memory_kb]
      ,pq.[reserved_worker_count]
      ,pq.[used_worker_count]
      ,pq.[max_used_worker_count]
      ,pq.[reserved_node_bitmap]
      ,pq.[bucketid]
      ,pq.[refcounts]
      ,pq.[usecounts]
      ,pq.[size_in_bytes]
      ,pq.[memory_object_address]
      ,pq.[cacheobjtype]
      ,pq.[objtype]
      ,pq.[parent_plan_handle]
      ,pq.[creation_time]
      ,pq.[execution_count]
      ,pq.[total_worker_time]
      ,pq.[min_last_worker_time]
      ,pq.[max_last_worker_time]
      ,pq.[min_worker_time]
      ,pq.[max_worker_time]
      ,pq.[total_physical_reads]
      ,pq.[min_last_physical_reads]
      ,pq.[max_last_physical_reads]
      ,pq.[min_physical_reads]
      ,pq.[max_physical_reads]
      ,pq.[total_logical_writes]
      ,pq.[min_last_logical_writes]
      ,pq.[max_last_logical_writes]
      ,pq.[min_logical_writes]
      ,pq.[max_logical_writes]
      ,pq.[total_logical_reads]
      ,pq.[min_last_logical_reads]
      ,pq.[max_last_logical_reads]
      ,pq.[min_logical_reads]
      ,pq.[max_logical_reads]
      ,pq.[total_clr_time]
      ,pq.[min_last_clr_time]
      ,pq.[max_last_clr_time]
      ,pq.[min_clr_time]
      ,pq.[max_clr_time]
      ,pq.[min_last_elapsed_time]
      ,pq.[max_last_elapsed_time]
      ,pq.[min_elapsed_time]
      ,pq.[max_elapsed_time]
      ,pq.[total_rows]
      ,pq.[min_last_rows]
      ,pq.[max_last_rows]
      ,pq.[min_rows]
      ,pq.[max_rows]
      ,pq.[total_dop]
      ,pq.[min_last_dop]
      ,pq.[max_last_dop]
      ,pq.[min_dop]
      ,pq.[max_dop]
      ,pq.[total_grant_kb]
      ,pq.[min_last_grant_kb]
      ,pq.[max_last_grant_kb]
      ,pq.[min_grant_kb]
      ,pq.[max_grant_kb]
      ,pq.[total_used_grant_kb]
      ,pq.[min_last_used_grant_kb]
      ,pq.[max_last_used_grant_kb]
      ,pq.[min_used_grant_kb]
      ,pq.[max_used_grant_kb]
      ,pq.[total_ideal_grant_kb]
      ,pq.[min_last_ideal_grant_kb]
      ,pq.[max_last_ideal_grant_kb]
      ,pq.[min_ideal_grant_kb]
      ,pq.[max_ideal_grant_kb]
      ,pq.[total_reserved_threads]
      ,pq.[min_last_reserved_threads]
      ,pq.[max_last_reserved_threads]
      ,pq.[min_reserved_threads]
      ,pq.[max_reserved_threads]
      ,pq.[total_used_threads]
      ,pq.[min_last_used_threads]
      ,pq.[max_last_used_threads]
      ,pq.[min_used_threads]
      ,pq.[max_used_threads]
  FROM [srv].[PlanQuery] as pq
  inner join [srv].[SQLQuery] as sq on sq.[SQLHandle]=pq.[SQLHandle]
GO
/****** Object:  View [srv].[vSQLQuery]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [srv].[vSQLQuery] as 
SELECT [SQLHandle]
      ,[TSQL]
      ,[InsertUTCDate]
  FROM [srv].[SQLQuery]
GO
/****** Object:  View [inf].[vTableSize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vTableSize] as
with pagesizeKB as (
	SELECT low / 1024 as PageSizeKB
	FROM master.dbo.spt_values
	WHERE number = 1 AND type = 'E'
)
,f_size as (
	select p.[object_id], 
		   sum([total_pages]) as TotalPageSize,
		   sum([used_pages])  as UsedPageSize,
		   sum([data_pages])  as DataPageSize
	from sys.partitions p join sys.allocation_units a on p.partition_id = a.container_id
	left join sys.internal_tables it on p.object_id = it.object_id
	WHERE OBJECTPROPERTY(p.[object_id], N'IsUserTable') = 1
	group by p.[object_id]
)
,tbl as (
	SELECT
	  t.[schema_id],
	  t.[object_id],
	  i1.rowcnt as CountRows,
	  (COALESCE(SUM(i1.reserved), 0) + COALESCE(SUM(i2.reserved), 0)) * (select top(1) PageSizeKB from pagesizeKB) as ReservedKB,
	  (COALESCE(SUM(i1.dpages), 0) + COALESCE(SUM(i2.used), 0)) * (select top(1) PageSizeKB from pagesizeKB) as DataKB,
	  ((COALESCE(SUM(i1.used), 0) + COALESCE(SUM(i2.used), 0))
	    - (COALESCE(SUM(i1.dpages), 0) + COALESCE(SUM(i2.used), 0))) * (select top(1) PageSizeKB from pagesizeKB) as IndexSizeKB,
	  ((COALESCE(SUM(i1.reserved), 0) + COALESCE(SUM(i2.reserved), 0))
	    - (COALESCE(SUM(i1.used), 0) + COALESCE(SUM(i2.used), 0))) * (select top(1) PageSizeKB from pagesizeKB) as UnusedKB
	FROM sys.tables as t
	LEFT OUTER JOIN sysindexes as i1 ON i1.id = t.[object_id] AND i1.indid < 2
	LEFT OUTER JOIN sysindexes as i2 ON i2.id = t.[object_id] AND i2.indid = 255
	WHERE OBJECTPROPERTY(t.[object_id], N'IsUserTable') = 1
	OR (OBJECTPROPERTY(t.[object_id], N'IsView') = 1 AND OBJECTPROPERTY(t.[object_id], N'IsIndexed') = 1)
	GROUP BY t.[schema_id], t.[object_id], i1.rowcnt
)
SELECT
  @@Servername AS Server,
  DB_NAME() AS DBName,
  SCHEMA_NAME(t.[schema_id]) as SchemaName,
  OBJECT_NAME(t.[object_id]) as TableName,
  t.CountRows,
  t.ReservedKB,
  t.DataKB,
  t.IndexSizeKB,
  t.UnusedKB,
  f.TotalPageSize*(select top(1) PageSizeKB from pagesizeKB) as TotalPageSizeKB,
  f.UsedPageSize*(select top(1) PageSizeKB from pagesizeKB) as UsedPageSizeKB,
  f.DataPageSize*(select top(1) PageSizeKB from pagesizeKB) as DataPageSizeKB
FROM f_size as f
inner join tbl as t on t.[object_id]=f.[object_id]
GO
/****** Object:  View [inf].[vDataSize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vDataSize] as
with tbl as (
	select sum(ReservedKB) as [ReservedUserTablesKB],
	sum(DataKB) as [DataUserTablesKB],
	sum(IndexSizeKB) as [IndexSizeUserTablesKB],
	sum(UnusedKB) as [UnusedUserTablesKB],
	sum([TotalPageSizeKB]) as [TotalPageSizeKB],
	sum([UsedPageSizeKB]) as [UsedPageSizeKB],
	sum([DataPageSizeKB]) as [DataPageSizeKB]
	from inf.vTableSize
)
select
(
	select cast(sum([total_pages]) * 8192 / 1024. as decimal(18,2))
	from sys.partitions p join sys.allocation_units a on p.partition_id = a.container_id
	left join sys.internal_tables it on p.object_id = it.object_id
	WHERE OBJECTPROPERTY(p.[object_id], N'IsUserTable') = 0
) as [TotalPagesSystemTablesKB],
	[TotalPageSizeKB],
	[UsedPageSizeKB],
	[DataPageSizeKB],
	[DataUserTablesKB],
	[IndexSizeUserTablesKB],
	[UnusedUserTablesKB]
from tbl;
GO
/****** Object:  View [srv].[vTableStatisticsShort]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vTableStatisticsShort] as 
with d as (select DateAdd(day,-1,max([Date])) as [Date] from [srv].[TableStatistics])
SELECT t.[ServerName]
      ,t.[DBName]
      ,t.[SchemaName]
      ,t.[TableName]
      ,t.[CountRows]
      ,t.[DataKB]
      ,t.[IndexSizeKB]
      ,t.[UnusedKB]
      ,t.[ReservedKB]
      ,t.[InsertUTCDate]
      ,t.[Date]
      ,t.[CountRowsBack]
      ,t.[CountRowsNext]
      ,t.[DataKBBack]
      ,t.[DataKBNext]
      ,t.[IndexSizeKBBack]
      ,t.[IndexSizeKBNext]
      ,t.[UnusedKBBack]
      ,t.[UnusedKBNext]
      ,t.[ReservedKBBack]
      ,t.[ReservedKBNext]
      ,t.[AvgCountRows]
      ,t.[AvgDataKB]
      ,t.[AvgIndexSizeKB]
      ,t.[AvgUnusedKB]
      ,t.[AvgReservedKB]
      ,t.[DiffCountRows]
      ,t.[DiffDataKB]
      ,t.[DiffIndexSizeKB]
      ,t.[DiffUnusedKB]
      ,t.[DiffReservedKB]
      ,t.[TotalPageSizeKB]
      ,t.[TotalPageSizeKBBack]
      ,t.[TotalPageSizeKBNext]
      ,t.[UsedPageSizeKB]
      ,t.[UsedPageSizeKBBack]
      ,t.[UsedPageSizeKBNext]
      ,t.[DataPageSizeKB]
      ,t.[DataPageSizeKBBack]
      ,t.[DataPageSizeKBNext]
      ,t.[AvgDataPageSizeKB]
      ,t.[AvgUsedPageSizeKB]
      ,t.[AvgTotalPageSizeKB]
      ,t.[DiffDataPageSizeKB]
      ,t.[DiffUsedPageSizeKB]
      ,t.[DiffTotalPageSizeKB]
  FROM d
  inner join [SRV].[srv].[TableStatistics] as t on d.[Date]=t.[Date]
  where t.[CountRowsBack] is not null
	and	t.[CountRowsNext] is not null
GO
/****** Object:  View [inf].[vJobSchedules]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobSchedules] as
SELECT [schedule_id]
      ,[job_id]
      ,[next_run_date]
      ,[next_run_time]
  FROM [msdb].[dbo].[sysjobschedules];

GO
/****** Object:  View [inf].[vScheduleMultiJobs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [inf].[vScheduleMultiJobs] as
/*
	���: ����������, � ������� ��������� �����
*/
with sh as(
  SELECT schedule_id
  FROM [inf].[vJobSchedules]
  group by schedule_id
  having count(*)>1
)
select *
from msdb.dbo.sysschedules as s
where exists(select top(1) 1 from sh where sh.schedule_id=s.schedule_id)



GO
/****** Object:  Table [srv].[Drivers]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[Drivers](
	[Driver_GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Server] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](8) NOT NULL,
	[TotalSpace] [float] NOT NULL,
	[FreeSpace] [float] NOT NULL,
	[DiffFreeSpace] [float] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[UpdateUTCdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Drivers] PRIMARY KEY CLUSTERED 
(
	[Driver_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vDrivers]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [srv].[vDrivers] as
select
	  [Driver_GUID]
      ,[Server]
      ,[Name]
	  ,[TotalSpace] as [TotalSpaceByte]
	  ,[FreeSpace] as [FreeSpaceByte]
	  ,[DiffFreeSpace] as [DiffFreeSpaceByte]
	  ,round([TotalSpace]/1024, 3) as [TotalSpaceKb]
	  ,round([FreeSpace]/1024, 3) as [FreeSpaceKb]
	  ,round([DiffFreeSpace]/1024, 3) as [DiffFreeSpaceKb]
      ,round([TotalSpace]/1024/1024, 3) as [TotalSpaceMb]
	  ,round([FreeSpace]/1024/1024, 3) as [FreeSpaceMb]
	  ,round([DiffFreeSpace]/1024/1024, 3) as [DiffFreeSpaceMb]
	  ,round([TotalSpace]/1024/1024/1024, 3) as [TotalSpaceGb]
	  ,round([FreeSpace]/1024/1024/1024, 3) as [FreeSpaceGb]
	  ,round([DiffFreeSpace]/1024/1024/1024, 3) as [DiffFreeSpaceGb]
	  ,round([TotalSpace]/1024/1024/1024/1024, 3) as [TotalSpaceTb]
	  ,round([FreeSpace]/1024/1024/1024/1024, 3) as [FreeSpaceTb]
	  ,round([DiffFreeSpace]/1024/1024/1024/1024, 3) as [DiffFreeSpaceTb]
	  ,round([FreeSpace]/([TotalSpace]/100), 3) as [FreeSpacePercent]
	  ,round([DiffFreeSpace]/([TotalSpace]/100), 3) as [DiffFreeSpacePercent]
      ,[InsertUTCDate]
      ,[UpdateUTCdate]
  FROM [srv].[Drivers]
GO
/****** Object:  Table [srv].[RequestStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[RequestStatistics](
	[session_id] [smallint] NOT NULL,
	[request_id] [int] NULL,
	[start_time] [datetime] NULL,
	[status] [nvarchar](30) NULL,
	[command] [nvarchar](32) NULL,
	[sql_handle] [varbinary](64) NULL,
	[statement_start_offset] [int] NULL,
	[statement_end_offset] [int] NULL,
	[plan_handle] [varbinary](64) NULL,
	[database_id] [smallint] NULL,
	[user_id] [int] NULL,
	[connection_id] [uniqueidentifier] NULL,
	[blocking_session_id] [smallint] NULL,
	[wait_type] [nvarchar](60) NULL,
	[wait_time] [int] NULL,
	[last_wait_type] [nvarchar](60) NULL,
	[wait_resource] [nvarchar](256) NULL,
	[open_transaction_count] [int] NULL,
	[open_resultset_count] [int] NULL,
	[transaction_id] [bigint] NULL,
	[context_info] [varbinary](128) NULL,
	[percent_complete] [real] NULL,
	[estimated_completion_time] [bigint] NULL,
	[cpu_time] [int] NULL,
	[total_elapsed_time] [int] NULL,
	[scheduler_id] [int] NULL,
	[task_address] [varbinary](8) NULL,
	[reads] [bigint] NULL,
	[writes] [bigint] NULL,
	[logical_reads] [bigint] NULL,
	[text_size] [int] NULL,
	[language] [nvarchar](128) NULL,
	[date_format] [nvarchar](3) NULL,
	[date_first] [smallint] NULL,
	[quoted_identifier] [bit] NULL,
	[arithabort] [bit] NULL,
	[ansi_null_dflt_on] [bit] NULL,
	[ansi_defaults] [bit] NULL,
	[ansi_warnings] [bit] NULL,
	[ansi_padding] [bit] NULL,
	[ansi_nulls] [bit] NULL,
	[concat_null_yields_null] [bit] NULL,
	[transaction_isolation_level] [smallint] NULL,
	[lock_timeout] [int] NULL,
	[deadlock_priority] [int] NULL,
	[row_count] [bigint] NULL,
	[prev_error] [int] NULL,
	[nest_level] [int] NULL,
	[granted_query_memory] [int] NULL,
	[executing_managed_code] [bit] NULL,
	[group_id] [int] NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[most_recent_session_id] [int] NULL,
	[connect_time] [datetime] NULL,
	[net_transport] [nvarchar](40) NULL,
	[protocol_type] [nvarchar](40) NULL,
	[protocol_version] [int] NULL,
	[endpoint_id] [int] NULL,
	[encrypt_option] [nvarchar](40) NULL,
	[auth_scheme] [nvarchar](40) NULL,
	[node_affinity] [smallint] NULL,
	[num_reads] [int] NULL,
	[num_writes] [int] NULL,
	[last_read] [datetime] NULL,
	[last_write] [datetime] NULL,
	[net_packet_size] [int] NULL,
	[client_net_address] [varchar](48) NULL,
	[client_tcp_port] [int] NULL,
	[local_net_address] [varchar](48) NULL,
	[local_tcp_port] [int] NULL,
	[parent_connection_id] [uniqueidentifier] NULL,
	[most_recent_sql_handle] [varbinary](64) NULL,
	[login_time] [datetime] NULL,
	[host_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[host_process_id] [int] NULL,
	[client_version] [int] NULL,
	[client_interface_name] [nvarchar](32) NULL,
	[security_id] [varbinary](85) NULL,
	[login_name] [nvarchar](128) NULL,
	[nt_domain] [nvarchar](128) NULL,
	[nt_user_name] [nvarchar](128) NULL,
	[memory_usage] [int] NULL,
	[total_scheduled_time] [int] NULL,
	[last_request_start_time] [datetime] NULL,
	[last_request_end_time] [datetime] NULL,
	[is_user_process] [bit] NULL,
	[original_security_id] [varbinary](85) NULL,
	[original_login_name] [nvarchar](128) NULL,
	[last_successful_logon] [datetime] NULL,
	[last_unsuccessful_logon] [datetime] NULL,
	[unsuccessful_logons] [bigint] NULL,
	[authenticating_database_id] [int] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[EndRegUTCDate] [datetime] NULL,
	[is_blocking_other_session] [int] NOT NULL,
	[dop] [smallint] NULL,
	[request_time] [datetime] NULL,
	[grant_time] [datetime] NULL,
	[requested_memory_kb] [bigint] NULL,
	[granted_memory_kb] [bigint] NULL,
	[required_memory_kb] [bigint] NULL,
	[used_memory_kb] [bigint] NULL,
	[max_used_memory_kb] [bigint] NULL,
	[query_cost] [float] NULL,
	[timeout_sec] [int] NULL,
	[resource_semaphore_id] [smallint] NULL,
	[queue_id] [smallint] NULL,
	[wait_order] [int] NULL,
	[is_next_candidate] [bit] NULL,
	[wait_time_ms] [bigint] NULL,
	[pool_id] [int] NULL,
	[is_small] [bit] NULL,
	[ideal_memory_kb] [bigint] NULL,
	[reserved_worker_count] [int] NULL,
	[used_worker_count] [int] NULL,
	[max_used_worker_count] [int] NULL,
	[reserved_node_bitmap] [bigint] NULL,
	[bucketid] [int] NULL,
	[refcounts] [int] NULL,
	[usecounts] [int] NULL,
	[size_in_bytes] [int] NULL,
	[memory_object_address] [varbinary](8) NULL,
	[cacheobjtype] [nvarchar](50) NULL,
	[objtype] [nvarchar](20) NULL,
	[parent_plan_handle] [varbinary](64) NULL,
	[creation_time] [datetime] NULL,
	[execution_count] [bigint] NULL,
	[total_worker_time] [bigint] NULL,
	[min_last_worker_time] [bigint] NULL,
	[max_last_worker_time] [bigint] NULL,
	[min_worker_time] [bigint] NULL,
	[max_worker_time] [bigint] NULL,
	[total_physical_reads] [bigint] NULL,
	[min_last_physical_reads] [bigint] NULL,
	[max_last_physical_reads] [bigint] NULL,
	[min_physical_reads] [bigint] NULL,
	[max_physical_reads] [bigint] NULL,
	[total_logical_writes] [bigint] NULL,
	[min_last_logical_writes] [bigint] NULL,
	[max_last_logical_writes] [bigint] NULL,
	[min_logical_writes] [bigint] NULL,
	[max_logical_writes] [bigint] NULL,
	[total_logical_reads] [bigint] NULL,
	[min_last_logical_reads] [bigint] NULL,
	[max_last_logical_reads] [bigint] NULL,
	[min_logical_reads] [bigint] NULL,
	[max_logical_reads] [bigint] NULL,
	[total_clr_time] [bigint] NULL,
	[min_last_clr_time] [bigint] NULL,
	[max_last_clr_time] [bigint] NULL,
	[min_clr_time] [bigint] NULL,
	[max_clr_time] [bigint] NULL,
	[min_last_elapsed_time] [bigint] NULL,
	[max_last_elapsed_time] [bigint] NULL,
	[min_elapsed_time] [bigint] NULL,
	[max_elapsed_time] [bigint] NULL,
	[total_rows] [bigint] NULL,
	[min_last_rows] [bigint] NULL,
	[max_last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[min_last_dop] [bigint] NULL,
	[max_last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[min_last_grant_kb] [bigint] NULL,
	[max_last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[min_last_used_grant_kb] [bigint] NULL,
	[max_last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[min_last_ideal_grant_kb] [bigint] NULL,
	[max_last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[min_last_reserved_threads] [bigint] NULL,
	[max_last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[min_last_used_threads] [bigint] NULL,
	[max_last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indRequest]    Script Date: 07.03.2018 11:22:33 ******/
CREATE CLUSTERED INDEX [indRequest] ON [srv].[RequestStatistics]
(
	[session_id] ASC,
	[request_id] ASC,
	[database_id] ASC,
	[user_id] ASC,
	[start_time] ASC,
	[command] ASC,
	[sql_handle] ASC,
	[plan_handle] ASC,
	[transaction_id] ASC,
	[connection_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [srv].[RequestStatisticsArchive]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[RequestStatisticsArchive](
	[session_id] [smallint] NOT NULL,
	[request_id] [int] NULL,
	[start_time] [datetime] NULL,
	[status] [nvarchar](30) NULL,
	[command] [nvarchar](32) NULL,
	[sql_handle] [varbinary](64) NULL,
	[statement_start_offset] [int] NULL,
	[statement_end_offset] [int] NULL,
	[plan_handle] [varbinary](64) NULL,
	[database_id] [smallint] NULL,
	[user_id] [int] NULL,
	[connection_id] [uniqueidentifier] NULL,
	[blocking_session_id] [smallint] NULL,
	[wait_type] [nvarchar](60) NULL,
	[wait_time] [int] NULL,
	[last_wait_type] [nvarchar](60) NULL,
	[wait_resource] [nvarchar](256) NULL,
	[open_transaction_count] [int] NULL,
	[open_resultset_count] [int] NULL,
	[transaction_id] [bigint] NULL,
	[context_info] [varbinary](128) NULL,
	[percent_complete] [real] NULL,
	[estimated_completion_time] [bigint] NULL,
	[cpu_time] [int] NULL,
	[total_elapsed_time] [int] NULL,
	[scheduler_id] [int] NULL,
	[task_address] [varbinary](8) NULL,
	[reads] [bigint] NULL,
	[writes] [bigint] NULL,
	[logical_reads] [bigint] NULL,
	[text_size] [int] NULL,
	[language] [nvarchar](128) NULL,
	[date_format] [nvarchar](3) NULL,
	[date_first] [smallint] NULL,
	[quoted_identifier] [bit] NULL,
	[arithabort] [bit] NULL,
	[ansi_null_dflt_on] [bit] NULL,
	[ansi_defaults] [bit] NULL,
	[ansi_warnings] [bit] NULL,
	[ansi_padding] [bit] NULL,
	[ansi_nulls] [bit] NULL,
	[concat_null_yields_null] [bit] NULL,
	[transaction_isolation_level] [smallint] NULL,
	[lock_timeout] [int] NULL,
	[deadlock_priority] [int] NULL,
	[row_count] [bigint] NULL,
	[prev_error] [int] NULL,
	[nest_level] [int] NULL,
	[granted_query_memory] [int] NULL,
	[executing_managed_code] [bit] NULL,
	[group_id] [int] NULL,
	[query_hash] [binary](8) NULL,
	[query_plan_hash] [binary](8) NULL,
	[most_recent_session_id] [int] NULL,
	[connect_time] [datetime] NULL,
	[net_transport] [nvarchar](40) NULL,
	[protocol_type] [nvarchar](40) NULL,
	[protocol_version] [int] NULL,
	[endpoint_id] [int] NULL,
	[encrypt_option] [nvarchar](40) NULL,
	[auth_scheme] [nvarchar](40) NULL,
	[node_affinity] [smallint] NULL,
	[num_reads] [int] NULL,
	[num_writes] [int] NULL,
	[last_read] [datetime] NULL,
	[last_write] [datetime] NULL,
	[net_packet_size] [int] NULL,
	[client_net_address] [varchar](48) NULL,
	[client_tcp_port] [int] NULL,
	[local_net_address] [varchar](48) NULL,
	[local_tcp_port] [int] NULL,
	[parent_connection_id] [uniqueidentifier] NULL,
	[most_recent_sql_handle] [varbinary](64) NULL,
	[login_time] [datetime] NULL,
	[host_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[host_process_id] [int] NULL,
	[client_version] [int] NULL,
	[client_interface_name] [nvarchar](32) NULL,
	[security_id] [varbinary](85) NULL,
	[login_name] [nvarchar](128) NULL,
	[nt_domain] [nvarchar](128) NULL,
	[nt_user_name] [nvarchar](128) NULL,
	[memory_usage] [int] NULL,
	[total_scheduled_time] [int] NULL,
	[last_request_start_time] [datetime] NULL,
	[last_request_end_time] [datetime] NULL,
	[is_user_process] [bit] NULL,
	[original_security_id] [varbinary](85) NULL,
	[original_login_name] [nvarchar](128) NULL,
	[last_successful_logon] [datetime] NULL,
	[last_unsuccessful_logon] [datetime] NULL,
	[unsuccessful_logons] [bigint] NULL,
	[authenticating_database_id] [int] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[EndRegUTCDate] [datetime] NULL,
	[is_blocking_other_session] [int] NOT NULL,
	[dop] [smallint] NULL,
	[request_time] [datetime] NULL,
	[grant_time] [datetime] NULL,
	[requested_memory_kb] [bigint] NULL,
	[granted_memory_kb] [bigint] NULL,
	[required_memory_kb] [bigint] NULL,
	[used_memory_kb] [bigint] NULL,
	[max_used_memory_kb] [bigint] NULL,
	[query_cost] [float] NULL,
	[timeout_sec] [int] NULL,
	[resource_semaphore_id] [smallint] NULL,
	[queue_id] [smallint] NULL,
	[wait_order] [int] NULL,
	[is_next_candidate] [bit] NULL,
	[wait_time_ms] [bigint] NULL,
	[pool_id] [int] NULL,
	[is_small] [bit] NULL,
	[ideal_memory_kb] [bigint] NULL,
	[reserved_worker_count] [int] NULL,
	[used_worker_count] [int] NULL,
	[max_used_worker_count] [int] NULL,
	[reserved_node_bitmap] [bigint] NULL,
	[bucketid] [int] NULL,
	[refcounts] [int] NULL,
	[usecounts] [int] NULL,
	[size_in_bytes] [int] NULL,
	[memory_object_address] [varbinary](8) NULL,
	[cacheobjtype] [nvarchar](50) NULL,
	[objtype] [nvarchar](20) NULL,
	[parent_plan_handle] [varbinary](64) NULL,
	[creation_time] [datetime] NULL,
	[execution_count] [bigint] NULL,
	[total_worker_time] [bigint] NULL,
	[min_last_worker_time] [bigint] NULL,
	[max_last_worker_time] [bigint] NULL,
	[min_worker_time] [bigint] NULL,
	[max_worker_time] [bigint] NULL,
	[total_physical_reads] [bigint] NULL,
	[min_last_physical_reads] [bigint] NULL,
	[max_last_physical_reads] [bigint] NULL,
	[min_physical_reads] [bigint] NULL,
	[max_physical_reads] [bigint] NULL,
	[total_logical_writes] [bigint] NULL,
	[min_last_logical_writes] [bigint] NULL,
	[max_last_logical_writes] [bigint] NULL,
	[min_logical_writes] [bigint] NULL,
	[max_logical_writes] [bigint] NULL,
	[total_logical_reads] [bigint] NULL,
	[min_last_logical_reads] [bigint] NULL,
	[max_last_logical_reads] [bigint] NULL,
	[min_logical_reads] [bigint] NULL,
	[max_logical_reads] [bigint] NULL,
	[total_clr_time] [bigint] NULL,
	[min_last_clr_time] [bigint] NULL,
	[max_last_clr_time] [bigint] NULL,
	[min_clr_time] [bigint] NULL,
	[max_clr_time] [bigint] NULL,
	[min_last_elapsed_time] [bigint] NULL,
	[max_last_elapsed_time] [bigint] NULL,
	[min_elapsed_time] [bigint] NULL,
	[max_elapsed_time] [bigint] NULL,
	[total_rows] [bigint] NULL,
	[min_last_rows] [bigint] NULL,
	[max_last_rows] [bigint] NULL,
	[min_rows] [bigint] NULL,
	[max_rows] [bigint] NULL,
	[total_dop] [bigint] NULL,
	[min_last_dop] [bigint] NULL,
	[max_last_dop] [bigint] NULL,
	[min_dop] [bigint] NULL,
	[max_dop] [bigint] NULL,
	[total_grant_kb] [bigint] NULL,
	[min_last_grant_kb] [bigint] NULL,
	[max_last_grant_kb] [bigint] NULL,
	[min_grant_kb] [bigint] NULL,
	[max_grant_kb] [bigint] NULL,
	[total_used_grant_kb] [bigint] NULL,
	[min_last_used_grant_kb] [bigint] NULL,
	[max_last_used_grant_kb] [bigint] NULL,
	[min_used_grant_kb] [bigint] NULL,
	[max_used_grant_kb] [bigint] NULL,
	[total_ideal_grant_kb] [bigint] NULL,
	[min_last_ideal_grant_kb] [bigint] NULL,
	[max_last_ideal_grant_kb] [bigint] NULL,
	[min_ideal_grant_kb] [bigint] NULL,
	[max_ideal_grant_kb] [bigint] NULL,
	[total_reserved_threads] [bigint] NULL,
	[min_last_reserved_threads] [bigint] NULL,
	[max_last_reserved_threads] [bigint] NULL,
	[min_reserved_threads] [bigint] NULL,
	[max_reserved_threads] [bigint] NULL,
	[total_used_threads] [bigint] NULL,
	[min_last_used_threads] [bigint] NULL,
	[max_last_used_threads] [bigint] NULL,
	[min_used_threads] [bigint] NULL,
	[max_used_threads] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indRequest]    Script Date: 07.03.2018 11:22:33 ******/
CREATE CLUSTERED INDEX [indRequest] ON [srv].[RequestStatisticsArchive]
(
	[session_id] ASC,
	[request_id] ASC,
	[database_id] ASC,
	[user_id] ASC,
	[start_time] ASC,
	[command] ASC,
	[sql_handle] ASC,
	[plan_handle] ASC,
	[transaction_id] ASC,
	[connection_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [srv].[vRequestStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO














CREATE view [srv].[vRequestStatistics] as
/*���������� ��������*/
select rs.[session_id] --������
	      ,rs.[blocking_session_id] --������, ������� ���� ��������� ������ [session_id]
		  ,rs.[request_id] --������������� �������. �������� � ��������� ������
	      ,rs.[start_time] --����� ������� ����������� �������
		  ,DateDiff(second, rs.[start_time], GetDate()) as [date_diffSec] --������� � ��� ������ ������� �� ������� ����������� �������
	      ,rs.[status] --��������� �������
	      ,rs.[command] --��� ����������� � ������ ������ �������
		  , COALESCE(
						CAST(NULLIF(rs.[total_elapsed_time] / 1000, 0) as BIGINT)
					   ,CASE WHEN (rs.[status]  <> 'running') 
								THEN  DATEDIFF(ss,0,getdate() - nullif(rs.[last_request_end_time], '1900-01-01T00:00:00.000'))
						END
					) as [total_time, sec] --����� ���� ������ ������� � ���
		  , CAST(NULLIF((CAST(rs.[total_elapsed_time] as BIGINT) - CAST(rs.[wait_time] AS BIGINT)) / 1000, 0 ) as bigint) as [work_time, sec] --����� ������ ������� � ��� ��� ����� ������� ��������
		  , CASE WHEN (rs.[status] <> 'running') 
		  			THEN  DATEDIFF(ss,0,getdate() - nullif(rs.[last_request_end_time], '1900-01-01T00:00:00.000'))
			END as [sleep_time, sec] --����� ��� � ���
		  , NULLIF( CAST((rs.[logical_reads] + rs.[writes]) * 8 / 1024 as numeric(38,2)), 0) as [IO, MB] --�������� ������ � ������ � ��
		  , CASE  rs.transaction_isolation_level
			WHEN 0 THEN 'Unspecified'
			WHEN 1 THEN 'ReadUncommited'
			WHEN 2 THEN 'ReadCommited'
			WHEN 3 THEN 'Repetable'
			WHEN 4 THEN 'Serializable'
			WHEN 5 THEN 'Snapshot'
			END as [transaction_isolation_level_desc] --������� �������� ���������� (�����������)
		  ,rs.[percent_complete] --������� ���������� ������ ��� ��������� ������
		  ,DB_NAME(rs.[database_id]) as [DBName] --��
		  , SUBSTRING(
						sq.[TSQL]
					  , rs.[statement_start_offset]/2+1
					  ,	(
							CASE WHEN ((rs.[statement_start_offset]<0) OR (rs.[statement_end_offset]<0))
									THEN DATALENGTH (sq.[TSQL])
								 ELSE rs.[statement_end_offset]
							END
							- rs.[statement_start_offset]
						)/2 +1
					 ) as [CURRENT_REQUEST] --������� ����������� ������ � ������
	      ,sq.[TSQL] --������ ����� ������
		  ,pq.[QueryPlan] --���� ����� ������
	      ,rs.[wait_type] --���� ������ � ��������� ������ ����������, � ������� ���������� ��� �������� (sys.dm_os_wait_stats)
	      ,rs.[login_time] --����� ����������� ������
		  ,rs.[host_name] --��� ���������� ������� �������, ��������� � ������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[program_name] --��� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
	      ,cast(rs.[wait_time]/1000 as decimal(18,3)) as [wait_timeSec] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� ��������)
	      ,rs.[wait_time] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������)
	      ,rs.[last_wait_type] --���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������
	      ,rs.[wait_resource] --���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������
	      ,rs.[open_transaction_count] --����� ����������, �������� ��� ������� �������
	      ,rs.[open_resultset_count] --����� �������������� �������, �������� ��� ������� �������
	      ,rs.[transaction_id] --������������� ����������, � ������� ����������� ������
	      ,rs.[context_info] --�������� CONTEXT_INFO ������
		  ,cast(rs.[estimated_completion_time]/1000 as decimal(18,3)) as [estimated_completion_timeSec] --������ ��� ����������� �������������. �� ��������� �������� NULL
	      ,rs.[estimated_completion_time] --������ ��� ����������� �������������. �� ��������� �������� NULL
		  ,cast(rs.[cpu_time]/1000 as decimal(18,3)) as [cpu_timeSec] --����� �� (� ��������), ����������� �� ���������� �������
	      ,rs.[cpu_time] --����� �� (� �������������), ����������� �� ���������� �������
		  ,cast(rs.[total_elapsed_time]/1000 as decimal(18,3)) as [total_elapsed_timeSec] --����� �����, �������� � ������� ����������� ������� (� ��������)
	      ,rs.[total_elapsed_time] --����� �����, �������� � ������� ����������� ������� (� �������������)
	      ,rs.[scheduler_id] --������������� ������������, ������� ��������� ������ ������
	      ,rs.[task_address] --����� ����� ������, ����������� ��� ������, ��������� � ���� ��������
	      ,rs.[reads] --����� �������� ������, ����������� ������ ��������
	      ,rs.[writes] --����� �������� ������, ����������� ������ ��������
	      ,rs.[logical_reads] --����� ���������� �������� ������, ����������� ������ ��������
	      ,rs.[text_size] --��������� ��������� TEXTSIZE ��� ������� �������
	      ,rs.[language] --��������� ����� ��� ������� �������
	      ,rs.[date_format] --��������� ��������� DATEFORMAT ��� ������� �������
	      ,rs.[date_first] --��������� ��������� DATEFIRST ��� ������� �������
	      ,rs.[quoted_identifier] --1 = �������� QUOTED_IDENTIFIER ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[arithabort] --1 = �������� ARITHABORT ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_null_dflt_on] --1 = �������� ANSI_NULL_DFLT_ON ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_defaults] --1 = �������� ANSI_DEFAULTS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_warnings] --1 = �������� ANSI_WARNINGS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_padding] --1 = �������� ANSI_PADDING ��� ������� ������� (ON)
	      ,rs.[ansi_nulls] --1 = �������� ANSI_NULLS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[concat_null_yields_null] --1 = �������� CONCAT_NULL_YIELDS_NULL ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[transaction_isolation_level] --������� ��������, � ������� ������� ���������� ��� ������� �������
		  ,cast(rs.[lock_timeout]/1000 as decimal(18,3)) as [lock_timeoutSec] --����� �������� ���������� ��� ������� ������� (� ��������)
		  ,rs.[lock_timeout] --����� �������� ���������� ��� ������� ������� (� �������������)
	      ,rs.[deadlock_priority] --�������� ��������� DEADLOCK_PRIORITY ��� ������� �������
	      ,rs.[row_count] --����� �����, ������������ ������� �� ������� �������
	      ,rs.[prev_error] --��������� ������, ����������� ��� ���������� �������
	      ,rs.[nest_level] --������� ������� ����������� ����, ������������ ��� ������� �������
	      ,rs.[granted_query_memory] --����� �������, ���������� ��� ���������� ������������ ������� (1 ��������-��� �������� 8 ��)
	      ,rs.[executing_managed_code] --���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������).
									  --���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL
	      
		  ,rs.[group_id]	--������������� ������ ������� ��������, ������� ����������� ���� ������
	      ,rs.[query_hash] --�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������.
						  --����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������
	      
		  ,rs.[query_plan_hash] --�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������.
							   --����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������
		  
		  ,rs.[most_recent_session_id] --������������ ����� ������������� ������ ������ ���������� �������, ���������� � ������ �����������
	      ,rs.[connect_time] --������� ������� ������������ ����������
	      ,rs.[net_transport] --�������� �������� ����������� ������������� ���������, ������������� ������ �����������
	      ,rs.[protocol_type] --��������� ��� ��������� �������� �������� ������
	      ,rs.[protocol_version] --������ ��������� ������� � ������, ���������� � ������ �����������
	      ,rs.[endpoint_id] --�������������, ����������� ��� ����������. ���� ������������� endpoint_id ����� �������������� ��� �������� � ������������� sys.endpoints
	      ,rs.[encrypt_option] --���������� ��������, �����������, ��������� �� ���������� ��� ������� ����������
	      ,rs.[auth_scheme] --��������� ����� �������� ����������� (SQL Server ��� Windows), ������������ � ������ �����������
	      ,rs.[node_affinity] --�������������� ���� ������, �������� ������������� ������ ����������
	      ,rs.[num_reads] --����� �������, �������� ����������� ������� ����������
	      ,rs.[num_writes] --����� �������, ���������� ����������� ������� ����������
	      ,rs.[last_read] --������� ������� � ��������� ���������� ������ ������
	      ,rs.[last_write] --������� ������� � ��������� ������������ ������ ������
	      ,rs.[net_packet_size] --������ �������� ������, ������������ ��� �������� ������
	      ,rs.[client_net_address] --������� ����� ���������� �������
	      ,rs.[client_tcp_port] --����� ����� �� ���������� ����������, ������� ������������ ��� ������������� ����������
	      ,rs.[local_net_address] --IP-����� �������, � ������� ����������� ������ ����������. �������� ������ ��� ����������, ������� � �������� ���������� ������ ���������� �������� TCP
	      ,rs.[local_tcp_port] --TCP-���� �������, ���� ���������� ���������� �������� TCP
	      ,rs.[parent_connection_id] --�������������� ��������� ����������, ������������ � ������ MARS
	      ,rs.[most_recent_sql_handle] --���������� ���������� ������� SQL, ������������ � ������� ������� ����������. ��������� ���������� ������������� ����� �������� most_recent_sql_handle � �������� most_recent_session_id
		  ,rs.[host_process_id] --������������� �������� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[client_version] --������ TDS-��������� ����������, ������� ������������ �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[client_interface_name] --��� ���������� ��� �������, ������������ �������� ��� ������ ������� � ��������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[security_id] --������������� ������������ Microsoft Windows, ��������� � ������ �����
		  ,rs.[login_name] --SQL Server ��� �����, ��� ������� ����������� ������� �����.
						  --����� ������ �������������� ��� �����, � ������� �������� ��� ������ �����, ��. �������� original_login_name.
						  --����� ���� SQL Server �������� ����������� ����� ����� ��� ����� ������������ ������, ���������� �������� ����������� Windows
		  
		  ,rs.[nt_domain] --����� Windows ��� �������, ���� �� ����� ������ ����������� �������� ����������� Windows ��� ������������� ����������.
						 --��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,rs.[nt_user_name] --��� ������������ Windows ��� �������, ���� �� ����� ������ ������������ �������� ����������� Windows ��� ������������� ����������.
							--��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,rs.[memory_usage] --���������� 8-������������ ������� ������, ������������ ������ �������
		  ,rs.[total_scheduled_time] --����� �����, ����������� ������� ������ (������� ��� ��������� �������) ��� ����������, � �������������
		  ,rs.[last_request_start_time] --�����, ����� ������� ��������� ������ ������� ������. ��� ����� ���� ������, ������������� � ������ ������
		  ,rs.[last_request_end_time] --����� ���������� ���������� ������� � ������ ������� ������
		  ,rs.[is_user_process] --0, ���� ����� �������� ���������. � ��������� ������ �������� ����� 1
		  ,rs.[original_security_id] --Microsoft ������������� ������������ Windows, ��������� � ���������� original_login_name
		  ,rs.[original_login_name] --SQL Server ��� �����, ������� ���������� ������ ������ ������ �����.
								   --��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ��� ������������ ������ Windows, 
								   --��������� �������� �����������, ��� ������������ ���������� ���� ������.
								   --�������� ��������, ��� ����� ��������������� ���������� ��� ������ ����� ���� ��������� ����� ������� ��� ����� ������������ ���������.
								   --�������� ���� EXECUTE AS ������������
		  
		  ,rs.[last_successful_logon] --����� ���������� ��������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,rs.[last_unsuccessful_logon] --����� ���������� ����������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,rs.[unsuccessful_logons] --����� ���������� ������� ����� � ������� ��� ����� original_login_name ����� �������� last_successful_logon � �������� login_time
		  ,rs.[authenticating_database_id] --������������� ���� ������, ����������� �������� ����������� ���������.
										  --��� ���� ����� ��� �������� ����� ����� 0.
										  --��� ������������� ���������� ���� ������ ��� �������� ����� ��������� ������������� ���������� ���� ������
		  
		  ,rs.[sql_handle] --���-����� ������ SQL-�������
	      ,rs.[statement_start_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������.
									  --����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									  --��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,rs.[statement_end_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������.
									--����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									--��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,rs.[plan_handle] --���-����� ����� ���������� SQL
	      ,rs.[database_id] --������������� ���� ������, � ������� ����������� ������
	      ,rs.[user_id] --������������� ������������, ������������ ������ ������
	      ,rs.[connection_id] --������������� ����������, �� �������� �������� ������
		  ,rs.[is_blocking_other_session] --1-������ ���� ��������� ������ ������, 0-������ ���� �� ��������� ������ ������
		  ,rs.[dop] --������� ������������ �������
		  ,rs.[request_time] --���� � ����� ��������� ������� �� ��������������� ������
		  ,rs.[grant_time] --���� � �����, ����� ������� ���� ������������� ������. ���������� �������� NULL, ���� ������ ��� �� ���� �������������
		  ,rs.[requested_memory_kb] --����� ����� ����������� ������ � ����������
		  ,rs.[granted_memory_kb] --����� ����� ���������� ��������������� ������ � ����������.
								  --����� ���� �������� NULL, ���� ������ ��� �� ���� �������������.
								  --������ ��� �������� ������ ���� ���������� � requested_memory_kb.
								  --��� �������� ������� ������ ����� ��������� �������������� �������������� �� ���������� ������,
								  --����� ������� ������� �� ����� ���������� ��������������� ������
		  
		  ,rs.[required_memory_kb] --����������� ����� ������ � ���������� (��), ����������� ��� ���������� ������� �������.
								   --�������� requested_memory_kb ����� ����� ������ ��� ������ ���
		  
		  ,rs.[used_memory_kb] --������������ � ������ ������ ����� ���������� ������ (� ����������)
		  ,rs.[max_used_memory_kb] --������������ ����� ������������ �� ������� ������� ���������� ������ � ����������
		  ,rs.[query_cost] --��������� ��������� �������
		  ,rs.[timeout_sec] --����� �������� ������� ������� � �������� �� ������ �� ��������� �� ��������������� ������
		  ,rs.[resource_semaphore_id] --������������ ������������� �������� �������, �������� ������� ������ ������
		  ,rs.[queue_id] --������������� ��������� �������, � ������� ������ ������ ������� �������������� ������.
						 --�������� NULL, ���� ������ ��� �������������
		  
		  ,rs.[wait_order] --���������������� ������� ��������� �������� � ��������� ������� queue_id.
						   --��� �������� ����� ���������� ��� ��������� �������, ���� ������ ������� ������������ �� �������������� ������ ��� �������� ��.
						   --�������� NULL, ���� ������ ��� �������������
		  
		  ,rs.[is_next_candidate] --�������� ��������� ���������� �� �������������� ������ (1 = ��, 0 = ���, NULL = ������ ��� �������������)
		  ,rs.[wait_time_ms] --����� �������� � �������������. �������� NULL, ���� ������ ��� �������������
		  ,rs.[pool_id] --������������� ���� ��������, � �������� ����������� ������ ������ ������� ��������
		  ,rs.[is_small] --�������� 1 ��������, ��� ��� ������ �������� �������������� ������ ������������ ����� ������� �������.
						 --�������� 0 �������� ������������� �������� ��������
		  
		  ,rs.[ideal_memory_kb] --�����, � ���������� (��), ��������������� ������, ����������� ��� ���������� ���� ������ � ���������� ������.
								--������������ �� ������ ���������� ���������
		  
		  ,rs.[reserved_worker_count] --����� ������� ���������, ����������������� � ������� ������������ ��������, � ����� ����� �������� ������� ���������, ������������ ����� ���������
		  ,rs.[used_worker_count] --����� ������� ���������, ������������ ������������ ��������
		  ,rs.[max_used_worker_count] --???
		  ,rs.[reserved_node_bitmap] --???
		  ,rs.[bucketid] --������������� �������� ����, � ������� ���������� ������.
						 --�������� ��������� �������� �� 0 �� �������� ������� ���-������� ��� ���� ����.
						 --��� ����� SQL Plans � Object Plans ������ ���-������� ����� ��������� 10007 �� 32-��������� ������� ������ � 40009 � �� 64-���������.
						 --��� ���� Bound Trees ������ ���-������� ����� ��������� 1009 �� 32-��������� ������� ������ � 4001 �� 64-���������.
						 --��� ���� ����������� �������� �������� ������ ���-������� ����� ��������� 127 �� 32-��������� � 64-��������� ������� ������
		  
		  ,rs.[refcounts] --����� �������� ����, ����������� �� ������ ������ ����.
						  --�������� refcounts ��� ������ ������ ���� �� ������ 1, ����� ����������� � ����
		  
		  ,rs.[usecounts] --���������� ���������� ������ ������� ����.
						  --�������� ��� ����������, ���� ����������������� ������� ������������ ���� � ����.
						  --����� ���� �������� ��������� ��� ��� ������������� ���������� showplan
		  
		  ,rs.[size_in_bytes] --����� ������, ���������� �������� ����
		  ,rs.[memory_object_address] --����� ������ ������������ ������.
									  --��� �������� ����� ������������ � �������������� sys.dm_os_memory_objects,
									  --����� ���������������� ������������� ������ ������������� �����, 
									  --� � �������������� sys.dm_os_memory_cache_entries ��� ����������� ������ �� ����������� ������
		  
		  ,rs.[cacheobjtype] --��� ������� � ����. �������� ����� ���� ����� �� ���������
		  ,rs.[objtype] --��� �������. �������� ����� ���� ����� �� ���������
		  ,rs.[parent_plan_handle] --������������ ����
		  
		  --������ �� sys.dm_exec_query_stats ������� �� �����, � ������� ���� ���� (������, ����)
		  ,rs.[creation_time] --����� ���������� �����
		  ,rs.[execution_count] --���������� ���������� ����� � ������� ��������� ����������
		  ,rs.[total_worker_time] --����� ����� ��, ����������� �� ���������� ����� � ������� ����������, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_last_worker_time] --����������� ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_last_worker_time] --������������ ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_worker_time] --����������� ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_worker_time] --������������ ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[total_physical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_physical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_physical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_physical_reads] --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_physical_reads] --������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_logical_writes] --����� ���������� �������� ���������� ������ ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_logical_writes] --����������� ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_logical_writes] --������������ ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_logical_writes] --����������� ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_logical_writes] --������������ ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_logical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_logical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_logical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_logical_reads]	   --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_logical_reads]	--������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_clr_time]	--�����, � ������������� (�� � ��������� �� ������������),
								--������ Microsoft .NET Framework ������������ ����� ���������� (CLR) ������� ��� ���������� ����� � ������� ��� ����������.
								--������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[min_last_clr_time] --����������� �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[max_last_clr_time] --������������ �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[min_clr_time] --����������� �����, �����-���� ����������� �� ���������� ����� ������ �������� .NET Framework ����� CLR,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[max_clr_time] --������������ �����, �����-���� ����������� �� ���������� ����� ������ ����� CLR .NET Framework,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  --,rs.[total_elapsed_time] --����� �����, ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_last_elapsed_time] --����������� �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_last_elapsed_time] --������������ �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_elapsed_time] --����������� �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_elapsed_time] --������������ �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[total_rows] --����� ����� �����, ������������ ��������. �� ����� ����� �������� null.
						   --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_rows] --����������� ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_rows] --������������ ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[min_rows] --����������� ���������� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[max_rows] --������������ ����� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[total_dop] --����� ����� �� ������� ������������ ����� ������������ � ������� ��� ����������.
						  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_dop] --����������� ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_dop] --������������ ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_dop] --����������� ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_dop] --������������ ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ���������� � ������� ��� ����������.
							   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_grant_kb] --����������� ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_grant_kb] --������������ ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_grant_kb] --����������� ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_grant_kb] --������������ ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_used_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ������������ � ������� ��� ����������.
									--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_used_grant_kb] --����������� ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_used_grant_kb] --������������ ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_used_grant_kb] --����������� ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_used_grant_kb] --������������ ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_ideal_grant_kb] --����� ����� ��������� ������ � ��, ������ ����� � ������� ��� ����������.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_ideal_grant_kb] --����������� ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_ideal_grant_kb] --������������ ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_ideal_grant_kb] --����������� ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_ideal_grant_kb] --������������ ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_reserved_threads] --����� ����� �� ����������������� ������������� ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_reserved_threads] --����������� ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_reserved_threads] --������������ ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_reserved_threads] --����������� ����� ����������������� ������������� �������, �����-���� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_reserved_threads] --������������ ����� ����������������� ������������� ������� ������� �� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_used_threads] --����� ����� ������������ ������������ ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_used_threads] --����������� ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_used_threads] --������������ ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_used_threads] --����������� ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_used_threads] --������������ ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������

		  ,rs.[InsertUTCDate] --���� � ����� �������� ������ � UTC
		  ,rs.[EndRegUTCDate] --���� � ����� �������� ������ �� �������� �������� � UTC
  FROM [srv].[RequestStatistics] as rs with(readuncommitted)
  inner join [srv].[PlanQuery] as pq on rs.[plan_handle]=pq.[PlanHandle] and rs.[sql_handle]=pq.[SqlHandle]
  inner join [srv].[SQLQuery] as sq on sq.[SqlHandle]=pq.[SqlHandle]
  union all
  select rs.[session_id] --������
	      ,rs.[blocking_session_id] --������, ������� ���� ��������� ������ [session_id]
		  ,rs.[request_id] --������������� �������. �������� � ��������� ������
	      ,rs.[start_time] --����� ������� ����������� �������
		  ,DateDiff(second, rs.[start_time], GetDate()) as [date_diffSec] --������� � ��� ������ ������� �� ������� ����������� �������
	      ,rs.[status] --��������� �������
	      ,rs.[command] --��� ����������� � ������ ������ �������
		  , COALESCE(
						CAST(NULLIF(rs.[total_elapsed_time] / 1000, 0) as BIGINT)
					   ,CASE WHEN (rs.[status]  <> 'running') 
								THEN  DATEDIFF(ss,0,getdate() - nullif(rs.[last_request_end_time], '1900-01-01T00:00:00.000'))
						END
					) as [total_time, sec] --����� ���� ������ ������� � ���
		  , CAST(NULLIF((CAST(rs.[total_elapsed_time] as BIGINT) - CAST(rs.[wait_time] AS BIGINT)) / 1000, 0 ) as bigint) as [work_time, sec] --����� ������ ������� � ��� ��� ����� ������� ��������
		  , CASE WHEN (rs.[status] <> 'running') 
		  			THEN  DATEDIFF(ss,0,getdate() - nullif(rs.[last_request_end_time], '1900-01-01T00:00:00.000'))
			END as [sleep_time, sec] --����� ��� � ���
		  , NULLIF( CAST((rs.[logical_reads] + rs.[writes]) * 8 / 1024 as numeric(38,2)), 0) as [IO, MB] --�������� ������ � ������ � ��
		  , CASE  rs.transaction_isolation_level
			WHEN 0 THEN 'Unspecified'
			WHEN 1 THEN 'ReadUncommited'
			WHEN 2 THEN 'ReadCommited'
			WHEN 3 THEN 'Repetable'
			WHEN 4 THEN 'Serializable'
			WHEN 5 THEN 'Snapshot'
			END as [transaction_isolation_level_desc] --������� �������� ���������� (�����������)
		  ,rs.[percent_complete] --������� ���������� ������ ��� ��������� ������
		  ,DB_NAME(rs.[database_id]) as [DBName] --��
		  , SUBSTRING(
						sq.[TSQL]
					  , rs.[statement_start_offset]/2+1
					  ,	(
							CASE WHEN ((rs.[statement_start_offset]<0) OR (rs.[statement_end_offset]<0))
									THEN DATALENGTH (sq.[TSQL])
								 ELSE rs.[statement_end_offset]
							END
							- rs.[statement_start_offset]
						)/2 +1
					 ) as [CURRENT_REQUEST] --������� ����������� ������ � ������
	      ,sq.[TSQL] --������ ����� ������
		  ,pq.[QueryPlan] --���� ����� ������
	      ,rs.[wait_type] --���� ������ � ��������� ������ ����������, � ������� ���������� ��� �������� (sys.dm_os_wait_stats)
	      ,rs.[login_time] --����� ����������� ������
		  ,rs.[host_name] --��� ���������� ������� �������, ��������� � ������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[program_name] --��� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
	      ,cast(rs.[wait_time]/1000 as decimal(18,3)) as [wait_timeSec] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� ��������)
	      ,rs.[wait_time] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������)
	      ,rs.[last_wait_type] --���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������
	      ,rs.[wait_resource] --���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������
	      ,rs.[open_transaction_count] --����� ����������, �������� ��� ������� �������
	      ,rs.[open_resultset_count] --����� �������������� �������, �������� ��� ������� �������
	      ,rs.[transaction_id] --������������� ����������, � ������� ����������� ������
	      ,rs.[context_info] --�������� CONTEXT_INFO ������
		  ,cast(rs.[estimated_completion_time]/1000 as decimal(18,3)) as [estimated_completion_timeSec] --������ ��� ����������� �������������. �� ��������� �������� NULL
	      ,rs.[estimated_completion_time] --������ ��� ����������� �������������. �� ��������� �������� NULL
		  ,cast(rs.[cpu_time]/1000 as decimal(18,3)) as [cpu_timeSec] --����� �� (� ��������), ����������� �� ���������� �������
	      ,rs.[cpu_time] --����� �� (� �������������), ����������� �� ���������� �������
		  ,cast(rs.[total_elapsed_time]/1000 as decimal(18,3)) as [total_elapsed_timeSec] --����� �����, �������� � ������� ����������� ������� (� ��������)
	      ,rs.[total_elapsed_time] --����� �����, �������� � ������� ����������� ������� (� �������������)
	      ,rs.[scheduler_id] --������������� ������������, ������� ��������� ������ ������
	      ,rs.[task_address] --����� ����� ������, ����������� ��� ������, ��������� � ���� ��������
	      ,rs.[reads] --����� �������� ������, ����������� ������ ��������
	      ,rs.[writes] --����� �������� ������, ����������� ������ ��������
	      ,rs.[logical_reads] --����� ���������� �������� ������, ����������� ������ ��������
	      ,rs.[text_size] --��������� ��������� TEXTSIZE ��� ������� �������
	      ,rs.[language] --��������� ����� ��� ������� �������
	      ,rs.[date_format] --��������� ��������� DATEFORMAT ��� ������� �������
	      ,rs.[date_first] --��������� ��������� DATEFIRST ��� ������� �������
	      ,rs.[quoted_identifier] --1 = �������� QUOTED_IDENTIFIER ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[arithabort] --1 = �������� ARITHABORT ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_null_dflt_on] --1 = �������� ANSI_NULL_DFLT_ON ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_defaults] --1 = �������� ANSI_DEFAULTS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_warnings] --1 = �������� ANSI_WARNINGS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[ansi_padding] --1 = �������� ANSI_PADDING ��� ������� ������� (ON)
	      ,rs.[ansi_nulls] --1 = �������� ANSI_NULLS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[concat_null_yields_null] --1 = �������� CONCAT_NULL_YIELDS_NULL ��� ������� ������� (ON). � ��������� ������ � 0
	      ,rs.[transaction_isolation_level] --������� ��������, � ������� ������� ���������� ��� ������� �������
		  ,cast(rs.[lock_timeout]/1000 as decimal(18,3)) as [lock_timeoutSec] --����� �������� ���������� ��� ������� ������� (� ��������)
		  ,rs.[lock_timeout] --����� �������� ���������� ��� ������� ������� (� �������������)
	      ,rs.[deadlock_priority] --�������� ��������� DEADLOCK_PRIORITY ��� ������� �������
	      ,rs.[row_count] --����� �����, ������������ ������� �� ������� �������
	      ,rs.[prev_error] --��������� ������, ����������� ��� ���������� �������
	      ,rs.[nest_level] --������� ������� ����������� ����, ������������ ��� ������� �������
	      ,rs.[granted_query_memory] --����� �������, ���������� ��� ���������� ������������ ������� (1 ��������-��� �������� 8 ��)
	      ,rs.[executing_managed_code] --���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������).
									  --���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL
	      
		  ,rs.[group_id]	--������������� ������ ������� ��������, ������� ����������� ���� ������
	      ,rs.[query_hash] --�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������.
						  --����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������
	      
		  ,rs.[query_plan_hash] --�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������.
							   --����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������
		  
		  ,rs.[most_recent_session_id] --������������ ����� ������������� ������ ������ ���������� �������, ���������� � ������ �����������
	      ,rs.[connect_time] --������� ������� ������������ ����������
	      ,rs.[net_transport] --�������� �������� ����������� ������������� ���������, ������������� ������ �����������
	      ,rs.[protocol_type] --��������� ��� ��������� �������� �������� ������
	      ,rs.[protocol_version] --������ ��������� ������� � ������, ���������� � ������ �����������
	      ,rs.[endpoint_id] --�������������, ����������� ��� ����������. ���� ������������� endpoint_id ����� �������������� ��� �������� � ������������� sys.endpoints
	      ,rs.[encrypt_option] --���������� ��������, �����������, ��������� �� ���������� ��� ������� ����������
	      ,rs.[auth_scheme] --��������� ����� �������� ����������� (SQL Server ��� Windows), ������������ � ������ �����������
	      ,rs.[node_affinity] --�������������� ���� ������, �������� ������������� ������ ����������
	      ,rs.[num_reads] --����� �������, �������� ����������� ������� ����������
	      ,rs.[num_writes] --����� �������, ���������� ����������� ������� ����������
	      ,rs.[last_read] --������� ������� � ��������� ���������� ������ ������
	      ,rs.[last_write] --������� ������� � ��������� ������������ ������ ������
	      ,rs.[net_packet_size] --������ �������� ������, ������������ ��� �������� ������
	      ,rs.[client_net_address] --������� ����� ���������� �������
	      ,rs.[client_tcp_port] --����� ����� �� ���������� ����������, ������� ������������ ��� ������������� ����������
	      ,rs.[local_net_address] --IP-����� �������, � ������� ����������� ������ ����������. �������� ������ ��� ����������, ������� � �������� ���������� ������ ���������� �������� TCP
	      ,rs.[local_tcp_port] --TCP-���� �������, ���� ���������� ���������� �������� TCP
	      ,rs.[parent_connection_id] --�������������� ��������� ����������, ������������ � ������ MARS
	      ,rs.[most_recent_sql_handle] --���������� ���������� ������� SQL, ������������ � ������� ������� ����������. ��������� ���������� ������������� ����� �������� most_recent_sql_handle � �������� most_recent_session_id
		  ,rs.[host_process_id] --������������� �������� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[client_version] --������ TDS-��������� ����������, ������� ������������ �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[client_interface_name] --��� ���������� ��� �������, ������������ �������� ��� ������ ������� � ��������. ��� ����������� ������ ��� �������� ����� NULL
		  ,rs.[security_id] --������������� ������������ Microsoft Windows, ��������� � ������ �����
		  ,rs.[login_name] --SQL Server ��� �����, ��� ������� ����������� ������� �����.
						  --����� ������ �������������� ��� �����, � ������� �������� ��� ������ �����, ��. �������� original_login_name.
						  --����� ���� SQL Server �������� ����������� ����� ����� ��� ����� ������������ ������, ���������� �������� ����������� Windows
		  
		  ,rs.[nt_domain] --����� Windows ��� �������, ���� �� ����� ������ ����������� �������� ����������� Windows ��� ������������� ����������.
						 --��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,rs.[nt_user_name] --��� ������������ Windows ��� �������, ���� �� ����� ������ ������������ �������� ����������� Windows ��� ������������� ����������.
							--��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,rs.[memory_usage] --���������� 8-������������ ������� ������, ������������ ������ �������
		  ,rs.[total_scheduled_time] --����� �����, ����������� ������� ������ (������� ��� ��������� �������) ��� ����������, � �������������
		  ,rs.[last_request_start_time] --�����, ����� ������� ��������� ������ ������� ������. ��� ����� ���� ������, ������������� � ������ ������
		  ,rs.[last_request_end_time] --����� ���������� ���������� ������� � ������ ������� ������
		  ,rs.[is_user_process] --0, ���� ����� �������� ���������. � ��������� ������ �������� ����� 1
		  ,rs.[original_security_id] --Microsoft ������������� ������������ Windows, ��������� � ���������� original_login_name
		  ,rs.[original_login_name] --SQL Server ��� �����, ������� ���������� ������ ������ ������ �����.
								   --��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ��� ������������ ������ Windows, 
								   --��������� �������� �����������, ��� ������������ ���������� ���� ������.
								   --�������� ��������, ��� ����� ��������������� ���������� ��� ������ ����� ���� ��������� ����� ������� ��� ����� ������������ ���������.
								   --�������� ���� EXECUTE AS ������������
		  
		  ,rs.[last_successful_logon] --����� ���������� ��������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,rs.[last_unsuccessful_logon] --����� ���������� ����������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,rs.[unsuccessful_logons] --����� ���������� ������� ����� � ������� ��� ����� original_login_name ����� �������� last_successful_logon � �������� login_time
		  ,rs.[authenticating_database_id] --������������� ���� ������, ����������� �������� ����������� ���������.
										  --��� ���� ����� ��� �������� ����� ����� 0.
										  --��� ������������� ���������� ���� ������ ��� �������� ����� ��������� ������������� ���������� ���� ������
		  
		  ,rs.[sql_handle] --���-����� ������ SQL-�������
	      ,rs.[statement_start_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������.
									  --����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									  --��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,rs.[statement_end_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������.
									--����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									--��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,rs.[plan_handle] --���-����� ����� ���������� SQL
	      ,rs.[database_id] --������������� ���� ������, � ������� ����������� ������
	      ,rs.[user_id] --������������� ������������, ������������ ������ ������
	      ,rs.[connection_id] --������������� ����������, �� �������� �������� ������
		  ,rs.[is_blocking_other_session] --1-������ ���� ��������� ������ ������, 0-������ ���� �� ��������� ������ ������
		  ,rs.[dop] --������� ������������ �������
		  ,rs.[request_time] --���� � ����� ��������� ������� �� ��������������� ������
		  ,rs.[grant_time] --���� � �����, ����� ������� ���� ������������� ������. ���������� �������� NULL, ���� ������ ��� �� ���� �������������
		  ,rs.[requested_memory_kb] --����� ����� ����������� ������ � ����������
		  ,rs.[granted_memory_kb] --����� ����� ���������� ��������������� ������ � ����������.
								  --����� ���� �������� NULL, ���� ������ ��� �� ���� �������������.
								  --������ ��� �������� ������ ���� ���������� � requested_memory_kb.
								  --��� �������� ������� ������ ����� ��������� �������������� �������������� �� ���������� ������,
								  --����� ������� ������� �� ����� ���������� ��������������� ������
		  
		  ,rs.[required_memory_kb] --����������� ����� ������ � ���������� (��), ����������� ��� ���������� ������� �������.
								   --�������� requested_memory_kb ����� ����� ������ ��� ������ ���
		  
		  ,rs.[used_memory_kb] --������������ � ������ ������ ����� ���������� ������ (� ����������)
		  ,rs.[max_used_memory_kb] --������������ ����� ������������ �� ������� ������� ���������� ������ � ����������
		  ,rs.[query_cost] --��������� ��������� �������
		  ,rs.[timeout_sec] --����� �������� ������� ������� � �������� �� ������ �� ��������� �� ��������������� ������
		  ,rs.[resource_semaphore_id] --������������ ������������� �������� �������, �������� ������� ������ ������
		  ,rs.[queue_id] --������������� ��������� �������, � ������� ������ ������ ������� �������������� ������.
						 --�������� NULL, ���� ������ ��� �������������
		  
		  ,rs.[wait_order] --���������������� ������� ��������� �������� � ��������� ������� queue_id.
						   --��� �������� ����� ���������� ��� ��������� �������, ���� ������ ������� ������������ �� �������������� ������ ��� �������� ��.
						   --�������� NULL, ���� ������ ��� �������������
		  
		  ,rs.[is_next_candidate] --�������� ��������� ���������� �� �������������� ������ (1 = ��, 0 = ���, NULL = ������ ��� �������������)
		  ,rs.[wait_time_ms] --����� �������� � �������������. �������� NULL, ���� ������ ��� �������������
		  ,rs.[pool_id] --������������� ���� ��������, � �������� ����������� ������ ������ ������� ��������
		  ,rs.[is_small] --�������� 1 ��������, ��� ��� ������ �������� �������������� ������ ������������ ����� ������� �������.
						 --�������� 0 �������� ������������� �������� ��������
		  
		  ,rs.[ideal_memory_kb] --�����, � ���������� (��), ��������������� ������, ����������� ��� ���������� ���� ������ � ���������� ������.
								--������������ �� ������ ���������� ���������
		  
		  ,rs.[reserved_worker_count] --����� ������� ���������, ����������������� � ������� ������������ ��������, � ����� ����� �������� ������� ���������, ������������ ����� ���������
		  ,rs.[used_worker_count] --����� ������� ���������, ������������ ������������ ��������
		  ,rs.[max_used_worker_count] --???
		  ,rs.[reserved_node_bitmap] --???
		  ,rs.[bucketid] --������������� �������� ����, � ������� ���������� ������.
						 --�������� ��������� �������� �� 0 �� �������� ������� ���-������� ��� ���� ����.
						 --��� ����� SQL Plans � Object Plans ������ ���-������� ����� ��������� 10007 �� 32-��������� ������� ������ � 40009 � �� 64-���������.
						 --��� ���� Bound Trees ������ ���-������� ����� ��������� 1009 �� 32-��������� ������� ������ � 4001 �� 64-���������.
						 --��� ���� ����������� �������� �������� ������ ���-������� ����� ��������� 127 �� 32-��������� � 64-��������� ������� ������
		  
		  ,rs.[refcounts] --����� �������� ����, ����������� �� ������ ������ ����.
						  --�������� refcounts ��� ������ ������ ���� �� ������ 1, ����� ����������� � ����
		  
		  ,rs.[usecounts] --���������� ���������� ������ ������� ����.
						  --�������� ��� ����������, ���� ����������������� ������� ������������ ���� � ����.
						  --����� ���� �������� ��������� ��� ��� ������������� ���������� showplan
		  
		  ,rs.[size_in_bytes] --����� ������, ���������� �������� ����
		  ,rs.[memory_object_address] --����� ������ ������������ ������.
									  --��� �������� ����� ������������ � �������������� sys.dm_os_memory_objects,
									  --����� ���������������� ������������� ������ ������������� �����, 
									  --� � �������������� sys.dm_os_memory_cache_entries ��� ����������� ������ �� ����������� ������
		  
		  ,rs.[cacheobjtype] --��� ������� � ����. �������� ����� ���� ����� �� ���������
		  ,rs.[objtype] --��� �������. �������� ����� ���� ����� �� ���������
		  ,rs.[parent_plan_handle] --������������ ����
		  
		  --������ �� sys.dm_exec_query_stats ������� �� �����, � ������� ���� ���� (������, ����)
		  ,rs.[creation_time] --����� ���������� �����
		  ,rs.[execution_count] --���������� ���������� ����� � ������� ��������� ����������
		  ,rs.[total_worker_time] --����� ����� ��, ����������� �� ���������� ����� � ������� ����������, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_last_worker_time] --����������� ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_last_worker_time] --������������ ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_worker_time] --����������� ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_worker_time] --������������ ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[total_physical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_physical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_physical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_physical_reads] --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_physical_reads] --������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_logical_writes] --����� ���������� �������� ���������� ������ ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_logical_writes] --����������� ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_logical_writes] --������������ ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_logical_writes] --����������� ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_logical_writes] --������������ ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_logical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_logical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_logical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[min_logical_reads]	   --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[max_logical_reads]	--������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,rs.[total_clr_time]	--�����, � ������������� (�� � ��������� �� ������������),
								--������ Microsoft .NET Framework ������������ ����� ���������� (CLR) ������� ��� ���������� ����� � ������� ��� ����������.
								--������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[min_last_clr_time] --����������� �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[max_last_clr_time] --������������ �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[min_clr_time] --����������� �����, �����-���� ����������� �� ���������� ����� ������ �������� .NET Framework ����� CLR,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,rs.[max_clr_time] --������������ �����, �����-���� ����������� �� ���������� ����� ������ ����� CLR .NET Framework,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  --,rs.[total_elapsed_time] --����� �����, ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_last_elapsed_time] --����������� �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_last_elapsed_time] --������������ �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[min_elapsed_time] --����������� �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[max_elapsed_time] --������������ �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,rs.[total_rows] --����� ����� �����, ������������ ��������. �� ����� ����� �������� null.
						   --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[min_last_rows] --����������� ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[max_last_rows] --������������ ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[min_rows] --����������� ���������� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[max_rows] --������������ ����� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,rs.[total_dop] --����� ����� �� ������� ������������ ����� ������������ � ������� ��� ����������.
						  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_dop] --����������� ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_dop] --������������ ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_dop] --����������� ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_dop] --������������ ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ���������� � ������� ��� ����������.
							   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_grant_kb] --����������� ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_grant_kb] --������������ ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_grant_kb] --����������� ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_grant_kb] --������������ ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_used_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ������������ � ������� ��� ����������.
									--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_used_grant_kb] --����������� ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_used_grant_kb] --������������ ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_used_grant_kb] --����������� ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_used_grant_kb] --������������ ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_ideal_grant_kb] --����� ����� ��������� ������ � ��, ������ ����� � ������� ��� ����������.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_ideal_grant_kb] --����������� ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_ideal_grant_kb] --������������ ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_ideal_grant_kb] --����������� ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_ideal_grant_kb] --������������ ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_reserved_threads] --����� ����� �� ����������������� ������������� ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_reserved_threads] --����������� ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_reserved_threads] --������������ ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_reserved_threads] --����������� ����� ����������������� ������������� �������, �����-���� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_reserved_threads] --������������ ����� ����������������� ������������� ������� ������� �� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[total_used_threads] --����� ����� ������������ ������������ ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_last_used_threads] --����������� ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_last_used_threads] --������������ ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[min_used_threads] --����������� ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,rs.[max_used_threads] --������������ ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������

		  ,rs.[InsertUTCDate] --���� � ����� �������� ������ � UTC
		  ,rs.[EndRegUTCDate] --���� � ����� �������� ������ �� �������� �������� � UTC
  FROM [srv].[RequestStatisticsArchive] as rs with(readuncommitted)
  inner join [srv].[PlanQuery] as pq on rs.[plan_handle]=pq.[PlanHandle] and rs.[sql_handle]=pq.[SqlHandle]
  inner join [srv].[SQLQuery] as sq on sq.[SqlHandle]=pq.[SqlHandle]


GO
/****** Object:  Table [srv].[DBFile]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[DBFile](
	[DBFile_GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Server] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Drive] [nvarchar](10) NOT NULL,
	[Physical_Name] [nvarchar](255) NOT NULL,
	[Ext] [nvarchar](255) NOT NULL,
	[Growth] [int] NOT NULL,
	[IsPercentGrowth] [int] NOT NULL,
	[DB_ID] [int] NOT NULL,
	[DB_Name] [nvarchar](255) NOT NULL,
	[SizeMb] [float] NOT NULL,
	[DiffSizeMb] [float] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[UpdateUTCdate] [datetime] NOT NULL,
	[File_ID] [int] NOT NULL,
 CONSTRAINT [PK_DBFile] PRIMARY KEY CLUSTERED 
(
	[DBFile_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vDBFiles]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [srv].[vDBFiles] as
SELECT [DBFile_GUID]
      ,[Server]
      ,[Name]
      ,[Drive]
      ,[Physical_Name]
      ,[Ext]
      ,[Growth]
      ,[IsPercentGrowth]
      ,[DB_ID]
	  ,[File_ID]
      ,[DB_Name]
      ,[SizeMb]
      ,[DiffSizeMb]
	  ,round([SizeMb]/1024,3) as [SizeGb]
      ,round([DiffSizeMb]/1024,3) as [DiffSizeGb]
	  ,round([SizeMb]/1024/1024,3) as [SizeTb]
      ,round([DiffSizeMb]/1024/1024,3) as [DiffSizeTb]
	  ,round([DiffSizeMb]/([SizeMb]/100), 3) as [DiffSizePercent]
      ,[InsertUTCDate]
      ,[UpdateUTCdate]
  FROM [srv].[DBFile];
GO
/****** Object:  View [inf].[vJobServers]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobServers] as
SELECT [job_id]
      ,[server_id]
      ,[last_run_outcome]
      ,[last_outcome_message]
      ,[last_run_date]
      ,[last_run_time]
      ,[last_run_duration]
  FROM [msdb].[dbo].[sysjobservers];

GO
/****** Object:  View [inf].[vJOBS]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJOBS] as
select
	job_id,
	originating_server,
	name,
	enabled,
	description,
	start_step_id,
	category_id,
	owner_sid,
	notify_level_eventlog,
	notify_level_email,
	notify_level_netsend,
	notify_level_page,
	notify_email_operator_id,
	notify_netsend_operator_id,
	notify_page_operator_id,
	delete_level,
	date_created,
	date_modified,
	version_number,
	originating_server_id,
	master_server
from msdb.dbo.sysjobs_view

GO
/****** Object:  View [inf].[vJobRunShortInfo]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [inf].[vJobRunShortInfo] as
SELECT sj.[job_id] as Job_GUID
      ,j.name as Job_Name
      ,case sj.[last_run_outcome]
		when 0 then '������'
		when 1 then '�������'
		when 3 then '��������'
		else case when sj.[last_run_date] is not null and len(sj.[last_run_date])=8 then '�������������� ���������'
				else NULL
				end
	   end as LastFinishRunState
	  ,sj.[last_run_outcome] as LastRunOutcome
	  ,case when sj.[last_run_date] is not null and len(sj.[last_run_date])=8 then
		DATETIMEFROMPARTS(
							substring(cast(sj.[last_run_date] as nvarchar(255)),1,4),
							substring(cast(sj.[last_run_date] as nvarchar(255)),5,2),
							substring(cast(sj.[last_run_date] as nvarchar(255)),7,2),
							case when len(cast(sj.[last_run_time] as nvarchar(255)))>=5 then substring(cast(sj.[last_run_time] as nvarchar(255)),1,len(cast(sj.[last_run_time] as nvarchar(255)))-4)
								else 0
							end,
							case when len(right(cast(sj.[last_run_time] as nvarchar(255)),4))>=4 then substring(right(cast(sj.[last_run_time] as nvarchar(255)),4),1,2)
								 when len(right(cast(sj.[last_run_time] as nvarchar(255)),4))=3  then substring(right(cast(sj.[last_run_time] as nvarchar(255)),4),1,1)
								 else 0
							end,
							right(cast(sj.[last_run_duration] as nvarchar(255)),2),
							0
						)
		else NULL
	   end as LastDateTime
       ,case when len(cast(sj.[last_run_duration] as nvarchar(255)))>5 then substring(cast(sj.[last_run_duration] as nvarchar(255)),1,len(cast(sj.[last_run_duration] as nvarchar(255)))-4)
		    when len(cast(sj.[last_run_duration] as nvarchar(255)))=5 then '0'+substring(cast(sj.[last_run_duration] as nvarchar(255)),1,len(cast(sj.[last_run_duration] as nvarchar(255)))-4)
		    else '00'
	   end
	   +':'
	   +case when len(cast(sj.[last_run_duration] as nvarchar(255)))>=4 then substring(right(cast(sj.[last_run_duration] as nvarchar(255)),4),1,2)
			 when len(cast(sj.[last_run_duration] as nvarchar(255)))=3  then '0'+substring(right(cast(sj.[last_run_duration] as nvarchar(255)),4),1,1)
			 else '00'
	   end
	   +':'
	   +case when len(cast(sj.[last_run_duration] as nvarchar(255)))>=2 then substring(right(cast(sj.[last_run_duration] as nvarchar(255)),2),1,2)
			 when len(cast(sj.[last_run_duration] as nvarchar(255)))=2  then '0'+substring(right(cast(sj.[last_run_duration] as nvarchar(255)),2),1,1)
			 else '00'
	   end as [LastRunDurationString]
	  ,sj.last_run_duration as LastRunDurationInt
	  ,sj.[last_outcome_message] as LastOutcomeMessage
	  ,j.enabled as [Enabled]
  FROM [inf].[vJobServers] as sj
  inner join [inf].[vJOBS] as j on j.job_id=sj.job_id




GO
/****** Object:  Table [srv].[Address]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[Address](
	[Address_GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Recipient_GUID] [uniqueidentifier] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Address_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Address] UNIQUE NONCLUSTERED 
(
	[Recipient_GUID] ASC,
	[Address] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[Recipient]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[Recipient](
	[Recipient_GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Recipient_Name] [nvarchar](255) NOT NULL,
	[Recipient_Code] [nvarchar](10) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Recipient] PRIMARY KEY CLUSTERED 
(
	[Recipient_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Recipient_Code] UNIQUE NONCLUSTERED 
(
	[Recipient_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Recipient_Name] UNIQUE NONCLUSTERED 
(
	[Recipient_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vRecipientAddress]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vRecipientAddress] as
select t1.Address, 
	   t2.Recipient_Code, 
	   t2.Recipient_Name, 
	   t1.IsDeleted as AddressIsDeleted,
	   t2.IsDeleted as RecipientIsDeleted
from [srv].[Address] as t1
inner join [srv].[Recipient] as t2 on t1.Recipient_GUID=t2.Recipient_GUID
GO
/****** Object:  Table [srv].[ServerDBFileInfoStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ServerDBFileInfoStatistics](
	[Row_GUID] [uniqueidentifier] NOT NULL,
	[ServerName] [nvarchar](255) NOT NULL,
	[DBName] [nvarchar](128) NULL,
	[File_id] [int] NOT NULL,
	[Type_desc] [nvarchar](60) NULL,
	[FileName] [sysname] NOT NULL,
	[Drive] [nvarchar](1) NULL,
	[Ext] [nvarchar](3) NULL,
	[CountPage] [int] NOT NULL,
	[SizeMb] [float] NULL,
	[SizeGb] [float] NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ServerDBFileInfoStatistics] PRIMARY KEY CLUSTERED 
(
	[Row_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [srv].[vServerDBFileInfoStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [srv].[vServerDBFileInfoStatistics] as
SELECT [ServerName]
	  ,[DBName]
      ,[File_id]
      ,[Type_desc]
      ,[FileName]
      ,[Drive]
      ,[Ext]
      ,MIN([CountPage]) as MinCountPage
	  ,MAX([CountPage]) as MaxCountPage
	  ,AVG([CountPage]) as AvgCountPage
	  ,MAX([CountPage])-MIN([CountPage]) as AbsDiffCountPage
	  ,MIN([SizeMb]) as MinSizeMb
	  ,MAX([SizeMb]) as MaxSizeMb
	  ,AVG([SizeMb]) as AvgSizeMb
	  ,MAX([SizeMb])-MIN([SizeMb]) as AbsDiffSizeMb
	  ,MIN([SizeGb]) as MinIndexSizeGb
	  ,MAX([SizeGb]) as MaxIndexSizeGb
	  ,AVG([SizeGb]) as AvgIndexSizeGb
	  ,MAX([SizeGb])-MIN([SizeGb]) as AbsDiffIndexSizeGb
	  ,count(*) as CountRowsStatistic
	  ,MIN(InsertUTCDate) as StartInsertUTCDate
	  ,MAX(InsertUTCDate) as FinishInsertUTCDate
  FROM [srv].[ServerDBFileInfoStatistics]
  group by [ServerName]
	  ,[DBName]
      ,[File_id]
      ,[Type_desc]
      ,[FileName]
      ,[Drive]
      ,[Ext]

GO
/****** Object:  UserDefinedFunction [dbo].[GetPlansObject]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GetPlansObject]
(	
	@ObjectID int,
	@DBID int
)
RETURNS TABLE 
AS
/*
	09.08.2017 ���: ���������� ��� ����� ��������� �������
*/
RETURN 
(
	select 
	creation_time,
	last_execution_time,
	execution_count,
	total_worker_time/1000 as CPU,
	convert(money, (total_worker_time))/(execution_count*1000)as [AvgCPUTime],
	qs.total_elapsed_time/1000 as TotDuration,
	convert(money, (qs.total_elapsed_time))/(execution_count*1000)as [AvgDur],
	total_logical_reads as [Reads],
	total_logical_writes as [Writes],
	total_logical_reads+total_logical_writes as [AggIO],
	convert(money, (total_logical_reads+total_logical_writes)/(execution_count + 0.0))as [AvgIO],
	case 
		when sql_handle IS NULL then ' '
		else(substring(st.text,(qs.statement_start_offset+2)/2,(
			case
				when qs.statement_end_offset =-1 then len(convert(nvarchar(MAX),st.text))*2      
				else qs.statement_end_offset    
			end - qs.statement_start_offset)/2  ))
	end as query_text,
	db_name(st.dbid)as database_name,
	object_schema_name(st.objectid, st.dbid)+'.'+object_name(st.objectid, st.dbid) as object_name,
	qp.query_plan
	from sys.dm_exec_query_stats  qs
	cross apply sys.dm_exec_sql_text(sql_handle) st
	cross apply sys.dm_exec_query_plan(qs.plan_handle) qp
	where st.objectid=@ObjectID and st.dbid=@DBID
)
GO
/****** Object:  View [inf].[AllIndexFrag]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [inf].[AllIndexFrag] as
SELECT t2.TABLE_CATALOG as [DBName]
	 ,t2.TABLE_SCHEMA as [Schema]
	 ,t2.TABLE_NAME as [Name]
	 ,(select top(1) idx.[name] from [sys].[indexes] as idx where t1.[object_id] = idx.[object_id] and idx.[index_id] = a.[index_id]) as index_name
	 ,a.avg_fragmentation_in_percent
	 ,a.page_count
	 ,a.avg_fragment_size_in_pages
	 ,a.[database_id]
	 ,a.[object_id]
	 ,a.index_id
	 ,a.partition_number
	 ,a.index_type_desc
	 ,a.alloc_unit_type_desc
	 ,a.index_depth
	 ,a.index_level
	 ,a.fragment_count
	 ,'['+t2.table_catalog+'].['+t2.table_schema+'].['+t2.table_name+']' as FullTable
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL,
     NULL, NULL, NULL) AS a
    --JOIN sys.indexes AS b ON a.object_id = b.object_id AND a.index_id = b.index_id
	JOIN sys.tables as t1 on a.object_id=t1.object_id
	inner join INFORMATION_SCHEMA.TABLES as t2 on t1.name=t2.table_name
	--where t1.type_desc = 'USER_TABLE'
	--and t2.table_catalog='VTSDB2'
	--and a.avg_fragmentation_in_percent>30
	--order by a.avg_fragmentation_in_percent desc;





GO
/****** Object:  View [inf].[SqlLogins]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[SqlLogins]
as
/*
	���� �������� �� ����
*/
select [name] as [Name], 
create_date as CreateDate, 
modify_date as ModifyDate, 
default_database_name as DefaultDatabaseName, 
is_policy_checked as IsPolicyChecked, --�������� �������
is_expiration_checked as IsExpirationChecked, --��������� ����� �������� �������
is_disabled as IsDisabled
from sys.sql_logins
GO
/****** Object:  View [inf].[SysLogins]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[SysLogins]
as
/*
	��� ���� (�������� � ��������) �� ����
*/
select [name] as [Name],
createdate as CreateDate,
updatedate as UpdateDate,
dbname as DBName, --�� �� ���������
denylogin as DenyLogin, --�������� � �������
hasaccess as HasAccess, --�������� ���� �� ������
isntname as IsntName, --��� ����� (�����-1, �����-0)
isntgroup as IsntGroup, --������ �����
isntuser as IsntUser,--������������ �����
sysadmin as SysAdmin,
securityadmin as SecurityAdmin,
serveradmin as ServerAdmin,
setupadmin as SetupAdmin,
processadmin as ProcessAdmin,
diskadmin as DiskAdmin,
dbcreator as DBCreator,
bulkadmin as BulkAdmin
from sys.syslogins
GO
/****** Object:  View [inf].[vActiveConnect]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [inf].[vActiveConnect] as
select
    db_name([database_id]) as DBName,
    [session_id] as SessionID,
    [login_name] as LoginName,
	[program_name] as ProgramName,
	[status] as [Status],
	[login_time] as [LoginTime]
from
    sys.dm_exec_sessions
where
    [database_id] > 0




GO
/****** Object:  View [inf].[vBigQuery]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE view [inf].[vBigQuery]
as
/*
creation_time - �����, ����� ������ ��� �������������. ��������� ��� ������ ������� ��� ������, ������ ����� ������ ������ ���� ����� ������� ������� �������. ���� �����, ��������� � ���� ������� �����, ��� �������������� (������ ������������� ���������), ��� ������� � ���, ��� ������ �� ��� ��� ���� �������� ��� ��������������.
last_execution_time - ������ ������������ ���������� ���������� �������.
execution_count - ������� ��� ������ ��� �������� � ������� ����������
���������� ���������� ��������� ����� ������ � ���������� - ����� � �������� ����������� �������� ����������� ��, ������� ��������� ������ �����-���� ������ ������ ����� ���� ��������� ����� ����� ������ ���� ���. ��������, ��������� �����-���� ���������� �� ���� ������, �� ���������� ������ �����.
CPU - ��������� ����� ������������� ���������� � �������������. ���� ������ �������������� �����������, �� ��� ����� ����� ��������� ����� ����� ���������� �������, ��������� ����������� ����� ������������� ������� ������ �����. �� ����� ������������� ���������� ���������� ������ ����������� �������� �� ����, � ��� �� ������ �������� �����-���� ��������.
��������, ��� ������ ���������� ��������� �������� �������, �������� ������ ����������� ���������.
AvgCPUTime - ������� �������� ���������� �� ���� ������. 
TotDuration - ����� ����� ���������� �������, � �������������.
������ �������� ����� ���� ����������� ��� ������ ��� ��������, �������, ���������� �� ������� ����������� "�������� �����". ���� ����� ����� ���������� ������� ����������� ���� ������� CPU (� ��������� �� �����������) - ��� ������� � ���, ��� ��� ���������� ������� ���� �������� �����-���� ��������. � ����������� ������� ��� ������� � �������� ����������� ��� ������������, �� ����� ��� ����� ���� ������� ��������� ��� ������ ������. 
������ ������ ����� �������� ����� ���������� � �������� ������������� sys.dm_os_wait_stats.
AvgDur - ������� ����� ���������� ������� � �������������.
Reads - ����� ���������� ������.
��� ������� ������ ���������� ����������, ����������� ������� �������� ����������� ������ �������.
���������� ������ - ��� ������� ��������� � �������� ������, ���������� ������ �� �����������.
� ������ ���������� ������ �������, ����� ����������� ������������� ��������� � ����� � ��� �� ��������.
��� ������ ��������� � ���������, ��� ������ ��������� �������� ������, ������ �, ���� ���� ���� � ��������� ����������, ������� ����� ��������� ���������� �������� � ������.
Writes - ����� ���������� ��������� ������� ������.
������������� ��, ��� ������ "���������" �������� ������� ���������� ������.
������� �������, ��� ���� ���������� ����� ���� ������ 0 �� ������ � ��� ��������, ������� ���� ������ ������, �� ����� � � ���, ������� ��������� ������������� ������ � tempdb.
AggIO - ����� ���������� ���������� �������� �����-������ (��������)
��� �������, ���������� ���������� ������ �� ������� ��������� ���������� �������� ������, ������� ���� ���������� ��� �� ���� ��� ������� �������� � ������ �������.
AvgIO - ������� ���������� ���������� �������� �������� �� ���� ���������� �������.
�������� ������� ���������� ����� ������������� �� ��������� �����������:
���� �������� ������ - ��� 8192 �����. ����� �������� ������� ���������� ���� ������, "��������������" ������ ��������. ���� ���� ����� ��������� �������� ���������� ������, ������� ������������ ������ (��������� ����� ������ � ������������ � ������� ��������), ��� ������� � ���, ��� ��� ������ �������� ������ ���� ���������� � ��������� �������� ������������ ������� �������.
� �������� ������, ����� ���� ������ ����� ���������� ���������, ������������� ������ � 5��, ��� ���� ����� ����� ������ � ��� �� ��� 300��, � ����� ������ � ��������, ��������������� � ������� �� �������� 10��.
� ����� ����� ������� ���� ������� ������ ��������� ������� - ������ ������������� ������� ������ ������������ ����������� ������� ��� ��������.
���� ����� ���������� ������ � ���� ����������� ����� ����� ������, �� ��� ������� ��������� ���������� � ����� � ��� �� ��������� ������. ������ ����, ��� � ����� ������� ������� ����� ���� ������������ ��������� ���, � ����� � ��� �� ��������� ������ ���������� �������� � �������, ����� ������������ ������ � �� ����������� ������ �� ����, ��������� ��������� ������ ������ ����� �� ����� � ��� �� ��������. �������, � ����� ������ ���������������� ����� �� ���� ������������ ������� - � ���� ������ ������ ��������� �� � ������ �������� ������ ������ ���� ���. ������ ����� ����� ������... ������� ����������� ��������, ����� ����������� ���� ���������, ����� ������ ��� ��� ���������� ������ ���� �����������.
�������� ������ - ������ ������������� ������� ���� ������� ������������ �������. ��� �������, ��� ������� � ���, ��� ���������� �������� � ��������� � ����������. ������ � � ���� ������ �������� �������� ���������� ����� ������ ����� ��������� ��������� ������������ ��������.
query_text - ����� ������ �������
database_name - ��� ���� ������, � ��������� ������, ���������� ������. NULL ��� ��������� ��������
object_name - ��� ������� (��������� ��� �������), ����������� ������.
*/
with s as (
	select  top(100)
			creation_time,
			last_execution_time,
			execution_count,
			total_worker_time/1000 as CPU,
			convert(money, (total_worker_time))/(execution_count*1000)as [AvgCPUTime],
			qs.total_elapsed_time/1000 as TotDuration,
			convert(money, (qs.total_elapsed_time))/(execution_count*1000)as [AvgDur],
			total_logical_reads as [Reads],
			total_logical_writes as [Writes],
			total_logical_reads+total_logical_writes as [AggIO],
			convert(money, (total_logical_reads+total_logical_writes)/(execution_count + 0.0))as [AvgIO],
			[sql_handle],
			plan_handle,
			statement_start_offset,
			statement_end_offset
	from sys.dm_exec_query_stats as qs with(readuncommitted)
	order by convert(money, (qs.total_elapsed_time))/(execution_count*1000) desc-->=100 --���������� ������ �� ����� 100 ��
)
select
	s.creation_time,
	s.last_execution_time,
	s.execution_count,
	s.CPU,
	s.[AvgCPUTime],
	s.TotDuration,
	s.[AvgDur],
	s.[Reads],
	s.[Writes],
	s.[AggIO],
	s.[AvgIO],
	--st.text as query_text,
	case 
		when sql_handle IS NULL then ' '
		else(substring(st.text,(s.statement_start_offset+2)/2,(
			case
				when s.statement_end_offset =-1 then len(convert(nvarchar(MAX),st.text))*2      
				else s.statement_end_offset    
			end - s.statement_start_offset)/2  ))
	end as query_text,
	db_name(st.dbid) as database_name,
	object_schema_name(st.objectid, st.dbid)+'.'+object_name(st.objectid, st.dbid) as [object_name],
	sp.[query_plan],
	s.[sql_handle],
	s.plan_handle
from s
cross apply sys.dm_exec_sql_text(s.[sql_handle]) as st
cross apply sys.dm_exec_query_plan(s.[plan_handle]) as sp



GO
/****** Object:  View [inf].[vBlockingQuery]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vBlockingQuery] as
/*
	http://sqlcom.ru/dba-tools/quickest-way-to-identify-blocking-query/
*/
SELECT
db.name DBName,
tl.request_session_id,
wt.blocking_session_id,
OBJECT_NAME(p.OBJECT_ID) BlockedObjectName,
tl.resource_type,
h1.TEXT AS RequestingText,
h2.TEXT AS BlockingTest,
tl.request_mode
FROM sys.dm_tran_locks AS tl
INNER JOIN sys.databases db ON db.database_id = tl.resource_database_id
INNER JOIN sys.dm_os_waiting_tasks AS wt ON tl.lock_owner_address = wt.resource_address
INNER JOIN sys.partitions AS p ON p.hobt_id = tl.resource_associated_entity_id
INNER JOIN sys.dm_exec_connections ec1 ON ec1.session_id = tl.request_session_id
INNER JOIN sys.dm_exec_connections ec2 ON ec2.session_id = wt.blocking_session_id
CROSS APPLY sys.dm_exec_sql_text(ec1.most_recent_sql_handle) AS h1
CROSS APPLY sys.dm_exec_sql_text(ec2.most_recent_sql_handle) AS h2

GO
/****** Object:  View [inf].[vBlockRequest]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




	CREATE view [inf].[vBlockRequest] as
/*
	���: �������� � ��������������� ��������
	blocking_session_id<>0 - ����� ���������������
*/
SELECT session_id
	  ,status
	  ,blocking_session_id
	  ,database_id
	  ,DB_NAME(database_id) as DBName
	  ,(select top(1) text from sys.dm_exec_sql_text([sql_handle])) as [TSQL]
	  ,[sql_handle]
	   ,[statement_start_offset]
	   ,[statement_end_offset]
	   ,[plan_handle]
	   ,[user_id]
	   ,[connection_id]
	   ,[wait_type]
	   ,[wait_time]
	   ,[last_wait_type]
	   ,[wait_resource]
	   ,[open_transaction_count]
	   ,[open_resultset_count]
	   ,[transaction_id]
	   ,[context_info]
	   ,[percent_complete]
	   ,[estimated_completion_time]
	   ,[cpu_time]
	   ,[total_elapsed_time]
	   ,[scheduler_id]
	   ,[task_address]
	   ,[reads]
	   ,[writes]
	   ,[logical_reads]
	   ,[text_size]
	   ,[language]
	   ,[date_format]
	   ,[date_first]
	   ,[quoted_identifier]
	   ,[arithabort]
	   ,[ansi_null_dflt_on]
	   ,[ansi_defaults]
	   ,[ansi_warnings]
	   ,[ansi_padding]
	   ,[ansi_nulls]
	   ,[concat_null_yields_null]
	   ,[transaction_isolation_level]
	   ,[lock_timeout]
	   ,[deadlock_priority]
	   ,[row_count]
	   ,[prev_error]
	   ,[nest_level]
	   ,[granted_query_memory]
	   ,[executing_managed_code]
	   ,[group_id]
	   ,[query_hash]
	   ,[query_plan_hash]
FROM sys.dm_exec_requests
where blocking_session_id<>0
--WHERE status = N'suspended' --������������� �����;



GO
/****** Object:  View [inf].[vColumns]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vColumns] as
SELECT  @@Servername AS Server ,
        DB_NAME() AS DBName ,
        isc.Table_Name AS TableName ,
        isc.Table_Schema AS SchemaName ,
        Ordinal_Position AS  Ord ,
        Column_Name ,
        Data_Type ,
        Numeric_Precision AS  Prec ,
        Numeric_Scale AS  Scale ,
        Character_Maximum_Length AS LEN , -- -1 means MAX like Varchar(MAX) 
        Is_Nullable ,
        Column_Default ,
        Table_Type
FROM     INFORMATION_SCHEMA.COLUMNS isc
        INNER JOIN  INFORMATION_SCHEMA.TABLES ist
              ON isc.table_name = ist.table_name 
--      WHERE Table_Type = 'BASE TABLE' -- 'Base Table' or 'View' 
--ORDER BY DBName ,
--        TableName ,
--        SchemaName ,
--        Ordinal_position;


GO
/****** Object:  View [inf].[vColumnsStatisticsCount]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vColumnsStatisticsCount] as
-- ����� �������� � ���������� ��������
-- ������������ ��� ������ ���������� �������� � ������� ������ ������/������

SELECT  @@Servername AS Server ,
        DB_NAME() AS DBName ,
        Column_Name ,
        Data_Type ,
        Numeric_Precision AS  Prec ,
        Numeric_Scale AS  Scale ,
        Character_Maximum_Length ,
        COUNT(*) AS Count
FROM     INFORMATION_SCHEMA.COLUMNS isc
        INNER JOIN  INFORMATION_SCHEMA.TABLES ist
               ON isc.table_name = ist.table_name
WHERE   Table_type = 'BASE TABLE'
GROUP BY Column_Name ,
        Data_Type ,
        Numeric_Precision ,
        Numeric_Scale ,
        Character_Maximum_Length; 

GO
/****** Object:  View [inf].[vColumnTableDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [inf].[vColumnTableDescription] as
select 
SCHEMA_NAME(t.schema_id) as SchemaName
,QUOTENAME(object_schema_name(t.[object_id]))+'.'+quotename(t.[name]) as TableName
,c.[name] as ColumnName
,ep.[value] as ColumnDescription
from sys.tables as t
inner join sys.columns as c on c.[object_id]=t.[object_id]
left outer join sys.extended_properties as ep on t.[object_id]=ep.[major_id]
											 and ep.[minor_id]=c.[column_id]
											 and ep.[name]='MS_Description'
where t.[is_ms_shipped]=0;
GO
/****** Object:  View [inf].[vColumnViewDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [inf].[vColumnViewDescription] as
select 
SCHEMA_NAME(t.schema_id) as SchemaName
,QUOTENAME(object_schema_name(t.[object_id]))+'.'+quotename(t.[name]) as TableName
,c.[name] as ColumnName
,ep.[value] as ColumnDescription
from sys.views as t
inner join sys.columns as c on c.[object_id]=t.[object_id]
left outer join sys.extended_properties as ep on t.[object_id]=ep.[major_id]
											 and ep.[minor_id]=c.[column_id]
											 and ep.[name]='MS_Description'
where t.[is_ms_shipped]=0;
GO
/****** Object:  View [inf].[vComputedColumns]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vComputedColumns] as
-- ����������� �������

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        OBJECT_SCHEMA_NAME(t.object_id) AS SchemaName ,
        OBJECT_NAME(t.object_id) AS Tablename ,
        t.Column_id ,
        t.Name AS  Computed_Column ,
        t.[Definition] ,
        t.is_persisted 
FROM    sys.computed_columns as t
--ORDER BY SchemaName ,
--        Tablename ,
--        [Definition];




GO
/****** Object:  View [inf].[vCountRows]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vCountRows] as
-- ����� ��������� ���������� ������� � �������������� DMV dm_db_partition_stats 
SELECT  @@ServerName AS ServerName ,
        DB_NAME() AS DBName ,
        OBJECT_SCHEMA_NAME(ddps.object_id) AS SchemaName ,
        OBJECT_NAME(ddps.object_id) AS TableName ,
        i.Type_Desc ,
        i.Name AS IndexUsedForCounts ,
        SUM(ddps.row_count) AS Rows
FROM    sys.dm_db_partition_stats ddps
        JOIN sys.indexes i ON i.object_id = ddps.object_id
                              AND i.index_id = ddps.index_id
WHERE   i.type_desc IN ( 'CLUSTERED', 'HEAP' )
                              -- This is key (1 index per table) 
        AND OBJECT_SCHEMA_NAME(ddps.object_id) <> 'sys'
GROUP BY ddps.object_id ,
        i.type_desc ,
        i.Name
--ORDER BY SchemaName ,
--        TableName;


GO
/****** Object:  View [inf].[vDBFileInfo]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vDBFileInfo] as
--���������� � ������ ��
SELECT  @@Servername AS Server ,
        DB_NAME() AS DB_Name ,
        File_id ,
        Type_desc ,
        Name ,
        LEFT(Physical_Name, 1) AS Drive ,
        Physical_Name ,
        RIGHT(physical_name, 3) AS Ext ,
        Size ,
        Growth
FROM    sys.database_files
--ORDER BY File_id; 


GO
/****** Object:  View [inf].[vDefaultsConstraints]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vDefaultsConstraints] as
-- Column Defaults 

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DB_Name ,
        OBJECT_SCHEMA_NAME(t.object_id) AS SchemaName ,
        t.Name AS TableName ,
        c.Column_ID AS Column_NBR ,
        c.Name AS Column_Name ,
        OBJECT_NAME(default_object_id) AS DefaultName ,
        OBJECT_DEFINITION(default_object_id) AS Defaults,
        dc.[type] ,
        dc.type_desc ,
        dc.create_date
FROM    sys.tables t
        INNER JOIN sys.columns c ON t.object_id = c.object_id
		inner join sys.default_constraints as dc on dc.object_id=c.default_object_id
WHERE    default_object_id <> 0
--ORDER BY TableName ,
--        SchemaName ,
--        c.Column_ID 


GO
/****** Object:  View [inf].[vDelIndexOptimize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vDelIndexOptimize] as
/*
	���: ������������ �� �������, ������� �� �������������� � �������� ����� ������ ����
		 ��� ��������������, ��� � ��������.
		 �� master, model, msdb � tempdb �� ���������������
*/
select DB_NAME(t.database_id)		as [DBName]
	 , SCHEMA_NAME(obj.schema_id)	as [SchemaName]
	 , OBJECT_NAME(t.object_id)		as [ObjectName]
	 , obj.Type						as [ObjectType]
	 , obj.Type_Desc				as [ObjectTypeDesc]
	 , ind.name						as [IndexName]
	 , ind.Type						as IndexType
	 , ind.Type_Desc				as IndexTypeDesc
	 , ind.Is_Unique				as IndexIsUnique
	 , ind.is_primary_key			as IndexIsPK
	 , ind.is_unique_constraint		as IndexIsUniqueConstraint
	 , (t.[USER_SEEKS]+t.[USER_SCANS]+t.[USER_LOOKUPS]+t.[SYSTEM_SEEKS]+t.[SYSTEM_SCANS]+t.[SYSTEM_LOOKUPS])-(t.[USER_UPDATES]+t.[System_Updates]) as [index_advantage]
	 , t.[Database_ID]
	 , t.[Object_ID]
	 , t.[Index_ID]
	 , t.USER_SEEKS
     , t.USER_SCANS 
     , t.USER_LOOKUPS 
     , t.USER_UPDATES
	 , t.SYSTEM_SEEKS
     , t.SYSTEM_SCANS 
     , t.SYSTEM_LOOKUPS 
     , t.SYSTEM_UPDATES
	 , t.Last_User_Seek
	 , t.Last_User_Scan
	 , t.Last_User_Lookup
	 , t.Last_System_Seek
	 , t.Last_System_Scan
	 , t.Last_System_Lookup
	 , ind.Filter_Definition,
		STUFF(
				(
					SELECT N', [' + [name] +N'] '+case ic.[is_descending_key] when 0 then N'ASC' when 1 then N'DESC' end FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=ind.[index_id]
					  and ic.[is_included_column]=0
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [Columns],
		STUFF(
				(
					SELECT N', [' + [name] +N']' FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=ind.[index_id]
					  and ic.[is_included_column]=1
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [IncludeColumns]
from sys.dm_db_index_usage_stats as t
inner join sys.objects as obj on t.[object_id]=obj.[object_id]
inner join sys.indexes as ind on t.[object_id]=ind.[object_id] and t.index_id=ind.index_id
where ((last_user_seek	is null or last_user_seek		<dateadd(year,-1,getdate()))
and (last_user_scan		is null or last_user_scan		<dateadd(year,-1,getdate()))
and (last_user_lookup	is null or last_user_lookup		<dateadd(year,-1,getdate()))
and (last_system_seek	is null or last_system_seek		<dateadd(year,-1,getdate()))
and (last_system_scan	is null or last_system_scan		<dateadd(year,-1,getdate()))
and (last_system_lookup is null or last_system_lookup	<dateadd(year,-1,getdate()))
or (((t.[USER_UPDATES]+t.[System_Updates])>0) and (t.[SYSTEM_SEEKS]<=(t.[USER_UPDATES]+t.[System_Updates]-(t.[USER_SEEKS]+t.[USER_SCANS]+t.[USER_LOOKUPS]+t.[SYSTEM_SCANS]+t.[SYSTEM_LOOKUPS])))))
and t.database_id>4 and t.[object_id]>0
and ind.is_primary_key=0 --�� �������� ������������ ���������� �����
and ind.is_unique_constraint=0 --�� �������� ������������ ������������
and t.database_id=DB_ID()
GO
/****** Object:  View [inf].[vFK_Keys]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vFK_Keys] as
-- Foreign Keys 

SELECT  f.name AS ForeignKey ,
        SCHEMA_NAME(f.SCHEMA_ID) AS SchemaName ,
        OBJECT_NAME(f.parent_object_id) AS TableName ,
        COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName ,
        SCHEMA_NAME(o.SCHEMA_ID) ReferenceSchemaName ,
        OBJECT_NAME(f.referenced_object_id) AS ReferenceTableName ,
        COL_NAME(fc.referenced_object_id, fc.referenced_column_id)
                                              AS ReferenceColumnName,
		f.create_date
FROM    sys.foreign_keys AS f
        INNER JOIN sys.foreign_key_columns AS fc
               ON f.OBJECT_ID = fc.constraint_object_id
        INNER JOIN sys.objects AS o ON o.OBJECT_ID = fc.referenced_object_id
--ORDER BY TableName ,
--        ReferenceTableName;


GO
/****** Object:  View [inf].[vFK_KeysIndexes]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vFK_KeysIndexes] as
-- ������ ������� ������
-- Foreign Keys missing indexes 
-- ���� ������ �������� ������ ��� �������� �������� �� ������ �������
-- ������� �����, ��������� ����� ��� �� ������ �������, �� �������������

SELECT  DB_NAME() AS DBName ,
        rc.CONSTRAINT_NAME AS FK_Constraint , 
		rc.CONSTRAINT_CATALOG AS FK_Database, 
		rc.CONSTRAINT_SCHEMA AS FKSchema, 
		ccu.TABLE_SCHEMA as SchemaFK_Table,
        ccu.TABLE_NAME AS FK_Table ,
        ccu.COLUMN_NAME AS FK_Column ,
		ccu2.TABLE_SCHEMA as SchemaParentTable,
        ccu2.TABLE_NAME AS ParentTable ,
        ccu2.COLUMN_NAME AS ParentColumn ,
        i.name AS IndexName ,
        CASE WHEN i.name IS NULL
             THEN 'IF NOT EXISTS (SELECT * FROM sys.indexes
                                    WHERE object_id = OBJECT_ID(N'''
                  + rc.CONSTRAINT_SCHEMA + '.' + ccu.TABLE_NAME
                  + ''') AND name = N''IX_' + ccu.TABLE_NAME + '_'
                  + ccu.COLUMN_NAME + ''') '
                  + 'CREATE NONCLUSTERED INDEX IX_' + ccu.TABLE_NAME + '_'
                  + ccu.COLUMN_NAME + ' ON ' + rc.CONSTRAINT_SCHEMA + '.'
                  + ccu.TABLE_NAME + '( ' + ccu.COLUMN_NAME
                  + ' ASC ) WITH (PAD_INDEX = OFF, 
                                   STATISTICS_NORECOMPUTE = OFF,
                                   SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF,
                                   DROP_EXISTING = OFF, ONLINE = ON);'
             ELSE ''
        END AS SQL
FROM     INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
        JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
         ON rc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
        JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu2
         ON rc.UNIQUE_CONSTRAINT_NAME = ccu2.CONSTRAINT_NAME
        LEFT JOIN sys.columns c ON ccu.COLUMN_NAME = c.name
                                AND ccu.TABLE_NAME = OBJECT_NAME(c.object_id)
        LEFT JOIN sys.index_columns ic ON c.object_id = ic.object_id
                                          AND c.column_id = ic.column_id
                                          AND index_column_id  = 1

                                           -- index found has the foreign key
                                          --  as the first column 

        LEFT JOIN sys.indexes i ON ic.object_id = i.object_id
                                   AND ic.index_id = i.index_id
--WHERE   I.name IS NULL
--ORDER BY FK_table ,
--        ParentTable ,
--        ParentColumn; 



GO
/****** Object:  View [inf].[vFuncs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vFuncs] as
-- �������������� ���������� � ��������

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DB_Name ,
        o.name AS 'FunctionName' ,
        o.[type] ,
        o.create_date ,
        sm.[DEFINITION] AS 'Function script'
FROM    sys.objects o
        INNER JOIN sys.sql_modules sm ON o.object_id = sm.OBJECT_ID
WHERE   o.[Type] in ('FN', 'AF', 'FS', 'FT', 'IF', 'TF') -- Function 
--ORDER BY o.NAME;



GO
/****** Object:  View [inf].[vFunctionStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vFunctionStat] as 
select DB_Name(coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [DB_Name]
	  ,OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Schema_Name]
	  ,object_name(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Object_Name]
	  ,coalesce(QS.[database_id], ST.[dbid], PT.[dbid]) as [database_id]
	  ,SCHEMA_ID(OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid]))) as [schema_id]
      ,coalesce(QS.[object_id], ST.[objectid], PT.[objectid]) as [object_id]
      ,QS.[type]
      ,QS.[type_desc]
      ,QS.[sql_handle]
      ,QS.[plan_handle]
      ,QS.[cached_time]
      ,QS.[last_execution_time]
      ,QS.[execution_count]
      ,QS.[total_worker_time]
      ,QS.[last_worker_time]
      ,QS.[min_worker_time]
      ,QS.[max_worker_time]
      ,QS.[total_physical_reads]
      ,QS.[last_physical_reads]
      ,QS.[min_physical_reads]
      ,QS.[max_physical_reads]
      ,QS.[total_logical_writes]
      ,QS.[last_logical_writes]
      ,QS.[min_logical_writes]
      ,QS.[max_logical_writes]
      ,QS.[total_logical_reads]
      ,QS.[last_logical_reads]
      ,QS.[min_logical_reads]
      ,QS.[max_logical_reads]
      ,QS.[total_elapsed_time]
      ,QS.[last_elapsed_time]
      ,QS.[min_elapsed_time]
      ,QS.[max_elapsed_time]
	  ,ST.[encrypted]
	  ,ST.[text] as [TSQL]
	  ,PT.[query_plan]
FROM sys.dm_exec_function_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.[sql_handle]) as ST
	 CROSS APPLY sys.dm_exec_query_plan(QS.[plan_handle]) as PT
GO
/****** Object:  View [inf].[vHeaps]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vHeaps] as
-- ���� + ���������� �������

SELECT  @@ServerName AS Server ,
        DB_NAME() AS DBName ,
        OBJECT_SCHEMA_NAME(ddps.object_id) AS SchemaName ,
        OBJECT_NAME(ddps.object_id) AS TableName ,
        i.Type_Desc ,
        SUM(ddps.row_count) AS Rows
FROM    sys.dm_db_partition_stats AS ddps
        JOIN sys.indexes i ON i.object_id = ddps.object_id
                              AND i.index_id = ddps.index_id
WHERE   i.type_desc = 'HEAP'
        AND OBJECT_SCHEMA_NAME(ddps.object_id) <> 'sys'
GROUP BY ddps.object_id ,
        i.type_desc
--ORDER BY TableName;
GO
/****** Object:  View [inf].[vIdentityColumns]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vIdentityColumns] as
--������� identity
SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        OBJECT_SCHEMA_NAME(object_id) AS SchemaName ,
        OBJECT_NAME(object_id) AS TableName ,
        Column_id ,
        Name AS  IdentityColumn ,
        Seed_Value ,
        Last_Value
FROM    sys.identity_columns
--ORDER BY SchemaName ,
--        TableName ,
--        Column_id; 


GO
/****** Object:  View [inf].[vIndexDefrag]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vIndexDefrag]
as
with info as 
(SELECT
	ps.[object_id],
	ps.database_id,
	ps.index_id,
	ps.index_type_desc,
	ps.index_level,
	ps.fragment_count,
	ps.avg_fragmentation_in_percent,
	ps.avg_fragment_size_in_pages,
	ps.page_count,
	ps.record_count,
	ps.ghost_record_count
	FROM sys.dm_db_index_physical_stats
    (DB_ID()
	, NULL, NULL, NULL ,
	N'LIMITED') as ps
	inner join sys.indexes as i on i.[object_id]=ps.[object_id] and i.[index_id]=ps.[index_id]
	where ps.index_level = 0
	and ps.avg_fragmentation_in_percent >= 10
	and ps.index_type_desc <> 'HEAP'
	and ps.page_count>=8 --1 �������
	and i.is_disabled=0
	)
SELECT
	DB_NAME(i.database_id) as db,
	SCHEMA_NAME(t.[schema_id]) as shema,
	t.name as tb,
	i.index_id as idx,
	i.database_id,
	(select top(1) idx.[name] from [sys].[indexes] as idx where t.[object_id] = idx.[object_id] and idx.[index_id] = i.[index_id]) as index_name,
	i.index_type_desc,i.index_level as [level],
	i.[object_id],
	i.fragment_count as frag_num,
	round(i.avg_fragmentation_in_percent,2) as frag,
	round(i.avg_fragment_size_in_pages,2) as frag_page,
	i.page_count as [page],
	i.record_count as rec,
	i.ghost_record_count as ghost,
	round(i.avg_fragmentation_in_percent*i.page_count,0) as func
FROM info as i
inner join [sys].[all_objects]	as t	on i.[object_id] = t.[object_id];
GO
/****** Object:  View [inf].[vIndexesUser]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vIndexesUser] as
-- ���������������� �������
SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DB_Name ,
        obj.Name AS TableName ,
        i.Name AS IndexName ,
		i.Filter_Definition,
		STUFF(
				(
					SELECT N', [' + [name] +N'] '+case ic.[is_descending_key] when 0 then N'ASC' when 1 then N'DESC' end FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=i.[index_id]
					  and ic.[is_included_column]=0
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [Columns],
		STUFF(
				(
					SELECT N', [' + [name] +N']' FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=i.[index_id]
					  and ic.[is_included_column]=1
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [IncludeColumns]
FROM    sys.objects obj
        INNER JOIN sys.indexes i ON obj.[object_id] = i.[object_id]
WHERE   obj.[Type] = 'U' -- User table 
        AND LEFT(i.Name, 1) <> '_' -- Remove hypothetical indexes 
--ORDER BY o.NAME ,
--        i.name; 
GO
/****** Object:  View [inf].[vIndexUsageStats]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vIndexUsageStats] as
SELECT   SCHEMA_NAME(obj.schema_id) as [SCHEMA_NAME],
		 OBJECT_NAME(s.object_id) AS [OBJECT NAME], 
		 i.name AS [INDEX NAME], 
		 ([USER_SEEKS]+[USER_SCANS]+[USER_LOOKUPS])-([USER_UPDATES]+[System_Updates]) as [index_advantage],
         s.USER_SEEKS, 
         s.USER_SCANS, 
         s.USER_LOOKUPS, 
         s.USER_UPDATES,
		 s.Last_User_Seek,
		 s.Last_User_Scan,
		 s.Last_User_Lookup,
		 s.Last_User_Update,
		 s.System_Seeks,
		 s.System_Scans,
		 s.System_Lookups,
		 s.System_Updates,
		 s.Last_System_Seek,
		 s.Last_System_Scan,
		 s.Last_System_Lookup,
		 s.Last_System_Update,
		 obj.schema_id,
		 i.object_id,
		 i.index_id,
		 obj.[type] as [ObjectType],
		 obj.[type_desc] as TYPE_DESC_OBJECT,
		 i.[type] as [IndexType],
		 i.[type_desc] as TYPE_DESC_INDEX,
		 i.Is_Unique,
		 i.Data_Space_ID,
		 i.[Ignore_Dup_Key],
		 i.Is_Primary_Key,
		 i.Is_Unique_Constraint,
		 i.Fill_Factor,
		 i.Is_Padded,
		 i.Is_Disabled,
		 i.Is_Hypothetical,
		 i.[Allow_Row_Locks],
		 i.[Allow_Page_Locks],
		 i.Has_Filter,
		 i.Filter_Definition,
		 STUFF(
				(
					SELECT N', [' + [name] +N'] '+case ic.[is_descending_key] when 0 then N'ASC' when 1 then N'DESC' end FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=i.[index_id]
					  and ic.[is_included_column]=0
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [Columns],
		STUFF(
				(
					SELECT N', [' + [name] +N']' FROM sys.index_columns ic
								   INNER JOIN sys.columns c on c.[object_id] = obj.[object_id] and ic.[column_id] = c.[column_id]
					WHERE ic.[object_id] = obj.[object_id]
					  and ic.[index_id]=i.[index_id]
					  and ic.[is_included_column]=1
					order by ic.[key_ordinal] asc
					FOR XML PATH(''),TYPE
				).value('.','NVARCHAR(MAX)'),1,2,''
			  ) as [IncludeColumns]
FROM     sys.dm_db_index_usage_stats AS s 
         INNER JOIN sys.indexes AS i 
           ON i.object_id = s.object_id 
              AND i.index_id = s.index_id
		 inner join sys.objects as obj on obj.object_id=i.object_id
--WHERE    OBJECTPROPERTY(S.[OBJECT_ID],'IsUserTable') = 1 
GO
/****** Object:  View [inf].[vInnerTableSize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [inf].[vInnerTableSize] as
--������� ���������� ������
select object_name(p.[object_id]) as [Name]
	 , SUM(a.[total_pages]) as TotalPages
	 , SUM(p.[rows]) as CountRows
	 , cast(SUM(a.[total_pages]) * 8192/1024. as decimal(18, 2)) as TotalSizeKB
from sys.partitions as p
inner join sys.allocation_units as a on p.[partition_id]=a.[container_id]
left outer join sys.internal_tables as it on p.[object_id]=it.[object_id]
where OBJECTPROPERTY(p.[object_id], N'IsUserTable')=0
group by object_name(p.[object_id])
--order by p.[rows] desc;
GO
/****** Object:  View [inf].[vJobActivity]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobActivity] as
SELECT [session_id]
      ,[job_id]
      ,[run_requested_date]
      ,[run_requested_source]
      ,[queued_date]
      ,[start_execution_date]
      ,[last_executed_step_id]
      ,[last_executed_step_date]
      ,[stop_execution_date]
      ,[job_history_id]
      ,[next_scheduled_run_date]
  FROM [msdb].[dbo].[sysjobactivity];

GO
/****** Object:  View [inf].[vJobHistory]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobHistory] as
SELECT [instance_id]
      ,[job_id]
      ,[step_id]
      ,[step_name]
      ,[sql_message_id]
      ,[sql_severity]
      ,[message]
      ,[run_status]
      ,[run_date]
      ,[run_time]
      ,[run_duration]
      ,[operator_id_emailed]
      ,[operator_id_netsent]
      ,[operator_id_paged]
      ,[retries_attempted]
      ,[server]
  FROM [msdb].[dbo].[sysjobhistory];

GO
/****** Object:  View [inf].[vJobSteps]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobSteps] as
SELECT [job_id]
      ,[step_id]
      ,[step_name]
      ,[subsystem]
      ,[command]
      ,[flags]
      ,[additional_parameters]
      ,[cmdexec_success_code]
      ,[on_success_action]
      ,[on_success_step_id]
      ,[on_fail_action]
      ,[on_fail_step_id]
      ,[server]
      ,[database_name]
      ,[database_user_name]
      ,[retry_attempts]
      ,[retry_interval]
      ,[os_run_priority]
      ,[output_file_name]
      ,[last_run_outcome]
      ,[last_run_duration]
      ,[last_run_retries]
      ,[last_run_date]
      ,[last_run_time]
      ,[proxy_id]
      ,[step_uid]
  FROM [msdb].[dbo].[sysjobsteps];

GO
/****** Object:  View [inf].[vJobStepsLogs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [inf].[vJobStepsLogs] as
SELECT [log_id]
      ,[log]
      ,[date_created]
      ,[date_modified]
      ,[log_size]
      ,[step_uid]
  FROM [msdb].[dbo].[sysjobstepslogs];

GO
/****** Object:  View [inf].[vLocks]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [inf].[vLocks] as
/*
	���: �������� � �����������
*/
SELECT 
        t1.resource_type,
        t1.resource_database_id,
        t1.resource_associated_entity_id,
        t1.request_mode,
        t1.request_session_id,
        t2.blocking_session_id
    FROM sys.dm_tran_locks as t1
    INNER JOIN sys.dm_os_waiting_tasks as t2
        ON t1.lock_owner_address = t2.resource_address;

GO
/****** Object:  View [inf].[vNewIndexOptimize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vNewIndexOptimize] as
/*
	���: ������� ���������� ����� ��������
	index_advantage: >50 000 - ����� ������� ������� ������
					 >10 000 - ����� ������� ������, ������ ����� ������������� � ��� ���������
					 <=10000 - ������ ����� �� ���������
*/
SELECT @@ServerName AS ServerName,
       DB_Name(ddmid.[database_id]) as [DBName],
	   OBJECT_SCHEMA_NAME(ddmid.[object_id], ddmid.[database_id]) as [Schema],
	   OBJECT_NAME(ddmid.[object_id], ddmid.[database_id]) as [Name],
	   ddmigs.user_seeks * ddmigs.avg_total_user_cost * (ddmigs.avg_user_impact * 0.01) AS index_advantage,
	   ddmigs.group_handle,
	   ddmigs.unique_compiles,
	   ddmigs.last_user_seek,
	   ddmigs.last_user_scan,
	   ddmigs.avg_total_user_cost,
	   ddmigs.avg_user_impact,
	   ddmigs.system_seeks,
	   ddmigs.last_system_scan,
	   ddmigs.last_system_seek,
	   ddmigs.avg_total_system_cost,
	   ddmigs.avg_system_impact,
	   ddmig.index_group_handle,
	   ddmig.index_handle,
	   ddmid.database_id,
	   ddmid.[object_id],
	   ddmid.equality_columns,	  -- =
	   ddmid.inequality_columns,
	   ddmid.[statement],
       ( LEN(ISNULL(ddmid.equality_columns, N'')
             + CASE WHEN ddmid.equality_columns IS NOT NULL
                         AND ddmid.inequality_columns IS NOT NULL THEN ','
                    ELSE ''
               END) - LEN(REPLACE(ISNULL(ddmid.equality_columns, N'')
                                  + CASE WHEN ddmid.equality_columns
                                                            IS NOT NULL
                                              AND ddmid.inequality_columns
                                                            IS NOT NULL
                                         THEN ','
                                         ELSE ''
                                    END, ',', '')) ) + 1 AS K ,
       COALESCE(ddmid.equality_columns, '')
       + CASE WHEN ddmid.equality_columns IS NOT NULL
                   AND ddmid.inequality_columns IS NOT NULL THEN ','
              ELSE ''
         END + COALESCE(ddmid.inequality_columns, '') AS Keys ,
       ddmid.included_columns AS [include] ,
       'Create NonClustered Index [IX_' + OBJECT_NAME(ddmid.[object_id], ddmid.[database_id]) + '_missing_'
       + CAST(ddmid.index_handle AS VARCHAR(20)) 
       + '] On ' + ddmid.[statement] COLLATE database_default
       + ' (' + ISNULL(ddmid.equality_columns, '')
       + CASE WHEN ddmid.equality_columns IS NOT NULL
                   AND ddmid.inequality_columns IS NOT NULL THEN ','
              ELSE ''
         END + ISNULL(ddmid.inequality_columns, '') + ')'
       + ISNULL(' Include (' + ddmid.included_columns + ');', ';')
                                                 AS sql_statement ,
       ddmigs.user_seeks ,
       ddmigs.user_scans ,
       CAST(( ddmigs.user_seeks + ddmigs.user_scans )
       * ddmigs.avg_user_impact AS BIGINT) AS 'est_impact' ,
       ( SELECT    DATEDIFF(Second, create_date, GETDATE()) Seconds
         FROM      sys.databases
         WHERE     name = 'tempdb'
       ) SecondsUptime 
FROM
sys.dm_db_missing_index_group_stats ddmigs
INNER JOIN sys.dm_db_missing_index_groups AS ddmig
ON ddmigs.group_handle = ddmig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details AS ddmid
ON ddmig.index_handle = ddmid.index_handle
--WHERE   mid.database_id = DB_ID()
--ORDER BY migs_adv.index_advantage


GO
/****** Object:  View [inf].[vObjectDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vObjectDescription] as
select
SCHEMA_NAME(obj.[schema_id]) as SchemaName
,QUOTENAME(object_schema_name(obj.[object_id]))+'.'+quotename(obj.[name]) as ObjectName
,obj.[type] as [Type]
,obj.[type_desc] as [TypeDesc]
,ep.[value] as ObjectDescription
from sys.objects as obj
left outer join sys.extended_properties as ep on obj.[object_id]=ep.[major_id]
											 and ep.[minor_id]=0
											 and ep.[name]='MS_Description'
where obj.[is_ms_shipped]=0
and obj.[parent_object_id]=0
GO
/****** Object:  View [inf].[vObjectInParentDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vObjectInParentDescription] as
select
SCHEMA_NAME(obj.[schema_id]) as SchemaName
,QUOTENAME(object_schema_name(obj.[parent_object_id]))+'.'+quotename(object_name(obj.[parent_object_id])) as ParentObjectName
,QUOTENAME(object_schema_name(obj.[object_id]))+'.'+quotename(obj.[name]) as ObjectName
,obj.[type] as [Type]
,obj.[type_desc] as [TypeDesc]
,ep.[value] as ObjectDescription
from sys.all_objects as obj
left outer join sys.extended_properties as ep on obj.[parent_object_id]=ep.[major_id]
											 and ep.[minor_id]=obj.[object_id]
											 and ep.[name]='MS_Description'
where obj.[is_ms_shipped]=0
and obj.[parent_object_id]<>0
GO
/****** Object:  View [inf].[vParameterDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vParameterDescription] as
select
SCHEMA_NAME(obj.[schema_id]) as SchemaName
,QUOTENAME(object_schema_name(obj.[object_id]))+'.'+quotename(object_name(obj.[object_id])) as ParentObjectName
,p.[name] as ParameterName
,obj.[type] as [Type]
,obj.[type_desc] as [TypeDesc]
,ep.[value] as ParameterDescription
from sys.parameters as p
inner join sys.objects as obj on p.[object_id]=obj.[object_id]
left outer join sys.extended_properties as ep on obj.[object_id]=ep.[major_id]
											 and ep.[minor_id]=p.[parameter_id]
											 and ep.[name]='MS_Description'
where obj.[is_ms_shipped]=0
GO
/****** Object:  View [inf].[vPerformanceObject]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [inf].[vPerformanceObject]
as
SELECT
object_name		as [Object],
counter_name	as [Counter],
instance_name	as [Instance],
cntr_value		as [Value_KB],
cntr_type		as [Type]
from master.dbo.sysperfinfo
--order by object_name, counter_name;



GO
/****** Object:  View [inf].[vProcedures]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [inf].[vProcedures] as
-- �������������� ���������� � �� 

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DB_Name ,
		s.name as SchemaName,
        o.name AS 'ViewName' ,
        o.[type] ,
        o.Create_date ,
        sm.[definition] AS 'Stored Procedure script'
FROM    sys.objects o
		inner join sys.schemas s on o.schema_id=s.schema_id
        INNER JOIN sys.sql_modules sm ON o.object_id = sm.object_id
WHERE   o.[type] in ('P', 'PC') -- Stored Procedures 
        -- AND sm.[definition] LIKE '%insert%'
        -- AND sm.[definition] LIKE '%update%'
        -- AND sm.[definition] LIKE '%delete%'
        -- AND sm.[definition] LIKE '%tablename%'
--ORDER BY o.name;


GO
/****** Object:  View [inf].[vProcedureStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vProcedureStat] as 
select DB_Name(coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [DB_Name]
	  ,OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Schema_Name]
	  ,object_name(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Object_Name]
	  ,coalesce(QS.[database_id], ST.[dbid], PT.[dbid]) as [database_id]
	  ,SCHEMA_ID(OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid]))) as [schema_id]
      ,coalesce(QS.[object_id], ST.[objectid], PT.[objectid]) as [object_id]
      ,QS.[type]
      ,QS.[type_desc]
      ,QS.[sql_handle]
      ,QS.[plan_handle]
      ,QS.[cached_time]
      ,QS.[last_execution_time]
      ,QS.[execution_count]
      ,QS.[total_worker_time]
      ,QS.[last_worker_time]
      ,QS.[min_worker_time]
      ,QS.[max_worker_time]
      ,QS.[total_physical_reads]
      ,QS.[last_physical_reads]
      ,QS.[min_physical_reads]
      ,QS.[max_physical_reads]
      ,QS.[total_logical_writes]
      ,QS.[last_logical_writes]
      ,QS.[min_logical_writes]
      ,QS.[max_logical_writes]
      ,QS.[total_logical_reads]
      ,QS.[last_logical_reads]
      ,QS.[min_logical_reads]
      ,QS.[max_logical_reads]
      ,QS.[total_elapsed_time]
      ,QS.[last_elapsed_time]
      ,QS.[min_elapsed_time]
      ,QS.[max_elapsed_time]
	  ,ST.[encrypted]
	  ,ST.[text] as [TSQL]
	  ,PT.[query_plan]
FROM sys.dm_exec_procedure_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.[sql_handle]) as ST
	 CROSS APPLY sys.dm_exec_query_plan(QS.[plan_handle]) as PT
GO
/****** Object:  View [inf].[vProcesses]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vProcesses] as
select
db_name(dbid) as DB_Name,
login_time,
last_batch,
(select top(1) [text] from sys.dm_exec_sql_text(sql_handle)) as SQLText,
status,
blocked,
physical_io,
open_tran,
hostname,
program_name,
hostprocess,
cmd,
nt_domain,
nt_username,
net_address,
net_library,
loginame,
spid,
kpid,
waittype,
waittime,
lastwaittype,
waitresource,
dbid,
uid,
cpu,
memusage,
ecid,
sid,
context_info,
stmt_start,
stmt_end,
request_id
from sysprocesses



GO
/****** Object:  View [inf].[vQueryResourse]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [inf].[vQueryResourse] as
SELECT creation_time
	 , last_execution_time
	 ,round(cast((total_worker_time/execution_count) as float)/1000000,4) AS [Avg CPU Time SEC]
	 ,execution_count
    ,SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
        ((CASE qs.statement_end_offset
          WHEN -1 THEN DATALENGTH(st.text)
         ELSE qs.statement_end_offset
         END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st


GO
/****** Object:  View [inf].[vQueryStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vQueryStat] as 
select DB_Name(coalesce(ST.[dbid], PT.[dbid])) as [DB_Name]
	   ,OBJECT_SCHEMA_NAME(coalesce(ST.[objectid], PT.[objectid]), coalesce(ST.[dbid], PT.[dbid])) as [Schema_Name]
	   ,object_name(coalesce(ST.[objectid], PT.[objectid]), coalesce(ST.[dbid], PT.[dbid])) as [Trigger_Name]
	  ,QS.[sql_handle]
      ,QS.[statement_start_offset]
      ,QS.[statement_end_offset]
      ,QS.[plan_generation_num]
      ,QS.[plan_handle]
      ,QS.[creation_time]
      ,QS.[last_execution_time]
      ,QS.[execution_count]
      ,QS.[total_worker_time]
      ,QS.[last_worker_time]
      ,QS.[min_worker_time]
      ,QS.[max_worker_time]
      ,QS.[total_physical_reads]
      ,QS.[last_physical_reads]
      ,QS.[min_physical_reads]
      ,QS.[max_physical_reads]
      ,QS.[total_logical_writes]
      ,QS.[last_logical_writes]
      ,QS.[min_logical_writes]
      ,QS.[max_logical_writes]
      ,QS.[total_logical_reads]
      ,QS.[last_logical_reads]
      ,QS.[min_logical_reads]
      ,QS.[max_logical_reads]
      ,QS.[total_clr_time]
      ,QS.[last_clr_time]
      ,QS.[min_clr_time]
      ,QS.[max_clr_time]
      ,QS.[total_elapsed_time]
      ,QS.[last_elapsed_time]
      ,QS.[min_elapsed_time]
      ,QS.[max_elapsed_time]
      ,QS.[query_hash]
      ,QS.[query_plan_hash]
      ,QS.[total_rows]
      ,QS.[last_rows]
      ,QS.[min_rows]
      ,QS.[max_rows]
      ,QS.[statement_sql_handle]
      ,QS.[statement_context_id]
      ,QS.[total_dop]
      ,QS.[last_dop]
      ,QS.[min_dop]
      ,QS.[max_dop]
      ,QS.[total_grant_kb]
      ,QS.[last_grant_kb]
      ,QS.[min_grant_kb]
      ,QS.[max_grant_kb]
      ,QS.[total_used_grant_kb]
      ,QS.[last_used_grant_kb]
      ,QS.[min_used_grant_kb]
      ,QS.[max_used_grant_kb]
      ,QS.[total_ideal_grant_kb]
      ,QS.[last_ideal_grant_kb]
      ,QS.[min_ideal_grant_kb]
      ,QS.[max_ideal_grant_kb]
      ,QS.[total_reserved_threads]
      ,QS.[last_reserved_threads]
      ,QS.[min_reserved_threads]
      ,QS.[max_reserved_threads]
      ,QS.[total_used_threads]
      ,QS.[last_used_threads]
      ,QS.[min_used_threads]
      ,QS.[max_used_threads]
      ,NULL as [total_columnstore_segment_reads]
      ,NULL as [last_columnstore_segment_reads]
      ,NULL as [min_columnstore_segment_reads]
      ,NULL as [max_columnstore_segment_reads]
      ,NULL as [total_columnstore_segment_skips]
      ,NULL as [last_columnstore_segment_skips]
      ,NULL as [min_columnstore_segment_skips]
      ,NULL as [max_columnstore_segment_skips]
	  ,coalesce(ST.[dbid], PT.[dbid]) as [dbid]
	  ,SCHEMA_ID(OBJECT_SCHEMA_NAME(coalesce(ST.[objectid], PT.[objectid]), coalesce(ST.[dbid], PT.[dbid]))) as [schema_id]
	  ,coalesce(ST.[objectid], PT.[objectid]) as [objectid]
	  ,ST.[encrypted]
	  ,ST.[text] as [TSQL]
	  ,PT.[query_plan]
FROM sys.dm_exec_query_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST
	 CROSS APPLY sys.dm_exec_query_plan(QS.[plan_handle]) as PT
GO
/****** Object:  View [inf].[vReadWriteTables]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vReadWriteTables] as
-- ������/������ �������
-- ���� �� ���������������, � ��� ��� ��������
-- ������ �� �������, � ������� ���������� ����� ������� SQL Server

SELECT  @@ServerName AS ServerName ,
        DB_NAME() AS DBName ,
		s.name AS SchemaTableName ,
        OBJECT_NAME(ddius.object_id) AS TableName ,
        SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups)
                                                               AS  Reads ,
        SUM(ddius.user_updates) AS Writes ,
        SUM(ddius.user_seeks + ddius.user_scans + ddius.user_lookups
            + ddius.user_updates) AS [Reads&Writes] ,
        ( SELECT    DATEDIFF(s, create_date, GETDATE()) / 86400.0
          FROM      master.sys.databases
          WHERE     name = 'tempdb'
        ) AS SampleDays ,
        ( SELECT    DATEDIFF(s, create_date, GETDATE()) AS SecoundsRunnig
          FROM      master.sys.databases
          WHERE     name = 'tempdb'
        ) AS SampleSeconds
FROM    sys.dm_db_index_usage_stats ddius
		inner join sys.tables as t on t.object_id=ddius.object_id
		inner join sys.schemas as s on t.schema_id=s.schema_id
		INNER JOIN sys.indexes i ON ddius.object_id = i.object_id
                                     AND i.index_id = ddius.index_id
WHERE    OBJECTPROPERTY(ddius.object_id, 'IsUserTable') = 1
        AND ddius.database_id = DB_ID()
GROUP BY s.name, OBJECT_NAME(ddius.object_id)
--ORDER BY [Reads&Writes] DESC;


GO
/****** Object:  View [inf].[vRecomendateIndex]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vRecomendateIndex] as

-- ������������� ������� �� DMV

SELECT  @@ServerName AS ServerName ,
        DB_Name(ddmid.[database_id]) as [DBName] ,
        t.name AS 'Affected_table' ,
		ddmigs.user_seeks * ddmigs.avg_total_user_cost * (ddmigs.avg_user_impact * 0.01) AS index_advantage,
		ddmigs.group_handle,
		ddmigs.unique_compiles,
		ddmigs.last_user_seek,
		ddmigs.last_user_scan,
		ddmigs.avg_total_user_cost,
		ddmigs.avg_user_impact,
		ddmigs.system_seeks,
		ddmigs.last_system_scan,
		ddmigs.last_system_seek,
		ddmigs.avg_total_system_cost,
		ddmigs.avg_system_impact,
		ddmig.index_group_handle,
		ddmig.index_handle,
		ddmid.database_id,
		ddmid.[object_id],
		ddmid.equality_columns,	  -- =
		ddmid.inequality_columns,
		ddmid.[statement],
        ( LEN(ISNULL(ddmid.equality_columns, N'')
              + CASE WHEN ddmid.equality_columns IS NOT NULL
                          AND ddmid.inequality_columns IS NOT NULL THEN ','
                     ELSE ''
                END) - LEN(REPLACE(ISNULL(ddmid.equality_columns, N'')
                                   + CASE WHEN ddmid.equality_columns
                                                             IS NOT NULL
                                               AND ddmid.inequality_columns
                                                             IS NOT NULL
                                          THEN ','
                                          ELSE ''
                                     END, ',', '')) ) + 1 AS K ,
        COALESCE(ddmid.equality_columns, '')
        + CASE WHEN ddmid.equality_columns IS NOT NULL
                    AND ddmid.inequality_columns IS NOT NULL THEN ','
               ELSE ''
          END + COALESCE(ddmid.inequality_columns, '') AS Keys ,
        ddmid.included_columns AS [include] ,
        'Create NonClustered Index IX_' + t.name + '_missing_'
        + CAST(ddmid.index_handle AS VARCHAR(20)) 
        + ' On ' + ddmid.[statement] COLLATE database_default
        + ' (' + ISNULL(ddmid.equality_columns, '')
        + CASE WHEN ddmid.equality_columns IS NOT NULL
                    AND ddmid.inequality_columns IS NOT NULL THEN ','
               ELSE ''
          END + ISNULL(ddmid.inequality_columns, '') + ')'
        + ISNULL(' Include (' + ddmid.included_columns + ');', ';')
                                                  AS sql_statement ,
        ddmigs.user_seeks ,
        ddmigs.user_scans ,
        CAST(( ddmigs.user_seeks + ddmigs.user_scans )
        * ddmigs.avg_user_impact AS BIGINT) AS 'est_impact' ,
        ( SELECT    DATEDIFF(Second, create_date, GETDATE()) Seconds
          FROM      sys.databases
          WHERE     name = 'tempdb'
        ) SecondsUptime 
FROM    sys.dm_db_missing_index_groups ddmig
        INNER JOIN sys.dm_db_missing_index_group_stats ddmigs
               ON ddmigs.group_handle = ddmig.index_group_handle
        INNER JOIN sys.dm_db_missing_index_details ddmid
               ON ddmig.index_handle = ddmid.index_handle
        INNER JOIN sys.tables t ON ddmid.OBJECT_ID = t.OBJECT_ID
WHERE   ddmid.database_id = DB_ID()
--ORDER BY est_impact DESC;


GO
/****** Object:  View [inf].[vRequestDetail]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [inf].[vRequestDetail] as
/*��������, ������� � ���������� � ��������� �������, � ����� ��, ��� ���� ��������� ������ ������*/
with tbl0 as (
	select ES.[session_id]
	      ,ER.[blocking_session_id]
		  ,ER.[request_id]
	      ,ER.[start_time]
	      ,ER.[status]
		  ,ES.[status] as [status_session]
	      ,ER.[command]
		  ,ER.[percent_complete]
		  ,DB_Name(coalesce(ER.[database_id], ES.[database_id])) as [DBName]
	      ,(select top(1) [text] from sys.dm_exec_sql_text(ER.[sql_handle])) as [TSQL]
		  ,(select top(1) [objectid] from sys.dm_exec_sql_text(ER.[sql_handle])) as [objectid]
		  ,(select top(1) [query_plan] from sys.dm_exec_query_plan(ER.[plan_handle])) as [QueryPlan]
		  ,(select top(1) [event_info] from sys.dm_exec_input_buffer(ES.[session_id], ER.[request_id])) as [event_info]
	      ,ER.[wait_type]
	      ,ES.[login_time]
		  ,ES.[host_name]
		  ,ES.[program_name]
	      ,ER.[wait_time]
	      ,ER.[last_wait_type]
	      ,ER.[wait_resource]
	      ,ER.[open_transaction_count]
	      ,ER.[open_resultset_count]
	      ,ER.[transaction_id]
	      ,ER.[context_info]
	      ,ER.[estimated_completion_time]
	      ,ER.[cpu_time]
	      ,ER.[total_elapsed_time]
	      ,ER.[scheduler_id]
	      ,ER.[task_address]
	      ,ER.[reads]
	      ,ER.[writes]
	      ,ER.[logical_reads]
	      ,ER.[text_size]
	      ,ER.[language]
	      ,ER.[date_format]
	      ,ER.[date_first]
	      ,ER.[quoted_identifier]
	      ,ER.[arithabort]
	      ,ER.[ansi_null_dflt_on]
	      ,ER.[ansi_defaults]
	      ,ER.[ansi_warnings]
	      ,ER.[ansi_padding]
	      ,ER.[ansi_nulls]
	      ,ER.[concat_null_yields_null]
	      ,ER.[transaction_isolation_level]
	      ,ER.[lock_timeout]
	      ,ER.[deadlock_priority]
	      ,ER.[row_count]
	      ,ER.[prev_error]
	      ,ER.[nest_level]
	      ,ER.[granted_query_memory]
	      ,ER.[executing_managed_code]
	      ,ER.[group_id]
	      ,ER.[query_hash]
	      ,ER.[query_plan_hash]
		  ,EC.[most_recent_session_id]
	      ,EC.[connect_time]
	      ,EC.[net_transport]
	      ,EC.[protocol_type]
	      ,EC.[protocol_version]
	      ,EC.[endpoint_id]
	      ,EC.[encrypt_option]
	      ,EC.[auth_scheme]
	      ,EC.[node_affinity]
	      ,EC.[num_reads]
	      ,EC.[num_writes]
	      ,EC.[last_read]
	      ,EC.[last_write]
	      ,EC.[net_packet_size]
	      ,EC.[client_net_address]
	      ,EC.[client_tcp_port]
	      ,EC.[local_net_address]
	      ,EC.[local_tcp_port]
	      ,EC.[parent_connection_id]
	      ,EC.[most_recent_sql_handle]
		  ,ES.[host_process_id]
		  ,ES.[client_version]
		  ,ES.[client_interface_name]
		  ,ES.[security_id]
		  ,ES.[login_name]
		  ,ES.[nt_domain]
		  ,ES.[nt_user_name]
		  ,ES.[memory_usage]
		  ,ES.[total_scheduled_time]
		  ,ES.[last_request_start_time]
		  ,ES.[last_request_end_time]
		  ,ES.[is_user_process]
		  ,ES.[original_security_id]
		  ,ES.[original_login_name]
		  ,ES.[last_successful_logon]
		  ,ES.[last_unsuccessful_logon]
		  ,ES.[unsuccessful_logons]
		  ,ES.[authenticating_database_id]
		  ,ER.[sql_handle]
	      ,ER.[statement_start_offset]
	      ,ER.[statement_end_offset]
	      ,ER.[plan_handle]
		  ,ER.[dop]
	      ,coalesce(ER.[database_id], ES.[database_id]) as [database_id]
	      ,ER.[user_id]
	      ,ER.[connection_id]
	from sys.dm_exec_requests ER with(readuncommitted)
	right join sys.dm_exec_sessions ES with(readuncommitted)
	on ES.session_id = ER.session_id 
	left join sys.dm_exec_connections EC  with(readuncommitted)
	on EC.session_id = ES.session_id
)
, tbl as (
	select [session_id]
	      ,[blocking_session_id]
		  ,[request_id]
	      ,[start_time]
	      ,[status]
		  ,[status_session]
	      ,[command]
		  ,[percent_complete]
		  ,[DBName]
		  ,OBJECT_name([objectid], [database_id]) as [object]
	      ,[TSQL]
		  ,[QueryPlan]
		  ,[event_info]
	      ,[wait_type]
	      ,[login_time]
		  ,[host_name]
		  ,[program_name]
	      ,[wait_time]
	      ,[last_wait_type]
	      ,[wait_resource]
	      ,[open_transaction_count]
	      ,[open_resultset_count]
	      ,[transaction_id]
	      ,[context_info]
	      ,[estimated_completion_time]
	      ,[cpu_time]
	      ,[total_elapsed_time]
	      ,[scheduler_id]
	      ,[task_address]
	      ,[reads]
	      ,[writes]
	      ,[logical_reads]
	      ,[text_size]
	      ,[language]
	      ,[date_format]
	      ,[date_first]
	      ,[quoted_identifier]
	      ,[arithabort]
	      ,[ansi_null_dflt_on]
	      ,[ansi_defaults]
	      ,[ansi_warnings]
	      ,[ansi_padding]
	      ,[ansi_nulls]
	      ,[concat_null_yields_null]
	      ,[transaction_isolation_level]
	      ,[lock_timeout]
	      ,[deadlock_priority]
	      ,[row_count]
	      ,[prev_error]
	      ,[nest_level]
	      ,[granted_query_memory]
	      ,[executing_managed_code]
	      ,[group_id]
	      ,[query_hash]
	      ,[query_plan_hash]
		  ,[most_recent_session_id]
	      ,[connect_time]
	      ,[net_transport]
	      ,[protocol_type]
	      ,[protocol_version]
	      ,[endpoint_id]
	      ,[encrypt_option]
	      ,[auth_scheme]
	      ,[node_affinity]
	      ,[num_reads]
	      ,[num_writes]
	      ,[last_read]
	      ,[last_write]
	      ,[net_packet_size]
	      ,[client_net_address]
	      ,[client_tcp_port]
	      ,[local_net_address]
	      ,[local_tcp_port]
	      ,[parent_connection_id]
	      ,[most_recent_sql_handle]
		  ,[host_process_id]
		  ,[client_version]
		  ,[client_interface_name]
		  ,[security_id]
		  ,[login_name]
		  ,[nt_domain]
		  ,[nt_user_name]
		  ,[memory_usage]
		  ,[total_scheduled_time]
		  ,[last_request_start_time]
		  ,[last_request_end_time]
		  ,[is_user_process]
		  ,[original_security_id]
		  ,[original_login_name]
		  ,[last_successful_logon]
		  ,[last_unsuccessful_logon]
		  ,[unsuccessful_logons]
		  ,[authenticating_database_id]
		  ,[sql_handle]
	      ,[statement_start_offset]
	      ,[statement_end_offset]
	      ,[plan_handle]
		  ,[dop]
	      ,[database_id]
	      ,[user_id]
	      ,[connection_id]
	from tbl0
	where [status] in ('suspended', 'running', 'runnable')
)
, tbl_group as (
	select [blocking_session_id]
	from tbl
	where [blocking_session_id]<>0
	group by [blocking_session_id]
)
, tbl_res_rec as (
	select [session_id]
	      ,[blocking_session_id]
		  ,[request_id]
	      ,[start_time]
	      ,[status]
		  ,[status_session]
	      ,[command]
		  ,[percent_complete]
		  ,[DBName]
		  ,[object]
	      ,[TSQL]
		  ,[QueryPlan]
		  ,[event_info]
	      ,[wait_type]
	      ,[login_time]
		  ,[host_name]
		  ,[program_name]
	      ,[wait_time]
	      ,[last_wait_type]
	      ,[wait_resource]
	      ,[open_transaction_count]
	      ,[open_resultset_count]
	      ,[transaction_id]
	      ,[context_info]
	      ,[estimated_completion_time]
	      ,[cpu_time]
	      ,[total_elapsed_time]
	      ,[scheduler_id]
	      ,[task_address]
	      ,[reads]
	      ,[writes]
	      ,[logical_reads]
	      ,[text_size]
	      ,[language]
	      ,[date_format]
	      ,[date_first]
	      ,[quoted_identifier]
	      ,[arithabort]
	      ,[ansi_null_dflt_on]
	      ,[ansi_defaults]
	      ,[ansi_warnings]
	      ,[ansi_padding]
	      ,[ansi_nulls]
	      ,[concat_null_yields_null]
	      ,[transaction_isolation_level]
	      ,[lock_timeout]
	      ,[deadlock_priority]
	      ,[row_count]
	      ,[prev_error]
	      ,[nest_level]
	      ,[granted_query_memory]
	      ,[executing_managed_code]
	      ,[group_id]
	      ,[query_hash]
	      ,[query_plan_hash]
		  ,[most_recent_session_id]
	      ,[connect_time]
	      ,[net_transport]
	      ,[protocol_type]
	      ,[protocol_version]
	      ,[endpoint_id]
	      ,[encrypt_option]
	      ,[auth_scheme]
	      ,[node_affinity]
	      ,[num_reads]
	      ,[num_writes]
	      ,[last_read]
	      ,[last_write]
	      ,[net_packet_size]
	      ,[client_net_address]
	      ,[client_tcp_port]
	      ,[local_net_address]
	      ,[local_tcp_port]
	      ,[parent_connection_id]
	      ,[most_recent_sql_handle]
		  ,[host_process_id]
		  ,[client_version]
		  ,[client_interface_name]
		  ,[security_id]
		  ,[login_name]
		  ,[nt_domain]
		  ,[nt_user_name]
		  ,[memory_usage]
		  ,[total_scheduled_time]
		  ,[last_request_start_time]
		  ,[last_request_end_time]
		  ,[is_user_process]
		  ,[original_security_id]
		  ,[original_login_name]
		  ,[last_successful_logon]
		  ,[last_unsuccessful_logon]
		  ,[unsuccessful_logons]
		  ,[authenticating_database_id]
		  ,[sql_handle]
	      ,[statement_start_offset]
	      ,[statement_end_offset]
	      ,[plan_handle]
		  ,[dop]
	      ,[database_id]
	      ,[user_id]
	      ,[connection_id]
		  , 0 as [is_blocking_other_session]
from tbl
union all
select tbl0.[session_id]
	      ,tbl0.[blocking_session_id]
		  ,tbl0.[request_id]
	      ,tbl0.[start_time]
	      ,tbl0.[status]
		  ,tbl0.[status_session]
	      ,tbl0.[command]
		  ,tbl0.[percent_complete]
		  ,tbl0.[DBName]
		  ,OBJECT_name(tbl0.[objectid], tbl0.[database_id]) as [object]
	      ,tbl0.[TSQL]
		  ,tbl0.[QueryPlan]
		  ,tbl0.[event_info]
	      ,tbl0.[wait_type]
	      ,tbl0.[login_time]
		  ,tbl0.[host_name]
		  ,tbl0.[program_name]
	      ,tbl0.[wait_time]
	      ,tbl0.[last_wait_type]
	      ,tbl0.[wait_resource]
	      ,tbl0.[open_transaction_count]
	      ,tbl0.[open_resultset_count]
	      ,tbl0.[transaction_id]
	      ,tbl0.[context_info]
	      ,tbl0.[estimated_completion_time]
	      ,tbl0.[cpu_time]
	      ,tbl0.[total_elapsed_time]
	      ,tbl0.[scheduler_id]
	      ,tbl0.[task_address]
	      ,tbl0.[reads]
	      ,tbl0.[writes]
	      ,tbl0.[logical_reads]
	      ,tbl0.[text_size]
	      ,tbl0.[language]
	      ,tbl0.[date_format]
	      ,tbl0.[date_first]
	      ,tbl0.[quoted_identifier]
	      ,tbl0.[arithabort]
	      ,tbl0.[ansi_null_dflt_on]
	      ,tbl0.[ansi_defaults]
	      ,tbl0.[ansi_warnings]
	      ,tbl0.[ansi_padding]
	      ,tbl0.[ansi_nulls]
	      ,tbl0.[concat_null_yields_null]
	      ,tbl0.[transaction_isolation_level]
	      ,tbl0.[lock_timeout]
	      ,tbl0.[deadlock_priority]
	      ,tbl0.[row_count]
	      ,tbl0.[prev_error]
	      ,tbl0.[nest_level]
	      ,tbl0.[granted_query_memory]
	      ,tbl0.[executing_managed_code]
	      ,tbl0.[group_id]
	      ,tbl0.[query_hash]
	      ,tbl0.[query_plan_hash]
		  ,tbl0.[most_recent_session_id]
	      ,tbl0.[connect_time]
	      ,tbl0.[net_transport]
	      ,tbl0.[protocol_type]
	      ,tbl0.[protocol_version]
	      ,tbl0.[endpoint_id]
	      ,tbl0.[encrypt_option]
	      ,tbl0.[auth_scheme]
	      ,tbl0.[node_affinity]
	      ,tbl0.[num_reads]
	      ,tbl0.[num_writes]
	      ,tbl0.[last_read]
	      ,tbl0.[last_write]
	      ,tbl0.[net_packet_size]
	      ,tbl0.[client_net_address]
	      ,tbl0.[client_tcp_port]
	      ,tbl0.[local_net_address]
	      ,tbl0.[local_tcp_port]
	      ,tbl0.[parent_connection_id]
	      ,tbl0.[most_recent_sql_handle]
		  ,tbl0.[host_process_id]
		  ,tbl0.[client_version]
		  ,tbl0.[client_interface_name]
		  ,tbl0.[security_id]
		  ,tbl0.[login_name]
		  ,tbl0.[nt_domain]
		  ,tbl0.[nt_user_name]
		  ,tbl0.[memory_usage]
		  ,tbl0.[total_scheduled_time]
		  ,tbl0.[last_request_start_time]
		  ,tbl0.[last_request_end_time]
		  ,tbl0.[is_user_process]
		  ,tbl0.[original_security_id]
		  ,tbl0.[original_login_name]
		  ,tbl0.[last_successful_logon]
		  ,tbl0.[last_unsuccessful_logon]
		  ,tbl0.[unsuccessful_logons]
		  ,tbl0.[authenticating_database_id]
		  ,tbl0.[sql_handle]
	      ,tbl0.[statement_start_offset]
	      ,tbl0.[statement_end_offset]
	      ,tbl0.[plan_handle]
		  ,tbl0.[dop]
	      ,tbl0.[database_id]
	      ,tbl0.[user_id]
	      ,tbl0.[connection_id]
		  , 1 as [is_blocking_other_session]
	from tbl_group as tg
	inner join tbl0 on tg.blocking_session_id=tbl0.session_id
)
,tbl_res_rec_g as (
	select [plan_handle],
		   [sql_handle],
		   cast([start_time] as date) as [start_time]
	from tbl_res_rec
	group by [plan_handle],
			 [sql_handle],
			 cast([start_time] as date)
)
,tbl_rec_stat_g as (
	select qs.[plan_handle]
		  ,qs.[sql_handle]
		  --,cast(qs.[last_execution_time] as date)	as [last_execution_time]
		  ,min(qs.[creation_time])					as [creation_time]
		  ,max(qs.[execution_count])				as [execution_count]
		  ,max(qs.[total_worker_time])				as [total_worker_time]
		  ,min(qs.[last_worker_time])				as [min_last_worker_time]
		  ,max(qs.[last_worker_time])				as [max_last_worker_time]
		  ,min(qs.[min_worker_time])				as [min_worker_time]
		  ,max(qs.[max_worker_time])				as [max_worker_time]
		  ,max(qs.[total_physical_reads])			as [total_physical_reads]
		  ,min(qs.[last_physical_reads])			as [min_last_physical_reads]
		  ,max(qs.[last_physical_reads])			as [max_last_physical_reads]
		  ,min(qs.[min_physical_reads])				as [min_physical_reads]
		  ,max(qs.[max_physical_reads])				as [max_physical_reads]
		  ,max(qs.[total_logical_writes])			as [total_logical_writes]
		  ,min(qs.[last_logical_writes])			as [min_last_logical_writes]
		  ,max(qs.[last_logical_writes])			as [max_last_logical_writes]
		  ,min(qs.[min_logical_writes])				as [min_logical_writes]
		  ,max(qs.[max_logical_writes])				as [max_logical_writes]
		  ,max(qs.[total_logical_reads])			as [total_logical_reads]
		  ,min(qs.[last_logical_reads])				as [min_last_logical_reads]
		  ,max(qs.[last_logical_reads])				as [max_last_logical_reads]
		  ,min(qs.[min_logical_reads])				as [min_logical_reads]
		  ,max(qs.[max_logical_reads])				as [max_logical_reads]
		  ,max(qs.[total_clr_time])					as [total_clr_time]
		  ,min(qs.[last_clr_time])					as [min_last_clr_time]
		  ,max(qs.[last_clr_time])					as [max_last_clr_time]
		  ,min(qs.[min_clr_time])					as [min_clr_time]
		  ,max(qs.[max_clr_time])					as [max_clr_time]
		  ,max(qs.[total_elapsed_time])				as [total_elapsed_time]
		  ,min(qs.[last_elapsed_time])				as [min_last_elapsed_time]
		  ,max(qs.[last_elapsed_time])				as [max_last_elapsed_time]
		  ,min(qs.[min_elapsed_time])				as [min_elapsed_time]
		  ,max(qs.[max_elapsed_time])				as [max_elapsed_time]
		  ,max(qs.[total_rows])						as [total_rows]
		  ,min(qs.[last_rows])						as [min_last_rows]
		  ,max(qs.[last_rows])						as [max_last_rows]
		  ,min(qs.[min_rows])						as [min_rows]
		  ,max(qs.[max_rows])						as [max_rows]
		  ,max(qs.[total_dop])						as [total_dop]
		  ,min(qs.[last_dop])						as [min_last_dop]
		  ,max(qs.[last_dop])						as [max_last_dop]
		  ,min(qs.[min_dop])						as [min_dop]
		  ,max(qs.[max_dop])						as [max_dop]
		  ,max(qs.[total_grant_kb])					as [total_grant_kb]
		  ,min(qs.[last_grant_kb])					as [min_last_grant_kb]
		  ,max(qs.[last_grant_kb])					as [max_last_grant_kb]
		  ,min(qs.[min_grant_kb])					as [min_grant_kb]
		  ,max(qs.[max_grant_kb])					as [max_grant_kb]
		  ,max(qs.[total_used_grant_kb])			as [total_used_grant_kb]
		  ,min(qs.[last_used_grant_kb])				as [min_last_used_grant_kb]
		  ,max(qs.[last_used_grant_kb])				as [max_last_used_grant_kb]
		  ,min(qs.[min_used_grant_kb])				as [min_used_grant_kb]
		  ,max(qs.[max_used_grant_kb])				as [max_used_grant_kb]
		  ,max(qs.[total_ideal_grant_kb])			as [total_ideal_grant_kb]
		  ,min(qs.[last_ideal_grant_kb])			as [min_last_ideal_grant_kb]
		  ,max(qs.[last_ideal_grant_kb])			as [max_last_ideal_grant_kb]
		  ,min(qs.[min_ideal_grant_kb])				as [min_ideal_grant_kb]
		  ,max(qs.[max_ideal_grant_kb])				as [max_ideal_grant_kb]
		  ,max(qs.[total_reserved_threads])			as [total_reserved_threads]
		  ,min(qs.[last_reserved_threads])			as [min_last_reserved_threads]
		  ,max(qs.[last_reserved_threads])			as [max_last_reserved_threads]
		  ,min(qs.[min_reserved_threads])			as [min_reserved_threads]
		  ,max(qs.[max_reserved_threads])			as [max_reserved_threads]
		  ,max(qs.[total_used_threads])				as [total_used_threads]
		  ,min(qs.[last_used_threads])				as [min_last_used_threads]
		  ,max(qs.[last_used_threads])				as [max_last_used_threads]
		  ,min(qs.[min_used_threads])				as [min_used_threads]
		  ,max(qs.[max_used_threads])				as [max_used_threads]
	from tbl_res_rec_g as t
	inner join sys.dm_exec_query_stats as qs with(readuncommitted) on t.[plan_handle]=qs.[plan_handle] 
																  and t.[sql_handle]=qs.[sql_handle] 
																  and t.[start_time]=cast(qs.[last_execution_time] as date)
	group by qs.[plan_handle]
			,qs.[sql_handle]
			--,qs.[last_execution_time]
)
select t.[session_id] --������
	      ,t.[blocking_session_id] --������, ������� ���� ��������� ������ [session_id]
		  ,t.[request_id] --������������� �������. �������� � ��������� ������
	      ,t.[start_time] --����� ������� ����������� �������
		  ,DateDiff(second, t.[start_time], GetDate()) as [date_diffSec] --������� � ��� ������ ������� �� ������� ����������� �������
	      ,t.[status] --��������� �������
		  ,t.[status_session] --��������� ������
	      ,t.[command] --��� ����������� � ������ ������ �������
		  , COALESCE(
						CAST(NULLIF(t.[total_elapsed_time] / 1000, 0) as BIGINT)
					   ,CASE WHEN (t.[status_session] <> 'running' and isnull(t.[status], '')  <> 'running') 
								THEN  DATEDIFF(ss,0,getdate() - nullif(t.[last_request_end_time], '1900-01-01T00:00:00.000'))
						END
					) as [total_time, sec] --����� ���� ������ ������� � ���
		  , CAST(NULLIF((CAST(t.[total_elapsed_time] as BIGINT) - CAST(t.[wait_time] AS BIGINT)) / 1000, 0 ) as bigint) as [work_time, sec] --����� ������ ������� � ��� ��� ����� ������� ��������
		  , CASE WHEN (t.[status_session] <> 'running' AND ISNULL(t.[status],'') <> 'running') 
		  			THEN  DATEDIFF(ss,0,getdate() - nullif(t.[last_request_end_time], '1900-01-01T00:00:00.000'))
			END as [sleep_time, sec] --����� ��� � ���
		  , NULLIF( CAST((t.[logical_reads] + t.[writes]) * 8 / 1024 as numeric(38,2)), 0) as [IO, MB] --�������� ������ � ������ � ��
		  , CASE  t.transaction_isolation_level
			WHEN 0 THEN 'Unspecified'
			WHEN 1 THEN 'ReadUncommited'
			WHEN 2 THEN 'ReadCommited'
			WHEN 3 THEN 'Repetable'
			WHEN 4 THEN 'Serializable'
			WHEN 5 THEN 'Snapshot'
			END as [transaction_isolation_level_desc] --������� �������� ���������� (�����������)
		  ,t.[percent_complete] --������� ���������� ������ ��� ��������� ������
		  ,t.[DBName] --��
		  ,t.[object] --������
		  , SUBSTRING(
						t.[TSQL]
					  , t.[statement_start_offset]/2+1
					  ,	(
							CASE WHEN ((t.[statement_start_offset]<0) OR (t.[statement_end_offset]<0))
									THEN DATALENGTH (t.[TSQL])
								 ELSE t.[statement_end_offset]
							END
							- t.[statement_start_offset]
						)/2 +1
					 ) as [CURRENT_REQUEST] --������� ����������� ������ � ������
	      ,t.[TSQL] --������ ����� ������
		  ,t.[QueryPlan] --���� ����� ������
		  ,t.[event_info] --����� ���������� �� �������� ������ ��� ������ ��������������� spid
	      ,t.[wait_type] --���� ������ � ��������� ������ ����������, � ������� ���������� ��� �������� (sys.dm_os_wait_stats)
	      ,t.[login_time] --����� ����������� ������
		  ,t.[host_name] --��� ���������� ������� �������, ��������� � ������. ��� ����������� ������ ��� �������� ����� NULL
		  ,t.[program_name] --��� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
		  ,cast(t.[wait_time]/1000 as decimal(18,3)) as [wait_timeSec] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� ��������)
	      ,t.[wait_time] --���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������)
	      ,t.[last_wait_type] --���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������
	      ,t.[wait_resource] --���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������
	      ,t.[open_transaction_count] --����� ����������, �������� ��� ������� �������
	      ,t.[open_resultset_count] --����� �������������� �������, �������� ��� ������� �������
	      ,t.[transaction_id] --������������� ����������, � ������� ����������� ������
	      ,t.[context_info] --�������� CONTEXT_INFO ������
		  ,cast(t.[estimated_completion_time]/1000 as decimal(18,3)) as [estimated_completion_timeSec] --������ ��� ����������� �������������. �� ��������� �������� NULL
	      ,t.[estimated_completion_time] --������ ��� ����������� �������������. �� ��������� �������� NULL
		  ,cast(t.[cpu_time]/1000 as decimal(18,3)) as [cpu_timeSec] --����� �� (� ��������), ����������� �� ���������� �������
	      ,t.[cpu_time] --����� �� (� �������������), ����������� �� ���������� �������
		  ,cast(t.[total_elapsed_time]/1000 as decimal(18,3)) as [total_elapsed_timeSec] --����� �����, �������� � ������� ����������� ������� (� ��������)
	      ,t.[total_elapsed_time] --����� �����, �������� � ������� ����������� ������� (� �������������)
	      ,t.[scheduler_id] --������������� ������������, ������� ��������� ������ ������
	      ,t.[task_address] --����� ����� ������, ����������� ��� ������, ��������� � ���� ��������
	      ,t.[reads] --����� �������� ������, ����������� ������ ��������
	      ,t.[writes] --����� �������� ������, ����������� ������ ��������
	      ,t.[logical_reads] --����� ���������� �������� ������, ����������� ������ ��������
	      ,t.[text_size] --��������� ��������� TEXTSIZE ��� ������� �������
	      ,t.[language] --��������� ����� ��� ������� �������
	      ,t.[date_format] --��������� ��������� DATEFORMAT ��� ������� �������
	      ,t.[date_first] --��������� ��������� DATEFIRST ��� ������� �������
	      ,t.[quoted_identifier] --1 = �������� QUOTED_IDENTIFIER ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[arithabort] --1 = �������� ARITHABORT ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[ansi_null_dflt_on] --1 = �������� ANSI_NULL_DFLT_ON ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[ansi_defaults] --1 = �������� ANSI_DEFAULTS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[ansi_warnings] --1 = �������� ANSI_WARNINGS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[ansi_padding] --1 = �������� ANSI_PADDING ��� ������� ������� (ON)
	      ,t.[ansi_nulls] --1 = �������� ANSI_NULLS ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[concat_null_yields_null] --1 = �������� CONCAT_NULL_YIELDS_NULL ��� ������� ������� (ON). � ��������� ������ � 0
	      ,t.[transaction_isolation_level] --������� ��������, � ������� ������� ���������� ��� ������� �������
		  ,cast(t.[lock_timeout]/1000 as decimal(18,3)) as [lock_timeoutSec] --����� �������� ���������� ��� ������� ������� (� ��������)
		  ,t.[lock_timeout] --����� �������� ���������� ��� ������� ������� (� �������������)
	      ,t.[deadlock_priority] --�������� ��������� DEADLOCK_PRIORITY ��� ������� �������
	      ,t.[row_count] --����� �����, ������������ ������� �� ������� �������
	      ,t.[prev_error] --��������� ������, ����������� ��� ���������� �������
	      ,t.[nest_level] --������� ������� ����������� ����, ������������ ��� ������� �������
	      ,t.[granted_query_memory] --����� �������, ���������� ��� ���������� ������������ ������� (1 ��������-��� �������� 8 ��)
	      ,t.[executing_managed_code] --���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������).
									  --���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL
	      
		  ,t.[group_id]	--������������� ������ ������� ��������, ������� ����������� ���� ������
	      ,t.[query_hash] --�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������.
						  --����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������
	      
		  ,t.[query_plan_hash] --�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������.
							   --����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������
		  
		  ,t.[most_recent_session_id] --������������ ����� ������������� ������ ������ ���������� �������, ���������� � ������ �����������
	      ,t.[connect_time] --������� ������� ������������ ����������
	      ,t.[net_transport] --�������� �������� ����������� ������������� ���������, ������������� ������ �����������
	      ,t.[protocol_type] --��������� ��� ��������� �������� �������� ������
	      ,t.[protocol_version] --������ ��������� ������� � ������, ���������� � ������ �����������
	      ,t.[endpoint_id] --�������������, ����������� ��� ����������. ���� ������������� endpoint_id ����� �������������� ��� �������� � ������������� sys.endpoints
	      ,t.[encrypt_option] --���������� ��������, �����������, ��������� �� ���������� ��� ������� ����������
	      ,t.[auth_scheme] --��������� ����� �������� ����������� (SQL Server ��� Windows), ������������ � ������ �����������
	      ,t.[node_affinity] --�������������� ���� ������, �������� ������������� ������ ����������
	      ,t.[num_reads] --����� �������, �������� ����������� ������� ����������
	      ,t.[num_writes] --����� �������, ���������� ����������� ������� ����������
	      ,t.[last_read] --������� ������� � ��������� ���������� ������ ������
	      ,t.[last_write] --������� ������� � ��������� ������������ ������ ������
	      ,t.[net_packet_size] --������ �������� ������, ������������ ��� �������� ������
	      ,t.[client_net_address] --������� ����� ���������� �������
	      ,t.[client_tcp_port] --����� ����� �� ���������� ����������, ������� ������������ ��� ������������� ����������
	      ,t.[local_net_address] --IP-����� �������, � ������� ����������� ������ ����������. �������� ������ ��� ����������, ������� � �������� ���������� ������ ���������� �������� TCP
	      ,t.[local_tcp_port] --TCP-���� �������, ���� ���������� ���������� �������� TCP
	      ,t.[parent_connection_id] --�������������� ��������� ����������, ������������ � ������ MARS
	      ,t.[most_recent_sql_handle] --���������� ���������� ������� SQL, ������������ � ������� ������� ����������. ��������� ���������� ������������� ����� �������� most_recent_sql_handle � �������� most_recent_session_id
		  ,t.[host_process_id] --������������� �������� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL
		  ,t.[client_version] --������ TDS-��������� ����������, ������� ������������ �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL
		  ,t.[client_interface_name] --��� ���������� ��� �������, ������������ �������� ��� ������ ������� � ��������. ��� ����������� ������ ��� �������� ����� NULL
		  ,t.[security_id] --������������� ������������ Microsoft Windows, ��������� � ������ �����
		  ,t.[login_name] --SQL Server ��� �����, ��� ������� ����������� ������� �����.
						  --����� ������ �������������� ��� �����, � ������� �������� ��� ������ �����, ��. �������� original_login_name.
						  --����� ���� SQL Server �������� ����������� ����� ����� ��� ����� ������������ ������, ���������� �������� ����������� Windows
		  
		  ,t.[nt_domain] --����� Windows ��� �������, ���� �� ����� ������ ����������� �������� ����������� Windows ��� ������������� ����������.
						 --��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,t.[nt_user_name] --��� ������������ Windows ��� �������, ���� �� ����� ������ ������������ �������� ����������� Windows ��� ������������� ����������.
							--��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL
		  
		  ,t.[memory_usage] --���������� 8-������������ ������� ������, ������������ ������ �������
		  ,t.[total_scheduled_time] --����� �����, ����������� ������� ������ (������� ��� ��������� �������) ��� ����������, � �������������
		  ,t.[last_request_start_time] --�����, ����� ������� ��������� ������ ������� ������. ��� ����� ���� ������, ������������� � ������ ������
		  ,t.[last_request_end_time] --����� ���������� ���������� ������� � ������ ������� ������
		  ,t.[is_user_process] --0, ���� ����� �������� ���������. � ��������� ������ �������� ����� 1
		  ,t.[original_security_id] --Microsoft ������������� ������������ Windows, ��������� � ���������� original_login_name
		  ,t.[original_login_name] --SQL Server ��� �����, ������� ���������� ������ ������ ������ �����.
								   --��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ��� ������������ ������ Windows, 
								   --��������� �������� �����������, ��� ������������ ���������� ���� ������.
								   --�������� ��������, ��� ����� ��������������� ���������� ��� ������ ����� ���� ��������� ����� ������� ��� ����� ������������ ���������.
								   --�������� ���� EXECUTE AS ������������
		  
		  ,t.[last_successful_logon] --����� ���������� ��������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,t.[last_unsuccessful_logon] --����� ���������� ����������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������
		  ,t.[unsuccessful_logons] --����� ���������� ������� ����� � ������� ��� ����� original_login_name ����� �������� last_successful_logon � �������� login_time
		  ,t.[authenticating_database_id] --������������� ���� ������, ����������� �������� ����������� ���������.
										  --��� ���� ����� ��� �������� ����� ����� 0.
										  --��� ������������� ���������� ���� ������ ��� �������� ����� ��������� ������������� ���������� ���� ������
		  
		  ,t.[sql_handle] --���-����� ������ SQL-�������
	      ,t.[statement_start_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������.
									  --����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									  --��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,t.[statement_end_offset] --���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������.
									--����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text
									--��� ���������� ����������� � ��������� ������ ���������� �� �������
	      
		  ,t.[plan_handle] --���-����� ����� ���������� SQL
	      ,t.[database_id] --������������� ���� ������, � ������� ����������� ������
	      ,t.[user_id] --������������� ������������, ������������ ������ ������
	      ,t.[connection_id] --������������� ����������, �� �������� �������� ������
		  ,t.[is_blocking_other_session] --1-������ ���� ��������� ������ ������, 0-������ ���� �� ��������� ������ ������
		  ,coalesce(t.[dop], mg.[dop]) as [dop] --������� ������������ �������
		  ,mg.[request_time] --���� � ����� ��������� ������� �� ��������������� ������
		  ,mg.[grant_time] --���� � �����, ����� ������� ���� ������������� ������. ���������� �������� NULL, ���� ������ ��� �� ���� �������������
		  ,mg.[requested_memory_kb] --����� ����� ����������� ������ � ����������
		  ,mg.[granted_memory_kb] --����� ����� ���������� ��������������� ������ � ����������.
								  --����� ���� �������� NULL, ���� ������ ��� �� ���� �������������.
								  --������ ��� �������� ������ ���� ���������� � requested_memory_kb.
								  --��� �������� ������� ������ ����� ��������� �������������� �������������� �� ���������� ������,
								  --����� ������� ������� �� ����� ���������� ��������������� ������
		  
		  ,mg.[required_memory_kb] --����������� ����� ������ � ���������� (��), ����������� ��� ���������� ������� �������.
								   --�������� requested_memory_kb ����� ����� ������ ��� ������ ���
		  
		  ,mg.[used_memory_kb] --������������ � ������ ������ ����� ���������� ������ (� ����������)
		  ,mg.[max_used_memory_kb] --������������ ����� ������������ �� ������� ������� ���������� ������ � ����������
		  ,mg.[query_cost] --��������� ��������� �������
		  ,mg.[timeout_sec] --����� �������� ������� ������� � �������� �� ������ �� ��������� �� ��������������� ������
		  ,mg.[resource_semaphore_id] --������������ ������������� �������� �������, �������� ������� ������ ������
		  ,mg.[queue_id] --������������� ��������� �������, � ������� ������ ������ ������� �������������� ������.
						 --�������� NULL, ���� ������ ��� �������������
		  
		  ,mg.[wait_order] --���������������� ������� ��������� �������� � ��������� ������� queue_id.
						   --��� �������� ����� ���������� ��� ��������� �������, ���� ������ ������� ������������ �� �������������� ������ ��� �������� ��.
						   --�������� NULL, ���� ������ ��� �������������
		  
		  ,mg.[is_next_candidate] --�������� ��������� ���������� �� �������������� ������ (1 = ��, 0 = ���, NULL = ������ ��� �������������)
		  ,mg.[wait_time_ms] --����� �������� � �������������. �������� NULL, ���� ������ ��� �������������
		  ,mg.[pool_id] --������������� ���� ��������, � �������� ����������� ������ ������ ������� ��������
		  ,mg.[is_small] --�������� 1 ��������, ��� ��� ������ �������� �������������� ������ ������������ ����� ������� �������.
						 --�������� 0 �������� ������������� �������� ��������
		  
		  ,mg.[ideal_memory_kb] --�����, � ���������� (��), ��������������� ������, ����������� ��� ���������� ���� ������ � ���������� ������.
								--������������ �� ������ ���������� ���������
		  
		  ,mg.[reserved_worker_count] --����� ������� ���������, ����������������� � ������� ������������ ��������, � ����� ����� �������� ������� ���������, ������������ ����� ���������
		  ,mg.[used_worker_count] --����� ������� ���������, ������������ ������������ ��������
		  ,mg.[max_used_worker_count] --???
		  ,mg.[reserved_node_bitmap] --???
		  ,pl.[bucketid] --������������� �������� ����, � ������� ���������� ������.
						 --�������� ��������� �������� �� 0 �� �������� ������� ���-������� ��� ���� ����.
						 --��� ����� SQL Plans � Object Plans ������ ���-������� ����� ��������� 10007 �� 32-��������� ������� ������ � 40009 � �� 64-���������.
						 --��� ���� Bound Trees ������ ���-������� ����� ��������� 1009 �� 32-��������� ������� ������ � 4001 �� 64-���������.
						 --��� ���� ����������� �������� �������� ������ ���-������� ����� ��������� 127 �� 32-��������� � 64-��������� ������� ������
		  
		  ,pl.[refcounts] --����� �������� ����, ����������� �� ������ ������ ����.
						  --�������� refcounts ��� ������ ������ ���� �� ������ 1, ����� ����������� � ����
		  
		  ,pl.[usecounts] --���������� ���������� ������ ������� ����.
						  --�������� ��� ����������, ���� ����������������� ������� ������������ ���� � ����.
						  --����� ���� �������� ��������� ��� ��� ������������� ���������� showplan
		  
		  ,pl.[size_in_bytes] --����� ������, ���������� �������� ����
		  ,pl.[memory_object_address] --����� ������ ������������ ������.
									  --��� �������� ����� ������������ � �������������� sys.dm_os_memory_objects,
									  --����� ���������������� ������������� ������ ������������� �����, 
									  --� � �������������� sys.dm_os_memory_cache_entries ��� ����������� ������ �� ����������� ������
		  
		  ,pl.[cacheobjtype] --��� ������� � ����. �������� ����� ���� ����� �� ���������
		  ,pl.[objtype] --��� �������. �������� ����� ���� ����� �� ���������
		  ,pl.[parent_plan_handle] --������������ ����
		  
		  --������ �� sys.dm_exec_query_stats ������� �� �����, � ������� ���� ���� (������, ����)
		  ,qs.[creation_time] --����� ���������� �����
		  ,qs.[execution_count] --���������� ���������� ����� � ������� ��������� ����������
		  ,qs.[total_worker_time] --����� ����� ��, ����������� �� ���������� ����� � ������� ����������, � ������������� (�� � ��������� �� ������������)
		  ,qs.[min_last_worker_time] --����������� ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[max_last_worker_time] --������������ ����� ��, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[min_worker_time] --����������� ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[max_worker_time] --������������ ����� ��, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[total_physical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_last_physical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_last_physical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_physical_reads] --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_physical_reads] --������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[total_logical_writes] --����� ���������� �������� ���������� ������ ��� ���������� ����� � ������� ��� ����������.
									 --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_last_logical_writes] --����������� ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_last_logical_writes] --������������ ���������� ������� � �������� ����, ������������ �� ����� ���������� ���������� �����.
										--���� �������� ��� �������� �������� (�. �. ����������), �������� ������ �� �����������.
										--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_logical_writes] --����������� ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_logical_writes] --������������ ���������� �������� ���������� ������ �� ���� ���������� �����.
								   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[total_logical_reads] --����� ���������� �������� ����������� ���������� ��� ���������� ����� � ������� ��� ����������.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_last_logical_reads] --����������� ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_last_logical_reads] --������������ ���������� �������� ����������� ���������� �� ����� ���������� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[min_logical_reads]	   --����������� ���������� �������� ����������� ���������� �� ���� ���������� �����.
									   --�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[max_logical_reads]	--������������ ���������� �������� ����������� ���������� �� ���� ���������� �����.
									--�������� ������ ����� 0 ��� ������� ���������������� ��� ������ �������
		  
		  ,qs.[total_clr_time]	--�����, � ������������� (�� � ��������� �� ������������),
								--������ Microsoft .NET Framework ������������ ����� ���������� (CLR) ������� ��� ���������� ����� � ������� ��� ����������.
								--������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,qs.[min_last_clr_time] --����������� �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,qs.[max_last_clr_time] --������������ �����, � ������������� (�� � ��������� �� ������������),
								  --����������� ������ .NET Framework ������� ����� CLR �� ����� ���������� ���������� �����.
								  --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,qs.[min_clr_time] --����������� �����, �����-���� ����������� �� ���������� ����� ������ �������� .NET Framework ����� CLR,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  ,qs.[max_clr_time] --������������ �����, �����-���� ����������� �� ���������� ����� ������ ����� CLR .NET Framework,
							 --� ������������� (�� � ��������� �� ������������).
							 --������� ����� CLR ����� ���� ��������� �����������, ���������, ����������, ������ � ��������������� �����������
		  
		  --,qs.[total_elapsed_time] --����� �����, ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[min_last_elapsed_time] --����������� �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[max_last_elapsed_time] --������������ �����, ����������� �� ��������� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[min_elapsed_time] --����������� �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[max_elapsed_time] --������������ �����, �����-���� ����������� �� ���������� �����, � ������������� (�� � ��������� �� ������������)
		  ,qs.[total_rows] --����� ����� �����, ������������ ��������. �� ����� ����� �������� null.
						   --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,qs.[min_last_rows] --����������� ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,qs.[max_last_rows] --������������ ����� �����, ������������ ��������� ����������� �������. �� ����� ����� �������� null.
							  --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,qs.[min_rows] --����������� ���������� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,qs.[max_rows] --������������ ����� �����, �����-���� ������������ �� ������� �� ����� ���������� ����
						 --�������� ������ ����� 0, ���� ���������������� � ����������� ���� �������� ��������� ����������� ���������������� ��� ������ �������
		  
		  ,qs.[total_dop] --����� ����� �� ������� ������������ ����� ������������ � ������� ��� ����������.
						  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_dop] --����������� ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_dop] --������������ ������� ������������, ���� ����� ���������� ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_dop] --����������� ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_dop] --������������ ������� ������������ ���� ���� �����-���� ������������ �� ����� ������ ����������.
						--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[total_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ���������� � ������� ��� ����������.
							   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_grant_kb] --����������� ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_grant_kb] --������������ ����� ����������������� ������ ������������� � ��, ����� ����� ���������� ���������� �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_grant_kb] --����������� ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_grant_kb] --������������ ����� ����������������� ������ � �� ������������ ������� �� �������� � ���� ������ ���������� �����.
							 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[total_used_grant_kb] --����� ����� ����������������� ������ � �� ������������ ���� ����, ������������ � ������� ��� ����������.
									--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_used_grant_kb] --����������� ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_used_grant_kb] --������������ ����� �������������� ������������ ������ � ��, ���� ����� ���������� ���������� �����.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_used_grant_kb] --����������� ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_used_grant_kb] --������������ ����� ������������ ������ � �� ������������ ������� �� ������������ ��� ���������� ������ �����.
								  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[total_ideal_grant_kb] --����� ����� ��������� ������ � ��, ������ ����� � ������� ��� ����������.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_ideal_grant_kb] --����������� ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_ideal_grant_kb] --������������ ����� ������, ��������� ������������� � ��, ����� ����� ���������� ���������� �����.
										--�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_ideal_grant_kb] --����������� ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_ideal_grant_kb] --������������ ����� ������ ��������� �������������� � ���� ���� �����-���� ������ �� ����� ���������� ���� ��.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[total_reserved_threads] --����� ����� �� ����������������� ������������� ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
									   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_reserved_threads] --����������� ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_reserved_threads] --������������ ����� ����������������� ������������ �������, ����� ����� ���������� ���������� �����.
										  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_reserved_threads] --����������� ����� ����������������� ������������� �������, �����-���� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_reserved_threads] --������������ ����� ����������������� ������������� ������� ������� �� ������������ ��� ���������� ������ �����.
									 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[total_used_threads] --����� ����� ������������ ������������ ������� ���� ���� �����-���� ����������������� � ������� ��� ����������.
								   --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_last_used_threads] --����������� ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_last_used_threads] --������������ ����� ������������ ������������ �������, ����� ����� ���������� ���������� �����.
									  --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[min_used_threads] --����������� ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
		  
		  ,qs.[max_used_threads] --������������ ����� ������������ ������������ �������, ��� ���������� ������ ����� ������������.
								 --�� ������ ����� ����� 0 ��� ������� � �������, ���������������� ��� ������
from tbl_res_rec as t
left outer join sys.dm_exec_query_memory_grants as mg on t.[plan_handle]=mg.[plan_handle] and t.[sql_handle]=mg.[sql_handle]
left outer join sys.dm_exec_cached_plans as pl on t.[plan_handle]=pl.[plan_handle]
left outer join tbl_rec_stat_g as qs on t.[plan_handle]=qs.[plan_handle] and t.[sql_handle]=qs.[sql_handle] --and qs.[last_execution_time]=cast(t.[start_time] as date)
;
GO
/****** Object:  View [inf].[vRequestLockDetail]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



	CREATE view [inf].[vRequestLockDetail] as
/*
	���: �������� � ��������-��� ��������� � � �
*/
SELECT r.[session_id]
      ,r.[blocking_session_id]
	  ,(select top(1) text from sys.dm_exec_sql_text(r.[sql_handle])) as [TSQL]
	  ,DB_NAME(r.[database_id]) as DBName
	  ,(select top(1) [query_plan] from sys.dm_exec_query_plan(r.[plan_handle])) as [QueryPlan]
	  ,r.[request_id]
      ,r.[start_time]
      ,r.[status]
      ,r.[command]
      ,r.[sql_handle]
      ,r.[statement_start_offset]
      ,r.[statement_end_offset]
      ,r.[plan_handle]
      ,r.[database_id]
      ,r.[user_id]
      ,r.[connection_id]
      ,r.[wait_type]
      ,r.[wait_time]
      ,r.[last_wait_type]
      ,r.[wait_resource]
      ,r.[open_transaction_count]
      ,r.[open_resultset_count]
      ,r.[transaction_id]
      ,r.[context_info]
      ,r.[percent_complete]
      ,r.[estimated_completion_time]
      ,r.[cpu_time]
      ,r.[total_elapsed_time]
      ,r.[scheduler_id]
      ,r.[task_address]
      ,r.[reads]
      ,r.[writes]
      ,r.[logical_reads]
      ,r.[text_size]
      ,r.[language]
      ,r.[date_format]
      ,r.[date_first]
      ,r.[quoted_identifier]
      ,r.[arithabort]
      ,r.[ansi_null_dflt_on]
      ,r.[ansi_defaults]
      ,r.[ansi_warnings]
      ,r.[ansi_padding]
      ,r.[ansi_nulls]
      ,r.[concat_null_yields_null]
      ,r.[transaction_isolation_level]
      ,r.[lock_timeout]
      ,r.[deadlock_priority]
      ,r.[row_count]
      ,r.[prev_error]
      ,r.[nest_level]
      ,r.[granted_query_memory]
      ,r.[executing_managed_code]
      ,r.[group_id]
      ,r.[query_hash]
      ,r.[query_plan_hash]
	  ,lock.[resource_type]
      ,lock.[resource_subtype]
      ,lock.[resource_database_id]
      ,lock.[resource_description]
      ,lock.[resource_associated_entity_id]
      ,lock.[resource_lock_partition]
      ,lock.[request_mode]
      ,lock.[request_type]
      ,lock.[request_status]
      ,lock.[request_reference_count]
      ,lock.[request_session_id]
      ,lock.[request_exec_context_id]
      ,lock.[request_request_id]
      ,lock.[request_owner_type]
      ,lock.[request_owner_id]
      ,lock.[request_owner_guid]
      ,lock.[lock_owner_address]
FROM sys.dm_exec_requests as r
inner join sys.dm_tran_locks as lock on lock.request_owner_id=r.[transaction_id]

GO
/****** Object:  View [inf].[vRequests]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







	CREATE view [inf].[vRequests] as
/*
	���: �������� � ��������
*/
SELECT session_id
	  ,status
	  ,blocking_session_id
	  ,database_id
	  ,DB_NAME(database_id) as DBName
	  ,(select top(1) text from sys.dm_exec_sql_text([sql_handle])) as [TSQL]
	  ,(select top(1) [query_plan] from sys.dm_exec_query_plan([plan_handle])) as [QueryPlan]
	  ,[sql_handle]
      ,[statement_start_offset]--���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ��������� ����������� � ��������� ������ ���������� ��� �������. ����������� �������� NULL.
      ,[statement_end_offset]--���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ��������� ����������� � ��������� ������ ���������� ��� �������. ����������� �������� NULL.
      ,[plan_handle]
      ,[user_id]
      ,[connection_id]
      ,[wait_type]--��� ��������
      ,[wait_time]--���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������). �� ��������� �������� NULL.
	  ,round(cast([wait_time] as decimal(18,3))/1000, 3) as [wait_timeSec]
      ,[last_wait_type]--���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������. �� ��������� �������� NULL.
      ,[wait_resource]--���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������. �� ��������� �������� NULL.
      ,[open_transaction_count]--����� ����������, �������� ��� ������� �������. �� ��������� �������� NULL.
      ,[open_resultset_count]--����� �������������� �������, �������� ��� ������� �������. �� ��������� �������� NULL.
      ,[transaction_id]--������������� ����������, � ������� ����������� ������. �� ��������� �������� NULL.
      ,[context_info]
      ,[percent_complete]
      ,[estimated_completion_time]
      ,[cpu_time]--����� �� (� �������������), ����������� �� ���������� �������. �� ��������� �������� NULL.
	  ,round(cast([cpu_time] as decimal(18,3))/1000, 3) as [cpu_timeSec]
      ,[total_elapsed_time]--����� �����, �������� � ������� ����������� ������� (� �������������). �� ��������� �������� NULL.
	  ,round(cast([total_elapsed_time] as decimal(18,3))/1000, 3) as [total_elapsed_timeSec]
      ,[scheduler_id]--������������� ������������, ������� ��������� ������ ������. �� ��������� �������� NULL.
      ,[task_address]--����� ����� ������, ����������� ��� ������, ��������� � ���� ��������. ����������� �������� NULL.
      ,[reads]--����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL.
      ,[writes]--����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL.
      ,[logical_reads]--����� ���������� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL.
      ,[text_size]--��������� ��������� TEXTSIZE ��� ������� �������. �� ��������� �������� NULL.
      ,[language]--��������� ����� ��� ������� �������. ����������� �������� NULL.
      ,[date_format]--��������� ��������� DATEFORMAT ��� ������� �������. ����������� �������� NULL.
      ,[date_first]--��������� ��������� DATEFIRST ��� ������� �������. �� ��������� �������� NULL.
      ,[quoted_identifier]
      ,[arithabort]
      ,[ansi_null_dflt_on]
      ,[ansi_defaults]
      ,[ansi_warnings]
      ,[ansi_padding]
      ,[ansi_nulls]
      ,[concat_null_yields_null]
      ,[transaction_isolation_level]--������� ��������, � ������� ������� ���������� ��� ������� �������. �� ��������� �������� NULL (0-�� �����, �� 1 �� 5 ������������ ������ �������� ����������)
      ,[lock_timeout]--����� �������� ���������� ��� ������� ������� (� �������������). �� ��������� �������� NULL.
      ,[deadlock_priority]--�������� ��������� DEADLOCK_PRIORITY ��� ������� �������. �� ��������� �������� NULL.
      ,[row_count]--����� �����, ������������ ������� �� ������� �������. �� ��������� �������� NULL.
      ,[prev_error]--��������� ������, ����������� ��� ���������� �������. �� ��������� �������� NULL.
      ,[nest_level]--������� ������� ����������� ����, ������������ ��� ������� �������. �� ��������� �������� NULL.
      ,[granted_query_memory]--����� �������, ���������� ��� ���������� ������������ �������. �� ��������� �������� NULL.
      ,[executing_managed_code]--���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������). ���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL. �� ��������� �������� NULL.
      ,[group_id]--������������� ������ ������� ��������, ������� ����������� ���� ������. �� ��������� �������� NULL.
      ,[query_hash]--�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������. ����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������.
      ,[query_plan_hash]--�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������. ����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������.
FROM sys.dm_exec_requests






GO
/****** Object:  View [inf].[vSchedulersOS]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vSchedulersOS] as
--���������� �� ����� ������ ��� ������� ������������ SQL Server, ��������������� � ��������� �����������
SELECT scheduler_id			--������������� ������������. ��� ������������, ������������ ��� ���������� ������� ��������, ����� �������������� ������ 1048576.
							--������������ � ����������������, ������� 255 ��� ������������ ��� ��������, ������������ ����������� ����������� SQL Server,
							--	������ ��� ����������� ���������� ���������������� ����������. �� ��������� �������� NULL.
	 , cpu_id				--������������� ��, ����������� ������������. �� ��������� �������� NULL.
	 , parent_node_id		--������������� ����, � �������� ��������� �����������; ���� ���� ��� �������� ������������.
							--�� �������� ����� � ������������ �������� � ������ (NUMA). �� ��������� �������� NULL.
	 , current_tasks_count	--���������� �����, ��������������� � ��������� ������ � ������ �������������. ���� ������� ��������:
							--������, ��������� �����������, ������� �� �� ��������;
							--������, ��������� ���������� ��� ������������� � ������ ������ (����������� � ��������� SUSPENDED ��� RUNNABLE).
							--��� ���������� ������ ���� ������� �����������. �� ��������� �������� NULL.
	 , runnable_tasks_count	--���������� ������������ � ������������ ��������, ������� ������� ���������� � ������� ������� � ������. �� ��������� �������� NULL.
	 , current_workers_count--���������� ������������, ��������������� � ������ �������������. � �� ����� ������ �����������, ������� �� ��������� ������� ������. 
							--�� ��������� �������� NULL.
	 , active_workers_count	--���������� �������� ������������. �������� ����������� ������� �� �������� � ������ � �����������; 
							--�� ������ ����� ��������� � ��� ������ � ���� ��������, ���� ����� � ����������, ���� �������������. 
							--�� ��������� �������� NULL.
	 , work_queue_count		--����� ����� � ������� �� ����������. ��� ������, ��������� �����������, ������� �� �� ��������. �� ��������� �������� NULL.
	 , pending_disk_io_count--����� �������� �����-������, ��������� ����������. ������ ����������� ����� ������ ������������� �������� �����-������, 
							--	�������� ��� ������ ������������ ���������, �� ��������� �� ���. 
							--���� ������� ������������� ��� ����������� ������� � ����������� ��� ���������� ��������� �������. 
							--�� �� ������������� ��������� �������� �����-������. �� ��������� �������� NULL.
	 , load_factor			--���������� ��������, ��������������� �������� �� �����������. ��� ������������ ��� ������������� ����� ����� ��������������. 
							--��� �������� ����� ��������� �������� ��� ������� � ������ �������������� ������������� �������� ����� ��������������. 
							--������� � ������������� ����������� � ����������� �� �������� ������������. 
							--����� ����, ��� ����������� ���������� ��������� �������� � SQL Server ������������ ������ �������� �� ���� � ������������. 
							--����� ������ ���������� � �������, ������ �������� �������������. ����� ������ �����������, ������ �������� �����������. 
							--������� �������� �������� ������������ ������� SQL Server ����������� ��������� �������������� ��������. �� ��������� �������� NULL.
	 , is_online			--���� SQL Server �������� �� ������������� ���� ��������� ��������� �� ������� �����������, 
							--	��������� ������������ ����� ���� ������������ � ������������, �� ���������� � ����� ��������. 
							--���� ��� ���, �� ���� ������� ������ 0. ��� �������� ��������, ��� ����������� �� ������������ ��� ��������� �������� ��� �������.
							--�� ��������� �������� NULL.
	, is_idle				--1 = ����������� ��������� � ��������� �������. � ��������� ������ �� ������� �� ���� �� ������������. �� ��������� �������� NULL.
	, failed_to_create_worker--��� �������� ��������������� � 1, ���� �� ������ ������������ �� ������� ������� ����� �����������. 
							 --��� �������, ��� ���������� ��-�� ���������� ������. ��������� �������� NULL.
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255
GO
/****** Object:  View [inf].[vSchemaDescription]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [inf].[vSchemaDescription] as
select
SCHEMA_NAME(t.schema_id) as SchemaName
--,QUOTENAME(object_schema_name(t.[object_id]))+'.'+quotename(t.[name]) as TableName
,ep.[value] as SchemaDescription
from sys.schemas as t
left outer join sys.extended_properties as ep on t.[schema_id]=ep.[major_id]
											 and ep.[minor_id]=0
											 and ep.[name]='MS_Description'
GO
/****** Object:  View [inf].[vServerBackupDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [inf].[vServerBackupDB] as
with backup_cte as
(
    select
        bs.[database_name],
        backup_type =
            case bs.[type]
                when 'D' then 'database'
                when 'L' then 'log'
                when 'I' then 'differential'
                else 'other'
            end,
        bs.[first_lsn],
		bs.[last_lsn],
		bs.[backup_start_date],
		bs.[backup_finish_date],
		cast(bs.[backup_size] as decimal(18,3))/1024/1024 as BackupSizeMb,
		LogicalDeviceName = bmf.[logical_device_name],
		PhysicalDeviceName = bmf.[physical_device_name],
		bs.[server_name],
		bs.[user_name]
    FROM msdb.dbo.backupset bs
    INNER JOIN msdb.dbo.backupmediafamily bmf 
        ON [bs].[media_set_id] = [bmf].[media_set_id]
)
select
    [server_name] as [ServerName],
	[database_name] as [DBName],
	[user_name] as [USerName],
    [backup_type] as [BackupType],
	[backup_start_date] as [BackupStartDate],
    [backup_finish_date] as [BackupFinishDate],
	[BackupSizeMb], --������ ��� ������
	[LogicalDeviceName],
	[PhysicalDeviceName],
	[first_lsn] as [FirstLSN],
	[last_lsn] as [LastLSN]
from backup_cte;
GO
/****** Object:  View [inf].[vServerConfigurations]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE view [inf].[vServerConfigurations] as
/*
	exec sp_configure 'show advanced options', 1; -- ����� �������������� ����� �������� � ����
	-- (1-�� ���������)

	exec sp_configure 'query governor cost limit', 6000; -- �������������� ����� �� ����� ���������� ������� (� �� �� ����� ��� ����������� ����������
		-- ���������� �������)-��������� ������ �� SQL-������, � �� �� ���������� T-SQL
		-- ��������! ����� ���� �� �������������� ����� ���������� ������� �� ��� ���������������� ����� ����������.
		-- �. �. ������ ����� � ���������� ����������� 25 ���, � ������ �������� ��� ������-����� ������ ����� ���������� � �������.
		-- �. �. ����� ���� �� �� ����� ���������� ������� (������ �� ����������� �� ����� ������ ����������), 
		-- � �� ���������������� ����� ���������� ������� (��� ������� �������� ��������������� ���� ���������� � ���� �� ������� �� ��������� �����,
		-- �� ������ ����������� � ������� � �� �����������
		-- (0-�� ���������)
	exec sp_configure 'query wait (s)', 600; --��� �������� ������� � ��������, � ������� �������� ������ ����� ������� �������
	-- (-1-�� ���������)

	exec sp_configure 'remote query timeout (s)', 600; -- ��� ������� ������� �������� SQL Server (� ��������), � ������� �������� ����� ����������� ��������� ��������
	-- (0-�� ���������)

	exec sp_configure 'blocked process threshold', 20; -- ���������� ��������� �������� (� ��������), � ������� �������� ������������� ������� ��������� ���������.
	-- ��� ������� �� ����������� ��� ��������� ����� � ��� �����, ������� ������� �������, �� ������������ ������������� ����������������.
	-- ��� ������������ ������� ������� ����� ������ ��������������.
	-- ��������, ����� ������ �������������� �� ������� ��������� � ������������� ����������� � �����������.
	-- ���������� ������ ���������� �������� ���������� ������� ����� ������������ ����������������, ������� ������������� ������ �����,
	-- ��������� ���������� � ������� �������, ������������ ��������� � ���������� ��������� ��������.
	-- ��� ������� ����������� ���� ��� � ������� ��������� ��������� ��� ������ �� ��������������� �����.
	-- ����� � ������������� �������� ����������� �� �������� ����������� ������.
	-- ��� ������� ��������, ��� �� ����� ���������� � �������� ������� ��� ���� �� ���������� ������.
	--  (0-�� ���������)
	exec sp_configure 'Database Mail XPs', 1; -- ��� ��������� ���������� Database Mail �� ������� (��� �������� �����������)
	-- (0-�� ���������)

	exec sp_configure 'clr enabled', 1; -- ��� ����������� ���������� CLR-������
	-- (0-�� ���������)

	exec sp_configure 'Ad Hoc Distributed Queries', 1;
	-- �� ��������� SQL Server �� ��������� �������������������� �������������� �������,
	-- ������������ ��������� OPENROWSET � OPENDATASOURCE.
	-- ���� ���� �������� ����� 1, SQL Server ��������� ���������� �������������������� �������������� ��������.
	-- ���� ���� �������� �� ����� ��� ����� 0, SQL Server �� ��������� �������������������� ������

	exec sp_configure 'contained database authentication', 1; -- ��������� ���������� ��
	-- (0-�� ���������)

	exec sp_configure 'Ole Automation Procedures', 1; -- ����������� �������� ����������� �������� OLE-������������� � ������� Transact-SQL
	-- (0-�� ���������)

	reconfigure with override; -- ����� ��������� ������������ �������� � ����
*/
SELECT
configuration_id,
name,
value,
minimum,
maximum,
value_in_use,
description,
is_dynamic,
is_advanced
FROM sys.configurations






GO
/****** Object:  View [inf].[vServerFilesDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vServerFilesDB] as
--�������� ���������� � ������ ��
SELECT  @@SERVERNAME AS Server ,
        d.name AS DBName ,
        create_date ,
        compatibility_level ,
        m.physical_name AS FileName,
		d.create_date as CreateDate
FROM    sys.databases d
        JOIN sys.master_files m ON d.database_id = m.database_id
WHERE   m.[type] = 0 -- data files only
--ORDER BY d.name;

GO
/****** Object:  View [inf].[vServerLastBackupDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [inf].[vServerLastBackupDB] as
with backup_cte as
(
    select
        bs.[database_name],
        backup_type =
            case bs.[type]
                when 'D' then 'database'
                when 'L' then 'log'
                when 'I' then 'differential'
                else 'other'
            end,
        bs.[first_lsn],
		bs.[last_lsn],
		bs.[backup_start_date],
		bs.[backup_finish_date],
		cast(bs.[backup_size] as decimal(18,3))/1024/1024 as BackupSizeMb,
        rownum = 
            row_number() over
            (
                partition by bs.[database_name], type 
                order by bs.[backup_finish_date] desc
            ),
		LogicalDeviceName = bmf.[logical_device_name],
		PhysicalDeviceName = bmf.[physical_device_name],
		bs.[server_name],
		bs.[user_name]
    FROM msdb.dbo.backupset bs
    INNER JOIN msdb.dbo.backupmediafamily bmf 
        ON [bs].[media_set_id] = [bmf].[media_set_id]
)
select
    [server_name] as [ServerName],
	[database_name] as [DBName],
	[user_name] as [USerName],
    [backup_type] as [BackupType],
	[backup_start_date] as [BackupStartDate],
    [backup_finish_date] as [BackupFinishDate],
	[BackupSizeMb], --������ ��� ������
	[LogicalDeviceName],
	[PhysicalDeviceName],
	[first_lsn] as [FirstLSN],
	[last_lsn] as [LastLSN]
from backup_cte
where rownum = 1;

GO
/****** Object:  View [inf].[vServerOnlineDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vServerOnlineDB] as
-- ����� �� ������ ������������
SELECT  @@Servername AS Server ,
        DB_NAME(database_id) AS DatabaseName ,
        COUNT(database_id) AS Connections ,
        Login_name AS  LoginName ,
        MIN(Login_Time) AS Login_Time ,
        MIN(COALESCE(last_request_end_time, last_request_start_time))
                                                         AS  Last_Batch
FROM    sys.dm_exec_sessions
WHERE   database_id > 0
        --AND DB_NAME(database_id) NOT IN ( 'master', 'msdb' )
GROUP BY database_id ,
         login_name
--ORDER BY DatabaseName;
GO
/****** Object:  View [inf].[vServerProblemInCountFilesTempDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vServerProblemInCountFilesTempDB]
as
/*
	http://sqlcom.ru/dba-tools/tempdb-in-sql-server-2016/
	����� ������ ���� �� � �������� � ����������� ������ tempdb.
	���� �������� �������� ����� latch �� ��������� �������� PFS, GAM, SGAM � ���� ������ tempdb.
	���� ������ ������ �� ���������� ��� ���������� ������ ������ � �Is Not PFS, GAM, or SGAM page�, �� ������ ����� ������� �������� �� ������� ���������� ������ tempdb
*/
Select session_id,
wait_type,
wait_duration_ms,
blocking_session_id,
resource_description,
		ResourceType = Case
When Cast(Right(resource_description, Len(resource_description) - Charindex(':', resource_description, 3)) As Int) - 1 % 8088 = 0 Then 'Is PFS Page'
			When Cast(Right(resource_description, Len(resource_description) - Charindex(':', resource_description, 3)) As Int) - 2 % 511232 = 0 Then 'Is GAM Page'
			When Cast(Right(resource_description, Len(resource_description) - Charindex(':', resource_description, 3)) As Int) - 3 % 511232 = 0 Then 'Is SGAM Page'
			Else 'Is Not PFS, GAM, or SGAM page'
			End
From sys.dm_os_waiting_tasks
Where wait_type Like 'PAGE%LATCH_%'
And resource_description Like '2:%' 
GO
/****** Object:  View [inf].[vServerRunTime]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vServerRunTime] as
--����� ������ �������
SELECT  @@Servername AS ServerName ,
        create_date AS  ServerStarted ,
        DATEDIFF(s, create_date, GETDATE()) / 86400.0 AS DaysRunning ,
        DATEDIFF(s, create_date, GETDATE()) AS SecondsRunnig
FROM    sys.databases
WHERE   name = 'tempdb'; 


GO
/****** Object:  View [inf].[vServerShortInfo]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [inf].[vServerShortInfo] as
--�������� ����������
-- ����� ������� � ���������� 
Select @@SERVERNAME as [Server\Instance]
-- ������ SQL Server 
,@@VERSION as SQLServerVersion
-- ��������� SQL Server 
,@@ServiceName AS ServiceInstance
 -- ������� �� (��, � ��������� ������� ����������� ������)
,DB_NAME() AS CurrentDB_Name
,system_user as CurrentLogin--�����
,USER_NAME() as CurrentUser--������������
,SERVERPROPERTY(N'BuildClrVersion')					as BuildClrVersion
,SERVERPROPERTY(N'Collation')						as Collation
,SERVERPROPERTY(N'CollationID')						as CollationID
,SERVERPROPERTY(N'ComparisonStyle')					as ComparisonStyle
,SERVERPROPERTY(N'ComputerNamePhysicalNetBIOS')		as ComputerNamePhysicalNetBIOS
,SERVERPROPERTY(N'Edition')							as Edition
,SERVERPROPERTY(N'EditionID')						as EditionID
,SERVERPROPERTY(N'EngineEdition')					as EngineEdition
,SERVERPROPERTY(N'HadrManagerStatus')				as HadrManagerStatus
,SERVERPROPERTY(N'InstanceName')					as InstanceName
,SERVERPROPERTY(N'IsClustered')						as IsClustered
,SERVERPROPERTY(N'IsFullTextInstalled')				as IsFullTextInstalled
,SERVERPROPERTY(N'IsHadrEnabled')					as IsHadrEnabled
,SERVERPROPERTY(N'IsIntegratedSecurityOnly')		as IsIntegratedSecurityOnly
,SERVERPROPERTY(N'IsLocalDB')						as IsLocalDB
,SERVERPROPERTY(N'IsSingleUser')					as IsSingleUser
,SERVERPROPERTY(N'IsXTPSupported')					as IsXTPSupported
,SERVERPROPERTY(N'LCID')							as LCID
,SERVERPROPERTY(N'LicenseType')						as LicenseType
,SERVERPROPERTY(N'MachineName')						as MachineName
,SERVERPROPERTY(N'NumLicenses')						as NumLicenses
,SERVERPROPERTY(N'ProcessID')						as ProcessID
,SERVERPROPERTY(N'ProductVersion')					as ProductVersion
,SERVERPROPERTY(N'ProductLevel')					as ProductLevel
,SERVERPROPERTY(N'ResourceLastUpdateDateTime')		as ResourceLastUpdateDateTime
,SERVERPROPERTY(N'ResourceVersion')					as ResourceVersion
,SERVERPROPERTY(N'ServerName')						as ServerName
,SERVERPROPERTY(N'SqlCharSet')						as SqlCharSet
,SERVERPROPERTY(N'SqlCharSetName')					as SqlCharSetName
,SERVERPROPERTY(N'SqlSortOrder')					as SqlSortOrder
,SERVERPROPERTY(N'SqlSortOrderName')				as SqlSortOrderName
,SERVERPROPERTY(N'FilestreamShareName')				as FilestreamShareName
,SERVERPROPERTY(N'FilestreamConfiguredLevel')		as FilestreamConfiguredLevel
,SERVERPROPERTY(N'FilestreamEffectiveLevel')		as FilestreamEffectiveLevel
GO
/****** Object:  View [inf].[vSessionThreadOS]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [inf].[vSessionThreadOS] as
/*
	���: ������������� ���������� ����������, ����������� ������������� ������ � ��������������� ������ Windows.
		 �� ������������������� ������ ����� ��������� � ��������� �������� Windows.
		 ������ �� ���������� �������������� �������, ������� � ��������� ������ ��������� � ������ ������.
*/
SELECT STasks.session_id, SThreads.os_thread_id
    FROM sys.dm_os_tasks AS STasks
    INNER JOIN sys.dm_os_threads AS SThreads
        ON STasks.worker_address = SThreads.worker_address
    WHERE STasks.session_id IS NOT NULL;


GO
/****** Object:  View [inf].[vSizeCache]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vSizeCache] as
--������� ������ ����� ���� ������ � ���� ������ �������� (https://club.directum.ru/post/1125)
with tbl as (
	select
	  TotalCacheSize = SUM(CAST(size_in_bytes as bigint)) / 1048576,
	  QueriesCacheSize = SUM(CAST((case 
									  when objtype in ('Adhoc', 'Prepared') 
									  then size_in_bytes else 0 
									end) as bigint)) / 1048576,
	  QueriesUseMultiCountCacheSize = SUM(CAST((case 
									  when ((objtype in ('Adhoc', 'Prepared')) and (usecounts>1))
									  then size_in_bytes else 0 
									end) as bigint)) / 1048576,
	  QueriesUseOneCountCacheSize = SUM(CAST((case 
									  when ((objtype in ('Adhoc', 'Prepared')) and (usecounts=1))
									  then size_in_bytes else 0 
									end) as bigint)) / 1048576
	from sys.dm_exec_cached_plans
)
select 
  'Queries' as 'Cache', 
  (select top(1) QueriesCacheSize from tbl) as 'Cache Size (MB)', 
  CAST((select top(1) QueriesCacheSize from tbl) * 100 / (select top(1) TotalCacheSize from tbl) as int) as 'Percent of Total/Queries'
union all
select 
  'Total' as 'Cache', 
  (select top(1) TotalCacheSize from tbl) as 'Cache Size (MB)', 
  100 as 'Percent of Total/Queries'
union all
select 
  'Queries UseMultiCount' as 'Cache', 
  (select top(1) QueriesUseMultiCountCacheSize from tbl) as 'Cache Size (MB)', 
  CAST((select top(1) QueriesUseMultiCountCacheSize from tbl) * 100 / (select top(1) QueriesCacheSize from tbl) as int) as 'Percent of Queries/Queries'
union all
select 
  'Queries UseOneCount' as 'Cache', 
  (select top(1) QueriesUseOneCountCacheSize from tbl) as 'Cache Size (MB)', 
  CAST((select top(1) QueriesUseOneCountCacheSize from tbl) * 100 / (select top(1) QueriesCacheSize from tbl) as int) as 'Percent of Queries/Queries'
--option(recompile)
GO
/****** Object:  View [inf].[vSuspendedRequest]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




	CREATE view [inf].[vSuspendedRequest] as
/*
	���: �������� � ���������������� (���������) ��������
*/
SELECT session_id
	  ,status
	  ,blocking_session_id
	  ,database_id
	  ,DB_NAME(database_id) as DBName
	  ,(select top(1) text from sys.dm_exec_sql_text([sql_handle])) as [TSQL]
	  ,[sql_handle]
	   ,[statement_start_offset]
	   ,[statement_end_offset]
	   ,[plan_handle]
	   ,[user_id]
	   ,[connection_id]
	   ,[wait_type]
	   ,[wait_time]
	   ,[last_wait_type]
	   ,[wait_resource]
	   ,[open_transaction_count]
	   ,[open_resultset_count]
	   ,[transaction_id]
	   ,[context_info]
	   ,[percent_complete]
	   ,[estimated_completion_time]
	   ,[cpu_time]
	   ,[total_elapsed_time]
	   ,[scheduler_id]
	   ,[task_address]
	   ,[reads]
	   ,[writes]
	   ,[logical_reads]
	   ,[text_size]
	   ,[language]
	   ,[date_format]
	   ,[date_first]
	   ,[quoted_identifier]
	   ,[arithabort]
	   ,[ansi_null_dflt_on]
	   ,[ansi_defaults]
	   ,[ansi_warnings]
	   ,[ansi_padding]
	   ,[ansi_nulls]
	   ,[concat_null_yields_null]
	   ,[transaction_isolation_level]
	   ,[lock_timeout]
	   ,[deadlock_priority]
	   ,[row_count]
	   ,[prev_error]
	   ,[nest_level]
	   ,[granted_query_memory]
	   ,[executing_managed_code]
	   ,[group_id]
	   ,[query_hash]
	   ,[query_plan_hash]
FROM sys.dm_exec_requests
WHERE status = N'suspended' --������������� �����;



GO
/****** Object:  View [inf].[vSynonyms]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vSynonyms] as
-- �������������� ���������� � ���������

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
		sch.name as SchemaName,
        s.name AS [Synonyms] ,
        s.create_date as CreateDate,
        s.base_object_name as BaseObjectName
FROM    sys.synonyms s
inner join sys.schemas as sch on sch.schema_id=s.schema_id
--ORDER BY s.name;


GO
/****** Object:  View [inf].[vTables]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vTables] as
--�������
select @@Servername AS Server,
       DB_NAME() AS DBName,
	   s.name as SchemaName,
	   t.name as TableName,
	   t.type as Type,
	   t.type_desc as TypeDesc,
	   t.create_date as CreateDate,
	   t.modify_date as ModifyDate
from sys.tables as t
inner join sys.schemas as s on t.schema_id=s.schema_id
GO
/****** Object:  View [inf].[vTriggers]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vTriggers] as
select t.name as TriggerName,
	   t.parent_class_desc,
	   t.type as TrigerType,
	   t.create_date as TriggerCreateDate,
	   t.modify_date as TriggerModifyDate,
	   t.is_disabled as TriggerIsDisabled,
	   t.is_instead_of_trigger as TriggerInsteadOfTrigger,
	   t.is_ms_shipped as TriggerIsMSShipped,
	   t.is_not_for_replication,
	   s.name as SchenaName,
	   ob.name as ObjectName,
	   ob.type_desc as ObjectTypeDesc,
	   ob.type as ObjectType,
	   sm.[DEFINITION] AS 'Trigger script'
from sys.triggers as t --sys.server_triggers
left outer join sys.objects as ob on t.parent_id=ob.object_id
left outer join sys.schemas as s on ob.schema_id=s.schema_id
left outer join sys.sql_modules sm ON t.object_id = sm.OBJECT_ID;


GO
/****** Object:  View [inf].[vTriggerStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [inf].[vTriggerStat] as 
select DB_Name(coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [DB_Name]
	  ,OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Schema_Name]
	  ,object_name(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid])) as [Object_Name]
	  ,coalesce(QS.[database_id], ST.[dbid], PT.[dbid]) as [database_id]
	  ,SCHEMA_ID(OBJECT_SCHEMA_NAME(coalesce(QS.[object_id], ST.[objectid], PT.[objectid]), coalesce(QS.[database_id], ST.[dbid], PT.[dbid]))) as [schema_id]
      ,coalesce(QS.[object_id], ST.[objectid], PT.[objectid]) as [object_id]
      ,QS.[type]
      ,QS.[type_desc]
      ,QS.[sql_handle]
      ,QS.[plan_handle]
      ,QS.[cached_time]
      ,QS.[last_execution_time]
      ,QS.[execution_count]
      ,QS.[total_worker_time]
      ,QS.[last_worker_time]
      ,QS.[min_worker_time]
      ,QS.[max_worker_time]
      ,QS.[total_physical_reads]
      ,QS.[last_physical_reads]
      ,QS.[min_physical_reads]
      ,QS.[max_physical_reads]
      ,QS.[total_logical_writes]
      ,QS.[last_logical_writes]
      ,QS.[min_logical_writes]
      ,QS.[max_logical_writes]
      ,QS.[total_logical_reads]
      ,QS.[last_logical_reads]
      ,QS.[min_logical_reads]
      ,QS.[max_logical_reads]
      ,QS.[total_elapsed_time]
      ,QS.[last_elapsed_time]
      ,QS.[min_elapsed_time]
      ,QS.[max_elapsed_time]
	  ,ST.[encrypted]
	  ,ST.[text] as [TSQL]
	  ,PT.[query_plan]
FROM sys.dm_exec_trigger_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.[sql_handle]) as ST
	 CROSS APPLY sys.dm_exec_query_plan(QS.[plan_handle]) as PT
GO
/****** Object:  View [inf].[vTypesRunStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [inf].[vTypesRunStatistics] as
-- ���������� �� ������������ ����� ������

SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        Data_Type ,
        Numeric_Precision AS  Prec ,
        Numeric_Scale AS  Scale ,
        Character_Maximum_Length AS [Length] ,
        COUNT(*) AS COUNT
FROM    INFORMATION_SCHEMA.COLUMNS isc
        INNER JOIN  INFORMATION_SCHEMA.TABLES ist
               ON isc.table_name = ist.table_name
WHERE   Table_type = 'BASE TABLE'
GROUP BY Data_Type ,
        Numeric_Precision ,
        Numeric_Scale ,
        Character_Maximum_Length
--ORDER BY Data_Type ,
--        Numeric_Precision ,
--        Numeric_Scale ,
--        Character_Maximum_Length  

GO
/****** Object:  View [inf].[vViews]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [inf].[vViews] as
--�������������
select @@Servername AS Server,
       DB_NAME() AS DBName,
	   s.name as SchemaName,
	   t.name as TableName,
	   t.type as Type,
	   t.type_desc as TypeDesc,
	   t.create_date as CreateDate,
	   t.modify_date as ModifyDate
from sys.views as t
inner join sys.schemas as s on t.schema_id=s.schema_id
GO
/****** Object:  View [inf].[vWaits]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [inf].[vWaits] as
/*
	2014-08-22 ���:
		SQL Server ����������� �����, ������� �������� ����� ������� ������ �� ��������� ������������� � ��� ������������ � ��� ���������, 
		��������� ��� ��� ������ ��������� (wait time) � �����, ����������� � ��������� ������ � �����������, 
		��������� ��� ��� ������ �������� ������� (signal wait time), 
		�.�. ������� ������� ��������� ������ ����� ��������� ������� � ����������� �������� ��� ����, 
		����� �������� ������ � ����������. 
		�� ������ ������, ������� ������� ������ ����� � ��������� ���������������, 
		���������� ��������� �������� �������� (resource wait time), ������� ����� �������� ������� �� ������ ������� ��������.

		http://habrahabr.ru/post/216309/

		505: CXPACKET 
			�������� �����������, �� �� ����������� � ��� ��������. 
			�����-����������� � ������������ ������� ������ ����������� ��� ��������. 
			���� ������������ ������ �� ������ ������� ��� ���� �� ������� ������������, �� ��������� ������ ����� ����������� �������� CXPACKET, 
			��� �������� � ����� �������� ���������� ���������� �� ����� ���� � � ���� � ��������. 
			���� ����� ����� ����� ������ ������, ��� ���������, � �� ���� ������� ���� ������ �����������, ���� ������ ����� �� �������� ���� ������. 
			���� ���� ��� �������� �������� � �������� ������� �������� PAGEIOLATCH_XX, �� ��� ����� ���� ������������ ������� ������ 
			�� ������� ������������ ������������ �������� ��� ��-�� ������� ����� ���������� �������. 
			���� ��� �� �������� ��������, �� ������ ����������� ���������� ����� MAXDOP �� ���������� 4, 2, ��� 1 ��� ���������� �������� 
			��� ��� ����� ���������� ������� (��������������� �� ������� ���������� �max degree of parallelism�). 
			���� ���� ������� �������� �� ����� NUMA, ���������� ���������� MAXDOP � ��������, ������ ���������� ����������� � ����� ���� NUMA ��� ����, 
			����� ����������, �� � ���� �� ��������. ��� ����� ����� ���������� ������ �� ��������� MAXDOP �� �������� �� ��������� ���������. 
			���� ������, � �� ������� � ���������� �cost threshold for parallelism� (������ ��� �� 25 ��� ������), ������ ��� ������� �������� MAXDOP ��� ����� ����������. 
			� �� ��������� ��� ��������� �������� (Resource Governor) � Enterprise ������ SQL Server 2008, ������� ��������� ���������� ���������� ����������� 
			��� ���������� ������ ���������� � ��������.

		304: PAGEIOLATCH_XX
			��� ��� SQL Server ���� ������ �������� ������ � ����� � ������. 
			���� ��� �������� ����� ��������� �� �������� � ������� �����/������ (��� �������� ������ �������� �� ���� ��� ��������), 
			�� ������ ������� �����/������ ������ ����������� ����� ���������� ������? 
			��������, �������� ��������� �������� ���/������ (������������ ������ ��� �������� ��������), ��������� ��������� � ������ ����������, 
			���������� � ������� ������������ ������������� ������ ������, ���������� ���� ������ ��� ��������� ������ �������. 
			�� ����� �������, ��� �������� �������� � ������� �����/������.

		275: ASYNC_NETWORK_IO
			����� SQL Server ����, ���� ������ �������� �������� ������. 
			������� ����� ���� � ���, ��� ������ �������� ������� ������� ���������� ������ ��� ������ �������� �� ������� �������� ��-�� ������� ���� � � ����� ������� �� �� �����, 
			����� �������� ����������� � ����. 
			������� ����� ������ �� ����� ������ �� ��� � ��� ���������� RBAR ��� ������� �� ������������� �������(Row-By-Agonizing-Row) � ������ ����, 
			����� ������������ ������ �� ������� � ��������� SQL Server �� ��������� ������ ����������.

		112: WRITELOG
			���������� ���������� ����� ������� ������ ���� �� ����. 
			��� �������, ��������, ��� ������� �����/����� �� ����� ���������� ������������� ������ ����� ������ ����, 
			�� �� ����������������� �������� ��� ����� ���� ������� ������ ������������� ������ ����, ��� ����� ��������, 
			��� ��� ������� ��������� �������� ����� ����������� ������, ��� ���� ������� ���� ���������� ���� ����� �������, 
			����� ��������� ���������� ������� ���� �� ����. ��� ����, ����� ���������, ��� ������� � ������� �����/������, 
			����������� DMV sys.dm_io_virtual_file_stats ��� ����, ����� ������� �������� �����/������ ��� ����� ���� � �������, 
			��������� �� ��� � �������� �������� WRITELOG. ���� WRITELOG ������ ������, �� �������� ���������� ����������� �� ������ �� ���� � ������ ��������� ��������. 
			���� ���, ���������, ������ �� �������� ����� ������� ��� ����������. 
			����� (https://sqlperformance.com/2012/12/io-subsystem/trimming-t-log-fat) 
			� ����� (https://sqlperformance.com/2013/01/io-subsystem/trimming-more-transaction-log-fat) ����� ���������� ��������� ����.
			(���� �����������: ��������� ������ ��������� � ������� � ������� ���� �������� ���������� �������� �����/������ ��� ������� ����� ������ ���� ������ �� �������:
				-- �����: ��.�������� ����� �������� > 20 ����
				USE master
				GO
				SELECT cast(db_name(a.database_id) AS VARCHAR) AS Database_Name
					 , b.physical_name
					 --, a.io_stall
					 , a.size_on_disk_bytes
					 , a.io_stall_read_ms / a.num_of_reads '��.�������� ����� �������� ������'
					 , a.io_stall_write_ms / a.num_of_writes '��.�������� ����� �������� ������'
					 --, *
				FROM
					sys.dm_io_virtual_file_stats(NULL, NULL) a
					INNER JOIN sys.master_files b
						ON a.database_id = b.database_id AND a.file_id = b.file_id
				where num_of_writes > 0 and num_of_reads > 0
				ORDER BY
					Database_Name
				  , a.io_stall DESC

		109: BROKER_RECEIVE_WAITFOR
			����� Service Broker ���� ����� ���������. 
			� �� ������������ �������� ��� �������� � ������ ����������� � ������ ��������� ������ �� ����������� ��������.

		086: MSQL_XP
			����� SQL Server ���� ���������� ����������� �������� ��������. 
			��� ����� �������� ������� ������� � ���� ����� ����������� �������� ��������.

		074: OLEDB
			��� � �������������� �� ��������, ��� �������� �������������� � �������������� OLEDB � ��������, �� ��������� ��������. 
			������, OLEDB ����� ������������ � DMV � �������� DBCC CHECKDB, ��� ��� �� �������, 
			��� �������� ����������� � ��������� �������� � ��� ����� ���� ������� ������� �����������, ��������� ������������ ������ DMV. 
			���� ��� � � ����� ���� ��������� ������ � ����� ��������� ������ �������� �� ��������� ������� � ����������, � ��� �������� � ������������������� �� ���.

		054: BACKUPIO
			����������, ����� �� ������� ����� �������� �� �����, ��� ������� ��������. 
			� �� ��������� ������������� ��� ��������. 
			(����. �����������: � ���������� � ���� ����� �������� ��� ������ ������ �� ����, ��� ���� ����� ��������� ���� ���������� ����� �����, 
			�� ������� ����������� � ��������������� ������� � ������� �������� � ������������������� � �������������. 
			���� ��� ��� ������, �������� ���� � ������� �����/������, ������������ ��� �������������, 
			���������� ����������� ����������� ���������� �� ������������������ ���� ������������ ���� ������������ 
			(�� ��������� ������ ������ � �������� ��������������� ��������, ������� �� �����������������))

		041: LCK_M_XX
			����� ����� ������ ���� ������� ��� ��������� ���������� �� ������ � �������� �������� � ������������. 
			��� ����� ���� ������� ������������� ���������� ���������� ��� ������ �����, �� ����� ����� ���� ������� ���, 
			��� �������� �����/������ �������� ������� ������ ����� � ������ ���������� ������, ��� ������. 
			���������� �� �������, ��������� � ������������, ��������� DMV sys.dm_os_waiting_tasks. 
			�� ����� �������, ��� �������� �������� � �����������.

		032: ONDEMAND_TASK_QUEUE
			��� ��������� � �������� ������ ������� ������� ����� (����� ��� ���������� �����, ������� � ����). 
			� �� ������� ��� �������� � ������ ����������� � ������ �������� ������ �� ����������� ��������.

		031: BACKUPBUFFER
			����������, ����� �� ������� ����� �������� �� �����, ��� ������� ��������. 
			� �� ��������� ������������� ��� ��������.

		027: IO_COMPLETION
			SQL Server ���� ���������� �����/������ � ���� ��� �������� ����� ���� ����������� �������� � �������� �����/������.

		024: SOS_SCHEDULER_YIELD
			���� ����� ��� ���, ������� �� �������� � ������ ���� ��������, �� ������ ��� ����� ���� ����������� � ����������� ����������.

		022: DBMIRROR_EVENTS_QUEUE
		022: DBMIRRORING_CMD
			��� ��� ���� ����������, ��� ������� ���������� ���������� ������������ (database mirroring) ����� � ����, ��� �� �� ��������. 
			� �� ������� ��� �������� � ������ ����������� � ������ �������� ������ �� ����������� ��������.

		018: PAGELATCH_XX
			��� ����������� �� ������ � ������ ������� � ������. 
			�������� ��������� ������ � ��� ����������� PFS, SGAM, � GAM, ����������� � ���� tempdb 
			��� ������������ ����� �������� (https://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-1230-tempdb-should-always-have-one-data-file-per-processor-core/). 
			��� ����, ����� ��������, �� ����� �������� ���� �����������, ��� ����� ������������ DMV sys.dm_os_waiting_tasks ��� ����, 
			����� ��������, ��-�� ����� ������� ��������� ����������. 
			�� ��������� � ����� tempdb ������ ����� (��� ���� http://www.sqlservercentral.com/blogs/robert_davis/) ������� ������� ������, ������������, 
			��� �� ������ (http://www.sqlservercentral.com/blogs/robert_davis/2010/03/05/Breaking-Down-TempDB-Contention/).
			������ ������ �������, ������� � ����� � ����� ����������� ������ � �������������� ��������� � ������, ������������ ���������������� ���� (IDENTITY).

		016: LATCH_XX
			��� ����������� �� ����� ���� �� ���������� ��������� � SQL Server'� � ��� ��� ��� �� ������� � ������/������� � ������� ������. 
			������� ������ ���� �������� ����� ���� ���������� ������ ������ � ��� ���������� ������������ DMV sys.dm_os_latch_stats.

		013: PREEMPTIVE_OS_PIPEOPS
			����� SQL Server ������������� � ����� ������������ ������������ ��� ����, ����� ��������� � ���-�� Windows. 
			���� ��� �������� ��� �������� � 2008 ������ � ��� �� ��� ��������������. 
			����� ������� ������ ��������, ��� �� �������� � ��� ������ ��������� PREEMPTIVE_OS_ � �������� ��, ��� ��������, � MSDN � ��� ����� �������� API Windows.

		013: THREADPOOL
			����� ��� �������, ��� ������������ ������� ������� � ������� ��� ����, ����� ������������� ������. 
			������ ������� � ������� ���������� ������ ����������������� ��������, ���������� �����������. 
			(����. �����������: ����� ��� ����� ���� ��������� ��������� �������� ��������� ������� �max worker threads�)

		009: BROKER_TRANSMITTER
			����� Service Broker ���� ����� ��������� ��� ��������. 
			� �� ������������ �������� ��� �������� � ������ ����������� � ������ ��������� ������ �� ����������� ��������.

		006: SQLTRACE_WAIT_ENTRIES
			����� ��������� (trace) SQL Server'�. 
			� �� ������������ �������� ��� �������� � ������ ����������� � ������ ��������� ������ �� ����������� ��������.

		005: DBMIRROR_DBM_MUTEX
			��� ���� �� ������������������� ����� � � ��� ����������� ��������� �� �������� ������, ������� ������� ����� �������� ����������� ����������� (database mirroring). 
			����� ��������, ��� � ��� ������� ����� ������ ����������� �����������.

		005: RESOURCE_SEMAPHORE
			����� ������ ���� ������ ��� ���������� (������, ������������ ��� ��������� ���������� ������� � �����, ��� ����������). 
			��� ����� ���� ���������� ������ ��� ������������ ��������.

		003: PREEMPTIVE_OS_AUTHENTICATIONOPS
		003: PREEMPTIVE_OS_GENERICOPS
			����� SQL Server ������������� � ����� ������������ ������������ ��� ����, ����� ��������� � ���-�� Windows. 
			���� ��� �������� ��� �������� � 2008 ������ � ��� �� ��� ��������������. 
			����� ������� ������ ��������, ��� �� �������� � ��� ������ ��������� PREEMPTIVE_OS_ � �������� ��, ��� ��������, � MSDN � ��� ����� �������� API Windows.

		003: SLEEP_BPOOL_FLUSH
			��� �������� ����� ����� ������� � ��� ��������, ��� ����������� ����� ������������ ���� ��� ����, ����� �������� ���������� ������� �����/������. 
			� �� ������������ �������� ��� �������� � ������ ����������� � ������ ��������� ������ �� ����������� ��������.

		002: MSQL_DQ
			����� SQL Server �������, ���� ���������� �������������� ������. 
			��� ����� �������� �������� � ��������������� ��������� ��� ����� ���� ������ ������.

		002: RESOURCE_SEMAPHORE_QUERY_COMPILE
			����� � ������� ���������� ������� ����� ������������� �������������� ��������, SQL Server ������������ �� ����������. 
			� �� ����� ������ �����������, �� ��� �������� ����� �������� �������� �������������� ���, ��������, ������� ������ ������������� ����������� ������.

		001: DAC_INIT
			� ������� ������ ����� �� ����� � BOL �������, ��� ������� � ������������� ����������������� �����������. 
			� �� ���� �����������, ��� ��� ����� ���� ���������������� ��������� �� ���� ���� �������...

		001: MSSEARCH
			���� ��� �������� ���������� ��� �������������� ���������. 
			���� ��� ���������������� ��������, ��� ����� ��������, ��� ���� ������� ������ ������ ����� ������� �� ���������� �������������� ��������. 
			�� ������ ����������� ����������� �������� ���� ��� �������� � ������ �����������.

		001: PREEMPTIVE_OS_FILEOPS
		001: PREEMPTIVE_OS_LIBRARYOPS
		001: PREEMPTIVE_OS_LOOKUPACCOUNTSID
		001: PREEMPTIVE_OS_QUERYREGISTRY
			����� SQL Server ������������� � ����� ������������ ������������ ��� ����, ����� ��������� � ���-�� Windows. 
			���� ��� �������� ��� �������� � 2008 ������ � ��� �� ��� ��������������. 
			����� ������� ������ ��������, ��� �� �������� � ��� ������ ��������� PREEMPTIVE_OS_ � �������� ��, ��� ��������, � MSDN � ��� ����� �������� API Windows.

		001: SQLTRACE_LOCK
			����� ��������� (trace) SQL Server'�. 
			� �� ������������ �������� ��� �������� � ������ ����������� � ������ ��������� ������ �� ����������� ��������.

		LCK_M_XXX
		http://sqlcom.ru/waitstats-and-waittypes/lck_m_xxx/
		��� �������� ���� SQL Server, ����������� ������������ ������������� ������ � ������� � ���� � �� �� �����. 
		������� ������� ���� �������� ������������ ����������� ������, ������� ������ � ������� ���� ������.
		
		�� Book On-Line:
		LCK_M_BU
		����� �����, ����� ������ ������� ��������� ���������� ��� ��������� ���������� (BU). 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_IS
		����� �����, ����� ������ ������� ��������� ���������� � ���������� ������������� ������� (IS). 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_IU
		����� �����, ����� ������ ������� ��������� ���������� � ���������� ���������� (IU). 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks 
		
		LCK_M_IX
		����� �����, ����� ������ ������� ��������� ���������� � ���������� ������������ ������� (IX). 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_S
		����� �����, ����� ������ ������� ��������� ����������� ����������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_SCH_M
		����� �����, ����� ������ ������� ��������� ���������� �� ��������� �����. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_SCH_S
		����� �����, ����� ������ ������� ��������� ����������� ���������� �����. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_SIU
		����� �����, ����� ������ ������� ��������� ����������� ���������� � ���������� ����������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_SIX
		����� �����, ����� ������ ������� ��������� ����������� ���������� � ���������� ������������ �������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks 
		
		LCK_M_U
		����� �����, ����� ������ ������� ��������� ���������� �� ����������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		LCK_M_UIX
		����� �����, ����� ������ ������� ��������� ���������� �� ���������� � ���������� ������������ �������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks 
		
		LCK_M_X
		����� �����, ����� ������ ������� ��������� ���������� �� ����������� ������. 
		������� ������������� ���������� ��. � ������������� sys.dm_tran_locks
		
		����������:
		
		� ������, ��� ���������� ����� ���� �������� ����� �����. 
		����� ����� ������� ������� ��������� ���������� �� ����� ������, ���������� ���� ��� ��������. 
		�������� ������� ��������� ��������� ���������� ������� � ���, ��� �� ����������� ������ ��� �������� ���������� � ������ �������� ������������ � ����� �������. 
		��� ��� �������� ��������, ��� ������� �� �������� ��� ������ � ������ ������.

		�� ������ ������������ ��������� ������, ����� ���������� ����������

		EXEC sp_who2
		������� ������ ����� ��������������� �������-[srv].[vBlockingQuery]
		DMV � sys.dm_tran_locks
		DMV � sys.dm_os_waiting_tasks
		���������� LCK_M_XXX:
		
		��������� ������ ����������, ������������ ������� �� �� ����� ������
		������� �������� Serialization ����� ��������� ���� ��� ��������. 
		����������� ������� �������� SQL Server � �Read Committed�
		���� �� ���� �������� ����� ���� ������ � ������� ������ �������� �Read Uncommitted�. 
		� ������������ �� ���������� ����� �������, ��� ��� ����� ����� ����� �������� ������ � ���� ������
		������� ��������������� �������, ������� ������ ��� ���������� � ��������� ��
		��������������� ����� ���� ���������� ��������
		��������� ��� �� ������� � ������� � IO ����������
		��������� ������ ����� � ������� ��������� ��������� ������������������ (Perfomance Monitor):
		
		SQLServer: Memory Manager\Memory Grants Pending (���������� �������� ����� ��� 0-2 ��������������� � ��������)
		SQLServer: Memory Manager\Memory Grants Outstanding
		SQLServer: Buffer Manager\Buffer Hit Cache Ratio (��� ������, ��� �����. ������ �������� ����� ��������� 90%)
		SQLServer: Buffer Manager\Page Life Expectancy (�����, ����� ���� 300)
		Memory: Available Mbytes
		Memory: Page Faults/sec
		Memory: Pages/sec
		��������� ���� ����� � �������:
		
		Average Disk sec/Read (���������� �������� ����� ��� 4-8 �� ��������������� � ��������)
		Average Disk sec/Write (���������� �������� ����� ��� 4-8 �� ��������������� � ��������)
		Average Disk Read/Write Queue Length
		�������: �������������� ��� ���������� �������� ������ ���� ������. 
		� ����������, ����� �� ������ Books On-Line. 
		��� ��� ���������� �������� ����� ����� ����� �������� � ���������� �� ������� � �������. 
		� ���������� ������� ����������� �� �� ������� ����������, ������ ��� ��������� ��� �� ������� �������.

		ASYNC_IO_COMPLETION
		http://sqlcom.ru/waitstats-and-waittypes/async_io_completion/

		��� ����� ������� ������� ���� 3 ������ ����: ���������, ����, ������. 
		�� ���� ���, ���� �������� �������� ��������� ��� SQL Server. 
		������ �� ������ �� ��������� ����, � �� ���� �����, ������� �������� ���������� ��� ������ �����, ������ ����� �������� ���������� ����� 
		(���������� ��������� ������������, ���������� �����������). 
		������� �� ���������� ��� ���� ��������, ������� ��������� � �����.

		�� Book On-Line:
		����� �����, ����� ��� ������ ���������� ������ ������� �����-������.
		
		����������:
		����� ������� ������� ���������� I/O. 
		���� SQL Server ����� �������� ������������ ������ � ������� ������� ��, �� ������� ASYNC_IO_COMPLETION ����� �������������. 
		��� �� ��� �������� ������������� Backup, ��������� � ��������������� ��� ������.
		
		���������� ASYNC_IO_COMPLETION ��������:
		
		1. ���������� �� ��� � ������� ��� �� ����������� �������, �� ����������� ���������� ��
		2. ���������� �������, �� ������ ������, ���������� ����� �������� (LDF) � ����� ������ (MDF), 
			Tempdb �� ������ ��������� �����, ����� ������������ ������� � ������ �������� ������� � �� ������ ������.
		3. ��������� ���������� ������������� ������ ��� ������, �������� �������� �� IO Read Stall � IO Write Stall (fn_virtualfilestats)
		4. ��������� ���� ����� �� ������� ������ �����
		5. ���� �� ����������� SAN (������� ��������� ������), �� ���������� ��������� ��������� �������� HBA Queue Depth, �������� � ������� ����� � ���������
		6. ��������� ������� ������ ��������
		7. ��������� ��������� ��������� ��������� Perfomance Monitor
		SQLServer: Memory Manager\Memory Grants Pending (���������� �������� ����� ��� 0-2 ��������������� � ��������)
		SQLServer: Memory Manager\Memory Grants Outstanding
		SQLServer: Buffer Manager\Buffer Hit Cache Ratio (��� ������, ��� �����. ������ �������� ����� ��������� 90%)
		SQLServer: Buffer Manager\Page Life Expectancy (�����, ����� ���� 300)
		Memory: Available Mbytes
		Memory: Page Faults/sec
		Memory: Pages/sec
		Average Disk sec/Read (���������� �������� ����� ��� 4-8 �� ��������������� � ��������)
		Average Disk sec/Write (���������� �������� ����� ��� 4-8 �� ��������������� � ��������)
		Average Disk Read/Write Queue Length
*/
WITH [Waits] AS
    (SELECT
        [wait_type], --��� ���� ��������
        [wait_time_ms] / 1000.0 AS [WaitS],--����� ����� �������� ������� ���� � �������������. ��� ����� �������� signal_wait_time_ms
        ([wait_time_ms] - [signal_wait_time_ms]) / 1000.0 AS [ResourceS],--����� ����� �������� ������� ���� � ������������� ��� signal_wait_time_ms
        [signal_wait_time_ms] / 1000.0 AS [SignalS],--������� ����� �������� ������������ ���������� ������ � �������� ������ ��� ����������
        [waiting_tasks_count] AS [WaitCount],--����� �������� ������� ����. ���� ������� ������������ ������ ��� ��� ������ ��������
        100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER() AS [Percentage],
        ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC) AS [RowNum]
    FROM sys.dm_os_wait_stats
    WHERE [waiting_tasks_count]>0
		and [wait_type] NOT IN (
        N'BROKER_EVENTHANDLER',         N'BROKER_RECEIVE_WAITFOR',
        N'BROKER_TASK_STOP',            N'BROKER_TO_FLUSH',
        N'BROKER_TRANSMITTER',          N'CHECKPOINT_QUEUE',
        N'CHKPT',                       N'CLR_AUTO_EVENT',
        N'CLR_MANUAL_EVENT',            N'CLR_SEMAPHORE',
        N'DBMIRROR_DBM_EVENT',          N'DBMIRROR_EVENTS_QUEUE',
        N'DBMIRROR_WORKER_QUEUE',       N'DBMIRRORING_CMD',
        N'DIRTY_PAGE_POLL',             N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC',                    N'FSAGENT',
        N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
        N'HADR_CLUSAPI_CALL',           N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
        N'HADR_LOGCAPTURE_WAIT',        N'HADR_NOTIFICATION_DEQUEUE',
        N'HADR_TIMER_TASK',             N'HADR_WORK_QUEUE',
        N'KSOURCE_WAKEUP',              N'LAZYWRITER_SLEEP',
        N'LOGMGR_QUEUE',                N'ONDEMAND_TASK_QUEUE',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED',
        N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP',
        N'REQUEST_FOR_DEADLOCK_SEARCH', N'RESOURCE_QUEUE',
        N'SERVER_IDLE_CHECK',           N'SLEEP_BPOOL_FLUSH',
        N'SLEEP_DBSTARTUP',             N'SLEEP_DCOMSTARTUP',
        N'SLEEP_MASTERDBREADY',         N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED',        N'SLEEP_MSDBSTARTUP',
        N'SLEEP_SYSTEMTASK',            N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP',         N'SNI_HTTP_ACCEPT',
        N'SP_SERVER_DIAGNOSTICS_SLEEP', N'SQLTRACE_BUFFER_FLUSH',
        N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
        N'SQLTRACE_WAIT_ENTRIES',       N'WAIT_FOR_RESULTS',
        N'WAITFOR',                     N'WAITFOR_TASKSHUTDOWN',
        N'WAIT_XTP_HOST_WAIT',          N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG',
        N'WAIT_XTP_CKPT_CLOSE',         N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT',          N'XE_TIMER_EVENT')
    )
, ress as (
	SELECT
	    [W1].[wait_type] AS [WaitType],
	    CAST ([W1].[WaitS] AS DECIMAL (16, 2)) AS [Wait_S],--����� ����� �������� ������� ���� � �������������. ��� ����� �������� signal_wait_time_ms
	    CAST ([W1].[ResourceS] AS DECIMAL (16, 2)) AS [Resource_S],--����� ����� �������� ������� ���� � ������������� ��� signal_wait_time_ms
	    CAST ([W1].[SignalS] AS DECIMAL (16, 2)) AS [Signal_S],--������� ����� �������� ������������ ���������� ������ � �������� ������ ��� ����������
	    [W1].[WaitCount] AS [WaitCount],--����� �������� ������� ����. ���� ������� ������������ ������ ��� ��� ������ ��������
	    CAST ([W1].[Percentage] AS DECIMAL (5, 2)) AS [Percentage],
	    CAST (([W1].[WaitS] / [W1].[WaitCount]) AS DECIMAL (16, 4)) AS [AvgWait_S],
	    CAST (([W1].[ResourceS] / [W1].[WaitCount]) AS DECIMAL (16, 4)) AS [AvgRes_S],
	    CAST (([W1].[SignalS] / [W1].[WaitCount]) AS DECIMAL (16, 4)) AS [AvgSig_S]
	FROM [Waits] AS [W1]
	INNER JOIN [Waits] AS [W2]
	    ON [W2].[RowNum] <= [W1].[RowNum]
	GROUP BY [W1].[RowNum], [W1].[wait_type], [W1].[WaitS],
	    [W1].[ResourceS], [W1].[SignalS], [W1].[WaitCount], [W1].[Percentage]
	HAVING SUM ([W2].[Percentage]) - [W1].[Percentage] < 95 -- percentage threshold
)
SELECT [WaitType]
      ,MAX([Wait_S]) as [Wait_S]
      ,MAX([Resource_S]) as [Resource_S]
      ,MAX([Signal_S]) as [Signal_S]
      ,MAX([WaitCount]) as [WaitCount]
      ,MAX([Percentage]) as [Percentage]
      ,MAX([AvgWait_S]) as [AvgWait_S]
      ,MAX([AvgRes_S]) as [AvgRes_S]
      ,MAX([AvgSig_S]) as [AvgSig_S]
  FROM ress
  group by [WaitType]





GO
/****** Object:  View [srv].[vDelIndexInclude]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [srv].[vDelIndexInclude] as
/*
  ��������� �.�.
  ����� ���������������(������) ��������.
  ���� ���� ������� ������������� ����� ������� �������� � ��� �� ������� ���������� ����� ������� � ������� ����, �� 
  ���� ������ ��������� ������, ��� ��� ������� ����� ������������ ����� ������� ������.

  http://www.sql.ru/blogs/andraptor/1218
*/
WITH cte_index_info AS (
SELECT
tSS.[name] AS [SchemaName]
,tSO.[name] AS [ObjectName]
,tSO.[type_desc] AS [ObjectType]
,tSO.[create_date] AS [ObjectCreateDate]
,tSI.[name] AS [IndexName]
,tSI.[is_primary_key] AS [IndexIsPrimaryKey]
,d.[index_type_desc] AS [IndexType]
,d.[avg_fragmentation_in_percent] AS [IndexFragmentation]
,d.[fragment_count] AS [IndexFragmentCount]
,d.[avg_fragment_size_in_pages] AS [IndexAvgFragmentSizeInPages]
,d.[page_count] AS [IndexPages]
,c.key_columns AS [IndexKeyColumns]
,COALESCE(ic.included_columns, '') AS [IndexIncludedColumns]
,tSI.is_unique_constraint
FROM
(
SELECT
tSDDIPS.[object_id] AS [object_id]
,tSDDIPS.[index_id] AS [index_id]
,tSDDIPS.[index_type_desc] AS [index_type_desc]
,MAX(tSDDIPS.[avg_fragmentation_in_percent]) AS [avg_fragmentation_in_percent]
,MAX(tSDDIPS.[fragment_count]) AS [fragment_count]
,MAX(tSDDIPS.[avg_fragment_size_in_pages]) AS [avg_fragment_size_in_pages]
,MAX(tSDDIPS.[page_count]) AS [page_count]
FROM
[sys].[dm_db_index_physical_stats] (DB_ID(), NULL, NULL , NULL, N'LIMITED') tSDDIPS
GROUP BY
tSDDIPS.[object_id]
,tSDDIPS.[index_id]
,tSDDIPS.[index_type_desc]
) d
INNER JOIN [sys].[indexes] tSI ON
tSI.[object_id] = d.[object_id]
AND tSI.[index_id] = d.[index_id]
INNER JOIN [sys].[objects] tSO ON
tSO.[object_id] = d.[object_id]
INNER JOIN [sys].[schemas] tSS ON
tSS.[schema_id] = tSO.[schema_id]
CROSS APPLY (
SELECT
STUFF((
SELECT
', ' + c.[name] +
CASE ic.[is_descending_key]
WHEN 1 THEN
'(-)'
ELSE
''
END
FROM
[sys].[index_columns] ic
INNER JOIN [sys].[columns] c ON
c.[object_id] = ic.[object_id]
and c.[column_id] = ic.[column_id]
WHERE
ic.[index_id] = tSI.[index_id]
AND ic.[object_id] = tSI.[object_id]
AND ic.[is_included_column] = 0
ORDER BY
ic.[key_ordinal]
FOR XML
PATH('')
)
,1, 2, ''
) AS [key_columns]
) c
CROSS APPLY (
SELECT
STUFF((
SELECT
', ' + c.[name]
FROM
[sys].[index_columns] ic
INNER JOIN [sys].[columns] c ON
c.[object_id] = ic.[object_id]
AND c.[column_id] = ic.[column_id]
WHERE
ic.[index_id] = tSI.[index_id]
AND ic.[object_id] = tSI.[object_id]
AND ic.[is_included_column] = 1
FOR XML
PATH('')
)
,1, 2, ''
) AS [included_columns]
) ic
WHERE
tSO.[type_desc] IN (
N'USER_TABLE'
)
AND OBJECTPROPERTY(tSO.[object_id], N'IsMSShipped') = 0
AND d.[index_type_desc] NOT IN (
'HEAP'
)
)
SELECT
t1.[SchemaName]
,t1.[ObjectName]
,t1.[ObjectType]
,t1.[ObjectCreateDate]
,t1.[IndexName] as [DelIndexName]
,t1.[IndexIsPrimaryKey]
,t1.[IndexType]
,t1.[IndexFragmentation]
,t1.[IndexFragmentCount]
,t1.[IndexAvgFragmentSizeInPages]
,t1.[IndexPages]
,t1.[IndexKeyColumns]
,t1.[IndexIncludedColumns]
,t2.[IndexName] as [ActualIndexName]
FROM
cte_index_info t1
INNER JOIN cte_index_info t2 ON
t2.[SchemaName] = t1.[SchemaName]
AND t2.[ObjectName] = t1.[ObjectName]
AND t2.[IndexName] <> t1.[IndexName]
AND PATINDEX(REPLACE(t1.[IndexKeyColumns], '_', '[_]') + ',%', t2.[IndexKeyColumns] + ',') > 0
WHERE
t1.[IndexIncludedColumns] = '' -- don't check indexes with INCLUDE columns
AND t1.[IndexIsPrimaryKey] = 0 -- don't check primary keys
AND t1.is_unique_constraint=0  -- don't check unique constraint
AND t1.[IndexType] NOT IN (
N'CLUSTERED INDEX'
,N'UNIQUE CLUSTERED INDEX'
) -- don't check clustered indexes
GO
/****** Object:  View [srv].[vStatisticsIOInTempDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [srv].[vStatisticsIOInTempDB] as
/*
	���� ����� ������ ������ (avg_write_stall_ms) ������ 5 ��, �� ��� ������ ������� ������� ������������������. 
	����� 5 � 10 ��  � ���������� �������. 
	����� 10 �� � ������ ������������������, ���������� ������� ��������� ������, ������� �������� � ������-������� ��� ��������� ���� ������
	https://minyurov.com/2016/07/24/mssql-tempdb-opt/
*/
SELECT files.physical_name, files.name,
stats.num_of_writes, (1.0 * stats.io_stall_write_ms / stats.num_of_writes) AS avg_write_stall_ms,
stats.num_of_reads, (1.0 * stats.io_stall_read_ms / stats.num_of_reads) AS avg_read_stall_ms
FROM sys.dm_io_virtual_file_stats(2, NULL) as stats
INNER JOIN master.sys.master_files AS files 
ON stats.database_id = files.database_id
AND stats.file_id = files.file_id
WHERE files.type_desc = 'ROWS'
GO
/****** Object:  Table [dbo].[AuditQuery]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditQuery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TSQL] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AuditQuery] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TEST]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEST](
	[TEST_GUID] [uniqueidentifier] NOT NULL,
	[IDENT] [bigint] IDENTITY(1,1) NOT NULL,
	[Field_Name] [nvarchar](255) NULL,
	[Field_Value] [nvarchar](255) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TEST] PRIMARY KEY CLUSTERED 
(
	[TEST_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[ddl_log]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ddl_log](
	[DDL_Log_GUID] [uniqueidentifier] NOT NULL,
	[PostTime] [datetime] NOT NULL,
	[DB_Login] [nvarchar](255) NULL,
	[DB_User] [nvarchar](255) NULL,
	[Event] [nvarchar](255) NULL,
	[TSQL] [nvarchar](max) NULL,
 CONSTRAINT [PK_ddl_log] PRIMARY KEY CLUSTERED 
(
	[DDL_Log_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[ddl_log_all]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ddl_log_all](
	[DDL_Log_GUID] [uniqueidentifier] NOT NULL,
	[Server_Name] [nvarchar](255) NOT NULL,
	[DB_Name] [nvarchar](255) NOT NULL,
	[PostTime] [datetime] NOT NULL,
	[DB_Login] [nvarchar](255) NULL,
	[DB_User] [nvarchar](255) NULL,
	[Event] [nvarchar](255) NULL,
	[TSQL] [nvarchar](max) NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ddl_log_all] PRIMARY KEY CLUSTERED 
(
	[DDL_Log_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[Deadlocks]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[Deadlocks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Server] [nvarchar](20) NULL,
	[NumberDeadlocks] [int] NULL,
	[InsertDate] [datetime] NULL,
 CONSTRAINT [PK_Deadlocks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[DefragRun]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[DefragRun](
	[Run] [bit] NOT NULL,
	[UpdateUTCDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[ErrorInfo]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ErrorInfo](
	[ErrorInfo_GUID] [uniqueidentifier] NOT NULL,
	[ERROR_TITLE] [nvarchar](max) NULL,
	[ERROR_PRED_MESSAGE] [nvarchar](max) NULL,
	[ERROR_NUMBER] [nvarchar](max) NULL,
	[ERROR_MESSAGE] [nvarchar](max) NULL,
	[ERROR_LINE] [nvarchar](max) NULL,
	[ERROR_PROCEDURE] [nvarchar](max) NULL,
	[ERROR_POST_MESSAGE] [nvarchar](max) NULL,
	[RECIPIENTS] [nvarchar](max) NULL,
	[InsertDate] [datetime] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NOT NULL,
	[Count] [int] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[IsRealTime] [bit] NOT NULL,
	[InsertUTCDate] [datetime] NULL,
 CONSTRAINT [PK_ErrorInfo] PRIMARY KEY CLUSTERED 
(
	[ErrorInfo_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[ErrorInfoArchive]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ErrorInfoArchive](
	[ErrorInfo_GUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ERROR_TITLE] [nvarchar](max) NULL,
	[ERROR_PRED_MESSAGE] [nvarchar](max) NULL,
	[ERROR_NUMBER] [nvarchar](max) NULL,
	[ERROR_MESSAGE] [nvarchar](max) NULL,
	[ERROR_LINE] [nvarchar](max) NULL,
	[ERROR_PROCEDURE] [nvarchar](max) NULL,
	[ERROR_POST_MESSAGE] [nvarchar](max) NULL,
	[RECIPIENTS] [nvarchar](max) NULL,
	[InsertDate] [datetime] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NOT NULL,
	[Count] [int] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[IsRealTime] [bit] NOT NULL,
	[InsertUTCDate] [datetime] NULL,
 CONSTRAINT [PK_ArchiveErrorInfo] PRIMARY KEY CLUSTERED 
(
	[ErrorInfo_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[KillSession]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[KillSession](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[session_id] [smallint] NOT NULL,
	[transaction_id] [bigint] NOT NULL,
	[login_time] [datetime] NOT NULL,
	[host_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[host_process_id] [int] NULL,
	[client_version] [int] NULL,
	[client_interface_name] [nvarchar](32) NULL,
	[security_id] [varbinary](85) NOT NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[nt_domain] [nvarchar](128) NULL,
	[nt_user_name] [nvarchar](128) NULL,
	[status] [nvarchar](30) NOT NULL,
	[context_info] [varbinary](128) NULL,
	[cpu_time] [int] NOT NULL,
	[memory_usage] [int] NOT NULL,
	[total_scheduled_time] [int] NOT NULL,
	[total_elapsed_time] [int] NOT NULL,
	[endpoint_id] [int] NOT NULL,
	[last_request_start_time] [datetime] NOT NULL,
	[last_request_end_time] [datetime] NULL,
	[reads] [bigint] NOT NULL,
	[writes] [bigint] NOT NULL,
	[logical_reads] [bigint] NOT NULL,
	[is_user_process] [bit] NOT NULL,
	[text_size] [int] NOT NULL,
	[language] [nvarchar](128) NULL,
	[date_format] [nvarchar](3) NULL,
	[date_first] [smallint] NOT NULL,
	[quoted_identifier] [bit] NOT NULL,
	[arithabort] [bit] NOT NULL,
	[ansi_null_dflt_on] [bit] NOT NULL,
	[ansi_defaults] [bit] NOT NULL,
	[ansi_warnings] [bit] NOT NULL,
	[ansi_padding] [bit] NOT NULL,
	[ansi_nulls] [bit] NOT NULL,
	[concat_null_yields_null] [bit] NOT NULL,
	[transaction_isolation_level] [smallint] NOT NULL,
	[lock_timeout] [int] NOT NULL,
	[deadlock_priority] [int] NOT NULL,
	[row_count] [bigint] NOT NULL,
	[prev_error] [int] NOT NULL,
	[original_security_id] [varbinary](85) NOT NULL,
	[original_login_name] [nvarchar](128) NOT NULL,
	[last_successful_logon] [datetime] NULL,
	[last_unsuccessful_logon] [datetime] NULL,
	[unsuccessful_logons] [bigint] NULL,
	[group_id] [int] NOT NULL,
	[database_id] [smallint] NOT NULL,
	[authenticating_database_id] [int] NULL,
	[open_transaction_count] [int] NOT NULL,
	[most_recent_session_id] [int] NULL,
	[connect_time] [datetime] NULL,
	[net_transport] [nvarchar](40) NULL,
	[protocol_type] [nvarchar](40) NULL,
	[protocol_version] [int] NULL,
	[encrypt_option] [nvarchar](40) NULL,
	[auth_scheme] [nvarchar](40) NULL,
	[node_affinity] [smallint] NULL,
	[num_reads] [int] NULL,
	[num_writes] [int] NULL,
	[last_read] [datetime] NULL,
	[last_write] [datetime] NULL,
	[net_packet_size] [int] NULL,
	[client_net_address] [nvarchar](48) NULL,
	[client_tcp_port] [int] NULL,
	[local_net_address] [nvarchar](48) NULL,
	[local_tcp_port] [int] NULL,
	[connection_id] [uniqueidentifier] NULL,
	[parent_connection_id] [uniqueidentifier] NULL,
	[most_recent_sql_handle] [varbinary](64) NULL,
	[LastTSQL] [nvarchar](max) NULL,
	[transaction_begin_time] [datetime] NOT NULL,
	[CountTranNotRequest] [tinyint] NOT NULL,
	[CountSessionNotRequest] [tinyint] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_KillSession] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [srv].[ListDefragIndex]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ListDefragIndex](
	[db] [nvarchar](100) NOT NULL,
	[shema] [nvarchar](100) NOT NULL,
	[table] [nvarchar](100) NOT NULL,
	[IndexName] [nvarchar](100) NOT NULL,
	[object_id] [int] NOT NULL,
	[idx] [int] NOT NULL,
	[db_id] [int] NOT NULL,
	[frag] [decimal](6, 2) NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ListDefragIndex] PRIMARY KEY CLUSTERED 
(
	[object_id] ASC,
	[idx] ASC,
	[db_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[RestoreSettingsDetail]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[RestoreSettingsDetail](
	[Row_GUID] [uniqueidentifier] NOT NULL,
	[DBName] [nvarchar](255) NOT NULL,
	[SourcePathRestore] [nvarchar](255) NOT NULL,
	[TargetPathRestore] [nvarchar](255) NOT NULL,
	[Ext] [nvarchar](255) NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RestoreSettingsDetail_1] PRIMARY KEY CLUSTERED 
(
	[Row_GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[SessionTran]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[SessionTran](
	[SessionID] [int] NOT NULL,
	[TransactionID] [bigint] NOT NULL,
	[CountTranNotRequest] [tinyint] NOT NULL,
	[CountSessionNotRequest] [tinyint] NOT NULL,
	[TransactionBeginTime] [datetime] NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[UpdateUTCDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SessionTran] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [srv].[ShortInfoRunJobs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [srv].[ShortInfoRunJobs](
	[Job_GUID] [uniqueidentifier] NOT NULL,
	[Job_Name] [nvarchar](255) NOT NULL,
	[LastFinishRunState] [nvarchar](255) NULL,
	[LastDateTime] [datetime] NOT NULL,
	[LastRunDurationString] [nvarchar](255) NULL,
	[LastRunDurationInt] [int] NULL,
	[LastOutcomeMessage] [nvarchar](255) NULL,
	[LastRunOutcome] [tinyint] NOT NULL,
	[Server] [nvarchar](255) NOT NULL,
	[InsertUTCDate] [datetime] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ShortInfoRunJobs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [dbo].[TEST]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ActiveConnectionStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indSession]    Script Date: 07.03.2018 11:22:33 ******/
CREATE UNIQUE NONCLUSTERED INDEX [indSession] ON [srv].[ActiveConnectionStatistics]
(
	[ServerName] ASC,
	[SessionID] ASC,
	[LoginName] ASC,
	[DBName] ASC,
	[LoginTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[BackupSettings]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_DBFile]    Script Date: 07.03.2018 11:22:33 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DBFile] ON [srv].[DBFile]
(
	[DB_ID] ASC,
	[File_ID] ASC,
	[Server] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ddl_log_all]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertDate] ON [srv].[Deadlocks]
(
	[InsertDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[Defrag]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IndMain]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [IndMain] ON [srv].[Defrag]
(
	[db] ASC,
	[shema] ASC,
	[table] ASC,
	[IndexName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[Drivers]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ErrorInfo]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ErrorInfoArchive]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[KillSession]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ListDefragIndex]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[PlanQuery]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[QueryStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indPlanQuery]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indPlanQuery] ON [srv].[QueryStatistics]
(
	[plan_handle] ASC,
	[sql_handle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[Recipient]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[RequestStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indPlanQuery]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indPlanQuery] ON [srv].[RequestStatistics]
(
	[sql_handle] ASC,
	[plan_handle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[RequestStatisticsArchive]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [indPlanQuery]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indPlanQuery] ON [srv].[RequestStatisticsArchive]
(
	[plan_handle] ASC,
	[sql_handle] ASC
)
WHERE ([sql_handle] IS NOT NULL AND [plan_handle] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[RestoreSettings]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ServerDBFileInfoStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[SessionTran]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[ShortInfoRunJobs]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[SQLQuery]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[TableIndexStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indInsertUTCDate]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indInsertUTCDate] ON [srv].[TableStatistics]
(
	[InsertUTCDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [indDATE]    Script Date: 07.03.2018 11:22:33 ******/
CREATE NONCLUSTERED INDEX [indDATE] ON [srv].[TSQL_DAY_Statistics]
(
	[DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TEST] ADD  CONSTRAINT [DF_TEST_TEST_GUID]  DEFAULT (newid()) FOR [TEST_GUID]
GO
ALTER TABLE [dbo].[TEST] ADD  CONSTRAINT [DF_TEST_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[ActiveConnectionStatistics] ADD  CONSTRAINT [DF_ActiveConnectionStatistics_Row_GUID]  DEFAULT (newid()) FOR [Row_GUID]
GO
ALTER TABLE [srv].[ActiveConnectionStatistics] ADD  CONSTRAINT [DF_ActiveConnectionStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[Address] ADD  CONSTRAINT [DF_Address_Address_GUID]  DEFAULT (newsequentialid()) FOR [Address_GUID]
GO
ALTER TABLE [srv].[Address] ADD  CONSTRAINT [DF_Address_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [srv].[Address] ADD  CONSTRAINT [DF_Address_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[BackupSettings] ADD  CONSTRAINT [DF_BackupSettings_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[DBFile] ADD  CONSTRAINT [DF_DBFile_DBFile_GUID]  DEFAULT (newsequentialid()) FOR [DBFile_GUID]
GO
ALTER TABLE [srv].[DBFile] ADD  CONSTRAINT [DF_DBFile_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[DBFile] ADD  CONSTRAINT [DF_DBFile_UpdateUTCdate]  DEFAULT (getutcdate()) FOR [UpdateUTCdate]
GO
ALTER TABLE [srv].[ddl_log] ADD  CONSTRAINT [DF_ddl_log_DDL_Log_GUID]  DEFAULT (newid()) FOR [DDL_Log_GUID]
GO
ALTER TABLE [srv].[ddl_log_all] ADD  CONSTRAINT [DF_ddl_log_all_DDL_Log_GUID]  DEFAULT (newid()) FOR [DDL_Log_GUID]
GO
ALTER TABLE [srv].[ddl_log_all] ADD  CONSTRAINT [DF_ddl_log_all_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[Deadlocks] ADD  CONSTRAINT [DF_Deadlocks_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [srv].[Defrag] ADD  CONSTRAINT [DF_Defrag_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[DefragRun] ADD  CONSTRAINT [DF_DefragRun_Run]  DEFAULT ((0)) FOR [Run]
GO
ALTER TABLE [srv].[DefragRun] ADD  CONSTRAINT [DF_DefragRun_UpdateUTCDate]  DEFAULT (getutcdate()) FOR [UpdateUTCDate]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_Driver_GUID]  DEFAULT (newsequentialid()) FOR [Driver_GUID]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_Server]  DEFAULT (@@servername) FOR [Server]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_TotalSpace]  DEFAULT ((0)) FOR [TotalSpace]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_FreeSpace]  DEFAULT ((0)) FOR [FreeSpace]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_DiffFreeSpace]  DEFAULT ((0)) FOR [DiffFreeSpace]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[Drivers] ADD  CONSTRAINT [DF_Drivers_UpdateUTCdate]  DEFAULT (getutcdate()) FOR [UpdateUTCdate]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_ErrorInfo_GUID]  DEFAULT (newid()) FOR [ErrorInfo_GUID]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_FinishDate]  DEFAULT (getdate()) FOR [FinishDate]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_Count]  DEFAULT ((1)) FOR [Count]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF__ErrorInfo__Updat__5FFEE747]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_IsRealTime]  DEFAULT ((0)) FOR [IsRealTime]
GO
ALTER TABLE [srv].[ErrorInfo] ADD  CONSTRAINT [DF_ErrorInfo_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_ErrorInfo_GUID]  DEFAULT (newsequentialid()) FOR [ErrorInfo_GUID]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ArchiveErrorInfo_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_FinishDate]  DEFAULT (getdate()) FOR [FinishDate]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_Count]  DEFAULT ((1)) FOR [Count]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_IsRealTime]  DEFAULT ((0)) FOR [IsRealTime]
GO
ALTER TABLE [srv].[ErrorInfoArchive] ADD  CONSTRAINT [DF_ErrorInfoArchive_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[KillSession] ADD  CONSTRAINT [DF_KillSession_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[ListDefragIndex] ADD  CONSTRAINT [DF_ListDefragIndex_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[PlanQuery] ADD  CONSTRAINT [DF_PlanQuery_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[QueryRequestGroupStatistics] ADD  CONSTRAINT [DF_QueryRequestGroupStatistics1_DBName]  DEFAULT (newid()) FOR [DBName]
GO
ALTER TABLE [srv].[QueryRequestGroupStatistics] ADD  CONSTRAINT [DF_QueryRequestGroupStatistics1_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[QueryStatistics] ADD  CONSTRAINT [DF_QueryStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[Recipient] ADD  CONSTRAINT [DF_Recipient_Recipient_GUID]  DEFAULT (newsequentialid()) FOR [Recipient_GUID]
GO
ALTER TABLE [srv].[Recipient] ADD  CONSTRAINT [DF_Recipient_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [srv].[Recipient] ADD  CONSTRAINT [DF_Recipient_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[RequestStatistics] ADD  CONSTRAINT [DF_RequestStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[RequestStatistics] ADD  DEFAULT ((0)) FOR [is_blocking_other_session]
GO
ALTER TABLE [srv].[RequestStatisticsArchive] ADD  CONSTRAINT [DF_RequestStatisticsArchive_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[RequestStatisticsArchive] ADD  DEFAULT ((0)) FOR [is_blocking_other_session]
GO
ALTER TABLE [srv].[RestoreSettings] ADD  CONSTRAINT [DF_RestoreSettings_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[RestoreSettingsDetail] ADD  CONSTRAINT [DF_RestoreSettingsDetail_Row_GUID]  DEFAULT (newid()) FOR [Row_GUID]
GO
ALTER TABLE [srv].[RestoreSettingsDetail] ADD  CONSTRAINT [DF_RestoreSettingsDetail_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[ServerDBFileInfoStatistics] ADD  CONSTRAINT [DF_ServerDBFileInfoStatistics_Row_GUID]  DEFAULT (newid()) FOR [Row_GUID]
GO
ALTER TABLE [srv].[ServerDBFileInfoStatistics] ADD  CONSTRAINT [DF_ServerDBFileInfoStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[SessionTran] ADD  CONSTRAINT [DF_SessionTran_Count]  DEFAULT ((0)) FOR [CountTranNotRequest]
GO
ALTER TABLE [srv].[SessionTran] ADD  CONSTRAINT [DF_SessionTran_CountSessionNotRequest]  DEFAULT ((0)) FOR [CountSessionNotRequest]
GO
ALTER TABLE [srv].[SessionTran] ADD  CONSTRAINT [DF_SessionTran_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[SessionTran] ADD  CONSTRAINT [DF_SessionTran_UpdateUTCDate]  DEFAULT (getutcdate()) FOR [UpdateUTCDate]
GO
ALTER TABLE [srv].[ShortInfoRunJobs] ADD  CONSTRAINT [DF_ShortInfoRunJobs_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[SQLQuery] ADD  CONSTRAINT [DF_SQLQuery_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[TableIndexStatistics] ADD  CONSTRAINT [DF_TableIndexStatistics_Row_GUID]  DEFAULT (newid()) FOR [Row_GUID]
GO
ALTER TABLE [srv].[TableIndexStatistics] ADD  CONSTRAINT [DF_TableIndexStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[TableStatistics] ADD  CONSTRAINT [DF_TableStatistics_Row_GUID]  DEFAULT (newid()) FOR [Row_GUID]
GO
ALTER TABLE [srv].[TableStatistics] ADD  CONSTRAINT [DF_TableStatistics_InsertUTCDate]  DEFAULT (getutcdate()) FOR [InsertUTCDate]
GO
ALTER TABLE [srv].[TSQL_DAY_Statistics] ADD  CONSTRAINT [DF_TSQL_DAY_Statistics_DATE]  DEFAULT (getutcdate()) FOR [DATE]
GO
/****** Object:  StoredProcedure [inf].[InfoAgentJobs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [inf].[InfoAgentJobs]
AS
BEGIN
	--����������� ������� �������
	SET NOCOUNT ON;
	
		--���������� ��������� �� ������ ������ ��, ������� ���������:

		--CREATE SCHEMA [inf]
		--GO

		--CREATE SCHEMA [srv]
		--GO
		
		--SET ANSI_NULLS ON
		--GO
		
		--SET QUOTED_IDENTIFIER ON
		--GO
		
		
		--CREATE VIEW [inf].[vCountRows]
				 
		--CREATE VIEW [inf].[vIndexDefrag]
				 
		--CREATE VIEW [inf].[vTableSize]
				 
		--CREATE PROCEDURE [srv].[AutoDefragIndex]
				 
		--CREATE PROCEDURE [srv].[AutoUpdateStatistics]

    /*
		1) syspolicy_purge_history � ������� ������ ���������� ������� � ������������ � ���������� ��������� �������� �������
		2) �������� ������ � ����������� �������� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
				declare @body nvarchar(max);
		        exec [SRV].[srv].[AutoShortInfoRunJobs]
						@second=60
					   ,@body=@body output;
		
				EXEC [msdb].[dbo].[sp_send_dbmail]
				-- ��������� ���� ������� �������������� �������� ��������
					@profile_name = 'profile_name',
				-- ����� ����������
					@recipients = 'Gribkov@mkis.su;',--'Gribkov@mkis.su',
				-- ����� ������
					@body = @body,
				-- ����
					@subject = N'���������� �� ������� ����������',
					@body_format='HTML'--,
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ � ����������� �������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ������ � ����������� ��������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		3) �������� ������ ������ ��� ������ � ����������� ���������:
		USE [SRV];
		go
		
		begin try
				exec [srv].[MergeDBFileInfo];
				--exec [srv].[MergeDriverInfo]; --� ������
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ � ������ � ������ ��� ������ �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ������ � ������ � ������ ��� ������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		4) �������� ������ �� �������� �������� ��� ����������� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[RunRequestGroupStatistics];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ �� �������� �������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ������ �� �������� ��������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		5) �������� ������ �� �������� ������������ � ����������� ������ 10 �����:
		USE [SRV];
		go
		
		begin try
		    exec [srv].[AutoStatisticsActiveConnections];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ �� �������� ������������ �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ������ �� �������� ������������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		6) �������� ������ �� ������������������ ���� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[AutoStatisticsTimeRequests];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ �� ������������������ ���� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ������ �� ������������������ ����';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		7) �������� ���-�� ����� ���������� �������� � ������� ������ � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[InsertTableStatistics];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ���-�� ����� ���������� ��������  � ������ ������ �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ���-�� ����� ���������� �������� � ������� ������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		8) �������� ���������� ����� ������ �� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		    exec [srv].[AutoStatisticsFileDB]
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ���������� ����� ������ �� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ��������� ���������� ����� ������ ��';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		
		9) ������������ �������� ���������� ����������� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[KillFullOldConnect];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'������������ �������� ���������� ����������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ������������ �������� �����������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		10) ������������ ������ ������� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[DeleteArchive];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'������������ ������ ������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ������������ ������ �������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		11) �������������� � ����������� ������ 30 �����:
		USE [SRV];
		go
		
		EXECUTE [srv].[RunErrorInfoProc] 
		   @IsRealTime=0;
		12) �������������� ��������� ������� � ����������� ������ 60 ������:
		USE [SRV];
		go
		
		EXECUTE [srv].[RunErrorInfoProc] 
		   @IsRealTime=1;
		13) ������������ �� � ����� ������� ���������� ����������� � ����������� ���������, ������� �� ��������� ������:
		13.1) ����������� ���� � ����������� ����������� ���������� �� ���� ����������� ��:
		USE [SRV];
		go
		
		begin try
				EXEC [srv].[AutoUpdateStatisticsCache] 
				@DB_Name=NULL
				,@IsUpdateStatistics=1;
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'����������� ���� � ����������� ����������� ���������� �� ���� ����������� �� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ���������� ���� � ����������� ����������� ���������� �� ���� ����������� ��';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		13.2) ����������� ��������:
		USE [SRV];
		go
		
		begin try
			EXECUTE [srv].[AutoDefragIndexDB] @count=100000;
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'����������� �������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ����������� ��������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		13.3) �������� ������ ��������� �����:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[RunFullBackupDB];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ ��������� ����� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ �������� ������ ��������� �����';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		13.4) �������� ������ ������:
		USE [SRV];
		go
		
		begin try
			EXECUTE [srv].[XPDeleteFile] 
					@FolderPath=N'D:\Backup\LOG'
					,@FileExtension=N'*'
					,@OldDays=3
					,@SubFolder=1;
			EXECUTE [srv].[XPDeleteFile] 
					@FolderPath=N'D:\Backup\Diff'
					,@FileExtension=N'*'
					,@OldDays=3
					,@SubFolder=1;
			EXECUTE [srv].[XPDeleteFile] 
					@FolderPath=N'D:\Backup\FULL'
					,@FileExtension=N'*'
					,@OldDays=10
					,@SubFolder=1;
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ������ ������ �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ �������� ������ ������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		14) ���� ������ � �������� � ����������� ���������:
		USE [SRV];
		go
		
		begin try
		    exec [srv].[AutoStatisticsQuerys];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'���� ������ � �������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ����� ������ � ��������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		15) ���� ������ �� �������� �������� � ����������� ������ 10 ������ (� ����� �� ������� ����� ������ � ��������������� ������) (���������� ���������� ��������� �������� ���������, �������� �� ��, ��� ���� � ���� ���� ������� �������� ������):
		USE [SRV];
		go
		
		begin try
		                exec [srv].[AutoStatisticsActiveRequests];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'���� ������ �� �������� �������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ����� ������ �� �������� ��������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		16) �������� ���������� ��������� ����� � �� �������������:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[RunDiffBackupDB];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������� ���������� ��������� ����� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ �������� ���������� ��������� �����';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		17) �������������� �� �� �� ������ ��������� �����:
		USE [SRV];
		go
		
		begin try
		                exec [srv].[RunFullRestoreDB];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'�������������� �� �� �� ������ ��������� ����� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ �������������� �� �� �� ������ ��������� �����';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch
		18) ������������ ������� ����������:
		USE [SRV];
		go
		
		begin try
		                exec  [srv].[AutoKillSessionTranBegin];
		end try
		begin catch
		    declare @str_mess nvarchar(max)=ERROR_MESSAGE(),
		            @str_num  nvarchar(max)=cast(ERROR_NUMBER() as nvarchar(max)),
		            @str_line nvarchar(max)=cast(ERROR_LINE()   as nvarchar(max)),
		            @str_proc nvarchar(max)=ERROR_PROCEDURE(),
		            @str_title nvarchar(max)=N'������������ ������� ���������� �� ������� '+@@servername,
		            @str_pred_mess nvarchar(max)=N'�� ������� '+@@servername+N' �������� ������ ������������ ������� ����������';
		
		    exec [SRV].srv.ErrorInfoIncUpd
		         @ERROR_TITLE           = @str_title,
		         @ERROR_PRED_MESSAGE    = @str_pred_mess,
		         @ERROR_NUMBER          = @str_num,
		         @ERROR_MESSAGE         = @str_mess,
		         @ERROR_LINE            = @str_line,
		         @ERROR_PROCEDURE       = @str_proc,
		         @ERROR_POST_MESSAGE    = NULL,
		         @RECIPIENTS            = 'DBA;';
		
		     declare @err int=@@error;
		     raiserror(@str_mess,16,1);
		end catch

	*/
END
GO
/****** Object:  StoredProcedure [inf].[RunAsyncExecute]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [inf].[RunAsyncExecute]
(
	@sql nvarchar(max),
	@jobname nvarchar(57) = null,   
	@database nvarchar(128)= null,
	@owner nvarchar(128) = null
)
AS BEGIN
/*
	����������� ����� ������ ����� ������� ������
	RunAsyncExecute - asynchronous execution of T-SQL command or stored prodecure  
	2012 Antonin Foller, Motobit Software, www.motobit.com
	http://www.motobit.com/tips/detpg_async-execute-sql/  
*/  
    SET NOCOUNT ON;  
  
    declare @id uniqueidentifier;

    --Create unique job name if the name is not specified  
    if (@jobname is null) set @jobname= '';

    set @jobname = @jobname + '_async_' + convert(varchar(64),NEWID());
  
    if (@owner is null) set @owner = 'sa';
  
    --Create a new job, get job ID  
    execute msdb..sp_add_job @jobname, @owner_login_name=@owner, @job_id=@id OUTPUT;
  
    --Specify a job server for the job  
    execute msdb..sp_add_jobserver @job_id=@id;
  
    --Specify a first step of the job - the SQL command  
    --(@on_success_action = 3 ... Go to next step)  
    execute msdb..sp_add_jobstep @job_id=@id, @step_name='Step1', @command = @sql,   
        @database_name = @database, @on_success_action = 3;
  
    --Specify next step of the job - delete the job  
    declare @deletecommand varchar(200);

    set @deletecommand = 'execute msdb..sp_delete_job @job_name='''+@jobname+'''';

    execute msdb..sp_add_jobstep @job_id=@id, @step_name='Step2', @command = @deletecommand;
  
    --Start the job  
    execute msdb..sp_start_job @job_id=@id;
  
END  
GO
/****** Object:  StoredProcedure [inf].[sp_WhoIsActive]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*********************************************************************************************
Who Is Active? v11.17 (2016-10-18)
(C) 2007-2016, Adam Machanic

Feedback: mailto:amachanic@gmail.com
Updates: http://whoisactive.com

License: 
	Who is Active? is free to download and use for personal, educational, and internal 
	corporate purposes, provided that this header is preserved. Redistribution or sale 
	of Who is Active?, in whole or in part, is prohibited without the author's express 
	written consent.
*********************************************************************************************/
CREATE PROC [inf].[sp_WhoIsActive]
(
--~
	--Filters--Both inclusive and exclusive
	--Set either filter to '' to disable
	--Valid filter types are: session, program, database, login, and host
	--Session is a session ID, and either 0 or '' can be used to indicate "all" sessions
	--All other filter types support % or _ as wildcards
	@filter sysname = '',
	@filter_type VARCHAR(10) = 'session',
	@not_filter sysname = '',
	@not_filter_type VARCHAR(10) = 'session',

	--Retrieve data about the calling session?
	@show_own_spid BIT = 0,

	--Retrieve data about system sessions?
	@show_system_spids BIT = 0,

	--Controls how sleeping SPIDs are handled, based on the idea of levels of interest
	--0 does not pull any sleeping SPIDs
	--1 pulls only those sleeping SPIDs that also have an open transaction
	--2 pulls all sleeping SPIDs
	@show_sleeping_spids TINYINT = 1,

	--If 1, gets the full stored procedure or running batch, when available
	--If 0, gets only the actual statement that is currently running in the batch or procedure
	@get_full_inner_text BIT = 0,

	--Get associated query plans for running tasks, if available
	--If @get_plans = 1, gets the plan based on the request's statement offset
	--If @get_plans = 2, gets the entire plan based on the request's plan_handle
	@get_plans TINYINT = 0,

	--Get the associated outer ad hoc query or stored procedure call, if available
	@get_outer_command BIT = 0,

	--Enables pulling transaction log write info and transaction duration
	@get_transaction_info BIT = 0,

	--Get information on active tasks, based on three interest levels
	--Level 0 does not pull any task-related information
	--Level 1 is a lightweight mode that pulls the top non-CXPACKET wait, giving preference to blockers
	--Level 2 pulls all available task-based metrics, including: 
	--number of active tasks, current wait stats, physical I/O, context switches, and blocker information
	@get_task_info TINYINT = 1,

	--Gets associated locks for each request, aggregated in an XML format
	@get_locks BIT = 0,

	--Get average time for past runs of an active query
	--(based on the combination of plan handle, sql handle, and offset)
	@get_avg_time BIT = 0,

	--Get additional non-performance-related information about the session or request
	--text_size, language, date_format, date_first, quoted_identifier, arithabort, ansi_null_dflt_on, 
	--ansi_defaults, ansi_warnings, ansi_padding, ansi_nulls, concat_null_yields_null, 
	--transaction_isolation_level, lock_timeout, deadlock_priority, row_count, command_type
	--
	--If a SQL Agent job is running, an subnode called agent_info will be populated with some or all of
	--the following: job_id, job_name, step_id, step_name, msdb_query_error (in the event of an error)
	--
	--If @get_task_info is set to 2 and a lock wait is detected, a subnode called block_info will be
	--populated with some or all of the following: lock_type, database_name, object_id, file_id, hobt_id, 
	--applock_hash, metadata_resource, metadata_class_id, object_name, schema_name
	@get_additional_info BIT = 0,

	--Walk the blocking chain and count the number of 
	--total SPIDs blocked all the way down by a given session
	--Also enables task_info Level 1, if @get_task_info is set to 0
	@find_block_leaders BIT = 0,

	--Pull deltas on various metrics
	--Interval in seconds to wait before doing the second data pull
	@delta_interval TINYINT = 0,

	--List of desired output columns, in desired order
	--Note that the final output will be the intersection of all enabled features and all 
	--columns in the list. Therefore, only columns associated with enabled features will 
	--actually appear in the output. Likewise, removing columns from this list may effectively
	--disable features, even if they are turned on
	--
	--Each element in this list must be one of the valid output column names. Names must be
	--delimited by square brackets. White space, formatting, and additional characters are
	--allowed, as long as the list contains exact matches of delimited valid column names.
	@output_column_list VARCHAR(8000) = '[dd%][session_id][sql_text][sql_command][login_name][wait_info][tasks][tran_log%][cpu%][temp%][block%][reads%][writes%][context%][physical%][query_plan][locks][%]',

	--Column(s) by which to sort output, optionally with sort directions. 
		--Valid column choices:
		--session_id, physical_io, reads, physical_reads, writes, tempdb_allocations,
		--tempdb_current, CPU, context_switches, used_memory, physical_io_delta, 
		--reads_delta, physical_reads_delta, writes_delta, tempdb_allocations_delta, 
		--tempdb_current_delta, CPU_delta, context_switches_delta, used_memory_delta, 
		--tasks, tran_start_time, open_tran_count, blocking_session_id, blocked_session_count,
		--percent_complete, host_name, login_name, database_name, start_time, login_time
		--
		--Note that column names in the list must be bracket-delimited. Commas and/or white
		--space are not required. 
	@sort_order VARCHAR(500) = '[start_time] ASC',

	--Formats some of the output columns in a more "human readable" form
	--0 disables outfput format
	--1 formats the output for variable-width fonts
	--2 formats the output for fixed-width fonts
	@format_output TINYINT = 1,

	--If set to a non-blank value, the script will attempt to insert into the specified 
	--destination table. Please note that the script will not verify that the table exists, 
	--or that it has the correct schema, before doing the insert.
	--Table can be specified in one, two, or three-part format
	@destination_table VARCHAR(4000) = '',

	--If set to 1, no data collection will happen and no result set will be returned; instead,
	--a CREATE TABLE statement will be returned via the @schema parameter, which will match 
	--the schema of the result set that would be returned by using the same collection of the
	--rest of the parameters. The CREATE TABLE statement will have a placeholder token of 
	--<table_name> in place of an actual table name.
	@return_schema BIT = 0,
	@schema VARCHAR(MAX) = NULL OUTPUT,

	--Help! What do I do?
	@help BIT = 0
--~
)
/*
OUTPUT COLUMNS
--------------
Formatted/Non:	[session_id] [smallint] NOT NULL
	Session ID (a.k.a. SPID)

Formatted:		[dd hh:mm:ss.mss] [varchar](15) NULL
Non-Formatted:	<not returned>
	For an active request, time the query has been running
	For a sleeping session, time since the last batch completed

Formatted:		[dd hh:mm:ss.mss (avg)] [varchar](15) NULL
Non-Formatted:	[avg_elapsed_time] [int] NULL
	(Requires @get_avg_time option)
	How much time has the active portion of the query taken in the past, on average?

Formatted:		[physical_io] [varchar](30) NULL
Non-Formatted:	[physical_io] [bigint] NULL
	Shows the number of physical I/Os, for active requests

Formatted:		[reads] [varchar](30) NULL
Non-Formatted:	[reads] [bigint] NULL
	For an active request, number of reads done for the current query
	For a sleeping session, total number of reads done over the lifetime of the session

Formatted:		[physical_reads] [varchar](30) NULL
Non-Formatted:	[physical_reads] [bigint] NULL
	For an active request, number of physical reads done for the current query
	For a sleeping session, total number of physical reads done over the lifetime of the session

Formatted:		[writes] [varchar](30) NULL
Non-Formatted:	[writes] [bigint] NULL
	For an active request, number of writes done for the current query
	For a sleeping session, total number of writes done over the lifetime of the session

Formatted:		[tempdb_allocations] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations] [bigint] NULL
	For an active request, number of TempDB writes done for the current query
	For a sleeping session, total number of TempDB writes done over the lifetime of the session

Formatted:		[tempdb_current] [varchar](30) NULL
Non-Formatted:	[tempdb_current] [bigint] NULL
	For an active request, number of TempDB pages currently allocated for the query
	For a sleeping session, number of TempDB pages currently allocated for the session

Formatted:		[CPU] [varchar](30) NULL
Non-Formatted:	[CPU] [int] NULL
	For an active request, total CPU time consumed by the current query
	For a sleeping session, total CPU time consumed over the lifetime of the session

Formatted:		[context_switches] [varchar](30) NULL
Non-Formatted:	[context_switches] [bigint] NULL
	Shows the number of context switches, for active requests

Formatted:		[used_memory] [varchar](30) NOT NULL
Non-Formatted:	[used_memory] [bigint] NOT NULL
	For an active request, total memory consumption for the current query
	For a sleeping session, total current memory consumption

Formatted:		[physical_io_delta] [varchar](30) NULL
Non-Formatted:	[physical_io_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical I/Os reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[reads_delta] [varchar](30) NULL
Non-Formatted:	[reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[physical_reads_delta] [varchar](30) NULL
Non-Formatted:	[physical_reads_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of physical reads reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[writes_delta] [varchar](30) NULL
Non-Formatted:	[writes_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_allocations_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_allocations_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of TempDB writes reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[tempdb_current_delta] [varchar](30) NULL
Non-Formatted:	[tempdb_current_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the number of allocated TempDB pages reported on the first and second 
	collections. If the request started after the first collection, the value will be NULL

Formatted:		[CPU_delta] [varchar](30) NULL
Non-Formatted:	[CPU_delta] [int] NULL
	(Requires @delta_interval option)
	Difference between the CPU time reported on the first and second collections. 
	If the request started after the first collection, the value will be NULL

Formatted:		[context_switches_delta] [varchar](30) NULL
Non-Formatted:	[context_switches_delta] [bigint] NULL
	(Requires @delta_interval option)
	Difference between the context switches count reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[used_memory_delta] [varchar](30) NULL
Non-Formatted:	[used_memory_delta] [bigint] NULL
	Difference between the memory usage reported on the first and second collections
	If the request started after the first collection, the value will be NULL

Formatted:		[tasks] [varchar](30) NULL
Non-Formatted:	[tasks] [smallint] NULL
	Number of worker tasks currently allocated, for active requests

Formatted/Non:	[status] [varchar](30) NOT NULL
	Activity status for the session (running, sleeping, etc)

Formatted/Non:	[wait_info] [nvarchar](4000) NULL
	Aggregates wait information, in the following format:
		(Ax: Bms/Cms/Dms)E
	A is the number of waiting tasks currently waiting on resource type E. B/C/D are wait
	times, in milliseconds. If only one thread is waiting, its wait time will be shown as B.
	If two tasks are waiting, each of their wait times will be shown (B/C). If three or more 
	tasks are waiting, the minimum, average, and maximum wait times will be shown (B/C/D).
	If wait type E is a page latch wait and the page is of a "special" type (e.g. PFS, GAM, SGAM), 
	the page type will be identified.
	If wait type E is CXPACKET, the nodeId from the query plan will be identified

Formatted/Non:	[locks] [xml] NULL
	(Requires @get_locks option)
	Aggregates lock information, in XML format.
	The lock XML includes the lock mode, locked object, and aggregates the number of requests. 
	Attempts are made to identify locked objects by name

Formatted/Non:	[tran_start_time] [datetime] NULL
	(Requires @get_transaction_info option)
	Date and time that the first transaction opened by a session caused a transaction log 
	write to occur.

Formatted/Non:	[tran_log_writes] [nvarchar](4000) NULL
	(Requires @get_transaction_info option)
	Aggregates transaction log write information, in the following format:
	A:wB (C kB)
	A is a database that has been touched by an active transaction
	B is the number of log writes that have been made in the database as a result of the transaction
	C is the number of log kilobytes consumed by the log records

Formatted:		[open_tran_count] [varchar](30) NULL
Non-Formatted:	[open_tran_count] [smallint] NULL
	Shows the number of open transactions the session has open

Formatted:		[sql_command] [xml] NULL
Non-Formatted:	[sql_command] [nvarchar](max) NULL
	(Requires @get_outer_command option)
	Shows the "outer" SQL command, i.e. the text of the batch or RPC sent to the server, 
	if available

Formatted:		[sql_text] [xml] NULL
Non-Formatted:	[sql_text] [nvarchar](max) NULL
	Shows the SQL text for active requests or the last statement executed
	for sleeping sessions, if available in either case.
	If @get_full_inner_text option is set, shows the full text of the batch.
	Otherwise, shows only the active statement within the batch.
	If the query text is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[query_plan] [xml] NULL
	(Requires @get_plans option)
	Shows the query plan for the request, if available.
	If the plan is locked, a special timeout message will be sent, in the following format:
		<timeout_exceeded />
	If an error occurs, an error message will be sent, in the following format:
		<error message="message" />

Formatted/Non:	[blocking_session_id] [smallint] NULL
	When applicable, shows the blocking SPID

Formatted:		[blocked_session_count] [varchar](30) NULL
Non-Formatted:	[blocked_session_count] [smallint] NULL
	(Requires @find_block_leaders option)
	The total number of SPIDs blocked by this session,
	all the way down the blocking chain.

Formatted:		[percent_complete] [varchar](30) NULL
Non-Formatted:	[percent_complete] [real] NULL
	When applicable, shows the percent complete (e.g. for backups, restores, and some rollbacks)

Formatted/Non:	[host_name] [sysname] NOT NULL
	Shows the host name for the connection

Formatted/Non:	[login_name] [sysname] NOT NULL
	Shows the login name for the connection

Formatted/Non:	[database_name] [sysname] NULL
	Shows the connected database

Formatted/Non:	[program_name] [sysname] NULL
	Shows the reported program/application name

Formatted/Non:	[additional_info] [xml] NULL
	(Requires @get_additional_info option)
	Returns additional non-performance-related session/request information
	If the script finds a SQL Agent job running, the name of the job and job step will be reported
	If @get_task_info = 2 and the script finds a lock wait, the locked object will be reported

Formatted/Non:	[start_time] [datetime] NOT NULL
	For active requests, shows the time the request started
	For sleeping sessions, shows the time the last batch completed

Formatted/Non:	[login_time] [datetime] NOT NULL
	Shows the time that the session connected

Formatted/Non:	[request_id] [int] NULL
	For active requests, shows the request_id
	Should be 0 unless MARS is being used

Formatted/Non:	[collection_time] [datetime] NOT NULL
	Time that this script's final SELECT ran
*/
AS
BEGIN;
	SET NOCOUNT ON; 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET QUOTED_IDENTIFIER ON;
	SET ANSI_PADDING ON;
	SET CONCAT_NULL_YIELDS_NULL ON;
	SET ANSI_WARNINGS ON;
	SET NUMERIC_ROUNDABORT OFF;
	SET ARITHABORT ON;

	IF
		@filter IS NULL
		OR @filter_type IS NULL
		OR @not_filter IS NULL
		OR @not_filter_type IS NULL
		OR @show_own_spid IS NULL
		OR @show_system_spids IS NULL
		OR @show_sleeping_spids IS NULL
		OR @get_full_inner_text IS NULL
		OR @get_plans IS NULL
		OR @get_outer_command IS NULL
		OR @get_transaction_info IS NULL
		OR @get_task_info IS NULL
		OR @get_locks IS NULL
		OR @get_avg_time IS NULL
		OR @get_additional_info IS NULL
		OR @find_block_leaders IS NULL
		OR @delta_interval IS NULL
		OR @format_output IS NULL
		OR @output_column_list IS NULL
		OR @sort_order IS NULL
		OR @return_schema IS NULL
		OR @destination_table IS NULL
		OR @help IS NULL
	BEGIN;
		RAISERROR('Input parameters cannot be NULL', 16, 1);
		RETURN;
	END;
	
	IF @filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @filter_type = 'session' AND @filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type NOT IN ('session', 'program', 'database', 'login', 'host')
	BEGIN;
		RAISERROR('Valid filter types are: session, program, database, login, host', 16, 1);
		RETURN;
	END;
	
	IF @not_filter_type = 'session' AND @not_filter LIKE '%[^0123456789]%'
	BEGIN;
		RAISERROR('Session filters must be valid integers', 16, 1);
		RETURN;
	END;
	
	IF @show_sleeping_spids NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @show_sleeping_spids are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @get_plans NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_plans are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @get_task_info NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @get_task_info are: 0, 1, or 2', 16, 1);
		RETURN;
	END;

	IF @format_output NOT IN (0, 1, 2)
	BEGIN;
		RAISERROR('Valid values for @format_output are: 0, 1, or 2', 16, 1);
		RETURN;
	END;
	
	IF @help = 1
	BEGIN;
		DECLARE 
			@header VARCHAR(MAX),
			@params VARCHAR(MAX),
			@outputs VARCHAR(MAX);

		SELECT 
			@header =
				REPLACE
				(
					REPLACE
					(
						CONVERT
						(
							VARCHAR(MAX),
							SUBSTRING
							(
								t.text, 
								CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94,
								CHARINDEX(REPLICATE('*', 93) + '/', t.text) - (CHARINDEX('/' + REPLICATE('*', 93), t.text) + 94)
							)
						),
						CHAR(13)+CHAR(10),
						CHAR(13)
					),
					'	',
					''
				),
			@params =
				CHAR(13) +
					REPLACE
					(
						REPLACE
						(
							CONVERT
							(
								VARCHAR(MAX),
								SUBSTRING
								(
									t.text, 
									CHARINDEX('--~', t.text) + 5, 
									CHARINDEX('--~', t.text, CHARINDEX('--~', t.text) + 5) - (CHARINDEX('--~', t.text) + 5)
								)
							),
							CHAR(13)+CHAR(10),
							CHAR(13)
						),
						'	',
						''
					),
				@outputs = 
					CHAR(13) +
						REPLACE
						(
							REPLACE
							(
								REPLACE
								(
									CONVERT
									(
										VARCHAR(MAX),
										SUBSTRING
										(
											t.text, 
											CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32,
											CHARINDEX('*/', t.text, CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32) - (CHARINDEX('OUTPUT COLUMNS'+CHAR(13)+CHAR(10)+'--------------', t.text) + 32)
										)
									),
									CHAR(9),
									CHAR(255)
								),
								CHAR(13)+CHAR(10),
								CHAR(13)
							),
							'	',
							''
						) +
						CHAR(13)
		FROM sys.dm_exec_requests AS r
		CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
		WHERE
			r.session_id = @@SPID;

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@header) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		)
		SELECT
			RTRIM(LTRIM(
				SUBSTRING
				(
					@header,
					number + 1,
					CHARINDEX(CHAR(13), @header, number + 1) - number - 1
				)
			)) AS [------header---------------------------------------------------------------------------------------------------------------]
		FROM numbers
		WHERE
			SUBSTRING(@header, number, 1) = CHAR(13);

		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@params) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@params,
						number + 1,
						CHARINDEX(CHAR(13), @params, number + 1) - number - 1
					)
				)) AS token,
				number,
				CASE
					WHEN SUBSTRING(@params, number + 1, 1) = CHAR(13) THEN number
					ELSE COALESCE(NULLIF(CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number), 0), LEN(@params)) 
				END AS param_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY
						CHARINDEX(',' + CHAR(13) + CHAR(13), @params, number),
						SUBSTRING(@params, number+1, 1)
					ORDER BY 
						number
				) AS group_order
			FROM numbers
			WHERE
				SUBSTRING(@params, number, 1) = CHAR(13)
		),
		parsed_tokens AS
		(
			SELECT
				MIN
				(
					CASE
						WHEN token LIKE '@%' THEN token
						ELSE NULL
					END
				) AS parameter,
				MIN
				(
					CASE
						WHEN token LIKE '--%' THEN RIGHT(token, LEN(token) - 2)
						ELSE NULL
					END
				) AS description,
				param_group,
				group_order
			FROM tokens
			WHERE
				NOT 
				(
					token = '' 
					AND group_order > 1
				)
			GROUP BY
				param_group,
				group_order
		)
		SELECT
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '-------------------------------------------------------------------------'
				WHEN param_group = MAX(param_group) OVER() THEN parameter
				ELSE COALESCE(LEFT(parameter, LEN(parameter) - 1), '')
			END AS [------parameter----------------------------------------------------------],
			CASE
				WHEN description IS NULL AND parameter IS NULL THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE COALESCE(description, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM parsed_tokens
		ORDER BY
			param_group, 
			group_order;
		
		WITH
		a0 AS
		(SELECT 1 AS n UNION ALL SELECT 1),
		a1 AS
		(SELECT 1 AS n FROM a0 AS a, a0 AS b),
		a2 AS
		(SELECT 1 AS n FROM a1 AS a, a1 AS b),
		a3 AS
		(SELECT 1 AS n FROM a2 AS a, a2 AS b),
		a4 AS
		(SELECT 1 AS n FROM a3 AS a, a3 AS b),
		numbers AS
		(
			SELECT TOP(LEN(@outputs) - 1)
				ROW_NUMBER() OVER
				(
					ORDER BY (SELECT NULL)
				) AS number
			FROM a4
			ORDER BY
				number
		),
		tokens AS
		(
			SELECT 
				RTRIM(LTRIM(
					SUBSTRING
					(
						@outputs,
						number + 1,
						CASE
							WHEN 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) < 
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs))
								THEN COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) - number - 1
							ELSE
								COALESCE(NULLIF(CHARINDEX(CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2, @outputs, number + 1), 0), LEN(@outputs)) - number - 1
						END
					)
				)) AS token,
				number,
				COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs)) AS output_group,
				ROW_NUMBER() OVER
				(
					PARTITION BY 
						COALESCE(NULLIF(CHARINDEX(CHAR(13) + 'Formatted', @outputs, number + 1), 0), LEN(@outputs))
					ORDER BY
						number
				) AS output_group_order
			FROM numbers
			WHERE
				SUBSTRING(@outputs, number, 10) = CHAR(13) + 'Formatted'
				OR SUBSTRING(@outputs, number, 2) = CHAR(13) + CHAR(255) COLLATE Latin1_General_Bin2
		),
		output_tokens AS
		(
			SELECT 
				*,
				CASE output_group_order
					WHEN 2 THEN MAX(CASE output_group_order WHEN 1 THEN token ELSE NULL END) OVER (PARTITION BY output_group)
					ELSE ''
				END COLLATE Latin1_General_Bin2 AS column_info
			FROM tokens
		)
		SELECT
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)+2) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info)-1)
					END
				ELSE ''
			END AS formatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '-----------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, LEN(column_info))
						ELSE
							SUBSTRING(column_info, CHARINDEX(']', column_info)+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
					END
				ELSE ''
			END AS formatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX('>', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
								ELSE
									SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, CHARINDEX(']', column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1) - CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info)))
							END
					END
				ELSE ''
			END AS unformatted_column_name,
			CASE output_group_order
				WHEN 1 THEN '---------------------------------------'
				WHEN 2 THEN 
					CASE
						WHEN CHARINDEX('Formatted/Non:', column_info) = 1 THEN ''
						ELSE
							CASE
								WHEN SUBSTRING(column_info, CHARINDEX(CHAR(255) COLLATE Latin1_General_Bin2, column_info, CHARINDEX('Non-Formatted:', column_info))+1, 1) = '<' THEN ''
								ELSE
									SUBSTRING(column_info, CHARINDEX(']', column_info, CHARINDEX('Non-Formatted:', column_info))+2, CHARINDEX('Non-Formatted:', column_info, CHARINDEX(']', column_info)+2) - CHARINDEX(']', column_info)-3)
							END
					END
				ELSE ''
			END AS unformatted_column_type,
			CASE output_group_order
				WHEN 1 THEN '----------------------------------------------------------------------------------------------------------------------'
				ELSE REPLACE(token, CHAR(255) COLLATE Latin1_General_Bin2, '')
			END AS [------description-----------------------------------------------------------------------------------------------------]
		FROM output_tokens
		WHERE
			NOT 
			(
				output_group_order = 1 
				AND output_group = LEN(@outputs)
			)
		ORDER BY
			output_group,
			CASE output_group_order
				WHEN 1 THEN 99
				ELSE output_group_order
			END;

		RETURN;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@output_column_list))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@output_column_list,
					number + 1,
					CHARINDEX(']', @output_column_list, number) - number - 1
				) + '|]' AS token,
			number
		FROM numbers
		WHERE
			SUBSTRING(@output_column_list, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number,
					x.default_order
			) AS r,
			ROW_NUMBER() OVER
			(
				ORDER BY
					tokens.number,
					x.default_order
			) AS s
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name, 1 AS default_order
			UNION ALL
			SELECT '[dd hh:mm:ss.mss]', 2
			WHERE
				@format_output IN (1, 2)
			UNION ALL
			SELECT '[dd hh:mm:ss.mss (avg)]', 3
			WHERE
				@format_output IN (1, 2)
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[avg_elapsed_time]', 4
			WHERE
				@format_output = 0
				AND @get_avg_time = 1
			UNION ALL
			SELECT '[physical_io]', 5
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[reads]', 6
			UNION ALL
			SELECT '[physical_reads]', 7
			UNION ALL
			SELECT '[writes]', 8
			UNION ALL
			SELECT '[tempdb_allocations]', 9
			UNION ALL
			SELECT '[tempdb_current]', 10
			UNION ALL
			SELECT '[CPU]', 11
			UNION ALL
			SELECT '[context_switches]', 12
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[used_memory]', 13
			UNION ALL
			SELECT '[physical_io_delta]', 14
			WHERE
				@delta_interval > 0	
				AND @get_task_info = 2
			UNION ALL
			SELECT '[reads_delta]', 15
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[physical_reads_delta]', 16
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[writes_delta]', 17
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_allocations_delta]', 18
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tempdb_current_delta]', 19
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[CPU_delta]', 20
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[context_switches_delta]', 21
			WHERE
				@delta_interval > 0
				AND @get_task_info = 2
			UNION ALL
			SELECT '[used_memory_delta]', 22
			WHERE
				@delta_interval > 0
			UNION ALL
			SELECT '[tasks]', 23
			WHERE
				@get_task_info = 2
			UNION ALL
			SELECT '[status]', 24
			UNION ALL
			SELECT '[wait_info]', 25
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[locks]', 26
			WHERE
				@get_locks = 1
			UNION ALL
			SELECT '[tran_start_time]', 27
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[tran_log_writes]', 28
			WHERE
				@get_transaction_info = 1
			UNION ALL
			SELECT '[open_tran_count]', 29
			UNION ALL
			SELECT '[sql_command]', 30
			WHERE
				@get_outer_command = 1
			UNION ALL
			SELECT '[sql_text]', 31
			UNION ALL
			SELECT '[query_plan]', 32
			WHERE
				@get_plans >= 1
			UNION ALL
			SELECT '[blocking_session_id]', 33
			WHERE
				@get_task_info > 0
				OR @find_block_leaders = 1
			UNION ALL
			SELECT '[blocked_session_count]', 34
			WHERE
				@find_block_leaders = 1
			UNION ALL
			SELECT '[percent_complete]', 35
			UNION ALL
			SELECT '[host_name]', 36
			UNION ALL
			SELECT '[login_name]', 37
			UNION ALL
			SELECT '[database_name]', 38
			UNION ALL
			SELECT '[program_name]', 39
			UNION ALL
			SELECT '[additional_info]', 40
			WHERE
				@get_additional_info = 1
			UNION ALL
			SELECT '[start_time]', 41
			UNION ALL
			SELECT '[login_time]', 42
			UNION ALL
			SELECT '[request_id]', 43
			UNION ALL
			SELECT '[collection_time]', 44
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@output_column_list =
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						s
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			);
	
	IF COALESCE(RTRIM(@output_column_list), '') = ''
	BEGIN;
		RAISERROR('No valid column matches found in @output_column_list or no columns remain due to selected options.', 16, 1);
		RETURN;
	END;
	
	IF @destination_table <> ''
	BEGIN;
		SET @destination_table = 
			--database
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 3)) + '.', '') +
			--schema
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 2)) + '.', '') +
			--table
			COALESCE(QUOTENAME(PARSENAME(@destination_table, 1)), '');
			
		IF COALESCE(RTRIM(@destination_table), '') = ''
		BEGIN;
			RAISERROR('Destination table not properly formatted.', 16, 1);
			RETURN;
		END;
	END;

	WITH
	a0 AS
	(SELECT 1 AS n UNION ALL SELECT 1),
	a1 AS
	(SELECT 1 AS n FROM a0 AS a, a0 AS b),
	a2 AS
	(SELECT 1 AS n FROM a1 AS a, a1 AS b),
	a3 AS
	(SELECT 1 AS n FROM a2 AS a, a2 AS b),
	a4 AS
	(SELECT 1 AS n FROM a3 AS a, a3 AS b),
	numbers AS
	(
		SELECT TOP(LEN(@sort_order))
			ROW_NUMBER() OVER
			(
				ORDER BY (SELECT NULL)
			) AS number
		FROM a4
		ORDER BY
			number
	),
	tokens AS
	(
		SELECT 
			'|[' +
				SUBSTRING
				(
					@sort_order,
					number + 1,
					CHARINDEX(']', @sort_order, number) - number - 1
				) + '|]' AS token,
			SUBSTRING
			(
				@sort_order,
				CHARINDEX(']', @sort_order, number) + 1,
				COALESCE(NULLIF(CHARINDEX('[', @sort_order, CHARINDEX(']', @sort_order, number)), 0), LEN(@sort_order)) - CHARINDEX(']', @sort_order, number)
			) AS next_chunk,
			number
		FROM numbers
		WHERE
			SUBSTRING(@sort_order, number, 1) = '['
	),
	ordered_columns AS
	(
		SELECT
			x.column_name +
				CASE
					WHEN tokens.next_chunk LIKE '%asc%' THEN ' ASC'
					WHEN tokens.next_chunk LIKE '%desc%' THEN ' DESC'
					ELSE ''
				END AS column_name,
			ROW_NUMBER() OVER
			(
				PARTITION BY
					x.column_name
				ORDER BY
					tokens.number
			) AS r,
			tokens.number
		FROM tokens
		JOIN
		(
			SELECT '[session_id]' AS column_name
			UNION ALL
			SELECT '[physical_io]'
			UNION ALL
			SELECT '[reads]'
			UNION ALL
			SELECT '[physical_reads]'
			UNION ALL
			SELECT '[writes]'
			UNION ALL
			SELECT '[tempdb_allocations]'
			UNION ALL
			SELECT '[tempdb_current]'
			UNION ALL
			SELECT '[CPU]'
			UNION ALL
			SELECT '[context_switches]'
			UNION ALL
			SELECT '[used_memory]'
			UNION ALL
			SELECT '[physical_io_delta]'
			UNION ALL
			SELECT '[reads_delta]'
			UNION ALL
			SELECT '[physical_reads_delta]'
			UNION ALL
			SELECT '[writes_delta]'
			UNION ALL
			SELECT '[tempdb_allocations_delta]'
			UNION ALL
			SELECT '[tempdb_current_delta]'
			UNION ALL
			SELECT '[CPU_delta]'
			UNION ALL
			SELECT '[context_switches_delta]'
			UNION ALL
			SELECT '[used_memory_delta]'
			UNION ALL
			SELECT '[tasks]'
			UNION ALL
			SELECT '[tran_start_time]'
			UNION ALL
			SELECT '[open_tran_count]'
			UNION ALL
			SELECT '[blocking_session_id]'
			UNION ALL
			SELECT '[blocked_session_count]'
			UNION ALL
			SELECT '[percent_complete]'
			UNION ALL
			SELECT '[host_name]'
			UNION ALL
			SELECT '[login_name]'
			UNION ALL
			SELECT '[database_name]'
			UNION ALL
			SELECT '[start_time]'
			UNION ALL
			SELECT '[login_time]'
		) AS x ON 
			x.column_name LIKE token ESCAPE '|'
	)
	SELECT
		@sort_order = COALESCE(z.sort_order, '')
	FROM
	(
		SELECT
			STUFF
			(
				(
					SELECT
						',' + column_name as [text()]
					FROM ordered_columns
					WHERE
						r = 1
					ORDER BY
						number
					FOR XML
						PATH('')
				),
				1,
				1,
				''
			) AS sort_order
	) AS z;

	CREATE TABLE #sessions
	(
		recursion SMALLINT NOT NULL,
		session_id SMALLINT NOT NULL,
		request_id INT NOT NULL,
		session_number INT NOT NULL,
		elapsed_time INT NOT NULL,
		avg_elapsed_time INT NULL,
		physical_io BIGINT NULL,
		reads BIGINT NULL,
		physical_reads BIGINT NULL,
		writes BIGINT NULL,
		tempdb_allocations BIGINT NULL,
		tempdb_current BIGINT NULL,
		CPU INT NULL,
		thread_CPU_snapshot BIGINT NULL,
		context_switches BIGINT NULL,
		used_memory BIGINT NOT NULL, 
		tasks SMALLINT NULL,
		status VARCHAR(30) NOT NULL,
		wait_info NVARCHAR(4000) NULL,
		locks XML NULL,
		transaction_id BIGINT NULL,
		tran_start_time DATETIME NULL,
		tran_log_writes NVARCHAR(4000) NULL,
		open_tran_count SMALLINT NULL,
		sql_command XML NULL,
		sql_handle VARBINARY(64) NULL,
		statement_start_offset INT NULL,
		statement_end_offset INT NULL,
		sql_text XML NULL,
		plan_handle VARBINARY(64) NULL,
		query_plan XML NULL,
		blocking_session_id SMALLINT NULL,
		blocked_session_count SMALLINT NULL,
		percent_complete REAL NULL,
		host_name sysname NULL,
		login_name sysname NOT NULL,
		database_name sysname NULL,
		program_name sysname NULL,
		additional_info XML NULL,
		start_time DATETIME NOT NULL,
		login_time DATETIME NULL,
		last_request_start_time DATETIME NULL,
		PRIMARY KEY CLUSTERED (session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON),
		UNIQUE NONCLUSTERED (transaction_id, session_id, request_id, recursion) WITH (IGNORE_DUP_KEY = ON)
	);

	IF @return_schema = 0
	BEGIN;
		--Disable unnecessary autostats on the table
		CREATE STATISTICS s_session_id ON #sessions (session_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_request_id ON #sessions (request_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_transaction_id ON #sessions (transaction_id)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_session_number ON #sessions (session_number)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_status ON #sessions (status)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_start_time ON #sessions (start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_last_request_start_time ON #sessions (last_request_start_time)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;
		CREATE STATISTICS s_recursion ON #sessions (recursion)
		WITH SAMPLE 0 ROWS, NORECOMPUTE;

		DECLARE @recursion SMALLINT;
		SET @recursion = 
			CASE @delta_interval
				WHEN 0 THEN 1
				ELSE -1
			END;

		DECLARE @first_collection_ms_ticks BIGINT;
		DECLARE @last_collection_start DATETIME;

		--Used for the delta pull
		REDO:;
		
		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			SELECT
				y.resource_type,
				y.database_name,
				y.object_id,
				y.file_id,
				y.page_type,
				y.hobt_id,
				y.allocation_unit_id,
				y.index_id,
				y.schema_id,
				y.principal_id,
				y.request_mode,
				y.request_status,
				y.session_id,
				y.resource_description,
				y.request_count,
				s.request_id,
				s.start_time,
				CONVERT(sysname, NULL) AS object_name,
				CONVERT(sysname, NULL) AS index_name,
				CONVERT(sysname, NULL) AS schema_name,
				CONVERT(sysname, NULL) AS principal_name,
				CONVERT(NVARCHAR(2048), NULL) AS query_error
			INTO #locks
			FROM
			(
				SELECT
					sp.spid AS session_id,
					CASE sp.status
						WHEN 'sleeping' THEN CONVERT(INT, 0)
						ELSE sp.request_id
					END AS request_id,
					CASE sp.status
						WHEN 'sleeping' THEN sp.last_batch
						ELSE COALESCE(req.start_time, sp.last_batch)
					END AS start_time,
					sp.dbid
				FROM sys.sysprocesses AS sp
				OUTER APPLY
				(
					SELECT TOP(1)
						CASE
							WHEN 
							(
								sp.hostprocess > ''
								OR r.total_elapsed_time < 0
							) THEN
								r.start_time
							ELSE
								DATEADD
								(
									ms, 
									1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())), 
									DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
								)
						END AS start_time
					FROM sys.dm_exec_requests AS r
					WHERE
						r.session_id = sp.spid
						AND r.request_id = sp.request_id
				) AS req
				WHERE
					--Process inclusive filter
					1 =
						CASE
							WHEN @filter <> '' THEN
								CASE @filter_type
									WHEN 'session' THEN
										CASE
											WHEN
												CONVERT(SMALLINT, @filter) = 0
												OR sp.spid = CONVERT(SMALLINT, @filter)
													THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 1
						END
					--Process exclusive filter
					AND 0 =
						CASE
							WHEN @not_filter <> '' THEN
								CASE @not_filter_type
									WHEN 'session' THEN
										CASE
											WHEN sp.spid = CONVERT(SMALLINT, @not_filter) THEN 1
											ELSE 0
										END
									WHEN 'program' THEN
										CASE
											WHEN sp.program_name LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'login' THEN
										CASE
											WHEN sp.loginame LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'host' THEN
										CASE
											WHEN sp.hostname LIKE @not_filter THEN 1
											ELSE 0
										END
									WHEN 'database' THEN
										CASE
											WHEN DB_NAME(sp.dbid) LIKE @not_filter THEN 1
											ELSE 0
										END
									ELSE 0
								END
							ELSE 0
						END
					AND 
					(
						@show_own_spid = 1
						OR sp.spid <> @@SPID
					)
					AND 
					(
						@show_system_spids = 1
						OR sp.hostprocess > ''
					)
					AND sp.ecid = 0
			) AS s
			INNER HASH JOIN
			(
				SELECT
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END AS page_type,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END AS resource_description,
					COUNT(*) AS request_count
				FROM
				(
					SELECT
						tl.resource_type +
							CASE
								WHEN tl.resource_subtype = '' THEN ''
								ELSE '.' + tl.resource_subtype
							END AS resource_type,
						COALESCE(DB_NAME(tl.resource_database_id), N'(null)') AS database_name,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type = 'OBJECT' THEN tl.resource_associated_entity_id
								WHEN tl.resource_description LIKE '%object_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('object_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('object_id = ', tl.resource_description) + 12),
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('object_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END
						) AS object_id,
						CONVERT
						(
							INT,
							CASE 
								WHEN tl.resource_type = 'FILE' THEN CONVERT(INT, tl.resource_description)
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN LEFT(tl.resource_description, CHARINDEX(':', tl.resource_description)-1)
								ELSE NULL
							END
						) AS file_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_type IN ('PAGE', 'EXTENT', 'RID') THEN 
									SUBSTRING
									(
										tl.resource_description, 
										CHARINDEX(':', tl.resource_description) + 1, 
										COALESCE
										(
											NULLIF
											(
												CHARINDEX(':', tl.resource_description, CHARINDEX(':', tl.resource_description) + 1), 
												0
											), 
											DATALENGTH(tl.resource_description)+1
										) - (CHARINDEX(':', tl.resource_description) + 1)
									)
								ELSE NULL
							END
						) AS page_no,
						CASE
							WHEN tl.resource_type IN ('PAGE', 'KEY', 'RID', 'HOBT') THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS hobt_id,
						CASE
							WHEN tl.resource_type = 'ALLOCATION_UNIT' THEN tl.resource_associated_entity_id
							ELSE NULL
						END AS allocation_unit_id,
						CONVERT
						(
							INT,
							CASE
								WHEN
									/*TODO: Deal with server principals*/ 
									tl.resource_subtype <> 'SERVER_PRINCIPAL' 
									AND tl.resource_description LIKE '%index_id or stats_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('index_id or stats_id = ', tl.resource_description) + 23)
										)
									)
								ELSE NULL
							END 
						) AS index_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%schema_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('schema_id = ', tl.resource_description) + 12), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('schema_id = ', tl.resource_description) + 12), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('schema_id = ', tl.resource_description) + 12)
										)
									)
								ELSE NULL
							END 
						) AS schema_id,
						CONVERT
						(
							INT,
							CASE
								WHEN tl.resource_description LIKE '%principal_id = %' THEN
									(
										SUBSTRING
										(
											tl.resource_description, 
											(CHARINDEX('principal_id = ', tl.resource_description) + 15), 
											COALESCE
											(
												NULLIF
												(
													CHARINDEX(',', tl.resource_description, CHARINDEX('principal_id = ', tl.resource_description) + 15), 
													0
												), 
												DATALENGTH(tl.resource_description)+1
											) - (CHARINDEX('principal_id = ', tl.resource_description) + 15)
										)
									)
								ELSE NULL
							END
						) AS principal_id,
						tl.request_mode,
						tl.request_status,
						tl.request_session_id AS session_id,
						tl.request_request_id AS request_id,

						/*TODO: Applocks, other resource_descriptions*/
						RTRIM(tl.resource_description) AS resource_description,
						tl.resource_associated_entity_id
						/*********************************************/
					FROM 
					(
						SELECT 
							request_session_id,
							CONVERT(VARCHAR(120), resource_type) COLLATE Latin1_General_Bin2 AS resource_type,
							CONVERT(VARCHAR(120), resource_subtype) COLLATE Latin1_General_Bin2 AS resource_subtype,
							resource_database_id,
							CONVERT(VARCHAR(512), resource_description) COLLATE Latin1_General_Bin2 AS resource_description,
							resource_associated_entity_id,
							CONVERT(VARCHAR(120), request_mode) COLLATE Latin1_General_Bin2 AS request_mode,
							CONVERT(VARCHAR(120), request_status) COLLATE Latin1_General_Bin2 AS request_status,
							request_request_id
						FROM sys.dm_tran_locks
					) AS tl
				) AS x
				GROUP BY
					x.resource_type,
					x.database_name,
					x.object_id,
					x.file_id,
					CASE
						WHEN x.page_no = 1 OR x.page_no % 8088 = 0 THEN 'PFS'
						WHEN x.page_no = 2 OR x.page_no % 511232 = 0 THEN 'GAM'
						WHEN x.page_no = 3 OR (x.page_no - 1) % 511232 = 0 THEN 'SGAM'
						WHEN x.page_no = 6 OR (x.page_no - 6) % 511232 = 0 THEN 'DCM'
						WHEN x.page_no = 7 OR (x.page_no - 7) % 511232 = 0 THEN 'BCM'
						WHEN x.page_no IS NOT NULL THEN '*'
						ELSE NULL
					END,
					x.hobt_id,
					x.allocation_unit_id,
					x.index_id,
					x.schema_id,
					x.principal_id,
					x.request_mode,
					x.request_status,
					x.session_id,
					x.request_id,
					CASE
						WHEN COALESCE(x.object_id, x.file_id, x.hobt_id, x.allocation_unit_id, x.index_id, x.schema_id, x.principal_id) IS NULL THEN NULLIF(resource_description, '')
						ELSE NULL
					END
			) AS y ON
				y.session_id = s.session_id
				AND y.request_id = s.request_id
			OPTION (HASH GROUP);

			--Disable unnecessary autostats on the table
			CREATE STATISTICS s_database_name ON #locks (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_id ON #locks (object_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_hobt_id ON #locks (hobt_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_allocation_unit_id ON #locks (allocation_unit_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_id ON #locks (index_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_id ON #locks (schema_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_id ON #locks (principal_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_id ON #locks (request_id)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_start_time ON #locks (start_time)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_type ON #locks (resource_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #locks (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #locks (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_page_type ON #locks (page_type)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_mode ON #locks (request_mode)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_request_status ON #locks (request_status)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_resource_description ON #locks (resource_description)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_index_name ON #locks (index_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_principal_name ON #locks (principal_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		END;
		
		DECLARE 
			@sql VARCHAR(MAX), 
			@sql_n NVARCHAR(MAX);

		SET @sql = 
			CONVERT(VARCHAR(MAX), '') +
			'DECLARE @blocker BIT;
			SET @blocker = 0;
			DECLARE @i INT;
			SET @i = 2147483647;

			DECLARE @sessions TABLE
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				login_time DATETIME,
				last_request_end_time DATETIME,
				status VARCHAR(30),
				statement_start_offset INT,
				statement_end_offset INT,
				sql_handle BINARY(20),
				host_name NVARCHAR(128),
				login_name NVARCHAR(128),
				program_name NVARCHAR(128),
				database_id SMALLINT,
				memory_usage INT,
				open_tran_count SMALLINT, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0 
						OR @find_block_leaders = 1 
					) THEN
						'wait_type NVARCHAR(32),
						wait_resource NVARCHAR(256),
						wait_time BIGINT, 
						'
					ELSE 
						''
				END +
				'blocked SMALLINT,
				is_user_process BIT,
				cmd VARCHAR(32),
				PRIMARY KEY CLUSTERED (session_id, request_id) WITH (IGNORE_DUP_KEY = ON)
			);

			DECLARE @blockers TABLE
			(
				session_id INT NOT NULL PRIMARY KEY WITH (IGNORE_DUP_KEY = ON)
			);

			BLOCKERS:;

			INSERT @sessions
			(
				session_id,
				request_id,
				login_time,
				last_request_end_time,
				status,
				statement_start_offset,
				statement_end_offset,
				sql_handle,
				host_name,
				login_name,
				program_name,
				database_id,
				memory_usage,
				open_tran_count, 
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0
						OR @find_block_leaders = 1 
					) THEN
						'wait_type,
						wait_resource,
						wait_time, 
						'
					ELSE
						''
				END +
				'blocked,
				is_user_process,
				cmd 
			)
			SELECT TOP(@i)
				spy.session_id,
				spy.request_id,
				spy.login_time,
				spy.last_request_end_time,
				spy.status,
				spy.statement_start_offset,
				spy.statement_end_offset,
				spy.sql_handle,
				spy.host_name,
				spy.login_name,
				spy.program_name,
				spy.database_id,
				spy.memory_usage,
				spy.open_tran_count,
				' +
				CASE
					WHEN 
					(
						@get_task_info <> 0  
						OR @find_block_leaders = 1 
					) THEN
						'spy.wait_type,
						CASE
							WHEN
								spy.wait_type LIKE N''PAGE%LATCH_%''
								OR spy.wait_type = N''CXPACKET''
								OR spy.wait_type LIKE N''LATCH[_]%''
								OR spy.wait_type = N''OLEDB'' THEN
									spy.wait_resource
							ELSE
								NULL
						END AS wait_resource,
						spy.wait_time, 
						'
					ELSE
						''
				END +
				'spy.blocked,
				spy.is_user_process,
				spy.cmd
			FROM
			(
				SELECT TOP(@i)
					spx.*, 
					' +
					CASE
						WHEN 
						(
							@get_task_info <> 0 
							OR @find_block_leaders = 1 
						) THEN
							'ROW_NUMBER() OVER
							(
								PARTITION BY
									spx.session_id,
									spx.request_id
								ORDER BY
									CASE
										WHEN spx.wait_type LIKE N''LCK[_]%'' THEN 
											1
										ELSE
											99
									END,
									spx.wait_time DESC,
									spx.blocked DESC
							) AS r 
							'
						ELSE 
							'1 AS r 
							'
					END +
				'FROM
				(
					SELECT TOP(@i)
						sp0.session_id,
						sp0.request_id,
						sp0.login_time,
						sp0.last_request_end_time,
						LOWER(sp0.status) AS status,
						CASE
							WHEN sp0.cmd = ''CREATE INDEX'' THEN
								0
							ELSE
								sp0.stmt_start
						END AS statement_start_offset,
						CASE
							WHEN sp0.cmd = N''CREATE INDEX'' THEN
								-1
							ELSE
								COALESCE(NULLIF(sp0.stmt_end, 0), -1)
						END AS statement_end_offset,
						sp0.sql_handle,
						sp0.host_name,
						sp0.login_name,
						sp0.program_name,
						sp0.database_id,
						sp0.memory_usage,
						sp0.open_tran_count, 
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0 
								OR @find_block_leaders = 1 
							) THEN
								'CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_type
									ELSE
										NULL
								END AS wait_type,
								CASE
									WHEN sp0.wait_time > 0 AND sp0.wait_type <> N''CXPACKET'' THEN 
										sp0.wait_resource
									ELSE
										NULL
								END AS wait_resource,
								CASE
									WHEN sp0.wait_type <> N''CXPACKET'' THEN
										sp0.wait_time
									ELSE
										0
								END AS wait_time, 
								'
							ELSE
								''
						END +
						'sp0.blocked,
						sp0.is_user_process,
						sp0.cmd
					FROM
					(
						SELECT TOP(@i)
							sp1.session_id,
							sp1.request_id,
							sp1.login_time,
							sp1.last_request_end_time,
							sp1.status,
							sp1.cmd,
							sp1.stmt_start,
							sp1.stmt_end,
							MAX(NULLIF(sp1.sql_handle, 0x00)) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS sql_handle,
							sp1.host_name,
							MAX(sp1.login_name) OVER (PARTITION BY sp1.session_id, sp1.request_id) AS login_name,
							sp1.program_name,
							sp1.database_id,
							MAX(sp1.memory_usage)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS memory_usage,
							MAX(sp1.open_tran_count)  OVER (PARTITION BY sp1.session_id, sp1.request_id) AS open_tran_count,
							sp1.wait_type,
							sp1.wait_resource,
							sp1.wait_time,
							sp1.blocked,
							sp1.hostprocess,
							sp1.is_user_process
						FROM
						(
							SELECT TOP(@i)
								sp2.spid AS session_id,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END AS request_id,
								MAX(sp2.login_time) AS login_time,
								MAX(sp2.last_batch) AS last_request_end_time,
								MAX(CONVERT(VARCHAR(30), RTRIM(sp2.status)) COLLATE Latin1_General_Bin2) AS status,
								MAX(CONVERT(VARCHAR(32), RTRIM(sp2.cmd)) COLLATE Latin1_General_Bin2) AS cmd,
								MAX(sp2.stmt_start) AS stmt_start,
								MAX(sp2.stmt_end) AS stmt_end,
								MAX(sp2.sql_handle) AS sql_handle,
								MAX(CONVERT(sysname, RTRIM(sp2.hostname)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS host_name,
								MAX(CONVERT(sysname, RTRIM(sp2.loginame)) COLLATE SQL_Latin1_General_CP1_CI_AS) AS login_name,
								MAX
								(
									CASE
										WHEN blk.queue_id IS NOT NULL THEN
											N''Service Broker
												database_id: '' + CONVERT(NVARCHAR, blk.database_id) +
												N'' queue_id: '' + CONVERT(NVARCHAR, blk.queue_id)
										ELSE
											CONVERT
											(
												sysname,
												RTRIM(sp2.program_name)
											)
									END COLLATE SQL_Latin1_General_CP1_CI_AS
								) AS program_name,
								MAX(sp2.dbid) AS database_id,
								MAX(sp2.memusage) AS memory_usage,
								MAX(sp2.open_tran) AS open_tran_count,
								RTRIM(sp2.lastwaittype) AS wait_type,
								RTRIM(sp2.waitresource) AS wait_resource,
								MAX(sp2.waittime) AS wait_time,
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0) AS blocked,
								MAX
								(
									CASE
										WHEN blk.session_id = sp2.spid THEN
											''blocker''
										ELSE
											RTRIM(sp2.hostprocess)
									END
								) AS hostprocess,
								CONVERT
								(
									BIT,
									MAX
									(
										CASE
											WHEN sp2.hostprocess > '''' THEN
												1
											ELSE
												0
										END
									)
								) AS is_user_process
							FROM
							(
								SELECT TOP(@i)
									session_id,
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								FROM @blockers

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, 0),
									CONVERT(INT, NULL) AS queue_id,
									CONVERT(INT, NULL) AS database_id
								WHERE
									@blocker = 0

								UNION ALL

								SELECT TOP(@i)
									CONVERT(SMALLINT, spid),
									queue_id,
									database_id
								FROM sys.dm_broker_activated_tasks
								WHERE
									@blocker = 0
							) AS blk
							INNER JOIN sys.sysprocesses AS sp2 ON
								sp2.spid = blk.session_id
								OR
								(
									blk.session_id = 0
									AND @blocker = 0
								)
							' +
							CASE 
								WHEN 
								(
									@get_task_info = 0 
									AND @find_block_leaders = 0
								) THEN
									'WHERE
										sp2.ecid = 0 
									' 
								ELSE
									''
							END +
							'GROUP BY
								sp2.spid,
								CASE sp2.status
									WHEN ''sleeping'' THEN
										CONVERT(INT, 0)
									ELSE
										sp2.request_id
								END,
								RTRIM(sp2.lastwaittype),
								RTRIM(sp2.waitresource),
								COALESCE(NULLIF(sp2.blocked, sp2.spid), 0)
						) AS sp1
					) AS sp0
					WHERE
						@blocker = 1
						OR
						(1=1 
						' +
							--inclusive filter
							CASE
								WHEN @filter <> '' THEN
									CASE @filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @filter) <> 0 THEN
													'AND sp0.session_id = CONVERT(SMALLINT, @filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name LIKE @filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name LIKE @filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name LIKE @filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) LIKE @filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							--exclusive filter
							CASE
								WHEN @not_filter <> '' THEN
									CASE @not_filter_type
										WHEN 'session' THEN
											CASE
												WHEN CONVERT(SMALLINT, @not_filter) <> 0 THEN
													'AND sp0.session_id <> CONVERT(SMALLINT, @not_filter) 
													'
												ELSE
													''
											END
										WHEN 'program' THEN
											'AND sp0.program_name NOT LIKE @not_filter 
											'
										WHEN 'login' THEN
											'AND sp0.login_name NOT LIKE @not_filter 
											'
										WHEN 'host' THEN
											'AND sp0.host_name NOT LIKE @not_filter 
											'
										WHEN 'database' THEN
											'AND DB_NAME(sp0.database_id) NOT LIKE @not_filter 
											'
										ELSE
											''
									END
								ELSE
									''
							END +
							CASE @show_own_spid
								WHEN 1 THEN
									''
								ELSE
									'AND sp0.session_id <> @@spid 
									'
							END +
							CASE 
								WHEN @show_system_spids = 0 THEN
									'AND sp0.hostprocess > '''' 
									' 
								ELSE
									''
							END +
							CASE @show_sleeping_spids
								WHEN 0 THEN
									'AND sp0.status <> ''sleeping'' 
									'
								WHEN 1 THEN
									'AND
									(
										sp0.status <> ''sleeping''
										OR sp0.open_tran_count > 0
									)
									'
								ELSE
									''
							END +
						')
				) AS spx
			) AS spy
			WHERE
				spy.r = 1; 
			' + 
			CASE @recursion
				WHEN 1 THEN 
					'IF @@ROWCOUNT > 0
					BEGIN;
						INSERT @blockers
						(
							session_id
						)
						SELECT TOP(@i)
							blocked
						FROM @sessions
						WHERE
							NULLIF(blocked, 0) IS NOT NULL

						EXCEPT

						SELECT TOP(@i)
							session_id
						FROM @sessions; 
						' +

						CASE
							WHEN
							(
								@get_task_info > 0
								OR @find_block_leaders = 1
							) THEN
								'IF @@ROWCOUNT > 0
								BEGIN;
									SET @blocker = 1;
									GOTO BLOCKERS;
								END; 
								'
							ELSE 
								''
						END +
					'END; 
					'
				ELSE 
					''
			END +
			'SELECT TOP(@i)
				@recursion AS recursion,
				x.session_id,
				x.request_id,
				DENSE_RANK() OVER
				(
					ORDER BY
						x.session_id
				) AS session_number,
				' +
				CASE
					WHEN @output_column_list LIKE '%|[dd hh:mm:ss.mss|]%' ESCAPE '|' THEN 
						'x.elapsed_time '
					ELSE 
						'0 '
				END + 
					'AS elapsed_time, 
					' +
				CASE
					WHEN
						(
							@output_column_list LIKE '%|[dd hh:mm:ss.mss (avg)|]%' ESCAPE '|' OR 
							@output_column_list LIKE '%|[avg_elapsed_time|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.avg_elapsed_time / 1000 '
					ELSE 
						'NULL '
				END + 
					'AS avg_elapsed_time, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_io|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_io_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_io '
					ELSE 
						'NULL '
				END + 
					'AS physical_io, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[reads_delta|]%' ESCAPE '|'
							THEN 
								'x.reads '
					ELSE 
						'0 '
				END + 
					'AS reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[physical_reads|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[physical_reads_delta|]%' ESCAPE '|'
							THEN 
								'x.physical_reads '
					ELSE 
						'0 '
				END + 
					'AS physical_reads, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[writes|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[writes_delta|]%' ESCAPE '|'
							THEN 
								'x.writes '
					ELSE 
						'0 '
				END + 
					'AS writes, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_allocations|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_allocations_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_allocations '
					ELSE 
						'0 '
				END + 
					'AS tempdb_allocations, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tempdb_current|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[tempdb_current_delta|]%' ESCAPE '|'
							THEN 
								'x.tempdb_current '
					ELSE 
						'0 '
				END + 
					'AS tempdb_current, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
							THEN
								'x.CPU '
					ELSE
						'0 '
				END + 
					'AS CPU, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
						AND @get_task_info = 2
							THEN 
								'x.thread_CPU_snapshot '
					ELSE 
						'0 '
				END + 
					'AS thread_CPU_snapshot, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[context_switches|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[context_switches_delta|]%' ESCAPE '|'
							THEN 
								'x.context_switches '
					ELSE 
						'NULL '
				END + 
					'AS context_switches, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[used_memory|]%' ESCAPE '|'
						OR @output_column_list LIKE '%|[used_memory_delta|]%' ESCAPE '|'
							THEN 
								'x.used_memory '
					ELSE 
						'0 '
				END + 
					'AS used_memory, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[tasks|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.tasks '
					ELSE 
						'NULL '
				END + 
					'AS tasks, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[status|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
						)
						AND @recursion = 1
							THEN 
								'x.status '
					ELSE 
						''''' '
				END + 
					'AS status, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[wait_info|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								CASE @get_task_info
									WHEN 2 THEN
										'COALESCE(x.task_wait_info, x.sys_wait_info) '
									ELSE
										'x.sys_wait_info '
								END
					ELSE 
						'NULL '
				END + 
					'AS wait_info, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.transaction_id '
					ELSE 
						'NULL '
				END + 
					'AS transaction_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[open_tran_count|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.open_tran_count '
					ELSE 
						'NULL '
				END + 
					'AS open_tran_count, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.sql_handle '
					ELSE 
						'NULL '
				END + 
					'AS sql_handle, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_start_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_start_offset, 
					' +
				CASE
					WHEN 
						(
							@output_column_list LIKE '%|[sql_text|]%' ESCAPE '|' 
							OR @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						)
						AND @recursion = 1
							THEN 
								'x.statement_end_offset '
					ELSE 
						'NULL '
				END + 
					'AS statement_end_offset, 
					' +
				'NULL AS sql_text, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[query_plan|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.plan_handle '
					ELSE 
						'NULL '
				END + 
					'AS plan_handle, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[blocking_session_id|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'NULLIF(x.blocking_session_id, 0) '
					ELSE 
						'NULL '
				END + 
					'AS blocking_session_id, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[percent_complete|]%' ESCAPE '|'
						AND @recursion = 1
							THEN 
								'x.percent_complete '
					ELSE 
						'NULL '
				END + 
					'AS percent_complete, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[host_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.host_name '
					ELSE 
						''''' '
				END + 
					'AS host_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[login_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.login_name '
					ELSE 
						''''' '
				END + 
					'AS login_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[database_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'DB_NAME(x.database_id) '
					ELSE 
						'NULL '
				END + 
					'AS database_name, 
					' +
				CASE
					WHEN 
						@output_column_list LIKE '%|[program_name|]%' ESCAPE '|' 
						AND @recursion = 1
							THEN 
								'x.program_name '
					ELSE 
						''''' '
				END + 
					'AS program_name, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'(
									SELECT TOP(@i)
										x.text_size,
										x.language,
										x.date_format,
										x.date_first,
										CASE x.quoted_identifier
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS quoted_identifier,
										CASE x.arithabort
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS arithabort,
										CASE x.ansi_null_dflt_on
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_null_dflt_on,
										CASE x.ansi_defaults
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_defaults,
										CASE x.ansi_warnings
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_warnings,
										CASE x.ansi_padding
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_padding,
										CASE ansi_nulls
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS ansi_nulls,
										CASE x.concat_null_yields_null
											WHEN 0 THEN ''OFF''
											WHEN 1 THEN ''ON''
										END AS concat_null_yields_null,
										CASE x.transaction_isolation_level
											WHEN 0 THEN ''Unspecified''
											WHEN 1 THEN ''ReadUncomitted''
											WHEN 2 THEN ''ReadCommitted''
											WHEN 3 THEN ''Repeatable''
											WHEN 4 THEN ''Serializable''
											WHEN 5 THEN ''Snapshot''
										END AS transaction_isolation_level,
										x.lock_timeout,
										x.deadlock_priority,
										x.row_count,
										x.command_type, 
										master.dbo.fn_varbintohexstr(x.sql_handle) AS sql_handle,
										master.dbo.fn_varbintohexstr(x.plan_handle) AS plan_handle,
										' +
										CASE
											WHEN @output_column_list LIKE '%|[program_name|]%' ESCAPE '|' THEN
												'(
													SELECT TOP(1)
														CONVERT(uniqueidentifier, CONVERT(XML, '''').value(''xs:hexBinary( substring(sql:column("agent_info.job_id_string"), 0) )'', ''binary(16)'')) AS job_id,
														agent_info.step_id,
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''job_name''),
																TYPE
														),
														(
															SELECT TOP(1)
																NULL
															FOR XML
																PATH(''step_name''),
																TYPE
														)
													FROM
													(
														SELECT TOP(1)
															SUBSTRING(x.program_name, CHARINDEX(''0x'', x.program_name) + 2, 32) AS job_id_string,
															SUBSTRING(x.program_name, CHARINDEX('': Step '', x.program_name) + 7, CHARINDEX('')'', x.program_name, CHARINDEX('': Step '', x.program_name)) - (CHARINDEX('': Step '', x.program_name) + 7)) AS step_id
														WHERE
															x.program_name LIKE N''SQLAgent - TSQL JobStep (Job 0x%''
													) AS agent_info
													FOR XML
														PATH(''agent_job_info''),
														TYPE
												),
												'
											ELSE ''
										END +
										CASE
											WHEN @get_task_info = 2 THEN
												'CONVERT(XML, x.block_info) AS block_info, 
												'
											ELSE
												''
										END +
										'x.host_process_id 
									FOR XML
										PATH(''additional_info''),
										TYPE
								) '
					ELSE
						'NULL '
				END + 
					'AS additional_info, 
				x.start_time, 
					' +
				CASE
					WHEN
						@output_column_list LIKE '%|[login_time|]%' ESCAPE '|'
						AND @recursion = 1
							THEN
								'x.login_time '
					ELSE 
						'NULL '
				END + 
					'AS login_time, 
				x.last_request_start_time
			FROM
			(
				SELECT TOP(@i)
					y.*,
					CASE
						WHEN DATEDIFF(hour, y.start_time, GETDATE()) > 576 THEN
							DATEDIFF(second, GETDATE(), y.start_time)
						ELSE DATEDIFF(ms, y.start_time, GETDATE())
					END AS elapsed_time,
					COALESCE(tempdb_info.tempdb_allocations, 0) AS tempdb_allocations,
					COALESCE
					(
						CASE
							WHEN tempdb_info.tempdb_current < 0 THEN 0
							ELSE tempdb_info.tempdb_current
						END,
						0
					) AS tempdb_current, 
					' +
					CASE
						WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1
							) THEN
								'N''('' + CONVERT(NVARCHAR, y.wait_duration_ms) + N''ms)'' +
									y.wait_type +
										CASE
											WHEN y.wait_type LIKE N''PAGE%LATCH_%'' THEN
												N'':'' +
												COALESCE(DB_NAME(CONVERT(INT, LEFT(y.resource_description, CHARINDEX(N'':'', y.resource_description) - 1))), N''(null)'') +
												N'':'' +
												SUBSTRING(y.resource_description, CHARINDEX(N'':'', y.resource_description) + 1, LEN(y.resource_description) - CHARINDEX(N'':'', REVERSE(y.resource_description)) - CHARINDEX(N'':'', y.resource_description)) +
												N''('' +
													CASE
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 1 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 8088 = 0
																THEN 
																	N''PFS''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 2 OR
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) % 511232 = 0
																THEN 
																	N''GAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 3 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 1) % 511232 = 0
																THEN
																	N''SGAM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 6 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 6) % 511232 = 0 
																THEN 
																	N''DCM''
														WHEN
															CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) = 7 OR
															(CONVERT(INT, RIGHT(y.resource_description, CHARINDEX(N'':'', REVERSE(y.resource_description)) - 1)) - 7) % 511232 = 0 
																THEN 
																	N''BCM''
														ELSE 
															N''*''
													END +
												N'')''
											WHEN y.wait_type = N''CXPACKET'' THEN
												N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''nodeId'', y.resource_description) + 7, 4)
											WHEN y.wait_type LIKE N''LATCH[_]%'' THEN
												N'' ['' + LEFT(y.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', y.resource_description), 0), LEN(y.resource_description) + 1) - 1) + N'']''
											WHEN
												y.wait_type = N''OLEDB''
												AND y.resource_description LIKE N''%(SPID=%)'' THEN
													N''['' + LEFT(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) - 2) +
														N'':'' + SUBSTRING(y.resource_description, CHARINDEX(N''(SPID='', y.resource_description) + 6, CHARINDEX(N'')'', y.resource_description, (CHARINDEX(N''(SPID='', y.resource_description) + 6)) - (CHARINDEX(N''(SPID='', y.resource_description) + 6)) + '']''
											ELSE
												N''''
										END COLLATE Latin1_General_Bin2 AS sys_wait_info, 
										'
							ELSE
								''
						END +
						CASE
							WHEN @get_task_info = 2 THEN
								'tasks.physical_io,
								tasks.context_switches,
								tasks.tasks,
								tasks.block_info,
								tasks.wait_info AS task_wait_info,
								tasks.thread_CPU_snapshot,
								'
							ELSE
								'' 
					END +
					CASE 
						WHEN NOT (@get_avg_time = 1 AND @recursion = 1) THEN
							'CONVERT(INT, NULL) '
						ELSE 
							'qs.total_elapsed_time / qs.execution_count '
					END + 
						'AS avg_elapsed_time 
				FROM
				(
					SELECT TOP(@i)
						sp.session_id,
						sp.request_id,
						COALESCE(r.logical_reads, s.logical_reads) AS reads,
						COALESCE(r.reads, s.reads) AS physical_reads,
						COALESCE(r.writes, s.writes) AS writes,
						COALESCE(r.CPU_time, s.CPU_time) AS CPU,
						sp.memory_usage + COALESCE(r.granted_query_memory, 0) AS used_memory,
						LOWER(sp.status) AS status,
						COALESCE(r.sql_handle, sp.sql_handle) AS sql_handle,
						COALESCE(r.statement_start_offset, sp.statement_start_offset) AS statement_start_offset,
						COALESCE(r.statement_end_offset, sp.statement_end_offset) AS statement_end_offset,
						' +
						CASE
							WHEN 
							(
								@get_task_info <> 0
								OR @find_block_leaders = 1 
							) THEN
								'sp.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
								sp.wait_resource COLLATE Latin1_General_Bin2 AS resource_description,
								sp.wait_time AS wait_duration_ms, 
								'
							ELSE
								''
						END +
						'NULLIF(sp.blocked, 0) AS blocking_session_id,
						r.plan_handle,
						NULLIF(r.percent_complete, 0) AS percent_complete,
						sp.host_name,
						sp.login_name,
						sp.program_name,
						s.host_process_id,
						COALESCE(r.text_size, s.text_size) AS text_size,
						COALESCE(r.language, s.language) AS language,
						COALESCE(r.date_format, s.date_format) AS date_format,
						COALESCE(r.date_first, s.date_first) AS date_first,
						COALESCE(r.quoted_identifier, s.quoted_identifier) AS quoted_identifier,
						COALESCE(r.arithabort, s.arithabort) AS arithabort,
						COALESCE(r.ansi_null_dflt_on, s.ansi_null_dflt_on) AS ansi_null_dflt_on,
						COALESCE(r.ansi_defaults, s.ansi_defaults) AS ansi_defaults,
						COALESCE(r.ansi_warnings, s.ansi_warnings) AS ansi_warnings,
						COALESCE(r.ansi_padding, s.ansi_padding) AS ansi_padding,
						COALESCE(r.ansi_nulls, s.ansi_nulls) AS ansi_nulls,
						COALESCE(r.concat_null_yields_null, s.concat_null_yields_null) AS concat_null_yields_null,
						COALESCE(r.transaction_isolation_level, s.transaction_isolation_level) AS transaction_isolation_level,
						COALESCE(r.lock_timeout, s.lock_timeout) AS lock_timeout,
						COALESCE(r.deadlock_priority, s.deadlock_priority) AS deadlock_priority,
						COALESCE(r.row_count, s.row_count) AS row_count,
						COALESCE(r.command, sp.cmd) AS command_type,
						COALESCE
						(
							CASE
								WHEN
								(
									s.is_user_process = 0
									AND r.total_elapsed_time >= 0
								) THEN
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									)
							END,
							NULLIF(COALESCE(r.start_time, sp.last_request_end_time), CONVERT(DATETIME, ''19000101'', 112)),
							(
								SELECT TOP(1)
									DATEADD(second, -(ms_ticks / 1000), GETDATE())
								FROM sys.dm_os_sys_info
							)
						) AS start_time,
						sp.login_time,
						CASE
							WHEN s.is_user_process = 1 THEN
								s.last_request_start_time
							ELSE
								COALESCE
								(
									DATEADD
									(
										ms,
										1000 * (DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())) / 500) - DATEPART(ms, DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())),
										DATEADD(second, -(r.total_elapsed_time / 1000), GETDATE())
									),
									s.last_request_start_time
								)
						END AS last_request_start_time,
						r.transaction_id,
						sp.database_id,
						sp.open_tran_count
					FROM @sessions AS sp
					LEFT OUTER LOOP JOIN sys.dm_exec_sessions AS s ON
						s.session_id = sp.session_id
						AND s.login_time = sp.login_time
					LEFT OUTER LOOP JOIN sys.dm_exec_requests AS r ON
						sp.status <> ''sleeping''
						AND r.session_id = sp.session_id
						AND r.request_id = sp.request_id
						AND
						(
							(
								s.is_user_process = 0
								AND sp.is_user_process = 0
							)
							OR
							(
								r.start_time = s.last_request_start_time
								AND s.last_request_end_time <= sp.last_request_end_time
							)
						)
				) AS y
				' + 
				CASE 
					WHEN @get_task_info = 2 THEN
						CONVERT(VARCHAR(MAX), '') +
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								task_nodes.task_node.value(''(session_id/text())[1]'', ''SMALLINT'') AS session_id,
								task_nodes.task_node.value(''(request_id/text())[1]'', ''INT'') AS request_id,
								task_nodes.task_node.value(''(physical_io/text())[1]'', ''BIGINT'') AS physical_io,
								task_nodes.task_node.value(''(context_switches/text())[1]'', ''BIGINT'') AS context_switches,
								task_nodes.task_node.value(''(tasks/text())[1]'', ''INT'') AS tasks,
								task_nodes.task_node.value(''(block_info/text())[1]'', ''NVARCHAR(4000)'') AS block_info,
								task_nodes.task_node.value(''(waits/text())[1]'', ''NVARCHAR(4000)'') AS wait_info,
								task_nodes.task_node.value(''(thread_CPU_snapshot/text())[1]'', ''BIGINT'') AS thread_CPU_snapshot
							FROM
							(
								SELECT TOP(@i)
									CONVERT
									(
										XML,
										REPLACE
										(
											CONVERT(NVARCHAR(MAX), tasks_raw.task_xml_raw) COLLATE Latin1_General_Bin2,
											N''</waits></tasks><tasks><waits>'',
											N'', ''
										)
									) AS task_xml
								FROM
								(
									SELECT TOP(@i)
										CASE waits.r
											WHEN 1 THEN
												waits.session_id
											ELSE
												NULL
										END AS [session_id],
										CASE waits.r
											WHEN 1 THEN
												waits.request_id
											ELSE
												NULL
										END AS [request_id],											
										CASE waits.r
											WHEN 1 THEN
												waits.physical_io
											ELSE
												NULL
										END AS [physical_io],
										CASE waits.r
											WHEN 1 THEN
												waits.context_switches
											ELSE
												NULL
										END AS [context_switches],
										CASE waits.r
											WHEN 1 THEN
												waits.thread_CPU_snapshot
											ELSE
												NULL
										END AS [thread_CPU_snapshot],
										CASE waits.r
											WHEN 1 THEN
												waits.tasks
											ELSE
												NULL
										END AS [tasks],
										CASE waits.r
											WHEN 1 THEN
												waits.block_info
											ELSE
												NULL
										END AS [block_info],
										REPLACE
										(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
											REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												CONVERT
												(
													NVARCHAR(MAX),
													N''('' +
														CONVERT(NVARCHAR, num_waits) + N''x: '' +
														CASE num_waits
															WHEN 1 THEN
																CONVERT(NVARCHAR, min_wait_time) + N''ms''
															WHEN 2 THEN
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
															ELSE
																CASE
																	WHEN min_wait_time <> max_wait_time THEN
																		CONVERT(NVARCHAR, min_wait_time) + N''/'' + CONVERT(NVARCHAR, avg_wait_time) + N''/'' + CONVERT(NVARCHAR, max_wait_time) + N''ms''
																	ELSE 
																		CONVERT(NVARCHAR, max_wait_time) + N''ms''
																END
														END +
													N'')'' + wait_type COLLATE Latin1_General_Bin2
												),
												NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
												NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
												NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
											NCHAR(0),
											N''''
										) AS [waits]
									FROM
									(
										SELECT TOP(@i)
											w1.*,
											ROW_NUMBER() OVER
											(
												PARTITION BY
													w1.session_id,
													w1.request_id
												ORDER BY
													w1.block_info DESC,
													w1.num_waits DESC,
													w1.wait_type
											) AS r
										FROM
										(
											SELECT TOP(@i)
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks AS tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END AS wait_type,
												NULLIF(COUNT(COALESCE(task_info.runnable_time, wt2.waiting_task_address)), 0) AS num_waits,
												MIN(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS min_wait_time,
												AVG(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS avg_wait_time,
												MAX(COALESCE(task_info.runnable_time, wt2.wait_duration_ms)) AS max_wait_time,
												MAX(wt2.block_info) AS block_info
											FROM
											(
												SELECT TOP(@i)
													t.session_id,
													t.request_id,
													SUM(CONVERT(BIGINT, t.pending_io_count)) OVER (PARTITION BY t.session_id, t.request_id) AS physical_io,
													SUM(CONVERT(BIGINT, t.context_switches_count)) OVER (PARTITION BY t.session_id, t.request_id) AS context_switches, 
													' +
													CASE
														WHEN @output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
															THEN
																'SUM(tr.usermode_time + tr.kernel_time) OVER (PARTITION BY t.session_id, t.request_id) '
														ELSE
															'CONVERT(BIGINT, NULL) '
													END + 
														' AS thread_CPU_snapshot, 
													COUNT(*) OVER (PARTITION BY t.session_id, t.request_id) AS num_tasks,
													t.task_address,
													t.task_state,
													CASE
														WHEN
															t.task_state = ''RUNNABLE''
															AND w.runnable_time > 0 THEN
																w.runnable_time
														ELSE
															NULL
													END AS runnable_time
												FROM sys.dm_os_tasks AS t
												CROSS APPLY
												(
													SELECT TOP(1)
														sp2.session_id
													FROM @sessions AS sp2
													WHERE
														sp2.session_id = t.session_id
														AND sp2.request_id = t.request_id
														AND sp2.status <> ''sleeping''
												) AS sp20
												LEFT OUTER HASH JOIN
												(
													SELECT TOP(@i)
														(
															SELECT TOP(@i)
																ms_ticks
															FROM sys.dm_os_sys_info
														) -
															w0.wait_resumed_ms_ticks AS runnable_time,
														w0.worker_address,
														w0.thread_address,
														w0.task_bound_ms_ticks
													FROM sys.dm_os_workers AS w0
													WHERE
														w0.state = ''RUNNABLE''
														OR @first_collection_ms_ticks >= w0.task_bound_ms_ticks
												) AS w ON
													w.worker_address = t.worker_address 
												' +
												CASE
													WHEN @output_column_list LIKE '%|[CPU_delta|]%' ESCAPE '|'
														THEN
															'LEFT OUTER HASH JOIN sys.dm_os_threads AS tr ON
																tr.thread_address = w.thread_address
																AND @first_collection_ms_ticks >= w.task_bound_ms_ticks
															'
													ELSE
														''
												END +
											') AS task_info
											LEFT OUTER HASH JOIN
											(
												SELECT TOP(@i)
													wt1.wait_type,
													wt1.waiting_task_address,
													MAX(wt1.wait_duration_ms) AS wait_duration_ms,
													MAX(wt1.block_info) AS block_info
												FROM
												(
													SELECT DISTINCT TOP(@i)
														wt.wait_type +
															CASE
																WHEN wt.wait_type LIKE N''PAGE%LATCH_%'' THEN
																	'':'' +
																	COALESCE(DB_NAME(CONVERT(INT, LEFT(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) - 1))), N''(null)'') +
																	N'':'' +
																	SUBSTRING(wt.resource_description, CHARINDEX(N'':'', wt.resource_description) + 1, LEN(wt.resource_description) - CHARINDEX(N'':'', REVERSE(wt.resource_description)) - CHARINDEX(N'':'', wt.resource_description)) +
																	N''('' +
																		CASE
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 1 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 8088 = 0
																					THEN 
																						N''PFS''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 2 OR
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) % 511232 = 0 
																					THEN 
																						N''GAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 3 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 1) % 511232 = 0 
																					THEN 
																						N''SGAM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 6 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 6) % 511232 = 0 
																					THEN 
																						N''DCM''
																			WHEN
																				CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) = 7 OR
																				(CONVERT(INT, RIGHT(wt.resource_description, CHARINDEX(N'':'', REVERSE(wt.resource_description)) - 1)) - 7) % 511232 = 0
																					THEN 
																						N''BCM''
																			ELSE
																				N''*''
																		END +
																	N'')''
																WHEN wt.wait_type = N''CXPACKET'' THEN
																	N'':'' + SUBSTRING(wt.resource_description, CHARINDEX(N''nodeId'', wt.resource_description) + 7, 4)
																WHEN wt.wait_type LIKE N''LATCH[_]%'' THEN
																	N'' ['' + LEFT(wt.resource_description, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 1) + N'']''
																ELSE 
																	N''''
															END COLLATE Latin1_General_Bin2 AS wait_type,
														CASE
															WHEN
															(
																wt.blocking_session_id IS NOT NULL
																AND wt.wait_type LIKE N''LCK[_]%''
															) THEN
																(
																	SELECT TOP(@i)
																		x.lock_type,
																		REPLACE
																		(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
																				DB_NAME
																				(
																					CONVERT
																					(
																						INT,
																						SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''dbid='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''dbid='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''dbid='', wt.resource_description) - 5)
																					)
																				),
																				NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''),
																				NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''),
																				NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''),
																			NCHAR(0),
																			N''''
																		) AS database_name,
																		CASE x.lock_type
																			WHEN N''objectlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''objid='', wt.resource_description), 0) + 6, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''objid='', wt.resource_description) + 6), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''objid='', wt.resource_description) - 6)
																			ELSE
																				NULL
																		END AS object_id,
																		CASE x.lock_type
																			WHEN N''filelock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''fileid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''fileid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''fileid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS file_id,
																		CASE
																			WHEN x.lock_type in (N''pagelock'', N''extentlock'', N''ridlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''associatedObjectId='', wt.resource_description), 0) + 19, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''associatedObjectId='', wt.resource_description) + 19), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''associatedObjectId='', wt.resource_description) - 19)
																			WHEN x.lock_type in (N''keylock'', N''hobtlock'', N''allocunitlock'') THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hobtid='', wt.resource_description), 0) + 7, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hobtid='', wt.resource_description) + 7), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hobtid='', wt.resource_description) - 7)
																			ELSE
																				NULL
																		END AS hobt_id,
																		CASE x.lock_type
																			WHEN N''applicationlock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''hash='', wt.resource_description), 0) + 5, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''hash='', wt.resource_description) + 5), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''hash='', wt.resource_description) - 5)
																			ELSE
																				NULL
																		END AS applock_hash,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''subresource='', wt.resource_description), 0) + 12, COALESCE(NULLIF(CHARINDEX(N'' '', wt.resource_description, CHARINDEX(N''subresource='', wt.resource_description) + 12), 0), LEN(wt.resource_description) + 1) - CHARINDEX(N''subresource='', wt.resource_description) - 12)
																			ELSE
																				NULL
																		END AS metadata_resource,
																		CASE x.lock_type
																			WHEN N''metadatalock'' THEN
																				SUBSTRING(wt.resource_description, NULLIF(CHARINDEX(N''classid='', wt.resource_description), 0) + 8, COALESCE(NULLIF(CHARINDEX(N'' dbid='', wt.resource_description) - CHARINDEX(N''classid='', wt.resource_description), 0), LEN(wt.resource_description) + 1) - 8)
																			ELSE
																				NULL
																		END AS metadata_class_id
																	FROM
																	(
																		SELECT TOP(1)
																			LEFT(wt.resource_description, CHARINDEX(N'' '', wt.resource_description) - 1) COLLATE Latin1_General_Bin2 AS lock_type
																	) AS x
																	FOR XML
																		PATH('''')
																)
															ELSE NULL
														END AS block_info,
														wt.wait_duration_ms,
														wt.waiting_task_address
													FROM
													(
														SELECT TOP(@i)
															wt0.wait_type COLLATE Latin1_General_Bin2 AS wait_type,
															wt0.resource_description COLLATE Latin1_General_Bin2 AS resource_description,
															wt0.wait_duration_ms,
															wt0.waiting_task_address,
															CASE
																WHEN wt0.blocking_session_id = p.blocked THEN
																	wt0.blocking_session_id
																ELSE
																	NULL
															END AS blocking_session_id
														FROM sys.dm_os_waiting_tasks AS wt0
														CROSS APPLY
														(
															SELECT TOP(1)
																s0.blocked
															FROM @sessions AS s0
															WHERE
																s0.session_id = wt0.session_id
																AND COALESCE(s0.wait_type, N'''') <> N''OLEDB''
																AND wt0.wait_type <> N''OLEDB''
														) AS p
													) AS wt
												) AS wt1
												GROUP BY
													wt1.wait_type,
													wt1.waiting_task_address
											) AS wt2 ON
												wt2.waiting_task_address = task_info.task_address
												AND wt2.wait_duration_ms > 0
												AND task_info.runnable_time IS NULL
											GROUP BY
												task_info.session_id,
												task_info.request_id,
												task_info.physical_io,
												task_info.context_switches,
												task_info.thread_CPU_snapshot,
												task_info.num_tasks,
												CASE
													WHEN task_info.runnable_time IS NOT NULL THEN
														''RUNNABLE''
													ELSE
														wt2.wait_type
												END
										) AS w1
									) AS waits
									ORDER BY
										waits.session_id,
										waits.request_id,
										waits.r
									FOR XML
										PATH(N''tasks''),
										TYPE
								) AS tasks_raw (task_xml_raw)
							) AS tasks_final
							CROSS APPLY tasks_final.task_xml.nodes(N''/tasks'') AS task_nodes (task_node)
							WHERE
								task_nodes.task_node.exist(N''session_id'') = 1
						) AS tasks ON
							tasks.session_id = y.session_id
							AND tasks.request_id = y.request_id 
						'
					ELSE
						''
				END +
				'LEFT OUTER HASH JOIN
				(
					SELECT TOP(@i)
						t_info.session_id,
						COALESCE(t_info.request_id, -1) AS request_id,
						SUM(t_info.tempdb_allocations) AS tempdb_allocations,
						SUM(t_info.tempdb_current) AS tempdb_current
					FROM
					(
						SELECT TOP(@i)
							tsu.session_id,
							tsu.request_id,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count AS tempdb_allocations,
							tsu.user_objects_alloc_page_count +
								tsu.internal_objects_alloc_page_count -
								tsu.user_objects_dealloc_page_count -
								tsu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_task_space_usage AS tsu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = tsu.session_id
						) AS p

						UNION ALL

						SELECT TOP(@i)
							ssu.session_id,
							NULL AS request_id,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count AS tempdb_allocations,
							ssu.user_objects_alloc_page_count +
								ssu.internal_objects_alloc_page_count -
								ssu.user_objects_dealloc_page_count -
								ssu.internal_objects_dealloc_page_count AS tempdb_current
						FROM sys.dm_db_session_space_usage AS ssu
						CROSS APPLY
						(
							SELECT TOP(1)
								s0.session_id
							FROM @sessions AS s0
							WHERE
								s0.session_id = ssu.session_id
						) AS p
					) AS t_info
					GROUP BY
						t_info.session_id,
						COALESCE(t_info.request_id, -1)
				) AS tempdb_info ON
					tempdb_info.session_id = y.session_id
					AND tempdb_info.request_id =
						CASE
							WHEN y.status = N''sleeping'' THEN
								-1
							ELSE
								y.request_id
						END
				' +
				CASE 
					WHEN 
						NOT 
						(
							@get_avg_time = 1 
							AND @recursion = 1
						) THEN 
							''
					ELSE
						'LEFT OUTER HASH JOIN
						(
							SELECT TOP(@i)
								*
							FROM sys.dm_exec_query_stats
						) AS qs ON
							qs.sql_handle = y.sql_handle
							AND qs.plan_handle = y.plan_handle
							AND qs.statement_start_offset = y.statement_start_offset
							AND qs.statement_end_offset = y.statement_end_offset
						'
				END + 
			') AS x
			OPTION (KEEPFIXED PLAN, OPTIMIZE FOR (@i = 1)); ';

		SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

		SET @last_collection_start = GETDATE();

		IF @recursion = -1
		BEGIN;
			SELECT
				@first_collection_ms_ticks = ms_ticks
			FROM sys.dm_os_sys_info;
		END;

		INSERT #sessions
		(
			recursion,
			session_id,
			request_id,
			session_number,
			elapsed_time,
			avg_elapsed_time,
			physical_io,
			reads,
			physical_reads,
			writes,
			tempdb_allocations,
			tempdb_current,
			CPU,
			thread_CPU_snapshot,
			context_switches,
			used_memory,
			tasks,
			status,
			wait_info,
			transaction_id,
			open_tran_count,
			sql_handle,
			statement_start_offset,
			statement_end_offset,		
			sql_text,
			plan_handle,
			blocking_session_id,
			percent_complete,
			host_name,
			login_name,
			database_name,
			program_name,
			additional_info,
			start_time,
			login_time,
			last_request_start_time
		)
		EXEC sp_executesql 
			@sql_n,
			N'@recursion SMALLINT, @filter sysname, @not_filter sysname, @first_collection_ms_ticks BIGINT',
			@recursion, @filter, @not_filter, @first_collection_ms_ticks;

		--Collect transaction information?
		IF
			@recursion = 1
			AND
			(
				@output_column_list LIKE '%|[tran_start_time|]%' ESCAPE '|'
				OR @output_column_list LIKE '%|[tran_log_writes|]%' ESCAPE '|' 
			)
		BEGIN;	
			DECLARE @i INT;
			SET @i = 2147483647;

			UPDATE s
			SET
				tran_start_time =
					CONVERT
					(
						DATETIME,
						LEFT
						(
							x.trans_info,
							NULLIF(CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info) - 1, -1)
						),
						121
					),
				tran_log_writes =
					RIGHT
					(
						x.trans_info,
						LEN(x.trans_info) - CHARINDEX(NCHAR(254) COLLATE Latin1_General_Bin2, x.trans_info)
					)
			FROM
			(
				SELECT TOP(@i)
					trans_nodes.trans_node.value('(session_id/text())[1]', 'SMALLINT') AS session_id,
					COALESCE(trans_nodes.trans_node.value('(request_id/text())[1]', 'INT'), 0) AS request_id,
					trans_nodes.trans_node.value('(trans_info/text())[1]', 'NVARCHAR(4000)') AS trans_info				
				FROM
				(
					SELECT TOP(@i)
						CONVERT
						(
							XML,
							REPLACE
							(
								CONVERT(NVARCHAR(MAX), trans_raw.trans_xml_raw) COLLATE Latin1_General_Bin2, 
								N'</trans_info></trans><trans><trans_info>', N''
							)
						)
					FROM
					(
						SELECT TOP(@i)
							CASE u_trans.r
								WHEN 1 THEN u_trans.session_id
								ELSE NULL
							END AS [session_id],
							CASE u_trans.r
								WHEN 1 THEN u_trans.request_id
								ELSE NULL
							END AS [request_id],
							CONVERT
							(
								NVARCHAR(MAX),
								CASE
									WHEN u_trans.database_id IS NOT NULL THEN
										CASE u_trans.r
											WHEN 1 THEN COALESCE(CONVERT(NVARCHAR, u_trans.transaction_start_time, 121) + NCHAR(254), N'')
											ELSE N''
										END + 
											REPLACE
											(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
												REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
													CONVERT(VARCHAR(128), COALESCE(DB_NAME(u_trans.database_id), N'(null)')),
													NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
													NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
													NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
												NCHAR(0),
												N'?'
											) +
											N': ' +
										CONVERT(NVARCHAR, u_trans.log_record_count) + N' (' + CONVERT(NVARCHAR, u_trans.log_kb_used) + N' kB)' +
										N','
									ELSE
										N'N/A,'
								END COLLATE Latin1_General_Bin2
							) AS [trans_info]
						FROM
						(
							SELECT TOP(@i)
								trans.*,
								ROW_NUMBER() OVER
								(
									PARTITION BY
										trans.session_id,
										trans.request_id
									ORDER BY
										trans.transaction_start_time DESC
								) AS r
							FROM
							(
								SELECT TOP(@i)
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id,
									COALESCE(SUM(s_tran.database_transaction_log_record_count), 0) AS log_record_count,
									COALESCE(SUM(s_tran.database_transaction_log_bytes_used), 0) / 1024 AS log_kb_used,
									MIN(s_tran.database_transaction_begin_time) AS transaction_start_time
								FROM
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_active_transactions
									WHERE
										transaction_begin_time <= @last_collection_start
								) AS a_tran
								INNER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_database_transactions
									WHERE
										database_id < 32767
								) AS s_tran ON
									s_tran.transaction_id = a_tran.transaction_id
								LEFT OUTER HASH JOIN
								(
									SELECT TOP(@i)
										*
									FROM sys.dm_tran_session_transactions
								) AS tst ON
									s_tran.transaction_id = tst.transaction_id
								CROSS APPLY
								(
									SELECT TOP(1)
										s3.session_id,
										s3.request_id
									FROM
									(
										SELECT TOP(1)
											s1.session_id,
											s1.request_id
										FROM #sessions AS s1
										WHERE
											s1.transaction_id = s_tran.transaction_id
											AND s1.recursion = 1
											
										UNION ALL
									
										SELECT TOP(1)
											s2.session_id,
											s2.request_id
										FROM #sessions AS s2
										WHERE
											s2.session_id = tst.session_id
											AND s2.recursion = 1
									) AS s3
									ORDER BY
										s3.request_id
								) AS session_tran_map
								GROUP BY
									session_tran_map.session_id,
									session_tran_map.request_id,
									s_tran.database_id
							) AS trans
						) AS u_trans
						FOR XML
							PATH('trans'),
							TYPE
					) AS trans_raw (trans_xml_raw)
				) AS trans_final (trans_xml)
				CROSS APPLY trans_final.trans_xml.nodes('/trans') AS trans_nodes (trans_node)
			) AS x
			INNER HASH JOIN #sessions AS s ON
				s.session_id = x.session_id
				AND s.request_id = x.request_id
			OPTION (OPTIMIZE FOR (@i = 1));
		END;

		--Variables for text and plan collection
		DECLARE	
			@session_id SMALLINT,
			@request_id INT,
			@sql_handle VARBINARY(64),
			@plan_handle VARBINARY(64),
			@statement_start_offset INT,
			@statement_end_offset INT,
			@start_time DATETIME,
			@database_name sysname;

		IF 
			@recursion = 1
			AND @output_column_list LIKE '%|[sql_text|]%' ESCAPE '|'
		BEGIN;
			DECLARE sql_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					request_id,
					sql_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND sql_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN sql_cursor;

			FETCH NEXT FROM sql_cursor
			INTO 
				@session_id,
				@request_id,
				@sql_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for the SQL text, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					UPDATE s
					SET
						s.sql_text =
						(
							SELECT
								REPLACE
								(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
										N'--' + NCHAR(13) + NCHAR(10) +
										CASE 
											WHEN @get_full_inner_text = 1 THEN est.text
											WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN est.text
											WHEN SUBSTRING(est.text, (@statement_start_offset/2), 2) LIKE N'[a-zA-Z0-9][a-zA-Z0-9]' THEN est.text
											ELSE
												CASE
													WHEN @statement_start_offset > 0 THEN
														SUBSTRING
														(
															est.text,
															((@statement_start_offset/2) + 1),
															(
																CASE
																	WHEN @statement_end_offset = -1 THEN 2147483647
																	ELSE ((@statement_end_offset - @statement_start_offset)/2) + 1
																END
															)
														)
													ELSE RTRIM(LTRIM(est.text))
												END
										END +
										NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2,
										NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
										NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
										NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
									NCHAR(0),
									N''
								) AS [processing-instruction(query)]
							FOR XML
								PATH(''),
								TYPE
						),
						s.statement_start_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN 0
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN 0
								ELSE @statement_start_offset
							END,
						s.statement_end_offset = 
							CASE 
								WHEN LEN(est.text) < (@statement_end_offset / 2) + 1 THEN -1
								WHEN SUBSTRING(CONVERT(VARCHAR(MAX), est.text), (@statement_start_offset/2), 2) LIKE '[a-zA-Z0-9][a-zA-Z0-9]' THEN -1
								ELSE @statement_end_offset
							END
					FROM 
						#sessions AS s,
						(
							SELECT TOP(1)
								text
							FROM
							(
								SELECT 
									text, 
									0 AS row_num
								FROM sys.dm_exec_sql_text(@sql_handle)
								
								UNION ALL
								
								SELECT 
									NULL,
									1 AS row_num
							) AS est0
							ORDER BY
								row_num
						) AS est
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END TRY
				BEGIN CATCH;
					UPDATE s
					SET
						s.sql_text = 
							CASE ERROR_NUMBER() 
								WHEN 1222 THEN '<timeout_exceeded />'
								ELSE '<error message="' + ERROR_MESSAGE() + '" />'
							END
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM sql_cursor
				INTO
					@session_id,
					@request_id,
					@sql_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE sql_cursor;
			DEALLOCATE sql_cursor;
		END;

		IF 
			@get_outer_command = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[sql_command|]%' ESCAPE '|'
		BEGIN;
			DECLARE @buffer_results TABLE
			(
				EventType VARCHAR(30),
				Parameters INT,
				EventInfo NVARCHAR(4000),
				start_time DATETIME,
				session_number INT IDENTITY(1,1) NOT NULL PRIMARY KEY
			);

			DECLARE buffer_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT 
					session_id,
					MAX(start_time) AS start_time
				FROM #sessions
				WHERE
					recursion = 1
				GROUP BY
					session_id
				ORDER BY
					session_id
				OPTION (KEEPFIXED PLAN);

			OPEN buffer_cursor;

			FETCH NEXT FROM buffer_cursor
			INTO 
				@session_id,
				@start_time;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					--In SQL Server 2008, DBCC INPUTBUFFER will throw 
					--an exception if the session no longer exists
					INSERT @buffer_results
					(
						EventType,
						Parameters,
						EventInfo
					)
					EXEC sp_executesql
						N'DBCC INPUTBUFFER(@session_id) WITH NO_INFOMSGS;',
						N'@session_id SMALLINT',
						@session_id;

					UPDATE br
					SET
						br.start_time = @start_time
					FROM @buffer_results AS br
					WHERE
						br.session_number = 
						(
							SELECT MAX(br2.session_number)
							FROM @buffer_results br2
						);
				END TRY
				BEGIN CATCH
				END CATCH;

				FETCH NEXT FROM buffer_cursor
				INTO 
					@session_id,
					@start_time;
			END;

			UPDATE s
			SET
				sql_command = 
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX),
									N'--' + NCHAR(13) + NCHAR(10) + br.EventInfo + NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [processing-instruction(query)]
					FROM @buffer_results AS br
					WHERE 
						br.session_number = s.session_number
						AND br.start_time = s.start_time
						AND 
						(
							(
								s.start_time = s.last_request_start_time
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_requests r2
									WHERE
										r2.session_id = s.session_id
										AND r2.request_id = s.request_id
										AND r2.start_time = s.start_time
								)
							)
							OR 
							(
								s.request_id = 0
								AND EXISTS
								(
									SELECT *
									FROM sys.dm_exec_sessions s2
									WHERE
										s2.session_id = s.session_id
										AND s2.last_request_start_time = s.last_request_start_time
								)
							)
						)
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions AS s
			WHERE
				recursion = 1
			OPTION (KEEPFIXED PLAN);

			CLOSE buffer_cursor;
			DEALLOCATE buffer_cursor;
		END;

		IF 
			@get_plans >= 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[query_plan|]%' ESCAPE '|'
		BEGIN;
			DECLARE plan_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					session_id,
					request_id,
					plan_handle,
					statement_start_offset,
					statement_end_offset
				FROM #sessions
				WHERE
					recursion = 1
					AND plan_handle IS NOT NULL
			OPTION (KEEPFIXED PLAN);

			OPEN plan_cursor;

			FETCH NEXT FROM plan_cursor
			INTO 
				@session_id,
				@request_id,
				@plan_handle,
				@statement_start_offset,
				@statement_end_offset;

			--Wait up to 5 ms for a query plan, then give up
			SET LOCK_TIMEOUT 5;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					UPDATE s
					SET
						s.query_plan =
						(
							SELECT
								CONVERT(xml, query_plan)
							FROM sys.dm_exec_text_query_plan
							(
								@plan_handle, 
								CASE @get_plans
									WHEN 1 THEN
										@statement_start_offset
									ELSE
										0
								END, 
								CASE @get_plans
									WHEN 1 THEN
										@statement_end_offset
									ELSE
										-1
								END
							)
						)
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.request_id = @request_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END TRY
				BEGIN CATCH;
					IF ERROR_NUMBER() = 6335
					BEGIN;
						UPDATE s
						SET
							s.query_plan =
							(
								SELECT
									N'--' + NCHAR(13) + NCHAR(10) + 
									N'-- Could not render showplan due to XML data type limitations. ' + NCHAR(13) + NCHAR(10) + 
									N'-- To see the graphical plan save the XML below as a .SQLPLAN file and re-open in SSMS.' + NCHAR(13) + NCHAR(10) +
									N'--' + NCHAR(13) + NCHAR(10) +
										REPLACE(qp.query_plan, N'<RelOp', NCHAR(13)+NCHAR(10)+N'<RelOp') + 
										NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2 AS [processing-instruction(query_plan)]
								FROM sys.dm_exec_text_query_plan
								(
									@plan_handle, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_start_offset
										ELSE
											0
									END, 
									CASE @get_plans
										WHEN 1 THEN
											@statement_end_offset
										ELSE
											-1
									END
								) AS qp
								FOR XML
									PATH(''),
									TYPE
							)
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.request_id = @request_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END;
					ELSE
					BEGIN;
						UPDATE s
						SET
							s.query_plan = 
								CASE ERROR_NUMBER() 
									WHEN 1222 THEN '<timeout_exceeded />'
									ELSE '<error message="' + ERROR_MESSAGE() + '" />'
								END
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
							AND s.request_id = @request_id
							AND s.recursion = 1
						OPTION (KEEPFIXED PLAN);
					END;
				END CATCH;

				FETCH NEXT FROM plan_cursor
				INTO
					@session_id,
					@request_id,
					@plan_handle,
					@statement_start_offset,
					@statement_end_offset;
			END;

			--Return this to the default
			SET LOCK_TIMEOUT -1;

			CLOSE plan_cursor;
			DEALLOCATE plan_cursor;
		END;

		IF 
			@get_locks = 1 
			AND @recursion = 1
			AND @output_column_list LIKE '%|[locks|]%' ESCAPE '|'
		BEGIN;
			DECLARE locks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT DISTINCT
					database_name
				FROM #locks
				WHERE
					EXISTS
					(
						SELECT *
						FROM #sessions AS s
						WHERE
							s.session_id = #locks.session_id
							AND recursion = 1
					)
					AND database_name <> '(null)'
				OPTION (KEEPFIXED PLAN);

			OPEN locks_cursor;

			FETCH NEXT FROM locks_cursor
			INTO 
				@database_name;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = CONVERT(NVARCHAR(MAX), '') +
						'UPDATE l ' +
						'SET ' +
							'object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'index_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'i.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'principal_name = ' + 
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'dp.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #locks AS l ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.allocation_units AS au ON ' +
							'au.allocation_unit_id = l.allocation_unit_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = ' +
								'COALESCE ' +
								'( ' +
									'l.hobt_id, ' +
									'CASE ' +
										'WHEN au.type IN (1, 3) THEN au.container_id ' +
										'ELSE NULL ' +
									'END ' +
								') ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p1 ON ' +
							'l.hobt_id IS NULL ' +
							'AND au.type = 2 ' +
							'AND p1.partition_id = au.container_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.indexes AS i ON ' +
							'i.object_id = COALESCE(l.object_id, p.object_id, p1.object_id) ' +
							'AND i.index_id = COALESCE(l.index_id, p.index_id, p1.index_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(l.schema_id, o.schema_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.database_principals AS dp ON ' +
							'dp.principal_id = l.principal_id ' +
						'WHERE ' +
							'l.database_name = @database_name ' +
						'OPTION (KEEPFIXED PLAN); ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #locks
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE 
						database_name = @database_name
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM locks_cursor
				INTO
					@database_name;
			END;

			CLOSE locks_cursor;
			DEALLOCATE locks_cursor;

			CREATE CLUSTERED INDEX IX_SRD ON #locks (session_id, request_id, database_name);

			UPDATE s
			SET 
				s.locks =
				(
					SELECT 
						REPLACE
						(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
							REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								CONVERT
								(
									NVARCHAR(MAX), 
									l1.database_name COLLATE Latin1_General_Bin2
								),
								NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
								NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
								NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
							NCHAR(0),
							N''
						) AS [Database/@name],
						MIN(l1.query_error) AS [Database/@query_error],
						(
							SELECT 
								l2.request_mode AS [Lock/@request_mode],
								l2.request_status AS [Lock/@request_status],
								COUNT(*) AS [Lock/@request_count]
							FROM #locks AS l2
							WHERE 
								l1.session_id = l2.session_id
								AND l1.request_id = l2.request_id
								AND l2.database_name = l1.database_name
								AND l2.resource_type = 'DATABASE'
							GROUP BY
								l2.request_mode,
								l2.request_status
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Locks],
						(
							SELECT
								COALESCE(l3.object_name, '(null)') AS [Object/@name],
								l3.schema_name AS [Object/@schema_name],
								(
									SELECT
										l4.resource_type AS [Lock/@resource_type],
										l4.page_type AS [Lock/@page_type],
										l4.index_name AS [Lock/@index_name],
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END AS [Lock/@schema_name],
										l4.principal_name AS [Lock/@principal_name],
										l4.resource_description AS [Lock/@resource_description],
										l4.request_mode AS [Lock/@request_mode],
										l4.request_status AS [Lock/@request_status],
										SUM(l4.request_count) AS [Lock/@request_count]
									FROM #locks AS l4
									WHERE 
										l4.session_id = l3.session_id
										AND l4.request_id = l3.request_id
										AND l3.database_name = l4.database_name
										AND COALESCE(l3.object_name, '(null)') = COALESCE(l4.object_name, '(null)')
										AND COALESCE(l3.schema_name, '') = COALESCE(l4.schema_name, '')
										AND l4.resource_type <> 'DATABASE'
									GROUP BY
										l4.resource_type,
										l4.page_type,
										l4.index_name,
										CASE 
											WHEN l4.object_name IS NULL THEN l4.schema_name
											ELSE NULL
										END,
										l4.principal_name,
										l4.resource_description,
										l4.request_mode,
										l4.request_status
									FOR XML
										PATH(''),
										TYPE
								) AS [Object/Locks]
							FROM #locks AS l3
							WHERE 
								l3.session_id = l1.session_id
								AND l3.request_id = l1.request_id
								AND l3.database_name = l1.database_name
								AND l3.resource_type <> 'DATABASE'
							GROUP BY 
								l3.session_id,
								l3.request_id,
								l3.database_name,
								COALESCE(l3.object_name, '(null)'),
								l3.schema_name
							FOR XML
								PATH(''),
								TYPE
						) AS [Database/Objects]
					FROM #locks AS l1
					WHERE
						l1.session_id = s.session_id
						AND l1.request_id = s.request_id
						AND l1.start_time IN (s.start_time, s.last_request_start_time)
						AND s.recursion = 1
					GROUP BY 
						l1.session_id,
						l1.request_id,
						l1.database_name
					FOR XML
						PATH(''),
						TYPE
				)
			FROM #sessions s
			OPTION (KEEPFIXED PLAN);
		END;

		IF 
			@find_block_leaders = 1
			AND @recursion = 1
			AND @output_column_list LIKE '%|[blocked_session_count|]%' ESCAPE '|'
		BEGIN;
			WITH
			blockers AS
			(
				SELECT
					session_id,
					session_id AS top_level_session_id,
					CONVERT(VARCHAR(8000), '.' + CONVERT(VARCHAR(8000), session_id) + '.') AS the_path
				FROM #sessions
				WHERE
					recursion = 1

				UNION ALL

				SELECT
					s.session_id,
					b.top_level_session_id,
					CONVERT(VARCHAR(8000), b.the_path + CONVERT(VARCHAR(8000), s.session_id) + '.') AS the_path
				FROM blockers AS b
				JOIN #sessions AS s ON
					s.blocking_session_id = b.session_id
					AND s.recursion = 1
					AND b.the_path NOT LIKE '%.' + CONVERT(VARCHAR(8000), s.session_id) + '.%' COLLATE Latin1_General_Bin2
			)
			UPDATE s
			SET
				s.blocked_session_count = x.blocked_session_count
			FROM #sessions AS s
			JOIN
			(
				SELECT
					b.top_level_session_id AS session_id,
					COUNT(*) - 1 AS blocked_session_count
				FROM blockers AS b
				GROUP BY
					b.top_level_session_id
			) x ON
				s.session_id = x.session_id
			WHERE
				s.recursion = 1;
		END;

		IF
			@get_task_info = 2
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
		BEGIN;
			CREATE TABLE #blocked_requests
			(
				session_id SMALLINT NOT NULL,
				request_id INT NOT NULL,
				database_name sysname NOT NULL,
				object_id INT,
				hobt_id BIGINT,
				schema_id INT,
				schema_name sysname NULL,
				object_name sysname NULL,
				query_error NVARCHAR(2048),
				PRIMARY KEY (database_name, session_id, request_id)
			);

			CREATE STATISTICS s_database_name ON #blocked_requests (database_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_schema_name ON #blocked_requests (schema_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_object_name ON #blocked_requests (object_name)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
			CREATE STATISTICS s_query_error ON #blocked_requests (query_error)
			WITH SAMPLE 0 ROWS, NORECOMPUTE;
		
			INSERT #blocked_requests
			(
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				schema_id
			)
			SELECT
				session_id,
				request_id,
				database_name,
				object_id,
				hobt_id,
				CONVERT(INT, SUBSTRING(schema_node, CHARINDEX(' = ', schema_node) + 3, LEN(schema_node))) AS schema_id
			FROM
			(
				SELECT
					session_id,
					request_id,
					agent_nodes.agent_node.value('(database_name/text())[1]', 'sysname') AS database_name,
					agent_nodes.agent_node.value('(object_id/text())[1]', 'int') AS object_id,
					agent_nodes.agent_node.value('(hobt_id/text())[1]', 'bigint') AS hobt_id,
					agent_nodes.agent_node.value('(metadata_resource/text()[.="SCHEMA"]/../../metadata_class_id/text())[1]', 'varchar(100)') AS schema_node
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//block_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			) AS t
			WHERE
				t.database_name IS NOT NULL
				AND
				(
					t.object_id IS NOT NULL
					OR t.hobt_id IS NOT NULL
					OR t.schema_node IS NOT NULL
				);
			
			DECLARE blocks_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR
				SELECT DISTINCT
					database_name
				FROM #blocked_requests;
				
			OPEN blocks_cursor;
			
			FETCH NEXT FROM blocks_cursor
			INTO 
				@database_name;
			
			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					SET @sql_n = 
						CONVERT(NVARCHAR(MAX), '') +
						'UPDATE b ' +
						'SET ' +
							'b.schema_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										's.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								'), ' +
							'b.object_name = ' +
								'REPLACE ' +
								'( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
									'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( ' +
										'o.name COLLATE Latin1_General_Bin2, ' +
										'NCHAR(31),N''?''),NCHAR(30),N''?''),NCHAR(29),N''?''),NCHAR(28),N''?''),NCHAR(27),N''?''),NCHAR(26),N''?''),NCHAR(25),N''?''),NCHAR(24),N''?''),NCHAR(23),N''?''),NCHAR(22),N''?''), ' +
										'NCHAR(21),N''?''),NCHAR(20),N''?''),NCHAR(19),N''?''),NCHAR(18),N''?''),NCHAR(17),N''?''),NCHAR(16),N''?''),NCHAR(15),N''?''),NCHAR(14),N''?''),NCHAR(12),N''?''), ' +
										'NCHAR(11),N''?''),NCHAR(8),N''?''),NCHAR(7),N''?''),NCHAR(6),N''?''),NCHAR(5),N''?''),NCHAR(4),N''?''),NCHAR(3),N''?''),NCHAR(2),N''?''),NCHAR(1),N''?''), ' +
									'NCHAR(0), ' +
									N''''' ' +
								') ' +
						'FROM #blocked_requests AS b ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.partitions AS p ON ' +
							'p.hobt_id = b.hobt_id ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.objects AS o ON ' +
							'o.object_id = COALESCE(p.object_id, b.object_id) ' +
						'LEFT OUTER JOIN ' + QUOTENAME(@database_name) + '.sys.schemas AS s ON ' +
							's.schema_id = COALESCE(o.schema_id, b.schema_id) ' +
						'WHERE ' +
							'b.database_name = @database_name; ';
					
					EXEC sp_executesql
						@sql_n,
						N'@database_name sysname',
						@database_name;
				END TRY
				BEGIN CATCH;
					UPDATE #blocked_requests
					SET
						query_error = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									CONVERT
									(
										NVARCHAR(MAX), 
										ERROR_MESSAGE() COLLATE Latin1_General_Bin2
									),
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N''
							)
					WHERE
						database_name = @database_name;
				END CATCH;

				FETCH NEXT FROM blocks_cursor
				INTO
					@database_name;
			END;
			
			CLOSE blocks_cursor;
			DEALLOCATE blocks_cursor;
			
			UPDATE s
			SET
				additional_info.modify
				('
					insert <schema_name>{sql:column("b.schema_name")}</schema_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.schema_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <object_name>{sql:column("b.object_name")}</object_name>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.object_name IS NOT NULL;

			UPDATE s
			SET
				additional_info.modify
				('
					insert <query_error>{sql:column("b.query_error")}</query_error>
					as last
					into (/additional_info/block_info)[1]
				')
			FROM #sessions AS s
			INNER JOIN #blocked_requests AS b ON
				b.session_id = s.session_id
				AND b.request_id = s.request_id
				AND s.recursion = 1
			WHERE
				b.query_error IS NOT NULL;
		END;

		IF
			@output_column_list LIKE '%|[program_name|]%' ESCAPE '|'
			AND @output_column_list LIKE '%|[additional_info|]%' ESCAPE '|'
			AND @recursion = 1
		BEGIN;
			DECLARE @job_id UNIQUEIDENTIFIER;
			DECLARE @step_id INT;

			DECLARE agent_cursor
			CURSOR LOCAL FAST_FORWARD
			FOR 
				SELECT
					s.session_id,
					agent_nodes.agent_node.value('(job_id/text())[1]', 'uniqueidentifier') AS job_id,
					agent_nodes.agent_node.value('(step_id/text())[1]', 'int') AS step_id
				FROM #sessions AS s
				CROSS APPLY s.additional_info.nodes('//agent_job_info') AS agent_nodes (agent_node)
				WHERE
					s.recursion = 1
			OPTION (KEEPFIXED PLAN);
			
			OPEN agent_cursor;

			FETCH NEXT FROM agent_cursor
			INTO 
				@session_id,
				@job_id,
				@step_id;

			WHILE @@FETCH_STATUS = 0
			BEGIN;
				BEGIN TRY;
					DECLARE @job_name sysname;
					SET @job_name = NULL;
					DECLARE @step_name sysname;
					SET @step_name = NULL;
					
					SELECT
						@job_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									j.name,
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N'?'
							),
						@step_name = 
							REPLACE
							(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
								REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
									s.step_name,
									NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
									NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
									NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
								NCHAR(0),
								N'?'
							)
					FROM msdb.dbo.sysjobs AS j
					INNER JOIN msdb..sysjobsteps AS s ON
						j.job_id = s.job_id
					WHERE
						j.job_id = @job_id
						AND s.step_id = @step_id;

					IF @job_name IS NOT NULL
					BEGIN;
						UPDATE s
						SET
							additional_info.modify
							('
								insert text{sql:variable("@job_name")}
								into (/additional_info/agent_job_info/job_name)[1]
							')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
						OPTION (KEEPFIXED PLAN);
						
						UPDATE s
						SET
							additional_info.modify
							('
								insert text{sql:variable("@step_name")}
								into (/additional_info/agent_job_info/step_name)[1]
							')
						FROM #sessions AS s
						WHERE 
							s.session_id = @session_id
						OPTION (KEEPFIXED PLAN);
					END;
				END TRY
				BEGIN CATCH;
					DECLARE @msdb_error_message NVARCHAR(256);
					SET @msdb_error_message = ERROR_MESSAGE();
				
					UPDATE s
					SET
						additional_info.modify
						('
							insert <msdb_query_error>{sql:variable("@msdb_error_message")}</msdb_query_error>
							as last
							into (/additional_info/agent_job_info)[1]
						')
					FROM #sessions AS s
					WHERE 
						s.session_id = @session_id
						AND s.recursion = 1
					OPTION (KEEPFIXED PLAN);
				END CATCH;

				FETCH NEXT FROM agent_cursor
				INTO 
					@session_id,
					@job_id,
					@step_id;
			END;

			CLOSE agent_cursor;
			DEALLOCATE agent_cursor;
		END; 
		
		IF 
			@delta_interval > 0 
			AND @recursion <> 1
		BEGIN;
			SET @recursion = 1;

			DECLARE @delay_time CHAR(12);
			SET @delay_time = CONVERT(VARCHAR, DATEADD(second, @delta_interval, 0), 114);
			WAITFOR DELAY @delay_time;

			GOTO REDO;
		END;
	END;

	SET @sql = 
		--Outer column list
		CONVERT
		(
			VARCHAR(MAX),
			CASE
				WHEN 
					@destination_table <> '' 
					AND @return_schema = 0 
						THEN 'INSERT ' + @destination_table + ' '
				ELSE ''
			END +
			'SELECT ' +
				@output_column_list + ' ' +
			CASE @return_schema
				WHEN 1 THEN 'INTO #session_schema '
				ELSE ''
			END
		--End outer column list
		) + 
		--Inner column list
		CONVERT
		(
			VARCHAR(MAX),
			'FROM ' +
			'( ' +
				'SELECT ' +
					'session_id, ' +
					--[dd hh:mm:ss.mss]
					CASE
						WHEN @format_output IN (1, 2) THEN
							'CASE ' +
								'WHEN elapsed_time < 0 THEN ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, (-1 * elapsed_time) / 86400), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, (-1 * elapsed_time), 0), 120), ' +
											'9 ' +
										') + ' +
										'''.000'' ' +
								'ELSE ' +
									'RIGHT ' +
									'( ' +
										'REPLICATE(''0'', max_elapsed_length) + CONVERT(VARCHAR, elapsed_time / 86400000), ' +
										'max_elapsed_length ' +
									') + ' +
										'RIGHT ' +
										'( ' +
											'CONVERT(VARCHAR, DATEADD(second, elapsed_time / 1000, 0), 120), ' +
											'9 ' +
										') + ' +
										'''.'' + ' + 
										'RIGHT(''000'' + CONVERT(VARCHAR, elapsed_time % 1000), 3) ' +
							'END AS [dd hh:mm:ss.mss], '
						ELSE
							''
					END +
					--[dd hh:mm:ss.mss (avg)] / avg_elapsed_time
					CASE 
						WHEN  @format_output IN (1, 2) THEN 
							'RIGHT ' +
							'( ' +
								'''00'' + CONVERT(VARCHAR, avg_elapsed_time / 86400000), ' +
								'2 ' +
							') + ' +
								'RIGHT ' +
								'( ' +
									'CONVERT(VARCHAR, DATEADD(second, avg_elapsed_time / 1000, 0), 120), ' +
									'9 ' +
								') + ' +
								'''.'' + ' +
								'RIGHT(''000'' + CONVERT(VARCHAR, avg_elapsed_time % 1000), 3) AS [dd hh:mm:ss.mss (avg)], '
						ELSE
							'avg_elapsed_time, '
					END +
					--physical_io
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io))) OVER() - LEN(CONVERT(VARCHAR, physical_io))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io), 1), 19)) AS '
						ELSE ''
					END + 'physical_io, ' +
					--reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads))) OVER() - LEN(CONVERT(VARCHAR, reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads), 1), 19)) AS '
						ELSE ''
					END + 'reads, ' +
					--physical_reads
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads))) OVER() - LEN(CONVERT(VARCHAR, physical_reads))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads), 1), 19)) AS '
						ELSE ''
					END + 'physical_reads, ' +
					--writes
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes))) OVER() - LEN(CONVERT(VARCHAR, writes))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes), 1), 19)) AS '
						ELSE ''
					END + 'writes, ' +
					--tempdb_allocations
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_allocations, ' +
					--tempdb_current
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current), 1), 19)) AS '
						ELSE ''
					END + 'tempdb_current, ' +
					--CPU
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CPU))) OVER() - LEN(CONVERT(VARCHAR, CPU))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU), 1), 19)) AS '
						ELSE ''
					END + 'CPU, ' +
					--context_switches
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches))) OVER() - LEN(CONVERT(VARCHAR, context_switches))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches), 1), 19)) AS '
						ELSE ''
					END + 'context_switches, ' +
					--used_memory
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory))) OVER() - LEN(CONVERT(VARCHAR, used_memory))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory), 1), 19)) AS '
						ELSE ''
					END + 'used_memory, ' +
					CASE
						WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
							--physical_io_delta			
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_io_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_io_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_io_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) ' 
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_io_delta), 1), 19)) '
											ELSE 'physical_io_delta '
										END +
								'ELSE NULL ' +
							'END AS physical_io_delta, ' +
							--reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, reads_delta))) OVER() - LEN(CONVERT(VARCHAR, reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, reads_delta), 1), 19)) '
											ELSE 'reads_delta '
										END +
								'ELSE NULL ' +
							'END AS reads_delta, ' +
							--physical_reads_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND physical_reads_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, physical_reads_delta))) OVER() - LEN(CONVERT(VARCHAR, physical_reads_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, physical_reads_delta), 1), 19)) '
											ELSE 'physical_reads_delta '
										END + 
								'ELSE NULL ' +
							'END AS physical_reads_delta, ' +
							--writes_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND writes_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, writes_delta))) OVER() - LEN(CONVERT(VARCHAR, writes_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, writes_delta), 1), 19)) '
											ELSE 'writes_delta '
										END + 
								'ELSE NULL ' +
							'END AS writes_delta, ' +
							--tempdb_allocations_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND tempdb_allocations_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_allocations_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_allocations_delta), 1), 19)) '
											ELSE 'tempdb_allocations_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_allocations_delta, ' +
							--tempdb_current_delta
							--this is the only one that can (legitimately) go negative 
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tempdb_current_delta))) OVER() - LEN(CONVERT(VARCHAR, tempdb_current_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tempdb_current_delta), 1), 19)) '
											ELSE 'tempdb_current_delta '
										END + 
								'ELSE NULL ' +
							'END AS tempdb_current_delta, ' +
							--CPU_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
										'THEN ' +
											'CASE ' +
												'WHEN ' +
													'thread_CPU_delta > CPU_delta ' +
													'AND thread_CPU_delta > 0 ' +
														'THEN ' +
															CASE @format_output
																WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, thread_CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, thread_CPU_delta), 1), 19)) '
																ELSE 'thread_CPU_delta '
															END + 
												'WHEN CPU_delta >= 0 THEN ' +
													CASE @format_output
														WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, thread_CPU_delta + CPU_delta))) OVER() - LEN(CONVERT(VARCHAR, CPU_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, CPU_delta), 1), 19)) '
														ELSE 'CPU_delta '
													END + 
												'ELSE NULL ' +
											'END ' +
								'ELSE ' +
									'NULL ' +
							'END AS CPU_delta, ' +
							--context_switches_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND context_switches_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, context_switches_delta))) OVER() - LEN(CONVERT(VARCHAR, context_switches_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, context_switches_delta), 1), 19)) '
											ELSE 'context_switches_delta '
										END + 
								'ELSE NULL ' +
							'END AS context_switches_delta, ' +
							--used_memory_delta
							'CASE ' +
								'WHEN ' +
									'first_request_start_time = last_request_start_time ' + 
									'AND num_events = 2 ' +
									'AND used_memory_delta >= 0 ' +
										'THEN ' +
										CASE @format_output
											WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, used_memory_delta))) OVER() - LEN(CONVERT(VARCHAR, used_memory_delta))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, used_memory_delta), 1), 19)) '
											ELSE 'used_memory_delta '
										END + 
								'ELSE NULL ' +
							'END AS used_memory_delta, '
						ELSE ''
					END +
					--tasks
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, tasks))) OVER() - LEN(CONVERT(VARCHAR, tasks))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, tasks), 1), 19)) '
						ELSE ''
					END + 'tasks, ' +
					'status, ' +
					'wait_info, ' +
					'locks, ' +
					'tran_start_time, ' +
					'LEFT(tran_log_writes, LEN(tran_log_writes) - 1) AS tran_log_writes, ' +
					--open_tran_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, open_tran_count))) OVER() - LEN(CONVERT(VARCHAR, open_tran_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, open_tran_count), 1), 19)) AS '
						ELSE ''
					END + 'open_tran_count, ' +
					--sql_command
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_command), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_command, ' +
					--sql_text
					CASE @format_output 
						WHEN 0 THEN 'REPLACE(REPLACE(CONVERT(NVARCHAR(MAX), sql_text), ''<?query --''+CHAR(13)+CHAR(10), ''''), CHAR(13)+CHAR(10)+''--?>'', '''') AS '
						ELSE ''
					END + 'sql_text, ' +
					'query_plan, ' +
					'blocking_session_id, ' +
					--blocked_session_count
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, blocked_session_count))) OVER() - LEN(CONVERT(VARCHAR, blocked_session_count))) + LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, LEFT(CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1), 19)) AS '
						ELSE ''
					END + 'blocked_session_count, ' +
					--percent_complete
					CASE @format_output
						WHEN 1 THEN 'CONVERT(VARCHAR, SPACE(MAX(LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) OVER() - LEN(CONVERT(VARCHAR, CONVERT(MONEY, percent_complete), 2))) + CONVERT(CHAR(22), CONVERT(MONEY, percent_complete), 2)) AS '
						WHEN 2 THEN 'CONVERT(VARCHAR, CONVERT(CHAR(22), CONVERT(MONEY, blocked_session_count), 1)) AS '
						ELSE ''
					END + 'percent_complete, ' +
					'host_name, ' +
					'login_name, ' +
					'database_name, ' +
					'program_name, ' +
					'additional_info, ' +
					'start_time, ' +
					'login_time, ' +
					'CASE ' +
						'WHEN status = N''sleeping'' THEN NULL ' +
						'ELSE request_id ' +
					'END AS request_id, ' +
					'GETDATE() AS collection_time '
		--End inner column list
		) +
		--Derived table and INSERT specification
		CONVERT
		(
			VARCHAR(MAX),
				'FROM ' +
				'( ' +
					'SELECT TOP(2147483647) ' +
						'*, ' +
						'CASE ' +
							'MAX ' +
							'( ' +
								'LEN ' +
								'( ' +
									'CONVERT ' +
									'( ' +
										'VARCHAR, ' +
										'CASE ' +
											'WHEN elapsed_time < 0 THEN ' +
												'(-1 * elapsed_time) / 86400 ' +
											'ELSE ' +
												'elapsed_time / 86400000 ' +
										'END ' +
									') ' +
								') ' +
							') OVER () ' +
								'WHEN 1 THEN 2 ' +
								'ELSE ' +
									'MAX ' +
									'( ' +
										'LEN ' +
										'( ' +
											'CONVERT ' +
											'( ' +
												'VARCHAR, ' +
												'CASE ' +
													'WHEN elapsed_time < 0 THEN ' +
														'(-1 * elapsed_time) / 86400 ' +
													'ELSE ' +
														'elapsed_time / 86400000 ' +
												'END ' +
											') ' +
										') ' +
									') OVER () ' +
						'END AS max_elapsed_length, ' +
						CASE
							WHEN @output_column_list LIKE '%|_delta|]%' ESCAPE '|' THEN
								'MAX(physical_io * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_io * recursion) OVER (PARTITION BY session_id, request_id) AS physical_io_delta, ' +
								'MAX(reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(reads * recursion) OVER (PARTITION BY session_id, request_id) AS reads_delta, ' +
								'MAX(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(physical_reads * recursion) OVER (PARTITION BY session_id, request_id) AS physical_reads_delta, ' +
								'MAX(writes * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(writes * recursion) OVER (PARTITION BY session_id, request_id) AS writes_delta, ' +
								'MAX(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_allocations * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_allocations_delta, ' +
								'MAX(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(tempdb_current * recursion) OVER (PARTITION BY session_id, request_id) AS tempdb_current_delta, ' +
								'MAX(CPU * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(CPU * recursion) OVER (PARTITION BY session_id, request_id) AS CPU_delta, ' +
								'MAX(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(thread_CPU_snapshot * recursion) OVER (PARTITION BY session_id, request_id) AS thread_CPU_delta, ' +
								'MAX(context_switches * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(context_switches * recursion) OVER (PARTITION BY session_id, request_id) AS context_switches_delta, ' +
								'MAX(used_memory * recursion) OVER (PARTITION BY session_id, request_id) + ' +
									'MIN(used_memory * recursion) OVER (PARTITION BY session_id, request_id) AS used_memory_delta, ' +
								'MIN(last_request_start_time) OVER (PARTITION BY session_id, request_id) AS first_request_start_time, '
							ELSE ''
						END +
						'COUNT(*) OVER (PARTITION BY session_id, request_id) AS num_events ' +
					'FROM #sessions AS s1 ' +
					CASE 
						WHEN @sort_order = '' THEN ''
						ELSE
							'ORDER BY ' +
								@sort_order
					END +
				') AS s ' +
				'WHERE ' +
					's.recursion = 1 ' +
			') x ' +
			'OPTION (KEEPFIXED PLAN); ' +
			'' +
			CASE @return_schema
				WHEN 1 THEN
					'SET @schema = ' +
						'''CREATE TABLE <table_name> ( '' + ' +
							'STUFF ' +
							'( ' +
								'( ' +
									'SELECT ' +
										''','' + ' +
										'QUOTENAME(COLUMN_NAME) + '' '' + ' +
										'DATA_TYPE + ' + 
										'CASE ' +
											'WHEN DATA_TYPE LIKE ''%char'' THEN ''('' + COALESCE(NULLIF(CONVERT(VARCHAR, CHARACTER_MAXIMUM_LENGTH), ''-1''), ''max'') + '') '' ' +
											'ELSE '' '' ' +
										'END + ' +
										'CASE IS_NULLABLE ' +
											'WHEN ''NO'' THEN ''NOT '' ' +
											'ELSE '''' ' +
										'END + ''NULL'' AS [text()] ' +
									'FROM tempdb.INFORMATION_SCHEMA.COLUMNS ' +
									'WHERE ' +
										'TABLE_NAME = (SELECT name FROM tempdb.sys.objects WHERE object_id = OBJECT_ID(''tempdb..#session_schema'')) ' +
										'ORDER BY ' +
											'ORDINAL_POSITION ' +
									'FOR XML ' +
										'PATH('''') ' +
								'), + ' +
								'1, ' +
								'1, ' +
								''''' ' +
							') + ' +
						''')''; ' 
				ELSE ''
			END
		--End derived table and INSERT specification
		);

	SET @sql_n = CONVERT(NVARCHAR(MAX), @sql);

	EXEC sp_executesql
		@sql_n,
		N'@schema VARCHAR(MAX) OUTPUT',
		@schema OUTPUT;
END;

GO
/****** Object:  StoredProcedure [nav].[ZabbixGetCountRequestStatus]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [nav].[ZabbixGetCountRequestStatus]
	@Status nvarchar(255)=NULL,
	@IsBlockingSession bit=0
AS
BEGIN
	/*
		���������� ���-�� �������� � �������� ��������
	*/
	SET NOCOUNT ON;

	if(@IsBlockingSession=0)
	begin
		select count(*) as [Count]
		from sys.dm_exec_requests ER with(readuncommitted)
		where [status]=@Status
		and [command]  in (
							'UPDATE',
							'TRUNCATE TABLE',
							'SET OPTION ON',
							'SET COMMAND',
							'SELECT INTO',
							'SELECT',
							'NOP',
							'INSERT',
							'EXECUTE',
							'DELETE',
							'DECLARE',
							'CONDITIONAL',
							'BULK INSERT',
							'BEGIN TRY',
							'BEGIN CATCH',
							'AWAITING COMMAND',
							'ASSIGN',
							'ALTER TABLE'
						  )
		--���� ������
		--and [start_time]<=DateAdd(second,-1,GetDate());
	end
	else
	begin
		select count(*) as [Count]
		from sys.dm_exec_requests ER with(readuncommitted)
		where [blocking_session_id]>0
		and [command]  in (
							'UPDATE',
							'TRUNCATE TABLE',
							'SET OPTION ON',
							'SET COMMAND',
							'SELECT INTO',
							'SELECT',
							'NOP',
							'INSERT',
							'EXECUTE',
							'DELETE',
							'DECLARE',
							'CONDITIONAL',
							'BULK INSERT',
							'BEGIN TRY',
							'BEGIN CATCH',
							'AWAITING COMMAND',
							'ASSIGN',
							'ALTER TABLE'
						  )
		--���� ������
		--and [start_time]<=DateAdd(second,-1,GetDate());
	end
END
GO
/****** Object:  StoredProcedure [srv].[AutoDefragIndex]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[AutoDefragIndex]
	@count int=null --���-�� ������������ �������������� ��������
	,@isrebuild bit=0 --��������� �� ��������������� �������� (������������ ������� ����� 30%)
AS
BEGIN
	/*
		����������� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	--���������� ����������� ������������� ������ � ������ ONLINE
	declare @isRebuildOnline bit=CASE WHEN (CAST (SERVERPROPERTY ('Edition') AS nvarchar (max)) LIKE '%Enterprise%' OR CAST (SERVERPROPERTY ('Edition') AS nvarchar (max)) LIKE '%Developer%' OR CAST (SERVERPROPERTY ('Edition') AS nvarchar (max)) LIKE '%Evaluation%') THEN 1 ELSE 0 END;

	declare @IndexName		nvarchar(100)
			,@db			nvarchar(100)
			,@db_id			int
			,@Shema			nvarchar(100)
			,@Table			nvarchar(100)
			,@SQL_Str		nvarchar (max)=N''
			,@frag			decimal(6,2)
			,@frag_after	decimal(6,2)
			,@frag_num		int
			,@page			int
			,@ts			datetime
			,@tsg			datetime
			,@tf			datetime
			,@object_id		int
			,@idx			int
			,@rec			int;

	--��� ���������
	declare @tbl table (
						IndexName		nvarchar(100)
						,db				nvarchar(100)
						,[db_id]		int
						,Shema			nvarchar(100)
						,[Table]		nvarchar(100)
						,frag			decimal(6,2)
						,frag_num		int
						,[page]			int
						,[object_id]	int
						,idx			int
						,rec			int
					   );

	--��� �������
	declare @tbl_copy table (
						IndexName		nvarchar(100)
						,db				nvarchar(100)
						,[db_id]		int
						,Shema			nvarchar(100)
						,[Table]		nvarchar(100)
						,frag			decimal(6,2)
						,frag_num		int
						,[page]			int
						,[object_id]	int
						,idx			int
						,rec			int
					   );

	set @ts = getdate()
	set @tsg = @ts;
	
	--�������� �������, ������� ��������������� �� �����, ��� �� 10%
	--� ������� ��� �� ����������
	if(@count is null)
	begin
		insert into @tbl (
						IndexName	
						,db			
						,[db_id]	
						,Shema		
						,[Table]		
						,frag		
						,frag_num	
						,[page]				
						,[object_id]
						,idx		
						,rec		
					 )
		select				ind.index_name,
							ind.db,
							ind.database_id,
							ind.shema,
							ind.tb,
							ind.frag,
							ind.frag_num,
							ind.[page],
							ind.[object_id],
							ind.idx ,
							ind.rec
		from  [inf].[vIndexDefrag] as ind
		where not exists(
							select top(1) 1 from [SRV].[srv].[ListDefragIndex] as lind
							where lind.[db_id]=ind.database_id
							  and lind.[idx]=ind.idx
							  and lind.[object_id]=ind.[object_id]
						)
		--order by ind.[page] desc, ind.[frag] desc
	end
	else
	begin
		insert into @tbl (
						IndexName	
						,db			
						,[db_id]	
						,Shema		
						,[Table]		
						,frag		
						,frag_num	
						,[page]				
						,[object_id]
						,idx		
						,rec		
					 )
		select top (@count)
							ind.index_name,
							ind.db,
							ind.database_id,
							ind.shema,
							ind.tb,
							ind.frag,
							ind.frag_num,
							ind.[page],
							ind.[object_id],
							ind.idx ,
							ind.rec
		from  [inf].[vIndexDefrag] as ind
		where not exists(
							select top(1) 1 from [SRV].[srv].[ListDefragIndex] as lind
							where lind.[db_id]=ind.database_id
							  and lind.[idx]=ind.idx
							  and lind.[object_id]=ind.[object_id]
						)
		--order by ind.[page] desc, ind.[frag] desc
	end
	
	--���� ��� ������� ���������� (� � ������� �����)
	--�� ������� ������� ������������ ��������
	--� �������� ������
	if(not exists(select top(1) 1 from @tbl))
	begin
		delete from [SRV].[srv].[ListDefragIndex]
		where [db_id]=DB_ID();

		if(@count is null)
		begin
			insert into @tbl (
							IndexName	
							,db			
							,[db_id]	
							,Shema		
							,[Table]		
							,frag		
							,frag_num	
							,[page]				
							,[object_id]
							,idx		
							,rec		
						 )
			select				ind.index_name,
								ind.db,
								ind.database_id,
								ind.shema,
								ind.tb,
								ind.frag,
								ind.frag_num,
								ind.[page],
								ind.[object_id],
								ind.idx ,
								ind.rec
			from  [inf].[vIndexDefrag] as ind
			where not exists(
								select top(1) 1 from [SRV].[srv].[ListDefragIndex] as lind
								where lind.[db_id]=ind.database_id
								  and lind.[idx]=ind.idx
								  and lind.[object_id]=ind.[object_id]
							)
			--order by ind.[page] desc, ind.[frag] desc
		end
		else
		begin
			insert into @tbl (
							IndexName	
							,db			
							,[db_id]	
							,Shema		
							,[Table]		
							,frag		
							,frag_num	
							,[page]				
							,[object_id]
							,idx		
							,rec		
						 )
			select top (@count)
								ind.index_name,
								ind.db,
								ind.database_id,
								ind.shema,
								ind.tb,
								ind.frag,
								ind.frag_num,
								ind.[page],
								ind.[object_id],
								ind.idx ,
								ind.rec
			from  [inf].[vIndexDefrag] as ind
			where not exists(
								select top(1) 1 from [SRV].[srv].[ListDefragIndex] as lind
								where lind.[db_id]=ind.database_id
								  and lind.[idx]=ind.idx
								  and lind.[object_id]=ind.[object_id]
							)
			--order by ind.[page] desc, ind.[frag] desc
		end
	end

	--���� ������� �� ������
	if(exists(select top(1) 1 from @tbl))
	begin
		--���������� ��������� �������
		INSERT INTO [SRV].[srv].[ListDefragIndex]
		       (
				 [db]
				,[shema]
				,[table]
				,[IndexName]
				,[object_id]
				,[idx]
				,[db_id]
				,[frag]
			   )
		select	 [db]
				,[shema]
				,[table]
				,[IndexName]
				,[object_id]
				,[idx]
				,[db_id]
				,[frag]
		from @tbl;

		insert into @tbl_copy (
						IndexName	
						,db			
						,[db_id]	
						,Shema		
						,[Table]	
						,frag		
						,frag_num	
						,[page]			
						,[object_id]
						,idx		
						,rec		
					 )
		select			IndexName	
						,db			
						,[db_id]	
						,Shema		
						,[Table]	
						,frag			
						,frag_num	
						,[page]				
						,[object_id]
						,idx		
						,rec	
		from @tbl;
		
		--��������� ������ �� ����������� ��������� �������� (� ������ �������������-� ����������� ����������� ���������� �� ���)
		while(exists(select top(1) 1 from @tbl))
		begin
			select top(1)
			@IndexName=[IndexName],
			@Shema=[Shema],
			@Table=[Table],
			@frag=[frag]
			from @tbl;
			
			if(@frag>=30 and @isrebuild=1 and @isRebuildOnline=1)
			begin
				set @SQL_Str = @SQL_Str+'ALTER INDEX ['+@IndexName+'] on ['+@Shema+'].['+@Table+'] REBUILD WITH(ONLINE=ON);'
			end
			else
			begin
				set @SQL_Str = @SQL_Str+'ALTER INDEX ['+@IndexName+'] on ['+@Shema+'].['+@Table+'] REORGANIZE;'
									   +'UPDATE STATISTICS ['+@Shema+'].['+@Table+'] ['+@IndexName+'];';
			end

			delete from @tbl
			where [IndexName]=@IndexName
			and [Shema]=@Shema
			and [Table]=@Table;
		end

		--������������ ��������� �������
		execute sp_executesql  @SQL_Str;

		--���������� ��������� ����������� ��������
		insert into [SRV].srv.Defrag(
									[db],
									[shema],
									[table],
									[IndexName],
									[frag_num],
									[frag],
									[page],
									ts,
									tf,
									frag_after,
									[object_id],
									idx,
									rec
								  )
						select
									[db],
									[shema],
									[table],
									[IndexName],
									[frag_num],
									[frag],
									[page],
									@ts,
									getdate(),
									(SELECT top(1) avg_fragmentation_in_percent
									FROM sys.dm_db_index_physical_stats
										(DB_ID([db]), [object_id], [idx], NULL ,
										N'LIMITED')
									where index_level = 0) as frag_after,
									[object_id],
									[idx],
									[rec]
						from	@tbl_copy;
	end
END



GO
/****** Object:  StoredProcedure [srv].[AutoDefragIndexDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[AutoDefragIndexDB]
	@DB nvarchar(255)=NULL, --�� ���������� �� ��� �� ����
	@count int=NULL, --���-�� �������� ��� ������������ � ������ ��
	@IsTempdb bit=0 --�������� �� �� tempdb
AS
BEGIN
	/*
		����� ����������� �������� ��� �������� ��
	*/
	SET NOCOUNT ON;

	declare @db_name nvarchar(255);
	declare @sql nvarchar(max);
	declare @ParmDefinition nvarchar(255)= N'@count int';
	
	if(@DB is null)
	begin
		select [name]
		into #tbls
		from sys.databases
		where [is_read_only]=0
		and [state]=0 --ONLINE
		and [user_access]=0--MULTI_USER
		and (((@IsTempdb=0 or @IsTempdb is null) and [name]<>N'tempdb') or (@IsTempdb=1));

		while(exists(select top(1) 1 from #tbls))
		begin
			select top(1)
			@db_name=[name]
			from #tbls;

			set @sql=N'USE ['+@db_name+']; '+
			N'IF(object_id('+N''''+N'[srv].[AutoDefragIndex]'+N''''+N') is not null) EXEC [srv].[AutoDefragIndex] @count=@count;';

			exec sp_executesql @sql, @ParmDefinition, @count=@count;

			delete from #tbls
			where [name]=@db_name;
		end

		drop table #tbls;
	end
	else
	begin
		set @sql=N'USE ['+@DB+']; '+
			N'IF(object_id('+N''''+N'[srv].[AutoDefragIndex]'+N''''+N') is not null) EXEC [srv].[AutoDefragIndex] @count=@count;';

		exec sp_executesql @sql, @ParmDefinition, @count=@count;
	end
END
GO
/****** Object:  StoredProcedure [srv].[AutoKillSessionTranBegin]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [srv].[AutoKillSessionTranBegin]
	@minuteOld int=30, --�������� ���������� ����������
	@countIsNotRequests int=5 --���-�� ��������� � �������
AS
BEGIN
	/*
		����������� �������� ���������� (�������, � ������� ��� �������� ��������) � ����������� �� ���������
	*/
	
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    
	declare @tbl table (
						SessionID int,
						TransactionID bigint,
						IsSessionNotRequest bit,
						TransactionBeginTime datetime
					   );
	
	--�������� ���������� (���������� � �� ������, � ������� ��� ��������, � � ���������� ���������� � �������)
	insert into @tbl (
						SessionID,
						TransactionID,
						IsSessionNotRequest,
						TransactionBeginTime
					 )
	select t.[session_id] as SessionID
		 , t.[transaction_id] as TransactionID
		 , case when exists(select top(1) 1 from sys.dm_exec_requests as r where r.[session_id]=t.[session_id]) then 0 else 1 end as IsSessionNotRequest
		 , (select top(1) ta.[transaction_begin_time] from sys.dm_tran_active_transactions as ta where ta.[transaction_id]=t.[transaction_id]) as TransactionBeginTime
	from sys.dm_tran_session_transactions as t
	where t.[is_user_transaction]=1
	and not exists(select top(1) 1 from sys.dm_exec_requests as r where r.[transaction_id]=t.[transaction_id]);
	
	--��������� ������� ���������� ����������, � ������� ��� �������� ��������
	;merge srv.SessionTran as st
	using @tbl as t
	on st.[SessionID]=t.[SessionID] and st.[TransactionID]=t.[TransactionID]
	when matched then
		update set [UpdateUTCDate]			= getUTCDate()
				 , [CountTranNotRequest]	= st.[CountTranNotRequest]+1			
				 , [CountSessionNotRequest]	= case when (t.[IsSessionNotRequest]=1) then (st.[CountSessionNotRequest]+1) else 0 end
				 , [TransactionBeginTime]	= t.[TransactionBeginTime]
	when not matched by target then
		insert (
				[SessionID]
				,[TransactionID]
				,[TransactionBeginTime]
			   )
		values (
				t.[SessionID]
				,t.[TransactionID]
				,t.[TransactionBeginTime]
			   )
	when not matched by source then delete;

	--������ ������ ��� �������� (���������� �������� ����������)
	declare @kills table (
							SessionID int
						 );

	--��������� ���������� ��� ������
	declare @kills_copy table (
							SessionID int,
							TransactionID bigint,
							CountTranNotRequest tinyint,
							CountSessionNotRequest tinyint,
							TransactionBeginTime datetime
						 )

	--�������� �� ������, ������� ����� �����
	--� ������ ���� ���� �� ���� ����������, ������� ������ @countIsNotRequests ��� ��� ��� �������� �������� � ������� �� ��� � ����� ������ ��� �������� ��������
	insert into @kills_copy	(
							SessionID,
							TransactionID,
							CountTranNotRequest,
							CountSessionNotRequest,
							TransactionBeginTime
						 )
	select SessionID,
		   TransactionID,
		   CountTranNotRequest,
		   CountSessionNotRequest,
		   TransactionBeginTime
	from srv.SessionTran
	where [CountTranNotRequest]>=@countIsNotRequests
	  and [CountSessionNotRequest]>=@countIsNotRequests
	  and [TransactionBeginTime]<=DateAdd(minute,-@minuteOld,GetDate());

	  --���������� ��� ���������� ������� (��������� ���������� ��� ��������� ������, ����������� � ����������)
	  INSERT INTO [srv].[KillSession]
           ([session_id]
           ,[transaction_id]
           ,[login_time]
           ,[host_name]
           ,[program_name]
           ,[host_process_id]
           ,[client_version]
           ,[client_interface_name]
           ,[security_id]
           ,[login_name]
           ,[nt_domain]
           ,[nt_user_name]
           ,[status]
           ,[context_info]
           ,[cpu_time]
           ,[memory_usage]
           ,[total_scheduled_time]
           ,[total_elapsed_time]
           ,[endpoint_id]
           ,[last_request_start_time]
           ,[last_request_end_time]
           ,[reads]
           ,[writes]
           ,[logical_reads]
           ,[is_user_process]
           ,[text_size]
           ,[language]
           ,[date_format]
           ,[date_first]
           ,[quoted_identifier]
           ,[arithabort]
           ,[ansi_null_dflt_on]
           ,[ansi_defaults]
           ,[ansi_warnings]
           ,[ansi_padding]
           ,[ansi_nulls]
           ,[concat_null_yields_null]
           ,[transaction_isolation_level]
           ,[lock_timeout]
           ,[deadlock_priority]
           ,[row_count]
           ,[prev_error]
           ,[original_security_id]
           ,[original_login_name]
           ,[last_successful_logon]
           ,[last_unsuccessful_logon]
           ,[unsuccessful_logons]
           ,[group_id]
           ,[database_id]
           ,[authenticating_database_id]
           ,[open_transaction_count]
           ,[most_recent_session_id]
           ,[connect_time]
           ,[net_transport]
           ,[protocol_type]
           ,[protocol_version]
           ,[encrypt_option]
           ,[auth_scheme]
           ,[node_affinity]
           ,[num_reads]
           ,[num_writes]
           ,[last_read]
           ,[last_write]
           ,[net_packet_size]
           ,[client_net_address]
           ,[client_tcp_port]
           ,[local_net_address]
           ,[local_tcp_port]
           ,[connection_id]
           ,[parent_connection_id]
           ,[most_recent_sql_handle]
           ,[LastTSQL]
           ,[transaction_begin_time]
           ,[CountTranNotRequest]
           ,[CountSessionNotRequest])
	select ES.[session_id]
           ,kc.[TransactionID]
           ,ES.[login_time]
           ,ES.[host_name]
           ,ES.[program_name]
           ,ES.[host_process_id]
           ,ES.[client_version]
           ,ES.[client_interface_name]
           ,ES.[security_id]
           ,ES.[login_name]
           ,ES.[nt_domain]
           ,ES.[nt_user_name]
           ,ES.[status]
           ,ES.[context_info]
           ,ES.[cpu_time]
           ,ES.[memory_usage]
           ,ES.[total_scheduled_time]
           ,ES.[total_elapsed_time]
           ,ES.[endpoint_id]
           ,ES.[last_request_start_time]
           ,ES.[last_request_end_time]
           ,ES.[reads]
           ,ES.[writes]
           ,ES.[logical_reads]
           ,ES.[is_user_process]
           ,ES.[text_size]
           ,ES.[language]
           ,ES.[date_format]
           ,ES.[date_first]
           ,ES.[quoted_identifier]
           ,ES.[arithabort]
           ,ES.[ansi_null_dflt_on]
           ,ES.[ansi_defaults]
           ,ES.[ansi_warnings]
           ,ES.[ansi_padding]
           ,ES.[ansi_nulls]
           ,ES.[concat_null_yields_null]
           ,ES.[transaction_isolation_level]
           ,ES.[lock_timeout]
           ,ES.[deadlock_priority]
           ,ES.[row_count]
           ,ES.[prev_error]
           ,ES.[original_security_id]
           ,ES.[original_login_name]
           ,ES.[last_successful_logon]
           ,ES.[last_unsuccessful_logon]
           ,ES.[unsuccessful_logons]
           ,ES.[group_id]
           ,ES.[database_id]
           ,ES.[authenticating_database_id]
           ,ES.[open_transaction_count]
           ,EC.[most_recent_session_id]
           ,EC.[connect_time]
           ,EC.[net_transport]
           ,EC.[protocol_type]
           ,EC.[protocol_version]
           ,EC.[encrypt_option]
           ,EC.[auth_scheme]
           ,EC.[node_affinity]
           ,EC.[num_reads]
           ,EC.[num_writes]
           ,EC.[last_read]
           ,EC.[last_write]
           ,EC.[net_packet_size]
           ,EC.[client_net_address]
           ,EC.[client_tcp_port]
           ,EC.[local_net_address]
           ,EC.[local_tcp_port]
           ,EC.[connection_id]
           ,EC.[parent_connection_id]
           ,EC.[most_recent_sql_handle]
           ,(select top(1) text from sys.dm_exec_sql_text(EC.[most_recent_sql_handle])) as [LastTSQL]
           ,kc.[TransactionBeginTime]
           ,kc.[CountTranNotRequest]
           ,kc.[CountSessionNotRequest]
	from @kills_copy as kc
	inner join sys.dm_exec_sessions ES with(readuncommitted) on kc.[SessionID]=ES.[session_id]
	inner join sys.dm_exec_connections EC  with(readuncommitted) on EC.session_id = ES.session_id;

	--�������� ������
	insert into @kills (
							SessionID
						 )
	select [SessionID]
	from @kills_copy
	group by [SessionID];
	
	declare @SessionID int;

	--���������������� �������� ��������� ������
	while(exists(select top(1) 1 from @kills))
	begin
		select top(1)
		@SessionID=[SessionID]
		from @kills;
    
    BEGIN TRY
		EXEC sp_executesql N'kill @SessionID',
						   N'@SessionID INT',
						   @SessionID;
    END TRY
    BEGIN CATCH
    END CATCH

		delete from @kills
		where [SessionID]=@SessionID;
	end

	select st.[SessionID]
		  ,st.[TransactionID]
		  into #tbl
	from srv.SessionTran as st
	where st.[CountTranNotRequest]>=250
	   or st.[CountSessionNotRequest]>=250
	   or exists(select top(1) 1 from @kills_copy kc where kc.[SessionID]=st.[SessionID]);

	--�������� ������������ �������, � ����� ��, ��� ���������� ������� � ��� ��������� ������� ����� � ������� �� ������������
	delete from st
	from #tbl as t
	inner join srv.SessionTran as st on t.[SessionID]	 =st.[SessionID]
									and t.[TransactionID]=st.[TransactionID];

	drop table #tbl;
END
GO
/****** Object:  StoredProcedure [srv].[AutoShortInfoRunJobs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoShortInfoRunJobs]
	@second int=60,
	@body nvarchar(max)=NULL OUTPUT
AS
BEGIN
	/*
		���������� ��������� � ����������� �������� ��� ����������� �������� �� �����
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    truncate table [srv].[ShortInfoRunJobs];

	INSERT INTO [srv].[ShortInfoRunJobs]
           ([Job_GUID]
           ,[Job_Name]
           ,[LastFinishRunState]
           ,[LastDateTime]
           ,[LastRunDurationString]
           ,[LastRunDurationInt]
           ,[LastOutcomeMessage]
           ,[LastRunOutcome]
           ,[Server])
    SELECT [Job_GUID]
          ,[Job_Name]
          ,[LastFinishRunState]
          ,[LastDateTime]
          ,[LastRunDurationString]
          ,[LastRunDurationInt]
          ,[LastOutcomeMessage]
          ,LastRunOutcome
          ,@@SERVERNAME
      FROM [inf].[vJobRunShortInfo]
      where [Enabled]=1
      and ([LastRunOutcome]=0
      or [LastRunDurationInt]>=@second)
      and LastDateTime>=DateAdd(day,-2,getdate());

	  exec [srv].[GetHTMLTableShortInfoRunJobs] @body=@body OUTPUT;
END
GO
/****** Object:  StoredProcedure [srv].[AutoStatisticsActiveConnections]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoStatisticsActiveConnections]
AS
BEGIN
	/*
		�������� ������ �� �������� ������������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	;with conn as (
		select @@SERVERNAME as [ServerName]
		   ,[SessionID]
           ,[LoginName]
		   ,[DBName]           
		   ,[ProgramName]
           ,[Status]
		   ,[LoginTime]
		from [SRV].[inf].[vActiveConnect] with(readuncommitted)
	)
	merge [srv].[ActiveConnectionStatistics] as trg
	using conn as src on (
								trg.[ServerName] collate DATABASE_DEFAULT=src.[ServerName] collate DATABASE_DEFAULT
							and trg.[SessionID]=src.[SessionID]
							and trg.[LoginName] collate DATABASE_DEFAULT=src.[LoginName] collate DATABASE_DEFAULT
							and ((trg.[DBName] collate DATABASE_DEFAULT=src.[DBName] collate DATABASE_DEFAULT) or (src.[DBName] IS NULL))
							and trg.[LoginTime]=src.[LoginTime]
						 )
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (
			[ServerName]
			,[SessionID]
			,[LoginName]
			,[DBName]
			,[ProgramName]
			,[Status]
			,[LoginTime]
		   )
	VALUES (
			src.[ServerName]
			,src.[SessionID]
			,src.[LoginName]
			,src.[DBName]
			,src.[ProgramName]
			,src.[Status]
			,src.[LoginTime]
		   )
	WHEN MATCHED THEN
	UPDATE SET
	trg.[ProgramName]=coalesce(src.[ProgramName] collate DATABASE_DEFAULT, trg.[ProgramName] collate DATABASE_DEFAULT) 
	,trg.[Status]=coalesce(src.[Status] collate DATABASE_DEFAULT, trg.[Status] collate DATABASE_DEFAULT)
	WHEN NOT MATCHED BY SOURCE AND (trg.[EndRegUTCDate] IS NULL) THEN
	UPDATE SET trg.[EndRegUTCDate]=GetUTCDate();
END
GO
/****** Object:  StoredProcedure [srv].[AutoStatisticsActiveRequests]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoStatisticsActiveRequests]
AS
BEGIN
	/*
		31.08.2017 ���: ���� ������ �� �������� ��������
		12.02.2018 ���: ��������� ��������� ������ �� ���� ������ � � �������������� �������� ������ ��������
		�� ����� ����� � ����������� � #ttt-�������� ������� ��� �������� � merge, ������ ���������������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @tbl0 table (
						[SQLHandle] [varbinary](64) NOT NULL,
						[TSQL] [nvarchar](max) NULL
					   );
	
	declare @tbl1 table (
						[PlanHandle] [varbinary](64) NOT NULL,
						[SQLHandle] [varbinary](64) NOT NULL,
						[QueryPlan] [xml] NULL
					   );

	declare @tbl2 table (
							[session_id] [smallint] NOT NULL,
							[request_id] [int] NULL,
							[start_time] [datetime] NULL,
							[status] [nvarchar](30) NULL,
							[command] [nvarchar](32) NULL,
							[sql_handle] [varbinary](64) NULL,
							[statement_start_offset] [int] NULL,
							[statement_end_offset] [int] NULL,
							[plan_handle] [varbinary](64) NULL,
							[database_id] [smallint] NULL,
							[user_id] [int] NULL,
							[connection_id] [uniqueidentifier] NULL,
							[blocking_session_id] [smallint] NULL,
							[wait_type] [nvarchar](60) NULL,
							[wait_time] [int] NULL,
							[last_wait_type] [nvarchar](60) NULL,
							[wait_resource] [nvarchar](256) NULL,
							[open_transaction_count] [int] NULL,
							[open_resultset_count] [int] NULL,
							[transaction_id] [bigint] NULL,
							[context_info] [varbinary](128) NULL,
							[percent_complete] [real] NULL,
							[estimated_completion_time] [bigint] NULL,
							[cpu_time] [int] NULL,
							[total_elapsed_time] [int] NULL,
							[scheduler_id] [int] NULL,
							[task_address] [varbinary](8) NULL,
							[reads] [bigint]  NULL,
							[writes] [bigint] NULL,
							[logical_reads] [bigint] NULL,
							[text_size] [int] NULL,
							[language] [nvarchar](128) NULL,
							[date_format] [nvarchar](3) NULL,
							[date_first] [smallint] NULL,
							[quoted_identifier] [bit] NULL,
							[arithabort] [bit] NULL,
							[ansi_null_dflt_on] [bit] NULL,
							[ansi_defaults] [bit] NULL,
							[ansi_warnings] [bit] NULL,
							[ansi_padding] [bit] NULL,
							[ansi_nulls] [bit] NULL,
							[concat_null_yields_null] [bit] NULL,
							[transaction_isolation_level] [smallint] NULL,
							[lock_timeout] [int] NULL,
							[deadlock_priority] [int] NULL,
							[row_count] [bigint] NULL,
							[prev_error] [int] NULL,
							[nest_level] [int] NULL,
							[granted_query_memory] [int]  NULL,
							[executing_managed_code] [bit]  NULL,
							[group_id] [int]  NULL,
							[query_hash] [binary](8) NULL,
							[query_plan_hash] [binary](8) NULL,
							[most_recent_session_id] [int] NULL,
							[connect_time] [datetime] NULL,
							[net_transport] [nvarchar](40) NULL,
							[protocol_type] [nvarchar](40) NULL,
							[protocol_version] [int] NULL,
							[endpoint_id] [int] NULL,
							[encrypt_option] [nvarchar](40) NULL,
							[auth_scheme] [nvarchar](40) NULL,
							[node_affinity] [smallint] NULL,
							[num_reads] [int] NULL,
							[num_writes] [int] NULL,
							[last_read] [datetime] NULL,
							[last_write] [datetime] NULL,
							[net_packet_size] [int] NULL,
							[client_net_address] [varchar](48) NULL,
							[client_tcp_port] [int] NULL,
							[local_net_address] [varchar](48) NULL,
							[local_tcp_port] [int] NULL,
							[parent_connection_id] [uniqueidentifier] NULL,
							[most_recent_sql_handle] [varbinary](64) NULL,
							[login_time] [datetime] NULL,
							[host_name] [nvarchar](128) NULL,
							[program_name] [nvarchar](128) NULL,
							[host_process_id] [int] NULL,
							[client_version] [int] NULL,
							[client_interface_name] [nvarchar](32) NULL,
							[security_id] [varbinary](85) NULL,
							[login_name] [nvarchar](128) NULL,
							[nt_domain] [nvarchar](128) NULL,
							[nt_user_name] [nvarchar](128) NULL,
							[memory_usage] [int] NULL,
							[total_scheduled_time] [int] NULL,
							[last_request_start_time] [datetime] NULL,
							[last_request_end_time] [datetime] NULL,
							[is_user_process] [bit] NULL,
							[original_security_id] [varbinary](85) NULL,
							[original_login_name] [nvarchar](128) NULL,
							[last_successful_logon] [datetime] NULL,
							[last_unsuccessful_logon] [datetime] NULL,
							[unsuccessful_logons] [bigint] NULL,
							[authenticating_database_id] [int] NULL,
							[TSQL] [nvarchar](max) NULL,
							[QueryPlan] [xml] NULL,
							[is_blocking_other_session] [int] NOT NULL,
							[dop] [smallint] NULL,
							[request_time] [datetime] NULL,
							[grant_time] [datetime] NULL,
							[requested_memory_kb] [bigint] NULL,
							[granted_memory_kb] [bigint] NULL,
							[required_memory_kb] [bigint] NULL,
							[used_memory_kb] [bigint] NULL,
							[max_used_memory_kb] [bigint] NULL,
							[query_cost] [float] NULL,
							[timeout_sec] [int] NULL,
							[resource_semaphore_id] [smallint] NULL,
							[queue_id] [smallint] NULL,
							[wait_order] [int] NULL,
							[is_next_candidate] [bit] NULL,
							[wait_time_ms] [bigint] NULL,
							[pool_id] [int] NULL,
							[is_small] [bit] NULL,
							[ideal_memory_kb] [bigint] NULL,
							[reserved_worker_count] [int] NULL,
							[used_worker_count] [int] NULL,
							[max_used_worker_count] [int] NULL,
							[reserved_node_bitmap] [bigint] NULL,
							[bucketid] [int] NULL,
							[refcounts] [int] NULL,
							[usecounts] [int] NULL,
							[size_in_bytes] [int] NULL,
							[memory_object_address] [varbinary](8) NULL,
							[cacheobjtype] [nvarchar](50) NULL,
							[objtype] [nvarchar](20) NULL,
							[parent_plan_handle] [varbinary](64) NULL,
							[creation_time] [datetime] NULL,
							[execution_count] [bigint] NULL,
							[total_worker_time] [bigint] NULL,
							[min_last_worker_time] [bigint] NULL,
							[max_last_worker_time] [bigint] NULL,
							[min_worker_time] [bigint] NULL,
							[max_worker_time] [bigint] NULL,
							[total_physical_reads] [bigint] NULL,
							[min_last_physical_reads] [bigint] NULL,
							[max_last_physical_reads] [bigint] NULL,
							[min_physical_reads] [bigint] NULL,
							[max_physical_reads] [bigint] NULL,
							[total_logical_writes] [bigint] NULL,
							[min_last_logical_writes] [bigint] NULL,
							[max_last_logical_writes] [bigint] NULL,
							[min_logical_writes] [bigint] NULL,
							[max_logical_writes] [bigint] NULL,
							[total_logical_reads] [bigint] NULL,
							[min_last_logical_reads] [bigint] NULL,
							[max_last_logical_reads] [bigint] NULL,
							[min_logical_reads] [bigint] NULL,
							[max_logical_reads] [bigint] NULL,
							[total_clr_time] [bigint] NULL,
							[min_last_clr_time] [bigint] NULL,
							[max_last_clr_time] [bigint] NULL,
							[min_clr_time] [bigint] NULL,
							[max_clr_time] [bigint] NULL,
							[min_last_elapsed_time] [bigint] NULL,
							[max_last_elapsed_time] [bigint] NULL,
							[min_elapsed_time] [bigint] NULL,
							[max_elapsed_time] [bigint] NULL,
							[total_rows] [bigint] NULL,
							[min_last_rows] [bigint] NULL,
							[max_last_rows] [bigint] NULL,
							[min_rows] [bigint] NULL,
							[max_rows] [bigint] NULL,
							[total_dop] [bigint] NULL,
							[min_last_dop] [bigint] NULL,
							[max_last_dop] [bigint] NULL,
							[min_dop] [bigint] NULL,
							[max_dop] [bigint] NULL,
							[total_grant_kb] [bigint] NULL,
							[min_last_grant_kb] [bigint] NULL,
							[max_last_grant_kb] [bigint] NULL,
							[min_grant_kb] [bigint] NULL,
							[max_grant_kb] [bigint] NULL,
							[total_used_grant_kb] [bigint] NULL,
							[min_last_used_grant_kb] [bigint] NULL,
							[max_last_used_grant_kb] [bigint] NULL,
							[min_used_grant_kb] [bigint] NULL,
							[max_used_grant_kb] [bigint] NULL,
							[total_ideal_grant_kb] [bigint] NULL,
							[min_last_ideal_grant_kb] [bigint] NULL,
							[max_last_ideal_grant_kb] [bigint] NULL,
							[min_ideal_grant_kb] [bigint] NULL,
							[max_ideal_grant_kb] [bigint] NULL,
							[total_reserved_threads] [bigint] NULL,
							[min_last_reserved_threads] [bigint] NULL,
							[max_last_reserved_threads] [bigint] NULL,
							[min_reserved_threads] [bigint] NULL,
							[max_reserved_threads] [bigint] NULL,
							[total_used_threads] [bigint] NULL,
							[min_last_used_threads] [bigint] NULL,
							[max_last_used_threads] [bigint] NULL,
							[min_used_threads] [bigint] NULL,
							[max_used_threads] [bigint] NULL
						);

	insert into @tbl2 (
						[session_id]
						,[request_id]
						,[start_time]
						,[status]
						,[command]
						,[sql_handle]
						,[TSQL]
						,[statement_start_offset]
						,[statement_end_offset]
						,[plan_handle]
						,[QueryPlan]
						,[database_id]
						,[user_id]
						,[connection_id]
						,[blocking_session_id]
						,[wait_type]
						,[wait_time]
						,[last_wait_type]
						,[wait_resource]
						,[open_transaction_count]
						,[open_resultset_count]
						,[transaction_id]
						,[context_info]
						,[percent_complete]
						,[estimated_completion_time]
						,[cpu_time]
						,[total_elapsed_time]
						,[scheduler_id]
						,[task_address]
						,[reads]
						,[writes]
						,[logical_reads]
						,[text_size]
						,[language]
						,[date_format]
						,[date_first]
						,[quoted_identifier]
						,[arithabort]
						,[ansi_null_dflt_on]
						,[ansi_defaults]
						,[ansi_warnings]
						,[ansi_padding]
						,[ansi_nulls]
						,[concat_null_yields_null]
						,[transaction_isolation_level]
						,[lock_timeout]
						,[deadlock_priority]
						,[row_count]
						,[prev_error]
						,[nest_level]
						,[granted_query_memory]
						,[executing_managed_code]
						,[group_id]
						,[query_hash]
						,[query_plan_hash]
						,[most_recent_session_id]
						,[connect_time]
						,[net_transport]
						,[protocol_type]
						,[protocol_version]
						,[endpoint_id]
						,[encrypt_option]
						,[auth_scheme]
						,[node_affinity]
						,[num_reads]
						,[num_writes]
						,[last_read]
						,[last_write]
						,[net_packet_size]
						,[client_net_address]
						,[client_tcp_port]
						,[local_net_address]
						,[local_tcp_port]
						,[parent_connection_id]
						,[most_recent_sql_handle]
						,[login_time]
						,[host_name]
						,[program_name]
						,[host_process_id]
						,[client_version]
						,[client_interface_name]
						,[security_id]
						,[login_name]
						,[nt_domain]
						,[nt_user_name]
						,[memory_usage]
						,[total_scheduled_time]
						,[last_request_start_time]
						,[last_request_end_time]
						,[is_user_process]
						,[original_security_id]
						,[original_login_name]
						,[last_successful_logon]
						,[last_unsuccessful_logon]
						,[unsuccessful_logons]
						,[authenticating_database_id]
						,[is_blocking_other_session]
						,[dop]
						,[request_time]
						,[grant_time]
						,[requested_memory_kb]
						,[granted_memory_kb]
						,[required_memory_kb]
						,[used_memory_kb]
						,[max_used_memory_kb]
						,[query_cost]
						,[timeout_sec]
						,[resource_semaphore_id]
						,[queue_id]
						,[wait_order]
						,[is_next_candidate]
						,[wait_time_ms]
						,[pool_id]
						,[is_small]
						,[ideal_memory_kb]
						,[reserved_worker_count]
						,[used_worker_count]
						,[max_used_worker_count]
						,[reserved_node_bitmap]
						,[bucketid]
						,[refcounts]
						,[usecounts]
						,[size_in_bytes]
						,[memory_object_address]
						,[cacheobjtype]
						,[objtype]
						,[parent_plan_handle]
						,[creation_time]
						,[execution_count]
						,[total_worker_time]
						,[min_last_worker_time]
						,[max_last_worker_time]
						,[min_worker_time]
						,[max_worker_time]
						,[total_physical_reads]
						,[min_last_physical_reads]
						,[max_last_physical_reads]
						,[min_physical_reads]
						,[max_physical_reads]
						,[total_logical_writes]
						,[min_last_logical_writes]
						,[max_last_logical_writes]
						,[min_logical_writes]
						,[max_logical_writes]
						,[total_logical_reads]
						,[min_last_logical_reads]
						,[max_last_logical_reads]
						,[min_logical_reads]
						,[max_logical_reads]
						,[total_clr_time]
						,[min_last_clr_time]
						,[max_last_clr_time]
						,[min_clr_time]
						,[max_clr_time]
						,[min_last_elapsed_time]
						,[max_last_elapsed_time]
						,[min_elapsed_time]
						,[max_elapsed_time]
						,[total_rows]
						,[min_last_rows]
						,[max_last_rows]
						,[min_rows]
						,[max_rows]
						,[total_dop]
						,[min_last_dop]
						,[max_last_dop]
						,[min_dop]
						,[max_dop]
						,[total_grant_kb]
						,[min_last_grant_kb]
						,[max_last_grant_kb]
						,[min_grant_kb]
						,[max_grant_kb]
						,[total_used_grant_kb]
						,[min_last_used_grant_kb]
						,[max_last_used_grant_kb]
						,[min_used_grant_kb]
						,[max_used_grant_kb]
						,[total_ideal_grant_kb]
						,[min_last_ideal_grant_kb]
						,[max_last_ideal_grant_kb]
						,[min_ideal_grant_kb]
						,[max_ideal_grant_kb]
						,[total_reserved_threads]
						,[min_last_reserved_threads]
						,[max_last_reserved_threads]
						,[min_reserved_threads]
						,[max_reserved_threads]
						,[total_used_threads]
						,[min_last_used_threads]
						,[max_last_used_threads]
						,[min_used_threads]
						,[max_used_threads]
					  )
	select [session_id]
	      ,[request_id]
	      ,[start_time]
	      ,[status]
	      ,[command]
	      ,[sql_handle]
		  ,[TSQL]
	      ,[statement_start_offset]
	      ,[statement_end_offset]
	      ,[plan_handle]
		  ,[QueryPlan]
	      ,[database_id]
	      ,[user_id]
	      ,[connection_id]
	      ,[blocking_session_id]
	      ,[wait_type]
	      ,[wait_time]
	      ,[last_wait_type]
	      ,[wait_resource]
	      ,[open_transaction_count]
	      ,[open_resultset_count]
	      ,[transaction_id]
	      ,[context_info]
	      ,[percent_complete]
	      ,[estimated_completion_time]
	      ,[cpu_time]
	      ,[total_elapsed_time]
	      ,[scheduler_id]
	      ,[task_address]
	      ,[reads]
	      ,[writes]
	      ,[logical_reads]
	      ,[text_size]
	      ,[language]
	      ,[date_format]
	      ,[date_first]
	      ,[quoted_identifier]
	      ,[arithabort]
	      ,[ansi_null_dflt_on]
	      ,[ansi_defaults]
	      ,[ansi_warnings]
	      ,[ansi_padding]
	      ,[ansi_nulls]
	      ,[concat_null_yields_null]
	      ,[transaction_isolation_level]
	      ,[lock_timeout]
	      ,[deadlock_priority]
	      ,[row_count]
	      ,[prev_error]
	      ,[nest_level]
	      ,[granted_query_memory]
	      ,[executing_managed_code]
	      ,[group_id]
	      ,[query_hash]
	      ,[query_plan_hash]
		  ,[most_recent_session_id]
	      ,[connect_time]
	      ,[net_transport]
	      ,[protocol_type]
	      ,[protocol_version]
	      ,[endpoint_id]
	      ,[encrypt_option]
	      ,[auth_scheme]
	      ,[node_affinity]
	      ,[num_reads]
	      ,[num_writes]
	      ,[last_read]
	      ,[last_write]
	      ,[net_packet_size]
	      ,[client_net_address]
	      ,[client_tcp_port]
	      ,[local_net_address]
	      ,[local_tcp_port]
	      ,[parent_connection_id]
	      ,[most_recent_sql_handle]
		  ,[login_time]
		  ,[host_name]
		  ,[program_name]
		  ,[host_process_id]
		  ,[client_version]
		  ,[client_interface_name]
		  ,[security_id]
		  ,[login_name]
		  ,[nt_domain]
		  ,[nt_user_name]
		  ,[memory_usage]
		  ,[total_scheduled_time]
		  ,[last_request_start_time]
		  ,[last_request_end_time]
		  ,[is_user_process]
		  ,[original_security_id]
		  ,[original_login_name]
		  ,[last_successful_logon]
		  ,[last_unsuccessful_logon]
		  ,[unsuccessful_logons]
		  ,[authenticating_database_id]
		  ,[is_blocking_other_session]
		  ,[dop]
		  ,[request_time]
		  ,[grant_time]
		  ,[requested_memory_kb]
		  ,[granted_memory_kb]
		  ,[required_memory_kb]
		  ,[used_memory_kb]
		  ,[max_used_memory_kb]
		  ,[query_cost]
		  ,[timeout_sec]
		  ,[resource_semaphore_id]
		  ,[queue_id]
		  ,[wait_order]
		  ,[is_next_candidate]
		  ,[wait_time_ms]
		  ,[pool_id]
		  ,[is_small]
		  ,[ideal_memory_kb]
		  ,[reserved_worker_count]
		  ,[used_worker_count]
		  ,[max_used_worker_count]
		  ,[reserved_node_bitmap]
		  ,[bucketid]
		  ,[refcounts]
		  ,[usecounts]
		  ,[size_in_bytes]
		  ,[memory_object_address]
		  ,[cacheobjtype]
		  ,[objtype]
		  ,[parent_plan_handle]
		  ,[creation_time]
		  ,[execution_count]
		  ,[total_worker_time]
		  ,[min_last_worker_time]
		  ,[max_last_worker_time]
		  ,[min_worker_time]
		  ,[max_worker_time]
		  ,[total_physical_reads]
		  ,[min_last_physical_reads]
		  ,[max_last_physical_reads]
		  ,[min_physical_reads]
		  ,[max_physical_reads]
		  ,[total_logical_writes]
		  ,[min_last_logical_writes]
		  ,[max_last_logical_writes]
		  ,[min_logical_writes]
		  ,[max_logical_writes]
		  ,[total_logical_reads]
		  ,[min_last_logical_reads]
		  ,[max_last_logical_reads]
		  ,[min_logical_reads]
		  ,[max_logical_reads]
		  ,[total_clr_time]
		  ,[min_last_clr_time]
		  ,[max_last_clr_time]
		  ,[min_clr_time]
		  ,[max_clr_time]
		  ,[min_last_elapsed_time]
		  ,[max_last_elapsed_time]
		  ,[min_elapsed_time]
		  ,[max_elapsed_time]
		  ,[total_rows]
		  ,[min_last_rows]
		  ,[max_last_rows]
		  ,[min_rows]
		  ,[max_rows]
		  ,[total_dop]
		  ,[min_last_dop]
		  ,[max_last_dop]
		  ,[min_dop]
		  ,[max_dop]
		  ,[total_grant_kb]
		  ,[min_last_grant_kb]
		  ,[max_last_grant_kb]
		  ,[min_grant_kb]
		  ,[max_grant_kb]
		  ,[total_used_grant_kb]
		  ,[min_last_used_grant_kb]
		  ,[max_last_used_grant_kb]
		  ,[min_used_grant_kb]
		  ,[max_used_grant_kb]
		  ,[total_ideal_grant_kb]
		  ,[min_last_ideal_grant_kb]
		  ,[max_last_ideal_grant_kb]
		  ,[min_ideal_grant_kb]
		  ,[max_ideal_grant_kb]
		  ,[total_reserved_threads]
		  ,[min_last_reserved_threads]
		  ,[max_last_reserved_threads]
		  ,[min_reserved_threads]
		  ,[max_reserved_threads]
		  ,[total_used_threads]
		  ,[min_last_used_threads]
		  ,[max_last_used_threads]
		  ,[min_used_threads]
		  ,[max_used_threads]
		from [inf].[vRequestDetail];

	insert into @tbl1 (
						[PlanHandle],
						[SQLHandle],
						[QueryPlan]
					  )
	select				[plan_handle],
						[sql_handle],
						(select top(1) [query_plan] from sys.dm_exec_query_plan([plan_handle])) as [QueryPlan]--cast(cast([QueryPlan] as nvarchar(max)) as XML),
	from @tbl2
	where (select top(1) [query_plan] from sys.dm_exec_query_plan([plan_handle])) is not null
	group by [plan_handle],
			 [sql_handle];--,
			 --cast([QueryPlan] as nvarchar(max)),
			 --[TSQL]

	insert into @tbl0 (
						[SQLHandle],
						[TSQL]
					  )
	select				[sql_handle],
						(select top(1) text from sys.dm_exec_sql_text([sql_handle])) as [TSQL]--[query_text]
	from @tbl2
	where (select top(1) text from sys.dm_exec_sql_text([sql_handle])) is not null
	group by [sql_handle];--,
			 --cast([query_plan] as nvarchar(max)),
			 --[query_text];
	
	;merge [srv].[SQLQuery] as trg
	using @tbl0 as src on trg.[SQLHandle]=src.[SQLHandle]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (
		 	[SQLHandle],
		 	[TSQL]
		   )
	VALUES (
		 	src.[SQLHandle],
		 	src.[TSQL]
		   );
	
	;merge [srv].[PlanQuery] as trg
	using @tbl1 as src on trg.[SQLHandle]=src.[SQLHandle] and trg.[PlanHandle]=src.[PlanHandle]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (
		 	[PlanHandle],
		 	[SQLHandle],
		 	[QueryPlan]
		   )
	VALUES (
			src.[PlanHandle],
		 	src.[SQLHandle],
		 	src.[QueryPlan]
		   );

	--select [session_id]
	--      ,[request_id]
	--      ,[start_time]
	--      ,[status]
	--      ,[command]
	--      ,[sql_handle]
	--	  ,(select top(1) 1 from @tbl0 as t where t.[SQLHandle]=tt.[sql_handle]) as [TSQL]
	--      ,[statement_start_offset]
	--      ,[statement_end_offset]
	--      ,[plan_handle]
	--	  ,(select top(1) 1 from @tbl1 as t where t.[PlanHandle]=tt.[plan_handle]) as [QueryPlan]
	--      ,[database_id]
	--      ,[user_id]
	--      ,[connection_id]
	--      ,[blocking_session_id]
	--      ,[wait_type]
	--      ,[wait_time]
	--      ,[last_wait_type]
	--      ,[wait_resource]
	--      ,[open_transaction_count]
	--      ,[open_resultset_count]
	--      ,[transaction_id]
	--      ,[context_info]
	--      ,[percent_complete]
	--      ,[estimated_completion_time]
	--      ,[cpu_time]
	--      ,[total_elapsed_time]
	--      ,[scheduler_id]
	--      ,[task_address]
	--      ,[reads]
	--      ,[writes]
	--      ,[logical_reads]
	--      ,[text_size]
	--      ,[language]
	--      ,[date_format]
	--      ,[date_first]
	--      ,[quoted_identifier]
	--      ,[arithabort]
	--      ,[ansi_null_dflt_on]
	--      ,[ansi_defaults]
	--      ,[ansi_warnings]
	--      ,[ansi_padding]
	--      ,[ansi_nulls]
	--      ,[concat_null_yields_null]
	--      ,[transaction_isolation_level]
	--      ,[lock_timeout]
	--      ,[deadlock_priority]
	--      ,[row_count]
	--      ,[prev_error]
	--      ,[nest_level]
	--      ,[granted_query_memory]
	--      ,[executing_managed_code]
	--      ,[group_id]
	--      ,[query_hash]
	--      ,[query_plan_hash]
	--	  ,[most_recent_session_id]
	--      ,[connect_time]
	--      ,[net_transport]
	--      ,[protocol_type]
	--      ,[protocol_version]
	--      ,[endpoint_id]
	--      ,[encrypt_option]
	--      ,[auth_scheme]
	--      ,[node_affinity]
	--      ,[num_reads]
	--      ,[num_writes]
	--      ,[last_read]
	--      ,[last_write]
	--      ,[net_packet_size]
	--      ,[client_net_address]
	--      ,[client_tcp_port]
	--      ,[local_net_address]
	--      ,[local_tcp_port]
	--      ,[parent_connection_id]
	--      ,[most_recent_sql_handle]
	--	  ,[login_time]
	--	  ,[host_name]
	--	  ,[program_name]
	--	  ,[host_process_id]
	--	  ,[client_version]
	--	  ,[client_interface_name]
	--	  ,[security_id]
	--	  ,[login_name]
	--	  ,[nt_domain]
	--	  ,[nt_user_name]
	--	  ,[memory_usage]
	--	  ,[total_scheduled_time]
	--	  ,[last_request_start_time]
	--	  ,[last_request_end_time]
	--	  ,[is_user_process]
	--	  ,[original_security_id]
	--	  ,[original_login_name]
	--	  ,[last_successful_logon]
	--	  ,[last_unsuccessful_logon]
	--	  ,[unsuccessful_logons]
	--	  ,[authenticating_database_id]
	--	  into #ttt
	--	  from @tbl2 as tt
	--	  group by [session_id]
	--      ,[request_id]
	--      ,[start_time]
	--      ,[status]
	--      ,[command]
	--      ,[sql_handle]
	--	  ,[TSQL]
	--      ,[statement_start_offset]
	--      ,[statement_end_offset]
	--      ,[plan_handle]
	--      ,[database_id]
	--      ,[user_id]
	--      ,[connection_id]
	--      ,[blocking_session_id]
	--      ,[wait_type]
	--      ,[wait_time]
	--      ,[last_wait_type]
	--      ,[wait_resource]
	--      ,[open_transaction_count]
	--      ,[open_resultset_count]
	--      ,[transaction_id]
	--      ,[context_info]
	--      ,[percent_complete]
	--      ,[estimated_completion_time]
	--      ,[cpu_time]
	--      ,[total_elapsed_time]
	--      ,[scheduler_id]
	--      ,[task_address]
	--      ,[reads]
	--      ,[writes]
	--      ,[logical_reads]
	--      ,[text_size]
	--      ,[language]
	--      ,[date_format]
	--      ,[date_first]
	--      ,[quoted_identifier]
	--      ,[arithabort]
	--      ,[ansi_null_dflt_on]
	--      ,[ansi_defaults]
	--      ,[ansi_warnings]
	--      ,[ansi_padding]
	--      ,[ansi_nulls]
	--      ,[concat_null_yields_null]
	--      ,[transaction_isolation_level]
	--      ,[lock_timeout]
	--      ,[deadlock_priority]
	--      ,[row_count]
	--      ,[prev_error]
	--      ,[nest_level]
	--      ,[granted_query_memory]
	--      ,[executing_managed_code]
	--      ,[group_id]
	--      ,[query_hash]
	--      ,[query_plan_hash]
	--	  ,[most_recent_session_id]
	--      ,[connect_time]
	--      ,[net_transport]
	--      ,[protocol_type]
	--      ,[protocol_version]
	--      ,[endpoint_id]
	--      ,[encrypt_option]
	--      ,[auth_scheme]
	--      ,[node_affinity]
	--      ,[num_reads]
	--      ,[num_writes]
	--      ,[last_read]
	--      ,[last_write]
	--      ,[net_packet_size]
	--      ,[client_net_address]
	--      ,[client_tcp_port]
	--      ,[local_net_address]
	--      ,[local_tcp_port]
	--      ,[parent_connection_id]
	--      ,[most_recent_sql_handle]
	--	  ,[login_time]
	--	  ,[host_name]
	--	  ,[program_name]
	--	  ,[host_process_id]
	--	  ,[client_version]
	--	  ,[client_interface_name]
	--	  ,[security_id]
	--	  ,[login_name]
	--	  ,[nt_domain]
	--	  ,[nt_user_name]
	--	  ,[memory_usage]
	--	  ,[total_scheduled_time]
	--	  ,[last_request_start_time]
	--	  ,[last_request_end_time]
	--	  ,[is_user_process]
	--	  ,[original_security_id]
	--	  ,[original_login_name]
	--	  ,[last_successful_logon]
	--	  ,[last_unsuccessful_logon]
	--	  ,[unsuccessful_logons]
	--	  ,[authenticating_database_id];

	UPDATE trg
	SET
	trg.[status]						   =case when (trg.[status]<>'suspended') then coalesce(src.[status] collate DATABASE_DEFAULT, trg.[status] collate DATABASE_DEFAULT) else trg.[status] end
	--,trg.[command]						   =coalesce(src.[command]					   collate DATABASE_DEFAULT, trg.[command]					 	  collate DATABASE_DEFAULT)
	--,trg.[sql_handle]					   =coalesce(src.[sql_handle]				                           , trg.[sql_handle]				 	                          )
	--,trg.[TSQL]							   =coalesce(src.[TSQL]						   collate DATABASE_DEFAULT, trg.[TSQL]						 	  collate DATABASE_DEFAULT)
	,trg.[statement_start_offset]		   =coalesce(src.[statement_start_offset]	                           , trg.[statement_start_offset]	 	                          )
	,trg.[statement_end_offset]			   =coalesce(src.[statement_end_offset]		                           , trg.[statement_end_offset]		 	                          )
	--,trg.[plan_handle]					   =coalesce(src.[plan_handle]				                           , trg.[plan_handle]				 	                          )
	--,trg.[QueryPlan]					   =coalesce(src.[QueryPlan]				                           , trg.[QueryPlan]				 	                          )
	--,trg.[connection_id]				   =coalesce(src.[connection_id]			                           , trg.[connection_id]			 	                          )
	,trg.[blocking_session_id]			   =coalesce(trg.[blocking_session_id]		                           , src.[blocking_session_id]		 	                          )
	,trg.[wait_type]					   =coalesce(trg.[wait_type]				   collate DATABASE_DEFAULT, src.[wait_type]				 	  collate DATABASE_DEFAULT)
	,trg.[wait_time]					   =coalesce(src.[wait_time]				                           , trg.[wait_time]				 	                          )
	,trg.[last_wait_type]				   =coalesce(src.[last_wait_type]			   collate DATABASE_DEFAULT, trg.[last_wait_type]			 	  collate DATABASE_DEFAULT)
	,trg.[wait_resource]				   =coalesce(src.[wait_resource]			   collate DATABASE_DEFAULT, trg.[wait_resource]			 	  collate DATABASE_DEFAULT)
	,trg.[open_transaction_count]		   =coalesce(src.[open_transaction_count]	                           , trg.[open_transaction_count]	 	                          )
	,trg.[open_resultset_count]			   =coalesce(src.[open_resultset_count]		                           , trg.[open_resultset_count]		 	                          )
	--,trg.[transaction_id]				   =coalesce(src.[transaction_id]			                           , trg.[transaction_id]			 	                          )
	,trg.[context_info]					   =coalesce(src.[context_info]				                           , trg.[context_info]				 	                          )
	,trg.[percent_complete]				   =coalesce(src.[percent_complete]			                           , trg.[percent_complete]			 	                          )
	,trg.[estimated_completion_time]	   =coalesce(src.[estimated_completion_time]                           , trg.[estimated_completion_time] 	                          )
	,trg.[cpu_time]						   =coalesce(src.[cpu_time]					                           , trg.[cpu_time]					 	                          )
	,trg.[total_elapsed_time]			   =coalesce(src.[total_elapsed_time]		                           , trg.[total_elapsed_time]		 	                          )
	,trg.[scheduler_id]					   =coalesce(src.[scheduler_id]				                           , trg.[scheduler_id]				 	                          )
	,trg.[task_address]					   =coalesce(src.[task_address]				                           , trg.[task_address]				 	                          )
	,trg.[reads]						   =coalesce(src.[reads]					                           , trg.[reads]					 	                          )
	,trg.[writes]						   =coalesce(src.[writes]					                           , trg.[writes]					 	                          )
	,trg.[logical_reads]				   =coalesce(src.[logical_reads]			                           , trg.[logical_reads]			 	                          )
	,trg.[text_size]					   =coalesce(src.[text_size]				                           , trg.[text_size]				 	                          )
	,trg.[language]						   =coalesce(src.[language]					   collate DATABASE_DEFAULT, trg.[language]					 	  collate DATABASE_DEFAULT)
	,trg.[date_format]					   =coalesce(src.[date_format]				                           , trg.[date_format]				 	                          )
	,trg.[date_first]					   =coalesce(src.[date_first]				                           , trg.[date_first]				 	                          )
	,trg.[quoted_identifier]			   =coalesce(src.[quoted_identifier]		                           , trg.[quoted_identifier]		 	                          )
	,trg.[arithabort]					   =coalesce(src.[arithabort]				                           , trg.[arithabort]				 	                          )
	,trg.[ansi_null_dflt_on]			   =coalesce(src.[ansi_null_dflt_on]		                           , trg.[ansi_null_dflt_on]		 	                          )
	,trg.[ansi_defaults]				   =coalesce(src.[ansi_defaults]			                           , trg.[ansi_defaults]			 	                          )
	,trg.[ansi_warnings]				   =coalesce(src.[ansi_warnings]			                           , trg.[ansi_warnings]			 	                          )
	,trg.[ansi_padding]					   =coalesce(src.[ansi_padding]				                           , trg.[ansi_padding]				 	                          )
	,trg.[ansi_nulls]					   =coalesce(src.[ansi_nulls]				                           , trg.[ansi_nulls]				 	                          )
	,trg.[concat_null_yields_null]		   =coalesce(src.[concat_null_yields_null]	                           , trg.[concat_null_yields_null]	 	                          )
	,trg.[transaction_isolation_level]	   =coalesce(src.[transaction_isolation_level]                         , trg.[transaction_isolation_level]                            )
	,trg.[lock_timeout]					   =coalesce(src.[lock_timeout]				                           , trg.[lock_timeout]				 	                          )
	,trg.[deadlock_priority]			   =coalesce(src.[deadlock_priority]		                           , trg.[deadlock_priority]		 	                          )
	,trg.[row_count]					   =coalesce(src.[row_count]				                           , trg.[row_count]				 	                          )
	,trg.[prev_error]					   =coalesce(src.[prev_error]				                           , trg.[prev_error]				 	                          )
	,trg.[nest_level]					   =coalesce(src.[nest_level]				                           , trg.[nest_level]				 	                          )
	,trg.[granted_query_memory]			   =coalesce(src.[granted_query_memory]		                           , trg.[granted_query_memory]		 	                          )
	,trg.[executing_managed_code]		   =coalesce(src.[executing_managed_code]	                           , trg.[executing_managed_code]	 	                          )
	,trg.[group_id]						   =coalesce(src.[group_id]					                           , trg.[group_id]					 	                          )
	,trg.[query_hash]					   =coalesce(src.[query_hash]				                           , trg.[query_hash]				 	                          )
	,trg.[query_plan_hash]				   =coalesce(src.[query_plan_hash]			                           , trg.[query_plan_hash]			 	                          )
	,trg.[most_recent_session_id]		   =coalesce(src.[most_recent_session_id]	                           , trg.[most_recent_session_id]	 	                          )
	,trg.[connect_time]					   =coalesce(src.[connect_time]				                           , trg.[connect_time]				 	                          )
	,trg.[net_transport]				   =coalesce(src.[net_transport]			   collate DATABASE_DEFAULT, trg.[net_transport]			 	  collate DATABASE_DEFAULT)
	,trg.[protocol_type]				   =coalesce(src.[protocol_type]			   collate DATABASE_DEFAULT, trg.[protocol_type]			 	  collate DATABASE_DEFAULT)
	,trg.[protocol_version]				   =coalesce(src.[protocol_version]			                           , trg.[protocol_version]			 	                          )
	,trg.[endpoint_id]					   =coalesce(src.[endpoint_id]				                           , trg.[endpoint_id]				 	                          )
	,trg.[encrypt_option]				   =coalesce(src.[encrypt_option]			   collate DATABASE_DEFAULT, trg.[encrypt_option]			 	  collate DATABASE_DEFAULT)
	,trg.[auth_scheme]					   =coalesce(src.[auth_scheme]				   collate DATABASE_DEFAULT, trg.[auth_scheme]				 	  collate DATABASE_DEFAULT)
	,trg.[node_affinity]				   =coalesce(src.[node_affinity]			                           , trg.[node_affinity]			 	                          )
	,trg.[num_reads]					   =coalesce(src.[num_reads]				                           , trg.[num_reads]				 	                          )
	,trg.[num_writes]					   =coalesce(src.[num_writes]				                           , trg.[num_writes]				 	                          )
	,trg.[last_read]					   =coalesce(src.[last_read]				                           , trg.[last_read]				 	                          )
	,trg.[last_write]					   =coalesce(src.[last_write]				                           , trg.[last_write]				 	                          )
	,trg.[net_packet_size]				   =coalesce(src.[net_packet_size]			                           , trg.[net_packet_size]			 	                          )
	,trg.[client_net_address]			   =coalesce(src.[client_net_address]		   collate DATABASE_DEFAULT, trg.[client_net_address]		 	  collate DATABASE_DEFAULT)
	,trg.[client_tcp_port]				   =coalesce(src.[client_tcp_port]			                           , trg.[client_tcp_port]			 	                          )
	,trg.[local_net_address]			   =coalesce(src.[local_net_address]		   collate DATABASE_DEFAULT, trg.[local_net_address]		 	  collate DATABASE_DEFAULT)
	,trg.[local_tcp_port]				   =coalesce(src.[local_tcp_port]			                           , trg.[local_tcp_port]			 	                          )
	,trg.[parent_connection_id]			   =coalesce(src.[parent_connection_id]		                           , trg.[parent_connection_id]		 	                          )
	,trg.[most_recent_sql_handle]		   =coalesce(src.[most_recent_sql_handle]	                           , trg.[most_recent_sql_handle]	 	                          )
	,trg.[login_time]					   =coalesce(src.[login_time]				                           , trg.[login_time]				 	                          )
	,trg.[host_name]					   =coalesce(src.[host_name]				   collate DATABASE_DEFAULT, trg.[host_name]				 	  collate DATABASE_DEFAULT)
	,trg.[program_name]					   =coalesce(src.[program_name]				   collate DATABASE_DEFAULT, trg.[program_name]				 	  collate DATABASE_DEFAULT)
	,trg.[host_process_id]				   =coalesce(src.[host_process_id]			                           , trg.[host_process_id]			 	                          )
	,trg.[client_version]				   =coalesce(src.[client_version]			                           , trg.[client_version]			 	                          )
	,trg.[client_interface_name]		   =coalesce(src.[client_interface_name]	   collate DATABASE_DEFAULT, trg.[client_interface_name]	 	  collate DATABASE_DEFAULT)
	,trg.[security_id]					   =coalesce(src.[security_id]				                           , trg.[security_id]				 	                          )
	,trg.[login_name]					   =coalesce(src.[login_name]				   collate DATABASE_DEFAULT, trg.[login_name]				 	  collate DATABASE_DEFAULT)
	,trg.[nt_domain]					   =coalesce(src.[nt_domain]				   collate DATABASE_DEFAULT, trg.[nt_domain]				 	  collate DATABASE_DEFAULT)
	,trg.[nt_user_name]					   =coalesce(src.[nt_user_name]				   collate DATABASE_DEFAULT, trg.[nt_user_name]				 	  collate DATABASE_DEFAULT)
	,trg.[memory_usage]					   =coalesce(src.[memory_usage]				                           , trg.[memory_usage]				 	                          )
	,trg.[total_scheduled_time]			   =coalesce(src.[total_scheduled_time]		                           , trg.[total_scheduled_time]		 	                          )
	,trg.[last_request_start_time]		   =coalesce(src.[last_request_start_time]	                           , trg.[last_request_start_time]	 	                          )
	,trg.[last_request_end_time]		   =coalesce(src.[last_request_end_time]	                           , trg.[last_request_end_time]	 	                          )
	,trg.[is_user_process]				   =coalesce(src.[is_user_process]			                           , trg.[is_user_process]			 	                          )
	,trg.[original_security_id]			   =coalesce(src.[original_security_id]		                           , trg.[original_security_id]		 	                          )
	,trg.[original_login_name]			   =coalesce(src.[original_login_name]		   collate DATABASE_DEFAULT, trg.[original_login_name]		 	  collate DATABASE_DEFAULT)
	,trg.[last_successful_logon]		   =coalesce(src.[last_successful_logon]	                           , trg.[last_successful_logon]	 	                          )
	,trg.[last_unsuccessful_logon]		   =coalesce(src.[last_unsuccessful_logon]	                           , trg.[last_unsuccessful_logon]	 	                          )
	,trg.[unsuccessful_logons]			   =coalesce(src.[unsuccessful_logons]								   , trg.[unsuccessful_logons]		 	                          )
	,trg.[authenticating_database_id]	   =coalesce(src.[authenticating_database_id]                          , trg.[authenticating_database_id]	                          )
	,trg.[is_blocking_other_session]	   =coalesce(src.[is_blocking_other_session]                           , trg.[is_blocking_other_session]	                          )
	,trg.[dop]							   =coalesce(src.[dop]							   					   , trg.[dop]							   						  )
	,trg.[request_time]					   =coalesce(src.[request_time]					   					   , trg.[request_time]					   						  )
	,trg.[grant_time]					   =coalesce(src.[grant_time]					   					   , trg.[grant_time]					   						  )
	,trg.[requested_memory_kb]			   =coalesce(src.[requested_memory_kb]			   					   , trg.[requested_memory_kb]			   						  )
	,trg.[granted_memory_kb]			   =coalesce(src.[granted_memory_kb]			   					   , trg.[granted_memory_kb]			   						  )
	,trg.[required_memory_kb]			   =coalesce(src.[required_memory_kb]			   					   , trg.[required_memory_kb]			   						  )
	,trg.[used_memory_kb]				   =coalesce(src.[used_memory_kb]				   					   , trg.[used_memory_kb]				   						  )
	,trg.[max_used_memory_kb]			   =coalesce(src.[max_used_memory_kb]			   					   , trg.[max_used_memory_kb]			   						  )
	,trg.[query_cost]					   =coalesce(src.[query_cost]					   					   , trg.[query_cost]					   						  )
	,trg.[timeout_sec]					   =coalesce(src.[timeout_sec]					   					   , trg.[timeout_sec]					   						  )
	,trg.[resource_semaphore_id]		   =coalesce(src.[resource_semaphore_id]		   					   , trg.[resource_semaphore_id]		   						  )
	,trg.[queue_id]						   =coalesce(src.[queue_id]						   					   , trg.[queue_id]						   						  )
	,trg.[wait_order]					   =coalesce(src.[wait_order]					   					   , trg.[wait_order]					   						  )
	,trg.[is_next_candidate]			   =coalesce(src.[is_next_candidate]			   					   , trg.[is_next_candidate]			   						  )
	,trg.[wait_time_ms]					   =coalesce(src.[wait_time_ms]					   					   , trg.[wait_time_ms]					   						  )
	,trg.[pool_id]						   =coalesce(src.[pool_id]						   					   , trg.[pool_id]						   						  )
	,trg.[is_small]						   =coalesce(src.[is_small]						   					   , trg.[is_small]						   						  )
	,trg.[ideal_memory_kb]				   =coalesce(src.[ideal_memory_kb]				   					   , trg.[ideal_memory_kb]				   						  )
	,trg.[reserved_worker_count]		   =coalesce(src.[reserved_worker_count]		   					   , trg.[reserved_worker_count]		   						  )
	,trg.[used_worker_count]			   =coalesce(src.[used_worker_count]			   					   , trg.[used_worker_count]			   						  )
	,trg.[max_used_worker_count]		   =coalesce(src.[max_used_worker_count]		   					   , trg.[max_used_worker_count]		   						  )
	,trg.[reserved_node_bitmap]			   =coalesce(src.[reserved_node_bitmap]			   					   , trg.[reserved_node_bitmap]			   						  )
	,trg.[bucketid]						   =coalesce(src.[bucketid]						   					   , trg.[bucketid]						   						  )
	,trg.[refcounts]					   =coalesce(src.[refcounts]					   					   , trg.[refcounts]					   						  )
	,trg.[usecounts]					   =coalesce(src.[usecounts]					   					   , trg.[usecounts]					   						  )
	,trg.[size_in_bytes]				   =coalesce(src.[size_in_bytes]				   					   , trg.[size_in_bytes]				   						  )
	,trg.[memory_object_address]		   =coalesce(src.[memory_object_address]		   					   , trg.[memory_object_address]		   						  )
	,trg.[cacheobjtype]					   =coalesce(src.[cacheobjtype]					   					   , trg.[cacheobjtype]					   						  )
	,trg.[objtype]						   =coalesce(src.[objtype]						   					   , trg.[objtype]						   						  )
	,trg.[parent_plan_handle]			   =coalesce(src.[parent_plan_handle]			   					   , trg.[parent_plan_handle]			   						  )
	,trg.[creation_time]				   =coalesce(src.[creation_time]				   					   , trg.[creation_time]				   						  )
	,trg.[execution_count]				   =coalesce(src.[execution_count]				   					   , trg.[execution_count]				   						  )
	,trg.[total_worker_time]			   =coalesce(src.[total_worker_time]			   					   , trg.[total_worker_time]			   						  )
	,trg.[min_last_worker_time]			   =coalesce(src.[min_last_worker_time]			   					   , trg.[min_last_worker_time]			   						  )
	,trg.[max_last_worker_time]			   =coalesce(src.[max_last_worker_time]			   					   , trg.[max_last_worker_time]			   						  )
	,trg.[min_worker_time]				   =coalesce(src.[min_worker_time]				   					   , trg.[min_worker_time]				   						  )
	,trg.[max_worker_time]				   =coalesce(src.[max_worker_time]				   					   , trg.[max_worker_time]				   						  )
	,trg.[total_physical_reads]			   =coalesce(src.[total_physical_reads]			   					   , trg.[total_physical_reads]			   						  )
	,trg.[min_last_physical_reads]		   =coalesce(src.[min_last_physical_reads]		   					   , trg.[min_last_physical_reads]		   						  )
	,trg.[max_last_physical_reads]		   =coalesce(src.[max_last_physical_reads]		   					   , trg.[max_last_physical_reads]		   						  )
	,trg.[min_physical_reads]			   =coalesce(src.[min_physical_reads]			   					   , trg.[min_physical_reads]			   						  )
	,trg.[max_physical_reads]			   =coalesce(src.[max_physical_reads]			   					   , trg.[max_physical_reads]			   						  )
	,trg.[total_logical_writes]			   =coalesce(src.[total_logical_writes]			   					   , trg.[total_logical_writes]			   						  )
	,trg.[min_last_logical_writes]		   =coalesce(src.[min_last_logical_writes]		   					   , trg.[min_last_logical_writes]		   						  )
	,trg.[max_last_logical_writes]		   =coalesce(src.[max_last_logical_writes]		   					   , trg.[max_last_logical_writes]		   						  )
	,trg.[min_logical_writes]			   =coalesce(src.[min_logical_writes]			   					   , trg.[min_logical_writes]			   						  )
	,trg.[max_logical_writes]			   =coalesce(src.[max_logical_writes]			   					   , trg.[max_logical_writes]			   						  )
	,trg.[total_logical_reads]			   =coalesce(src.[total_logical_reads]			   					   , trg.[total_logical_reads]			   						  )
	,trg.[min_last_logical_reads]		   =coalesce(src.[min_last_logical_reads]		   					   , trg.[min_last_logical_reads]		   						  )
	,trg.[max_last_logical_reads]		   =coalesce(src.[max_last_logical_reads]		   					   , trg.[max_last_logical_reads]		   						  )
	,trg.[min_logical_reads]			   =coalesce(src.[min_logical_reads]			   					   , trg.[min_logical_reads]			   						  )
	,trg.[max_logical_reads]			   =coalesce(src.[max_logical_reads]			   					   , trg.[max_logical_reads]			   						  )
	,trg.[total_clr_time]				   =coalesce(src.[total_clr_time]				   					   , trg.[total_clr_time]				   						  )
	,trg.[min_last_clr_time]			   =coalesce(src.[min_last_clr_time]			   					   , trg.[min_last_clr_time]			   						  )
	,trg.[max_last_clr_time]			   =coalesce(src.[max_last_clr_time]			   					   , trg.[max_last_clr_time]			   						  )
	,trg.[min_clr_time]					   =coalesce(src.[min_clr_time]					   					   , trg.[min_clr_time]					   						  )
	,trg.[max_clr_time]					   =coalesce(src.[max_clr_time]					   					   , trg.[max_clr_time]					   						  )
	,trg.[min_last_elapsed_time]		   =coalesce(src.[min_last_elapsed_time]		   					   , trg.[min_last_elapsed_time]		   						  )
	,trg.[max_last_elapsed_time]		   =coalesce(src.[max_last_elapsed_time]		   					   , trg.[max_last_elapsed_time]		   						  )
	,trg.[min_elapsed_time]				   =coalesce(src.[min_elapsed_time]				   					   , trg.[min_elapsed_time]				   						  )
	,trg.[max_elapsed_time]				   =coalesce(src.[max_elapsed_time]				   					   , trg.[max_elapsed_time]				   						  )
	,trg.[total_rows]					   =coalesce(src.[total_rows]					   					   , trg.[total_rows]					   						  )
	,trg.[min_last_rows]				   =coalesce(src.[min_last_rows]				   					   , trg.[min_last_rows]				   						  )
	,trg.[max_last_rows]				   =coalesce(src.[max_last_rows]				   					   , trg.[max_last_rows]				   						  )
	,trg.[min_rows]						   =coalesce(src.[min_rows]						   					   , trg.[min_rows]						   						  )
	,trg.[max_rows]						   =coalesce(src.[max_rows]						   					   , trg.[max_rows]						   						  )
	,trg.[total_dop]					   =coalesce(src.[total_dop]					   					   , trg.[total_dop]					   						  )
	,trg.[min_last_dop]					   =coalesce(src.[min_last_dop]					   					   , trg.[min_last_dop]					   						  )
	,trg.[max_last_dop]					   =coalesce(src.[max_last_dop]					   					   , trg.[max_last_dop]					   						  )
	,trg.[min_dop]						   =coalesce(src.[min_dop]						   					   , trg.[min_dop]						   						  )
	,trg.[max_dop]						   =coalesce(src.[max_dop]						   					   , trg.[max_dop]						   						  )
	,trg.[total_grant_kb]				   =coalesce(src.[total_grant_kb]				   					   , trg.[total_grant_kb]				   						  )
	,trg.[min_last_grant_kb]			   =coalesce(src.[min_last_grant_kb]			   					   , trg.[min_last_grant_kb]			   						  )
	,trg.[max_last_grant_kb]			   =coalesce(src.[max_last_grant_kb]			   					   , trg.[max_last_grant_kb]			   						  )
	,trg.[min_grant_kb]					   =coalesce(src.[min_grant_kb]					   					   , trg.[min_grant_kb]					   						  )
	,trg.[max_grant_kb]					   =coalesce(src.[max_grant_kb]					   					   , trg.[max_grant_kb]					   						  )
	,trg.[total_used_grant_kb]			   =coalesce(src.[total_used_grant_kb]			   					   , trg.[total_used_grant_kb]			   						  )
	,trg.[min_last_used_grant_kb]		   =coalesce(src.[min_last_used_grant_kb]		   					   , trg.[min_last_used_grant_kb]		   						  )
	,trg.[max_last_used_grant_kb]		   =coalesce(src.[max_last_used_grant_kb]		   					   , trg.[max_last_used_grant_kb]		   						  )
	,trg.[min_used_grant_kb]			   =coalesce(src.[min_used_grant_kb]			   					   , trg.[min_used_grant_kb]			   						  )
	,trg.[max_used_grant_kb]			   =coalesce(src.[max_used_grant_kb]			   					   , trg.[max_used_grant_kb]			   						  )
	,trg.[total_ideal_grant_kb]			   =coalesce(src.[total_ideal_grant_kb]			   					   , trg.[total_ideal_grant_kb]			   						  )
	,trg.[min_last_ideal_grant_kb]		   =coalesce(src.[min_last_ideal_grant_kb]		   					   , trg.[min_last_ideal_grant_kb]		   						  )
	,trg.[max_last_ideal_grant_kb]		   =coalesce(src.[max_last_ideal_grant_kb]		   					   , trg.[max_last_ideal_grant_kb]		   						  )
	,trg.[min_ideal_grant_kb]			   =coalesce(src.[min_ideal_grant_kb]			   					   , trg.[min_ideal_grant_kb]			   						  )
	,trg.[max_ideal_grant_kb]			   =coalesce(src.[max_ideal_grant_kb]			   					   , trg.[max_ideal_grant_kb]			   						  )
	,trg.[total_reserved_threads]		   =coalesce(src.[total_reserved_threads]		   					   , trg.[total_reserved_threads]		   						  )
	,trg.[min_last_reserved_threads]	   =coalesce(src.[min_last_reserved_threads]	   					   , trg.[min_last_reserved_threads]	   						  )
	,trg.[max_last_reserved_threads]	   =coalesce(src.[max_last_reserved_threads]	   					   , trg.[max_last_reserved_threads]	   						  )
	,trg.[min_reserved_threads]			   =coalesce(src.[min_reserved_threads]			   					   , trg.[min_reserved_threads]			   						  )
	,trg.[max_reserved_threads]			   =coalesce(src.[max_reserved_threads]			   					   , trg.[max_reserved_threads]			   						  )
	,trg.[total_used_threads]			   =coalesce(src.[total_used_threads]			   					   , trg.[total_used_threads]			   						  )
	,trg.[min_last_used_threads]		   =coalesce(src.[min_last_used_threads]		   					   , trg.[min_last_used_threads]		   						  )
	,trg.[max_last_used_threads]		   =coalesce(src.[max_last_used_threads]		   					   , trg.[max_last_used_threads]		   						  )
	,trg.[min_used_threads]				   =coalesce(src.[min_used_threads]				   					   , trg.[min_used_threads]				   						  )
	,trg.[max_used_threads]				   =coalesce(src.[max_used_threads]				   					   , trg.[max_used_threads]				   						  )
	from [srv].[RequestStatistics] as trg
	inner join @tbl2 as src on (trg.[session_id]=src.[session_id])
							and (trg.[request_id]=src.[request_id])
							and (trg.[database_id]=src.[database_id])
							and (trg.[user_id]=src.[user_id])
							and (trg.[start_time]=src.[start_time])
							and (trg.[command] collate DATABASE_DEFAULT=src.[command] collate DATABASE_DEFAULT)
							and ((trg.[sql_handle]=src.[sql_handle] and src.[sql_handle] IS NOT NULL) or (src.[sql_handle] IS NULL))
							and ((trg.[plan_handle]=src.[plan_handle] and src.[plan_handle] IS NOT NULL) or (src.[plan_handle] IS NULL))
							and (trg.[transaction_id]=src.[transaction_id])
							and ((trg.[connection_id]=src.[connection_id] and src.[connection_id] IS NOT NULL) or (src.[connection_id] IS NULL));
	UPDATE trg
	SET trg.[EndRegUTCDate]=GetUTCDate()
	from [srv].[RequestStatistics] as trg
	where not exists(
						select top(1) 1
						from @tbl2 as src
						where (trg.[session_id]=src.[session_id])
							and (trg.[request_id]=src.[request_id])
							and (trg.[database_id]=src.[database_id])
							and (trg.[user_id]=src.[user_id])
							and (trg.[start_time]=src.[start_time])
							and (trg.[command] collate DATABASE_DEFAULT=src.[command] collate DATABASE_DEFAULT)
							and ((trg.[sql_handle]=src.[sql_handle] and src.[sql_handle] IS NOT NULL) or (src.[sql_handle] IS NULL))
							and ((trg.[plan_handle]=src.[plan_handle] and src.[plan_handle] IS NOT NULL) or (src.[plan_handle] IS NULL))
							and (trg.[transaction_id]=src.[transaction_id])
							and ((trg.[connection_id]=src.[connection_id] and src.[connection_id] IS NOT NULL) or (src.[connection_id] IS NULL))
					 );

	INSERT into [srv].[RequestStatistics] ([session_id]
	           ,[request_id]
	           ,[start_time]
	           ,[status]
	           ,[command]
	           ,[sql_handle]
			   --,[TSQL]
	           ,[statement_start_offset]
	           ,[statement_end_offset]
	           ,[plan_handle]
			   --,[QueryPlan]
	           ,[database_id]
	           ,[user_id]
	           ,[connection_id]
	           ,[blocking_session_id]
	           ,[wait_type]
	           ,[wait_time]
	           ,[last_wait_type]
	           ,[wait_resource]
	           ,[open_transaction_count]
	           ,[open_resultset_count]
	           ,[transaction_id]
	           ,[context_info]
	           ,[percent_complete]
	           ,[estimated_completion_time]
	           ,[cpu_time]
	           ,[total_elapsed_time]
	           ,[scheduler_id]
	           ,[task_address]
	           ,[reads]
	           ,[writes]
	           ,[logical_reads]
	           ,[text_size]
	           ,[language]
	           ,[date_format]
	           ,[date_first]
	           ,[quoted_identifier]
	           ,[arithabort]
	           ,[ansi_null_dflt_on]
	           ,[ansi_defaults]
	           ,[ansi_warnings]
	           ,[ansi_padding]
	           ,[ansi_nulls]
	           ,[concat_null_yields_null]
	           ,[transaction_isolation_level]
	           ,[lock_timeout]
	           ,[deadlock_priority]
	           ,[row_count]
	           ,[prev_error]
	           ,[nest_level]
	           ,[granted_query_memory]
	           ,[executing_managed_code]
	           ,[group_id]
	           ,[query_hash]
	           ,[query_plan_hash]
	           ,[most_recent_session_id]
	           ,[connect_time]
	           ,[net_transport]
	           ,[protocol_type]
	           ,[protocol_version]
	           ,[endpoint_id]
	           ,[encrypt_option]
	           ,[auth_scheme]
	           ,[node_affinity]
	           ,[num_reads]
	           ,[num_writes]
	           ,[last_read]
	           ,[last_write]
	           ,[net_packet_size]
	           ,[client_net_address]
	           ,[client_tcp_port]
	           ,[local_net_address]
	           ,[local_tcp_port]
	           ,[parent_connection_id]
	           ,[most_recent_sql_handle]
	           ,[login_time]
	           ,[host_name]
	           ,[program_name]
	           ,[host_process_id]
	           ,[client_version]
	           ,[client_interface_name]
	           ,[security_id]
	           ,[login_name]
	           ,[nt_domain]
	           ,[nt_user_name]
	           ,[memory_usage]
	           ,[total_scheduled_time]
	           ,[last_request_start_time]
	           ,[last_request_end_time]
	           ,[is_user_process]
	           ,[original_security_id]
	           ,[original_login_name]
	           ,[last_successful_logon]
	           ,[last_unsuccessful_logon]
	           ,[unsuccessful_logons]
	           ,[authenticating_database_id]
			   ,[is_blocking_other_session]
			   ,[dop]
			   ,[request_time]
			   ,[grant_time]
			   ,[requested_memory_kb]
			   ,[granted_memory_kb]
			   ,[required_memory_kb]
			   ,[used_memory_kb]
			   ,[max_used_memory_kb]
			   ,[query_cost]
			   ,[timeout_sec]
			   ,[resource_semaphore_id]
			   ,[queue_id]
			   ,[wait_order]
			   ,[is_next_candidate]
			   ,[wait_time_ms]
			   ,[pool_id]
			   ,[is_small]
			   ,[ideal_memory_kb]
			   ,[reserved_worker_count]
			   ,[used_worker_count]
			   ,[max_used_worker_count]
			   ,[reserved_node_bitmap]
			   ,[bucketid]
			   ,[refcounts]
			   ,[usecounts]
			   ,[size_in_bytes]
			   ,[memory_object_address]
			   ,[cacheobjtype]
			   ,[objtype]
			   ,[parent_plan_handle]
			   ,[creation_time]
			   ,[execution_count]
			   ,[total_worker_time]
			   ,[min_last_worker_time]
			   ,[max_last_worker_time]
			   ,[min_worker_time]
			   ,[max_worker_time]
			   ,[total_physical_reads]
			   ,[min_last_physical_reads]
			   ,[max_last_physical_reads]
			   ,[min_physical_reads]
			   ,[max_physical_reads]
			   ,[total_logical_writes]
			   ,[min_last_logical_writes]
			   ,[max_last_logical_writes]
			   ,[min_logical_writes]
			   ,[max_logical_writes]
			   ,[total_logical_reads]
			   ,[min_last_logical_reads]
			   ,[max_last_logical_reads]
			   ,[min_logical_reads]
			   ,[max_logical_reads]
			   ,[total_clr_time]
			   ,[min_last_clr_time]
			   ,[max_last_clr_time]
			   ,[min_clr_time]
			   ,[max_clr_time]
			   ,[min_last_elapsed_time]
			   ,[max_last_elapsed_time]
			   ,[min_elapsed_time]
			   ,[max_elapsed_time]
			   ,[total_rows]
			   ,[min_last_rows]
			   ,[max_last_rows]
			   ,[min_rows]
			   ,[max_rows]
			   ,[total_dop]
			   ,[min_last_dop]
			   ,[max_last_dop]
			   ,[min_dop]
			   ,[max_dop]
			   ,[total_grant_kb]
			   ,[min_last_grant_kb]
			   ,[max_last_grant_kb]
			   ,[min_grant_kb]
			   ,[max_grant_kb]
			   ,[total_used_grant_kb]
			   ,[min_last_used_grant_kb]
			   ,[max_last_used_grant_kb]
			   ,[min_used_grant_kb]
			   ,[max_used_grant_kb]
			   ,[total_ideal_grant_kb]
			   ,[min_last_ideal_grant_kb]
			   ,[max_last_ideal_grant_kb]
			   ,[min_ideal_grant_kb]
			   ,[max_ideal_grant_kb]
			   ,[total_reserved_threads]
			   ,[min_last_reserved_threads]
			   ,[max_last_reserved_threads]
			   ,[min_reserved_threads]
			   ,[max_reserved_threads]
			   ,[total_used_threads]
			   ,[min_last_used_threads]
			   ,[max_last_used_threads]
			   ,[min_used_threads]
			   ,[max_used_threads])
	select		src.[session_id]
	           ,src.[request_id]
	           ,src.[start_time]
	           ,src.[status]
	           ,src.[command]
	           ,src.[sql_handle]
			   --,src.[TSQL]
	           ,src.[statement_start_offset]
	           ,src.[statement_end_offset]
	           ,src.[plan_handle]
			   --,src.[QueryPlan]
	           ,src.[database_id]
	           ,src.[user_id]
	           ,src.[connection_id]
	           ,src.[blocking_session_id]
	           ,src.[wait_type]
	           ,src.[wait_time]
	           ,src.[last_wait_type]
	           ,src.[wait_resource]
	           ,src.[open_transaction_count]
	           ,src.[open_resultset_count]
	           ,src.[transaction_id]
	           ,src.[context_info]
	           ,src.[percent_complete]
	           ,src.[estimated_completion_time]
	           ,src.[cpu_time]
	           ,src.[total_elapsed_time]
	           ,src.[scheduler_id]
	           ,src.[task_address]
	           ,src.[reads]
	           ,src.[writes]
	           ,src.[logical_reads]
	           ,src.[text_size]
	           ,src.[language]
	           ,src.[date_format]
	           ,src.[date_first]
	           ,src.[quoted_identifier]
	           ,src.[arithabort]
	           ,src.[ansi_null_dflt_on]
	           ,src.[ansi_defaults]
	           ,src.[ansi_warnings]
	           ,src.[ansi_padding]
	           ,src.[ansi_nulls]
	           ,src.[concat_null_yields_null]
	           ,src.[transaction_isolation_level]
	           ,src.[lock_timeout]
	           ,src.[deadlock_priority]
	           ,src.[row_count]
	           ,src.[prev_error]
	           ,src.[nest_level]
	           ,src.[granted_query_memory]
	           ,src.[executing_managed_code]
	           ,src.[group_id]
	           ,src.[query_hash]
	           ,src.[query_plan_hash]
	           ,src.[most_recent_session_id]
	           ,src.[connect_time]
	           ,src.[net_transport]
	           ,src.[protocol_type]
	           ,src.[protocol_version]
	           ,src.[endpoint_id]
	           ,src.[encrypt_option]
	           ,src.[auth_scheme]
	           ,src.[node_affinity]
	           ,src.[num_reads]
	           ,src.[num_writes]
	           ,src.[last_read]
	           ,src.[last_write]
	           ,src.[net_packet_size]
	           ,src.[client_net_address]
	           ,src.[client_tcp_port]
	           ,src.[local_net_address]
	           ,src.[local_tcp_port]
	           ,src.[parent_connection_id]
	           ,src.[most_recent_sql_handle]
	           ,src.[login_time]
	           ,src.[host_name]
	           ,src.[program_name]
	           ,src.[host_process_id]
	           ,src.[client_version]
	           ,src.[client_interface_name]
	           ,src.[security_id]
	           ,src.[login_name]
	           ,src.[nt_domain]
	           ,src.[nt_user_name]
	           ,src.[memory_usage]
	           ,src.[total_scheduled_time]
	           ,src.[last_request_start_time]
	           ,src.[last_request_end_time]
	           ,src.[is_user_process]
	           ,src.[original_security_id]
	           ,src.[original_login_name]
	           ,src.[last_successful_logon]
	           ,src.[last_unsuccessful_logon]
	           ,src.[unsuccessful_logons]
	           ,src.[authenticating_database_id]
			   ,src.[is_blocking_other_session]
			   ,src.[dop]
			   ,src.[request_time]
			   ,src.[grant_time]
			   ,src.[requested_memory_kb]
			   ,src.[granted_memory_kb]
			   ,src.[required_memory_kb]
			   ,src.[used_memory_kb]
			   ,src.[max_used_memory_kb]
			   ,src.[query_cost]
			   ,src.[timeout_sec]
			   ,src.[resource_semaphore_id]
			   ,src.[queue_id]
			   ,src.[wait_order]
			   ,src.[is_next_candidate]
			   ,src.[wait_time_ms]
			   ,src.[pool_id]
			   ,src.[is_small]
			   ,src.[ideal_memory_kb]
			   ,src.[reserved_worker_count]
			   ,src.[used_worker_count]
			   ,src.[max_used_worker_count]
			   ,src.[reserved_node_bitmap]
			   ,src.[bucketid]
			   ,src.[refcounts]
			   ,src.[usecounts]
			   ,src.[size_in_bytes]
			   ,src.[memory_object_address]
			   ,src.[cacheobjtype]
			   ,src.[objtype]
			   ,src.[parent_plan_handle]
			   ,src.[creation_time]
			   ,src.[execution_count]
			   ,src.[total_worker_time]
			   ,src.[min_last_worker_time]
			   ,src.[max_last_worker_time]
			   ,src.[min_worker_time]
			   ,src.[max_worker_time]
			   ,src.[total_physical_reads]
			   ,src.[min_last_physical_reads]
			   ,src.[max_last_physical_reads]
			   ,src.[min_physical_reads]
			   ,src.[max_physical_reads]
			   ,src.[total_logical_writes]
			   ,src.[min_last_logical_writes]
			   ,src.[max_last_logical_writes]
			   ,src.[min_logical_writes]
			   ,src.[max_logical_writes]
			   ,src.[total_logical_reads]
			   ,src.[min_last_logical_reads]
			   ,src.[max_last_logical_reads]
			   ,src.[min_logical_reads]
			   ,src.[max_logical_reads]
			   ,src.[total_clr_time]
			   ,src.[min_last_clr_time]
			   ,src.[max_last_clr_time]
			   ,src.[min_clr_time]
			   ,src.[max_clr_time]
			   ,src.[min_last_elapsed_time]
			   ,src.[max_last_elapsed_time]
			   ,src.[min_elapsed_time]
			   ,src.[max_elapsed_time]
			   ,src.[total_rows]
			   ,src.[min_last_rows]
			   ,src.[max_last_rows]
			   ,src.[min_rows]
			   ,src.[max_rows]
			   ,src.[total_dop]
			   ,src.[min_last_dop]
			   ,src.[max_last_dop]
			   ,src.[min_dop]
			   ,src.[max_dop]
			   ,src.[total_grant_kb]
			   ,src.[min_last_grant_kb]
			   ,src.[max_last_grant_kb]
			   ,src.[min_grant_kb]
			   ,src.[max_grant_kb]
			   ,src.[total_used_grant_kb]
			   ,src.[min_last_used_grant_kb]
			   ,src.[max_last_used_grant_kb]
			   ,src.[min_used_grant_kb]
			   ,src.[max_used_grant_kb]
			   ,src.[total_ideal_grant_kb]
			   ,src.[min_last_ideal_grant_kb]
			   ,src.[max_last_ideal_grant_kb]
			   ,src.[min_ideal_grant_kb]
			   ,src.[max_ideal_grant_kb]
			   ,src.[total_reserved_threads]
			   ,src.[min_last_reserved_threads]
			   ,src.[max_last_reserved_threads]
			   ,src.[min_reserved_threads]
			   ,src.[max_reserved_threads]
			   ,src.[total_used_threads]
			   ,src.[min_last_used_threads]
			   ,src.[max_last_used_threads]
			   ,src.[min_used_threads]
			   ,src.[max_used_threads]
	from @tbl2 as src
	where not exists(
						select top(1) 1
						from [srv].[RequestStatistics] as trg
						where (trg.[session_id]=src.[session_id])
							and (trg.[request_id]=src.[request_id])
							and (trg.[database_id]=src.[database_id])
							and (trg.[user_id]=src.[user_id])
							and (trg.[start_time]=src.[start_time])
							and (trg.[command] collate DATABASE_DEFAULT=src.[command] collate DATABASE_DEFAULT)
							and ((trg.[sql_handle]=src.[sql_handle] and src.[sql_handle] IS NOT NULL) or (src.[sql_handle] IS NULL))
							and ((trg.[plan_handle]=src.[plan_handle] and src.[plan_handle] IS NOT NULL) or (src.[plan_handle] IS NULL))
							and (trg.[transaction_id]=src.[transaction_id])
							and ((trg.[connection_id]=src.[connection_id] and src.[connection_id] IS NOT NULL) or (src.[connection_id] IS NULL))
					 );

	UPDATE pq
	SET pq.[dop]						=coalesce(t.[dop]						, pq.[dop]							)
      ,pq.[request_time]				=coalesce(t.[request_time]				, pq.[request_time]					)
      ,pq.[grant_time]					=coalesce(t.[grant_time]				, pq.[grant_time]					)
      ,pq.[requested_memory_kb]			=coalesce(t.[requested_memory_kb]		, pq.[requested_memory_kb]			)
      ,pq.[granted_memory_kb]			=coalesce(t.[granted_memory_kb]			, pq.[granted_memory_kb]			)
      ,pq.[required_memory_kb]			=coalesce(t.[required_memory_kb]		, pq.[required_memory_kb]			)
      ,pq.[used_memory_kb]				=coalesce(t.[used_memory_kb]			, pq.[used_memory_kb]				)
      ,pq.[max_used_memory_kb]			=coalesce(t.[max_used_memory_kb]		, pq.[max_used_memory_kb]			)
      ,pq.[query_cost]					=coalesce(t.[query_cost]				, pq.[query_cost]					)
      ,pq.[timeout_sec]					=coalesce(t.[timeout_sec]				, pq.[timeout_sec]					)
      ,pq.[resource_semaphore_id]		=coalesce(t.[resource_semaphore_id]		, pq.[resource_semaphore_id]		)
      ,pq.[queue_id]					=coalesce(t.[queue_id]					, pq.[queue_id]						)
      ,pq.[wait_order]					=coalesce(t.[wait_order]				, pq.[wait_order]					)
      ,pq.[is_next_candidate]			=coalesce(t.[is_next_candidate]			, pq.[is_next_candidate]			)
      ,pq.[wait_time_ms]				=coalesce(t.[wait_time_ms]				, pq.[wait_time_ms]					)
      ,pq.[pool_id]						=coalesce(t.[pool_id]					, pq.[pool_id]						)
      ,pq.[is_small]					=coalesce(t.[is_small]					, pq.[is_small]						)
      ,pq.[ideal_memory_kb]				=coalesce(t.[ideal_memory_kb]			, pq.[ideal_memory_kb]				)
      ,pq.[reserved_worker_count]		=coalesce(t.[reserved_worker_count]		, pq.[reserved_worker_count]		)
      ,pq.[used_worker_count]			=coalesce(t.[used_worker_count]			, pq.[used_worker_count]			)
      ,pq.[max_used_worker_count]		=coalesce(t.[max_used_worker_count]		, pq.[max_used_worker_count]		)
      ,pq.[reserved_node_bitmap]		=coalesce(t.[reserved_node_bitmap]		, pq.[reserved_node_bitmap]			)
      ,pq.[bucketid]					=coalesce(t.[bucketid]					, pq.[bucketid]						)
      ,pq.[refcounts]					=coalesce(t.[refcounts]					, pq.[refcounts]					)
      ,pq.[usecounts]					=coalesce(t.[usecounts]					, pq.[usecounts]					)
      ,pq.[size_in_bytes]				=coalesce(t.[size_in_bytes]				, pq.[size_in_bytes]				)
      ,pq.[memory_object_address]		=coalesce(t.[memory_object_address]		, pq.[memory_object_address]		)
      ,pq.[cacheobjtype]				=coalesce(t.[cacheobjtype]				, pq.[cacheobjtype]					)
      ,pq.[objtype]						=coalesce(t.[objtype]					, pq.[objtype]						)
      ,pq.[parent_plan_handle]			=coalesce(t.[parent_plan_handle]		, pq.[parent_plan_handle]			)
      ,pq.[creation_time]				=coalesce(t.[creation_time]				, pq.[creation_time]				)
      ,pq.[execution_count]				=coalesce(t.[execution_count]			, pq.[execution_count]				)
      ,pq.[total_worker_time]			=coalesce(t.[total_worker_time]			, pq.[total_worker_time]			)
      ,pq.[min_last_worker_time]		=coalesce(t.[min_last_worker_time]		, pq.[min_last_worker_time]			)
      ,pq.[max_last_worker_time]		=coalesce(t.[max_last_worker_time]		, pq.[max_last_worker_time]			)
      ,pq.[min_worker_time]				=coalesce(t.[min_worker_time]			, pq.[min_worker_time]				)
      ,pq.[max_worker_time]				=coalesce(t.[max_worker_time]			, pq.[max_worker_time]				)
      ,pq.[total_physical_reads]		=coalesce(t.[total_physical_reads]		, pq.[total_physical_reads]			)
      ,pq.[min_last_physical_reads]		=coalesce(t.[min_last_physical_reads]	, pq.[min_last_physical_reads]		)
      ,pq.[max_last_physical_reads]		=coalesce(t.[max_last_physical_reads]	, pq.[max_last_physical_reads]		)
      ,pq.[min_physical_reads]			=coalesce(t.[min_physical_reads]		, pq.[min_physical_reads]			)
      ,pq.[max_physical_reads]			=coalesce(t.[max_physical_reads]		, pq.[max_physical_reads]			)
      ,pq.[total_logical_writes]		=coalesce(t.[total_logical_writes]		, pq.[total_logical_writes]			)
      ,pq.[min_last_logical_writes]		=coalesce(t.[min_last_logical_writes]	, pq.[min_last_logical_writes]		)
      ,pq.[max_last_logical_writes]		=coalesce(t.[max_last_logical_writes]	, pq.[max_last_logical_writes]		)
      ,pq.[min_logical_writes]			=coalesce(t.[min_logical_writes]		, pq.[min_logical_writes]			)
      ,pq.[max_logical_writes]			=coalesce(t.[max_logical_writes]		, pq.[max_logical_writes]			)
      ,pq.[total_logical_reads]			=coalesce(t.[total_logical_reads]		, pq.[total_logical_reads]			)
      ,pq.[min_last_logical_reads]		=coalesce(t.[min_last_logical_reads]	, pq.[min_last_logical_reads]		)
      ,pq.[max_last_logical_reads]		=coalesce(t.[max_last_logical_reads]	, pq.[max_last_logical_reads]		)
      ,pq.[min_logical_reads]			=coalesce(t.[min_logical_reads]			, pq.[min_logical_reads]			)
      ,pq.[max_logical_reads]			=coalesce(t.[max_logical_reads]			, pq.[max_logical_reads]			)
      ,pq.[total_clr_time]				=coalesce(t.[total_clr_time]			, pq.[total_clr_time]				)
      ,pq.[min_last_clr_time]			=coalesce(t.[min_last_clr_time]			, pq.[min_last_clr_time]			)
      ,pq.[max_last_clr_time]			=coalesce(t.[max_last_clr_time]			, pq.[max_last_clr_time]			)
      ,pq.[min_clr_time]				=coalesce(t.[min_clr_time]				, pq.[min_clr_time]					)
      ,pq.[max_clr_time]				=coalesce(t.[max_clr_time]				, pq.[max_clr_time]					)
      ,pq.[min_last_elapsed_time]		=coalesce(t.[min_last_elapsed_time]		, pq.[min_last_elapsed_time]		)
      ,pq.[max_last_elapsed_time]		=coalesce(t.[max_last_elapsed_time]		, pq.[max_last_elapsed_time]		)
      ,pq.[min_elapsed_time]			=coalesce(t.[min_elapsed_time]			, pq.[min_elapsed_time]				)
      ,pq.[max_elapsed_time]			=coalesce(t.[max_elapsed_time]			, pq.[max_elapsed_time]				)
      ,pq.[total_rows]					=coalesce(t.[total_rows]				, pq.[total_rows]					)
      ,pq.[min_last_rows]				=coalesce(t.[min_last_rows]				, pq.[min_last_rows]				)
      ,pq.[max_last_rows]				=coalesce(t.[max_last_rows]				, pq.[max_last_rows]				)
      ,pq.[min_rows]					=coalesce(t.[min_rows]					, pq.[min_rows]						)
      ,pq.[max_rows]					=coalesce(t.[max_rows]					, pq.[max_rows]						)
      ,pq.[total_dop]					=coalesce(t.[total_dop]					, pq.[total_dop]					)
      ,pq.[min_last_dop]				=coalesce(t.[min_last_dop]				, pq.[min_last_dop]					)
      ,pq.[max_last_dop]				=coalesce(t.[max_last_dop]				, pq.[max_last_dop]					)
      ,pq.[min_dop]						=coalesce(t.[min_dop]					, pq.[min_dop]						)
      ,pq.[max_dop]						=coalesce(t.[max_dop]					, pq.[max_dop]						)
      ,pq.[total_grant_kb]				=coalesce(t.[total_grant_kb]			, pq.[total_grant_kb]				)
      ,pq.[min_last_grant_kb]			=coalesce(t.[min_last_grant_kb]			, pq.[min_last_grant_kb]			)
      ,pq.[max_last_grant_kb]			=coalesce(t.[max_last_grant_kb]			, pq.[max_last_grant_kb]			)
      ,pq.[min_grant_kb]				=coalesce(t.[min_grant_kb]				, pq.[min_grant_kb]					)
      ,pq.[max_grant_kb]				=coalesce(t.[max_grant_kb]				, pq.[max_grant_kb]					)
      ,pq.[total_used_grant_kb]			=coalesce(t.[total_used_grant_kb]		, pq.[total_used_grant_kb]			)
      ,pq.[min_last_used_grant_kb]		=coalesce(t.[min_last_used_grant_kb]	, pq.[min_last_used_grant_kb]		)
      ,pq.[max_last_used_grant_kb]		=coalesce(t.[max_last_used_grant_kb]	, pq.[max_last_used_grant_kb]		)
      ,pq.[min_used_grant_kb]			=coalesce(t.[min_used_grant_kb]			, pq.[min_used_grant_kb]			)
      ,pq.[max_used_grant_kb]			=coalesce(t.[max_used_grant_kb]			, pq.[max_used_grant_kb]			)
      ,pq.[total_ideal_grant_kb]		=coalesce(t.[total_ideal_grant_kb]		, pq.[total_ideal_grant_kb]			)
      ,pq.[min_last_ideal_grant_kb]		=coalesce(t.[min_last_ideal_grant_kb]	, pq.[min_last_ideal_grant_kb]		)
      ,pq.[max_last_ideal_grant_kb]		=coalesce(t.[max_last_ideal_grant_kb]	, pq.[max_last_ideal_grant_kb]		)
      ,pq.[min_ideal_grant_kb]			=coalesce(t.[min_ideal_grant_kb]		, pq.[min_ideal_grant_kb]			)
      ,pq.[max_ideal_grant_kb]			=coalesce(t.[max_ideal_grant_kb]		, pq.[max_ideal_grant_kb]			)
      ,pq.[total_reserved_threads]		=coalesce(t.[total_reserved_threads]	, pq.[total_reserved_threads]		)
      ,pq.[min_last_reserved_threads]	=coalesce(t.[min_last_reserved_threads]	, pq.[min_last_reserved_threads]	)
      ,pq.[max_last_reserved_threads]	=coalesce(t.[max_last_reserved_threads]	, pq.[max_last_reserved_threads]	)
      ,pq.[min_reserved_threads]		=coalesce(t.[min_reserved_threads]		, pq.[min_reserved_threads]			)
      ,pq.[max_reserved_threads]		=coalesce(t.[max_reserved_threads]		, pq.[max_reserved_threads]			)
      ,pq.[total_used_threads]			=coalesce(t.[total_used_threads]		, pq.[total_used_threads]			)
      ,pq.[min_last_used_threads]		=coalesce(t.[min_last_used_threads]		, pq.[min_last_used_threads]		)
      ,pq.[max_last_used_threads]		=coalesce(t.[max_last_used_threads]		, pq.[max_last_used_threads]		)
      ,pq.[min_used_threads]			=coalesce(t.[min_used_threads]			, pq.[min_used_threads]				)
      ,pq.[max_used_threads]			=coalesce(t.[max_used_threads]			, pq.[max_used_threads]				)
	from @tbl2 as t
	inner join srv.PlanQuery as pq on t.[plan_handle]=pq.[PlanHandle] and t.[sql_handle]=pq.[SQLHandle];
	
	--drop table #ttt;
END

GO
/****** Object:  StoredProcedure [srv].[AutoStatisticsFileDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoStatisticsFileDB]
AS
BEGIN
	/*
		�������� ���������� ����� ������ ��
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    INSERT INTO [SRV].[srv].[ServerDBFileInfoStatistics]
           ([ServerName]
		   ,[DBName]
           ,[File_id]
           ,[Type_desc]
           ,[FileName]
           ,[Drive]
           ,[Ext]
           ,[CountPage]
           ,[SizeMb]
           ,[SizeGb])
     SELECT [Server]
	  ,[DB_Name]
      ,[File_id]
      ,[Type_desc]
      ,[FileName]
      ,[Drive]
      ,[Ext]
      ,[CountPage]
      ,[SizeMb]
      ,[SizeGb]
	FROM [SRV].[inf].[ServerDBFileInfo];
END
GO
/****** Object:  StoredProcedure [srv].[AutoStatisticsQuerys]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoStatisticsQuerys]
AS
BEGIN
	/*
		���� ������ � �������� �� ����������� MS SQL Server
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	select [ID]
	into #tbl
	from [srv].[QueryStatistics]
	where [InsertUTCDate]<=DateAdd(day,-180,GetUTCDate());

	delete from qs
	from #tbl as t
	inner join [srv].[QueryStatistics] as qs on t.[ID]=qs.[ID];

	declare @tbl0 table (
						[SQLHandle] [varbinary](64) NOT NULL,
						[TSQL] [nvarchar](max) NULL
					   );

	declare @tbl1 table (
						[PlanHandle] [varbinary](64) NOT NULL,
						[SQLHandle] [varbinary](64) NOT NULL,
						[QueryPlan] [xml] NULL
					   );

	declare @tbl2 table (
							[creation_time] [datetime] NOT NULL,
							[last_execution_time] [datetime] NOT NULL,
							[execution_count] [bigint] NOT NULL,
							[CPU] [bigint] NULL,
							[AvgCPUTime] [money] NULL,
							[TotDuration] [bigint] NULL,
							[AvgDur] [money] NULL,
							[Reads] [bigint] NOT NULL,
							[Writes] [bigint] NOT NULL,
							[AggIO] [bigint] NULL,
							[AvgIO] [money] NULL,
							[sql_handle] [varbinary](64) NOT NULL,
							[plan_handle] [varbinary](64) NOT NULL,
							[statement_start_offset] [int] NOT NULL,
							[statement_end_offset] [int] NOT NULL,
							[query_text] [nvarchar](max) NULL,
							[database_name] [nvarchar](128) NULL,
							[object_name] [nvarchar](257) NULL,
							[query_plan] [xml] NULL
						);

	INSERT INTO @tbl2
           ([creation_time]
           ,[last_execution_time]
           ,[execution_count]
           ,[CPU]
           ,[AvgCPUTime]
           ,[TotDuration]
           ,[AvgDur]
           ,[Reads]
           ,[Writes]
           ,[AggIO]
           ,[AvgIO]
           ,[sql_handle]
           ,[plan_handle]
           ,[statement_start_offset]
           ,[statement_end_offset]
           ,[query_text]
           ,[database_name]
           ,[object_name]
           ,[query_plan])
	select  qs.creation_time,
			qs.last_execution_time,
			qs.execution_count,
			qs.total_worker_time/1000 as CPU,
			convert(money, (qs.total_worker_time))/(qs.execution_count*1000)as [AvgCPUTime],
			qs.total_elapsed_time/1000 as TotDuration,
			convert(money, (qs.total_elapsed_time))/(qs.execution_count*1000)as [AvgDur],
			total_logical_reads as [Reads],
			total_logical_writes as [Writes],
			total_logical_reads+total_logical_writes as [AggIO],
			convert(money, (qs.total_logical_reads+qs.total_logical_writes)/(qs.execution_count + 0.0))as [AvgIO],
			qs.[sql_handle],
			qs.plan_handle,
			qs.statement_start_offset,
			qs.statement_end_offset,
			case 
				when sql_handle IS NULL then ' '
				else(substring(st.text,(qs.statement_start_offset+2)/2,(
					case
						when qs.statement_end_offset =-1 then len(convert(nvarchar(MAX),st.text))*2      
						else qs.statement_end_offset    
					end - qs.statement_start_offset)/2  ))
			end as query_text,
			db_name(st.dbid) as database_name,
			object_schema_name(st.objectid, st.dbid)+'.'+object_name(st.objectid, st.dbid) as [object_name],
			sp.[query_plan]
	from sys.dm_exec_query_stats as qs with(readuncommitted)
	cross apply sys.dm_exec_sql_text(qs.[sql_handle]) as st
	cross apply sys.dm_exec_query_plan(qs.[plan_handle]) as sp;

	insert into @tbl1 (
						[PlanHandle],
						[SQLHandle],
						[QueryPlan]
					  )
	select				[plan_handle],
						[sql_handle],
						(select top(1) [query_plan] from sys.dm_exec_query_plan([plan_handle])) as [QueryPlan]--cast(cast([query_plan] as nvarchar(max)) as XML),
	from @tbl2
	group by [plan_handle],
			 [sql_handle];--,
			 --cast([query_plan] as nvarchar(max)),
			 --[query_text];

	insert into @tbl0 (
						[SQLHandle],
						[TSQL]
					  )
	select				[sql_handle],
						(select top(1) text from sys.dm_exec_sql_text([sql_handle])) as [TSQL]--[query_text]
	from @tbl2
	group by [sql_handle];--,
			 --cast([query_plan] as nvarchar(max)),
			 --[query_text];

	;merge [srv].[SQLQuery] as trg
	using @tbl0 as src on trg.[SQLHandle]=src.[SQLHandle]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (
		 	[SQLHandle],
		 	[TSQL]
		   )
	VALUES (
		 	src.[SQLHandle],
		 	src.[TSQL]
		   );
	
	;merge [srv].[PlanQuery] as trg
	using @tbl1 as src on trg.[SQLHandle]=src.[SQLHandle] and trg.[PlanHandle]=src.[PlanHandle]
	WHEN NOT MATCHED BY TARGET THEN
	INSERT (
		 	[PlanHandle],
		 	[SQLHandle],
		 	[QueryPlan]
		   )
	VALUES (
			src.[PlanHandle],
		 	src.[SQLHandle],
		 	src.[QueryPlan]
		   );

    INSERT INTO [srv].[QueryStatistics]
           ([creation_time]
           ,[last_execution_time]
           ,[execution_count]
           ,[CPU]
           ,[AvgCPUTime]
           ,[TotDuration]
           ,[AvgDur]
           ,[Reads]
           ,[Writes]
           ,[AggIO]
           ,[AvgIO]
           ,[sql_handle]
           ,[plan_handle]
           ,[statement_start_offset]
           ,[statement_end_offset]
           --,[query_text]
           ,[database_name]
           ,[object_name]
           --,[query_plan]
		   )
	select  [creation_time]
           ,[last_execution_time]
           ,[execution_count]
           ,[CPU]
           ,[AvgCPUTime]
           ,[TotDuration]
           ,[AvgDur]
           ,[Reads]
           ,[Writes]
           ,[AggIO]
           ,[AvgIO]
           ,[sql_handle]
           ,[plan_handle]
           ,[statement_start_offset]
           ,[statement_end_offset]
           --,[query_text]
           ,[database_name]
           ,[object_name]
           --,[query_plan]
	from @tbl2;
END
GO
/****** Object:  StoredProcedure [srv].[AutoStatisticsTimeRequests]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoStatisticsTimeRequests]
AS
BEGIN
	/*
		���� ������ � �������� ���������� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    delete from [srv].[TSQL_DAY_Statistics]
	where [DATE]<=DateAdd(day,-180,GetUTCDate());
	
	INSERT INTO [srv].[TSQL_DAY_Statistics]
	           ([command]
	           ,[DBName]
			   ,[PlanHandle]
	           ,[SqlHandle]
			   ,[execution_count]
	           ,[min_wait_timeSec]
	           ,[min_estimated_completion_timeSec]
	           ,[min_cpu_timeSec]
	           ,[min_total_elapsed_timeSec]
	           ,[min_lock_timeoutSec]
	           ,[max_wait_timeSec]
	           ,[max_estimated_completion_timeSec]
	           ,[max_cpu_timeSec]
	           ,[max_total_elapsed_timeSec]
	           ,[max_lock_timeoutSec]
			   ,[DATE])
	SELECT [command]
	      ,[DBName]
	      ,[plan_handle]
		  ,[sql_handle]
		  ,count(*) as [execution_count]
	      ,min([wait_timeSec])					as [min_wait_timeSec]
	      ,min([estimated_completion_timeSec])	as [min_estimated_completion_timeSec]
	      ,min([cpu_timeSec])					as [min_cpu_timeSec]
	      ,min([total_elapsed_timeSec])			as [min_total_elapsed_timeSec]
	      ,min([lock_timeoutSec])				as [min_lock_timeoutSec]
		  ,max([wait_timeSec])					as [max_wait_timeSec]
	      ,max([estimated_completion_timeSec])	as [max_estimated_completion_timeSec]
	      ,max([cpu_timeSec])					as [max_cpu_timeSec]
	      ,max([total_elapsed_timeSec])			as [max_total_elapsed_timeSec]
	      ,max([lock_timeoutSec])				as [max_lock_timeoutSec]
		  ,cast([InsertUTCDate] as [DATE])		as [DATE]
	  FROM [srv].[vRequestStatistics] with(readuncommitted)
	  where cast([InsertUTCDate] as date) = DateAdd(day,-1,cast(GetUTCDate() as date))
		and [command]  in (
								'UPDATE',
								'TRUNCATE TABLE',
								'SET OPTION ON',
								'SET COMMAND',
								'SELECT INTO',
								'SELECT',
								'NOP',
								'INSERT',
								'EXECUTE',
								'DELETE',
								'DECLARE',
								'CONDITIONAL',
								'BULK INSERT',
								'BEGIN TRY',
								'BEGIN CATCH',
								'AWAITING COMMAND',
								'ASSIGN',
								'ALTER TABLE'
							  )
			--and [database_id] in (
			--						DB_ID(N'bp_corp'),
			--						DB_ID(N'bp_corp_150517'),
			--						DB_ID(N'bp_corp_170216'),
			--						DB_ID(N'bp_corp_UMFO'),
			--						DB_ID(N'MSCRM_CONFIG'),
			--						DB_ID(N'PROFICD-LIVE-RU'),
			--						DB_ID(N'ProficreditRU_MSCRM'),
			--						DB_ID(N'ProficreditRU_REPORTS'),
			--						DB_ID(N'ProficreditRU_RM')
			--					 )
			and [DBName] is not null
	group by [command]
	      ,[DBName]
	      ,[plan_handle]
		  ,[sql_handle]
		  ,cast([InsertUTCDate] as [DATE]);

	declare @inddt int=1;

	;with tbl11 as (
		select [SqlHandle], max([max_total_elapsed_timeSec]) as [max_total_elapsed_timeSec]
		,min([max_total_elapsed_timeSec]) as [min_max_total_elapsed_timeSec]
		,avg([max_total_elapsed_timeSec]) as [avg_max_total_elapsed_timeSec]
		,sum([execution_count]) as [execution_count]
		from [srv].[TSQL_DAY_Statistics]
		where [max_total_elapsed_timeSec]>=0.001
			and [DATE]<cast(DateAdd(day,-@inddt,cast(GetUTCDate() as date)) as date)
		group by [SqlHandle]
	)
	, tbl12 as (
		select [SqlHandle], max([max_total_elapsed_timeSec]) as [max_total_elapsed_timeSec]
		,min([max_total_elapsed_timeSec]) as [min_max_total_elapsed_timeSec]
		,avg([max_total_elapsed_timeSec]) as [avg_max_total_elapsed_timeSec]
		,sum([execution_count]) as [execution_count]
		,[DATE]
		from [srv].[TSQL_DAY_Statistics]
		where [max_total_elapsed_timeSec]>=0.001
			and [DATE]=cast(DateAdd(day,-@inddt,cast(GetUTCDate() as date)) as date)
		group by [SqlHandle], [DATE]
	)
	, tbl11_sum as (select sum([execution_count]) as [sum_execution_count] from tbl11)
	, tbl12_sum as (select sum([execution_count]) as [sum_execution_count] from tbl12)
	, tbl21 as (
		select top(100000) [sql_handle], max([AvgDur]) as [AvgDur]
		,min([AvgDur]) as [min_AvgDur]
		,avg([AvgDur]) as [avg_AvgDur]
		,sum([execution_count]) as [execution_count]
		from [srv].[QueryStatistics]
		where [AvgDur]>=0.001
			and cast([InsertUTCDate] as date)<cast(DateAdd(day,-@inddt,cast(GetUTCDate() as date)) as date)
		group by [sql_handle]
	)
	, tbl22 as (
		select top(100000) [sql_handle], max([AvgDur]) as [AvgDur]
		,min([AvgDur]) as [min_AvgDur]
		,avg([AvgDur]) as [avg_AvgDur]
		,sum([execution_count]) as [execution_count]
		,cast(DateAdd(hour,-DateDiff(hour,GetDate(),GetUTCDate()),[InsertUTCDate]) as date) as [DATE]
		from [srv].[QueryStatistics]
		where [AvgDur]>=0.001
			and cast([InsertUTCDate] as date)=cast(DateAdd(day,-@inddt,cast(GetUTCDate() as date)) as date)
		group by [sql_handle], cast(DateAdd(hour,-DateDiff(hour,GetDate(),GetUTCDate()),[InsertUTCDate]) as date)
	)
	, tbl21_sum as (select sum([execution_count]) as [sum_execution_count] from tbl21)
	, tbl22_sum as (select sum([execution_count]) as [sum_execution_count] from tbl22)
	, tbl1_total as (
		select (select [sum_execution_count] from tbl12_sum) as [execution_count]
		 , sum(tbl11.[max_total_elapsed_timeSec]*tbl11.[execution_count])/(select [sum_execution_count] from tbl11_sum) as [max_total_elapsed_timeSec]
		 , sum(tbl12.[max_total_elapsed_timeSec]*tbl11.[execution_count])/(select [sum_execution_count] from tbl12_sum) as [max_total_elapsed_timeLastSec]
	     , tbl12.[DATE]
	from tbl11
	inner join tbl12 on tbl11.[SqlHandle]=tbl12.[SqlHandle]
	group by tbl12.[DATE]
	)
	, tbl2_total as (
		select (select [sum_execution_count] from tbl22_sum) as [execution_countStatistics]
		 , sum(tbl21.[AvgDur]*tbl21.[execution_count])/(select [sum_execution_count] from tbl21_sum) as [max_AvgDur_timeSec]
		 , sum(tbl22.[AvgDur]*tbl21.[execution_count])/(select [sum_execution_count] from tbl22_sum) as [max_AvgDur_timeLastSec]
	     , tbl22.[DATE]
	from tbl21
	inner join tbl22 on tbl21.[sql_handle]=tbl22.[sql_handle]
	group by tbl22.[DATE]
	)
	INSERT INTO [srv].[IndicatorStatistics]
	           ([DATE]
			   ,[execution_count]
	           ,[max_total_elapsed_timeSec]
	           ,[max_total_elapsed_timeLastSec]
			   ,[execution_countStatistics]
			   ,[max_AvgDur_timeSec]
			   ,[max_AvgDur_timeLastSec]
	           )
	select t1.[DATE]
		  ,t1.[execution_count]
		  ,t1.[max_total_elapsed_timeSec]
		  ,t1.[max_total_elapsed_timeLastSec]
		  ,t2.[execution_countStatistics]
		  ,t2.[max_AvgDur_timeSec]/1000
		  ,t2.[max_AvgDur_timeLastSec]/1000
	from tbl1_total as t1
	inner join tbl2_total as t2 on t1.[DATE]=t2.[DATE];

	declare @dt datetime=DateAdd(day,-2,GetUTCDate());

	INSERT INTO [srv].[RequestStatisticsArchive]
           ([session_id]
           ,[request_id]
           ,[start_time]
           ,[status]
           ,[command]
           ,[sql_handle]
           ,[statement_start_offset]
           ,[statement_end_offset]
           ,[plan_handle]
           ,[database_id]
           ,[user_id]
           ,[connection_id]
           ,[blocking_session_id]
           ,[wait_type]
           ,[wait_time]
           ,[last_wait_type]
           ,[wait_resource]
           ,[open_transaction_count]
           ,[open_resultset_count]
           ,[transaction_id]
           ,[context_info]
           ,[percent_complete]
           ,[estimated_completion_time]
           ,[cpu_time]
           ,[total_elapsed_time]
           ,[scheduler_id]
           ,[task_address]
           ,[reads]
           ,[writes]
           ,[logical_reads]
           ,[text_size]
           ,[language]
           ,[date_format]
           ,[date_first]
           ,[quoted_identifier]
           ,[arithabort]
           ,[ansi_null_dflt_on]
           ,[ansi_defaults]
           ,[ansi_warnings]
           ,[ansi_padding]
           ,[ansi_nulls]
           ,[concat_null_yields_null]
           ,[transaction_isolation_level]
           ,[lock_timeout]
           ,[deadlock_priority]
           ,[row_count]
           ,[prev_error]
           ,[nest_level]
           ,[granted_query_memory]
           ,[executing_managed_code]
           ,[group_id]
           ,[query_hash]
           ,[query_plan_hash]
           ,[most_recent_session_id]
           ,[connect_time]
           ,[net_transport]
           ,[protocol_type]
           ,[protocol_version]
           ,[endpoint_id]
           ,[encrypt_option]
           ,[auth_scheme]
           ,[node_affinity]
           ,[num_reads]
           ,[num_writes]
           ,[last_read]
           ,[last_write]
           ,[net_packet_size]
           ,[client_net_address]
           ,[client_tcp_port]
           ,[local_net_address]
           ,[local_tcp_port]
           ,[parent_connection_id]
           ,[most_recent_sql_handle]
           ,[login_time]
           ,[host_name]
           ,[program_name]
           ,[host_process_id]
           ,[client_version]
           ,[client_interface_name]
           ,[security_id]
           ,[login_name]
           ,[nt_domain]
           ,[nt_user_name]
           ,[memory_usage]
           ,[total_scheduled_time]
           ,[last_request_start_time]
           ,[last_request_end_time]
           ,[is_user_process]
           ,[original_security_id]
           ,[original_login_name]
           ,[last_successful_logon]
           ,[last_unsuccessful_logon]
           ,[unsuccessful_logons]
           ,[authenticating_database_id]
           ,[InsertUTCDate]
           ,[EndRegUTCDate])
	SELECT	[session_id]
           ,[request_id]
           ,[start_time]
           ,[status]
           ,[command]
           ,[sql_handle]
           ,[statement_start_offset]
           ,[statement_end_offset]
           ,[plan_handle]
           ,[database_id]
           ,[user_id]
           ,[connection_id]
           ,[blocking_session_id]
           ,[wait_type]
           ,[wait_time]
           ,[last_wait_type]
           ,[wait_resource]
           ,[open_transaction_count]
           ,[open_resultset_count]
           ,[transaction_id]
           ,[context_info]
           ,[percent_complete]
           ,[estimated_completion_time]
           ,[cpu_time]
           ,[total_elapsed_time]
           ,[scheduler_id]
           ,[task_address]
           ,[reads]
           ,[writes]
           ,[logical_reads]
           ,[text_size]
           ,[language]
           ,[date_format]
           ,[date_first]
           ,[quoted_identifier]
           ,[arithabort]
           ,[ansi_null_dflt_on]
           ,[ansi_defaults]
           ,[ansi_warnings]
           ,[ansi_padding]
           ,[ansi_nulls]
           ,[concat_null_yields_null]
           ,[transaction_isolation_level]
           ,[lock_timeout]
           ,[deadlock_priority]
           ,[row_count]
           ,[prev_error]
           ,[nest_level]
           ,[granted_query_memory]
           ,[executing_managed_code]
           ,[group_id]
           ,[query_hash]
           ,[query_plan_hash]
           ,[most_recent_session_id]
           ,[connect_time]
           ,[net_transport]
           ,[protocol_type]
           ,[protocol_version]
           ,[endpoint_id]
           ,[encrypt_option]
           ,[auth_scheme]
           ,[node_affinity]
           ,[num_reads]
           ,[num_writes]
           ,[last_read]
           ,[last_write]
           ,[net_packet_size]
           ,[client_net_address]
           ,[client_tcp_port]
           ,[local_net_address]
           ,[local_tcp_port]
           ,[parent_connection_id]
           ,[most_recent_sql_handle]
           ,[login_time]
           ,[host_name]
           ,[program_name]
           ,[host_process_id]
           ,[client_version]
           ,[client_interface_name]
           ,[security_id]
           ,[login_name]
           ,[nt_domain]
           ,[nt_user_name]
           ,[memory_usage]
           ,[total_scheduled_time]
           ,[last_request_start_time]
           ,[last_request_end_time]
           ,[is_user_process]
           ,[original_security_id]
           ,[original_login_name]
           ,[last_successful_logon]
           ,[last_unsuccessful_logon]
           ,[unsuccessful_logons]
           ,[authenticating_database_id]
           ,[InsertUTCDate]
           ,[EndRegUTCDate]
	FROM [srv].[RequestStatistics]
	where [InsertUTCDate]<=@dt;

	delete from [srv].[RequestStatistics]
	where [InsertUTCDate]<=@dt;

END
GO
/****** Object:  StoredProcedure [srv].[AutoUpdateStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[AutoUpdateStatistics]
	--������������ ������ � �� ��� ���������������� �������
	@ObjectSizeMB numeric (16,3) = NULL,
	--������������ ���-�� ����� � ������
	@row_count numeric (16,3) = NULL
AS
BEGIN
	/*
		������ ���������� ����������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    declare @ObjectID int;
	declare @SchemaName nvarchar(255);
	declare @ObjectName nvarchar(255);
	declare @StatsID int;
	declare @StatName nvarchar(255);
	declare @SQL_Str nvarchar(max);
	
	;with st AS(
	select DISTINCT 
	obj.[object_id]
	, obj.[create_date]
	, OBJECT_SCHEMA_NAME(obj.[object_id]) as [SchemaName]
	, obj.[name] as [ObjectName]
	, CAST(
			(
			   --����� ����� �������, ����������������� � ������ (�� 8 �� �� 1024 ��������=�������� �� 128)
				SELECT SUM(ps2.[reserved_page_count])/128.
				from sys.dm_db_partition_stats as ps2
				where ps2.[object_id] = obj.[object_id]
			) as numeric (38,2)
		  ) as [ObjectSizeMB] --������ ������� � ��
	, s.[stats_id]
	, s.[name] as [StatName]
	, sp.[last_updated]
	, i.[index_id]
	, i.[type_desc]
	, i.[name] as [IndexName]
	, ps.[row_count]
	, s.[has_filter]
	, s.[no_recompute]
	, sp.[rows]
	, sp.[rows_sampled]
	--���-�� ��������� ����������� ���:
	--����� ������ ���-�� ��������� � ��������� ������� ���������� � ������� ���������� ���������� ����������
	--� �������� ���������������� ���-�� ����� � ������ � ������ ����� ����� � ������� ��� ��������������� ������������� ��� ��������� ���������� ����������
	, sp.[modification_counter]+ABS(ps.[row_count]-sp.[rows]) as [ModificationCounter]
	--% ���������� �����, ��������� ��� �������������� ����������,
	--� ������ ����� ����� � ������� ��� ��������������� ������������� ��� ��������� ���������� ����������
	, NULLIF(CAST( sp.[rows_sampled]*100./sp.[rows] as numeric(18,3)), 100.00) as [ProcSampled]
	--% ������ ���-�� ��������� � ��������� ������� ���������� � ������� ���������� ���������� ����������
	--� ���������������� ���������� ����� � ������
	, CAST(sp.[modification_counter]*100./(case when (ps.[row_count]=0) then 1 else ps.[row_count] end) as numeric (18,3)) as [ProcModified]
	--��� �������:
	--[ProcModified]*���������� �������� �� ���������������� ���-�� ����� � ������
	, CAST(sp.[modification_counter]*100./(case when (ps.[row_count]=0) then 1 else ps.[row_count] end) as numeric (18,3))
								* case when (ps.[row_count]<=10) THEN 1 ELSE LOG10 (ps.[row_count]) END as [Func]
	--���� �� ������������:
	--����� ���������� �����, ��������� ��� �������������� ����������, �� �����
	--������ ����� ����� � ������� ��� ��������������� ������������� ��� ��������� ���������� ����������
	, CASE WHEN sp.[rows_sampled]<>sp.[rows] THEN 0 ELSE 1 END as [IsScanned]
	, tbl.[name] as [ColumnType]
	, s.[auto_created]	
	from sys.objects as obj
	inner join sys.stats as s on s.[object_id] = obj.[object_id]
	left outer join sys.indexes as i on i.[object_id] = obj.[object_id] and (i.[name] = s.[name] or i.[index_id] in (0,1) 
					and not exists(select top(1) 1 from sys.indexes i2 where i2.[object_id] = obj.[object_id] and i2.[name] = s.[name]))
	left outer join sys.dm_db_partition_stats as ps on ps.[object_id] = obj.[object_id] and ps.[index_id] = i.[index_id]
	outer apply sys.dm_db_stats_properties (s.[object_id], s.[stats_id]) as sp
	left outer join sys.stats_columns as sc on s.[object_id] = sc.[object_id] and s.[stats_id] = sc.[stats_id]
	left outer join sys.columns as col on col.[object_id] = s.[object_id] and col.[column_id] = sc.[column_id]
	left outer join sys.types as tbl on col.[system_type_id] = tbl.[system_type_id] and col.[user_type_id] = tbl.[user_type_id]
	where obj.[type_desc] <> 'SYSTEM_TABLE'
	)
	SELECT
		st.[object_id]
		, st.[SchemaName]
		, st.[ObjectName]
		, st.[stats_id]
		, st.[StatName]
		INTO #tbl
	FROM st
	WHERE NOT (st.[row_count] = 0 AND st.[last_updated] IS NULL)--���� ��� ������ � ���������� �� �����������
		--���� ������ ���������
		AND NOT (st.[row_count] = st.[rows] AND st.[row_count] = st.[rows_sampled] AND st.[ModificationCounter]=0)
		--���� ���� ��� ��������� (� ������ ����������� ��������)
		AND ((st.[ProcModified]>=10.0) OR (st.[Func]>=10.0) OR (st.[ProcSampled]<=50))
		--�����������, ������������ �� ������� ����������
		AND (
			 ([ObjectSizeMB]<=@ObjectSizeMB OR @ObjectSizeMB IS NULL)
			 AND
			 (st.[row_count]<=@row_count OR @row_count IS NULL)
			);
	
	WHILE (exists(select top(1) 1 from #tbl))
	BEGIN
		select top(1)
		@ObjectID	=[object_id]
		,@SchemaName=[SchemaName]
		,@ObjectName=[ObjectName]
		,@StatsId	=[stats_id]
		,@StatName	=[StatName]
		from #tbl;
	
		SET @SQL_Str = 'IF (EXISTS(SELECT TOP(1) 1 FROM sys.stats as s WHERE s.[object_id] = '+CAST(@ObjectID as nvarchar(32)) + 
						' AND s.[stats_id] = ' + CAST(@StatsId as nvarchar(32)) +')) UPDATE STATISTICS ' + QUOTENAME(@SchemaName) +'.' +
						QUOTENAME(@ObjectName) + ' ('+QUOTENAME(@StatName) + ') WITH FULLSCAN;';
	
		execute sp_executesql @SQL_Str;
	
		delete from #tbl
		where [object_id]=@ObjectID
		  and [stats_id]=@StatsId;
	END
	
	drop table #tbl;
END
GO
/****** Object:  StoredProcedure [srv].[AutoUpdateStatisticsCache]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoUpdateStatisticsCache]
	@DB_Name nvarchar(255)=null,
	@IsUpdateStatistics bit=0
AS
BEGIN
	/*
		������� ���� � ����������� ����������� ���������� �� ���� ����������� ��
	*/
	SET NOCOUNT ON;

    declare @tbl table (Name nvarchar(255), [DB_ID] int);
	declare @db_id int;
	declare @name nvarchar(255);
	declare @str nvarchar(255);
	
	--�������� ��� ��, ������� �� �������� ��� ������ ��� ������
	insert into @tbl(Name, [DB_ID])
	select name, database_id
	from sys.databases
	where name not in ('master', 'tempdb', 'model', 'msdb', 'distribution')
	and is_read_only=0	--write
	and state=0			--online
	and user_access=0	--MULTI_USER
	and is_auto_close_on=0
	and (name=@DB_Name or @DB_Name is null);
	
	while(exists(select top(1) 1 from @tbl))
	begin
		--�������� ������������� ������ ��
		select top(1)
			@db_id=[DB_ID]
		  , @name=Name
		from @tbl;
	
		--������� ��� �� id ��
		DBCC FLUSHPROCINDB(@db_id);
	
		if(@IsUpdateStatistics=1)
		begin
			--��������� ����������
			set @str='USE'+' ['+@name+']; exec sp_updatestats;'
			exec(@str);
		end
	
		delete from @tbl
		where [DB_ID]=@db_id;
	end
END
GO
/****** Object:  StoredProcedure [srv].[AutoUpdateStatisticsDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[AutoUpdateStatisticsDB]
	@DB nvarchar(255)=NULL, --�� ���������� �� ��� �� ����
	@ObjectSizeMB numeric (16,3) = NULL,
	--������������ ���-�� ����� � ������
	@row_count numeric (16,3) = NULL,
	@IsTempdb bit=0 --�������� �� �� tempdb
AS
BEGIN
	/*
		����� ������ ����������� ���������� ��� �������� ��
	*/
	SET NOCOUNT ON;

	declare @db_name nvarchar(255);
	declare @sql nvarchar(max);
	declare @ParmDefinition nvarchar(255)= N'@ObjectSizeMB numeric (16,3), @row_count numeric (16,3)';
	
	if(@DB is null)
	begin
		select [name]
		into #tbls
		from sys.databases
		where [is_read_only]=0
		and [state]=0 --ONLINE
		and [user_access]=0--MULTI_USER
		and (((@IsTempdb=0 or @IsTempdb is null) and [name]<>N'tempdb') or (@IsTempdb=1));

		while(exists(select top(1) 1 from #tbls))
		begin
			select top(1)
			@db_name=[name]
			from #tbls;

			set @sql=N'USE ['+@db_name+']; '+
			N'IF(object_id('+N''''+N'[srv].[AutoUpdateStatistics]'+N''''+N') is not null) EXEC [srv].[AutoUpdateStatistics] @ObjectSizeMB=@ObjectSizeMB, @row_count=@row_count;';

			exec sp_executesql @sql, @ParmDefinition, @ObjectSizeMB=@ObjectSizeMB, @row_count=@row_count;

			delete from #tbls
			where [name]=@db_name;
		end

		drop table #tbls;
	end
	else
	begin
		set @sql=N'USE ['+@DB+']; '+
		N'IF(object_id('+N''''+N'[srv].[AutoUpdateStatistics]'+N''''+N') is not null) EXEC [srv].[AutoUpdateStatistics] @ObjectSizeMB=@ObjectSizeMB, @row_count=@row_count;';

		exec sp_executesql @sql, @ParmDefinition, @ObjectSizeMB=@ObjectSizeMB, @row_count=@row_count;
	end
END
GO
/****** Object:  StoredProcedure [srv].[ClearFullInfo]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[ClearFullInfo]
AS
BEGIN
	/*
		������� ��� ��������� ������
	*/
	SET NOCOUNT ON;

	--truncate table [srv].[BlockRequest];
	truncate table [srv].[DBFile];
	truncate table [srv].[ddl_log];
	truncate table [srv].[ddl_log_all];
	truncate table [srv].[Deadlocks];
	truncate table [srv].[Defrag];

	update [srv].[DefragRun]
	set [Run]=0;

    truncate table [srv].[ErrorInfo];
	truncate table [srv].[ErrorInfoArchive];
	truncate table [srv].[ListDefragIndex];

	truncate table [srv].[TableIndexStatistics];
	truncate table [srv].[TableStatistics];
	truncate table [srv].[RequestStatistics];
	truncate table [srv].[RequestStatisticsArchive];
	truncate table [srv].[QueryStatistics];
	truncate table [srv].[PlanQuery];
	truncate table [srv].[SQLQuery];
	truncate table [srv].[QueryRequestGroupStatistics];
	truncate table [srv].[ActiveConnectionStatistics];
	truncate table [srv].[ServerDBFileInfoStatistics];
	truncate table [srv].[ShortInfoRunJobs];

	truncate table [srv].[TSQL_DAY_Statistics];
	truncate table [srv].[IndicatorStatistics];
	truncate table [srv].[KillSession];
	truncate table [srv].[SessionTran];
END
GO
/****** Object:  StoredProcedure [srv].[ConnectValid]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ConnectValid]
@SERVER_IP nvarchar(255) -- IP �������
AS
BEGIN
	/*
		�������� ����������� �������� (1-��������, ������-����������)
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @msg nvarchar(1000);
	declare @str nvarchar(max);

	set @str='SELECT TOP 1 1 FROM '
	+'['+@SERVER_IP+']'+'.'+'['+'SRV'+']'+'.'+'['+'dbo'+']'+'.'+'['+'TEST'+']';

	exec sp_executesql @str;
END

GO
/****** Object:  StoredProcedure [srv].[DeleteArchive]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [srv].[DeleteArchive]
	@day int=14 -- ���-�� ����, �� ������� ������������ �������� ������
AS
BEGIN
	/*
		�������� ������ �������� ������� �� �������
	*/
	SET NOCOUNT ON;

	while(exists(select top(1) 1 from [srv].[ErrorInfoArchive]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[ErrorInfoArchive]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[ddl_log_all]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[ddl_log_all]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[Defrag]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[Defrag]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[TableIndexStatistics]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[TableIndexStatistics]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[TableStatistics]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[TableStatistics]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[RequestStatisticsArchive]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[RequestStatisticsArchive]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[ActiveConnectionStatistics]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[ActiveConnectionStatistics]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[ServerDBFileInfoStatistics]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[ServerDBFileInfoStatistics]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end

	while(exists(select top(1) 1 from [srv].[ServerDBFileInfoStatistics]	where InsertUTCDate<=dateadd(day,-@day,getUTCDate())))
	begin
		delete
		from [srv].[KillSession]
		where InsertUTCDate<=dateadd(day,-@day,getUTCDate());
	end
END



GO
/****** Object:  StoredProcedure [srv].[DeleteArchiveInProductDB]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[DeleteArchiveInProductDB]
AS
BEGIN
	/*
		��� ������� � ����������� ��
	*/

	SET NOCOUNT ON;
END
GO
/****** Object:  StoredProcedure [srv].[ErrorInfoIncUpd]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ErrorInfoIncUpd]
	@ERROR_TITLE			nvarchar(max),
	@ERROR_PRED_MESSAGE		nvarchar(max),
	@ERROR_NUMBER			nvarchar(max),
	@ERROR_MESSAGE			nvarchar(max),
	@ERROR_LINE				nvarchar(max),
	@ERROR_PROCEDURE		nvarchar(max),
	@ERROR_POST_MESSAGE		nvarchar(max),
	@RECIPIENTS				nvarchar(max),
	@StartDate				datetime=null,
	@FinishDate				datetime=null,
	@IsRealTime				bit = 0
AS
BEGIN
	/*
		����������� ������ � ������� ������ �� ����������� �� �����
		���� ��� � ������� ���� ������ � ���������� ����������, ����������� � ������������
		, �� ��������� �������� ���� ������, ���� ���������� ������, � ����� ���������� ������
	*/
	SET NOCOUNT ON;

	declare @ErrorInfo_GUID uniqueidentifier;

	select top 1
	@ErrorInfo_GUID=ErrorInfo_GUID
	from srv.ErrorInfo
	where (ERROR_TITLE=@ERROR_TITLE or @ERROR_TITLE is null)
	and RECIPIENTS=@RECIPIENTS
	and (ERROR_MESSAGE=@ERROR_MESSAGE or @ERROR_MESSAGE is null)
	and (ERROR_PRED_MESSAGE=@ERROR_PRED_MESSAGE or @ERROR_PRED_MESSAGE is null)
	and (ERROR_POST_MESSAGE=@ERROR_POST_MESSAGE or @ERROR_POST_MESSAGE is null)
	and (IsRealTime=@IsRealTime or @IsRealTime is null);

	if(@ErrorInfo_GUID is null)
	begin
		insert into srv.ErrorInfo
					(
						ERROR_TITLE		
						,ERROR_PRED_MESSAGE	
						,ERROR_NUMBER		
						,ERROR_MESSAGE		
						,ERROR_LINE			
						,ERROR_PROCEDURE	
						,ERROR_POST_MESSAGE	
						,RECIPIENTS
						,IsRealTime
						,StartDate
						,FinishDate			
					)
		select
					@ERROR_TITLE		
					,@ERROR_PRED_MESSAGE	
					,@ERROR_NUMBER		
					,@ERROR_MESSAGE		
					,@ERROR_LINE			
					,@ERROR_PROCEDURE	
					,@ERROR_POST_MESSAGE	
					,@RECIPIENTS
					,@IsRealTime
					,isnull(@StartDate, getdate())
					,isnull(@FinishDate,getdate())		
	end
	else
	begin
		update srv.ErrorInfo
		set FinishDate=getdate(),
		[Count]=[Count]+1,
		UpdateDate=getdate()
		where ErrorInfo_GUID=@ErrorInfo_GUID;
	end
END

GO
/****** Object:  StoredProcedure [srv].[ExcelGetActiveConnectionStatistics]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetActiveConnectionStatistics]
as
begin
	/*
		���������� ���������� �� �������� ������������ MS SQL SERVER
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	;with conn as (
		SELECT [ServerName]
			  ,[DBName]
			  ,[ProgramName]
			  ,[LoginName]
			  ,[Status]
			  ,cast([LoginTime] as DATE) as [LoginDate]
			  ,count(*) as [Count]
			  ,MIN(InsertUTCDate) as StartInsertUTCDate
			  ,MAX(InsertUTCDate) as FinishInsertUTCDate
		FROM [srv].[ActiveConnectionStatistics]
		group by [ServerName]
			  ,[DBName]
		    ,[ProgramName]
		    ,[LoginName]
		    ,[Status]
			,cast([LoginTime] as DATE)
	) 
	SELECT [ServerName]
	  ,[DBName]
      ,[ProgramName]
      ,[LoginName]
      ,[Status]
      ,MIN([Count]) as MinCountRows
	  ,MAX([Count]) as MaxCountRows
	  ,AVG([Count]) as AvgCountRows
	  ,MAX([Count])-MIN([Count]) as AbsDiffCountRows
	  ,count(*) as CountRowsStatistic
	  ,MIN(StartInsertUTCDate) as StartInsertUTCDate
	  ,MAX(FinishInsertUTCDate) as FinishInsertUTCDate
  FROM conn
  group by [ServerName]
	  ,[DBName]
      ,[ProgramName]
      ,[LoginName]
      ,[Status];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetAllIndexFrag]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetAllIndexFrag]
as
begin
	/*
		���������� ���������� �� ���� ��������, ������� �������� �� ����� 20 �������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) @@SERVERNAME as [ServerName]
      ,[DBName]
      ,[Schema]
      ,[Name]
      ,[index_name]
      ,[avg_fragmentation_in_percent]
      ,[page_count]
      ,[avg_fragment_size_in_pages]
      ,[database_id]
      ,[object_id]
      ,[index_id]
      ,[partition_number]
      ,[index_type_desc]
      ,[alloc_unit_type_desc]
      ,[index_depth]
      ,[index_level]
      ,[fragment_count]
      ,[FullTable]
	  into #ttt
  FROM [inf].[AllIndexFrag];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DBName]
      ,[Schema]
      ,[Name]
      ,[index_name]
      ,[avg_fragmentation_in_percent]
      ,[page_count]
      ,[avg_fragment_size_in_pages]
      ,[database_id]
      ,[object_id]
      ,[index_id]
      ,[partition_number]
      ,[index_type_desc]
      ,[alloc_unit_type_desc]
      ,[index_depth]
      ,[index_level]
      ,[fragment_count]
      ,[FullTable])
	select @@SERVERNAME as [ServerName]
      ,[DBName]
      ,[Schema]
      ,[Name]
      ,[index_name]
      ,[avg_fragmentation_in_percent]
      ,[page_count]
      ,[avg_fragment_size_in_pages]
      ,[database_id]
      ,[object_id]
      ,[index_id]
      ,[partition_number]
      ,[index_type_desc]
      ,[alloc_unit_type_desc]
      ,[index_depth]
      ,[index_level]
      ,[fragment_count]
      ,[FullTable]
	from ['+@dbs+'].[inf].[AllIndexFrag];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt
  where [page_count]>=20;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetColumns]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetColumns]
as
begin
	/*
		���������� ���������� �� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [Server]
      ,[DBName]
      ,[TableName]
      ,[SchemaName]
      ,[Ord]
      ,[Column_Name]
      ,[Data_Type]
      ,[Prec]
      ,[Scale]
      ,[LEN]
      ,[Is_Nullable]
      ,[Column_Default]
      ,[Table_Type]
	  into #ttt
  FROM [inf].[vColumns];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([Server]
      ,[DBName]
      ,[TableName]
      ,[SchemaName]
      ,[Ord]
      ,[Column_Name]
      ,[Data_Type]
      ,[Prec]
      ,[Scale]
      ,[LEN]
      ,[Is_Nullable]
      ,[Column_Default]
      ,[Table_Type])
	select [Server]
      ,[DBName]
      ,[TableName]
      ,[SchemaName]
      ,[Ord]
      ,[Column_Name]
      ,[Data_Type]
      ,[Prec]
      ,[Scale]
      ,[LEN]
      ,[Is_Nullable]
      ,[Column_Default]
      ,[Table_Type]
	from ['+@dbs+'].[inf].[vColumns];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetDBFilesOperationsStat]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetDBFilesOperationsStat]
as
begin
	/*
		���������� ���������� �� ��
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
	  ,[DBName]
      ,[FileId]
      ,[NumberReads]
      ,[BytesRead]
      ,[IoStallReadMS]
      ,[NumberWrites]
      ,[BytesWritten]
      ,[IoStallWriteMS]
      ,[IoStallMS]
      ,[BytesOnDisk]
      ,[Type_desc]
      ,[FileName]
      ,[Drive]
      ,[Physical_Name]
      ,[Ext]
      ,[CountPage]
      ,[SizeMb]
      ,[SizeGb]
      ,[Growth]
      ,[GrowthMb]
      ,[GrowthGb]
      ,[GrowthPercent]
      ,[is_percent_growth]
      ,[StateDesc]
      ,[IsMediaReadOnly]
      ,[IsReadOnly]
      ,[IsSpace]
      ,[IsNameReserved]
  FROM [inf].[vDBFilesOperationsStat];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetDefaultsConstraints]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetDefaultsConstraints]
as
begin
	/*
		���������� ���������� �� ��������� �� ���������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[TableName]
      ,[Column_NBR]
      ,[Column_Name]
      ,[DefaultName]
      ,[Defaults]
      ,[type]
      ,[type_desc]
      ,[create_date]
	  into #ttt
  FROM [inf].[vDefaultsConstraints];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[TableName]
      ,[Column_NBR]
      ,[Column_Name]
      ,[DefaultName]
      ,[Defaults]
      ,[type]
      ,[type_desc]
      ,[create_date])
	select [ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[TableName]
      ,[Column_NBR]
      ,[Column_Name]
      ,[DefaultName]
      ,[Defaults]
      ,[type]
      ,[type_desc]
      ,[create_date]
	from ['+@dbs+'].[inf].[vDefaultsConstraints];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetDelIndexOptimize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetDelIndexOptimize]
as
begin
	/*
		���������� �������������� �������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
			,[DBName]
			,[SchemaName]
			,[ObjectName]
			,[ObjectType]
			,[ObjectTypeDesc]
			,[IndexName]
			,[IndexType]
			,[IndexTypeDesc]
			,[IndexIsUnique]
			,[IndexIsPK]
			,[IndexIsUniqueConstraint]
			,[Database_ID]
			,[Object_ID]
			,[Index_ID]
			,[Last_User_Seek]
			,[Last_User_Scan]
			,[Last_User_Lookup]
			,[Last_System_Seek]
			,[Last_System_Scan]
			,[Last_System_Lookup]
	  FROM [inf].[vDelIndexOptimize];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetFK_Keys]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetFK_Keys]
as
begin
	/*
		���������� ���������� �� FK-������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) @@SERVERNAME as [ServerName]
      ,[ForeignKey]
      ,[SchemaName]
      ,[TableName]
      ,[ColumnName]
      ,[ReferenceSchemaName]
      ,[ReferenceTableName]
      ,[ReferenceColumnName]
      ,[create_date]
	  into #ttt
  FROM [inf].[vFK_Keys];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[ForeignKey]
      ,[SchemaName]
      ,[TableName]
      ,[ColumnName]
      ,[ReferenceSchemaName]
      ,[ReferenceTableName]
      ,[ReferenceColumnName]
      ,[create_date])
	select @@SERVERNAME as [ServerName]
      ,[ForeignKey]
      ,[SchemaName]
      ,[TableName]
      ,[ColumnName]
      ,[ReferenceSchemaName]
      ,[ReferenceTableName]
      ,[ReferenceColumnName]
      ,[create_date]
	from ['+@dbs+'].[inf].[vFK_Keys];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetFuncs]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetFuncs]
as
begin
	/*
		���������� ���������� �� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [ServerName]
      ,[DB_Name]
      ,[FunctionName]
      ,[type]
      ,[create_date]
      ,[Function script]
	  into #ttt
  FROM [inf].[vFuncs];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DB_Name]
      ,[FunctionName]
      ,[type]
      ,[create_date]
      ,[Function script])
	select [ServerName]
      ,[DB_Name]
      ,[FunctionName]
      ,[type]
      ,[create_date]
      ,[Function script]
	from ['+@dbs+'].[inf].[vFuncs];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetHeaps]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetHeaps]
as
begin
	/*
		���������� ���������� �� ���� �����
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT [Server]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Type_Desc]
      ,[Rows]
	  into #ttt
  FROM [inf].[vHeaps];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([Server]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Type_Desc]
      ,[Rows])
	select [Server]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Type_Desc]
      ,[Rows]
	from ['+@dbs+'].[inf].[vHeaps];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetIdentityColumns]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetIdentityColumns]
as
begin
	/*
		���������� ���������� �� Identity-��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Column_id]
      ,[IdentityColumn]
      ,[Seed_Value]
      ,[Last_Value]
	  into #ttt
  FROM [inf].[vIdentityColumns];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Column_id]
      ,[IdentityColumn]
      ,[Seed_Value]
      ,[Last_Value])
	select [ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Column_id]
      ,[IdentityColumn]
      ,[Seed_Value]
      ,[Last_Value]
	from ['+@dbs+'].[inf].[vIdentityColumns];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetNewIndexOptimize]    Script Date: 07.03.2018 11:22:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [srv].[ExcelGetNewIndexOptimize]
as
begin
	/*
		���������� ������������� ������� ��� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT [ServerName]
		  ,[DBName]
		  ,[Schema]
		  ,[Name]
		  ,[index_advantage]
		  ,[group_handle]
		  ,[unique_compiles]
		  ,[last_user_seek]
		  ,[last_user_scan]
		  ,[avg_total_user_cost]
		  ,[avg_user_impact]
		  ,[system_seeks]
		  ,[last_system_scan]
		  ,[last_system_seek]
		  ,[avg_total_system_cost]
		  ,[avg_system_impact]
		  ,[index_group_handle]
		  ,[index_handle]
		  ,[database_id]
		  ,[object_id]
		  ,[equality_columns]
		  ,[inequality_columns] 
		  ,[statement]
		  ,[K]
		  ,[Keys]
		  ,[include] 
		  ,[sql_statement]
		  ,[user_seeks]
		  ,[user_scans]
		  ,[est_impact]
		  ,[SecondsUptime] 
	  FROM [inf].[vNewIndexOptimize]
	  where [index_advantage]>=30000;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetProcedures]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetProcedures]
as
begin
	/*
		���������� ���������� �� �������� ����������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[ViewName]
      ,[type]
      ,[Create_date]
      ,[Stored Procedure script]
	  into #ttt
  FROM [inf].[vProcedures];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[ViewName]
      ,[type]
      ,[Create_date]
      ,[Stored Procedure script])
	select [ServerName]
      ,[DB_Name]
      ,[SchemaName]
      ,[ViewName]
      ,[type]
      ,[Create_date]
      ,[Stored Procedure script]
	from ['+@dbs+'].[inf].[vProcedures];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetQueryRequestGroupStatistics]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetQueryRequestGroupStatistics]
as
begin
	/*
		���������� ��������������� ��� �������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
	  ,[DBName]
      ,[Count]
      ,[mintotal_elapsed_timeSec]
      ,[maxtotal_elapsed_timeSec]
      ,[mincpu_timeSec]
      ,[maxcpu_timeSec]
      ,[minwait_timeSec]
      ,[maxwait_timeSec]
      ,[row_count]
      ,[SumCountRows]
      ,[min_reads]
      ,[max_reads]
      ,[min_writes]
      ,[max_writes]
      ,[min_logical_reads]
      ,[max_logical_reads]
      ,[min_open_transaction_count]
      ,[max_open_transaction_count]
      ,[min_transaction_isolation_level]
      ,[max_transaction_isolation_level]
      ,[Unique_nt_user_name]
      ,[Unique_nt_domain]
      ,[Unique_login_name]
      ,[Unique_program_name]
      ,[Unique_host_name]
      ,[Unique_client_tcp_port]
      ,[Unique_client_net_address]
      ,[Unique_client_interface_name]
      ,[InsertUTCDate]
	  ,[TSQL]
  FROM [srv].[vQueryRequestGroupStatistics];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetSqlLogins]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [srv].[ExcelGetSqlLogins]
as
begin
	/*
		���������� ��� �������� ������ ��� ����� �� ������ MS SQL SERVER
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
	  ,[Name] as [Login]
      ,[CreateDate]
      ,[ModifyDate]
      ,[DefaultDatabaseName]
      ,[IsPolicyChecked]
      ,[IsExpirationChecked]
      ,[IsDisabled]
	FROM [inf].[SqlLogins];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetSynonyms]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetSynonyms]
as
begin
	/*
		���������� ���������� �� ���������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[Synonyms]
      ,[CreateDate]
      ,[BaseObjectName]
	  into #ttt
  FROM [inf].[vSynonyms];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[Synonyms]
      ,[CreateDate]
      ,[BaseObjectName])
	select [ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[Synonyms]
      ,[CreateDate]
      ,[BaseObjectName]
	from ['+@dbs+'].[inf].[vSynonyms];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetSysLogins]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [srv].[ExcelGetSysLogins]
as
begin
	/*
		���������� ��� ������ ��� ����� �� ������ MS SQL SERVER
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
	  ,[Name] as [Login]
      ,[CreateDate]
      ,[UpdateDate]
      ,[DBName]
      ,[DenyLogin]
      ,[HasAccess]
	  ,case when([IsntName]=1) then N'MS SQL SERVER' else N'WINDOWS' end as [NameInput]
      ,[IsntGroup] as [GroupWindows]
      ,[IsntUser] as [UserWindows]
      ,[SysAdmin]
      ,[SecurityAdmin]
      ,[ServerAdmin]
      ,[SetupAdmin]
      ,[ProcessAdmin]
      ,[DiskAdmin]
      ,[DBCreator]
      ,[BulkAdmin]
	FROM [inf].[SysLogins];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetTableStatistics]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [srv].[ExcelGetTableStatistics]
as
begin
	/*
		���������� ���������� �� ��������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT [ServerName]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[MinCountRows]
      ,[MaxCountRows]
      ,[AvgCountRows]
      ,[AbsDiffCountRows]
      ,[MinDataKB]
      ,[MaxDataKB]
      ,[AvgDataKB]
      ,[AbsDiffDataKB]
      ,[MinIndexSizeKB]
      ,[MaxIndexSizeKB]
      ,[AvgIndexSizeKB]
      ,[AbsDiffIndexSizeKB]
      ,[MinUnusedKB]
      ,[MaxUnusedKB]
      ,[AvgUnusedKB]
      ,[AbsDiffUnusedKB]
      ,[MinReservedKB]
      ,[MaxReservedKB]
      ,[AvgReservedKB]
      ,[AbsDiffReservedKB]
      ,[CountRowsStatistic]
      ,[StartInsertUTCDate]
      ,[FinishInsertUTCDate]
  FROM [srv].[vTableStatistics];
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetTriggers]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetTriggers]
as
begin
	/*
		���������� ���������� �� ���������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) @@SERVERNAME as [Server]
      ,[TriggerName]
      ,[parent_class_desc]
      ,[TrigerType]
      ,[TriggerCreateDate]
      ,[TriggerModifyDate]
      ,[TriggerIsDisabled]
      ,[TriggerInsteadOfTrigger]
      ,[TriggerIsMSShipped]
      ,[is_not_for_replication]
      ,[SchenaName]
      ,[ObjectName]
      ,[ObjectTypeDesc]
      ,[ObjectType]
      ,[Trigger script]
	  into #ttt
  FROM [inf].[vTriggers];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([Server]
	    ,[TriggerName]
		,[parent_class_desc]
		,[TrigerType]
		,[TriggerCreateDate]
		,[TriggerModifyDate]
		,[TriggerIsDisabled]
		,[TriggerInsteadOfTrigger]
		,[TriggerIsMSShipped]
		,[is_not_for_replication]
		,[SchenaName]
		,[ObjectName]
		,[ObjectTypeDesc]
		,[ObjectType]
		,[Trigger script])
	select @@SERVERNAME
	    ,[TriggerName]
		,[parent_class_desc]
		,[TrigerType]
		,[TriggerCreateDate]
		,[TriggerModifyDate]
		,[TriggerIsDisabled]
		,[TriggerInsteadOfTrigger]
		,[TriggerIsMSShipped]
		,[is_not_for_replication]
		,[SchenaName]
		,[ObjectName]
		,[ObjectTypeDesc]
		,[ObjectType]
		,[Trigger script]
	from ['+@dbs+'].[inf].[vTriggers];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetViews]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetViews]
as
begin
	/*
		���������� ���������� �� ��������������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT top(0) [Server]
      ,[DBName]
      ,[SchemaName]
      ,[TableName]
      ,[Type]
      ,[TypeDesc]
      ,[CreateDate]
      ,[ModifyDate]
	  into #ttt
  FROM [inf].[vViews];

  select [name]
  into #dbs
  from sys.databases;

  declare @dbs nvarchar(255);
  declare @sql nvarchar(max);

  while(exists(select top(1) 1 from #dbs))
  begin
	select top(1)
	@dbs=[name]
	from #dbs;

	set @sql=
	N'insert into #ttt([Server]
	    ,[DBName]
	    ,[SchemaName]
	    ,[TableName]
	    ,[Type]
	    ,[TypeDesc]
	    ,[CreateDate]
	    ,[ModifyDate])
	select [Server]
	    ,[DBName]
	    ,[SchemaName]
	    ,[TableName]
	    ,[Type]
	    ,[TypeDesc]
	    ,[CreateDate]
	    ,[ModifyDate]
	from ['+@dbs+'].[inf].[vViews];';

	exec sp_executesql @sql;

	delete from #dbs
	where [name]=@dbs;
  end

  select *
  from #ttt;

  drop table #ttt;
  drop table #dbs;
end
GO
/****** Object:  StoredProcedure [srv].[ExcelGetWaits]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[ExcelGetWaits]
as
begin
	/*
		���������� �������� �� �������������� ������ MS SQL Server
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	
	SELECT @@SERVERNAME as [ServerName]
	  ,[WaitType]
      ,[Wait_S]
      ,[Resource_S]
      ,[Signal_S]
      ,[WaitCount]
      ,[Percentage]
      ,[AvgWait_S]
      ,[AvgRes_S]
      ,[AvgSig_S]
	FROM [inf].[vWaits];
end
GO
/****** Object:  StoredProcedure [srv].[GetHTMLTable]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[GetHTMLTable]
	@recipients nvarchar(max)
	,@dt		datetime -- �� ����� ����� ������
AS
BEGIN
	/*
			��������� HTML-��� ��� �������
	*/
	SET NOCOUNT ON;

    declare @body nvarchar(max);
	declare @tbl table(ID int identity(1,1)
					  ,[ERROR_TITLE]		nvarchar(max)
					  ,[ERROR_PRED_MESSAGE] nvarchar(max)
					  ,[ERROR_NUMBER]		nvarchar(max)
					  ,[ERROR_MESSAGE]		nvarchar(max)
					  ,[ERROR_LINE]			nvarchar(max)
					  ,[ERROR_PROCEDURE]	nvarchar(max)
					  ,[ERROR_POST_MESSAGE]	nvarchar(max)
					  ,[InsertDate]			datetime
					  ,[StartDate]			datetime
					  ,[FinishDate]			datetime
					  ,[Count]				int
					  );
	declare
	@ID						int
	,@ERROR_TITLE			nvarchar(max)
	,@ERROR_PRED_MESSAGE	nvarchar(max)
	,@ERROR_NUMBER			nvarchar(max)
	,@ERROR_MESSAGE			nvarchar(max)
	,@ERROR_LINE			nvarchar(max)
	,@ERROR_PROCEDURE		nvarchar(max)
	,@ERROR_POST_MESSAGE	nvarchar(max)
	,@InsertDate			datetime
	,@StartDate				datetime
	,@FinishDate			datetime
	,@Count					int

	insert into @tbl(
				[ERROR_TITLE]		
				,[ERROR_PRED_MESSAGE] 
				,[ERROR_NUMBER]		
				,[ERROR_MESSAGE]		
				,[ERROR_LINE]			
				,[ERROR_PROCEDURE]	
				,[ERROR_POST_MESSAGE]	
				,[InsertDate]
				,[StartDate]
				,[FinishDate]
				,[Count]
	)
	select top 100
				[ERROR_TITLE]		
				,[ERROR_PRED_MESSAGE] 
				,[ERROR_NUMBER]		
				,[ERROR_MESSAGE]		
				,[ERROR_LINE]			
				,[ERROR_PROCEDURE]	
				,[ERROR_POST_MESSAGE]	
				,[InsertDate]
				,[StartDate]
				,[FinishDate]
				,[Count]
	from [srv].[ErrorInfo]
	where ([RECIPIENTS]=@recipients) or (@recipients IS NULL)
	and InsertDate<=@dt
	order by InsertDate asc;

	set @body='<TABLE BORDER=5>';

	set @body=@body+'<TR>';

	set @body=@body+'<TD>';
	set @body=@body+'� �/�';
	set @body=@body+'</TD>';
	
	set @body=@body+'<TD>';
	set @body=@body+'����';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'������';
	set @body=@body+'</TD>';
	
	set @body=@body+'<TD>';
	set @body=@body+'��������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'��� ������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'���������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'���������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'����������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'����� ������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'���������';
	set @body=@body+'</TD>';

	set @body=@body+'<TD>';
	set @body=@body+'����������';
	set @body=@body+'</TD>';

	set @body=@body+'</TR>';

	while((select top 1 1 from @tbl)>0)
	begin
		set @body=@body+'<TR>';

		select top 1
		@ID					=[ID]
		,@ERROR_TITLE		=[ERROR_TITLE]		
		,@ERROR_PRED_MESSAGE=[ERROR_PRED_MESSAGE]
		,@ERROR_NUMBER		=[ERROR_NUMBER]		
		,@ERROR_MESSAGE		=[ERROR_MESSAGE]	
		,@ERROR_LINE		=[ERROR_LINE]		
		,@ERROR_PROCEDURE	=[ERROR_PROCEDURE]	
		,@ERROR_POST_MESSAGE=[ERROR_POST_MESSAGE]
		,@InsertDate		=[InsertDate]
		,@StartDate			=[StartDate]
		,@FinishDate		=[FinishDate]
		,@Count				=[Count]
		from @tbl;

		set @body=@body+'<TD>';
		set @body=@body+cast(@ID as nvarchar(max));
		set @body=@body+'</TD>';
		
		set @body=@body+'<TD>';
		set @body=@body+rep.GetDateFormat(@InsertDate, default)+' '+rep.GetTimeFormat(@InsertDate, default);--cast(@InsertDate as nvarchar(max));
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_TITLE,'');
		set @body=@body+'</TD>';
		
		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_PRED_MESSAGE,'');
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_NUMBER,'');
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_MESSAGE,'');
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+rep.GetDateFormat(@StartDate, default)+' '+rep.GetTimeFormat(@StartDate, default);--cast(@StartDate as nvarchar(max));
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+rep.GetDateFormat(@FinishDate, default)+' '+rep.GetTimeFormat(@FinishDate, default);--cast(@FinishDate as nvarchar(max));
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+cast(@Count as nvarchar(max));
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_LINE,'');
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_PROCEDURE,'');
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+coalesce(@ERROR_POST_MESSAGE,'');
		set @body=@body+'</TD>';

		delete from @tbl
		where ID=@ID;

		set @body=@body+'</TR>';
	end

	set @body=@body+'</TABLE>';

	select @body;
END

GO
/****** Object:  StoredProcedure [srv].[GetHTMLTableShortInfoDrivers]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[GetHTMLTableShortInfoDrivers]
	@body nvarchar(max) OUTPUT
AS
BEGIN
	/*
			��������� HTML-��� ��� ������� ������������ ��������� (������� ������)
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @tbl table (
						Driver_GUID				uniqueidentifier
						,[Name]					nvarchar(255)
						,[TotalSpaceGb]			float
						,[FreeSpaceGb]			float
						,[DiffFreeSpaceMb]		float
						,[FreeSpacePercent]		float
						,[DiffFreeSpacePercent]	float
						,UpdateUTCDate			datetime
						,[Server]				nvarchar(255)
						,ID						int identity(1,1)
					   );

	declare
	@Driver_GUID			uniqueidentifier
	,@Name					nvarchar(255)
	,@TotalSpaceGb			float
	,@FreeSpaceGb			float
	,@DiffFreeSpaceMb		float
	,@FreeSpacePercent		float
	,@DiffFreeSpacePercent	float
	,@UpdateUTCDate			datetime
	,@Server				nvarchar(255)
	,@ID					int;

	insert into @tbl(
						Driver_GUID				
						,[Name]					
						,[TotalSpaceGb]			
						,[FreeSpaceGb]			
						,[DiffFreeSpaceMb]		
						,[FreeSpacePercent]		
						,[DiffFreeSpacePercent]	
						,UpdateUTCDate			
						,[Server]				
					)
			select		Driver_GUID				
						,[Name]					
						,[TotalSpaceGb]			
						,[FreeSpaceGb]			
						,[DiffFreeSpaceMb]		
						,[FreeSpacePercent]		
						,[DiffFreeSpacePercent]	
						,UpdateUTCDate			
						,[Server]
			from	srv.vDrivers
			where [DiffFreeSpacePercent]<=-5
			or [FreeSpacePercent]<=15
			order by [Server] asc, [Name] asc;

	if(exists(select top(1) 1 from @tbl))
	begin
		set @body='� ���� ������� ���� �������� ��������� �������� ���������, � ������� ���� ���������� ������ �������� ������ 15%, ���� ��������� ����� ����������� ����� 5% �� ����:<br><br>'+'<TABLE BORDER=5>';

		set @body=@body+'<TR>';

		set @body=@body+'<TD>';
		set @body=@body+'� �/�';
		set @body=@body+'</TD>';
	
		set @body=@body+'<TD>';
		set @body=@body+'����';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'������';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'���';
		set @body=@body+'</TD>';
	
		set @body=@body+'<TD>';
		set @body=@body+'�������, ��.';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'��������, ��.';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'��������� ���������� �����, ��.';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'��������, %';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'��������� ���������� �����, %';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'UTC ����� �����������';
		set @body=@body+'</TD>';

		set @body=@body+'</TR>';

		while((select top 1 1 from @tbl)>0)
		begin
			set @body=@body+'<TR>';

			select top 1
			@Driver_GUID			= Driver_GUID			
			,@Name					= Name					
			,@TotalSpaceGb			= TotalSpaceGb			
			,@FreeSpaceGb			= FreeSpaceGb			
			,@DiffFreeSpaceMb		= DiffFreeSpaceMb		
			,@FreeSpacePercent		= FreeSpacePercent		
			,@DiffFreeSpacePercent	= DiffFreeSpacePercent	
			,@UpdateUTCDate			= UpdateUTCDate			
			,@Server				= [Server]				
			,@ID					= [ID]					
			from @tbl;

			set @body=@body+'<TD>';
			set @body=@body+cast(@ID as nvarchar(max));
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+cast(@Driver_GUID as nvarchar(255));
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+coalesce(@Server,'');
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+coalesce(@Name,'');
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+cast(@TotalSpaceGb as nvarchar(255));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+cast(@FreeSpaceGb as nvarchar(255));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+cast(@DiffFreeSpaceMb as nvarchar(255));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+cast(@FreeSpacePercent as nvarchar(255));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+cast(@DiffFreeSpacePercent as nvarchar(255));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+rep.GetDateFormat(@UpdateUTCDate, default)+' '+rep.GetTimeFormat(@UpdateUTCDate, default);
			set @body=@body+'</TD>';

			delete from @tbl
			where ID=@ID;

			set @body=@body+'</TR>';
		end

		set @body=@body+'</TABLE>';

		set @body=@body+'<br><br>��� ����� ��������� ���������� ���������� � ������������� SRV.srv.vDrivers<br><br>��� ��������� ���������� �� ������ ��� ������ ���������� � ������������� SRV.srv.vDBFiles';
	end
	--else
	--begin
	--	set @body='� ���� ������� ��������� ���������� �������, ������� � ��������� �����������, � ����� ��, ��� ����������� �� ������� ����� 30 ������, �� ��������';
	--end
END

GO
/****** Object:  StoredProcedure [srv].[GetHTMLTableShortInfoRunJobs]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[GetHTMLTableShortInfoRunJobs]
	@body nvarchar(max) OUTPUT,
	@second int=60
AS
BEGIN
	/*
		��������� HTML-��� ��� ������� ����������� �������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @tbl table (
						Job_GUID				uniqueidentifier
						,Job_Name				nvarchar(255)
						,LastFinishRunState		nvarchar(255)
						,LastDateTime			datetime
						,LastRunDurationString	nvarchar(255)
						,LastOutcomeMessage		nvarchar(max)
						,[Server]				nvarchar(255)
						,ID						int identity(1,1)
					   );

	declare
	@Job_GUID				uniqueidentifier
	,@Job_Name				nvarchar(255)
	,@LastFinishRunState	nvarchar(255)
	,@LastDateTime			datetime
	,@LastRunDurationString	nvarchar(255)
	,@LastOutcomeMessage	nvarchar(max)
	,@Server				nvarchar(255)
	,@ID					int;

	insert into @tbl(
						Job_GUID
						,Job_Name
						,LastFinishRunState
						,LastDateTime
						,LastRunDurationString
						,LastOutcomeMessage
						,[Server]
					)
			select		Job_GUID
						,Job_Name
						,LastFinishRunState
						,LastDateTime
						,LastRunDurationString
						,LastOutcomeMessage
						,[Server]
			from	srv.ShortInfoRunJobs
			order by LastRunDurationInt desc;

	if(exists(select top(1) 1 from @tbl))
	begin
		set @body='� ���� ������� ��������� ���������� �������, ���� �������� ��������� �������, ������� ���� � ��������� �����������, '
				 +'���� ����������� �� ������� ����� '+cast(@second as nvarchar(255))+' ������:<br><br>'+'<TABLE BORDER=5>';

		set @body=@body+'<TR>';

		set @body=@body+'<TD>';
		set @body=@body+'� �/�';
		set @body=@body+'</TD>';
	
		set @body=@body+'<TD>';
		set @body=@body+'����';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'�������';
		set @body=@body+'</TD>';
	
		set @body=@body+'<TD>';
		set @body=@body+'������';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'���� � �����';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'������������';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'���������';
		set @body=@body+'</TD>';

		set @body=@body+'<TD>';
		set @body=@body+'������';
		set @body=@body+'</TD>';

		set @body=@body+'</TR>';

		while((select top 1 1 from @tbl)>0)
		begin
			set @body=@body+'<TR>';

			select top 1
			@ID						=	[ID]
			,@Job_GUID				=	Job_GUID
			,@Job_Name				=	Job_Name				
			,@LastFinishRunState	=	LastFinishRunState		
			,@LastDateTime			=	LastDateTime			
			,@LastRunDurationString	=	LastRunDurationString	
			,@LastOutcomeMessage	=	LastOutcomeMessage		
			,@Server				=	[Server]				
			from @tbl;

			set @body=@body+'<TD>';
			set @body=@body+cast(@ID as nvarchar(max));
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+cast(@Job_GUID as nvarchar(255));
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+coalesce(@Job_Name,'');
			set @body=@body+'</TD>';
		
			set @body=@body+'<TD>';
			set @body=@body+coalesce(@LastFinishRunState,'');
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+rep.GetDateFormat(@LastDateTime, default)+' '+rep.GetTimeFormat(@LastDateTime, default);--cast(@InsertDate as nvarchar(max));
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+coalesce(@LastRunDurationString,'');
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+coalesce(@LastOutcomeMessage, '');
			set @body=@body+'</TD>';

			set @body=@body+'<TD>';
			set @body=@body+coalesce(@Server, '');
			set @body=@body+'</TD>';

			delete from @tbl
			where ID=@ID;

			set @body=@body+'</TR>';
		end

		set @body=@body+'</TABLE>';
	end
	else
	begin
		set @body='� ���� ������� ��������� ���������� �������, ������� � ��������� �����������, � ����� ��, ��� ����������� �� ������� ����� '
				 +cast(@second as nvarchar(255))
				 +' ������, �� �������� �� ������� '+@@SERVERNAME;
	end
	
	set @body=@body+'<br><br>��� ����� ��������� ���������� ���������� � ������� SRV.srv.ShortInfoRunJobs';
END

GO
/****** Object:  StoredProcedure [srv].[GetRecipients]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[GetRecipients]
@Recipient_Name nvarchar(255)=NULL,
@Recipient_Code nvarchar(10)=NULL,
@Recipients nvarchar(max) out
/*
	��������� ����������� �������� ������� �����������
*/
AS
BEGIN
	SET NOCOUNT ON;
	set @Recipients='';
	
	select @Recipients=@Recipients+d.[Address]+';'
	from srv.Recipient as r
	inner join srv.[Address] as d on r.Recipient_GUID=d.Recipient_GUID
	where (r.Recipient_Name=@Recipient_Name or @Recipient_Name IS NULL)
	and  (r.Recipient_Code=@Recipient_Code or @Recipient_Code IS NULL)
	and r.IsDeleted=0
	and d.IsDeleted=0;
	--order by r.InsertUTCDate desc, d.InsertUTCDate desc;

	if(len(@Recipients)>0) set @Recipients=substring(@Recipients,1,len(@Recipients)-1);
END


GO
/****** Object:  StoredProcedure [srv].[InsertTableStatistics]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [srv].[InsertTableStatistics]
AS
BEGIN
	/*
		�������� ���-�� ����� � ������ ������� �� ���������� �������� (��������� ���-��)+������� ������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @dt date=CAST(GetUTCDate() as date);
    declare @dbs nvarchar(255);
	declare @sql nvarchar(max);

	select [name]
	into #dbs3
	from [master].sys.databases;

	while(exists(select top(1) 1 from #dbs3))
	begin
		select top(1)
		@dbs=[name]
		from #dbs3;

		set @sql=
		N'USE ['+@dbs+']; '
		+N'IF(object_id('+N''''+N'[inf].[vCountRows]'+N''''+N') is not null) BEGIN '
		+N'insert into [SRV].[srv].[TableIndexStatistics]
	         ([ServerName]
				   ,[DBName]
		           ,[SchemaName]
		           ,[TableName]
		           ,[IndexUsedForCounts]
		           ,[CountRows])
		SELECT [ServerName]
			  ,[DBName]
		      ,[SchemaName]
		      ,[TableName]
		      ,[IndexUsedForCounts]
		      ,[Rows]
		  FROM [inf].[vCountRows]
		  where [Type_Desc]='+''''+'CLUSTERED'+''''+'; END';

		exec sp_executesql @sql;

		delete from #dbs3
		where [name]=@dbs;
	end

	select [name]
	into #dbs
	from sys.databases;

	while(exists(select top(1) 1 from #dbs))
	begin
		select top(1)
		@dbs=[name]
		from #dbs;

		set @sql=
		N'USE ['+@dbs+']; '
		+N'IF(object_id('+N''''+N'[inf].[vTableSize]'+N''''+N') is not null) BEGIN '
		+N'INSERT INTO [SRV].[srv].[TableStatistics]
	         ([ServerName]
			   ,[DBName]
	         ,[SchemaName]
	         ,[TableName]
	         ,[CountRows]
	         ,[DataKB]
	         ,[IndexSizeKB]
	         ,[UnusedKB]
	         ,[ReservedKB]
			 ,[TotalPageSizeKB]
			 ,[UsedPageSizeKB]
			 ,[DataPageSizeKB])
	   SELECT [Server]
		  ,[DBName]
	         ,[SchemaName]
	         ,[TableName]
	         ,[CountRows]
	         ,[DataKB]
	         ,[IndexSizeKB]
	         ,[UnusedKB]
	         ,[ReservedKB]
			 ,[TotalPageSizeKB]
			 ,[UsedPageSizeKB]
			 ,[DataPageSizeKB]
		FROM ['+@dbs+'].[inf].[vTableSize]; END';

		exec sp_executesql @sql;

		delete from #dbs
		where [name]=@dbs;
	end

	drop table #dbs;
	drop table #dbs3;

	declare @dt_back date=CAST(DateAdd(day,-1,@dt) as date);

	;with tbl1 as (
		select [Date], 
			   [CountRows],
			   [DataKB],
			   [IndexSizeKB],
			   [UnusedKB],
			   [ReservedKB],
			   [ServerName], 
			   [DBName], 
			   [SchemaName], 
			   [TableName],
			   [TotalPageSizeKB],
			   [UsedPageSizeKB],
			   [DataPageSizeKB]
		from [srv].[TableStatistics]
		where [Date]=@dt_back
	)
	, tbl2 as (
		select [Date], 
			   [CountRows], 
			   [CountRowsBack],
			   [DataKBBack],
			   [IndexSizeKBBack],
			   [UnusedKBBack],
			   [ReservedKBBack],
			   [ServerName], 
			   [DBName], 
			   [SchemaName], 
			   [TableName],
			   [TotalPageSizeKBBack],
			   [UsedPageSizeKBBack],
			   [DataPageSizeKBBack]
		from [srv].[TableStatistics]
		where [Date]=@dt
	)
	update t2
	set t2.[CountRowsBack]		=t1.[CountRows],
		t2.[DataKBBack]			=t1.[DataKB],
		t2.[IndexSizeKBBack]	=t1.[IndexSizeKB],
		t2.[UnusedKBBack]		=t1.[UnusedKB],
		t2.[ReservedKBBack]		=t1.[ReservedKB],
		t2.[TotalPageSizeKBBack]=t1.[TotalPageSizeKB],
		t2.[UsedPageSizeKBBack]	=t1.[UsedPageSizeKB],
		t2.[DataPageSizeKBBack]	=t1.[DataPageSizeKB]
	from tbl1 as t1
	inner join tbl2 as t2 on t1.[Date]=DateAdd(day,-1,t2.[Date])
	and t1.[ServerName]=t2.[ServerName]
	and t1.[DBName]=t2.[DBName]
	and t1.[SchemaName]=t2.[SchemaName]
	and t1.[TableName]=t2.[TableName];

	;with tbl1 as (
		select [Date], 
			   [CountRows], 
			   [CountRowsNext],
			   [DataKBNext],
			   [IndexSizeKBNext],
			   [UnusedKBNext],
			   [ReservedKBNext],
			   [ServerName], 
			   [DBName], 
			   [SchemaName], 
			   [TableName],
			   [TotalPageSizeKBNext],
			   [UsedPageSizeKBNext],
			   [DataPageSizeKBNext]
		from [srv].[TableStatistics]
		where [Date]=@dt_back
	)
	, tbl2 as (
		select [Date], 
			   [CountRows],
			   [DataKB],
			   [IndexSizeKB],
			   [UnusedKB],
			   [ReservedKB],
			   [ServerName], 
			   [DBName], 
			   [SchemaName], 
			   [TableName],
			   [TotalPageSizeKB],
			   [UsedPageSizeKB],
			   [DataPageSizeKB]
		from [srv].[TableStatistics]
		where [Date]=@dt
	)
	update t1
	set t1.[CountRowsNext]		=t2.[CountRows],
		t1.[DataKBNext]			=t2.[DataKB],
		t1.[IndexSizeKBNext]	=t2.[IndexSizeKB],
		t1.[UnusedKBNext]		=t2.[UnusedKB],
		t1.[ReservedKBNext]		=t2.[ReservedKB],
		t1.[TotalPageSizeKBNext]=t2.[TotalPageSizeKB],
		t1.[UsedPageSizeKBNext]	=t2.[UsedPageSizeKB],
		t1.[DataPageSizeKBNext]	=t2.[DataPageSizeKB]
	from tbl1 as t1
	inner join tbl2 as t2 on t1.[Date]=DateAdd(day,-1,t2.[Date])
	and t1.[ServerName]=t2.[ServerName]
	and t1.[DBName]=t2.[DBName]
	and t1.[SchemaName]=t2.[SchemaName]
	and t1.[TableName]=t2.[TableName];
END
GO
/****** Object:  StoredProcedure [srv].[KillConnect]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[KillConnect]
	@databasename nvarchar(255), --��
	@loginname	  nvarchar(255)=NULL  --�����
AS
BEGIN
	/*
		������� ���������� ��� ��������� �� � ��������� ������ �����
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	if(@databasename is null)
	begin
		;THROW 50000, '���� ������ �� ������!', 0;
	end
	else
	begin
		declare @dbid int=db_id(@databasename);

		if(@dbid is NULL)
		begin
			;THROW 50000, '����� ���� ������ �� ����������!', 0;
		end
		else if @dbid <= 4
		begin
			;THROW 50000, '�������� ����������� � ��������� �� ���������!', 0;
		end
		else
		begin
			declare @query nvarchar(max);
			set @query = '';

			select @query=coalesce(@query,',' )
						+'kill '
						+convert(varchar, spid)
						+'; '
			from master..sysprocesses
			where dbid=db_id(@databasename)
			and spid<>@@SPID
			and (loginame=@loginname or @loginname is null);
	
			if len(@query) > 0
			begin
				begin try
					exec(@query);
				end try
				begin catch
				end catch
			end
		end
	end
END
GO
/****** Object:  StoredProcedure [srv].[KillFullOldConnect]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[KillFullOldConnect]
	@OldHour int=24
AS
BEGIN
	/*
		������� �� �����������, ��������� ���������� ������� ���� ����� ����� �����.
		��������! ��������� �� master, tempdb, model � msdb �� ��������� � ��������.
		������, �� distribution ��� ���������� ����� ��������� � ��� ���������.
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @query nvarchar(max);
	set @query = '';

	select @query=coalesce(@query,',' )
				+'kill '
				+convert(varchar, spid)
				+'; '
	from master..sysprocesses
	where dbid>4
	and [last_batch]<dateadd(hour,-@OldHour,getdate())
	order by [last_batch]
	
	if len(@query) > 0
	begin
		begin try
			exec(@query);
		end try
		begin catch
		end catch
	end
END
GO
/****** Object:  StoredProcedure [srv].[MergeDBFileInfo]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [srv].[MergeDBFileInfo]
AS
BEGIN
	/*
		��������� ������� ������ ��
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	;merge [srv].[DBFile] as f
	using [inf].[ServerDBFileInfo] as ff
	on f.File_ID=ff.File_ID and f.DB_ID=ff.[database_id] and f.[Server]=ff.[Server]
	when matched then
		update set UpdateUTCDate	= getUTCDate()
				 ,[Name]			= ff.[FileName]			
				 ,[Drive]			= ff.[Drive]			
				 ,[Physical_Name]	= ff.[Physical_Name]	
				 ,[Ext]				= ff.[Ext]				
				 ,[Growth]			= ff.[Growth]			
				 ,[IsPercentGrowth]	= ff.[is_percent_growth]	
				 ,[SizeMb]			= ff.[SizeMb]			
				 ,[DiffSizeMb]		= round(ff.[SizeMb]-f.[SizeMb],3)	
	when not matched by target then
		insert (
				[Server]
				,[Name]
				,[Drive]
				,[Physical_Name]
				,[Ext]
				,[Growth]
				,[IsPercentGrowth]
				,[DB_ID]
				,[DB_Name]
				,[SizeMb]
				,[File_ID]
				,[DiffSizeMb]
			   )
		values (
				ff.[Server]
				,ff.[FileName]
				,ff.[Drive]
				,ff.[Physical_Name]
				,ff.[Ext]
				,ff.[Growth]
				,ff.[is_percent_growth]
				,ff.[database_id]
				,ff.[DB_Name]
				,ff.[SizeMb]
				,ff.[File_id]
				,0
			   )
	when not matched by source and f.[Server]=@@SERVERNAME then delete;
END


GO
/****** Object:  StoredProcedure [srv].[MergeDriverInfo]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [srv].[MergeDriverInfo]
AS
BEGIN
	/*
		��������� ������� ���������-������
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	declare @Drivers table (
							[Server] nvarchar(255),
							Name nvarchar(8),
							TotalSpace float,
							FreeSpace float,
							DiffFreeSpace float NULL
						   );
	insert into @Drivers   (
							[Server],
							Name,
							TotalSpace,
							FreeSpace
						   )
	select					[Server],
							Name,
							TotalSpace,
							FreeSpace
	from				srv.Drivers
	where [Server]=@@SERVERNAME;

	declare @TotalSpace float;
    declare @FreeSpace float;
	declare @DrivePath nvarchar(8);

	while(exists(select top(1) 1 from @Drivers where DiffFreeSpace is null))
	begin
		select top(1)
		@DrivePath=Name
		from @Drivers
		where DiffFreeSpace is null;

		exec srv.sp_DriveSpace @DrivePath = @DrivePath
						 , @TotalSpace = @TotalSpace out
						 , @FreeSpace = @FreeSpace out;

		update @Drivers
		set TotalSpace=@TotalSpace
		   ,FreeSpace=@FreeSpace
		   ,DiffFreeSpace=case when FreeSpace>0 then round(FreeSpace-@FreeSpace,3) else 0 end
		where Name=@DrivePath;
	end

	;merge [srv].[Drivers] as d
	using @Drivers as dd
	on d.Name=dd.Name and d.[Server]=dd.[Server]
	when matched then
		update set UpdateUTcDate = getUTCDate()
				 ,[TotalSpace]	 = dd.[TotalSpace]	 
				 ,[FreeSpace]	 = dd.[FreeSpace]	 
				 ,[DiffFreeSpace]= dd.[DiffFreeSpace];
END
GO
/****** Object:  StoredProcedure [srv].[RunDiffBackupDB]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[RunDiffBackupDB]
	@ClearLog bit=1 --������� �� ������ ���������� 
AS
BEGIN
	/*
			�������� ���������� ��������� ����� ��
	*/
	SET NOCOUNT ON;

    declare @dt datetime=getdate();
	declare @year int=YEAR(@dt);
	declare @month int=MONTH(@dt);
	declare @day int=DAY(@dt);
	declare @hour int=DatePart(hour, @dt);
	declare @minute int=DatePart(minute, @dt);
	declare @second int=DatePart(second, @dt);
	declare @pathBackup nvarchar(255);
	declare @pathstr nvarchar(255);
	declare @DBName nvarchar(255);
	declare @backupName nvarchar(255);
	declare @sql nvarchar(max);
	declare @backupSetId as int;
	declare @FileNameLog nvarchar(255);
	
	declare @tbl table (
		[DBName] [nvarchar](255) NOT NULL,
		[DiffPathBackup] [nvarchar](255) NOT NULL
	);

	declare @tbllog table(
		[DBName] [nvarchar](255) NOT NULL,
		[FileNameLog] [nvarchar](255) NOT NULL
	);
	
	insert into @tbl (
	           [DBName]
	           ,[DiffPathBackup]
	)
	select		DB_NAME([DBID])
	           ,[DiffPathBackup]
	from [srv].[BackupSettings]
	where [DiffPathBackup] is not null;

	insert into @tbllog([DBName], [FileNameLog])
	select t.[DBName], tt.[FileName] as [FileNameLog]
	from @tbl as t
	inner join [inf].[ServerDBFileInfo] as tt on t.[DBName]=DB_NAME(tt.[database_id])
	where tt.[Type_desc]='LOG';
	
	while(exists(select top(1) 1 from @tbl))
	begin
		set @backupSetId=NULL;

		select top(1)
		@DBName=[DBName],
		@pathBackup=[DiffPathBackup]
		from @tbl;
	
		set @backupName=@DBName+N'_Diff_backup_'+cast(@year as nvarchar(255))+N'_'+cast(@month as nvarchar(255))+N'_'+cast(@day as nvarchar(255))+N'_'
						+cast(@hour as nvarchar(255))+N'_'+cast(@minute as nvarchar(255))+N'_'+cast(@second as nvarchar(255));
		set @pathstr=@pathBackup+@backupName+N'.bak';
	
		set @sql=N'BACKUP DATABASE ['+@DBName+N'] TO DISK = N'+N''''+@pathstr+N''''+
				 N' WITH DIFFERENTIAL, NOFORMAT, NOINIT, NAME = N'+N''''+@backupName+N''''+
				 N', CHECKSUM, STOP_ON_ERROR, SKIP, REWIND, COMPRESSION, STATS = 10;';
	
		exec(@sql);

		select @backupSetId = position
		from msdb..backupset where database_name=@DBName
		and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@DBName);

		set @sql=N'������ �����������. �������� � ��������� ����������� ��� ���� ������ "'+@DBName+'" �� �������.';

		if @backupSetId is null begin raiserror(@sql, 16, 1) end
		else
		begin
			set @sql=N'RESTORE VERIFYONLY FROM DISK = N'+''''+@pathstr+N''''+N' WITH FILE = '+cast(@backupSetId as nvarchar(255));

			exec(@sql);
		end

		if(@ClearLog=1)
		begin
			while(exists(select top(1) 1 from @tbllog where [DBName]=@DBName))
			begin
				select top(1)
				@FileNameLog=FileNameLog
				from @tbllog
				where DBName=@DBName;
			
				set @sql=N'USE ['+@DBName+N'];'+N' DBCC SHRINKFILE (N'+N''''+@FileNameLog+N''''+N' , 0, TRUNCATEONLY)';

				exec(@sql);

				delete from @tbllog
				where FileNameLog=@FileNameLog
				and DBName=@DBName;
			end
		end
		
		delete from @tbl
		where [DBName]=@DBName;
	end
END

GO
/****** Object:  StoredProcedure [srv].[RunErrorInfoProc]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[RunErrorInfoProc]
	@IsRealTime bit =0	-- ����� ��������
AS
BEGIN
	/*
		��������� �������� ����������� �� ������� � ��������� �������
	*/
	SET NOCOUNT ON;
	declare @dt datetime=getdate();

	declare @tbl table(Recipients nvarchar(max));
	declare @recipients nvarchar(max);
	declare @recipient nvarchar(255);
	declare @result nvarchar(max)='';
	declare @recp nvarchar(max);
	declare @ind int;
	declare @recipients_key nvarchar(max);

	 insert into @tbl(Recipients)
	 select [RECIPIENTS]
	 from srv.ErrorInfo
	 where InsertDate<=@dt and IsRealTime=@IsRealTime
	 group by [RECIPIENTS];

	 declare @rec_body table(Body nvarchar(max));
	 declare @body nvarchar(max);

	 declare @query nvarchar(max);

	 while((select top 1 1 from @tbl)>0)
	 begin
		select top 1
		@recipients=Recipients
		from @tbl;

		set @recipients_key=@recipients;
		set @result='';

		while(len(@recipients)>0)
		begin
			set @ind=CHARINDEX(';', @recipients);
			if(@ind>0)
			begin
				set @recipient=substring(@recipients,1, @ind-1);
				set @recipients=substring(@recipients,@ind+1,len(@recipients)-@ind);
			end
			else
			begin
				set @recipient=@recipients;
				set @recipients='';
			end;

			--select @recipients,@recipient

			--select @recipients, len(@recipients)

			exec [srv].[GetRecipients]
			@Recipient_Code=@recipient,
			@Recipients=@recp out;

			if(len(@recp)=0)
			begin
				exec [srv].[GetRecipients]
				@Recipient_Name=@recipient,
				@Recipients=@recp out;

				if(len(@recp)=0) set @recp=@recipient;
			end

			--select @recp,1

			set @result=@result+@recp+';';
		end

		set @result=substring(@result,1,len(@result)-1);
		set @recipients=@result;

		insert into @rec_body(Body)
		exec srv.GetHTMLTable @recipients=@recipients_key, @dt=@dt;

		select top 1
		@body=Body
		from @rec_body;

		--select @Recipients;

		 EXEC msdb.dbo.sp_send_dbmail
		-- ��������� ���� ������� �������������� �������� ��������
			@profile_name = 'profile_name',
		-- ����� ����������
			@recipients = @recipients,--'Gribkov@mkis.su',
		-- ����� ������
			@body = @body,
		-- ����
			@subject = N'���������� �� ������� ����������',
			@body_format='HTML'--,
		-- ��� ������� ������� � ������ ���������� ������������� SQL-�������
			--@query = @query--'SELECT TOP 10 name FROM sys.objects';

		delete from @tbl
		where Recipients=@recipients_key;

		delete from @rec_body;
	 end

	INSERT INTO [srv].[ErrorInfoArchive]
           ([ErrorInfo_GUID]
           ,[ERROR_TITLE]
           ,[ERROR_PRED_MESSAGE]
           ,[ERROR_NUMBER]
           ,[ERROR_MESSAGE]
           ,[ERROR_LINE]
           ,[ERROR_PROCEDURE]
           ,[ERROR_POST_MESSAGE]
           ,[RECIPIENTS]
		   ,[StartDate]
		   ,[FinishDate]
		   ,[Count]
	,IsRealTime
		   )
     SELECT
           [ErrorInfo_GUID]
           ,[ERROR_TITLE]
           ,[ERROR_PRED_MESSAGE]
           ,[ERROR_NUMBER]
           ,[ERROR_MESSAGE]
           ,[ERROR_LINE]
           ,[ERROR_PROCEDURE]
           ,[ERROR_POST_MESSAGE]
           ,[RECIPIENTS]
		   ,[StartDate]
		   ,[FinishDate]
		   ,[Count]
	,IsRealTime
	 FROM [srv].[ErrorInfo]
	 where IsRealTime=@IsRealTime
	 and InsertDate<=@dt
	 order by InsertDate;

	delete from [srv].[ErrorInfo]
	where IsRealTime=@IsRealTime
	and InsertDate<=@dt;
END

GO
/****** Object:  StoredProcedure [srv].[RunFullBackupDB]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[RunFullBackupDB]
	@ClearLog bit=1 --������� �� ������ ����������
AS
BEGIN
	/*
		�������� ������ ��������� ����� �� � ��������������� ��������� �� ����������� ����� ��
	*/
	SET NOCOUNT ON;

    declare @dt datetime=getdate();
	declare @year int=YEAR(@dt);
	declare @month int=MONTH(@dt);
	declare @day int=DAY(@dt);
	declare @hour int=DatePart(hour, @dt);
	declare @minute int=DatePart(minute, @dt);
	declare @second int=DatePart(second, @dt);
	declare @pathBackup nvarchar(255);
	declare @pathstr nvarchar(255);
	declare @DBName nvarchar(255);
	declare @backupName nvarchar(255);
	declare @sql nvarchar(max);
	declare @backupSetId as int;
	declare @FileNameLog nvarchar(255);

	declare @tbllog table(
		[DBName] [nvarchar](255) NOT NULL,
		[FileNameLog] [nvarchar](255) NOT NULL
	);
	
	declare @tbl table (
		[DBName] [nvarchar](255) NOT NULL,
		[FullPathBackup] [nvarchar](255) NOT NULL
	);
	
	insert into @tbl (
	           [DBName]
	           ,[FullPathBackup]
	)
	select		DB_NAME([DBID])
	           ,[FullPathBackup]
	from [srv].[BackupSettings];

	insert into @tbllog([DBName], [FileNameLog])
	select t.[DBName], tt.[FileName] as [FileNameLog]
	from @tbl as t
	inner join [inf].[ServerDBFileInfo] as tt on t.[DBName]=DB_NAME(tt.[database_id])
	where tt.[Type_desc]='LOG';
	
	while(exists(select top(1) 1 from @tbl))
	begin
		set @backupSetId=NULL;

		select top(1)
		@DBName=[DBName],
		@pathBackup=[FullPathBackup]
		from @tbl;
	
		set @backupName=@DBName+N'_Full_backup_'+cast(@year as nvarchar(255))+N'_'+cast(@month as nvarchar(255))+N'_'+cast(@day as nvarchar(255))--+N'_'
						--+cast(@hour as nvarchar(255))+N'_'+cast(@minute as nvarchar(255))+N'_'+cast(@second as nvarchar(255));
		set @pathstr=@pathBackup+@backupName+N'.bak';

		set @sql=N'DBCC CHECKDB(N'+N''''+@DBName+N''''+N')  WITH NO_INFOMSGS';

		exec(@sql);
	
		set @sql=N'BACKUP DATABASE ['+@DBName+N'] TO DISK = N'+N''''+@pathstr+N''''+
				 N' WITH NOFORMAT, NOINIT, NAME = N'+N''''+@backupName+N''''+
				 N', CHECKSUM, STOP_ON_ERROR, SKIP, REWIND, COMPRESSION, STATS = 10;';
	
		exec(@sql);

		select @backupSetId = position
		from msdb..backupset where database_name=@DBName
		and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@DBName);

		set @sql=N'������ �����������. �������� � ��������� ����������� ��� ���� ������ "'+@DBName+'" �� �������.';

		if @backupSetId is null begin raiserror(@sql, 16, 1) end
		else
		begin
			set @sql=N'RESTORE VERIFYONLY FROM DISK = N'+''''+@pathstr+N''''+N' WITH FILE = '+cast(@backupSetId as nvarchar(255));

			exec(@sql);
		end

		if(@ClearLog=1)
		begin
			while(exists(select top(1) 1 from @tbllog where [DBName]=@DBName))
			begin
				select top(1)
				@FileNameLog=FileNameLog
				from @tbllog
				where DBName=@DBName;
			
				set @sql=N'USE ['+@DBName+N'];'+N' DBCC SHRINKFILE (N'+N''''+@FileNameLog+N''''+N' , 0, TRUNCATEONLY)';

				exec(@sql);

				delete from @tbllog
				where FileNameLog=@FileNameLog
				and DBName=@DBName;
			end
		end
		
		delete from @tbl
		where [DBName]=@DBName;
	end
END
GO
/****** Object:  StoredProcedure [srv].[RunFullRestoreDB]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[RunFullRestoreDB]
AS
BEGIN
	/*
		�������������� �� ������ ��������� ����� �� � ����������� ��������� �� ����������� ����� ��
	*/
	SET NOCOUNT ON;

    declare @dt datetime=DateAdd(day,-2,getdate());
	declare @year int=YEAR(@dt);
	declare @month int=MONTH(@dt);
	declare @day int=DAY(@dt);
	declare @hour int=DatePart(hour, @dt);
	declare @minute int=DatePart(minute, @dt);
	declare @second int=DatePart(second, @dt);
	declare @pathBackup nvarchar(255);
	declare @pathstr nvarchar(255);
	declare @DBName nvarchar(255);
	declare @backupName nvarchar(255);
	declare @sql nvarchar(max);
	declare @backupSetId as int;
	declare @FileNameLog nvarchar(255);
	declare @SourcePathRestore nvarchar(255);
	declare @TargetPathRestore nvarchar(255);
	declare @Ext nvarchar(255);
	
	declare @tbl table (
		[DBName] [nvarchar](255) NOT NULL,
		[FullPathRestore] [nvarchar](255) NOT NULL
	);

	declare @tbl_files table (
		[DBName] [nvarchar](255) NOT NULL,
		[SourcePathRestore] [nvarchar](255) NOT NULL,
		[TargetPathRestore] [nvarchar](255) NOT NULL,
		[Ext] [nvarchar](255) NOT NULL
	);
	
	insert into @tbl (
	           [DBName]
	           ,[FullPathRestore]
	)
	select		[DBName]
	           ,[FullPathRestore]
	from [srv].[RestoreSettings];

	insert into @tbl_files (
	           [DBName]
	           ,[SourcePathRestore]
			   ,[TargetPathRestore]
			   ,[Ext]
	)
	select		[DBName]
	           ,[SourcePathRestore]
			   ,[TargetPathRestore]
			   ,[Ext]
	from [srv].[RestoreSettingsDetail];
	
	while(exists(select top(1) 1 from @tbl))
	begin
		set @backupSetId=NULL;

		select top(1)
		@DBName=[DBName],
		@pathBackup=[FullPathRestore]
		from @tbl;
	
		set @backupName=@DBName+N'_Full_backup_'+cast(@year as nvarchar(255))+N'_'+cast(@month as nvarchar(255))+N'_'+cast(@day as nvarchar(255))--+N'_'
						--+cast(@hour as nvarchar(255))+N'_'+cast(@minute as nvarchar(255))+N'_'+cast(@second as nvarchar(255));
		set @pathstr=@pathBackup+@backupName+N'.bak';

		set @sql=N'RESTORE DATABASE ['+@DBName+N'_Restore] FROM DISK = N'+N''''+@pathstr+N''''+
				 N' WITH FILE = 1,';

		while(exists(select top(1) 1 from @tbl_files where [DBName]=@DBName))
		begin
			select top(1)
			@SourcePathRestore=[SourcePathRestore],
			@TargetPathRestore=[TargetPathRestore],
			@Ext=[Ext]
			from @tbl_files
			where [DBName]=@DBName;

			set @sql=@sql+N' MOVE N'+N''''+@SourcePathRestore+N''''+N' TO N'+N''''+@TargetPathRestore+N'_Restore.'+@Ext+N''''+N',';

			delete from @tbl_files
			where [DBName]=@DBName
			and [SourcePathRestore]=@SourcePathRestore
			and [Ext]=@Ext;
		end

		set @sql=@sql+N' NOUNLOAD,  REPLACE,  STATS = 5';

		exec(@sql);

		set @sql=N'DBCC CHECKDB(N'+N''''+@DBName+'_Restore'+N''''+N')  WITH NO_INFOMSGS';
	
		exec(@sql);
		
		delete from @tbl
		where [DBName]=@DBName;
	end
END

GO
/****** Object:  StoredProcedure [srv].[RunLogBackupDB]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[RunLogBackupDB] 
AS
BEGIN
	/*
		�������� ��������� ����� ������� ���������� ��
	*/
	SET NOCOUNT ON;

    declare @dt datetime=getdate();
	declare @year int=YEAR(@dt);
	declare @month int=MONTH(@dt);
	declare @day int=DAY(@dt);
	declare @hour int=DatePart(hour, @dt);
	declare @minute int=DatePart(minute, @dt);
	declare @second int=DatePart(second, @dt);
	declare @pathBackup nvarchar(255);
	declare @pathstr nvarchar(255);
	declare @DBName nvarchar(255);
	declare @backupName nvarchar(255);
	declare @sql nvarchar(max);
	declare @backupSetId as int;
	
	declare @tbl table (
		[DBName] [nvarchar](255) NOT NULL,
		[LogPathBackup] [nvarchar](255) NOT NULL
	);
	
	insert into @tbl (
	           [DBName]
	           ,[LogPathBackup]
	)
	select		DB_NAME(b.[DBID])
	           ,b.[LogPathBackup]
	from [srv].[BackupSettings] as b
	inner join sys.databases as d on b.[DBID]=d.[database_id]
	where d.recovery_model<3
	and DB_NAME([DBID]) not in (
		N'master',
		N'tempdb',
		N'model',
		N'msdb',
		N'ReportServer',
		N'ReportServerTempDB'
	)
	and [LogPathBackup] is not null;
	
	while(exists(select top(1) 1 from @tbl))
	begin
		set @backupSetId=NULL;

		select top(1)
		@DBName=[DBName],
		@pathBackup=[LogPathBackup]
		from @tbl;
	
		set @backupName=@DBName+N'_Log_backup_'+cast(@year as nvarchar(255))+N'_'+cast(@month as nvarchar(255))+N'_'+cast(@day as nvarchar(255))+N'_'
						+cast(@hour as nvarchar(255))+N'_'+cast(@minute as nvarchar(255))+N'_'+cast(@second as nvarchar(255));
		set @pathstr=@pathBackup+@backupName+N'.trn';
	
		set @sql=N'BACKUP LOG ['+@DBName+N'] TO DISK = N'+N''''+@pathstr+N''''+
				 N' WITH NOFORMAT, NOINIT, NAME = N'+N''''+@backupName+N''''+
				 N', CHECKSUM, STOP_ON_ERROR, SKIP, REWIND, COMPRESSION, STATS = 10;';
	
		exec(@sql);

		select @backupSetId = position
		from msdb..backupset where database_name=@DBName
		and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@DBName);

		set @sql=N'������ �����������. �������� � ��������� ����������� ��� ���� ������ "'+@DBName+'" �� �������.';

		if @backupSetId is null begin raiserror(@sql, 16, 1) end
		else
		begin
			set @sql=N'RESTORE VERIFYONLY FROM DISK = N'+''''+@pathstr+N''''+N' WITH FILE = '+cast(@backupSetId as nvarchar(255));

			exec(@sql);
		end
		
		delete from @tbl
		where [DBName]=@DBName;
	end
END
GO
/****** Object:  StoredProcedure [srv].[RunLogShippingFailover]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [srv].[RunLogShippingFailover]
	@isfailover			bit=1,
	@login				nvarchar(255)=N'�����\�����',
	@backup_directory	nvarchar(255)=N'D:\Shared'
AS
	/*
		��������� ��������� ������ � �������� ����� ��� ������ ������� ������� ��� @isfailover=1 ��������� ����������������
		��� @isfailover=0 ������ �� ���������-����� ����� ������� ������ ������ �������� �������� � ���������� �� ��������
			, � ����� ������� ������� �� �������� ������ � ����� ��� ��� ����� ��������� �������� �������� ���������� ������.
		���������, ��� ������ ��������� ������ ��������� ������ �� ������ ������� ��������� ����� �������� ����������
	*/
BEGIN
	--���� ����������� ������� �� ��������� ������, �� ��������� ��� ������� �� ����������� ��������� ������ � ���������
	if(@isfailover=1)
	begin
		select [job_id]
		into #jobs
		from [msdb].[dbo].[sysjobs]
		where [name] like 'LSCopy%';
	
		declare @job_id uniqueidentifier;
	
		while(exists(select top(1) 1 from #jobs))
		begin
			select top(1)
			@job_id=[job_id]
			from #jobs;
	
			begin try
				EXEC [msdb].dbo.sp_start_job @job_id=@job_id;
			end try
			begin catch
			end catch
	
			delete from #jobs
			where [job_id]=@job_id;
		end
		
		drop table #jobs;
	end
	
	--��������� ��� ������� �� ����������� ������ � ��������� ��� �������� �� ��������� ������
	--�������� ��� ������� �� ����������� ������ � ��������� ��� �������� �� ������ ������
	update [msdb].[dbo].[sysjobs]
	set [enabled]=case when (@isfailover=1) then 0 else 1 end
	where [name] like 'LSCopy%';
	
	--���� ����������� ������� �� ��������� ������, �� ��������� ��� ������� �� �������������� �� �� ��������� ������ � ���������
	if(@isfailover=1)
	begin
		select [job_id]
		into #jobs2
		from [msdb].[dbo].[sysjobs]
		where [name] like 'LSRestore%';
	
		while(exists(select top(1) 1 from #jobs2))
		begin
			select top(1)
			@job_id=[job_id]
			from #jobs2;
	
			begin try
				EXEC [msdb].dbo.sp_start_job @job_id=@job_id;
				EXEC [msdb].dbo.sp_start_job @job_id=@job_id;
			end try
			begin catch
			end catch
	
			delete from #jobs2
			where [job_id]=@job_id;
		end
		drop table #jobs2;
	end
	
	--��������� ��� ������� �� �������������� �� �� ��������� ������ � ��������� ��� �������� �� ��������� ������
	--�������� ��� ������� �� �������������� �� �� ��������� ������ � ��������� ��� �������� �� ������ ������
	update [msdb].[dbo].[sysjobs]
	set [enabled]=case when (@isfailover=1) then 0 else 1 end
	where [name] like 'LSRestore%';
	
	--��� �������� �� ��������� ������, ������ �� ���������������� � ��������� �� ��������� �������, �� ��� ����������
	if(@isfailover=1)
	begin
		select [secondary_database] as [name]
		into #dbs
		from msdb.dbo.log_shipping_monitor_secondary
		where [secondary_server]=@@SERVERNAME;
	
		declare @db nvarchar(255);
	
		while(exists(select top(1) 1 from #dbs))
		begin
			select top(1)
			@db=[name]
			from #dbs;
	
			begin try
				RESTORE DATABASE @db WITH RECOVERY;
			end try
			begin catch
			end catch
	
			delete from #dbs
			where [name]=@db;
		end
	
		drop table #dbs;
	
		select [secondary_database] as [name]
		into #dbs2
		from msdb.dbo.log_shipping_monitor_secondary
		where [secondary_server]=@@SERVERNAME;
	
		declare @jobId BINARY(16);
		declare @command nvarchar(max);
	
		declare @dt nvarchar(255)=cast(YEAR(GetDate()) as nvarchar(255))
							  +'_'+cast(MONTH(GetDate()) as nvarchar(255))
							  +'_'+cast(DAY(GetDate()) as nvarchar(255))
							  +'_'+cast(DatePart(hour,GetDate()) as nvarchar(255))
							  +'_'+cast(DatePart(minute,GetDate()) as nvarchar(255))
							  +'.trn';
	
		declare @backup_job_name		nvarchar(255);
		declare @schedule_name			nvarchar(255);
		declare @disk					nvarchar(255);
		declare @uid					uniqueidentifier;
	
		while(exists(select top(1) 1 from #dbs2))
		begin
			select top(1)
			@db=[name]
			from #dbs2;
	
			set @disk=@backup_directory+N'\'+@db+N'.bak';
			set @backup_job_name=N'LSBackup_'+@db;
			set @schedule_name=N'LSBackupSchedule_'+@@SERVERNAME+N'_'+@db;
			set @command=N'declare @disk nvarchar(max)='+N''''+@backup_directory+N'\'+@db+'_'+@dt+N''''
						+N'BACKUP LOG ['+@db+'] TO DISK = @disk
							WITH NOFORMAT, NOINIT,  NAME = '+N''''+@db+N''''+N', SKIP, NOREWIND, NOUNLOAD,  STATS = 10;';
			set @uid=newid();
			
			begin try
				BACKUP DATABASE @db TO  DISK = @disk 
				WITH NOFORMAT, NOINIT,  NAME = @db, SKIP, NOREWIND, NOUNLOAD,  STATS = 10;
				
				EXEC msdb.dbo.sp_add_job @job_name=@backup_job_name, 
				@enabled=1, 
				@notify_level_eventlog=0, 
				@notify_level_email=0, 
				@notify_level_netsend=0, 
				@notify_level_page=0, 
				@delete_level=0, 
				@description=N'No description available.', 
				@category_name=N'[Uncategorized (Local)]', 
				@owner_login_name=@login, @job_id = @jobId OUTPUT;
		
				EXEC msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@backup_job_name, 
				@step_id=1, 
				@cmdexec_success_code=0, 
				@on_success_action=1, 
				@on_success_step_id=0, 
				@on_fail_action=2, 
				@on_fail_step_id=0, 
				@retry_attempts=0, 
				@retry_interval=0, 
				@os_run_priority=0, @subsystem=N'TSQL', 
				@command=@command, 
				@database_name=N'master', 
				@flags=0;
	
				EXEC msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1;
	
				EXEC msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=@backup_job_name, 
				@enabled=1, 
				@freq_type=4, 
				@freq_interval=1, 
				@freq_subday_type=4, 
				@freq_subday_interval=5, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=0, 
				@active_start_date=20171009, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959, 
				@schedule_uid=@uid;
	
				EXEC msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
			end try
			begin catch
			end catch
	
			delete from #dbs2
			where [name]=@db;
		end
	
		drop table #dbs2;
	end
END
GO
/****** Object:  StoredProcedure [srv].[RunRequestGroupStatistics]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [srv].[RunRequestGroupStatistics]
as
begin
	--���� ���������� �� ��������
	truncate table [srv].[QueryRequestGroupStatistics];
	
	;with tbl as (
		select count(*) as [Count]
		  ,min([cpu_timeSec]) as [mincpu_timeSec]
		  ,max([cpu_timeSec]) as [maxcpu_timeSec]
		  ,min([wait_timeSec]) as [minwait_timeSec]
		  ,max([wait_timeSec]) as [maxwait_timeSec]
		  ,max([row_count]) as [row_count]
		  ,count([row_count]) as [SumCountRows]
		  ,min([reads]) as [min_reads]
		  ,max([reads]) as [max_reads]
		  ,min([writes]) as [min_writes]
		  ,max([writes]) as [max_writes]
		  ,min([logical_reads]) as [min_logical_reads]
		  ,max([logical_reads]) as [max_logical_reads]
		  ,min([open_transaction_count]) as [min_open_transaction_count]
		  ,max([open_transaction_count]) as [max_open_transaction_count]
		  ,min([transaction_isolation_level]) as [min_transaction_isolation_level]
		  ,max([transaction_isolation_level]) as [max_transaction_isolation_level]
		  ,min(total_elapsed_timeSec) as [mintotal_elapsed_timeSec]
		  ,max(total_elapsed_timeSec) as [maxtotal_elapsed_timeSec]
		  ,[sql_handle]
		from [srv].[vRequestStatistics] as tt with(readuncommitted)
		where [TSQL] is not null
		group by [sql_handle]
	)
	insert into [srv].[QueryRequestGroupStatistics](
					[TSQL],
					[Count],
					[mincpu_timeSec],
					[maxcpu_timeSec],
					[minwait_timeSec],
					[maxwait_timeSec],
					[row_count],
					[SumCountRows],
					[min_reads],
					[max_reads],
					[min_writes],
					[max_writes],
					[min_logical_reads],
					[max_logical_reads],
					[min_open_transaction_count],
					[max_open_transaction_count],
					[min_transaction_isolation_level],
					[max_transaction_isolation_level],
					[mintotal_elapsed_timeSec],
					[maxtotal_elapsed_timeSec],
					[DBName],
					[Unique_nt_user_name],
					[Unique_nt_domain],
					[Unique_login_name],
					[Unique_program_name],
					[Unique_host_name],
					[Unique_client_tcp_port],
					[Unique_client_net_address],
					[Unique_client_interface_name],
					[sql_handle]
				)
	select			(select top(1) [TSQL] from srv.SQLQuery as t where t.[SQLHandle]=tbl.[sql_handle]) as [TSQL],
					sum([Count]) as [Count],
					min([mincpu_timeSec]) as [mincpu_timeSec],
				    max([maxcpu_timeSec]) as [maxcpu_timeSec],
				    min([minwait_timeSec]) as [minwait_timeSec],
				    max([maxwait_timeSec]) as [maxwait_timeSec],
				    max([row_count]) as [row_count],
				    sum([SumCountRows]) as [SumCountRows],
				    min([min_reads]) as [min_reads],
				    max([max_reads]) as [max_reads],
				    min([min_writes]) as [min_writes],
				    max([max_writes]) as [max_writes],
				    min([min_logical_reads]) as [min_logical_reads],
				    max([max_logical_reads]) as [max_logical_reads],
				    min([min_open_transaction_count]) as [min_open_transaction_count],
				    max([max_open_transaction_count]) as [max_open_transaction_count],
				    min([min_transaction_isolation_level]) as [min_transaction_isolation_level],
				    max([max_transaction_isolation_level]) as [max_transaction_isolation_level],
				    min([mintotal_elapsed_timeSec]) as [mintotal_elapsed_timeSec],
				    max([maxtotal_elapsed_timeSec]) as [maxtotal_elapsed_timeSec],
					N'' as [DBName],
					N'' as [Unique_nt_user_name],
					N'' as [Unique_nt_domain],
					N'' as [Unique_login_name],
					N'' as [Unique_program_name],
					N'' as [Unique_host_name],
					N'' as [Unique_client_tcp_port],
					N'' as [Unique_client_net_address],
					N'' as [Unique_client_interface_name],
					[sql_handle]
	from tbl
	group by [sql_handle];

	declare @str nvarchar(max);
	declare @sql_handle varbinary(64);
	declare @tbl_temp table([sql_handle] varbinary(64));
	declare @tbl table ([sql_handle] varbinary(64), [TValue] nvarchar(max));

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[DBName]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [DBName]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [DBName]
		) as t
		group by [DBName];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[DBName]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[nt_user_name]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [nt_user_name]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [nt_user_name]
		) as t
		group by [nt_user_name];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_nt_user_name]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[nt_domain]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [nt_domain]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [nt_domain]
		) as t
		group by [nt_domain];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_nt_domain]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[login_name]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [login_name]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [login_name]
		) as t
		group by [login_name];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_login_name]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[program_name]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [program_name]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [program_name]
		) as t
		group by [program_name];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_program_name]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[host_name]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [host_name]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [host_name]
		) as t
		group by [host_name];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_host_name]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+cast([client_tcp_port] as nvarchar(255))+N':'+cast(count(*) as nvarchar(255))
		from (
			select [client_tcp_port]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [client_tcp_port]
		) as t
		group by [client_tcp_port];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_client_tcp_port]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[client_net_address]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [client_net_address]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [client_net_address]
		) as t
		group by [client_net_address];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_client_net_address]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];

	insert into @tbl_temp([sql_handle])
	select [sql_handle]
	from [srv].[QueryRequestGroupStatistics]
	group by [sql_handle];

	delete from @tbl;

	while(exists(select top(1) 1 from @tbl_temp))
	begin
		set @str=N'';

		select top(1)
		@sql_handle=[sql_handle]
		from @tbl_temp;

		select @str=@str+N', '+[client_interface_name]+N':'+cast(count(*) as nvarchar(255))
		from (
			select [client_interface_name]
			from [srv].[vRequestStatistics] with(readuncommitted)
			where [sql_handle]=@sql_handle
			group by [client_interface_name]
		) as t
		group by [client_interface_name];

		insert into @tbl ([sql_handle], [TValue])
		select @sql_handle, @str;

		delete from @tbl_temp
		where [sql_handle]=@sql_handle;
	end

	update t
	set t.[Unique_client_interface_name]=substring(tt.[TValue],3,len(tt.[TValue]))
	from [srv].[QueryRequestGroupStatistics] as t
	inner join @tbl as tt on t.[sql_handle]=tt.[sql_handle];
end
GO
/****** Object:  StoredProcedure [srv].[SelectErrorInfoArchive]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[SelectErrorInfoArchive]
@StartDate datetime=NULL,
@FinishDate datetime=NULL,
@IsRealTime bit=NULL
/*
	��������� ������� ������ �� ������������ �������� ����������
*/
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	set @StartDate =DATETIMEFROMPARTS(YEAR(@StartDate), MONTH(@StartDate), DAY(@StartDate), 0, 0, 0, 0);
	set @FinishDate=DATETIMEFROMPARTS(YEAR(@FinishDate), MONTH(@FinishDate), DAY(@FinishDate), 23, 59, 59, 999);

	SELECT [ErrorInfo_GUID]
      ,[ERROR_TITLE]
      ,[ERROR_PRED_MESSAGE]
      ,[ERROR_NUMBER]
      ,[ERROR_MESSAGE]
      ,[ERROR_LINE]
      ,[ERROR_PROCEDURE]
      ,[ERROR_POST_MESSAGE]
      ,[RECIPIENTS]
      ,[InsertDate]
      ,[StartDate]
      ,[FinishDate]
      ,[Count]
      ,[UpdateDate]
      ,[IsRealTime]
      ,[InsertUTCDate]
  FROM [srv].[ErrorInfoArchive]
  where (InsertDate>=@StartDate or @StartDate is null)
  and (InsertDate<=@FinishDate or @FinishDate is null)
  and (IsRealTime=@IsRealTime or @IsRealTime is null);
END


GO
/****** Object:  StoredProcedure [srv].[SendDBMail]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [srv].[SendDBMail]
	@recipients nvarchar(max),
	@srr_title nvarchar(255),
	@srr_mess nvarchar(255),
	@isHTML bit=0
AS
BEGIN
	/*
		�������� ��������� �� �����
	*/
	SET NOCOUNT ON;
	declare @dt datetime=getdate();

	declare @recipient nvarchar(255);
	declare @result nvarchar(max)='';
	declare @recp nvarchar(max);
	declare @ind int;
	declare @recipients_key nvarchar(max);

	 declare @rec_body table(Body nvarchar(max));
	 declare @body nvarchar(max);

	 declare @query nvarchar(max);

	set @recipients_key=@recipients;
	set @result='';

	while(len(@recipients)>0)
	begin
		set @ind=CHARINDEX(';', @recipients);
		if(@ind>0)
		begin
			set @recipient=substring(@recipients,1, @ind-1);
			set @recipients=substring(@recipients,@ind+1,len(@recipients)-@ind);
		end
		else
		begin
			set @recipient=@recipients;
			set @recipients='';
		end;

		exec [srv].[GetRecipients]
		@Recipient_Code=@recipient,
		@Recipients=@recp out;

		if(len(@recp)=0)
		begin
			exec [srv].[GetRecipients]
			@Recipient_Name=@recipient,
			@Recipients=@recp out;

			if(len(@recp)=0) set @recp=@recipient;
		end

		set @result=@result+@recp+';';
	end

	set @result=substring(@result,1,len(@result)-1);
	set @recipients=@result;

	declare @body_format nvarchar(32)=case when @isHTML=1 then 'HTML' else 'TEXT' end;

	 EXEC msdb.dbo.sp_send_dbmail
	-- ��������� ���� ������� �������������� �������� ��������
		@profile_name = 'profile_name',
	-- ����� ����������
		@recipients = @recipients,--'Gribkov@ggg.ru',
	-- ����� ������
		@body = @srr_mess,
	-- ����
		@subject = @srr_title,
		@body_format=@body_format--,
	-- ��� ������� ������� � ������ ���������� ������������� SQL-�������
		--@query = @query--'SELECT TOP 10 name FROM sys.objects';
END

GO
/****** Object:  StoredProcedure [srv].[sp_DriveSpace]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [srv].[sp_DriveSpace] 
    @DrivePath varchar(1024) --���������� (����� �������� ����� ���� 'C:')
  , @TotalSpace float output --����� ������� � ������
  , @FreeSpace float output	 --���������� ������������ � ������
as
begin
	/*
		������� ���������� �� ����������
		http://www.t-sql.ru/post/disk_size.aspx
	*/
  DECLARE @fso int
        , @Drive int
        , @DriveName varchar(255)
        , @Folder int
        , @Drives int
        , @source varchar(255)
        , @desc varchar(255)
        , @ret int
        , @Object int
  -- ������� ����� �������� �������
  exec @ret = sp_OACreate 'Scripting.FileSystemObject', @fso output
  set @Object = @fso
  if @ret != 0
    goto ErrorInfo
 
  -- �������� ����� �� ��������� ����
  exec @ret = sp_OAmethod @fso, 'GetFolder', @Folder output, @DrivePath  
  set @Object = @fso
  if @ret != 0
    goto ErrorInfo
 
  -- �������� ����������
  exec @ret = sp_OAmethod @Folder, 'Drive', @Drive output
  set @Object = @Folder
  if @ret != 0
    goto ErrorInfo
 
  -- ���������� ������ ������ ����������
  exec @ret = sp_OAGetProperty @Drive, 'TotalSize', @TotalSpace output
  set @Object = @Drive
  if @ret != 0
    goto ErrorInfo
 
  -- ���������� ��������� ����� �� ����������
  exec @ret = sp_OAGetProperty @Drive, 'AvailableSpace', @FreeSpace output
  set @Object = @Drive
  if @ret != 0
    goto ErrorInfo
 
  DestroyObjects:
    if @Folder is not null
      exec sp_OADestroy @Folder
    if @Drive is not null
      exec sp_OADestroy @Drive
    if @fso is not null
      exec sp_OADestroy @fso
 
    return (@ret)
 
  ErrorInfo:
    exec sp_OAGetErrorInfo @Object, @source output, @desc output
    print 'Source error: ' + isnull( @source, 'n/a' ) + char(13) + 'Description: ' + isnull( @desc, 'n/a' )
    goto DestroyObjects;
end
GO
/****** Object:  StoredProcedure [srv].[usp_Find_Problems]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [srv].[usp_Find_Problems] ( @count_locks BIT = 1 )
AS 
    SET NOCOUNT ON
-- ������� ����������
    IF @count_locks = 0 
        GOTO Get_Blocks
    ELSE 
        IF @count_locks = 1 
            BEGIN
 
                    CREATE TABLE #Hold_sp_lock
                        (
                          spid INT,
                          dbid INT,
                          ObjId INT,
                          IndId SMALLINT,
                          Type VARCHAR(20),
                          Resource VARCHAR(50),
                          Mode VARCHAR(20),
                          Status VARCHAR(20)
                        )
                INSERT  INTO #Hold_sp_lock
                        EXEC sp_lock
                SELECT  COUNT(spid) AS lock_count,
                        SPID,
                        Type,
                        CAST(DB_NAME(DBID) AS VARCHAR(30)) AS DBName,
                        mode
                FROM    #Hold_sp_lock
                GROUP BY SPID,
                        Type,
                        CAST(DB_NAME(DBID) AS VARCHAR(30)),
                        MODE
                ORDER BY lock_count DESC,
                        DBName,
                        SPID,
                        MODE
 
-- ����� ��������������� ��� ����������� ���������
-- Show any blocked or blocking processes
 
                Get_Blocks:
 
 
                    CREATE TABLE #Catch_SPID
                        (
                          bSPID INT,
                          BLK_Status CHAR(10)
                        )
 
                INSERT  INTO #Catch_SPID
                        SELECT DISTINCT
                                SPID,
                                'BLOCKED'
                        FROM    master..sysprocesses
                        WHERE   blocked <> 0
                        UNION
                        SELECT DISTINCT
                                blocked,
                                'BLOCKING'
                        FROM    master..sysprocesses
                        WHERE   blocked <> 0
 
                DECLARE @tSPID INT 
                DECLARE @blkst CHAR(10)
                SELECT TOP 1
                        @tSPID = bSPID,
                        @blkst = BLK_Status
                FROM    #Catch_SPID
                
 
 
                WHILE( @@ROWCOUNT > 0 )
                    BEGIN
 
                        PRINT 'DBCC Results for SPID '
                            + CAST(@tSPID AS VARCHAR(5)) + '( ' + RTRIM(@blkst)
                            + ' )'
                        PRINT '-----------------------------------'
                        PRINT ''
                        DBCC INPUTBUFFER(@tSPID)
 
 
                        SELECT TOP 1
                                @tSPID = bSPID,
                                @blkst = BLK_Status
                        FROM    #Catch_SPID
                        WHERE   bSPID > @tSPID
                        ORDER BY bSPID
 
                    END
 
            END
GO
/****** Object:  StoredProcedure [srv].[XPDeleteFile]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[XPDeleteFile]
	@FileType int=0 --0-backup/1-report
	,@FolderPath nvarchar(255)--������ ���� ������ �������
	,@FileExtension nvarchar(255)=N'*'--���������� �����
	,@OldDays int --�������� � ���� �� ������� ����
	,@SubFolder int=0 --0-������������� ��������� �����/1-��������� �����
AS
BEGIN
	/*
		�������� ������
	*/
	SET NOCOUNT ON;

	declare @dt datetime=DateAdd(day, -@OldDays, GetDate());
	set @dt=DATETIMEFROMPARTS(year(@dt), month(@dt), day(@dt), 0, 0, 0, 0);

    EXECUTE master.dbo.xp_delete_file @FileType,
									  @FolderPath,
									  @FileExtension,
									  @dt,
									  @SubFolder;
END

GO
/****** Object:  DdlTrigger [SchemaLog]    Script Date: 07.03.2018 11:22:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE TRIGGER [SchemaLog] 
ON DATABASE --ALL SERVER 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	DECLARE @data XML
	begin try
	if(CURRENT_USER<>'NT AUTHORITY\NETWORK SERVICE' and SYSTEM_USER<>'NT AUTHORITY\NETWORK SERVICE')
	begin
		SET @data = EVENTDATA();
		INSERT srv.ddl_log(
					PostTime,
					DB_Login,
					DB_User,
					Event,
					TSQL
				  ) 
		select 
					GETUTCDATE(),
					CONVERT(nvarchar(255), SYSTEM_USER),
					CONVERT(nvarchar(255), CURRENT_USER), 
					@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(255)'), 
					@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')
		where		@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(255)') not in('UPDATE_STATISTICS', 'ALTER_INDEX')
				and	@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)') not like '%Msmerge%';
	end
	end try
	begin catch
	end catch









GO
DISABLE TRIGGER [SchemaLog] ON DATABASE
GO
EXEC [SRV].sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ��� �����������������
������ ��� MS SQL Server 2016-2017 (����� ��������� ��� �������� �������������� MS SQL Server 2012-2014).
��������� ���� ������ �� ������ MS SQL Server 2012 ����� ���� �� �� ����������� ������ ��� ������������� � ���������������� �����.
����������� ������� ������� ��. � �� inf.InfoAgentJobs.' 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ������� ������� (����� ���������������� ��� �������� ��� ���������� �����)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'PROCEDURE',@level1name=N'InfoAgentJobs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� ������ ����� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'PROCEDURE',@level1name=N'RunAsyncExecute'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� (�������� ������, �������������� �� MS SQL Server 2012)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'PROCEDURE',@level1name=N'sp_WhoIsActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���-�� �������� � �������� ��������' , @level0type=N'SCHEMA',@level0name=N'nav', @level1type=N'PROCEDURE',@level1name=N'ZabbixGetCountRequestStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����������� �������� (������������� ����� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoDefragIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������� �������� ��� �������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoDefragIndexDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� �������� ���������� (�������, � ������� ��� �������� ��������) � ����������� �� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoKillSessionTranBegin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� ���������� � �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoKillSessionTranBegin', @level2type=N'PARAMETER',@level2name=N'@minuteOld'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ��������� � �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoKillSessionTranBegin', @level2type=N'PARAMETER',@level2name=N'@countIsNotRequests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��������� � ����������� �������� ��� ����������� �������� �� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoShortInfoRunJobs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������ �� �������� ������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoStatisticsActiveConnections'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ �� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoStatisticsActiveRequests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� ����� ������ ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoStatisticsFileDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � �������� �� ����������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoStatisticsQuerys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � �������� ���������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoStatisticsTimeRequests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������ ���������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoUpdateStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���� � ����������� ����������� ���������� �� ���� ����������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoUpdateStatisticsCache'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������ ���������� ���������� ��������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'AutoUpdateStatisticsDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ClearFullInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ����������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ConnectValid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������ �������� ������� �� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'DeleteArchive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������ � ����������� �� (����������� �������������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'DeleteArchiveInProductDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ������ � ������� ������ �� ����������� �� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ErrorInfoIncUpd'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� �������� ������������ MS SQL SERVER' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetActiveConnectionStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ���� ��������, ������� �������� �� ����� 20 �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetAllIndexFrag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetColumns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetDBFilesOperationsStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ������������ �������� �� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetDefaultsConstraints'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetDelIndexOptimize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� FK-������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetFK_Keys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetFuncs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ���� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetHeaps'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� Identity-��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetIdentityColumns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ������������� ������� ��� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetNewIndexOptimize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� �������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetProcedures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��������������� ��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetQueryRequestGroupStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��� �������� ������ ��� ����� �� ������ MS SQL SERVER' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetSqlLogins'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetSynonyms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��� ������ ��� ����� �� ������ MS SQL SERVER' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetSysLogins'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetTableStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetTriggers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� ��������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetViews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������� �� �������������� ������ MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'ExcelGetWaits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� � ���������� HTML-��� ��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'GetHTMLTable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� � ���������� HTML-��� ��� ������� ������������ ��������� (���������� ������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'GetHTMLTableShortInfoDrivers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� � ���������� HTML-��� ��� ������� ����������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'GetHTMLTableShortInfoRunJobs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����������� �������� ������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'GetRecipients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���-�� ����� � ������ ������� �� ���������� �������� (��������� ���-��)+������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'InsertTableStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� ��� ��������� �� � ��������� ������ �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'KillConnect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �� �����������, ��������� ���������� ������� ���� ����� ����� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'KillFullOldConnect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������� �� ������ ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'MergeDBFileInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������� �� �����������-������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'MergeDriverInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� ��������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunDiffBackupDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �������� ����������� �� ������� � ��������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunErrorInfoProc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������ ��������� ����� �� � ��������������� ��������� �� ����������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunFullBackupDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� �� ������ ��������� ����� �� � ����������� ��������� �� ����������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunFullRestoreDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� ����� ������� ���������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunLogBackupDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������ ��� �������� �������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunLogShippingFailover'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'RunRequestGroupStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������� ������ �� ������������ �������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'SelectErrorInfoArchive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� �� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'SendDBMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� �� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'sp_DriveSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ��������������� ��� ����������� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'usp_Find_Problems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'PROCEDURE',@level1name=N'XPDeleteFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetPlansObject', @level2type=N'PARAMETER',@level2name=N'@ObjectID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetPlansObject', @level2type=N'PARAMETER',@level2name=N'@DBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��� ����� ��������� �������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'GetPlansObject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetDateFormat', @level2type=N'PARAMETER',@level2name=N'@dt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������:
0: "dd.mm.yyyy"
1: "mm.yyyy"
2: "yyyy"' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetDateFormat', @level2type=N'PARAMETER',@level2name=N'@format'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���� � ���� ������ �� ��������� ������� � ������� ����' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetDateFormat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������ � ����' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetNameMonth', @level2type=N'PARAMETER',@level2name=N'@Month_Num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ������� �������� ������ �� ��������� ��� ������' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetNameMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetNumMonth', @level2type=N'PARAMETER',@level2name=N'@Month_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����� ������ �� ��� ��������� �������� ��-������' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetNumMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetTimeFormat', @level2type=N'PARAMETER',@level2name=N'@dt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������:
0: "hh:mm:ss"
1: "hh:mm"
2: "hh"' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetTimeFormat', @level2type=N'PARAMETER',@level2name=N'@format'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����� � ���� ������ �� ��������� ������� � �������� �������' , @level0type=N'SCHEMA',@level0name=N'rep', @level1type=N'FUNCTION',@level1name=N'GetTimeFormat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� � ���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'FUNCTION',@level1name=N'GetNumericNormalize', @level2type=N'PARAMETER',@level2name=N'@str'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'� �������� ����� � ���� ������ �������� ������ ���� ����� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'FUNCTION',@level1name=N'GetNumericNormalize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������� �� (DDL)' , @level0type=N'TRIGGER',@level0name=N'SchemaLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� dll ������������ �� ��������� ���������' , @level0type=N'SCHEMA',@level0name=N'dll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� inf ���������� �� ���������� �������� � ������ ���������� ����� �������� � ����� ������ ������� (� � �������� �������� ��� ������������� ������� � ���� �����)' , @level0type=N'SCHEMA',@level0name=N'inf'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������������� �����' , @level0type=N'SCHEMA',@level0name=N'nav'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� rep �������� ���������� ��� �������' , @level0type=N'SCHEMA',@level0name=N'rep'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� srv ������ ���������� �� ��������� ������� ������ (� � �������� �������� ��� ������������� ������� �� ���������)' , @level0type=N'SCHEMA',@level0name=N'srv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AuditQuery', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AuditQuery', @level2type=N'COLUMN',@level2name=N'TSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AuditQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST', @level2type=N'COLUMN',@level2name=N'TEST_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (���������)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST', @level2type=N'COLUMN',@level2name=N'IDENT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����/���������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST', @level2type=N'COLUMN',@level2name=N'Field_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ����/���������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST', @level2type=N'COLUMN',@level2name=N'Field_Value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��� ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'Row_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'SessionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'LoginName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'ProgramName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������
sys.dm_exec_sessions ' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'LoginTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������������������� ��������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'EndRegUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ActiveConnectionStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'Address_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���������� (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'Recipient_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'COLUMN',@level2name=N'DBID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ����� ��� ������ ��������� ����� (���� ������, �� ��������� � ������ ��������� �����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'COLUMN',@level2name=N'FullPathBackup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ����� ��� ����������� ��������� ����� (���� ������, �� ��������� � ���������� ��������� �����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'COLUMN',@level2name=N'DiffPathBackup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ����� ��� ��������� ����� �������� ���������� (���� ������, �� ��������� � �������� ��������� ����� �������� ���������� ��� �������, ��� ������ �������������� � �� �� �������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'COLUMN',@level2name=N'LogPathBackup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'BackupSettings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����� �� (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'DBFile_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Server'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����, �� ������� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Drive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Physical_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Ext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'Growth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����, ��� ������� � ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'IsPercentGrowth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'DB_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'DB_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'SizeMb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'DiffSizeMb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ��������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'UpdateUTCdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'COLUMN',@level2name=N'File_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ������ (������������ ����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile', @level2type=N'INDEX',@level2name=N'IX_DBFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ������ ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DBFile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'DDL_Log_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'PostTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'DB_Login'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'DB_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'Event'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log', @level2type=N'COLUMN',@level2name=N'TSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �� (DDL)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'DDL_Log_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'Server_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'DB_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'PostTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'DB_Login'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'DB_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'Event'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'TSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �� ���� �� (DDL)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ddl_log_all'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks', @level2type=N'COLUMN',@level2name=N'Server'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ����������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks', @level2type=N'COLUMN',@level2name=N'NumberDeadlocks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks', @level2type=N'COLUMN',@level2name=N'InsertDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks', @level2type=N'INDEX',@level2name=N'indInsertDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Deadlocks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'db'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'shema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'table'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'IndexName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� �� �������� ������ ������� ������������� IN_ROW_DATA
NULL ��� ���������� ������� ������� � ������ ������������� LOB_DATA ��� ROW_OVERFLOW_DATA.

�������� NULL ��� ���, ���� ������ ����� = SAMPLED
sys.dm_db_index_physical_stats' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'frag_num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ � %' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'frag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� �������, ���������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'rec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ������ �������� �������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'ts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ��������� �������� �������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'tf'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ � % ����� �������� ��������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'frag_after'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'object_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ������ (������������, ������������ ������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag', @level2type=N'INDEX',@level2name=N'IndMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��� ������������� �������� ���� �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Defrag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����, ��� ������� ������������� �������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DefragRun', @level2type=N'COLUMN',@level2name=N'Run'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ��������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DefragRun', @level2type=N'COLUMN',@level2name=N'UpdateUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'DefragRun'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'Driver_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'Server'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ����� ����������� ����� � ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'TotalSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ��������� ����� ����������� ����� � ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'FreeSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� ������ ����������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'DiffFreeSpace'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ��������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'COLUMN',@level2name=N'UpdateUTCdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ���������� ������ (�������� �� ���������, �� ����������, � � �� ������������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Drivers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ErrorInfo_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_PRED_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������/�����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_NUMBER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������ ������/�����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_LINE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_PROCEDURE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'ERROR_POST_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ;' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'RECIPIENTS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'InsertDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'FinishDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����, ��� ����������� ��������� ������� (� � ����� ���������� ��� ����� �������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'IsRealTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ��� �������� �� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ErrorInfo_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_PRED_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������/�����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_NUMBER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������ ������/�����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_LINE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_PROCEDURE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'ERROR_POST_MESSAGE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ;' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'RECIPIENTS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'InsertDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'FinishDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'Count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'UpdateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����, ��� ����������� ��������� ������� (� � ����� ���������� ��� ����� �������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'IsRealTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������� �� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ErrorInfoArchive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� �� ������� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'execution_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ��������� ���-�� ������� � ���, ����������� �� ��������� �� ������� �������� �������� �� ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'max_total_elapsed_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ��������� ���-�� ������� � ���, ����������� �� ��������� �� ������� �������� �������� �� ���� DATE' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'max_total_elapsed_timeLastSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� �� ���������� ���������� MS SQL SERVER' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'execution_countStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �� ������� ������ ���������� � ���, ����������� �� ��������� �� ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'max_AvgDur_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �� ������� ������ ���������� � ���, ����������� �� ��������� �� ���� DATE' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'max_AvgDur_timeLastSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����, �� ����� ���� �������� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics', @level2type=N'COLUMN',@level2name=N'DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������������������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'IndicatorStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'KillSession', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������ (��. sys.dm_exec_sessions � sys.dm_exec_connections)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'KillSession'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'db'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'shema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'table'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'IndexName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'object_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'idx'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'db_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������, ��������� ������������� � ����� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ListDefragIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery', @level2type=N'COLUMN',@level2name=N'PlanHandle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery', @level2type=N'COLUMN',@level2name=N'SQLHandle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery', @level2type=N'COLUMN',@level2name=N'QueryPlan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'PlanQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� �� ��������� �������� (��������������� �� ��������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryRequestGroupStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����, ����� ������ ��� �������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'creation_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������������ ���������� ���������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'last_execution_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��� ������ ��� �������� � ������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'execution_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ������������� ���������� � �������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'CPU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �������� ���������� �� ���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'AvgCPUTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����� ���������� �������, � �������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'TotDuration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� ���������� ������� � �������������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'AvgDur'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'Reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ��������� ������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'Writes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ���������� �������� �����-������ (��������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'AggIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� ���������� �������� �������� �� ���� ���������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'AvgIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'sql_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'plan_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������� �������, ������������ �������, � ��������������� ������ ������ ��� ����������� �������, � ������, ������� � 0' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'statement_start_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������� �������, ������������ �������, � ��������������� ������ ������ ��� ����������� �������, � ������, ������� � 0.
� ������� �� SQL Server 2014 �������� -1 ���������� ����� ������. �������� ����������� ������ �� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'statement_end_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'database_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'object_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������������� ������������ ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'INDEX',@level2name=N'indClustQueryStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ���� ����� (������ � ������������� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics', @level2type=N'INDEX',@level2name=N'indPlanQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ����������� ���������� MS SQL Server (sys.dm_exec_query_stats)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'QueryStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'COLUMN',@level2name=N'Recipient_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� (����� ���� �������� � �������� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'COLUMN',@level2name=N'Recipient_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'COLUMN',@level2name=N'Recipient_Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'COLUMN',@level2name=N'IsDeleted'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'Recipient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������, � �������� ��������� ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������. �������� � ��������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'request_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������� ����������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����������� � ������ ������ �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'command'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-����� ������ SQL-�������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'sql_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ���������� ����������� � ��������� ������ ���������� �� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'statement_start_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ���������� ����������� � ��������� ������ ���������� �� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'statement_end_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-����� ����� ���������� SQL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'plan_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���� ������, � ������� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'database_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������, ������������ ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����������, �� �������� �������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'connection_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������, ������������ ������ ������. ���� ���� ������� �������� �������� NULL, �� ������ �� ���������� ��� �������� � ������ ���������� ���������� (��� �� ����� ���� ����������������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'blocking_session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ���������� ��� ��������. ��������� �������� NULL (sys.dm_os_wait_stats)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'wait_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'wait_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_wait_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'wait_resource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������, �������� ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'open_transaction_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������������� �������, �������� ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'open_resultset_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����������, � ������� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'transaction_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� CONTEXT_INFO ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'context_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� ������ (��� ��������� ����� ������ sys.dm_exec_requests)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'percent_complete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��� ����������� �������������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'estimated_completion_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �� (� �������������), ����������� �� ���������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'cpu_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, �������� � ������� ����������� ������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'total_elapsed_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������, ������� ��������� ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'scheduler_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����� ������, ����������� ��� ������, ��������� � ���� ��������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'task_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'writes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'logical_reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� TEXTSIZE ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'text_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ��� ������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� DATEFORMAT ��� ������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'date_format'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� DATEFIRST ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'date_first'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� QUOTED_IDENTIFIER ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'quoted_identifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ARITHABORT ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL.' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'arithabort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_NULL_DFLT_ON ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'ansi_null_dflt_on'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_DEFAULTS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'ansi_defaults'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_WARNINGS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'ansi_warnings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_PADDING ��� ������� ������� (ON).

� ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'ansi_padding'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_NULLS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'ansi_nulls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� CONCAT_NULL_YIELDS_NULL ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'concat_null_yields_null'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��������, � ������� ������� ���������� ��� ������� �������. �� ��������� �������� NULL.

0 = �� ������;

1 = ������ �����������������;

2 = ������ ���������������;

3 = ����������� ����������;

4 = �������������;

5 = ������������ ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'transaction_isolation_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ���������� ��� ������� ������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'lock_timeout'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� DEADLOCK_PRIORITY ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'deadlock_priority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, ������������ ������� �� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'row_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������, ����������� ��� ���������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'prev_error'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� ����������� ����, ������������ ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'nest_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, ���������� ��� ���������� ������������ �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'granted_query_memory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������). ���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'executing_managed_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ ������� ��������, ������� ����������� ���� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'group_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������. ����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'query_hash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������. ����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'query_plan_hash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� ������������� ������ ������ ���������� �������, ���������� � ������ �����������. (���������� SOAP ����� �������� ������������ � ������ ������.) ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'most_recent_session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� ������������ ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'connect_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������� ����������� ������������� ���������, ������������� ������ �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'net_transport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��� ��������� �������� �������� ������. � ��������� ����� ����������� ��������� TDS (TSQL) � SOAP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'protocol_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������� ������� � ������, ���������� � ������ �����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'protocol_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������, ����������� ��� ����������. ���� ������������� endpoint_id ����� �������������� ��� �������� � ������������� sys.endpoints. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'endpoint_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��������, �����������, ��������� �� ���������� ��� ������� ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'encrypt_option'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� �������� ����������� (SQL Server ��� Windows), ������������ � ������ �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'auth_scheme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� ���� ������, �������� ������������� ������ ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'node_affinity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, �������� ����������� ������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'num_reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, ���������� ����������� ������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'num_writes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� � ��������� ���������� ������ ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_read'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� � ��������� ������������ ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_write'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������� ������, ������������ ��� �������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'net_packet_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� ���������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'client_net_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����� �� ���������� ����������, ������� ������������ ��� ������������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'client_tcp_port'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP-����� �������, � ������� ����������� ������ ����������. �������� ������ ��� ����������, ������� � �������� ���������� ������ ���������� �������� TCP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'local_net_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TCP-���� �������, ���� ���������� ���������� �������� TCP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'local_tcp_port'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� ��������� ����������, ������������ � ������ MARS. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'parent_connection_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� ������� SQL, ������������ � ������� ������� ����������. ��������� ���������� ������������� ����� �������� most_recent_sql_handle � �������� most_recent_session_id. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'most_recent_sql_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'login_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������� ������� �������, ��������� � ������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'host_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'program_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'host_process_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ TDS-��������� ����������, ������� ������������ �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'client_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������, ������������� �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'client_interface_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������ Microsoft Windows, ��������� � ������ �����. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'security_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� SQL Server, ��� ������� ����������� ������� �����. ��� ����� ������������, ���������� �����, ��. � ������� original_login_name. ��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ���� ��� ������������ ������ Windows, ��������� �������� �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'login_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� Windows ��� �������, ���� �� ����� ������ ����������� �������� ����������� Windows ��� ������������� ����������. ��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'nt_domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������������ Windows ��� �������, ���� �� ����� ������ ������������ �������� ����������� Windows ��� ������������� ����������. ��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'nt_user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� 8-������������ ������� ������, ������������ ������ �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'memory_usage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, ����������� ������� ������ (������� ��� ��������� �������) ��� ����������, � �������������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'total_scheduled_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����, ����� ������� ��������� ������ ������� ������. ��� ����� ���� ������, ������������� � ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_request_start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ���������� ������� � ������ ������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_request_end_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0, ���� ����� �������� ���������. � ��������� ������ �������� ����� 1. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'is_user_process'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������ Microsoft Windows, ��������� � ������ ����� original_login_name. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'original_security_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� SQL Server, � ������� �������� ������ ������ ������ �����. ��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ��� ������������ ������ Windows, ��������� �������� �����������, ��� ������������ ���������� ���� ������. �������� ��������, ��� ����� ��������������� ���������� ��� ������ ����� ���� ��������� ����� ������� ��� ����� ������������ ���������. ��������, ��� ������������� ���������� EXECUTE AS. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'original_login_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ��������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_successful_logon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ����������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'last_unsuccessful_logon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ������� ����� � ������� ��� ����� original_login_name ����� last_successful_logon � login_time' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'unsuccessful_logons'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���� ������, ����������� �������� ����������� ���������. ��� ���� ����� ��� �������� ����� ����� 0. ��� ������������� ���������� ���� ������ ��� �������� ����� ��������� ������������� ���������� ���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'authenticating_database_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ �� �������� � UTC (����� ����������� �������� ������������ �������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics', @level2type=N'COLUMN',@level2name=N'EndRegUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� �������� �������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������, � �������� ��������� ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������. �������� � ��������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'request_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������� ����������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����������� � ������ ������ �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'command'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-����� ������ SQL-�������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'sql_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� �������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ���������� ����������� � ��������� ������ ���������� �� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'statement_start_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �������� � ����������� � ��������� ������ ������ ��� �������� ���������, � ������� ����������� ������� ����������. ����� ����������� ������ � ��������� ������������� ���������� sql_handle, statement_end_offset � sys.dm_exec_sql_text ��� ���������� ����������� � ��������� ������ ���������� �� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'statement_end_offset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-����� ����� ���������� SQL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'plan_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���� ������, � ������� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'database_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������, ������������ ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����������, �� �������� �������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'connection_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������, ������������ ������ ������. ���� ���� ������� �������� �������� NULL, �� ������ �� ���������� ��� �������� � ������ ���������� ���������� (��� �� ����� ���� ����������������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'blocking_session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ���������� ��� ��������. ��������� �������� NULL (sys.dm_os_wait_stats)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'wait_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ���������� ����������������� �������� �������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'wait_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ��� ���������� �����, � ������� ���������� ��� ���������� ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_wait_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ � ��������� ������ ����������, � ������� ������ ������, ������������ �������� ������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'wait_resource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������, �������� ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'open_transaction_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������������� �������, �������� ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'open_resultset_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����������, � ������� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'transaction_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� CONTEXT_INFO ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'context_info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� ������ (��� ��������� ����� ������ sys.dm_exec_requests)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'percent_complete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��� ����������� �������������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'estimated_completion_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �� (� �������������), ����������� �� ���������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'cpu_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, �������� � ������� ����������� ������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'total_elapsed_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������, ������� ��������� ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'scheduler_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����� ������, ����������� ��� ������, ��������� � ���� ��������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'task_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'writes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� �������� ������, ����������� ������ ��������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'logical_reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� TEXTSIZE ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'text_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ��� ������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� DATEFORMAT ��� ������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'date_format'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� DATEFIRST ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'date_first'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� QUOTED_IDENTIFIER ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'quoted_identifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ARITHABORT ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL.' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'arithabort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_NULL_DFLT_ON ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'ansi_null_dflt_on'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_DEFAULTS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'ansi_defaults'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_WARNINGS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'ansi_warnings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_PADDING ��� ������� ������� (ON).

� ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'ansi_padding'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� ANSI_NULLS ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'ansi_nulls'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = �������� CONCAT_NULL_YIELDS_NULL ��� ������� ������� (ON). � ��������� ������ � 0.

�� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'concat_null_yields_null'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��������, � ������� ������� ���������� ��� ������� �������. �� ��������� �������� NULL.

0 = �� ������;

1 = ������ �����������������;

2 = ������ ���������������;

3 = ����������� ����������;

4 = �������������;

5 = ������������ ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'transaction_isolation_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� ���������� ��� ������� ������� (� �������������). �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'lock_timeout'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� DEADLOCK_PRIORITY ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'deadlock_priority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, ������������ ������� �� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'row_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������, ����������� ��� ���������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'prev_error'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� ����������� ����, ������������ ��� ������� �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'nest_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, ���������� ��� ���������� ������������ �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'granted_query_memory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������, ��������� �� ������ ������ � ��������� ����� ��� ������� ����� CLR (��������, ���������, ���� ��� ��������). ���� ���� ���������� � ������� ����� �������, ����� ������ ����� CLR ��������� � �����, ���� ����� �� ����� ���������� ��� Transact-SQL. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'executing_managed_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ ������� ��������, ������� ����������� ���� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'group_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���-�������� �������������� ��� ������� � ������������ ��� ������������� �������� � ����������� �������. ����� ������������ ��� ������� ��� ����������� ������������� �������������� �������� ��� ��������, ������� ���������� ������ ������ ������������ ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'query_hash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���-�������� �������������� ��� ����� ���������� ������� � ������������ ��� ������������� ����������� ������ ���������� ��������. ����� ������������ ��� ����� ������� ��� ���������� ���������� ��������� �������� �� ������� ������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'query_plan_hash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� ������������� ������ ������ ���������� �������, ���������� � ������ �����������. (���������� SOAP ����� �������� ������������ � ������ ������.) ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'most_recent_session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� ������������ ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'connect_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������� ����������� ������������� ���������, ������������� ������ �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'net_transport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��� ��������� �������� �������� ������. � ��������� ����� ����������� ��������� TDS (TSQL) � SOAP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'protocol_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������� ������� � ������, ���������� � ������ �����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'protocol_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������, ����������� ��� ����������. ���� ������������� endpoint_id ����� �������������� ��� �������� � ������������� sys.endpoints. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'endpoint_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ��������, �����������, ��������� �� ���������� ��� ������� ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'encrypt_option'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� �������� ����������� (SQL Server ��� Windows), ������������ � ������ �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'auth_scheme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� ���� ������, �������� ������������� ������ ����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'node_affinity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, �������� ����������� ������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'num_reads'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������, ���������� ����������� ������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'num_writes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� � ��������� ���������� ������ ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_read'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������� � ��������� ������������ ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_write'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������� ������, ������������ ��� �������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'net_packet_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� ���������� �������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'client_net_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����� �� ���������� ����������, ������� ������������ ��� ������������� ����������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'client_tcp_port'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP-����� �������, � ������� ����������� ������ ����������. �������� ������ ��� ����������, ������� � �������� ���������� ������ ���������� �������� TCP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'local_net_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TCP-���� �������, ���� ���������� ���������� �������� TCP. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'local_tcp_port'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������� ��������� ����������, ������������ � ������ MARS. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'parent_connection_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ���������� ������� SQL, ������������ � ������� ������� ����������. ��������� ���������� ������������� ����� �������� most_recent_sql_handle � �������� most_recent_session_id. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'most_recent_sql_handle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������� ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'login_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������� ������� �������, ��������� � ������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'host_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'program_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� �������� ���������� ���������, ������� ������������ �����. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'host_process_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ TDS-��������� ����������, ������� ������������ �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'client_version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���������, ������������� �������� ��� ����������� � �������. ��� ����������� ������ ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'client_interface_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������ Microsoft Windows, ��������� � ������ �����. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'security_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� SQL Server, ��� ������� ����������� ������� �����. ��� ����� ������������, ���������� �����, ��. � ������� original_login_name. ��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ���� ��� ������������ ������ Windows, ��������� �������� �����������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'login_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� Windows ��� �������, ���� �� ����� ������ ����������� �������� ����������� Windows ��� ������������� ����������. ��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'nt_domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������������ Windows ��� �������, ���� �� ����� ������ ������������ �������� ����������� Windows ��� ������������� ����������. ��� ���������� ������� � �������������, �� ������������� � ������, ��� �������� ����� NULL. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'nt_user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� 8-������������ ������� ������, ������������ ������ �������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'memory_usage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �����, ����������� ������� ������ (������� ��� ��������� �������) ��� ����������, � �������������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'total_scheduled_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����, ����� ������� ��������� ������ ������� ������. ��� ����� ���� ������, ������������� � ������ ������. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_request_start_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ���������� ������� � ������ ������� ������. ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_request_end_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0, ���� ����� �������� ���������. � ��������� ������ �������� ����� 1. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'is_user_process'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������������ Microsoft Windows, ��������� � ������ ����� original_login_name. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'original_security_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� SQL Server, � ������� �������� ������ ������ ������ �����. ��� ����� ���� ��� ����� SQL Server, ��������� �������� �����������, ��� ������������ ������ Windows, ��������� �������� �����������, ��� ������������ ���������� ���� ������. �������� ��������, ��� ����� ��������������� ���������� ��� ������ ����� ���� ��������� ����� ������� ��� ����� ������������ ���������. ��������, ��� ������������� ���������� EXECUTE AS. �� ��������� �������� NULL' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'original_login_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ��������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_successful_logon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ����������� ����� � ������� ��� ����� original_login_name �� ������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'last_unsuccessful_logon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������� ������� ����� � ������� ��� ����� original_login_name ����� last_successful_logon � login_time' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'unsuccessful_logons'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���� ������, ����������� �������� ����������� ���������. ��� ���� ����� ��� �������� ����� ����� 0. ��� ������������� ���������� ���� ������ ��� �������� ����� ��������� ������������� ���������� ���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'authenticating_database_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ �� �������� � UTC (����� ����������� �������� ������������ �������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'COLUMN',@level2name=N'EndRegUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ������������ ������ �� ���������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'INDEX',@level2name=N'indRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ���������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive', @level2type=N'INDEX',@level2name=N'indPlanQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ������ �� �������� �������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RequestStatisticsArchive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ������ ������ ��������� ����� (���� �������, �� �� ��������� � �������� �������������� �� ������ ��������� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'COLUMN',@level2name=N'FullPathRestore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ������ ���������� ��������� ����� (���� �������, �� �� ��������� � �������� �������������� �� ���������� ��������� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'COLUMN',@level2name=N'DiffPathRestore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ������ ��������� ����� �������� ���������� (���� �������, �� �� ��������� � �������� �������������� �������� ����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'COLUMN',@level2name=N'LogPathRestore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �� �������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'Row_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ������ ��������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'SourcePathRestore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� � ������, ���� ����� ������������� �� (��� ����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'TargetPathRestore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'Ext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� �� �������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'RestoreSettingsDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'Row_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'File_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'Type_desc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ����������� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'Drive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'Ext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� ����� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'CountPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ����� �� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'SizeMb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ����� �� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'SizeGb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ������ ���� �� �� ������ ������ ������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ServerDBFileInfoStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'SessionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ��� ���������������� ����� � ���, ��� ���������� ���� ��� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'CountTranNotRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ��� ���������������� ����� � ���, ��� ������ ���� ��� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'CountSessionNotRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ������ ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'TransactionBeginTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� ��������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'COLUMN',@level2name=N'UpdateUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������, � ������� ��� �������� �������� � �� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SessionTran'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'Job_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'Job_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� ������ ��� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastFinishRunState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����� ������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastDateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����������������� ���������� ������� � ���� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastRunDurationString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ����������������� ���������� ������� � ���� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastRunDurationInt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ��������� � ����������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastOutcomeMessage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� ���������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'LastRunOutcome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'Server'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� � ��������, ������� ����������� ���� � �������, ���� ������� ����� (����� 30 ������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'ShortInfoRunJobs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SQLQuery', @level2type=N'COLUMN',@level2name=N'SQLHandle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SQLQuery', @level2type=N'COLUMN',@level2name=N'TSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SQLQuery', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'SQLQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'Row_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'SchemaName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'TableName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'IndexUsedForCounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'CountRows'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � �������� �������� ������� �� ������ ������ ������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableIndexStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������ (����������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'Row_GUID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'ServerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'SchemaName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'TableName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� �����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'CountRows'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������ � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'IndexSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������������� ����� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UnusedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'ReservedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� � ����� �������� ������ � UTC' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'InsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ����� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'CountRowsBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ����� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'CountRowsNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������ � �� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������ � �� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������� � �� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'IndexSizeKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������� � �� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'IndexSizeKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������������� ����� � �� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UnusedKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ��������������� ����� � �� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UnusedKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������������������ ����� � �� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'ReservedKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ������������������ ����� � �� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'ReservedKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����������  CountRows' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgCountRows'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����������  DataKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgDataKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����������  IndexSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgIndexSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����������  UnusedKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgUnusedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����������  ReservedKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgReservedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  CountRows' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffCountRows'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  DataKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffDataKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  IndexSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffIndexSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  UnusedKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffUnusedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  ReservedKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffReservedKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ������� � ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'TotalPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ������� � �� �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'TotalPageSizeKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ������� � �� �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'TotalPageSizeKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���-�� ������������ ������� (������ � ��)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UsedPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���-�� ������������ ������� (������ � ��) �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UsedPageSizeKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���-�� ������������ ������� (������ � ��) �� ����������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'UsedPageSizeKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� ��� ������ (������ � ��)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� ��� ������ (������ � ��) �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataPageSizeKBBack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� ��� ������ (������ � ��) �� ���������� ����' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DataPageSizeKBNext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� DataPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgDataPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� UsedPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgUsedPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� TotalPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'AvgTotalPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  DataPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffDataPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  UsedPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffUsedPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ����������  TotalPageSizeKB' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'COLUMN',@level2name=N'DiffTotalPageSizeKB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� InsertUTCDate' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics', @level2type=N'INDEX',@level2name=N'indInsertUTCDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � �������� ������� �� ������ ������ ������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TableStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'command'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'DBName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ����� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'PlanHandle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'SqlHandle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'execution_count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� �������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'min_wait_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� ���������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'min_estimated_completion_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� �� � ��� (�������� �� ���� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'min_cpu_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� ����� ���������� � ��� ' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'min_total_elapsed_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� ���������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'min_lock_timeoutSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� �������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'max_wait_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� ���������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'max_estimated_completion_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� �� � ��� (�������� �� ���� �����)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'max_cpu_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� ����� ���������� � ��� ' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'max_total_elapsed_timeSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������ ����� ���������� � ���' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'max_lock_timeoutSec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����, ����� ������ ����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics', @level2type=N'COLUMN',@level2name=N'DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������������������ ���������� MS SQL Server �� ������� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'TABLE',@level1name=N'TSQL_DAY_Statistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ������� � ����������� � ������� ������������ (sys.dm_db_index_physical_stats)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'AllIndexFrag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ������ ���� �� ���������� MS SQL Server (sys.master_files)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'ServerDBFileInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �������� �� ���� ���������� MS SQL Server (sys.sql_logins)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'SqlLogins'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��� ���� (�������� � ��������) �� ���� ���������� MS SQL Server (sys.syslogins)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'SysLogins'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������ ���������� MS SQL Server (sys.dm_exec_sessions)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vActiveConnect'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ������� �������� (������� ����������� ����� �� ����� 100 ����) �������� ���������� ���������� MS SQL Server (sys.dm_exec_query_stats)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vBigQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������������� ������� (����������� ������) ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vBlockingQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ��������������� �������� (������������� ������) ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vBlockRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������ � �������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vColumns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� �������� � ���������� ��������
������������ ��� ������ ���������� �������� � ������� ������ ������/������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vColumnsStatisticsCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������� ������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vColumnTableDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� �������� �������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vColumnViewDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� �������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vComputedColumns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ��������� ���������� ������� � �������������� DMV dm_db_partition_stats' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vCountRows'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ��' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vDataSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ������ ��' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vDBFileInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������� ������-������ �� ���� ������ ���� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vDBFilesOperationsStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� �������� �� ��������� ��� �������� (� ������������ ���� �����������)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vDefaultsConstraints'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vDelIndexOptimize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� �����' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vFK_Keys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ����� � ���������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vFK_KeysIndexes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� � �� �������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vFuncs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vFunctionStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���-�� ������� �� ����� (�� ��������, � ������� ��� ����������� �������)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vHeaps'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� IDENTITY (� � � ���� ��������������)' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vIdentityColumns'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������������ ��� ��������, ������ ������� �� ����� 1 �������� (8 �������) � ������������ ������� ����� 10% (��������� ����� �����) � ������ ��� ������-�� ��� (� � ��������� ���������� ������). ������� � ������ ������ �������� �������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vIndexDefrag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������������� �������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vIndexesUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vIndexUsageStats'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���������� ������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vInnerTableSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobActivity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� � ��������� ����������� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobRunShortInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������ ���������� MS SQL Server �� ������������� msdb.dbo.sysjobs_view' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJOBS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobSchedules'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������ ���������� MS SQL Server �� ������� [msdb].[dbo].[sysjobservers]' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobServers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobSteps'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ����� ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vJobStepsLogs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ����������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vLocks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ��������� ����� �������� � �� ������� ���������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vNewIndexOptimize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��� ��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vObjectDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��� ��������, � ������� ���� ��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vObjectInParentDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��� ����������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vParameterDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ������������������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vPerformanceObject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ��������� � �� �������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vProcedures'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� �������� ���������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vProcedureStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vProcesses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � �������� �������� ���������� ���������� MS SQL Server ' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vQueryResourse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vQueryStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ������/������ ������� (���� �� ���������������, � � � ��� ��� ��������).
������ �� �������, � ������� ���������� ����� ������� SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vReadWriteTables'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ������� �� DMV' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vRecomendateIndex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������, ������� � ���������� � ��������� �������, � ����� ��, ��� ���� ��������� ������ ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vRequestDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � �������� (��� ��������� � � �) ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vRequestLockDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � �������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vRequests'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������, � ������� ��������� ����� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vScheduleMultiJobs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ����� ������ ��� ������� ������������ SQL Server, ��������������� � ��������� �����������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSchedulersOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���� ��' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSchemaDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ��������� ������ �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerBackupDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ������������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerConfigurations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� �� ���� ������ ���� �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerFilesDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ��������� ��������� ������ �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerLastBackupDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ���� ��  ���������� MS SQL Server, ������� ������ ������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerOnlineDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ��������� � ����������� ������ �� tempdb ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerProblemInCountFilesTempDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerRunTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� ���������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vServerShortInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������������� ���������� ����������, ����������� ������������� ������ � ��������������� ������ Windows ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSessionThreadOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ������� �������� ����� ���� ������ � ���� ������ �������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSizeCache'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ���������������� (���������) �������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSuspendedRequest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vSynonyms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vTables'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vTableSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vTriggers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ���������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vTriggerStat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ������������ ����� ������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vTypesRunStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������������' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vViews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������� (�� �����������) ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'inf', @level1type=N'VIEW',@level1name=N'vWaits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ���������� �� �������� ������������ �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vActiveConnectionShortStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� �������� ������������ �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vActiveConnectionStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� �����������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vBackupSettings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ������ ���� �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vDBFiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������� ���������� �� �������� ���� �� �� ��������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vDBSizeShortStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� �������� ���� �� �� ��������� ������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vDBSizeStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ���������������(������) ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vDelIndexInclude'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ���������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vDrivers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������������������ ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vIndicatorStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vPlanQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ���������� �� �������� ���������� MS SQL Server (��������������� �� ��������)' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vQueryRequestGroupStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ �� ����������� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vQueryStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������� � ��������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vRecipientAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� �������� �������� �� ������ ������ �������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vRequestStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� �� �������������� ��' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vRestoreSettings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������� �������� ���� ������ ���� �� ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vServerDBFileInfoStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vSQLQuery'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ���������� ������������� �������� �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vStatisticDefrag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� � ������� ������ � ����� �� tempdb ���������� MS SQL Server' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vStatisticsIOInTempDB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������� �������� �������� ������ �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vTableIndexStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������� �� ��������� �������� ������ �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vTableStatistics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������� ���������� �� ��������� �������� ������ �� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vTableStatisticsShort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������� ������������������ ���������� MS SQL Server �� ������� �������� ��������' , @level0type=N'SCHEMA',@level0name=N'srv', @level1type=N'VIEW',@level1name=N'vTSQL_DAY_Statistics'
GO
USE [master]
GO
ALTER DATABASE [SRV] SET  READ_WRITE 
GO
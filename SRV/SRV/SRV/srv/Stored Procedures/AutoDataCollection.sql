﻿
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [srv].[AutoDataCollection]
AS
BEGIN
	/*
		Сбор данных
	*/
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	EXEC [srv].[AutoStatisticsFileDB];
    EXEC [srv].[AutoBigQueryStatistics];
	EXEC [srv].[AutoIndexStatistics];
	EXEC [srv].[AutoShortInfoRunJobs];
	EXEC [srv].[AutoStatisticsIOInTempDBStatistics];
	EXEC [srv].[AutoNewIndexOptimizeStatistics];
	EXEC [srv].[AutoWaitStatistics];
	EXEC [srv].[AutoReadWriteTablesStatistics];
	EXEC [srv].[InsertTableStatistics];
END

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Сбор данных', @level0type = N'SCHEMA', @level0name = N'srv', @level1type = N'PROCEDURE', @level1name = N'AutoDataCollection';


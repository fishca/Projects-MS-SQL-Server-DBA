﻿create view [inf].[vServerOnlineDB] as
-- какие БД сейчас используются
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
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Информация по всем БД  экземпляра MS SQL Server, которые сейчас используются', @level0type = N'SCHEMA', @level0name = N'inf', @level1type = N'VIEW', @level1name = N'vServerOnlineDB';


﻿CREATE TABLE [srv].[KillSession] (
    [ID]                          INT              IDENTITY (1, 1) NOT NULL,
    [session_id]                  SMALLINT         NOT NULL,
    [transaction_id]              BIGINT           NOT NULL,
    [login_time]                  DATETIME         NOT NULL,
    [host_name]                   NVARCHAR (128)   NULL,
    [program_name]                NVARCHAR (128)   NULL,
    [host_process_id]             INT              NULL,
    [client_version]              INT              NULL,
    [client_interface_name]       NVARCHAR (32)    NULL,
    [security_id]                 VARBINARY (85)   NOT NULL,
    [login_name]                  NVARCHAR (128)   NOT NULL,
    [nt_domain]                   NVARCHAR (128)   NULL,
    [nt_user_name]                NVARCHAR (128)   NULL,
    [status]                      NVARCHAR (30)    NOT NULL,
    [context_info]                VARBINARY (128)  NULL,
    [cpu_time]                    INT              NOT NULL,
    [memory_usage]                INT              NOT NULL,
    [total_scheduled_time]        INT              NOT NULL,
    [total_elapsed_time]          INT              NOT NULL,
    [endpoint_id]                 INT              NOT NULL,
    [last_request_start_time]     DATETIME         NOT NULL,
    [last_request_end_time]       DATETIME         NULL,
    [reads]                       BIGINT           NOT NULL,
    [writes]                      BIGINT           NOT NULL,
    [logical_reads]               BIGINT           NOT NULL,
    [is_user_process]             BIT              NOT NULL,
    [text_size]                   INT              NOT NULL,
    [language]                    NVARCHAR (128)   NULL,
    [date_format]                 NVARCHAR (3)     NULL,
    [date_first]                  SMALLINT         NOT NULL,
    [quoted_identifier]           BIT              NOT NULL,
    [arithabort]                  BIT              NOT NULL,
    [ansi_null_dflt_on]           BIT              NOT NULL,
    [ansi_defaults]               BIT              NOT NULL,
    [ansi_warnings]               BIT              NOT NULL,
    [ansi_padding]                BIT              NOT NULL,
    [ansi_nulls]                  BIT              NOT NULL,
    [concat_null_yields_null]     BIT              NOT NULL,
    [transaction_isolation_level] SMALLINT         NOT NULL,
    [lock_timeout]                INT              NOT NULL,
    [deadlock_priority]           INT              NOT NULL,
    [row_count]                   BIGINT           NOT NULL,
    [prev_error]                  INT              NOT NULL,
    [original_security_id]        VARBINARY (85)   NOT NULL,
    [original_login_name]         NVARCHAR (128)   NOT NULL,
    [last_successful_logon]       DATETIME         NULL,
    [last_unsuccessful_logon]     DATETIME         NULL,
    [unsuccessful_logons]         BIGINT           NULL,
    [group_id]                    INT              NOT NULL,
    [database_id]                 SMALLINT         NOT NULL,
    [authenticating_database_id]  INT              NULL,
    [open_transaction_count]      INT              NOT NULL,
    [most_recent_session_id]      INT              NULL,
    [connect_time]                DATETIME         NULL,
    [net_transport]               NVARCHAR (40)    NULL,
    [protocol_type]               NVARCHAR (40)    NULL,
    [protocol_version]            INT              NULL,
    [encrypt_option]              NVARCHAR (40)    NULL,
    [auth_scheme]                 NVARCHAR (40)    NULL,
    [node_affinity]               SMALLINT         NULL,
    [num_reads]                   INT              NULL,
    [num_writes]                  INT              NULL,
    [last_read]                   DATETIME         NULL,
    [last_write]                  DATETIME         NULL,
    [net_packet_size]             INT              NULL,
    [client_net_address]          NVARCHAR (48)    NULL,
    [client_tcp_port]             INT              NULL,
    [local_net_address]           NVARCHAR (48)    NULL,
    [local_tcp_port]              INT              NULL,
    [connection_id]               UNIQUEIDENTIFIER NULL,
    [parent_connection_id]        UNIQUEIDENTIFIER NULL,
    [most_recent_sql_handle]      VARBINARY (64)   NULL,
    [LastTSQL]                    NVARCHAR (MAX)   NULL,
    [transaction_begin_time]      DATETIME         NOT NULL,
    [CountTranNotRequest]         TINYINT          NOT NULL,
    [CountSessionNotRequest]      TINYINT          NOT NULL,
    [InsertUTCDate]               DATETIME         CONSTRAINT [DF_KillSession_InsertUTCDate] DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_KillSession] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [indInsertUTCDate]
    ON [srv].[KillSession]([InsertUTCDate] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Индекс по InsertUTCDate', @level0type = N'SCHEMA', @level0name = N'srv', @level1type = N'TABLE', @level1name = N'KillSession', @level2type = N'INDEX', @level2name = N'indInsertUTCDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Убитые сессии (см. sys.dm_exec_sessions и sys.dm_exec_connections)', @level0type = N'SCHEMA', @level0name = N'srv', @level1type = N'TABLE', @level1name = N'KillSession';

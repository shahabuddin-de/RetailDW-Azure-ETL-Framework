--creates ETL Runlog TABLE

CREATE TABLE dbo.ETL_RunLog
(
    RunLogID      INT IDENTITY(1,1) PRIMARY KEY,
    PipelineRunID VARCHAR(100),
    TableName     VARCHAR(100),
    LoadType      VARCHAR(20),
    RowsCopied    BIGINT,
    Status        VARCHAR(20),
    StartTime     DATETIME,
    EndTime       DATETIME,
    ErrorMessage  NVARCHAR(MAX)
);
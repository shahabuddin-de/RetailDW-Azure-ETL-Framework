CREATE   PROCEDURE dbo.usp_LogETLStart
(
    @PipelineRunID VARCHAR(100),
    @TableName VARCHAR(100),
    @LoadType VARCHAR(20),
    @StartTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ETL_RunLog
    (
        PipelineRunID,
        TableName,
        LoadType,
        Status,
        StartTime
    )
    VALUES
    (
        @PipelineRunID,
        @TableName,
        @LoadType,
        'RUNNING',
        @StartTime
    );
END;
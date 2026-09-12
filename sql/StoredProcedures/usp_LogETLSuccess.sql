CREATE   PROCEDURE dbo.usp_LogETLSuccess
(
    @PipelineRunID VARCHAR(100),
    @TableName VARCHAR(100),
    @RowsCopied BIGINT,
    @EndTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ETL_RunLog
    SET
        Status = 'SUCCESS',
        RowsCopied = @RowsCopied,
        EndTime = @EndTime
    WHERE PipelineRunID = @PipelineRunID
      AND TableName = @TableName
      AND Status = 'RUNNING';
END;
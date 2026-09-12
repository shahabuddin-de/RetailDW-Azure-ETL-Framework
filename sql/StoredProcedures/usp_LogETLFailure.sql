CREATE   PROCEDURE dbo.usp_LogETLFailure
(
    @PipelineRunID VARCHAR(100),
    @TableName VARCHAR(100),
    @ErrorMessage NVARCHAR(MAX),
    @EndTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ETL_RunLog
    SET
        Status = 'FAILED',
        ErrorMessage = @ErrorMessage,
        EndTime = @EndTime
    WHERE PipelineRunID = @PipelineRunID
      AND TableName = @TableName
      AND Status = 'RUNNING';

    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO dbo.ETL_RunLog
        (
            PipelineRunID,
            TableName,
            Status,
            StartTime,
            EndTime,
            ErrorMessage
        )
        VALUES
        (
            @PipelineRunID,
            @TableName,
            'FAILED',
            @EndTime,
            @EndTime,
            @ErrorMessage
        );
    END
END;
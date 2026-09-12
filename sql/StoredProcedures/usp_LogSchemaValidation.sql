CREATE   PROCEDURE dbo.usp_LogSchemaValidation
(
    @PipelineRunID VARCHAR(100),
    @SchemaName VARCHAR(100),
    @TableName VARCHAR(100),
    @SourceColumnCount INT,
    @TargetColumnCount INT,
    @IsMatch BIT
)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.ETL_SchemaValidationLog
    (PipelineRunID, SchemaName, TableName, SourceColumnCount, TargetColumnCount, IsMatch)
    VALUES
    (@PipelineRunID, @SchemaName, @TableName, @SourceColumnCount, @TargetColumnCount, @IsMatch);
END;
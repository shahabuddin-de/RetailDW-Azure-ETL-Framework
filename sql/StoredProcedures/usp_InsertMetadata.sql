CREATE   PROCEDURE dbo.usp_InsertMetadata
(
    @SchemaName VARCHAR(100),
    @TableName VARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.ETL_Metadata
        WHERE TableName = @TableName
    )
    BEGIN
        INSERT INTO dbo.ETL_Metadata
        (
            TableName,
            SchemaName,
            WatermarkColumn,
            LastWatermark,
            TargetContainer,
            TargetFolder,
            IsActive,
            LoadType,
            PrimaryKeyColumn
        )
        VALUES
        (
            @TableName,
            @SchemaName,
            'LastModifiedDate',
            '1900-01-01 00:00:00',
            'landing',
            LOWER(@TableName),
            1,
            'INCREMENTAL',
            NULL
        );
    END
END;
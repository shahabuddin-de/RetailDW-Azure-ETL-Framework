USE RetailControlDB;
GO

CREATE TABLE dbo.ETL_SchemaValidationLog
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    PipelineRunID VARCHAR(100),
    SchemaName VARCHAR(100),
    TableName VARCHAR(100),
    SourceColumnCount INT,
    TargetColumnCount INT,
    IsMatch BIT,
    ValidationTime DATETIME DEFAULT GETDATE()
);
GO
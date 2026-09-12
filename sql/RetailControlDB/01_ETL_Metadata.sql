--creates metadata TABLE

CREATE TABLE dbo.ETL_Metadata
(
    TableName        VARCHAR(100) NOT NULL,
    SchemaName       VARCHAR(100) NOT NULL,
    WatermarkColumn  VARCHAR(100) NULL,
    LastWatermark    DATETIME NULL,
    TargetContainer  VARCHAR(100) NOT NULL,
    TargetFolder     VARCHAR(500) NOT NULL,
    IsActive         BIT NOT NULL,
    LoadType         VARCHAR(20) NOT NULL,
    PrimaryKeyColumn VARCHAR(100) NULL
);


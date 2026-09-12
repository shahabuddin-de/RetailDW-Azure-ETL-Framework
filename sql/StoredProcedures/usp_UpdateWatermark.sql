CREATE OR ALTER PROCEDURE dbo.usp_UpdateWatermark
 @TableName  varchar(100),
 @NewWaterMark DATETIME

AS

BEGIN
SET NOCOUNT ON; --  suppresses the “(1 row affected)” message SQL Server normally sends after an UPDATE.
UPDATE dbo.ETL_Metadata
set LastWatermark = @NewWaterMark
where TableName = @TableName;
end;
Go
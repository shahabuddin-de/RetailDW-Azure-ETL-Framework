CREATE VIEW dbo.vw_Stores AS
SELECT
    *,
    r.filepath(1) AS LoadYear,
    r.filepath(2) AS LoadMonth,
    r.filepath(3) AS LoadDay
FROM OPENROWSET(
    BULK 'https://adlsprojectshahab.dfs.core.windows.net/landing/stores/*/*/*/*.parquet',
    FORMAT = 'PARQUET'
) AS r;

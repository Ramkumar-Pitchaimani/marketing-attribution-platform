CREATE OR REPLACE TABLE `pro1-501113.marketing_dw.dim_channel`
AS

SELECT
    1 AS channel_key,
    'Google Ads' AS channel_name,
    'Paid Search' AS channel_type,
    'Google' AS vendor

UNION ALL

SELECT
    2,
    'Meta Ads',
    'Paid Social',
    'Meta';
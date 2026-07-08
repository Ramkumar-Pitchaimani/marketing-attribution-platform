-- ==========================================
-- Dimension Row Counts
-- ==========================================

SELECT 'dim_date' AS dimension_name,
COUNT(*) AS row_count
FROM `pro1-501113.marketing_dw.dim_date`

UNION ALL

SELECT 'dim_campaign',
COUNT(*)
FROM `pro1-501113.marketing_dw.dim_campaign`

UNION ALL

SELECT 'dim_channel',
COUNT(*)
FROM `pro1-501113.marketing_dw.dim_channel`

UNION ALL

SELECT 'dim_device',
COUNT(*)
FROM `pro1-501113.marketing_dw.dim_device`;
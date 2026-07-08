-- ==========================================
-- Clean vs Fact Validation
-- ==========================================

SELECT
'Marketing Fact' AS table_name,
(
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.google_ads_clean`
)
+
(
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.meta_ads_clean`
)
AS expected_rows,

(
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.fact_marketing`
)
AS fact_rows

UNION ALL

SELECT
'Lead Fact',

(
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.crm_leads_clean`
),

(
SELECT COUNT(*)
FROM `pro1-501113.marketing_dw.fact_leads`
);
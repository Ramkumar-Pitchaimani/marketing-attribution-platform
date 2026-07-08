-- ==========================================
-- Referential Integrity
-- ==========================================

SELECT
COUNT(*) AS orphan_campaigns
FROM `pro1-501113.marketing_dw.fact_marketing` f
LEFT JOIN `pro1-501113.marketing_dw.dim_campaign` d
ON f.campaign_key=d.campaign_key
WHERE d.campaign_key IS NULL

UNION ALL

SELECT
COUNT(*)
FROM `pro1-501113.marketing_dw.fact_marketing` f
LEFT JOIN `pro1-501113.marketing_dw.dim_channel` c
ON f.channel_key=c.channel_key
WHERE c.channel_key IS NULL;
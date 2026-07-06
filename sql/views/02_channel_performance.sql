CREATE OR REPLACE VIEW
`pro1-501113.marketing_dw.vw_channel_performance`
AS

SELECT

d.channel_name,

SUM(f.impressions) impressions,

SUM(f.clicks) clicks,

SUM(f.spend) spend,

SUM(f.conversions) conversions,

SAFE_DIVIDE(SUM(f.clicks),SUM(f.impressions)) ctr,

SAFE_DIVIDE(SUM(f.spend),SUM(f.clicks)) avg_cpc

FROM
`pro1-501113.marketing_dw.fact_marketing` f

JOIN
`pro1-501113.marketing_dw.dim_channel` d

ON f.channel_key=d.channel_key

GROUP BY
d.channel_name;
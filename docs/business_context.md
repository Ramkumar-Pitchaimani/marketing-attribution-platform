# Business Guide

# Marketing Attribution Platform

---

# 1. Business Problem

Most organizations advertise across multiple marketing platforms.

Examples

- Google Ads
- Meta Ads
- LinkedIn
- Bing Ads
- Email Campaigns

Each platform generates its own reports.

Business teams struggle to answer simple questions such as

- Which campaign generated the most revenue?
- Which platform gives the highest ROI?
- Which campaigns waste money?
- Which leads actually converted?
- Which channel deserves more budget?

Without a centralized platform, these answers require manual effort.

---

# 2. Project Objective

Build a centralized Marketing Attribution Platform that

- Collects marketing data
- Cleans the data
- Standardizes data
- Links CRM leads to campaigns
- Calculates marketing KPIs
- Provides dashboards for business users

---

# 3. Business Users

This platform serves

- Marketing Managers
- Digital Marketing Teams
- Sales Managers
- Finance Teams
- Business Analysts
- Executives

---

# 4. Business Value

Instead of multiple Excel reports

↓

Business receives

One trusted dashboard

Benefits

- Single source of truth
- Faster decision making
- Better campaign optimization
- Accurate ROI reporting
- Reduced manual reporting

---

# 5. Why Marketing Attribution?

Suppose a customer

Searches Google

↓

Clicks an Ad

↓

Visits Website

↓

Submits Lead Form

↓

Sales Team Calls

↓

Customer Purchases

Question

Which marketing campaign deserves credit?

Marketing Attribution answers this.

---

# 6. Business KPIs

The platform calculates

## Spend

Total advertising cost.

Business Meaning

How much money was invested?

---

## Impressions

How many times ads appeared.

Business Meaning

Brand visibility.

---

## Clicks

Number of ad clicks.

Business Meaning

Customer interest.

---

## CTR

Click Through Rate

CTR = Clicks / Impressions

Business Meaning

Measures advertisement effectiveness.

Higher CTR usually means better creatives.

---

## CPC

Cost Per Click

Spend / Clicks

Business Meaning

How expensive each customer click is.

Lower is better.

---

## Conversions

Desired business action.

Examples

- Purchase
- Signup
- Download
- Registration

---

## Conversion Rate

Conversions / Clicks

Business Meaning

Measures landing page effectiveness.

---

## CPA

Cost Per Acquisition

Spend / Conversions

Business Meaning

How much it costs to acquire a customer.

Lower is better.

---

## Revenue

Money generated from converted leads.

---

## ROAS

Return On Ad Spend

Revenue / Spend

Business Meaning

Every ₹1 spent generated ₹X revenue.

Example

Spend = ₹1000

Revenue = ₹5000

ROAS = 5

Meaning

Every ₹1 spent generated ₹5.

---

# 7. Why Bronze Layer?

Purpose

Store original source data.

Business Benefit

Original data is never lost.

Allows

- Replay
- Auditing
- Recovery

---

# 8. Why Silver Layer?

Purpose

Clean and standardize data.

Business Benefit

Removes inconsistencies.

Example

Google

Spend

Meta

Cost

↓

Silver

Spend

Business now sees consistent reports.

---

# 9. Why Gold Layer?

Purpose

Business-friendly warehouse.

Business Benefit

Fast dashboards.

Simple SQL.

Consistent KPIs.

---

# 10. Why Dimension Tables?

Instead of repeating campaign information millions of times

Store once

Reference using keys

Benefits

- Smaller storage
- Faster joins
- Easier reporting

---

# 11. Why Fact Tables?

Fact tables store

Business events.

Examples

Clicks

Spend

Revenue

Conversions

Business dashboards always query Fact tables.

---

# 12. Why Reporting Views?

Business users should never query raw tables.

Views

Hide complexity.

Benefits

- Easier reporting
- Better security
- Consistent calculations

---

# 13. Why Event-Driven Architecture?

Traditional

Run ETL every night.

Problem

Business waits.

Our project

CSV arrives

↓

Eventarc triggers

↓

Cloud Run executes

↓

Dashboard updated

Business Benefit

Near real-time reporting.

---

# 14. Cost Optimization

This project minimizes GCP cost.

Techniques

✓ Serverless Cloud Run

Only runs when needed.

---

✓ Eventarc

No polling.

Only event-based execution.

---

✓ BigQuery

Pay per query.

No database servers.

---

✓ Cloud Storage

Cheap object storage.

---

✓ Views

Avoid duplicate tables.

---

✓ Separate Bronze/Silver

Avoid repeated processing.

---

# 15. Why BigQuery?

Business Benefits

- Massive scalability
- Serverless
- Fast analytics
- Easy integration
- Low operational cost

---

# 16. Business Decisions Enabled

Marketing Manager can answer

Which campaign generated most revenue?

↓

Increase budget.

---------------------------------------

Which campaign has high spend but low conversions?

↓

Pause campaign.

---------------------------------------

Which country converts best?

↓

Target that geography.

---------------------------------------

Which channel has lowest CPA?

↓

Allocate more budget.

---------------------------------------

Which campaign has highest ROAS?

↓

Scale campaign.

---

# 17. Business Outcome

Before

Multiple spreadsheets

Manual reports

Slow analysis

Inconsistent KPIs

Delayed decisions

↓

After

Centralized warehouse

Automated pipeline

Trusted dashboards

Real-time reporting

Better business decisions

---

# 18. Interview Summary

One-minute explanation

"I built a serverless Marketing Attribution Platform on GCP that automatically ingests Google Ads, Meta Ads, and CRM data using Cloud Storage, Eventarc, and Cloud Run. The data is transformed through Bronze, Silver, and Gold layers in BigQuery into a star schema with dimensions and facts. Reporting views power Looker Studio dashboards for executives and marketing teams, enabling campaign analysis, channel performance, lead attribution, and KPI reporting while optimizing cloud costs through an event-driven, serverless architecture."
# retail-loyalty-analytics-dashboard
End-to-end retail analytics project — SQL RFM segmentation, K-Means clustering in Python, and a 3-page Power BI dashboard with DAX measures and conditional formatting. Dataset: UCI Online Retail (UK, Dec 2010–Nov 2011, 4,338 customers)
# Retail Loyalty Analytics Dashboard

## Project Overview
End-to-end analytics project on a UK online retail dataset covering 
541,909 transactions, 4,338 customers, and £9.75M in gross revenue 
(Dec 2010 – Nov 2011).

## Business Problem
How do we identify our most valuable customers, understand why segments 
behave differently, and design data-driven marketing strategies for each?

## Methodology
1. **Data cleaning** — removed cancellations (C-prefix invoices), 
   anonymous transactions, and internal postage charges
2. **RFM Analysis in SQL** — calculated Recency, Frequency, and 
   Monetary value per customer
3. **K-Means Clustering in Python** — scaled RFM features, determined 
   optimal k=3 clusters, assigned segment labels
4. **Power BI Dashboard** — built 3-page interactive report with DAX 
   measures, conditional formatting, and cross-page navigation

## Key Findings
- **14 Champion customers** (0.3% of base) generate **18% of revenue** 
  — classic Pareto concentration
- **Champions score 99/100** on combined RFM index vs **1/100** for 
  At-Risk customers
- **November 2011** is the peak month — Oct + Nov together = 
  26% of annual revenue
- **UK generates 84%** of all revenue — significant international 
  growth opportunity
- **48% of customers** are Bronze tier — large loyalty programme 
  upgrade opportunity

## Dashboard Pages
| Page | Audience | Key Visuals |
|------|----------|-------------|
| Executive Summary | CEO / CFO | 4 KPI cards, 3 KPI gauges, segment revenue bar, customer donut |
| Segment Deep Dive | Marketing Team | RFM scorecard, health matrix, combined RFM score, loyalty tier |
| Revenue & Trends | Commercial Team | Monthly trend, country map, top products, top 10 customers |

## Tech Stack
- **SQL** — RFM aggregation and customer segmentation
- **Python** — scikit-learn KMeans, StandardScaler, pandas
- **Power BI** — DAX measures, conditional formatting, 
  custom theme, multi-page navigation
- **Excel** — data model and intermediate cleaning layer

## Dataset
Source: UCI Online Retail Dataset  
Link: https://archive.ics.uci.edu/ml/datasets/online+retail  
Period: December 2010 – November 2011  
Geography: United Kingdom (84%) + 37 other countries  

## Dashboard Preview
*(See dashboard_preview.pdf in the powerbi/ folder)*

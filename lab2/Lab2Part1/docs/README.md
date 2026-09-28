# Power BI Artifact Catalog

## Overview

This Power BI project supports Northwind Retail Group sales and store-performance analysis. A single Import-mode semantic model provides sales, product, customer, store, and calendar data to a two-page report that moves from an interactive sales overview to a category-by-year KPI matrix.

## Artifacts

| Artifact | Type | Source | Connected artifact(s) | Purpose | Documentation |
|---|---|---|---|---|---|
| sales | Semantic model | `sales.SemanticModel/` | sales report | Provides the shared sales star schema, dimensions, and business measures. | [Open](sales.semantic-model.md) |
| sales | Report | `sales.Report/` | sales semantic model | Presents sales KPIs, product and customer breakdowns, store comparison, and yearly KPI detail. | [Open](sales.report.md) |

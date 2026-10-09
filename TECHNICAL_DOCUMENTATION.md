# Healthcare Financial BI Analytics — Technical Documentation

## 1. Scope

Independent Power BI project based on synthetic healthcare financial data. The delivered report has three pages: Executive Financial Overview, Cost Center & Department Financial Analysis, and Advanced Financial Analysis.

## 2. Data Inventory

| Table | Purpose |
|---|---|
| `FactFinancials` | Actual financial amounts |
| `FactBudget` | Budget amounts |
| `FactForecast` | Forecast amounts |
| `FactHeadcount` | Headcount source table present in the model |
| `DimDate` | Reporting dates and periods |
| `DimDepartment` | Department filtering and grouping |
| `DimCostCenter` | Cost-center filtering and grouping |
| `DimAccount` | Account classification and measure home |
| `DimExpenseCategory` | Expense categorization |

The precise relationship keys, cardinalities, and filter directions should be read from the PBIX model view; they have not been independently inspected here.

## 3. Core Measures

```dax
Total Actual = SUM(FactFinancials[ActualAmount])
Total Budget = SUM(FactBudget[BudgetAmount])
Total Forecast = SUM(FactForecast[ForecastAmount])
Budget Variance = [Total Actual] - [Total Budget]
Budget Variance % = DIVIDE([Budget Variance], [Total Budget])
Budget Utilization % = DIVIDE([Total Actual], [Total Budget], 0)
Forecast Variance % = DIVIDE([Total Actual] - [Total Forecast], [Total Forecast], 0)
```

### Interpretation

- `Budget Variance`: Actual minus Budget; positive = over budget, negative = under budget for expenses.
- `Budget Variance %`: Variance divided by budget.
- `Budget Utilization %`: Share of budget consumed by actual spending.
- `Forecast Variance %`: Difference between actual and forecast relative to forecast.
- `DIVIDE` avoids division errors; the last two percentage measures explicitly return zero for zero or blank denominators.

These are the confirmed measure definitions. For other measures already implemented, retain and verify the existing `dax/measures.md` against the PBIX rather than substituting example formulas.

## 4. Dashboard Specification

| Page | Key elements |
|---|---|
| Executive Financial Overview | Four KPI cards; monthly actual vs budget; monthly actual, budget and forecast trend; budget variance % trend |
| Cost Center & Department Financial Analysis | Cost-center spending; actual vs budget by cost center; budget variance % by cost center and department; slicers |
| Advanced Financial Analysis | Budget utilization and forecast variance cards; department matrix; budget variance by department; actual vs forecast; top cost centers; spending distribution; monthly forecast variance trend |

## 5. Reconciliation Record

Reported unfiltered totals:

| Metric | Value |
|---|---:|
| Total Actual | $1,402,762,391.34 |
| Total Budget | $1,404,832,728.48 |
| Actual − Budget | −$2,070,337.14 |
| Budget Variance % | −0.15% (rounded) |

The completed monthly financial reconciliation worksheet displayed **PASS**. Local artifacts include `monthly-financial-reconciliation.csv`, `monthly-budget-actual-validation.csv`, and spreadsheet counterparts. These artifacts should accompany the project when reproducibility is required. This record is not a formal external audit.

## 6. Testing Already Performed

- Dashboard slicer and visual interactions were tested.
- Actual and budget totals were reconciled in a worksheet.
- Dashboard layout, titles, conditional colors, and visual presentation were reviewed.
- Final dashboard screenshots were captured.

## 7. Reproduction Notes

1. Open `Healthcare_Financial_BI_Analytics.pbix` in Power BI Desktop.
2. Inspect the source settings and update the local synthetic workbook path if necessary.
3. Refresh the model.
4. With filters cleared, compare report totals to the reconciliation record.
5. Review measures in the model and the existing DAX reference file.
6. Explore the three dashboard pages using year, department, and cost-center selections.

## 8. Boundaries and Future Work

No production deployment, formal governance certification, or Microsoft Fabric implementation is claimed. Headcount data is present in the model, but a separate headcount dashboard is outside the delivered three-page scope. Future enhancements could add automated refresh, deployment pipelines, or further expense-category and workforce analysis.

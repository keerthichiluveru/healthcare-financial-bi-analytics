# DAX Measure Library

This file documents the core DAX measures planned for the Healthcare Financial BI Analytics portfolio project.

> Dataset note: all values are based on synthetic portfolio data.

## Financial Measures

```DAX
Total Actual =
SUM(FactFinancials[ActualAmount])
```

```DAX
Total Budget =
SUM(FactBudget[BudgetAmount])
```

```DAX
Total Forecast =
SUM(FactForecast[ForecastAmount])
```

```DAX
Budget Variance =
[Total Actual] - [Total Budget]
```

```DAX
Budget Variance % =
DIVIDE(
    [Budget Variance],
    [Total Budget]
)
```

```DAX
Forecast Variance =
[Total Actual] - [Total Forecast]
```

```DAX
Forecast Variance % =
DIVIDE(
    [Forecast Variance],
    [Total Forecast]
)
```

## Revenue & Expense Measures

```DAX
Total Revenue =
CALCULATE(
    [Total Actual],
    DimAccount[AccountType] = "Revenue"
)
```

```DAX
Total Expense =
CALCULATE(
    [Total Actual],
    DimAccount[AccountType] = "Expense"
)
```

```DAX
Operating Margin =
[Total Revenue] - [Total Expense]
```

```DAX
Operating Margin % =
DIVIDE(
    [Operating Margin],
    [Total Revenue]
)
```

## Time Intelligence

```DAX
Prior Month Actual =
CALCULATE(
    [Total Actual],
    DATEADD(
        DimDate[MonthStart],
        -1,
        MONTH
    )
)
```

```DAX
Actual MoM Change =
[Total Actual] - [Prior Month Actual]
```

```DAX
Actual MoM Change % =
DIVIDE(
    [Actual MoM Change],
    [Prior Month Actual]
)
```

```DAX
Prior Year Actual =
CALCULATE(
    [Total Actual],
    DATEADD(
        DimDate[MonthStart],
        -1,
        YEAR
    )
)
```

```DAX
Actual YoY Change % =
DIVIDE(
    [Total Actual] - [Prior Year Actual],
    [Prior Year Actual]
)
```

## Workforce Measures

```DAX
Headcount =
DISTINCTCOUNT(FactHeadcount[EmployeeID])
```

```DAX
Total FTE =
SUM(FactHeadcount[FTE])
```

```DAX
Total Labor Cost =
SUM(FactHeadcount[LaborCost])
```

```DAX
Labor Cost per FTE =
DIVIDE(
    [Total Labor Cost],
    [Total FTE]
)
```

## KPI Status Measures

```DAX
Budget Variance Status =
VAR AccountType =
    SELECTEDVALUE(DimAccount[AccountType])
VAR Variance =
    [Budget Variance]
RETURN
    SWITCH(
        TRUE(),
        AccountType = "Revenue" && Variance >= 0, "Favorable",
        AccountType = "Revenue" && Variance < 0, "Unfavorable",
        AccountType = "Expense" && Variance <= 0, "Favorable",
        AccountType = "Expense" && Variance > 0, "Unfavorable",
        "N/A"
    )
```

```DAX
Budget Variance Color =
SWITCH(
    [Budget Variance Status],
    "Favorable", "#2E8B57",
    "Unfavorable", "#C0392B",
    "#808080"
)
```

## Suggested Dashboard KPIs

- Total Revenue
- Total Expense
- Operating Margin
- Operating Margin %
- Total Budget
- Budget Variance
- Budget Variance %
- Total Forecast
- Forecast Variance
- Headcount
- Total FTE
- Total Labor Cost
- Labor Cost per FTE
- Actual MoM Change %
- Actual YoY Change %

# Data Dictionary

## DimDate
- **DateKey**: YYYYMMDD key for the first day of each month.
- **MonthStart**: Month start date.
- **Year / MonthNumber / MonthName / Quarter / YearQuarter**: Calendar attributes.

## DimDepartment
- **DepartmentID**: Synthetic department key.
- **DepartmentName**: Department label.
- **BusinessUnit**: High-level organizational grouping.

## DimCostCenter
- **CostCenterID**: Synthetic cost center key.
- **CostCenterName**: Cost center label.
- **DepartmentID**: Parent department.

## DimAccount
- **AccountID**: Synthetic financial account key.
- **AccountName**: Financial account label.
- **AccountType**: Revenue or Expense.
- **ExpenseCategoryID**: Expense category mapping where applicable.

## FactFinancials
Monthly actual financial amounts by department, cost center, and account.

## FactBudget
Monthly budget amounts at the same grain as FactFinancials.

## FactForecast
Monthly forecast amounts at the same grain as FactFinancials.

## FactHeadcount
Monthly employee snapshot with synthetic employee IDs, FTE, and loaded labor cost.

> All data is synthetic and created only for portfolio demonstration.

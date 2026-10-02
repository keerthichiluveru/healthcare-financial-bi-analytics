-- Healthcare Financial BI Analytics
-- transformations.sql
-- Synthetic portfolio project
-- Purpose: demonstrate dimensional joins, standardized finance metrics,
--          and a reporting-ready monthly financial view.

-- =========================================================
-- 1. Reporting-ready actual financials
-- =========================================================

WITH actuals AS (
    SELECT
        f.DateKey,
        CAST(f.MonthStart AS DATE) AS MonthStart,
        f.DepartmentID,
        d.DepartmentName,
        d.BusinessUnit,
        f.CostCenterID,
        cc.CostCenterName,
        f.AccountID,
        a.AccountName,
        a.AccountType,
        a.ExpenseCategoryID,
        ec.ExpenseCategoryName,
        CAST(f.ActualAmount AS DECIMAL(18,2)) AS ActualAmount
    FROM FactFinancials f
    INNER JOIN DimDepartment d
        ON f.DepartmentID = d.DepartmentID
    INNER JOIN DimCostCenter cc
        ON f.CostCenterID = cc.CostCenterID
    INNER JOIN DimAccount a
        ON f.AccountID = a.AccountID
    LEFT JOIN DimExpenseCategory ec
        ON a.ExpenseCategoryID = ec.ExpenseCategoryID
)

SELECT *
FROM actuals;


-- =========================================================
-- 2. Combined actual / budget / forecast reporting view
-- =========================================================

WITH financials AS (
    SELECT
        f.DateKey,
        CAST(f.MonthStart AS DATE) AS MonthStart,
        f.DepartmentID,
        f.CostCenterID,
        f.AccountID,
        CAST(f.ActualAmount AS DECIMAL(18,2)) AS ActualAmount
    FROM FactFinancials f
),
budget AS (
    SELECT
        DateKey,
        DepartmentID,
        CostCenterID,
        AccountID,
        CAST(BudgetAmount AS DECIMAL(18,2)) AS BudgetAmount
    FROM FactBudget
),
forecast AS (
    SELECT
        DateKey,
        DepartmentID,
        CostCenterID,
        AccountID,
        CAST(ForecastAmount AS DECIMAL(18,2)) AS ForecastAmount
    FROM FactForecast
)

SELECT
    f.DateKey,
    f.MonthStart,
    f.DepartmentID,
    d.DepartmentName,
    d.BusinessUnit,
    f.CostCenterID,
    cc.CostCenterName,
    f.AccountID,
    a.AccountName,
    a.AccountType,
    ec.ExpenseCategoryName,
    f.ActualAmount,
    b.BudgetAmount,
    fc.ForecastAmount,
    f.ActualAmount - b.BudgetAmount AS BudgetVariance,
    CASE
        WHEN NULLIF(b.BudgetAmount, 0) IS NULL THEN NULL
        ELSE (f.ActualAmount - b.BudgetAmount) / NULLIF(b.BudgetAmount, 0)
    END AS BudgetVariancePct,
    f.ActualAmount - fc.ForecastAmount AS ForecastVariance,
    CASE
        WHEN NULLIF(fc.ForecastAmount, 0) IS NULL THEN NULL
        ELSE (f.ActualAmount - fc.ForecastAmount) / NULLIF(fc.ForecastAmount, 0)
    END AS ForecastVariancePct,
    CASE
        WHEN a.AccountType = 'Revenue'
             AND f.ActualAmount - b.BudgetAmount >= 0 THEN 'Favorable'
        WHEN a.AccountType = 'Revenue'
             AND f.ActualAmount - b.BudgetAmount < 0 THEN 'Unfavorable'
        WHEN a.AccountType = 'Expense'
             AND f.ActualAmount - b.BudgetAmount <= 0 THEN 'Favorable'
        ELSE 'Unfavorable'
    END AS BudgetVarianceStatus
FROM financials f
INNER JOIN budget b
    ON f.DateKey = b.DateKey
   AND f.DepartmentID = b.DepartmentID
   AND f.CostCenterID = b.CostCenterID
   AND f.AccountID = b.AccountID
INNER JOIN forecast fc
    ON f.DateKey = fc.DateKey
   AND f.DepartmentID = fc.DepartmentID
   AND f.CostCenterID = fc.CostCenterID
   AND f.AccountID = fc.AccountID
INNER JOIN DimDepartment d
    ON f.DepartmentID = d.DepartmentID
INNER JOIN DimCostCenter cc
    ON f.CostCenterID = cc.CostCenterID
INNER JOIN DimAccount a
    ON f.AccountID = a.AccountID
LEFT JOIN DimExpenseCategory ec
    ON a.ExpenseCategoryID = ec.ExpenseCategoryID;


-- =========================================================
-- 3. Monthly department summary
-- =========================================================

SELECT
    CAST(f.MonthStart AS DATE) AS MonthStart,
    d.BusinessUnit,
    d.DepartmentName,
    SUM(CASE WHEN a.AccountType = 'Revenue' THEN f.ActualAmount ELSE 0 END) AS TotalRevenue,
    SUM(CASE WHEN a.AccountType = 'Expense' THEN f.ActualAmount ELSE 0 END) AS TotalExpense,
    SUM(CASE WHEN a.AccountType = 'Revenue' THEN f.ActualAmount ELSE 0 END)
      - SUM(CASE WHEN a.AccountType = 'Expense' THEN f.ActualAmount ELSE 0 END) AS OperatingMargin
FROM FactFinancials f
INNER JOIN DimDepartment d
    ON f.DepartmentID = d.DepartmentID
INNER JOIN DimAccount a
    ON f.AccountID = a.AccountID
GROUP BY
    CAST(f.MonthStart AS DATE),
    d.BusinessUnit,
    d.DepartmentName;


-- =========================================================
-- 4. Monthly labor / headcount summary
-- =========================================================

SELECT
    CAST(h.MonthStart AS DATE) AS MonthStart,
    h.DepartmentID,
    d.DepartmentName,
    h.CostCenterID,
    cc.CostCenterName,
    COUNT(DISTINCT h.EmployeeID) AS Headcount,
    SUM(h.FTE) AS TotalFTE,
    SUM(h.LaborCost) AS TotalLaborCost,
    CASE
        WHEN NULLIF(SUM(h.FTE), 0) IS NULL THEN NULL
        ELSE SUM(h.LaborCost) / NULLIF(SUM(h.FTE), 0)
    END AS LaborCostPerFTE
FROM FactHeadcount h
INNER JOIN DimDepartment d
    ON h.DepartmentID = d.DepartmentID
INNER JOIN DimCostCenter cc
    ON h.CostCenterID = cc.CostCenterID
GROUP BY
    CAST(h.MonthStart AS DATE),
    h.DepartmentID,
    d.DepartmentName,
    h.CostCenterID,
    cc.CostCenterName;

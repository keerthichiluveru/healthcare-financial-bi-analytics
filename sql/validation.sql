-- Healthcare Financial BI Analytics
-- validation.sql
-- Synthetic portfolio project
-- Purpose: demonstrate source-to-report validation and data quality checks.

-- =========================================================
-- 1. Duplicate checks at expected financial grain
-- =========================================================

SELECT
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID,
    COUNT(*) AS DuplicateCount
FROM FactFinancials
GROUP BY
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID
HAVING COUNT(*) > 1;


-- =========================================================
-- 2. Budget duplicate checks
-- =========================================================

SELECT
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID,
    COUNT(*) AS DuplicateCount
FROM FactBudget
GROUP BY
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID
HAVING COUNT(*) > 1;


-- =========================================================
-- 3. Forecast duplicate checks
-- =========================================================

SELECT
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID,
    COUNT(*) AS DuplicateCount
FROM FactForecast
GROUP BY
    DateKey,
    DepartmentID,
    CostCenterID,
    AccountID
HAVING COUNT(*) > 1;


-- =========================================================
-- 4. Missing department mappings
-- =========================================================

SELECT DISTINCT f.DepartmentID
FROM FactFinancials f
LEFT JOIN DimDepartment d
    ON f.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NULL;


-- =========================================================
-- 5. Missing cost center mappings
-- =========================================================

SELECT DISTINCT f.CostCenterID
FROM FactFinancials f
LEFT JOIN DimCostCenter cc
    ON f.CostCenterID = cc.CostCenterID
WHERE cc.CostCenterID IS NULL;


-- =========================================================
-- 6. Missing account mappings
-- =========================================================

SELECT DISTINCT f.AccountID
FROM FactFinancials f
LEFT JOIN DimAccount a
    ON f.AccountID = a.AccountID
WHERE a.AccountID IS NULL;


-- =========================================================
-- 7. Cost center / department mismatch
-- =========================================================

SELECT
    f.DepartmentID AS FactDepartmentID,
    f.CostCenterID,
    cc.DepartmentID AS DimensionDepartmentID
FROM FactFinancials f
INNER JOIN DimCostCenter cc
    ON f.CostCenterID = cc.CostCenterID
WHERE f.DepartmentID <> cc.DepartmentID;


-- =========================================================
-- 8. Actual / budget row reconciliation
-- =========================================================

SELECT
    f.DateKey,
    f.DepartmentID,
    f.CostCenterID,
    f.AccountID
FROM FactFinancials f
FULL OUTER JOIN FactBudget b
    ON f.DateKey = b.DateKey
   AND f.DepartmentID = b.DepartmentID
   AND f.CostCenterID = b.CostCenterID
   AND f.AccountID = b.AccountID
WHERE f.DateKey IS NULL
   OR b.DateKey IS NULL;


-- =========================================================
-- 9. Actual / forecast row reconciliation
-- =========================================================

SELECT
    f.DateKey,
    f.DepartmentID,
    f.CostCenterID,
    f.AccountID
FROM FactFinancials f
FULL OUTER JOIN FactForecast fc
    ON f.DateKey = fc.DateKey
   AND f.DepartmentID = fc.DepartmentID
   AND f.CostCenterID = fc.CostCenterID
   AND f.AccountID = fc.AccountID
WHERE f.DateKey IS NULL
   OR fc.DateKey IS NULL;


-- =========================================================
-- 10. Monthly actual totals
-- Use as a source-to-report reconciliation control.
-- =========================================================

SELECT
    MonthStart,
    SUM(ActualAmount) AS TotalActual
FROM FactFinancials
GROUP BY MonthStart
ORDER BY MonthStart;


-- =========================================================
-- 11. Monthly budget totals
-- =========================================================

SELECT
    MonthStart,
    SUM(BudgetAmount) AS TotalBudget
FROM FactBudget
GROUP BY MonthStart
ORDER BY MonthStart;


-- =========================================================
-- 12. Monthly forecast totals
-- =========================================================

SELECT
    MonthStart,
    SUM(ForecastAmount) AS TotalForecast
FROM FactForecast
GROUP BY MonthStart
ORDER BY MonthStart;


-- =========================================================
-- 13. Invalid or missing numeric values
-- =========================================================

SELECT *
FROM FactFinancials
WHERE ActualAmount IS NULL;

SELECT *
FROM FactBudget
WHERE BudgetAmount IS NULL;

SELECT *
FROM FactForecast
WHERE ForecastAmount IS NULL;


-- =========================================================
-- 14. Headcount duplicate employee snapshots
-- =========================================================

SELECT
    DateKey,
    EmployeeID,
    COUNT(*) AS DuplicateCount
FROM FactHeadcount
GROUP BY
    DateKey,
    EmployeeID
HAVING COUNT(*) > 1;


-- =========================================================
-- 15. Headcount mapping checks
-- =========================================================

SELECT DISTINCT h.DepartmentID
FROM FactHeadcount h
LEFT JOIN DimDepartment d
    ON h.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NULL;

SELECT DISTINCT h.CostCenterID
FROM FactHeadcount h
LEFT JOIN DimCostCenter cc
    ON h.CostCenterID = cc.CostCenterID
WHERE cc.CostCenterID IS NULL;


-- =========================================================
-- 16. FTE and labor cost sanity checks
-- =========================================================

SELECT *
FROM FactHeadcount
WHERE FTE <= 0
   OR FTE > 1.5
   OR LaborCost < 0;


-- =========================================================
-- 17. Record counts by table
-- =========================================================

SELECT 'FactFinancials' AS TableName, COUNT(*) AS RowCount FROM FactFinancials
UNION ALL
SELECT 'FactBudget', COUNT(*) FROM FactBudget
UNION ALL
SELECT 'FactForecast', COUNT(*) FROM FactForecast
UNION ALL
SELECT 'FactHeadcount', COUNT(*) FROM FactHeadcount;

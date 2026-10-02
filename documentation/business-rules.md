# Business Rules

1. All financial facts are monthly and use the first day of each month.
2. Revenue and expense values are stored as positive amounts.
3. Operating Margin = Total Revenue - Total Expense.
4. Budget Variance = Actual - Budget.
5. Forecast Variance = Actual - Forecast.
6. Variance interpretation depends on account type:
   - Revenue: positive variance is favorable.
   - Expense: negative variance is favorable.
7. Headcount is calculated as DISTINCTCOUNT(EmployeeID) for the selected month.
8. Labor Cost per FTE = Total Labor Cost / Total FTE.
9. All public data in this project is synthetic and contains no PHI/PII or employer data.

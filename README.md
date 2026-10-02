<div align="center">

# 🏥 Healthcare Financial BI Analytics

### Power BI · Financial Analytics · DAX · SQL · Microsoft Fabric

![Status](https://img.shields.io/badge/Status-In%20Progress-F59E0B?style=for-the-badge)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Fabric](https://img.shields.io/badge/Microsoft%20Fabric-742774?style=for-the-badge&logo=microsoft&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-Analytics-2563EB?style=for-the-badge)

**Independent portfolio project using synthetic healthcare financial data**

</div>

---

## 🎯 Project Overview

This project demonstrates how healthcare financial and operational data can be transformed into a governed Power BI analytics solution supporting executive reporting, financial planning, cost management, workforce analytics, and KPI monitoring.

The project follows an end-to-end BI workflow:

**Raw Data → Transformation → Data Model → DAX → Validation → Dashboard → Business Insight**

### Key Focus Areas

- Executive financial dashboards
- Budgeting and forecasting
- Actual vs. budget analysis
- Forecast variance reporting
- Revenue and expense analytics
- Cost center reporting
- Labor and headcount analytics
- Financial KPI scorecards
- Semantic modeling
- Data validation and reconciliation

---

## 💼 Business Questions

This project is designed to answer questions such as:

- 📊 How are actual expenses performing against budget and forecast?
- 💰 Which cost centers are driving unfavorable variances?
- 📈 How are revenue and operating expenses trending over time?
- 👥 Which departments are contributing most to labor-cost changes?
- 🧑‍💼 How is headcount changing across departments?
- 🚨 Which financial KPIs require management attention?
- 🔄 How do current-period results compare with prior periods?
- 🎯 Where are the largest favorable and unfavorable financial variances?

---

## 📌 Planned Dashboard Pages

### 1. Executive Financial Overview

**KPIs**

- Total Revenue
- Total Operating Expense
- Operating Margin
- Budget Variance
- Forecast Variance
- Revenue Growth
- Expense Growth
- Headcount

**Visuals**

- Actual vs. Budget
- Actual vs. Forecast
- Monthly financial trend
- Revenue and expense trend
- Variance by department
- Executive KPI scorecards

---

### 2. Budget & Variance Analysis

Analysis covering:

- Actual vs. Budget
- Actual vs. Forecast
- Favorable / Unfavorable Variance
- Variance %
- Department-level variance
- Cost-center variance
- Monthly variance trends
- Variance-driver analysis

---

### 3. Cost Center Analysis

Reporting by:

- Department
- Cost Center
- Expense Category
- Month
- Business Unit

Metrics include:

- Actual Spend
- Budget
- Forecast
- Variance
- Variance %
- Share of Total Expense

---

### 4. Labor & Headcount Analytics

Analysis covering:

- Headcount
- FTEs
- Labor Expense
- Average Labor Cost
- Departmental Headcount
- Headcount Change
- Labor Budget Variance
- Workforce Cost Trends

---

### 5. Revenue & Expense Analytics

Analysis covering:

- Revenue trends
- Operating expenses
- SG&A
- Departmental expenses
- Expense mix
- Period-over-period changes
- Revenue vs. expense performance

---

## 🧱 Data Model

The project uses a star-schema approach to support scalable and governed financial reporting.

### Fact Tables

- `FactFinancials`
- `FactBudget`
- `FactForecast`
- `FactHeadcount`

### Dimension Tables

- `DimDate`
- `DimDepartment`
- `DimCostCenter`
- `DimAccount`
- `DimExpenseCategory`

### Conceptual Architecture

```text
                     DimDate
                        |
                        |
DimDepartment -- FactFinancials -- DimAccount
      |                 |
      |                 |
DimCostCenter       DimExpenseCategory

       FactBudget
            |
       FactForecast
            |
      FactHeadcount
```

---

## 🧮 Example DAX Measures

```DAX
Total Actual =
SUM(FactFinancials[ActualAmount])
```

```DAX
Total Budget =
SUM(FactBudget[BudgetAmount])
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
Total Forecast =
SUM(FactForecast[ForecastAmount])
```

```DAX
Forecast Variance =
[Total Actual] - [Total Forecast]
```

```DAX
Headcount =
DISTINCTCOUNT(FactHeadcount[EmployeeID])
```

```DAX
Labor Cost per FTE =
DIVIDE(
    [Total Labor Cost],
    [Headcount]
)
```

---

## ⚙️ Data Engineering & Transformation

Planned data preparation includes:

- Data-type standardization
- Null-value handling
- Duplicate detection
- Account mapping
- Cost-center mapping
- Date standardization
- Budget/actual reconciliation
- Financial hierarchy creation
- Department mapping
- Data-quality validation
- Source-to-report reconciliation

### Tools

![SQL](https://img.shields.io/badge/SQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Power Query](https://img.shields.io/badge/Power%20Query-Transformation-217346?style=flat-square)
![Fabric](https://img.shields.io/badge/Microsoft%20Fabric-742774?style=flat-square&logo=microsoft&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)

---

## ✅ Validation

Financial reporting will include validation checks such as:

- Actual totals reconcile to source data
- Budget totals reconcile to budget source
- Forecast totals reconcile to forecast source
- Department totals reconcile to enterprise totals
- Cost-center mappings are complete
- Duplicate financial transactions are identified
- Missing account mappings are flagged
- Percentage measures handle zero denominators correctly
- Date relationships behave correctly
- Headcount totals reconcile to source records

---

## 🛠️ Technology Stack

### Business Intelligence

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-Advanced-2563EB?style=flat-square)
![Power Query](https://img.shields.io/badge/Power%20Query-Data%20Transformation-217346?style=flat-square)

### Data & Engineering

![SQL](https://img.shields.io/badge/SQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Azure](https://img.shields.io/badge/Azure-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=flat-square&logo=databricks&logoColor=white)

### Analytics Architecture

![Fabric](https://img.shields.io/badge/Microsoft%20Fabric-742774?style=flat-square&logo=microsoft&logoColor=white)
![Semantic Models](https://img.shields.io/badge/Semantic%20Models-Governed%20BI-purple?style=flat-square)
![Star Schema](https://img.shields.io/badge/Star%20Schema-Dimensional%20Modeling-orange?style=flat-square)

---

## 📁 Repository Structure

```text
healthcare-financial-bi-analytics/
│
├── README.md
│
├── data/
│   ├── raw/
│   └── processed/
│
├── sql/
│   ├── transformations.sql
│   └── validation.sql
│
├── dax/
│   └── measures.md
│
├── documentation/
│   ├── data-dictionary.md
│   └── business-rules.md
│
├── screenshots/
│   ├── executive-overview.png
│   ├── variance-analysis.png
│   └── headcount-analysis.png
│
└── power-bi/
    └── healthcare-financial-analytics.pbix
```

---

## 🚀 Skills Demonstrated

![Financial Analytics](https://img.shields.io/badge/Financial%20Analytics-Executive%20Reporting-blue?style=flat-square)
![Forecasting](https://img.shields.io/badge/Forecasting-Planning-green?style=flat-square)
![Variance Analysis](https://img.shields.io/badge/Variance%20Analysis-Financial%20Performance-orange?style=flat-square)
![Semantic Modeling](https://img.shields.io/badge/Semantic%20Modeling-Enterprise%20BI-purple?style=flat-square)

- Financial Analytics
- Budgeting & Forecasting
- Variance Analysis
- Cost Center Reporting
- Labor & Headcount Analytics
- Power BI Development
- Advanced DAX
- Power Query
- SQL
- Semantic Modeling
- Star Schema
- Microsoft Fabric
- Data Validation
- Data Reconciliation
- Executive Dashboard Design

---

## 🔐 Portfolio Data Policy

This project uses synthetic data created specifically for portfolio demonstration.

No confidential employer, customer, healthcare-member, financial, production, or personally identifiable information is included.

---

## 🧭 Project Roadmap

- [ ] Create synthetic healthcare financial dataset
- [ ] Build star-schema data model
- [ ] Develop SQL transformation logic
- [ ] Create DAX measure library
- [ ] Build executive overview dashboard
- [ ] Build budget and variance dashboard
- [ ] Build cost-center dashboard
- [ ] Build labor/headcount dashboard
- [ ] Complete validation and reconciliation
- [ ] Add dashboard screenshots
- [ ] Publish final project documentation

---

## 📊 Final Deliverables

When completed, this repository will include:

- Power BI dashboard
- Synthetic source datasets
- SQL transformation scripts
- SQL validation scripts
- DAX measure library
- Data dictionary
- Business rules
- Data model documentation
- Dashboard screenshots
- Validation checks
- Executive analytics case study

---

<div align="center">

### Turning healthcare financial data into reliable executive insight.

**Power BI · Financial Analytics · SQL · DAX · Microsoft Fabric**

</div>

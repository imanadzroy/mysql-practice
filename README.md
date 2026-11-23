# MySQL Practice

A structured record of my SQL learning with MySQL, from fundamentals to advanced
queries, plus two hands-on analysis projects on real-world layoffs data.

## 📂 Structure
| Folder | Contents |
|---|---|
| [`01-beginner`](01-beginner) | Database setup (Parks and Rec), SELECT, WHERE and LIKE, GROUP BY and ORDER BY, HAVING vs WHERE, LIMIT and aliasing |
| [`02-intermediate`](02-intermediate) | Joins, UNION, string functions, CASE statements, subqueries, window functions |
| [`03-advanced`](03-advanced) | CTEs, temporary tables, stored procedures, triggers and events |
| [`projects`](projects) | End-to-end data cleaning and analysis projects |
| [`practice`](practice) | Extra practice queries |

## 📊 Projects

### 1. Data Cleaning
- **File:** [`01-data-cleaning.sql`](projects/01-data-cleaning.sql)
- **Dataset:** [Layoffs 2022 (Kaggle)](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- **Techniques:** staging tables, CTEs, `ROW_NUMBER()`, self-joins, `STR_TO_DATE`
- **What I did:**
  - Worked on a staging copy to keep the raw data untouched
  - Removed duplicate rows using `ROW_NUMBER()` with `PARTITION BY` in a CTE
  - Standardised data: trimmed company names, merged `Crypto` industry variants
  - Converted `date`, `date_added` and `total_laid_off` to proper data types
  - Turned `'NULL'` and blank strings into real `NULL` values
  - Filled missing industries by self-joining on company
  - Deleted rows with no layoff figures (both total and percentage `NULL`)
  - Dropped the helper `row_num` column

### 2. Exploratory Data Analysis
- **File:** [`02-exploratory-data-analysis.sql`](projects/02-exploratory-data-analysis.sql)
- **Dataset:** [Layoffs 2022 (Kaggle)](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- **Techniques:** CTEs, window functions (rolling total, `DENSE_RANK`), `PARTITION BY`
- **Key findings:**
  - Layoffs spiked at the start of COVID (25,271 in April 2020), then fell to just 15,810 in 2021.
  - The largest wave ran from November 2022 to early 2023: January 2023 was the peak month (70,935), and 2023 the peak year (215,065).
  - Layoffs continued but eased: yearly totals fell from 128,592 (2024) to 107,593 (2025).
  - Amazon ranked in the top 3 companies by layoffs in four of the five years from 2022 to 2026, and was #1 in 2023 and 2026.

*Note: 2026 data covers January to November.*

## 🛠️ Tools
MySQL · MySQL Workbench

## 👤 Author
Iman Adzroy · [LinkedIn](https://www.linkedin.com/in/imanadzroy)

## 📄 License
MIT

-- SQL Practical Assessment 2

WITH Example1 AS (
	SELECT company, industry, SUM(total_laid_off) AS total_layoffs
	FROM layoffs_staging2
	WHERE industry IS NOT NULL
    AND total_laid_off IS NOT NULL
    AND YEAR(`date`) = 2023
    GROUP BY company, industry
), Example2 AS (
	SELECT *,
	RANK() OVER(
		PARTITION BY industry
        ORDER BY total_layoffs DESC
    ) AS industry_rank
    FROM Example1
)
SELECT *
FROM Example2
WHERE industry_rank <= 3
ORDER BY industry, industry_rank;




























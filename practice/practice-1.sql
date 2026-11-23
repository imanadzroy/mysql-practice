-- SQL Practical Assessment

SELECT *
FROM layoffs_staging2
WHERE total_laid_off > 1000
ORDER BY total_laid_off DESC;

SELECT company, COUNT(*) AS total_records
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
HAVING total_layoffs > 500
ORDER BY 2 DESC;

SELECT company, COUNT(*), MAX(total_laid_off), MIN(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 3 DESC;

SELECT country, SUM(total_laid_off) AS total_layoff, COUNT(*) AS total_records
FROM layoffs_staging2
GROUP BY country
HAVING total_layoff > 1000
ORDER BY total_layoff DESC;

SELECT industry, country, SUM(total_laid_off) AS total_layoff, COUNT(*) AS total_records
FROM layoffs_staging2
GROUP BY industry, country
HAVING total_layoff > 500
ORDER BY total_layoff DESC;

SELECT YEAR(`date`) AS layoff_year, SUM(total_laid_off) AS total_layoff, COUNT(*) AS total_records
FROM layoffs_staging2
GROUP BY layoff_year
ORDER BY layoff_year ASC;

SELECT company, YEAR(`date`) AS layoff_year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) = 2022
GROUP BY company, layoff_year
ORDER BY total_laid_off DESC;

SELECT company, YEAR(`date`) AS layoff_year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) = 2022
GROUP BY company, layoff_year
HAVING total_laid_off > 500
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
HAVING total_laid_off > 1000
ORDER BY total_laid_off DESC
LIMIT 5;

SELECT company, SUM(total_laid_off) AS total_laid_off, COUNT(*) AS total_records
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC
LIMIT 5 OFFSET 5;

SELECT company, SUM(total_laid_off) AS total_laid_off,
CASE 
	WHEN SUM(total_laid_off) > 5000 THEN 'High'
    WHEN SUM(total_laid_off) BETWEEN 1000 AND 5000 THEN 'Medium'
    ELSE 'Low'
END AS layoff_category
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
HAVING SUM(total_laid_off) > (
	SELECT AVG(total_laid_off)
	FROM (SELECT SUM(total_laid_off) AS total_laid_off
		FROM layoffs_staging2
		GROUP BY company
        ) AS company_totals
	)
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off,
	(
	SELECT AVG(total_laid_off)
	FROM (
		SELECT SUM(total_laid_off) AS total_laid_off
		FROM layoffs_staging2
		GROUP BY company
        ) AS company_total
	) AS avg_total
FROM layoffs_staging2
GROUP BY company
HAVING SUM(total_laid_off) > (
	SELECT AVG(total_laid_off)
    FROM (
		SELECT SUM(total_laid_off) AS total_laid_off
		FROM layoffs_staging2
		GROUP BY company
        ) AS company_total
	)
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off,
	(
	SELECT AVG(company_total)
	FROM (
		SELECT SUM(total_laid_off) AS company_total
		FROM layoffs_staging2
		GROUP BY company
        ) AS company_summary
	) AS avg_total, 
    SUM(total_laid_off) / (
		SELECT AVG(company_total)
		FROM (
			SELECT SUM(total_laid_off) AS company_total
			FROM layoffs_staging2
			GROUP BY company
			) AS company_summary
		) * 100 AS percentage_avg
FROM layoffs_staging2
GROUP BY company
HAVING avg_total < SUM(total_laid_off)
ORDER BY percentage_avg DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE company IN (
	SELECT company
    FROM layoffs_staging2
    WHERE YEAR(`date`) = 2023
    )
GROUP BY company
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) = 2022
AND company NOT IN (
	SELECT company
    FROM layoffs_staging2
    WHERE YEAR(`date`) = 2023
    )
GROUP BY company
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off, industry
FROM layoffs_staging2
WHERE industry = 'Marketing'
AND YEAR(`date`) = 2023
AND company IN (
	SELECT company
    FROM layoffs_staging2
    WHERE YEAR(`date`) = 2023
    )
GROUP BY company
HAVING SUM(total_laid_off) < 1000
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off,
( SELECT AVG(company_total)
	FROM (
		SELECT SUM(total_laid_off) AS company_total
		FROM layoffs_staging2
        WHERE YEAR(`date`) = 2023
		GROUP BY company
        ) AS company_summary
) AS avg_total
FROM layoffs_staging2
WHERE YEAR(`date`) = 2023
GROUP BY company
HAVING avg_total < SUM(total_laid_off)
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) AS total_laid_off,
(
	SELECT AVG(sum_total)
    FROM (
		SELECT SUM(total_laid_off) AS sum_total
        FROM layoffs_staging2
        WHERE YEAR(`date`) = 2022
        GROUP BY company
        ) AS sum_total
) AS avg_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) = 2022
GROUP BY company
HAVING SUM(total_laid_off) > avg_laid_off
ORDER BY 2 DESC
;

SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(`date`) = 2023
GROUP BY company
HAVING total_laid_off > (
    SELECT AVG(sum_total)
    FROM (
		SELECT SUM(total_laid_off) AS sum_total
        FROM layoffs_staging2
        WHERE YEAR(`date`) = 2022
        GROUP BY company
        ) AS sum_total
	)
ORDER BY 2 DESC;

SELECT company, industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2 AS main
WHERE industry IS NOT NULL 
GROUP BY company, industry
HAVING total_laid_off > (
	SELECT AVG(company_total)
    FROM (
		SELECT industry, company, SUM(total_laid_off) AS company_total
		FROM layoffs_staging2
        WHERE industry IS NOT NULL
        GROUP BY company, industry
        ) AS industry_sum 
	WHERE industry_sum.industry = main.industry
)
ORDER BY industry, total_laid_off DESC
;




















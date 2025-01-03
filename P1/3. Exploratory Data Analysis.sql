-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT *
FROM layoffs_staging2;





SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;


WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;




WITH Company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
;


WITH RankedData AS (
    SELECT 
        company,
        `date`,
        total_laid_off,
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY total_laid_off DESC) AS `Rank`
    FROM layoffs_staging2
	WHERE total_laid_off IS NOT NULL
)
SELECT company, `date`, total_laid_off
FROM RankedData
WHERE `Rank` = 1
ORDER BY 3 DESC;


SELECT 
    l.company, 
    l.`date`, 
    l.total_laid_off
FROM layoffs_staging2 l
JOIN (
    SELECT 
        company, 
        MAX(total_laid_off) AS Max_Laid_Off
    FROM layoffs_staging2
    WHERE total_laid_off IS NOT NULL AND company = 'Zymergen'
    GROUP BY company
) Max_Data
ON l.company = Max_Data.company AND l.total_laid_off = Max_Data.Max_Laid_Off
ORDER BY 3 DESC;



WITH Industry_Ranking AS
(
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND industry IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC
)
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM Industry_Ranking;

WITH Industry_Ranking AS
(
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND industry IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC
), Specific_Ranking AS
(
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM Industry_Ranking
)
SELECT *
FROM Specific_Ranking
ORDER BY 3 ASC
LIMIT 3;


WITH Industry_Ranking AS
(
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND industry IS NOT NULL
GROUP BY industry
ORDER BY 2 DESC
), Specific_Ranking AS
(
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM Industry_Ranking
)
SELECT *
FROM Specific_Ranking
WHERE industry = 'Healthcare' OR industry = 'Crypto' OR industry = 'Retail'
ORDER BY 3 ASC;


WITH location_Ranking AS
(
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND location IS NOT NULL
GROUP BY location
ORDER BY 2 DESC
), Specific_Ranking AS
(
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM location_Ranking
)
SELECT *
FROM Specific_Ranking
WHERE location = 'SF Bay Area' OR location = 'Sao Paulo'
ORDER BY 3 ASC;


WITH location_Ranking AS
(
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND location IS NOT NULL
GROUP BY location
ORDER BY 2 DESC
), Specific_Ranking AS
(
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM location_Ranking
)
SELECT *
FROM Specific_Ranking
ORDER BY 3 ASC
LIMIT 3;

WITH location_Ranking AS
(
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND location IS NOT NULL
GROUP BY location
ORDER BY 2 DESC
)
SELECT *, ROW_NUMBER() OVER() AS `Rank`
FROM location_Ranking;






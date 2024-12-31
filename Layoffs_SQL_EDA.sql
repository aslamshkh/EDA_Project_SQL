-- MySQL EDA (Exploratory Data Analysis)
USE world_layoffs;


SELECT * 
FROM layoffs_staging2;

-- Lets find out the the maximum number of laidoffS
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Lets find out which company had the heighest laidoffs
SELECT MAX(company), MAX(total_laid_off)
from layoffs_staging2;

-- Lets find out which undustry had the maximum laidoff
SELECT MAX(total_laid_off), MAX(industry)
FROM layoffs_staging2;

-- Lets find out that which country had the most laidoffs
SELECT MAX(total_laid_off), MAX(country)
FROM layoffs_staging2;


-- Lets find out what was the minimum laidoffs
SELECT MIN(total_laid_off)
FROM layoffs_staging2;

-- Lets find out which company had the lowest laidoff
SELECT MIN(company), MIN(total_laid_off)
FROM layoffs_staging2;

-- Lets find out which industry had the minimum layoff
SELECT MIN(industry), MIN(total_laid_off)
FROM layoffs_staging2;

-- Lets find out which country has the least layoffs
SELECT MIN(total_laid_off), MIN(country)
FROM layoffs_staging2;

-- Lets find out which company laid off 100% of the employees
SELECT MAX(company), MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Lets find out which the list of companies that laidoff their staff completly
SELECT company, total_laid_off, percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1 AND total_laid_off IS NOT NULL
ORDER BY 2 DESC;

-- Lets find out all the companies that went out completely in decending order
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Lets find out over all laid offs based on dates in ascending order
SELECT *
FROM layoffs_staging2
ORDER BY `date` ASC;

-- Lets find out the list of the companies with the total laid off from max to min
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Lets find out the industries with the overall laid off from max to min
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Lets find the list of countries with the laid off from max to min
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Lets find out the date range for these layoffs
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Lets find out the layoffs based on year
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`) 
ORDER BY 1 DESC;

-- Lets find out layoffs based on months
SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 1;

-- Lets filter the same data without null values
SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,6,2) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

-- Lets add years alogn with the month to the same data
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

-- Lets find out the progression of layoffs by using rolling function
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_laidoff
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 
)
SELECT `MONTH`, SUM(total_laidoff) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Lets add total_laid_off column as well to see how many were added each month
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_laidoff
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 
)
SELECT `MONTH`, total_laidoff, SUM(total_laidoff) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

# Exploratory Data Analysis

## The table of contents

- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Data Preparation](#data-preparation)
- [Data Cleansing](#data-cleansing)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Code Body](#code-body)


### Project Overview

This EDA project aims to find out about the mass layoffs happend during covid. The project tries to answer from layff numbers to the country impacted. 

### Data Source

The dataset used for the project has been taken from a GitHub repositry showcasing the drasting layoff duering the Pandemic. The raw data consited 2361 rows in total which came down to 1995 rows after cleanign the data. The data has details on Companies, Industries, Location, and Countires mass layoff.

### Data Preparation

The raw data (CSV) file was uploaded directly to the workbench without making any changes at the innitial stage. Later, the data was cleansed and made available for EDA. The data cleaning process could be checked [here.](https://github.com/aslamshkh/Data_Cleansing_Project_SQL)

#### Data Cleansing

* Data loading and inspection
* Handling missing volume
* Data cleaning and formatting

### Exploratory Data Analysis

#### EDA involves data exploration to understand and answer the key questions.

1. What was the heighest layoff in a day?
2. Which company had the most layoffs?
3. Which industry was highly impacted?
4. Which country had the heighest layoff in a day?

5. What was the lowest number of layoffs?
6. Which company had the lowest layoffs?
7. Which industry was least impacted?
8. Which country had the lowest number of layoffs?

9. Which all companies had 100% layoffs?
10. What was the date range for these layoffs?
11. What was the total layoff per year?
12. What was the total layoff per month?

13. What was the progression of layoff?

### Code Body

**1. What was the heighest layoff in a day?**
```sql
SELECT MAX(total_laid_off)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/dd262210-fdaf-4bdf-9d87-1f21f140669d)



**2. Which company had the most layoffs?**
```sql
SELECT MAX(company), MAX(total_laid_off)
from layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/efbe02d1-8fbc-4d99-a0b1-a3cb5b20002e)


**3. Which industry was highly impacted?**
```sql
SELECT MAX(total_laid_off), MAX(industry)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/893ecaa3-9791-48e9-810e-98c7474a3270)


**4. Which country had the heighest layoff in a day?**
```sql   
SELECT MAX(total_laid_off), MAX(country)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/3e896dbd-00c8-41d1-af2e-f06139f313e5)


**5. What was the lowest number of layoffs?**
```sql
SELECT MIN(total_laid_off)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/226fb991-eaac-45d6-8082-9106f435999e)


**6. Which company had the lowest layoffs?**
```sql
SELECT MIN(company), MIN(total_laid_off)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/5b4b3306-66d4-4364-86fd-93f2f0ac60d1)


**7. Which industry was least impacted?**
```sql
SELECT MIN(industry), MIN(total_laid_off)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/ecef8370-962d-47d6-83ea-644e5ecf0a77)


**8. Which country had the lowest number of layoffs?**
```sql
SELECT MIN(total_laid_off), MIN(country)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/32eabea7-9f39-4fa0-81dd-efec9154f29a)


**9. Which all companies had 100% layoffs?**
```sql
SELECT company, total_laid_off, percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1 AND total_laid_off IS NOT NULL
ORDER BY 2 DESC;
```
![image](https://github.com/user-attachments/assets/eef6d5b4-b62c-414e-8243-78b59f31775b)


**10. What was the date range for these layoffs?**
```sql
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;
```
![image](https://github.com/user-attachments/assets/4ded54f3-b49c-4951-8101-1863ff581cf1)


**11. What was the total layoff per year?**
```sql
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`) 
ORDER BY 1 DESC;
```
![image](https://github.com/user-attachments/assets/1492fd81-5cf1-4ee8-9025-6c3792e43550)


**12. What was the total layoff per month?**
```sql
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;
```
![image](https://github.com/user-attachments/assets/9a3dde58-3bc0-4f0c-81f7-690663e3b8a6)


**13. What was the progression of layoff?**
```sql
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
```
![image](https://github.com/user-attachments/assets/37e16502-43c4-48f2-9d84-36f0cfb81e5d)



> [!NOTE]
> The full coding details can be found on the SQL file attached to the repositry. Some of null values not been removed from certain columns as the other information in the row found to be usfull for EDA.

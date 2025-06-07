-- EDA

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers

-- normally when you start the EDA process you have some idea of what you're looking for

-- with this info we are just going to look around and see what we find!

select *
from layoffs_staging3;


select max(total_laid_off)
from layoffs_staging3;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging3;

select *
from layoffs_staging3
order by total_laid_off desc;

select *
from layoffs_staging3
order by funds_raised_millions desc;


-- SOMEWHAT TOUGHER AND MOSTLY USING GROUP BY--------------------------------------------------------------------------------------------------

-- Companies with the biggest single Layoff

select company, total_laid_off
from layoffs_staging3
order by 2 desc
limit 5;

select company, sum(total_laid_off)
from layoffs_staging3
group by company
order by 2 desc; 

select min(`date`), max(`date`)
from layoffs_staging3;

select industry, sum(total_laid_off)
from layoffs_staging3
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging3
group by country
order by 2 desc;

select year(`date`), sum(total_laid_off)
from layoffs_staging3
group by year(`date`)
order by 1 desc;

select substring(`date`,1,7)as `month`, sum(total_laid_off)
from layoffs_staging3
group by `month`
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging3
group by stage
order by 2 desc;


-- Looking at Percentage to see how big these layoffs were

select min(percentage_laid_off), max(percentage_laid_off)
from layoffs_staging3
where percentage_laid_off is not null;

select *
from layoffs_staging3
where percentage_laid_off = 1;



select *
from layoffs_staging3
where percentage_laid_off = 1
order by funds_raised_millions;



-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 


with company_year as
(
select company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
from layoffs_staging3
group by company , years
)
,company_year_rank as
(
select company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
from company_year
)
select company, years, total_laid_off, ranking
from company_year_rank
where ranking <= 3
and years is not null
order by years ASC, total_laid_off DESC;


-- Rolling Total of Layoffs Per Month


select substring(`date`,1,7)as `month`, sum(total_laid_off)
from layoffs_staging3
group by `month`
order by 1 desc;

-- now use it in a CTE so we can query off of it

with  data_cte  as
(
select substring(`date`,1,7)as `month`, sum(total_laid_off) as total_laid_off
from layoffs_staging3
group by `month`
order by 1 desc
)
select `month`, SUM(total_laid_off) OVER (ORDER BY `month` ASC) as rolling_total_layoffs
from data_cte
order by `month` asc;

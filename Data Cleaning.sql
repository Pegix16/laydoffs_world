select * 
from layoffs_staging1;

-- data cleaning

create table layoffs_staging2
like layoffs_staging1;


insert layoffs_staging2
select * from layoffs_staging1;

select *
from layoffs_staging2;

-- removing duplicate

select company, industry, total_laid_off, `date`, row_number() over(partition by company, industry, total_laid_off, `date`) as row_num
from layoffs_staging2;




select *
from (
	select company, industry, 
    total_laid_off, `date`, 
    row_number() over(partition by company, industry, total_laid_off, `date`) as row_num
	from layoffs_staging2) duplicates
where row_num > 1;


with duplicate_cte as 
(
	select *
	from (
		select company, industry, 
		total_laid_off, `date`, 
		row_number() over(partition by company, industry, total_laid_off, `date`) as row_num
		from layoffs_staging2) duplicates
		where row_num > 1
)
select *
from duplicate_cte;

CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging3;

insert into layoffs_staging3
select *,
row_number() over(partition by company, industry, total_laid_off, `date`) as row_num
from layoffs_staging2;

    
delete
from layoffs_staging3
where row_num > 1;


select *
from layoffs_staging3;


-- standardizing data



select company, trim(company)
from layoffs_staging3;

SET SQL_SAFE_UPDATES = 0;


update layoffs_staging3
set company = trim(company);

select distinct industry
from layoffs_staging3
order by 1;


select industry
from layoffs_staging3
where industry like 'airbnb%';

select *
from layoffs_staging3
where industry like 'Crypto%';

update layoffs_staging3
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoffs_staging3
where industry like 'Crypto%';


select distinct country
from layoffs_staging1
order by 1;

select distinct country
from layoffs_staging3
where country like 'United States%';

update layoffs_staging3
set country = trim(trailing '.' from country);

update layoffs_staging3
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging3
modify column `date` date;

select *
from layoffs_staging3;


-- null

select *
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

select industry
from layoffs_staging3
where industry is null
or industry = '';

update layoffs_staging3
set industry = null
where industry = '';

select *
from layoffs_staging3
where industry is null;

update layoffs_staging3 t1
join layoffs_staging3 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging3
where industry is null;

select industry
from layoffs_staging3
where industry like 'Bally%';


select *
from layoffs_staging3;

-- remove any columns and rows we need to

select *
from layoffs_staging3
where total_laid_off is null;

select *
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging3;

alter table layoffs_staging3
drop column row_num;

select *
from layoffs_staging3;



# laydoffs_world
📊 Tech Layoffs SQL Project
This project focuses on cleaning and exploring a dataset of tech layoffs using MySQL. The dataset comes from a CSV file (layoffs.csv) and is processed step-by-step using SQL queries to transform, clean, and analyze the data.

🧹 Part 1: Data Cleaning (Data Cleaning.sql)
We cleaned the raw data through several steps:

✅ Loaded the data into a staging table (layoffs_staging1)

🔄 Removed duplicate rows using ROW_NUMBER() window function

🧼 Standardized data:

Trimmed whitespace in company, country, and industry

Standardized industry labels (e.g., "Crypto" variations)

Fixed country names (e.g., removing trailing dots)

Converted date strings to DATE format using STR_TO_DATE()

🧩 Handled missing values:

Refilled missing industry values using self-join logic

Deleted rows where both total_laid_off and percentage_laid_off were null

🧽 Dropped unnecessary columns (e.g., row_num used for de-duplication)

Final cleaned data was saved in a new table: layoffs_staging3

📈 Part 2: Exploratory Data Analysis (EDA.sql)
We analyzed the cleaned data to uncover insights:

🔹 Basic Stats & Sorting
Max layoffs (total_laid_off) and percentage_laid_off

Companies or industries with the largest layoffs

Top funding rounds vs layoff sizes

🔹 Aggregations
Layoffs by:

Company

Industry

Country

Year

Month

Funding Stage

🔹 Window Functions
Top 3 companies with most layoffs per year using DENSE_RANK()

Rolling total layoffs over time with a CTE and SUM() OVER (...)

📁 Files Included
File Name	Description
layoffs.csv	Raw dataset containing tech layoff information
Data Cleaning.sql	SQL script for data cleaning and transformation
EDA.sql	SQL script for exploring and analyzing cleaned data

🛠️ Technologies Used
MySQL

SQL Features: CTE, ROW_NUMBER, DENSE_RANK, JOIN, GROUP BY, WINDOW FUNCTIONS

📚 Key Learnings
Effective use of SQL for ETL (Extract, Transform, Load)

Handling messy real-world data with SQL techniques

Gaining business insights using SQL analytics

🚀 How to Run
Import layoffs.csv into MySQL as layoffs_staging1

Run Data Cleaning.sql to clean and transform the data into layoffs_staging3

Run EDA.sql to explore trends and generate insights

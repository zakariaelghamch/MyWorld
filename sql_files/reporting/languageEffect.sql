set colsep ,
set heading on
set echo off
set feedback off
set pagesize 0
SPOOL 'C:\Users\zakariaElghamch\Downloads\WISD\S3_2021\Data_Warehouse\project\sql_files\reporting\languageEffect.csv'
select language ,nbr_skills_immigrants,nbr_industries_immigrants FROM (select s.language AS language ,s.nbr_skills_immigrants,i.nbr_industries_immigrants
from (select c.language AS language,ABS(SUM(s.nbr)) AS nbr_skills_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   INDUSTRY_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code 
GROUP BY c.language) s,
(select c.language AS language,ABS(SUM(s.nbr)) AS nbr_industries_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   SKILL_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code 
GROUP BY c.language) i
where s.language =i.language  
ORDER BY s.nbr_skills_immigrants+i.nbr_industries_immigrants DESC)
WHERE rownum<=20;

set colsep " "
SPOOL OFF;
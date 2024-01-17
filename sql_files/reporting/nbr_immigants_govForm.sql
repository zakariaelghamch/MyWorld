set colsep ,
set heading on
set echo off
set feedback off
set pagesize 0
set linesize 300

SPOOL 'C:\Users\zakariaElghamch\Downloads\WISD\S3_2021\Data_Warehouse\project\sql_files\reporting\nbr_imgrts__GOVERNMENTFORM.csv'
select s.GOVERNMENTFORM AS GOVERNMENTFORM ,s.nbr_skills_immigrants,i.nbr_industries_immigrants
from (select c.GOVERNMENTFORM AS GOVERNMENTFORM,ABS(SUM(s.nbr)) AS nbr_skills_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   INDUSTRY_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code 
GROUP BY c.GOVERNMENTFORM) s,
(select c.GOVERNMENTFORM AS GOVERNMENTFORM,ABS(SUM(s.nbr)) AS nbr_industries_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   SKILL_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code 
GROUP BY c.GOVERNMENTFORM) i
where s.GOVERNMENTFORM =i.GOVERNMENTFORM 
ORDER BY s.nbr_skills_immigrants+i.nbr_industries_immigrants DESC;
set colsep "  "
set feedback ON
SPOOL OFF;
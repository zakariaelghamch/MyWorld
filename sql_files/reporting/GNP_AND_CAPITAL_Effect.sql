set colsep ,
set headsep off
set echo off
set feedback off
SPOOL 'C:\Users\zakariaElghamch\Downloads\WISD\S3_2021\Data_Warehouse\project\sql_files\reporting\GNP_AND_CAPITAL_Effect.csv'
select s.CAPITAL,s.GNP AS GNP,s.nbr_skills_immigrants,i.nbr_industries_immigrants
from (select c.CAPITAL,c.GNP AS GNP,ABS(s.nbr) AS nbr_skills_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   INDUSTRY_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code ) s,
(select c.CAPITAL,c.GNP AS GNP,ABS(s.nbr) AS nbr_industries_immigrants from (select c.code AS code,s.somme AS nbr FROM (select country_code,sum(NBR_MGTS) AS somme from immigration where NBR_MGTS<0 AND   SKILL_MIGRATION_ID=0 GROUP BY country_code) s,dw_country c where s.country_code = LOWER(c.code) ) s,dw_country c
where c.code=s.code ) i
where s.GNP =i.GNP ;
set colsep " "
set echo off;
SPOOL OFF;
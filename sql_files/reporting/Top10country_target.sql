set colsep ,
set heading on
set echo off
set feedback off
set pagesize 0
set linesize 100

SPOOL 'C:\Users\zakariaElghamch\Downloads\WISD\S3_2021\Data_Warehouse\project\sql_files\reporting\Top10country_target.csv'
 select name,nmrImmirants  from (select name,nmrImmirants  from (select c.name,i.nmrImmirants from (select country_code,sum(NBR_MGTS) AS nmrImmirants from immigration where SKILL_MIGRATION_ID <>0 group by country_code ) i, dw_country c
where i.country_code=lower(c.code))  
order by nmrImmirants DESC )
where rownum<=10;

set colsep "  "
set feedback ON
SPOOL OFF;
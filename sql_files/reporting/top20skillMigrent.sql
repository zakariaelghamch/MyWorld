set colsep ,
set heading on
set echo off
set feedback off
set pagesize 0
set linesize 300

SPOOL 'C:\Users\zakariaElghamch\Downloads\WISD\S3_2021\Data_Warehouse\project\sql_files\reporting\top20skillsMigrent.csv'
 select SKILL_GROUP_NAME,nmrImmirants  from (select SKILL_GROUP_NAME,nmrImmirants  from (select c.SKILL_GROUP_NAME,i.nmrImmirants from (select SKILL_MIGRATION_ID,sum(NBR_MGTS) AS nmrImmirants from immigration where SKILL_MIGRATION_ID <>0 group by SKILL_MIGRATION_ID ) i, dw_SKILL_MIGRATION c
where i.SKILL_MIGRATION_ID=lower(c.SKILL_GROUP_ID))  
order by nmrImmirants DESC) 
where rownum<=20;

set colsep "  "
set feedback ON
SPOOL OFF;
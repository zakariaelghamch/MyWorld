CREATE OR REPLACE DIRECTORY csv_files AS 'C:/Users/zakariaElghamch/Downloads/WISD/S3_2021/Data_Warehouse/project/csv_files';
CREATE OR REPLACE DIRECTORY log_files AS 'C:/Users/zakariaElghamch/Downloads/WISD/S3_2021/Data_Warehouse/project/log_files';
 /
CREATE   TABLE I_bde_skill_migration (
CODE  VARCHAR(3),
NAME VARCHAR(100) ,
skill_group_id NUMBER(5),
skill_group_category VARCHAR(100),
skill_group_name VARCHAR(60),
nbr_migrants_x_10K FLOAT(4) )
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY csv_files
ACCESS PARAMETERS
 (
RECORDS DELIMITED BY newline
SKIP 1
CHARACTERSET UTF8
BADFILE log_files:'import.bad'
LOGFILE log_files:'import.log'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
)
LOCATION ('skills_migration.csv'))
REJECT LIMIT UNLIMITED;
commit;
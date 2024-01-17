CREATE TABLE I_bde_industry_migration (
CODE  VARCHAR(3),
NAME VARCHAR(100) ,
sic_section_index CHAR(3),
isic_section_name VARCHAR(100),
industry_id NUMBER(4),
industry_name VARCHAR(100) ,
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
LOCATION ('industry_migration.csv'))
REJECT LIMIT UNLIMITED;
commit;
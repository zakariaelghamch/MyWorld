CREATE TABLE I_bde_country_migration (
base_country_code  VARCHAR(100),
base_country_name VARCHAR(100) ,
target_country_code  VARCHAR(100),
target_country_name VARCHAR(100) ,
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
LOCATION ('country_migration.csv'))
REJECT LIMIT UNLIMITED;
commit;
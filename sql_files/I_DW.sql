/*------------- DIMENSION COUNTRY -------------*/
DROP TABLE dw_country;
CREATE TABLE dw_country (
  Code char(2) ,
  Name varchar2(52) NOT NULL,
  Continent varchar2(20) check (Continent in ('Asia','Europe','North America','Africa','Oceania','Antarctica','South America')) NOT NULL,
  Region varchar2(26) NOT NULL ,
  SurfaceArea number(10,2) NOT NULL ,
  IndepYear number ,
  Population number NOT NULL ,
  GNP number(10,2) ,
  GovernmentForm varchar2(45) NOT NULL ,
  Capital number ,
  Language VARCHAR2(30),
  CONSTRAINT PK_country PRIMARY KEY (Code)  
);
INSERT INTO dw_country 
SELECT c.FUN_TCOUNTRYCODED(), c.FUN_TCOUNTRYNAME(), c.FUN_TCOUNTRYCONTINENT(),c.FUN_TCOUNTRYREGION(),c.fun_tcountrySurface(),c.fun_tcountryIndep(),c.fun_tcountryPop(),c.fun_tcountryGNP(), c.FUN_TCOUNTRYGOUVERNMENTFORM() ,c.fun_tcountryCapital(),c.getLanguage()
FROM tab_country c;
/
/*---------------DIMENSION SKILL MIGRATION -----------*/
DROP TABLE dw_skill_migration;
CREATE TABLE dw_skill_migration (
  SKILL_GROUP_ID NUMBER(5),
  SKILL_GROUP_CATEGORY VARCHAR2(100),
  SKILL_GROUP_NAME VARCHAR2(60),
 CONSTRAINT PK_skill_migration PRIMARY KEY (SKILL_GROUP_ID)
);
INSERT INTO dw_skill_migration
SELECT DISTINCT 
s.getSkill_groupId(), s.getSkill_groupCategory(), s.getSkill_groupName()
FROM tab_skill_migration s;

/*--------------DIMENSION INDUSTRY MIGRATION------------*/

DROP TABLE dw_industry_migration;
CREATE TABLE  dw_industry_migration (
  INDUSTRY_ID  NUMBER(4),
  INDUSTRY_NAME VARCHAR2(100),
  SIC_SECTION_NAME VARCHAR2(100) ,
  CONSTRAINT PK_industry_migration PRIMARY KEY (INDUSTRY_ID) 
   );
INSERT INTO dw_industry_migration
SELECT  DISTINCT i.getindustry_ID(),i.getindustry_NAME(), i.getSection_NAME()
FROM tab_industry_migration i;  
commit;  
/*------------ immigration --------------*/
DROP TABLE immigration;
CREATE TABLE immigration (
   Nbr_mgts NUMBER(10),
   country_code CHAR(2) ,
   skill_migration_id  NUMBER(5),
   industry_migration_id,
  Constraint fk_country_code FOREIGN KEY (country_code) REFERENCES dw_country(code),
   Constraint fk_skill_id FOREIGN KEY (skill_migration_id) REFERENCES dw_skill_migration(SKILL_GROUP_ID),
  Constraint fk_industry_id  FOREIGN KEY (industry_migration_id) REFERENCES dw_industry_migration(INDUSTRY_ID)
);
/
alter table immigration     DISABLE constraint  fk_country_code;
alter table immigration     DISABLE constraint  fk_skill_id;
alter table immigration     DISABLE constraint  fk_industry_id;
/
INSERT INTO immigration  SELECT s.getSkill_NBR_MIGRANTS(),s.getCode(),s.getSkill_groupId(),0 from tab_skill_migration s
WHERE s.getCode() IN (SELECT LOWER(Code) FROM dw_country) 
AND s.getSkill_groupId() IN (SELECT SKILL_GROUP_ID  FROM  dw_skill_migration) ;
commit;
INSERT INTO immigration  SELECT i.getindustry_NBR_MIGRANTS(),i.getCode(),0,i.getindustry_ID() from tab_industry_migration i
WHERE i.getCode() IN (SELECT LOWER(Code) FROM dw_country) 
AND i.getindustry_ID() IN (SELECT industry_ID  FROM  dw_industry_migration) ;
commit;
INSERT INTO dw_skill_migration VALUES  (0,NULL,NULL);
alter table immigration ENABLE constraint  fk_skill_id;
INSERT INTO dw_industry_migration VALUES  (0,NULL,NULL);
alter table immigration ENABLE constraint  fk_industry_id;

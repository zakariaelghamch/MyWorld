/*______________ INDUSTRY MIGRATION TABLE ________________*/
CREATE OR REPLACE TYPE T_industry_migration AS OBJECT (
  CODE VARCHAR2(3),
  NAME VARCHAR2(100),
  SIC_SECTION_INDEX CHAR(3),
  SIC_SECTION_NAME VARCHAR2(100) ,
  INDUSTRY_ID  NUMBER(4),
  INDUSTRY_NAME VARCHAR2(100),
  NBR_MIGRANTS_X_10K FLOAT(4),
  MEMBER FUNCTION getCode RETURN VARCHAR2,
  MEMBER FUNCTION getName RETURN VARCHAR2,
  MEMBER FUNCTION getindustry_ID RETURN NUMBER,
  MEMBER FUNCTION getindustry_NAME RETURN VARCHAR2,
  MEMBER FUNCTION getSection_NAME RETURN VARCHAR2,
  MEMBER FUNCTION getSection_ID RETURN CHAR,
  MEMBER FUNCTION getIndustry_NBR_MIGRANTS RETURN NUMBER
  );
/
CREATE OR REPLACE TYPE BODY T_industry_migration AS
    MEMBER FUNCTION getCode RETURN VARCHAR2 IS
    BEGIN
        RETURN CODE;
    END;
    MEMBER FUNCTION getName RETURN VARCHAR2 IS
    BEGIN
        RETURN Name;
    END;
    MEMBER FUNCTION getindustry_ID RETURN NUMBER IS
    BEGIN
        RETURN  INDUSTRY_ID;
    END;
    MEMBER FUNCTION  getindustry_NAME RETURN VARCHAR2 IS
    BEGIN
        RETURN   INDUSTRY_NAME ;
    END;  
    MEMBER FUNCTION getSection_ID  RETURN char IS
    BEGIN
        RETURN SIC_SECTION_INDEX ;
    END; 
    MEMBER FUNCTION getSection_NAME  RETURN VARCHAR2 IS
    BEGIN
        RETURN SIC_SECTION_NAME ;
    END; 
    MEMBER FUNCTION getIndustry_NBR_MIGRANTS RETURN NUMBER IS
    BEGIN
        RETURN  NBR_MIGRANTS_X_10K;
    END;    
END;
/
DROP TABLE tab_industry_migration;
CREATE TABLE tab_industry_migration   OF T_INDUSTRY_MIGRATION;
INSERT INTO tab_industry_migration SELECT * FROM I_bde_industry_migration;
commit;
/
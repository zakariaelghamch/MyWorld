/*______________ COUNTRY TABLE ________________*/
CREATE OR REPLACE TYPE T_country AS OBJECT (
  Code varchar2(3),
  Name varchar2(52) ,
  Continent varchar2(20),
  Region varchar2(26) ,
  SurfaceArea number(10,2)  ,
  IndepYear number ,
  Population number ,
  LifeExpectancy number(3,1) ,
  GNP number(10,2) ,
  GNPOld number(10,2) ,
  LocalName varchar2(65) ,
  GovernmentForm varchar2(45) ,
  HeadOfState varchar2(60) ,
  Capital NUMBER ,
  Code2 varchar2(2)  ,
 MEMBER FUNCTION fun_tcountryName RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryCode RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryCoded RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryContinent RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryRegion RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountrySurface RETURN NUMBER,
 MEMBER FUNCTION fun_tcountryIndep RETURN NUMBER,
 MEMBER FUNCTION fun_tcountryPop RETURN NUMBER,
 MEMBER FUNCTION fun_tcountryGNP RETURN NUMBER ,
 MEMBER FUNCTION fun_tcountryLocalName RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryGouvernmentForm  RETURN VARCHAR2,
 MEMBER FUNCTION fun_tcountryCapital RETURN NUMBER, 
 MEMBER FUNCTION getLanguage  RETURN VARCHAR2
);
/
CREATE OR REPLACE VIEW country_LanguageD AS 
select a.countrycode AS countrycode ,a.language AS language from v_countrylanguage a,(select countrycode,max(percentage) AS maxi from v_countrylanguage  group by countrycode) b
where a.countrycode=b.countrycode and a.percentage=b.maxi;

CREATE OR REPLACE TYPE BODY T_country AS
    MEMBER FUNCTION fun_tcountryName RETURN VARCHAR2 IS
    BEGIN
        RETURN Name;
    END;
    MEMBER FUNCTION fun_tcountryCode RETURN VARCHAR2 IS
    BEGIN
        RETURN Code;
    END;
    MEMBER FUNCTION fun_tcountryCoded RETURN VARCHAR2 IS
    BEGIN
        RETURN Code2;
    END;
    MEMBER FUNCTION fun_tcountryContinent RETURN VARCHAR2 IS
    BEGIN
        RETURN Continent ;
    END;
    MEMBER FUNCTION fun_tcountryRegion RETURN VARCHAR2 IS
    BEGIN
        RETURN Region ;
    END;
    MEMBER FUNCTION fun_tcountrySurface RETURN NUMBER IS
    BEGIN
        RETURN SurfaceArea ;
    END; 
    MEMBER FUNCTION fun_tcountryIndep RETURN NUMBER IS
    BEGIN
        RETURN  IndepYear ;
    END;
    MEMBER FUNCTION fun_tcountryPop RETURN NUMBER IS
    BEGIN
        RETURN   Population ;
    END;
    MEMBER FUNCTION fun_tcountryGNP  RETURN NUMBER IS
    BEGIN
        RETURN GNP  ;
    END;
    MEMBER FUNCTION  fun_tcountryLocalName RETURN VARCHAR2 IS
    BEGIN
    RETURN LOCALNAME  ;
    END;
    MEMBER FUNCTION fun_tcountryGouvernmentForm  RETURN VARCHAR2 IS
    BEGIN
    RETURN GOVERNMENTFORM  ;
    END;
    MEMBER FUNCTION  fun_tcountryCapital RETURN NUMBER IS
    BEGIN
    RETURN CAPITAL  ;
    END;
    MEMBER FUNCTION getLanguage   RETURN VARCHAR2 IS  
    lan VARCHAR2(40);
    
    BEGIN  
    for c in (select language  INTO lan from country_languageD where countrycode=Code )  
    loop
    lan := c.language;
    end loop;
    RETURN lan;
    END;
END;
/
DROP TABLE tab_country;
CREATE TABLE tab_country OF t_country;
INSERT INTO tab_country SELECT * FROM I_bde_country;
commit;
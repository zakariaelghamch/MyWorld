/*______________ COUNTRY LANGUAGE TABLE ________________*/
CREATE OR REPLACE TYPE T_countrylanguage AS OBJECT (
  CountryCode varchar2(3) ,
  Language varchar2(30) ,
  IsOfficial varchar2(1) ,
  Percentage number(4,1) ,
  MEMBER FUNCTION getcountryCode RETURN varchar2 ,
  MEMBER FUNCTION getLanguage RETURN VARCHAR2,
  MEMBER FUNCTION getsOfficial RETURN varchar2,
  MEMBER FUNCTION getPercentage RETURN NUMBER 
  );
/
CREATE OR REPLACE TYPE BODY  T_countrylanguage AS
    MEMBER FUNCTION getcountryCode RETURN varchar2 IS
    BEGIN
        RETURN CountryCode;
    END;
    MEMBER FUNCTION getLanguage RETURN VARCHAR2 IS
    BEGIN
        RETURN Language;
    END;
    MEMBER FUNCTION getsOfficial RETURN varchar2 IS
    BEGIN
        RETURN IsOfficial ;
    END;
    MEMBER FUNCTION getPercentage RETURN NUMBER IS
    BEGIN
        RETURN Percentage ;
    END;    
END;
/
DROP TABLE tab_countrylanguage;
CREATE TABLE tab_countrylanguage OF  T_countrylanguage ;
INSERT INTO tab_countrylanguage SELECT * FROM I_bde_countrylanguage;
commit;

/
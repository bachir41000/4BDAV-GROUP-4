# Exercice 2 

# 1 - 2 - 3 - 4 
# Après avoir installer SQL Developper sur la VM nous avons créé un utilisateur system et un utilisateur HR pour se connecter au schéma HR

# -----------------------------------------------------------------------------------------------------------------

# Describe HR Schema 

# Describe all objects in HR schema
SELECT * FROM ALL_OBJECTS

# -----------------------------------------------------------------------------------------------------------------

# Generate DDL 

# Get all tables
SELECT DBMS_METADATA.GET_DDL('TABLE', TABLE_NAME) FROM USER_TABLES;

# Get all indexes
SELECT DBMS_METADATA.GET_DDL('INDEX', INDEX_NAME) FROM USER_INDEXES WHERE INDEX_TYPE ='NORMAL';

# Get all views
SELECT DBMS_METADATA.GET_DDL('VIEW', VIEW_NAME) FROM USER_VIEWS;

# Get all materilized views
SELECT QUERY FROM USER_MVIEWS;

# Get all function
SELECT DBMS_METADATA.GET_DDL('FUNCTION', OBJECT_NAME) FROM USER_PROCEDURES WHERE OBJECT_TYPE = 'FUNCTION';

# -----------------------------------------------------------------------------------------------------------------

# Reverse engineering 

# Schéma ci-dessous à copier coller dans https://dbdiagram.io/d
# Une capture d'écran est également disponible dans ce fichier

Table REGIONS {
 REGION_ID  NUMBER [pk]     
 REGION_NAME VARCHAR2(25)
}

Table LOCATIONS {
 LOCATION_ID     NUMBER(4)  [pk]    
 STREET_ADDRESS  VARCHAR2(40) 
 POSTAL_CODE     VARCHAR2(12) 
 CITY            VARCHAR2(30) 
 STATE_PROVINCE  VARCHAR2(25) 
 COUNTRY_ID      CHAR(2)
}

Table jobs{
  JOB_ID     VARCHAR2(10) [pk]
  JOB_TITLE  VARCHAR2(35) 
  MIN_SALARY NUMBER(6)    
  MAX_SALARY NUMBER(6)    

}

Table job_history{
  EMPLOYEE_ID   NUMBER(6) [pk]    
  START_DATE    DATE         
  END_DATE      DATE         
  JOB_ID        VARCHAR2(10) 
  DEPARTMENT_ID NUMBER(4)    

}

Table employees {
 EMPLOYEE_ID    NUMBER(6) [pk]  
 FIRST_NAME     VARCHAR2(20) 
 LAST_NAME      VARCHAR2(25) 
 EMAIL          VARCHAR2(25) 
 PHONE_NUMBER   VARCHAR2(20) 
 HIRE_DATE      DATE         
 JOB_ID         VARCHAR2(10) 
 SALARY         NUMBER(8,2)  
 COMMISSION_PCT NUMBER(2,2)  
 MANAGER_ID     NUMBER(6)    
 DEPARTMENT_ID  NUMBER(4)     
}

Table departments {
 DEPARTMENT_ID   NUMBER(4) [pk]  
 DEPARTMENT_NAME VARCHAR2(30) 
 MANAGER_ID      NUMBER(6)    
 LOCATION_ID     NUMBER(4) 
}

Table countries {
 COUNTRY_ID    CHAR(2) [pk]    
 COUNTRY_NAME  VARCHAR2(40) 
 REGION_ID     NUMBER     
}

ref : REGIONS.REGION_ID - countries.REGION_ID
ref : LOCATIONS.LOCATION_ID - departments.LOCATION_ID
ref : employees.MANAGER_ID - departments.MANAGER_ID
ref : employees.DEPARTMENT_ID - departments.DEPARTMENT_ID
ref : job_history.DEPARTMENT_ID - departments.DEPARTMENT_ID
ref : jobs.JOB_ID - employees.JOB_ID
ref : jobs.JOB_ID - job_history.JOB_ID
ref : job_history.EMPLOYEE_ID - employees.JOB_ID
ref :  LOCATIONS.COUNTRY_ID - countries.COUNTRY_ID

# -----------------------------------------------------------------------------------------------------------------

#    Écrire une requête pour afficher le nom complet, 
#    le pourcentage de commission (garder une précision de 2 décimales), 
#    le département et la date d’embauche des employés dont le salaire est compris entre 10000 et 15000, 
#    dont la commission n’est pas nulle et ont été embauchés avant le 5 juin 2005 

SELECT 
    first_name, 
    last_name, 
    round(commission_pct,2), 
    department_id, 
    hire_date
FROM EMPLOYEES 
WHERE salary between 10000 and 15000
AND commission_pct is not null
AND to_date(hire_date,'DD-MM-YY') > '05-JUN-05'

# -----------------------------------------------------------------------------------------------------------------

# Quel est le salaire moyen, médian, min et max pour chaque département. 
# Attention si un employé n’avait pas de département, l’inclure tout de même dans les résultats.

SELECT 
    department_id, 
    round(avg(salary),2),
    min(salary),
    median(salary),
    max(salary)
FROM EMPLOYEES 
GROUP BY department_id

# -----------------------------------------------------------------------------------------------------------------

# Trouver les 10 meilleurs jobs avec le salaire moyen et médian le plus élevé

SELECT 
    *
FROM (
    SELECT 
        job_id, 
        round(avg(salary),2) as avg_salary,
        median(salary) as med_salary
    FROM EMPLOYEES
    GROUP BY job_id
    ORDER BY  avg_salary desc
    ) a

INNER JOIN 
    (SELECT JOB_ID,JOB_TITLE FROM JOBS) b

ON a.JOB_ID = b.JOB_ID

AND ROWNUM <= 10;

# -----------------------------------------------------------------------------------------------------------------

# Lister les employés qui gagnent plus que le salaire moyen et qui travaillent dans le département informatique

SELECT 
    first_name,
    last_name,
    salary
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
AND salary > (SELECT avg(salary) from employees);

# Afficher les noms et les dates d’embauche de tous les employés qui ont été embauchés avant leur manager, 
# ainsi que les noms et les dates d’embauche de ce manager


SELECT 
    *
FROM (
    SELECT 
        employee_id,
        first_name,
        last_name,
        hire_date,
        manager_id
    FROM
        EMPLOYEES
) employees

INNER JOIN 

(
    SELECT 
        employee_id as ID_EMPLOYEE_MANAGER,
        first_name  as FIRST_NAME_MANAGER,
        last_name   as LAST_NAME_MANAGER,
        hire_date   as HIRE_DATE_MANAGER,
        manager_id
    FROM
        EMPLOYEES
) manager

ON employees.manager_id = manager.ID_EMPLOYEE_MANAGER
AND employees.hire_date < manager.HIRE_DATE_MANAGER



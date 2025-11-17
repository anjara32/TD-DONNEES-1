-- 1. Employés sans équipe
SELECT id, first_name, last_name
FROM employee
WHERE team_id IS NULL;

-- 2. Employés sans congé
SELECT emp.id, emp.first_name, emp.last_name
FROM employee emp
LEFT JOIN leave lv ON emp.id = lv.employee_id
WHERE lv.id IS NULL;

-- 3. Congés + infos employés + équipe
SELECT 
    lv.id AS leave_id,
    lv.start_date,
    lv.end_date,
    emp.first_name,
    emp.last_name,
    tm.name AS team_name
FROM leave lv
JOIN employee emp ON lv.employee_id = emp.id
LEFT JOIN team tm ON emp.team_id = tm.id;

-- 4. Nombre d'employés par type de contrat
SELECT 
    contract_type,
    COUNT(*) AS number_of_employees
FROM employee
GROUP BY contract_type;

-- 5. Nombre d'employés en congé aujourd'hui
SELECT COUNT(*) AS employees_on_leave_today
FROM leave lv
WHERE CURDATE() BETWEEN lv.start_date AND lv.end_date;

-- 6. Employés en congé aujourd'hui + équipe
SELECT 
    emp.id,
    emp.first_name,
    emp.last_name,
    tm.name AS team_name
FROM employee emp
JOIN leave lv ON emp.id = lv.employee_id
LEFT JOIN team tm ON emp.team_id = tm.id
WHERE CURDATE() BETWEEN lv.start_date AND lv.end_date;

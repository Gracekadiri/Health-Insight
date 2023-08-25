


-- Find patients who are taking medications for a variety of conditions.
SELECT patients$.patient, patients$.first, patients$.last, 
COUNT(DISTINCT medications$.description) AS unique_medication,
COUNT(DISTINCT conditions$.description) AS conditions
FROM patients$
JOIN medications$ 
ON patients$.patient = medications$.patient
JOIN conditions$ 
ON patients$.patient = conditions$.patient
GROUP BY patients$.patient, patients$.first, patients$.last
HAVING COUNT(DISTINCT conditions$.description) >= 2;

-- Retrieve patients with multiple conditions and multiple allergies.
SELECT patients$.patient, patients$.first, patients$.last, COUNT(DISTINCT conditions$.description) AS condition, COUNT(DISTINCT allergies$.description) AS Allergies
FROM patients$
JOIN conditions$ 
ON patients$.patient = conditions$.patient
JOIN allergies$ 
ON patients$.patient = allergies$.patient
GROUP BY patients$.patient, patients$.first, patients$.last
HAVING COUNT(DISTINCT conditions$.description) >= 3 AND COUNT(DISTINCT allergies$.description) >= 2;

-- Identify the most common conditions among patients.
SELECT TOP 5 conditions$.description, COUNT(conditions$.patient) AS "Number of Patients"
FROM conditions$
GROUP BY conditions$.description
ORDER BY "Number of Patients" DESC;

-- Retrieve patients who have allergies that have persisted for more than 2 years.
SELECT allergies$.PATIENT,allergies$.START, allergies$.STOP
From allergies$
WHERE DATEDIFF(YEAR, allergies$.start, allergies$.stop) > 2

-- Identify the most common medication for diabetic patients.
SELECT TOP 5 medications$.DESCRIPTION, COUNT(medications$.DESCRIPTION) AS frequency 
FROM medications$
LEFT JOIN conditions$ 
ON medications$.PATIENT = conditions$.PATIENT
WHERE conditions$.DESCRIPTION = 'Diabetes'
GROUP BY medications$.DESCRIPTION 
ORDER BY frequency DESC;

-- Retrieve patients who have experienced more than two childbirths.
SELECT patients$.patient, patients$.first, patients$.last, COUNT(procedures$.DESCRIPTION) AS "Number of Procedures"
FROM patients$
LEFT JOIN procedures$  
ON patients$.patient = procedures$.patient
WHERE procedures$.DESCRIPTION = 'Childbirth'
GROUP BY patients$.patient, patients$.first, patients$.last
HAVING COUNT(procedures$.DESCRIPTION) > 2
ORDER BY "Number of Procedures" DESC;

-- Categorize patients according to their BMI. 
SELECT patient, description, AVG(value) AS "Average Value", UNITS,
       CASE
           WHEN AVG(value) < 18.5 THEN 'Underweight'
           WHEN AVG(value) >= 18.5 AND AVG(value) <= 24.9 THEN 'Healthy'
           WHEN AVG(value) >= 25 AND AVG(value) <= 29.9 THEN 'Overweight'
           ELSE 'Obese'
       END AS "BMI category"
FROM observations$
WHERE description = 'Body Mass Index'
GROUP BY patient, description,  units;



-- Retrieve procedures performed on female patients belonging to the Asian race.
SELECT patients$.patient, patients$.race, patients$.gender, procedures$.description AS "procedure"
FROM patients$
LEFT JOIN procedures$ 
ON patients$.patient = procedures$.patient
WHERE patients$.race = 'Asian' AND patients$.gender = 'F';



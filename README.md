# Health Insight Precision Project

## Aim
The Health Insight Precision project aims to leverage data analysis techniques to gain accurate and meaningful insights from healthcare data. 
By applying advanced SQL queries and Power BI reporting, this project seeks to uncover patterns and trends within patient data that can inform targeted healthcare strategies.

## Statement of Problem
In the realm of healthcare, the abundance of patient data often presents challenges in extracting actionable insights. 
The project addresses this by utilizing data segmentation and analysis to identify patients with specific conditions, allergies, and demographic attributes. 
The goal is to provide clinicians with the tools they need to make informed decisions and tailor their patient care strategies effectively.

## Analysis
ruby '''



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
'''
## Dashboard
https://app.powerbi.com/groups/me/reports/ee69b0d2-65dd-4fef-a7c8-da06a3e791e0/ReportSection814584da095104d4a525?experience=power-bi
![Dashboard](https://github.com/Gracekadiri/Health-Insight/assets/106782819/730abefc-e4e8-4d57-829a-8f481721847c)
![Patient Summary](https://github.com/Gracekadiri/Health-Insight/assets/106782819/740e7caf-d073-4458-927d-dc55fd6d6a6a)
![PATIENT ACTIVITY](https://github.com/Gracekadiri/Health-Insight/assets/106782819/ff9f6408-6266-4b1c-ae9c-424f506547d1)


## Findings
Through rigorous data analysis, the project has yielded several key findings:
- Identification of 1,216 patients taking medications for various conditions, allowing for personalized treatment plans.
- Detection of 87 patients with multiple medical conditions and allergies, enabling precise healthcare interventions.
- Unveiling of prevalent conditions, such as Viral sinusitis affecting 2,250 patients, guiding medical research and resource allocation.
- Recognition of 16 patients with persistent allergies over 2 years, contributing to proactive healthcare management strategies.
- Insight into 7 patients who underwent multiple childbirth procedures, offering valuable trends in maternal healthcare.
- Determination of the most common medication for diabetic patients, guiding tailored treatment approaches.


## Conclusions
The Health Insight Precision project highlights the power of data-driven decision-making in healthcare. By meticulously analyzing patient data, this project aims to improve patient care strategies, increase efficiency in resource allocation, and enhance medical interventions. The findings underscore the importance of leveraging data insights to achieve precision in healthcare, ultimately leading to better patient outcomes.

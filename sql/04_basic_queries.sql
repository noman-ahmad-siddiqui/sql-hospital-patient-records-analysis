-- Total Patients
SELECT COUNT(*) AS 'Total Patients' FROM patients;	--974


-- Gender Distribution
SELECT gender, COUNT(gender)
FROM patients
GROUP BY gender


-- Average Treatment Cost
SELECT AVG(total_claim_cost) FROM encounters



-- Encounter Types
SELECT encounterclass, COUNT(*) AS 'Total Visits' FROM encounters
GROUP BY encounterclass
ORDER BY 'Total Visits' DESC


-- Patient, Encounter Class and Number of Visits
SELECT p.first_name + ' '+ p.last_name AS 'Name' , e.encounterclass,  COUNT(*) as 'Number of Visits' 
FROM patients p
JOIN encounters e
ON p.id = e.patient
GROUP BY p.first_name,p.last_name,e.encounterclass
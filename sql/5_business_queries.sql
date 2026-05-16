-- OBJECTIVE 1: ENCOUNTERS OVERVIEW
-- a. How many total encounters occurred each year?

SELECT year(start_time) AS [year], Count(*) FROM encounters
GROUP BY year(start_time)
ORDER BY [year];


-- b. For each year, what percentage of all encounters belonged to each encounter class
-- (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?
SELECT year(start_time) AS [Year], encounterclass AS [Class], COUNT(*) AS [No. of Encounters],
    SUM(COUNT(*)) OVER(PARTITION BY year(start_time)) AS [Total Encounters by Year],
    CONCAT(ROUND(CAST(COUNT(*) AS FLOAT) / (SUM(COUNT(*)) OVER(PARTITION BY year(start_time))) * 100,2),'%') AS [Percentage of Encounter class w.r.t Year]
FROM encounters
GROUP BY year(start_time), encounterclass
ORDER BY [Year];


-- c. What percentage of encounters were over 24 hours versus under 24 hours?

SELECT 
    CASE
        WHEN DATEDIFF(HOUR, start_time,stop_time) >= 24 THEN 'OVER 24 HOURS'
        ELSE 'UNDER 24 HOURS' 
    END AS stay,
    COUNT(*) AS [Number of Encounters],
    SUM(COUNT(*)) OVER() AS [Total Encounters],
    ROUND((CAST(COUNT(*) AS FLOAT) / SUM(COUNT(*)) OVER()) * 100,2) AS [% of Encounters by stat]
FROM encounters
GROUP BY 
    CASE
        WHEN DATEDIFF(HOUR, start_time,stop_time) >= 24 THEN 'OVER 24 HOURS'
        ELSE 'UNDER 24 HOURS' 
    END 
	;
	
	
-- OBJECTIVE 2: COST & COVERAGE INSIGHTS

-- a. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?

SELECT 
    CASE 
        WHEN payer_coverage = 0 THEN 'No Coverage'
        ELSE 'With Coverage'
    END AS Coverage,
    COUNT(*) AS [No. of Encounters],
    SUM(COUNT(*)) OVER() AS [Overall Encounters],
    ROUND((CAST(COUNT(*) AS FLOAT) / SUM(COUNT(*)) OVER()) * 100,2) AS [% of Encounters]

FROM encounters 
GROUP BY CASE 
    WHEN payer_coverage = 0 THEN 'No Coverage'
    ELSE 'With Coverage'
END
;;


-- b. What are the top 10 most frequent procedures performed and the average base cost for each?

SELECT TOP(10) 
    procedure_description AS [Top 10 Procedures], 
    COUNT(*) AS [No. of times Performed], 
    AVG(base_cost) AS [Average Cost] 
FROM p_procedures
GROUP BY procedure_description
ORDER BY COUNT(*) DESC;


-- c. Which are the procedures with the highest average base cost and the number of times they were performed?
SELECT 
    procedure_description, 
    AVG(base_cost) AS [Average Cost], 
    COUNT(*) AS [No. of Times Performed] 
FROM p_procedures
GROUP BY procedure_description
ORDER BY AVG(base_cost) DESC;


-- d. What is the average total claim cost for encounters, broken down by payer?
SELECT p.payer_name, ROUND(AVG(e.total_claim_cost),2) AS [Average Cost Claimed by a Payer] FROM encounters e
JOIN payers p
ON e.payer = p.id
GROUP BY p.payer_name;


-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS

-- a. How many unique patients were admitted each quarter over time?
SELECT DATEPART(QUARTER, start_time) AS [Quarter], COUNT(DISTINCT patient) AS [No. of Unique Patients]
FROM encounters
GROUP BY DATEPART(QUARTER, start_time)
ORDER BY DATEPART(QUARTER, start_time);



-- b. Which patients were readmitted within 30 days?
SELECT * FROM (
    SELECT patient, 
        LAG(start_time) OVER(PARTITION BY patient ORDER BY start_time) AS [Last Visit],
        start_time AS [Current Visit]
    FROM encounters
    
    ) AS T
    
WHERE DATEDIFF(DAY,[Last Visit],[Current Visit]) < 30;


-- c. Which patients had the most readmissions?

SELECT TOP (10) 
    first_name + ' ' + last_name AS [Full Name],
    COUNT(encounters.patient) AS [No. of Re-admissions]
FROM patients
JOIN encounters
ON patients.id = encounters.patient
GROUP BY first_name + ' ' + last_name
ORDER BY [No. of Re-admissions] DESC
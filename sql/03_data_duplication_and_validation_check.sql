SELECT *
FROM encounters
WHERE 
   base_encounter_cost IS NULL
   OR total_claim_cost IS NULL
   OR payer_coverage IS NULL;
   
   
SELECT * FROM patients
where marital = NULL;


SELECT *
FROM patients
WHERE 
   id IS NULL
   OR marital IS NULL
   OR gender IS NULL
   OR ethnicity IS NULL
   OR race IS NULL;
   
   
SELECT id, COUNT(*) 
FROM encounters
GROUP BY id
HAVING COUNT(*) > 1;
   
   
 -- Some first_name and last_name contains numbers and special characters in patients table data
 -- Removing numbers from names
 
UPDATE patients
SET first_name = REGEXP_REPLACE(LEFT(first_name,len(first_name)-3),'[^A-Za-z ]', '')

UPDATE patients
SET last_name = REGEXP_REPLACE(LEFT(last_name,len(last_name)-3),'[^A-Za-z ]', '')
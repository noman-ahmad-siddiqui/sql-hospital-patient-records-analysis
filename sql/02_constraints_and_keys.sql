/*
========================================================
FOREIGN KEY RELATIONSHIPS
========================================================
*/


/* Creating Foreing Keys in Encounters Table
 =====================================================
 ENCOUNTERS → PATIENTS
*/

ALTER TABLE encounters
ADD CONSTRAINT fk_encounters_patient FOREIGN KEY (patient) REFERENCES patients(id);

-- ENCOUNTERS → ORGANIZATIONS
ALTER TABLE encounters
ADD CONSTRAINT fk_encounters_organization FOREIGN KEY (organization) REFERENCES organizations(id);

-- ENCOUNTERS → PAYERS
ALTER TABLE encounters
ADD CONSTRAINT fk_encounters_payer FOREIGN KEY (payer) REFERENCES payers(id);



/* Creating Foreing Keys in Procedures Table
 =====================================================
-- PROCEDURES → PATIENTS
*/

ALTER TABLE p_procedures
ADD CONSTRAINT fk_p_procedures_patient FOREIGN KEY (patient_id) REFERENCES patients(id);

-- PROCEDURES → ENCOUNTERS
ALTER TABLE p_procedures
ADD CONSTRAINT fk_p_procedures_encounter FOREIGN KEY (encounter_id) REFERENCES encounters(id);
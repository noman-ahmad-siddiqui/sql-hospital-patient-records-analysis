-- Database Creation
CREATE DATABASE db_hospital;

USE db_hospital

-- Patients Table
CREATE TABLE patients (

    id UNIQUEIDENTIFIER PRIMARY KEY,
    birthdate DATE,
    deathdate DATE NULL,
    prefix VARCHAR(10),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    suffix VARCHAR(20) NULL,
    maiden_name VARCHAR(100) NULL,
    marital CHAR(1) NULL,
    race VARCHAR(50),
    ethnicity VARCHAR(50),
    gender CHAR(1),
    birthplace VARCHAR(150),
    address_line VARCHAR(255),
    city VARCHAR(100),
    state_NAME VARCHAR(100),
    county VARCHAR(100),
    zip_code VARCHAR(20) NULL,
    lat varchar(20),
    lon varchar(20)
);


-- Bulk Insert Data from CSV to Patients Table
BULK INSERT patients
FROM 'CompleteFilePath' --For example: 'C:\Users\Downloads\patients.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM patients


-- Organizations Table
CREATE TABLE organizations (

    id UNIQUEIDENTIFIER PRIMARY KEY,
    f_name VARCHAR(100),
    address_line VARCHAR(255),
    city VARCHAR(100),
    state_NAME VARCHAR(100),
    zip_code VARCHAR(20) NULL,
    lat varchar(20),
    lon varchar(20)
);

-- Bulk Insert Data from CSV to organizations Table
BULK INSERT organizations
FROM 'CompleteFilePath' --For example: 'C:\Users\Downloads\organizations.csv' 
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM organizations


-- Procedures Table
CREATE TABLE p_procedures (

    start_time DATETIME2 NOT NULL,
    stop_time DATETIME2 NOT NULL,
    patient_id UNIQUEIDENTIFIER NOT NULL,
    encounter_id UNIQUEIDENTIFIER NOT NULL,
    procedure_code BIGINT NOT NULL,
    procedure_description VARCHAR(255) NOT NULL,
    base_cost INT NOT NULL,
    reason_code VARCHAR(20) NULL,
    reason_description VARCHAR(255) NULL
);

-- Bulk Insert Data from CSV to Procedures Table

BULK INSERT p_procedures
FROM 'CompleteFilePath' --For example: 'C:\Users\Downloads\procedures.csv' 
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


SELECT * FROM p_procedures

-- Encounters Table
CREATE TABLE encounters (
    
    id UNIQUEIDENTIFIER PRIMARY KEY,
    start_time DATETIME2 NOT NULL,
    stop_time DATETIME2 NOT NULL,
    patient UNIQUEIDENTIFIER NOT NULL,
    organization UNIQUEIDENTIFIER NOT NULL,
    payer UNIQUEIDENTIFIER NOT NULL,
    encounterclass VARCHAR(50) NOT NULL,
    code VARCHAR(255) NOT NULL,
    e_description VARCHAR(255),
    base_encounter_cost float NOT NULL,
    total_claim_cost float NOT NULL,
    payer_coverage float NOT NULL,
    reasoncode VARCHAR(20) NULL,
    reasondescription VARCHAR(255) NULL
);


BULK INSERT encounters
FROM 'CompleteFilePath' --For example: 'C:\Users\Downloads\encounters.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


SELECT * FROM encounters


-- Payers Table
CREATE TABLE payers (

    id UNIQUEIDENTIFIER PRIMARY KEY,
    payer_name VARCHAR(150) NOT NULL,
    address_line VARCHAR(255) NULL,
    city VARCHAR(100) NULL,
    state_headquartered CHAR(2) NULL,
    zip_code VARCHAR(20) NULL,
    phone VARCHAR(25) NULL
);

-- Bulk Insert Data from CSV to Procedures Table
BULK INSERT payers
FROM 'CompleteFilePath' --For example: 'C:\Users\Downloads\payers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

SELECT * FROM payers
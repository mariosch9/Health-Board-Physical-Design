drop table if exists NextofKin;
drop table if exists Prescription;
drop table if exists Admitted; 
drop table if exists Patient; 
drop table if exists Ward;
drop table if exists Medication;
drop table if exists Staff;
drop table if exists Hospital;

CREATE TABLE Hospital (
	Name VARCHAR(255) NOT NULL,
    Postcode VARCHAR(10) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Hospital_id VARCHAR(30) NOT NULL,
    PRIMARY KEY (hospital_id),
    INDEX (Name)
)  ENGINE INNODB;

CREATE TABLE Ward (
    Name VARCHAR(255) NOT NULL,
    Specialism VARCHAR(255) NOT NULL,
    Hospital_id VARCHAR(30) NOT NULL,
    Ward_id VARCHAR(30) NOT NULL,
    PRIMARY KEY (Ward_id),
    FOREIGN KEY (Hospital_id)
        REFERENCES Hospital (Hospital_id),
    INDEX idx_ward (Name , Specialism , Hospital_id)
)  ENGINE INNODB;

CREATE TABLE Staff (
    Employee_id VARCHAR(30) NOT NULL,
    Forename VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    Average_salary DECIMAL(15 , 2 ) NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Hospital_id VARCHAR(30) NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (hospital_id)
        REFERENCES Hospital (hospital_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX idx_staff_salary (Forename , Surname , Average_salary)
)  ENGINE INNODB;

CREATE TABLE Medication (
    NHS_id VARCHAR(25) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Contra_indication VARCHAR(255) NOT NULL,
    PRIMARY KEY (NHS_id),
    INDEX idx_med_contra (NHS_id , Name , Contra_indication)
)  ENGINE INNODB;

CREATE TABLE Patient (
    NI_number VARCHAR(15) NOT NULL,
    Patient_name VARCHAR(255) NOT NULL,
    DOB DATE NOT NULL,
    Sex ENUM('M', 'F') NOT NULL,
    PRIMARY KEY (NI_number)
)  ENGINE INNODB;

CREATE TABLE Admitted (
    Free_form_notes VARCHAR(255) NOT NULL,
    Date_of_admission DATE NOT NULL,
    NI_number VARCHAR(15) NOT NULL,
    Ward_id VARCHAR(30) NOT NULL,
    PRIMARY KEY (Date_of_admission , NI_number , Ward_id),
    FOREIGN KEY (NI_number)
        REFERENCES Patient (NI_number)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Ward_id)
        REFERENCES Ward (Ward_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_admitted (Free_form_notes)
)  ENGINE INNODB;

CREATE TABLE Prescription (
    Prescription_id VARCHAR(255) NOT NULL,
    NI_number VARCHAR(15) NOT NULL,
    Start_date DATE NOT NULL,
    dose VARCHAR(255) NOT NULL,
    Frequency_administration VARCHAR(255) NOT NULL,
    End_date DATE NOT NULL,
    Employee_id VARCHAR(255) NOT NULL,
    NHS_id VARCHAR(15) NOT NULL,
    PRIMARY KEY (Prescription_id),
    FOREIGN KEY (NHS_id)
        REFERENCES Medication (NHS_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (NI_number)
        REFERENCES Patient (NI_number)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_pres (Employee_id , dose , Frequency_administration)
)  ENGINE INNODB;

CREATE TABLE NextofKin (
    NI_number VARCHAR(15) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Telephone VARCHAR(15) NOT NULL,
    PRIMARY KEY (NI_number , Name , Telephone),
    FOREIGN KEY (NI_number)
        REFERENCES Patient (NI_number)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE INNODB;

insert into Hospital
values
('Glan Clwyd Hospital','LL18 5UJ','01745583910','glanclwyd123@nhs.gov.uk','HOSGCH000000001' ),
('Ysbyty Gwynedd', 'LL57 2PW', '01248384384', 'ysbgwynedd69@nhs.gov.uk', 'HOSYGH000000002'),
('Ysbyty Eryri', 'LL55 2YE', '01286672481','ysberyri34@nhs.gov.uk', 'HOSYER000000003' ),
('Llandudno General Hospital', 'LL30 1LB', '01492860066', 'llangenhos456@nhs.gov.uk', 'HOSLGH000000004' ),
('Ysbyty Cefni', 'LL77 7PP', '03000853155', 'ysbcefni@nhs.gov.uk', 'HOSYCF000000005');

insert into Ward
values
('CardWard', 'Cardiology', 'HOSGCH000000001', 'WARD0000100001' ),
('NeurWard', 'Neurology', 'HOSYGH000000002', 'WARD0000200002'),
('OnCoWard', 'Oncology', 'HOSYER000000003', 'WARD0000300003'),
('ObstWard', 'Obstetrics', 'HOSLGH000000004','WARD0000400004'),
('GynaWard', 'gynaecology', 'HOSYCF000000005','WARD0000500005'),
('ColloWard', 'colloquially', 'HOSGCH000000001', 'WARD0000600006'),
('MaterWard', 'Coronary care', 'HOSYGH000000002', 'WARD0000700007'),
('IntenWard', 'Intensive care unit', 'HOSYER000000003', 'WARD0000800008'),
('PaediWard', 'Paediatric intensive care', 'HOSLGH000000004', 'WARD0000900009'),
('NeoITWard', 'Neonatal intensive care ', 'HOSYCF000000005', 'WARD0000A0000A');

insert into Staff
values
('EEU001', 'John', 'Smith', 23000.00, 'Neurosurgeon', 'HOSGCH000000001' ),
('EEU002', 'Chris', 'Davies', 98000.00, 'Coronary Surgeon', 'HOSYGH000000002'),
('EEU003', 'Rock', 'Hudson', 40000.00, 'Oncology Surgeon', 'HOSYER000000003'),
('EEU004', 'Kay', 'Horstman', 2000.00, 'Trauma Orphopaedic Surgeon', 'HOSLGH000000004'),
('EEU005', 'Keane', 'Juve', 60000.00, 'gynaecology Surgeon', 'HOSYCF000000005'),
('EEU006', 'Marios', 'Christodoulou', 21000.00, 'colloquially Surgeon', 'HOSGCH000000001' ),
('EEU007', 'Jane', 'Roberts', 34500.00, 'Maternity Surgeon', 'HOSYGH000000002' ),
('EEU008', 'Peter', 'Jones', 18750.00, 'Intensive care unit Surgeon', 'HOSYER000000003'),
('EEU009', 'Danny', 'Owen', 32123.00, 'Paediatric intensive care Surgeon', 'HOSLGH000000004'),
('EEU00A','Dave', 'Chris', 67123.00, 'Neonatal intensive care Surgeon','HOSYCF000000005' ),
('EEU00B', 'Adam', 'Apple', 23230.00, 'Cleaner', 'HOSYGH000000002');

insert into Medication
values
('NHS000A1','Generic Zocor', 'cholesterol-lowering statin drug'),
('NHS000B2', 'Lisinopril', 'head injury'),
('NHS000C3', 'Generic Synthroid', 'synthetic thyroid hormone'),
('NHS000D4', 'Amoxicillin', 'antibiotic'),
('NHS000E5', 'Generic Glucophage','diabetes drug'),
('NHS000F6', 'Hydrochlorothiazide','lower blood pressure' );

insert into Patient
values
('PAT0000001', 'Frank Joe', '1899-04-06', 'M' ),
('PAT0000002', 'Joe Bloggs', '1722-09-24', 'M'),
('PAT0000003', 'AS IF', '1998-07-06', 'F'),
('PAT0000004', 'Asif Ill', '1564-09-16', 'M' ),
('PAT0000005', 'Joe Ninty','1066-09-24', 'F' );

insert into Admitted
values
('Swolllen ankle', '2019-03-15', 'PAT0000001','WARD0000100001' ),
('Broken Ribs', '2019-01-24','PAT0000002', 'WARD0000900009'),
('Fructured chest','2019-03-21', 'PAT0000003','WARD0000400004'),
('Internal bleeding','2014-04-04', 'PAT0000004', 'WARD0000500005'),
('Kidney failure', '2010-12-25','PAT0000005','WARD0000200002' );

insert into Prescription
values
('0001', 'PAT0000001', '2019-03-16','2g', 'once a day','2019-04-16', 'EEU001','NHS000A1'),
('0002','PAT0000002', '2019-03-17', '200g', '3 times a day', '2019-04-17','EEU002','NHS000B2' ),
('0003','PAT0000003', '2019-03-18', '100g', '2 in morning and 2 at bedtime', '2019-04-18', 'EEU003','NHS000D4'),
('0004', 'PAT0000004','2019-03-19', '15g','1 with food twice a day', '2019-04-19', 'EEU004','NHS000C3'),
('0005', 'PAT0000005','2019-03-20', '20ml', 'only take when needed', '2019-04-20','EEU005', 'NHS000F6' );

insert into NextofKin
values
('PAT0000001', 'Pamela Anderon', '12340000876'),
('PAT0000002', 'Cindy Crawford', '65650007575'),
('PAT0000003','Bop Parry', '65656567575'),
('PAT0000004','James Bond', '77750007666'),
('PAT0000005','Prince Charles', '6553234453343');


-- a) Get the contra-indications for a specific medicine.
SELECT 
    Contra_indication
FROM
    Medication
WHERE
    Name = 'Generic Glucophage';

-- b) Get the average salary of all consultants.
SELECT 
    AVG(Average_salary) AS 'Average Salary'
FROM
    Staff;

-- c) Get the name of all wards that have a  coronary care specialism, showing the hospital name and ward name. Order the results alphabetically by hospital then ward.

SELECT 
    w.Name, h.Name
FROM
    Ward w,
    Hospital h
WHERE
    w.Hospital_id = h.Hospital_id
        AND w.Specialism = 'Coronary care'
ORDER BY h.name , w.name;
    
  --  d) Get all medicines that need to be given to a specific patient on a specific date during their stay in hospital, listing the name, dose and frequency.
SELECT 
    m.*, p.dose, p.Frequency_administration
FROM
    Medication m
        JOIN
    Prescription p ON m.NHS_id = p.NHS_id
        JOIN
    Admitted a ON p.NI_number = a.NI_number
        JOIN
    Patient c ON a.NI_number = c.NI_number
WHERE
    a.Date_of_admission = '2010-12-25';

-- e) Get the next of kin details for a specific patient.
SELECT 
    n.*
FROM
    NextofKin n,
    Patient p
WHERE
    n.NI_number = p.NI_number
        AND p.NI_number = 'PAT0000002';
        
  -- f) Get the name of the doctor who prescribed a specific medicine to a patient.      
SELECT 
    d.Forename, d.Surname
FROM
    Staff d,
    Prescription p,
    Medication m
WHERE
    d.Employee_id = p.Employee_id
        AND p.NHS_id = m.NHS_id
        AND m.Name = 'Amoxicillin';

-- g) Get all notes for a specific patient for all their stays in a specific hospital.

SELECT 
    a.Free_form_notes
FROM
    Admitted a,
    Ward w,
    Hospital h,
    Patient p
WHERE
    a.Ward_id = w.ward_id
        AND w.Hospital_id = h.Hospital_id
        AND h.Name = 'Ysbyty Gwynedd'
        AND p.Patient_Name = 'Frank Joe';
        
-- h) Get all medicines whose contra-indications include the phrase “head injury”.
SELECT 
    *
FROM
    Medication
WHERE
    Contra_indication like '%head injury%';
    
    -- Views that need to be created.
    
CREATE VIEW staf_details AS
    SELECT 
        s.Employee_id, s.Forename, s.Surname, s.Position
    FROM
        Staff s;
    









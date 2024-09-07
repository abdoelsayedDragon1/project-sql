--SELECT: Retrieve all columns from the Doctor table.--
SELECT *
FROM DOCTORS;

--ORDER BY: List patients in the Patient table in ascending order of their ages.--
SELECT*
FROM PATIENTS
ORDER BY age ASC


--OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.--
SELECT *
FROM PATIENTS
ORDER BY
UR_Numbers
OFFSET 4 ROWS 
FETCH NEXT 10 ROWS ONLY;

--SELECT TOP: Retrieve the top 5 doctors from the Doctor table.--
SELECT TOP 5*
FROM DOCTORS

--SELECT DISTINCT: Get a list of unique address from the Patient table.--
SELECT DISTINCT ADDRESS
FROM PATIENTS

--WHERE: Retrieve patients from the Patient table who are aged 25.--
SELECT *
FROM PATIENTS
WHERE AGE =25;

--NULL: Retrieve patients from the Patient table whose email is not provided.--
SELECT *
FROM PATIENTS
WHERE email IS NULL;

--AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'--
SELECT*
FROM DOCTORS
WHERE Years_of_Experience>'2018' AND Specialty= 'Cardiology';

--IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
SELECT*
FROM DOCTORS
WHERE Specialty IN('Dermatological specialty','Oncology')

--BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.--
SELECT *
FROM PATIENTS
WHERE AGE BETWEEN 18 AND 30;

--LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'--
SELECT *
FROM DOCTORS
WHERE doctor_name LIKE 'DR.%'

--Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.--
SELECT doctor_name AS DoctorName, email AS DoctorEmail
FROM DOCTORS

--Joins: Retrieve all prescriptions with corresponding patient names.--
SELECT P.PRESCRIPTION_id, P.Date, PA.Name AS PatientName
FROM PRESCRIPTION P
Right JOIN PATIENTS PA ON P.UR_Numbers = PA.UR_Numbers;


--GROUP BY: Retrieve the count of patients grouped by their cities.--
SELECT Address,COUNT(*) AS PATIENTCOUNT
FROM PATIENTS
GROUP BY Address;

--HAVING: Retrieve cities with more than 3 patients.--
SELECT Address,COUNT(*) AS PATIENTCOUNT
FROM PATIENTS
GROUP BY Address
HAVING COUNT(*) > 3;

--UNION: Retrieve a combined list of doctors and patients. (Search)--
SELECT doctor_name AS PERSON_NAME, 'DOCTOR' AS PERSON_TYPE
FROM DOCTORS
UNION
SELECT Name AS PERSON_NAME, 'PATIENT' AS PERSON_TYPE
FROM PATIENTS;

--Common Table Expression (CTE): Retrieve patients along with their doctors using a CTE.--

WITH PATIENTDOCTOR AS (
    SELECT
        P.UR_Numbers AS PatientID,
        P.Name AS PatientName,
        D.doctor_name AS DoctorName,
        D.Specialty AS DoctorSpecialty
    FROM PATIENTS P
     JOIN DOCTORS D ON P.Doctor_ID = D.Doctor_ID
)

SELECT *
FROM PATIENTDOCTOR;

--NSERT: Insert a new doctor into the Doctor table.--
INSERT INTO DOCTORS
(
doctor_id,
doctor_name,
Specialty,
email,
phone,
Years_of_Experience
)
VALUES(101,'noah','Oncological','noah@.com','01032469714',10 )

--INSERT Multiple Rows: Insert multiple patients into the Patient table.--
INSERT INTO PATIENTS
(UR_Numbers,
Name,
Address,
email,
phone,
age,
Medicare_card_numbers
)
VALUES
(101,'SAYED','13 Omar bin al Khattab Street Kafr el Sheikh ','S@.COM777','234-678-690', 22,'0876543332'),
(102,'OSSAMA','41 al Fadi ','O@.COM777','734-578-690', 20,'0876543098'),
(103,'TAHA','13 kaabish','T@.COM777','734-543-690', 20,'0876558098')

--UPDATE: Update the phone number of a doctor.--
UPDATE DOCTORS
SET Phone = '123-456-7890'
WHERE Doctor_ID = 101;

--UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.--
UPDATE PATIENTS
SET Address = 'New Address'
FROM PATIENTS P
JOIN PRESCRIPTION PR ON P.UR_Numbers = PR.UR_Numbers
JOIN DOCTORS D ON PR.Doctor_ID = D.Doctor_ID
WHERE D.Doctor_Name = 'Dr. SAMI ABDO';


--DELETE: Delete a patient from the Patient table.--
DELETE FROM PATIENTS
WHERE UR_Numbers=102;

--Transaction: Insert a new doctor and a patient, ensuring both operations succeed or fail together.--
BEGIN TRANSACTION;

INSERT INTO DOCTORS (doctor_id, doctor_name, Specialty,email, phone, Years_of_Experience)
VALUES (102, 'Dr. SAAD', 'Orao','SA@GMAIL','234-556-876', 10);


INSERT INTO PATIENTS (UR_Numbers, Name, Age, Address, phone,email,Medicare_card_numbers)
VALUES (102, 'FATHI', 25, '123 Main St','987-765-436','FAT@GMAIL','1234567876');

COMMIT;

--View: Create a view that combines patient and doctor information for easy access--
CREATE VIEW DOCTOR_PATIENT AS 
SELECT P.UR_Numbers, P.Name AS PATIENT_NAME, P.Age, D.doctor_name AS DOCTOR_Name, D.Specialty
FROM PATIENTS P
JOIN DOCTORS D ON P.doctor_id = D.doctor_id;

--Index: Create an index on the 'phone' column of the Patient table to improve search performance.--
SELECT PHONE
FROM PATIENTS
WHERE phone= '108-324-7258';

CREATE INDEX IND
ON PATIENTS (PHONE);


--Backup: Perform a backup of the entire database to ensure data safety.--
BACKUP DATABASE HOSDB
TO DISK = 'D:\backups\hosp.bak';
-- 1. Count of Female vs Male patients that have OCD. -- Average Obsession score by Gender
with data as (
select Gender, count(Patient_ID) as patient_count,
round(avg(Y_BOCS_Score_Obsessions),2) as avg_obs_score
from Health_Data.ocd_patient_dataset
group by Gender
)

-- select * from data;

select
sum(case when Gender='Female' then patient_count else 0 end) as female_count,
sum(case when Gender='Male' then patient_count else 0 end) as male_count,

round(sum(case when Gender='Female' then patient_count else 0 end)/
(sum(case when Gender='Female' then patient_count else 0 end) + sum(case when Gender='Male' then patient_count else 0 end))*100,2)
as pct_female,
round(sum(case when Gender='Male' then patient_count else 0 end)/
(sum(case when Gender='Female' then patient_count else 0 end) + sum(case when Gender='Male' then patient_count else 0 end))*100,2)
as pct_male
from data;


-- 2. Count of Patients by Ethnicity and their respective average Obsession Score

select Ethnicity, count(Patient_ID) as patient_count,
round(avg(Y_BOCS_Score_Obsessions),2) as obs_score
from Health_Data.ocd_patient_dataset
group by Ethnicity;

-- 3. Number of people diagnosed with OCD MoM

-- SET SQL_SAFE_UPDATES = 0;

-- UPDATE Health_Data.ocd_patient_dataset 
-- SET OCD_Diagnosis_Date = STR_TO_DATE(OCD_Diagnosis_Date, '%m/%d/%y') 
-- WHERE OCD_Diagnosis_Date LIKE '%/%/%';

-- SET SQL_SAFE_UPDATES = 1;

-- alter table Health_Data.ocd_patient_dataset
-- modify OCD_Diagnosis_Date date;
select
date_format(OCD_Diagnosis_Date, '%Y-%m-01 00:00:00') as month,
count(Patient_ID) as patient_count
from Health_Data.ocd_patient_dataset
group by 1
order by 1;


-- 4.What is the most common Obsession type and its respective average obsession score

select Obsession_Type, count(Patient_ID) as patient_count,
round(avg(Y_BOCS_Score_Obsessions),2) as obs_score
from Health_Data.ocd_patient_dataset
group by 1
order by 2;

-- 5.What is the most common compulsion type  and its respective average obsession score

select Compulsion_Type, count(Patient_ID) as patient_count,
round(avg(Y_BOCS_Score_Obsessions),2) as obs_score
from Health_Data.ocd_patient_dataset
group by 1
order by 2;

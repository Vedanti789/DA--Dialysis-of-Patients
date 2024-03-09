create database project;
use project;


select * from dialysis_i;
select * from dialysis_ii;

/*KPI-I*/

SELECT SUM(patients_hypercalcemia_summary) AS total_hypercalcemia, sum(patients_transfusion_summary) as total_transfusion, 
sum(patients_serum_phosphorus_summary) as total_serum_phosphorus, sum(patients_hospitalization_summary) as total_hospitalization, 
sum(patients_survival_summary) as total_survival, sum(patients_fistula_summary) as total_fistula, sum(patients_nPCR_summary) as total_nPCR,
sum(patients_long_term_catheter_summary) as total_catheter  /*sum(patients_pppw) as total_pppw*/
FROM dialysis_i;

/*KPI-II*/

SELECT profit_or_non_profit, COUNT(*) AS count
FROM dialysis_i
WHERE profit_or_non_profit IN ('Profit', 'Non-Profit')
GROUP BY profit_or_non_profit;

/*KPI-III*/

SELECT t1.chain_organization, 
       count(*) AS co_totalCount,
       sum(CASE WHEN t2.total_performance_score = 'No Score' THEN 1 END) AS NoScoreCount
FROM dialysis_i t1
JOIN dialysis_ii t2 ON t1.Provider_Number = t2.cms_certification_number
GROUP BY t1.chain_organization;

/*KPI-IV*/

SELECT chain_organization, 
       sum(of_dialysis_stations) as dialysis_station
FROM dialysis_i
GROUP BY chain_organization;

/*KPI-V*/

SELECT 'Transfusion' AS Category, COUNT(patient_transfusion_category_text) AS Count
FROM dialysis_i
WHERE patient_transfusion_category_text IN ('As Expected')
UNION ALL
SELECT 'Hospitalization' AS Category, COUNT(patient_hospitalization_category_text) AS Count
FROM dialysis_i
WHERE patient_hospitalization_category_text IN ('As Expected')
UNION ALL
SELECT 'Survival' AS Category, COUNT(patient_survival_category_text) AS Count
FROM dialysis_i
WHERE patient_survival_category_text IN ('As Expected')
UNION ALL
SELECT 'Infection' AS Category, COUNT(patient_infection_category_text) AS Count
FROM dialysis_i
WHERE patient_infection_category_text IN ('As Expected')
UNION ALL
SELECT 'Fistula' AS Category, COUNT(fistula_category_text) AS Count
FROM dialysis_i
WHERE fistula_category_text IN ('As Expected')
UNION ALL
SELECT 'SWR' AS Category, COUNT(swr_category_text) AS Count
FROM dialysis_i
WHERE swr_category_text IN ('As Expected')
UNION ALL
SELECT 'PPPW' AS Category, COUNT(pppw_category_text) AS Count
FROM dialysis_i
WHERE pppw_category_text IN ('As Expected');




/*KPI-VI*/

SELECT AVG(py2020_payment_reduction_percentage) AS average_payment_reduction
FROM dialysis_ii;

SELECT ot.chain_organization, AVG(pt.py2020_payment_reduction_percentage) AS average_payment_reduction
FROM dialysis_i ot
JOIN dialysis_ii pt ON ot.Provider_Number = pt.cms_certification_number
GROUP BY ot.chain_organization;

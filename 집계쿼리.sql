-- kpi
SELECT COUNT(*) claims, SUM(rvd_rpe_tamt_amt) cost, COUNT(DISTINCT jid) patients FROM kr_claims.claim;

-- diseases
SELECT c.main_sick code,s.krnm name,COUNT(*) claims FROM kr_claims.claim c JOIN kr_claims.sick_master s ON c.main_sick=s.sickcd GROUP BY c.main_sick,s.krnm ORDER BY claims DESC,c.main_sick LIMIT 10;

-- institutions
SELECT t.code_nm name,COUNT(*) claims,AVG(c.rvd_rpe_tamt_amt) average FROM kr_claims.claim c JOIN kr_claims.institution i ON c.yid=i.yid JOIN kr_claims.code_table t ON t.code_type='종별코드' AND t.code=i.cl_cd GROUP BY t.code_nm ORDER BY average DESC;

-- monthly
SELECT substr(recu_fr_dd,1,7) month,COUNT(*) claims,SUM(CASE WHEN main_sick LIKE 'J%' THEN 1 ELSE 0 END) respiratory FROM kr_claims.claim GROUP BY month ORDER BY month;

-- day1
SELECT s.krnm name,c.main_sick code,COUNT(DISTINCT c.jid) patients,COUNT(*) claims FROM kr_claims.claim c JOIN kr_claims.sick_master s ON c.main_sick=s.sickcd WHERE c.fom_tp_cd='031' AND c.main_sick IN ('I109','E119') GROUP BY c.main_sick,s.krnm ORDER BY patients DESC;
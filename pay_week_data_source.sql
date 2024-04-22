-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
------DATA GATHERING---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------
--------CALENDAR----------------------- 
---------------------------------------
uncache table if exists CALENDAR;
drop view if exists CALENDAR;
cache table CALENDAR as

SELECT *
FROM
  (SELECT iso_date
  ,tesco_year
  ,tesco_week
  ,tesco_yrwk
  ,dmtm_fd_daynum
  ,dtdw_id
  ,CASE WHEN UPPER('${Country code | type: str}') = 'HU' 
    THEN --HU
      CASE WHEN MONTH(iso_date) IN (1,3,5,7,8,10,12)  
        THEN
          CASE WHEN SUBSTR(iso_date,9,2) = '02' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
                WHEN SUBSTR(iso_date,9,2) = '01' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
                WHEN SUBSTR(iso_date,9,2) = '01' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
                WHEN SUBSTR(iso_date,9,2) = '03' AND dtdw_id = 1 AND bank_holiday_id <> 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 1 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_3 = 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 2 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_4 = 1 AND lag_bank_holiday_id = 1 THEN 1      
                ELSE 0 END   
            WHEN MONTH(iso_date) IN (4,6,9,11)
        THEN
          CASE WHEN SUBSTR(iso_date,9,2) = '02' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
                WHEN SUBSTR(iso_date,9,2) = '01' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
                WHEN SUBSTR(iso_date,9,2) = '01' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
                WHEN SUBSTR(iso_date,9,2) = '03' AND dtdw_id = 1 AND bank_holiday_id <> 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 1 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_3 = 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 2 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_4 = 1 AND lag_bank_holiday_id = 1 THEN 1      
              ELSE 0 END 
            WHEN MONTH(iso_date) IN (2)
        THEN
          CASE WHEN SUBSTR(iso_date,9,2) = '02' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
                WHEN SUBSTR(iso_date,9,2) = '01' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
                WHEN SUBSTR(iso_date,9,2) = '01' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
                WHEN SUBSTR(iso_date,9,2) = '03' AND dtdw_id = 1 AND bank_holiday_id <> 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 1 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_3 = 1 THEN 1    
                WHEN SUBSTR(iso_date,9,2) = '04' AND dtdw_id = 2 AND bank_holiday_id <> 1 AND lag_bank_holiday_id_4 = 1 AND lag_bank_holiday_id = 1 THEN 1    
              ELSE 0 END
        ELSE 0 END
    ELSE --SK,CZ
      CASE WHEN SUBSTR(iso_date,9,2) = '10' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
              WHEN SUBSTR(iso_date,9,2) = '09' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
              WHEN SUBSTR(iso_date,9,2) = '09' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
              WHEN SUBSTR(iso_date,9,2) = '08' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
              WHEN SUBSTR(iso_date,9,2) = '07' AND dtdw_id = 5 AND bank_holiday_id <> 1 AND lead_bank_holiday_id_3 = 1 THEN 1 
              WHEN SUBSTR(iso_date,9,2) = '07' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1 
              WHEN SUBSTR(iso_date,9,2) = '06' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 AND lead_bank_holiday_id_4 = 1 THEN 1 
                  ELSE 0 END
    END AS small_payday_id
  ,CASE WHEN UPPER('${Country code | type: str}') = 'HU' 
    THEN --HU
      CASE WHEN SUBSTR(iso_date,9,2) = '10' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
            WHEN SUBSTR(iso_date,9,2) = '09' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '09' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
            WHEN SUBSTR(iso_date,9,2) = '08' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '07' AND dtdw_id = 5 AND bank_holiday_id <> 1 AND lead_bank_holiday_id_3 = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '07' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '06' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 AND lead_bank_holiday_id_4 = 1 THEN 1 
                ELSE 0 END
    ELSE --SK,CZ
      CASE WHEN SUBSTR(iso_date,9,2) = '15' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
            WHEN SUBSTR(iso_date,9,2) = '14' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '14' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
            WHEN SUBSTR(iso_date,9,2) = '13' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '12' AND dtdw_id = 5 AND bank_holiday_id <> 1 AND lead_bank_holiday_id_3 = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '12' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '11' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 AND lead_bank_holiday_id_4 = 1 THEN 1 
                ELSE 0 END 
    END AS large_payday_id
  ,CASE WHEN UPPER('${Country code | type: str}') = 'HU' THEN 
    CASE WHEN SUBSTR(iso_date,9,2) = '12' AND dtdw_id NOT IN (6,7) AND bank_holiday_id <> 1  THEN 1
            WHEN SUBSTR(iso_date,9,2) = '11' AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1
            WHEN SUBSTR(iso_date,9,2) = '11' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '10' AND dtdw_id = 5 AND bank_holiday_id <> 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '09' AND dtdw_id = 5 AND bank_holiday_id <> 1 AND lead_bank_holiday_id_3 = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '09' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 THEN 1 
            WHEN SUBSTR(iso_date,9,2) = '08' AND dtdw_id = 4 AND bank_holiday_id <> 1 AND lead_bank_holiday_id = 1 AND lead_bank_holiday_id_4 = 1 THEN 1 
                ELSE 0 END 
    ELSE 0 END AS HU_pensions_id
  FROM
    (SELECT cal.* 
    ,COALESCE(bhp.bh_id,0) as bank_holiday_id
    ,LEAD(COALESCE(bhp.bh_id,0)) OVER(ORDER BY iso_date ASC) AS lead_bank_holiday_id
    ,LEAD(COALESCE(bhp.bh_id,0),4) OVER(ORDER BY iso_date ASC) AS lead_bank_holiday_id_3
    ,LEAD(COALESCE(bhp.bh_id,0),4) OVER(ORDER BY iso_date ASC) AS lead_bank_holiday_id_4
    ,LEAD(COALESCE(bhp.bh_id,0)) OVER(ORDER BY iso_date ASC) AS lag_bank_holiday_id
    ,LAG(COALESCE(bhp.bh_id,0),3) OVER(ORDER BY iso_date ASC) AS lag_bank_holiday_id_3
    ,LAG(COALESCE(bhp.bh_id,0),3) OVER(ORDER BY iso_date ASC) AS lag_bank_holiday_id_4
    FROM
      (SELECT *
      ,CONCAT(tesco_year, tesco_week) as tesco_yrwk
      FROM
        (SELECT to_date(dmtm_value) as iso_date
        ,dmtm_fd_daynum
        ,CASE WHEN dmtm_fw_weeknum = '53' THEN CAST(SUBSTR(dmtm_fy_code,2,4) AS INT) + 1 ELSE CAST(SUBSTR(dmtm_fy_code,2,4) AS INT) END as tesco_year
        ,CASE WHEN dmtm_fw_weeknum = '53' THEN '01' ELSE dmtm_fw_weeknum END as tesco_week 
        ,dtdw_id 
        FROM dm.dim_time_d)
      ORDER BY iso_date asc
      ) AS cal
      
    --BH FOR PAYDAY
    LEFT JOIN (SELECT DISTINCT date_ as iso_date_bh, country_code, country_id, id as bh_id FROM sch_analysts.holiday_events_ce WHERE type_ = 'bank_holiday') AS bhp
    ON bhp.iso_date_bh = cal.iso_date
    AND bhp.country_code = UPPER('${Country code | type: str}')
    )
  )
WHERE iso_date > '2021-02-01'
;
---------------------------------------
------RMS_HIERARCHY-------------------- SELECT distinct cntr_code as int_cntr_code, dmat_div_code, dmat_dep_code, SUBSTR(sg_cd,1,3) as sg_cd_3, SUBSTR(sg_cd,1,4) as sg_cd_4, sg_cd FROM RMS_hierarchy 
--------------------------------------- 
REFRESH TABLE dm.dim_artgld_details;
uncache table if exists RMS_hierarchy; 
drop view if exists RMS_hierarchy;
cache table RMS_hierarchy as

SELECT g.*
,j.sg_cd
,CONCAT(CAST(g.dmat_div_code AS INT),CAST(g.dmat_dep_code AS INT),CAST(g.dmat_sec_code AS INT),CAST(g.dmat_grp_code AS INT),CAST(g.dmat_sgr_code as INT)) as RMS_ID
FROM dm.dim_artgld_details AS g

INNER JOIN stg_go.go_266_hierarchy_mapping as j
ON CAST(g.dmat_div_code AS INT)= j.rms_division
AND CAST(g.dmat_dep_code AS INT)= j.rms_group
AND CAST(g.dmat_sec_code AS INT)= j.rms_dept
AND CAST(g.dmat_grp_code AS INT)= j.rms_class
AND CAST(g.dmat_sgr_code AS INT)= j.rms_subclass
AND j.part_col = DATE_FORMAT(CURRENT_DATE,'yyyyMMdd')
AND g.cntr_id = j.int_cntr_id

WHERE CAST(G.dmat_dep_code AS INT) IN (${Department list | type: raw})
;
--------------------------------------- 
----TPNB COUNT FEATURE-----------------
--------------------------------------- 
------------------------------
--PREP TABLE TPNB LEVEL------- 
------------------------------
uncache table if exists Tpnb_table;
drop view if exists Tpnb_table;
cache table Tpnb_table as

SELECT int_cntr_code
,int_cntr_id
,iso_date
,tesco_yrwk
,ro_no
,bpr_tpn
,RMS_ID
,stkd_prod_stdt
,stkd_prod_endt
,part_col 
FROM
  (
  (SELECT cal.iso_date as iso_date
  ,cal.tesco_yrwk
  ,base.*
  ,gld.*
  FROM stg_go.go_207_tpn_store_basic as base 
  
  INNER JOIN RMS_hierarchy as gld
  ON gld.slad_tpnb = base.bpr_tpn
  AND gld.cntr_id = base.int_cntr_id
  
  INNER JOIN CALENDAR as cal
  ON cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw})
  AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
  AND cal.iso_date BETWEEN stkd_prod_stdt AND COALESCE(stkd_prod_endt,'2099-12-31')
  AND date_format(cal.iso_date,'yyyyMMdd') = base.part_col
  
  WHERE base.int_cntr_code = UPPER('${Country code | type: str}')
  AND CAST(base.rms_group AS INT) IN (${Department list | type: raw})
  )
  
  UNION ALL
  
  (SELECT cal.iso_date as iso_date
  ,cal.tesco_yrwk as tesco_yrwk
  ,base.*
  ,gld.*
  FROM stg_go.go_207_tpn_store_basic as base 
  
  INNER JOIN RMS_hierarchy as gld
  ON gld.slad_tpnb = base.bpr_tpn
  AND gld.cntr_id = base.int_cntr_id
  
  INNER JOIN CALENDAR as cal
  ON cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw})
  AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
  AND cal.iso_date > CURRENT_DATE
  AND cal.iso_date BETWEEN stkd_prod_stdt AND COALESCE(stkd_prod_endt,'2099-12-31')
  
  WHERE base.int_cntr_code = UPPER('${Country code | type: str}')
  AND base.part_col = DATE_FORMAT(CURRENT_DATE,'yyyyMMdd')
  AND CAST(base.rms_group AS INT) IN (${Department list | type: raw})
  ))
;
-----------------------------
--SUMMARY SGP LEVEL----------
-----------------------------
uncache table if exists Tpnb_count_table;
drop view if exists Tpnb_count_table;
cache table Tpnb_count_table as

SELECT int_cntr_code
,iso_date
,tesco_yrwk
,ro_no
,RMS_ID
,COUNT(*) as tpnb_count
FROM Tpnb_table

GROUP BY int_cntr_code
,iso_date
,tesco_yrwk
,ro_no
,RMS_ID
;
---------------------------------------
-----PROMO PRICE----------------------- 
---------------------------------------
uncache table if exists Promo_prices;
drop view if exists Promo_prices;
cache table Promo_prices as

SELECT CASE WHEN p.p1pt_cntr_id = 1 THEN 'CZ' WHEN p.p1pt_cntr_id = 4 THEN 'HU' ELSE 'SK' END as cntr_code
,p.p1pt_cntr_id as cntr_id
,gld.slad_tpnb as tpnb
,DATE_FORMAT(CAST(p.p1pt_pp_start AS DATE),'yyyyMMdd') AS promo_start
,DATE_FORMAT(CAST(p.p1pt_pp_end AS DATE),'yyyyMMdd') AS promo_end
,COALESCE(p.p1pt_pi_prcc,p.p1pt_pi_prnm) AS promo_price
,p.p1pt_pi_prcc as promo_price_old
,p.p1pt_pi_pruncc as promo_unit_price
,p.p1pt_pi_prunac as normal_price
,p.p1pt_pi_prnm as normal_unit_price
FROM dw.p1p_promo_tpn AS p

INNER JOIN RMS_hierarchy AS gld
ON gld.slad_dmat_id = p.p1pt_dmat_id
AND gld.cntr_id = p.p1pt_cntr_id
AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})

WHERE p.P1PT_CNTR_CODE = UPPER('${Country code | type: str}')
AND p.part_col >= DATE_FORMAT(DATE_ADD('2023-08-01',-460),'yyyyMMdd') 
;
-------------------------------
-----SAMPLE STORES------------- 
-------------------------------
uncache table if exists Promo_prices_sample;
drop view if exists Promo_prices_sample;
cache table Promo_prices_sample as

SELECT CASE WHEN p.p1pt_cntr_id = 1 THEN 'CZ' WHEN p.p1pt_cntr_id = 4 THEN 'HU' ELSE 'SK' END as cntr_code
,p.p1pt_cntr_id as cntr_id
,gld.slad_tpnb as tpnb
,DATE_FORMAT(DATE_ADD(CAST(p.p1pt_pp_start AS DATE),-1),'yyyyMMdd') AS promo_start
,DATE_FORMAT(CAST(p.p1pt_pp_end AS DATE),'yyyyMMdd') AS promo_end
,COALESCE(p.p1pt_pi_prcc,p.p1pt_pi_prnm) AS promo_price
,p.p1pt_pi_prcc as promo_price_old
,p.p1pt_pi_pruncc as promo_unit_price
,p.p1pt_pi_prunac as normal_price
,p.p1pt_pi_prnm as normal_unit_price
FROM dw.p1p_promo_tpn AS p
 
INNER JOIN RMS_hierarchy AS gld
ON gld.slad_dmat_id = p.p1pt_dmat_id
AND gld.cntr_id = p.p1pt_cntr_id
AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})

WHERE p.P1PT_CNTR_CODE = UPPER('${Country code | type: str}')
AND p.part_col >= DATE_FORMAT(DATE_ADD('2023-08-01',-460),'yyyyMMdd') 
;
---------------------------------------
----BSP TABLE PREP HISTORY-------------
---------------------------------------
REFRESH TABLE stg_go.go_131_bsp_extract;

uncache table if exists BSP_prep_history;
drop view if exists BSP_prep_history;
cache table BSP_prep_history as

SELECT date_format(cal.iso_date,'yyyyMMdd') as part_col
  ,base.int_cntr_code
  ,base.ro_no
  ,base.bpr_tpn
  ,base.tesco_yrwk
  ,CASE WHEN cal.dtdw_id = 1 THEN base.step_ind_1
        WHEN cal.dtdw_id = 2 THEN base.step_ind_2
        WHEN cal.dtdw_id = 3 THEN base.step_ind_3
        WHEN cal.dtdw_id = 4 THEN base.step_ind_4
        WHEN cal.dtdw_id = 5 THEN base.step_ind_5
        WHEN cal.dtdw_id = 6 THEN base.step_ind_6
        WHEN cal.dtdw_id = 7 THEN base.step_ind_7 ELSE NULL END AS step_ind
  ,CASE WHEN cal.dtdw_id = 1 THEN base.adj_sales_sngls_1
        WHEN cal.dtdw_id = 2 THEN base.adj_sales_sngls_2
        WHEN cal.dtdw_id = 3 THEN base.adj_sales_sngls_3
        WHEN cal.dtdw_id = 4 THEN base.adj_sales_sngls_4
        WHEN cal.dtdw_id = 5 THEN base.adj_sales_sngls_5
        WHEN cal.dtdw_id = 6 THEN base.adj_sales_sngls_6
        WHEN cal.dtdw_id = 7 THEN base.adj_sales_sngls_7 ELSE NULL END AS adj_sales        
  ,CASE WHEN cal.dtdw_id = 1 THEN base.exp_daily_sales_1
        WHEN cal.dtdw_id = 2 THEN base.exp_daily_sales_2
        WHEN cal.dtdw_id = 3 THEN base.exp_daily_sales_3
        WHEN cal.dtdw_id = 4 THEN base.exp_daily_sales_4
        WHEN cal.dtdw_id = 5 THEN base.exp_daily_sales_5
        WHEN cal.dtdw_id = 6 THEN base.exp_daily_sales_6
        WHEN cal.dtdw_id = 7 THEN base.exp_daily_sales_7 ELSE NULL END AS exp_sales
  FROM 
      (SELECT * FROM 
        ((SELECT *, part_col as part_col2 FROM stg_go.go_131_bsp_extract WHERE part_col <> '20230830')
        UNION ALL
        ((SELECT *, "20230831" as part_col2 FROM stg_go.go_131_bsp_extract WHERE part_col = '20230831'))
        )
      )as base

  INNER JOIN CALENDAR AS cal
  ON date_format(date_add(cal.iso_date,1),'yyyyMMdd') = base.part_col2
  AND base.part_col2 <= DATE_FORMAT(CURRENT_DATE,'yyyyMMdd')
  AND cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
  AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
  
  INNER JOIN dm.dim_artgld_details AS artgld 
  ON artgld.cntr_code = base.int_cntr_code
  AND artgld.slad_tpnb = base.bpr_tpn
  AND CAST(artgld.dmat_dep_code AS INT) IN (${Department list | type: raw})
  
  WHERE base.int_cntr_code = UPPER('${Country code | type: str}')
  AND cal.tesco_yrwk = base.tesco_yrwk 
;
---------------------------------------
----BSP TABLE PREP FUTURE-------------- SELECT * FROM BSP_prep_future WHERE part_col = '20240412' AND bpr_tpn = 100241425 AND int_cntr_code = 'SK' AND ro_no = 1006 
---------------------------------------
REFRESH TABLE stg_go.go_131_bsp_extract;
uncache table if exists BSP_prep_future;
drop view if exists BSP_prep_future;
cache table BSP_prep_future as

SELECT date_format(cal2.iso_date,'yyyyMMdd') as part_col
,b.int_cntr_code
,b.ro_no
,b.bpr_tpn
,b.tesco_yrwk
,b.step_ind
,b.adj_sales
,b.exp_sales
FROM
  (SELECT DISTINCT int_cntr_code
  ,ro_no
  ,bpr_tpn
  ,tesco_yrwk
  ,tesco_weekday
  ,struct
  ,struct.col1 as step_ind
  ,CAST(struct.col2 AS DECIMAL(10,2)) as adj_sales
  ,CAST(struct.col3 AS DECIMAL(10,2)) as exp_sales
  FROM(
      SELECT base.int_cntr_code
      ,base.part_col
      ,cal.iso_date as iso_date
      ,base.ro_no
      ,base.bpr_tpn
      ,base.tesco_yrwk
      ,MAP('1', STRUCT(CAST(step_ind_1 AS STRING),CAST(adj_sales_sngls_1 AS STRING), CAST(exp_daily_sales_1 AS STRING)),
          '2', STRUCT(CAST(step_ind_2 AS STRING),CAST(adj_sales_sngls_2 AS STRING), CAST(exp_daily_sales_2 AS STRING)),
          '3', STRUCT(CAST(step_ind_3 AS STRING),CAST(adj_sales_sngls_3 AS STRING), CAST(exp_daily_sales_3 AS STRING)),
          '4', STRUCT(CAST(step_ind_4 AS STRING),CAST(adj_sales_sngls_4 AS STRING), CAST(exp_daily_sales_4 AS STRING)),
          '5', STRUCT(CAST(step_ind_5 AS STRING),CAST(adj_sales_sngls_5 AS STRING), CAST(exp_daily_sales_5 AS STRING)),
          '6', STRUCT(CAST(step_ind_6 AS STRING),CAST(adj_sales_sngls_6 AS STRING), CAST(exp_daily_sales_6 AS STRING)),
          '7', STRUCT(CAST(step_ind_7 AS STRING),CAST(adj_sales_sngls_7 AS STRING), CAST(exp_daily_sales_7 AS STRING))) AS sales_map
      FROM stg_go.go_131_bsp_extract AS base

      INNER JOIN CALENDAR AS cal
      ON base.part_col = DATE_FORMAT(CURRENT_DATE, 'yyyyMMdd')
      AND cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
      AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
      
      INNER JOIN dm.dim_artgld_details AS artgld 
      ON artgld.cntr_code = base.int_cntr_code
      AND artgld.slad_tpnb = base.bpr_tpn
      AND CAST(artgld.dmat_dep_code AS INT) IN (${Department list | type: raw})
      
      WHERE base.int_cntr_code = UPPER('${Country code | type: str}') 
      ) AS orig_table_alias LATERAL VIEW OUTER EXPLODE(sales_map) AS tesco_weekday,struct
  ) as b
  
INNER JOIN CALENDAR as cal2
ON cal2.tesco_yrwk = b.tesco_yrwk
AND b.tesco_weekday = cal2.dtdw_id
  
WHERE cal2.iso_date >= CURRENT_DATE
;
--------------------------------------- 
----BSP PROMO IND FEATURE-------------- 
--------------------------------------- 
REFRESH TABLE stg_go.go_131_bsp_extract;
uncache table if exists Promo_count_table;
drop view if exists Promo_count_table;
cache table Promo_count_table as

SELECT b.int_cntr_code
,b.part_col
,rms.RMS_ID
,rms.sg_cd
,b.ro_no
,SUM(CASE WHEN b.step_ind IN ('P','B') THEN COALESCE(p.promo_price,ps.promo_price) ELSE NULL END) as promo_price_sum
,SUM(CASE WHEN b.step_ind IN ('P','B') THEN CASE WHEN COALESCE(p.promo_price,ps.promo_price) IS NOT NULL THEN 1 ELSE 0 END ELSE NULL END) AS promo_price_count
,SUM(CASE WHEN b.step_ind IN ('P','B') THEN 1 ELSE 0 END) AS promo_count
,SUM(CASE WHEN b.step_ind IN ('P','B') THEN b.adj_sales ELSE 0 END) AS adj_sales_P_BSP
,SUM(CASE WHEN b.step_ind NOT IN ('P','B') THEN b.adj_sales ELSE 0 END) AS adj_sales_N_BSP
,SUM(CASE WHEN b.step_ind IN ('P','B') THEN b.exp_sales ELSE 0 END) AS exp_sales_P_BSP
,SUM(CASE WHEN b.step_ind NOT IN ('P','B') THEN b.exp_sales ELSE 0 END) AS exp_sales_N_BSP
FROM
  (
  (SELECT * FROM BSP_prep_history)
  UNION ALL
  (SELECT * FROM BSP_prep_future)
  ) as b

LEFT JOIN Promo_prices as p
ON p.tpnb = b.bpr_tpn
AND b.part_col BETWEEN p.promo_start and p.promo_end
AND p.cntr_code = b.int_cntr_code
AND b.step_ind IN ('P','B')

LEFT JOIN Promo_prices_sample as ps
ON ps.tpnb = b.bpr_tpn
AND b.part_col BETWEEN ps.promo_start and ps.promo_end
AND ps.cntr_code = b.int_cntr_code
AND b.step_ind IN ('P','B')
AND ((b.int_cntr_code = 'CZ' AND b.ro_no = 1029)
    OR (b.int_cntr_code = 'SK' AND b.ro_no IN (1014, 1102, 4155))
    OR (b.int_cntr_code = 'HU' AND b.ro_no = 1520))

INNER JOIN RMS_hierarchy as rms
ON rms.slad_tpnb = b.bpr_tpn
AND rms.cntr_code = b.int_cntr_code

WHERE CASE WHEN UPPER('${Country code | type: str}') = 'HU' THEN b.ro_no BETWEEN 1001 AND 5999 ELSE b.ro_no BETWEEN 1001 AND 4999 END

GROUP BY b.int_cntr_code
,b.part_col
,b.ro_no
,rms.RMS_ID
,rms.sg_cd
;
---------------------------------------
-----NORMAL PRICE HISTORY-------------- SELECT * from Normal_price_history LIMIT 5 
--------------------------------------- 
uncache table if exists Normal_price_history;
drop view if exists Normal_price_history;
cache table Normal_price_history as

SELECT ROW_NUMBER() OVER(PARTITION BY tpnb, RMS_ID, store, cntr_id ORDER BY price_day DESC) AS date_rank
,*
FROM 
  (SELECT gld.slad_tpnb as tpnb
  ,gld.RMS_ID
  ,str.dmst_store_id as storeid
  ,SUBSTR(str.dmst_store_code,2,4) AS store
  ,str.dmst_store_code
  ,str.dmst_store_des 
  ,base.* 
  FROM 
    (
    (SELECT * FROM sch_analysts.payweek_price_${Country code | type: raw}_dairy)
    UNION ALL 
    (SELECT * FROM sch_analysts.payweek_price_${Country code | type: raw}_meatfishpoultry)
    UNION ALL
    (SELECT * FROM sch_analysts.payweek_price_${Country code | type: raw}_produce)
    ) as base 
  
  INNER JOIN RMS_hierarchy AS gld
  ON gld.slad_dmat_id = base.dmat_id
  AND gld.cntr_id = base.cntr_id
  
  LEFT JOIN dm.dim_stores as str
  ON str.cntr_id = base.cntr_id
  AND base.dmst_id = str.dmst_store_id
  
  WHERE base.price_rank = 1 
  AND SUBSTR(str.dmst_store_code,2,4) BETWEEN '1000' AND '5999'
  AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})
  )
;
--------------------------------------- 
-----NORMAL PRICE FUTURE--------------- 
--------------------------------------- 
uncache table if exists Normal_price_future;
drop view if exists Normal_price_future;
cache table Normal_price_future as

SELECT b.plrpd_cntr_id as cntr_id
,b.store
,b.tpnb
,b.RMS_ID
,b.retail_price
,b.price_rank
,CAST(b.plrpd_valid_from AS DATE) as valid_from
,CAST(b.plrpd_valid_to AS DATE) as valid_to
,b.part_col
,b.date_rank
,b.price_day
FROM
(SELECT 
p.plrpd_dmst_id as dmst_id
,SUBSTR(str.dmst_store_code,2,4) as store
,gld.slad_tpnb as tpnb
,gld.RMS_ID
,p.plrpd_price as retail_price
,ROW_NUMBER() OVER (PARTITION BY p.plrpd_dmat_id ORDER BY p.plrpd_dmst_id DESC) AS price_rank
,p.* 
,ph.date_rank
,ph.price_day
FROM dw.pl_retail_prices_d as p

INNER JOIN RMS_hierarchy AS gld
ON gld.slad_dmat_id = p.plrpd_dmat_id
AND gld.cntr_id = p.plrpd_cntr_id
AND gld.cntr_code = UPPER(CAST('${Country code | type: raw}' AS STRING))
AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})

LEFT JOIN dm.dim_stores as str
ON str.cntr_id = p.plrpd_cntr_id
AND str.dmst_store_id = p.plrpd_dmst_id 

LEFT JOIN Normal_price_history AS ph
ON ph.date_rank = 1
AND ph.tpnb = gld.slad_tpnb
AND ph.store = SUBSTR(str.dmst_store_code,2,4)

WHERE p.part_col = DATE_FORMAT(CURRENT_DATE,'yyyyMMdd') 
AND CAST(p.plrpd_valid_to AS DATE) >= DATE_ADD(ph.price_day,1)
AND CAST(p.plrpd_valid_to AS DATE) <> '2999-12-31'
AND CASE WHEN UPPER(CAST('${Country code | type: raw}' AS STRING)) = 'SK' THEN p.plrpd_cntr_id = 2 
         WHEN UPPER(CAST('${Country code | type: raw}' AS STRING)) = 'CZ' THEN p.plrpd_cntr_id = 1
         WHEN UPPER(CAST('${Country code | type: raw}' AS STRING)) = 'HU' THEN p.plrpd_cntr_id = 4 END 
) AS b
;
---------------------------------------
----NORMAL PRICE FINAL----------------- 
--------------------------------------- 
uncache table if exists Normal_price; 
drop view if exists Normal_price;
cache table Normal_price as

WITH last_date_price (SELECT * FROM Normal_price_history WHERE date_rank = 1)

SELECT int_cntr_code
,iso_date
,tesco_yrwk
,store
,RMS_ID
,SUM(retail_price) as normal_retail_price_sum
,SUM(CASE WHEN retail_price IS NOT NULL THEN 1 ELSE 0 END) as normal_retail_price_count
FROM 
  (SELECT b.int_cntr_code
  ,b.iso_date
  ,b.tesco_yrwk
  ,b.ro_no as store
  ,b.bpr_tpn as tpnb
  ,b.RMS_ID
  ,COALESCE(pf.retail_price,b.retail_price) as retail_price
  FROM
    (SELECT base.*
    ,COALESCE(ph.retail_price,pld.retail_price) as retail_price
    FROM Tpnb_table AS base
    
    LEFT JOIN Normal_price_history as ph
    ON base.iso_date = ph.price_day
    AND base.int_cntr_id = ph.cntr_id
    AND base.ro_no = ph.store
    AND base.bpr_tpn = ph.tpnb
    
    LEFT JOIN last_date_price as pld
    ON base.int_cntr_id = pld.cntr_id
    AND base.ro_no = pld.store
    AND base.bpr_tpn = pld.tpnb
    ) AS b
  
  LEFT JOIN Normal_price_future as pf
  ON b.iso_date BETWEEN pf.valid_from AND pf.valid_to
  AND b.int_cntr_id = pf.cntr_id
  AND b.ro_no = pf.store
  AND b.bpr_tpn = pf.tpnb
  )

GROUP BY RMS_ID,int_cntr_code,iso_date,tesco_yrwk,store
;
---------------------------------------
----WEATHER FACTORS--------------------
---------------------------------------
uncache table if exists Weather_factor;
drop view if exists Weather_factor;
cache table Weather_factor as

SELECT cntr_code
,RMS_ID
,ro_no
,iso_date
,COUNT(wthrfactor) as wthrfactor_count
,SUM(wthrfactor) as wthrfactor_sum
,SUM(wthrfactor*sales) as wthrfactor_sum_f
,SUM(sales) as wthrfactor_sum_sales
,SUM(wthrfactor*sales)/SUM(sales) as weighted_wf
FROM 
  (
  (SELECT gld.cntr_code
  ,gld.slad_tpnb as tpnb
  ,gld.RMS_ID
  ,w.ro_no
  ,cal.iso_date
  ,CASE WHEN cal.dtdw_id = 1 THEN wf_day_1
        WHEN cal.dtdw_id = 2 THEN wf_day_2
        WHEN cal.dtdw_id = 3 THEN wf_day_3
        WHEN cal.dtdw_id = 4 THEN wf_day_4
        WHEN cal.dtdw_id = 5 THEN wf_day_5
        WHEN cal.dtdw_id = 6 THEN wf_day_6
        WHEN cal.dtdw_id = 7 THEN wf_day_7
   END AS wthrfactor
  ,bsp.adj_sales AS sales
  FROM stg_go.go_551_rwf as W
  
  INNER JOIN RMS_hierarchy AS gld
  ON gld.cntr_code = w.int_cntr_code
  AND gld.slad_tpnb = w.bpr_tpn
  AND gld.cntr_code = UPPER(CAST('${Country code | type: raw}' AS STRING))
  AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})
  
  INNER JOIN CALENDAR AS cal
  ON date_format(cal.iso_date,'yyyyMMdd') = w.part_col
  AND cal.iso_date <= CURRENT_DATE
  AND cal.tesco_yrwk = w.tesco_yrwk
  AND cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
  AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)
  
  LEFT JOIN BSP_prep_history AS bsp
  ON w.part_col = bsp.part_col
  AND w.int_cntr_code = gld.cntr_code 
  AND gld.slad_tpnb = bsp.bpr_tpn
  AND w.ro_no = bsp.ro_no
  )
  UNION ALL
  (SELECT gld.cntr_code
  ,gld.slad_tpnb as tpnb
  ,gld.RMS_ID
  ,w.ro_no
  ,cal.iso_date
  ,CASE WHEN cal.dtdw_id = 1 THEN wf_day_1
        WHEN cal.dtdw_id = 2 THEN wf_day_2
        WHEN cal.dtdw_id = 3 THEN wf_day_3
        WHEN cal.dtdw_id = 4 THEN wf_day_4
        WHEN cal.dtdw_id = 5 THEN wf_day_5
        WHEN cal.dtdw_id = 6 THEN wf_day_6
        WHEN cal.dtdw_id = 7 THEN wf_day_7
   END AS wthrfactor
  ,bsp.exp_sales AS sales
  FROM stg_go.go_551_rwf as W
  
  INNER JOIN RMS_hierarchy AS gld
  ON gld.cntr_code = w.int_cntr_code
  AND gld.slad_tpnb = w.bpr_tpn
  AND gld.cntr_code = UPPER(CAST('${Country code | type: raw}' AS STRING))
  AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})
  
  INNER JOIN CALENDAR AS cal
  ON date_format(CURRENT_DATE,'yyyyMMdd') = w.part_col
  AND cal.iso_date >= DATE_ADD(CURRENT_DATE,1)
  AND cal.tesco_yrwk = w.tesco_yrwk
  AND cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
  AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400) 
  
  LEFT JOIN BSP_prep_future AS bsp
  ON bsp.part_col = DATE_FORMAT(cal.iso_date,'yyyyMMdd')
  AND w.int_cntr_code = bsp.int_cntr_code 
  AND gld.slad_tpnb = bsp.bpr_tpn
  AND w.ro_no = bsp.ro_no 
  )  
  )
  
GROUP BY cntr_code
,RMS_ID
,ro_no
,iso_date
;
---------------------------------------  
----DATA PREPARATION PART1-------------  
---------------------------------------
uncache table if exists Data_prep_1;
drop view if exists Data_prep_1;
cache table Data_prep_1 as

--CTE START
WITH event_df AS
(
SELECT c.iso_date
,b.*
FROM(
  SELECT distinct cal1.tesco_yrwk AS tesco_yrwk_from
  ,cal2.tesco_yrwk AS tesco_yrwk_to
  ,b.country_code
  ,b.ID
  ,b.event_holiday_name 
  FROM sch_analysts.holiday_events_ce as b
 
  INNER JOIN CALENDAR as cal1
  ON cal1.iso_date = DATE_ADD(b.date_from,-4)
  
  INNER JOIN CALENDAR as cal2
  ON cal2.iso_date = b.date_to
  
  WHERE split(b.event_holiday_name,' ')[0] IN ('Christmas','Easter') 
  AND b.type_ = 'event'
  ) as b
  
LEFT JOIN CALENDAR as c
ON c.tesco_yrwk BETWEEN tesco_yrwk_from AND tesco_yrwk_to
)

,event_df2 AS
(select distinct DATE_ADD(date_,-7) as date_from, DATE_ADD(date_,1) as date_to, date_, country_code, ID, event_holiday_name,split(event_holiday_name,' ')[0] as zero FROM sch_analysts.holiday_events_ce 
  WHERE type_ = 'event'
  AND (trim(split(event_holiday_name,' ')[0]) IN ('Summer',"Valentine's","woman's","mother's")
  OR trim(split(event_holiday_name,' ')[1]) IN ('Summer',"Valentine's","woman's","mother's")
  OR trim(split(event_holiday_name,' ')[2]) IN ('Summer',"Valentine's","woman's","mother's"))  
  )
--CTE END

SELECT distinct r.cntr_code AS int_cntr_code 
,cal.iso_date
,YEAR(cal.iso_date) AS year
,MONTH(cal.iso_date) AS month_name
,cal.dmtm_fd_daynum as month_day
,cal.tesco_yrwk 
,COALESCE(event.ID,event2.ID,0) as event_id
,COALESCE(cal.dtdw_id,0) as weekday
,cal.small_payday_id
,cal.large_payday_id
,cal.HU_pensions_id
,r.RMS_ID
,r.sg_cd
,r.dmat_div_code
,r.dmat_dep_code
,r.dmat_dep_des_en
,r.dmat_sec_code
,r.dmat_sec_des_en
,r.dmat_grp_code
,r.dmat_grp_des_en
,r.dmat_sgr_code as dmat_sgr_code
,r.dmat_sgr_des_en as dmat_sgr_des_en
,CAST(clus.store as INT) as store
,clus.store_cluster
FROM CALENDAR as cal

INNER JOIN 
(SELECT distinct cntr_code
  ,RMS_ID
  ,sg_cd
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,dmat_grp_code
  ,dmat_grp_des_en
  ,dmat_sgr_code
  ,dmat_sgr_des_en
  FROM RMS_hierarchy) as r
ON CAST(r.dmat_dep_code AS INT) IN (${Department list | type: raw})
AND r.cntr_code = UPPER('${Country code | type: str}')

--STORE CLUSTERS
FULL OUTER JOIN sch_analysts.ce_tbl_payweek_clusters_feb as clus
ON clus.int_cntr_code = r.cntr_code
AND clus.RMS_ID  = CONCAT(CAST(r.dmat_div_code AS INT),CAST(r.dmat_dep_code AS INT))

--MAJOR EVENTS
LEFT JOIN event_df as event
ON event.country_code = r.cntr_code
AND cal.iso_date = event.iso_date

--PRODUCE EVENTS - FLOWERS
LEFT JOIN event_df2 as event2
ON event2.country_code = r.cntr_code
AND cal.iso_date BETWEEN event2.date_from AND event2.date_to  
AND CONCAT(CAST(r.dmat_div_code AS INT),CAST(r.dmat_dep_code AS INT),CAST(r.dmat_sec_code AS INT)) == '1121205'

WHERE cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
;
--------------------------------------- 
----DATA PREPARATION PART2------------- SELECT * FROM Data_prep_1 LIMIT 10
---------------------------------------
uncache table if exists Data_prep_2;
drop view if exists Data_prep_2;
cache table Data_prep_2 as

SELECT CASE WHEN base.iso_date BETWEEN DATE_ADD(${Training end date | type: date},-358) AND DATE_ADD(${Training end date | type: date},-330) THEN 1 ELSE 0 END AS LY_week_range -- -365-330
,CASE WHEN base.iso_date BETWEEN DATE_ADD(${Training end date | type: date},-28) AND '${Training end date | type: date}' THEN 1 ELSE 0 END AS TY_week_range  --42
,CASE WHEN base.iso_date > ${Training end date | type: date} THEN 1 ELSE 0 END AS fcst_week_id
,CASE WHEN base.weekday = 1 AND base.iso_date BETWEEN '2023-02-01' AND '2023-07-31' THEN 0.5 ELSE 0 END AS monday_pensioners
,base.*
,COALESCE(np.normal_retail_price_sum,0) AS normal_retail_price_sum
,COALESCE(np.normal_retail_price_count,0) AS normal_retail_price_count
,COALESCE(rng.tpnb_count,0) AS tpnb_count
,COALESCE(prm.promo_count,0) as promo_count
,COALESCE(prm.promo_price_sum) as promo_price_sum
,COALESCE(prm.promo_price_count) as promo_price_count
,ROUND(COALESCE(prm.adj_sales_P_BSP,0)*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo),2) AS adj_sales_P_BSP
,COALESCE(prm.adj_sales_N_BSP,0) as adj_sales_N_BSP
,ROUND(COALESCE(prm.exp_sales_P_BSP,0)*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo),2) AS exp_sales_P_BSP
,COALESCE(prm.exp_sales_N_BSP,0) as exp_sales_N_BSP
,COALESCE(wf.wthrfactor_sum_f,1) as wthrfactor_sum_f
,COALESCE(wf.wthrfactor_sum_sales,1) as wthrfactor_sum_sales
,COALESCE(wf.wthrfactor_count,1) as wthrfactor_count
,COALESCE(wf.wthrfactor_sum,1) as wthrfactor_sum
FROM Data_prep_1 AS base

--COEFFICIENT TABLE FOR SECTION LEVEL
LEFT JOIN (SELECT int_cntr_code, CAST(department_num as INT) as department_num, CAST(section_num as INT) as section_num, CAST(coefficient_promo_non_promo as DECIMAL(10,3)) as coefficient_promo_non_promo FROM sch_analysts.ce_tbl_event_promo_coefficients WHERE CAST(section_num as INT) NOT IN ("0")) as coef_sec
ON coef_sec.int_cntr_code = base.int_cntr_code
AND coef_sec.section_num = CAST(base.dmat_sec_code AS INT)
AND coef_sec.department_num = CAST(base.dmat_dep_code AS INT)

 --COEFFICIENT TABLE FOR DEPARTMENT LEVEL  
INNER JOIN (SELECT int_cntr_code, CAST(department_num as INT) as department_num, CAST(section_num as INT) as section_num, CAST(coefficient_promo_non_promo as DECIMAL(10,3)) as coefficient_promo_non_promo FROM sch_analysts.ce_tbl_event_promo_coefficients WHERE CAST(section_num as INT) IN ("0")) as coef_dep
ON coef_dep.int_cntr_code = base.int_cntr_code
AND coef_dep.department_num = CAST(base.dmat_dep_code AS INT)

LEFT JOIN Tpnb_count_table as rng
ON rng.ro_no = base.store
AND rng.int_cntr_code = base.int_cntr_code
AND rng.RMS_ID = base.RMS_ID
AND rng.iso_date = base.iso_date

LEFT JOIN Promo_count_table as prm
ON prm.ro_no = base.store
AND prm.int_cntr_code = base.int_cntr_code
AND prm.part_col = date_format(base.iso_date,'yyyyMMdd')
AND prm.RMS_ID = base.RMS_ID

--NORMAL PRICE 
LEFT JOIN Normal_price as np
ON np.store = base.store
AND np.RMS_ID = base.RMS_ID 
AND base.iso_date = np.iso_date

--WEATHER FACTORS
LEFT JOIN Weather_factor as wf
ON wf.ro_no = base.store
AND wf.RMS_ID = base.RMS_ID
AND wf.iso_date = base.iso_date

WHERE event_id = 0
; 
------------------------------------------ 
--DATA PREPARATION BH PART 1--------------
------------------------------------------
uncache table if exists Data_prep_BH_1;
drop view if exists Data_prep_BH_1;
cache table Data_prep_BH_1 as

SELECT BH_date
,weekday
,country_code
,preceding as lower_window
,following as upper_window
,DATE_ADD(BH_date,preceding) as BH_from
,DATE_ADD(BH_date,following) as BH_to
,ID
FROM
  (SELECT distinct b.date_ as BH_date
  ,c.dtdw_id as weekday
  ,CASE WHEN c.dtdw_id BETWEEN 2 AND 4 THEN -1 
        WHEN c.dtdw_id = 5 THEN -1  
        WHEN c.dtdw_id = 6 THEN -1
        WHEN c.dtdw_id = 7 THEN -2
        WHEN c.dtdw_id = 1 THEN -3 END AS preceding
  ,CASE WHEN c.dtdw_id BETWEEN 2 AND 4 THEN 0
        WHEN c.dtdw_id = 5 THEN 2  
        WHEN c.dtdw_id = 6 THEN 1
        WHEN c.dtdw_id = 7 THEN 0
        WHEN c.dtdw_id = 1 THEN 0 END AS following
  ,b.country_code
  ,b.ID 
  FROM sch_analysts.holiday_events_ce as b
  
  INNER JOIN CALENDAR AS c
  ON  b.date_ = c.iso_date
  WHERE b.type_ = 'bank_holiday')
;
------------------------------------------ 
--DATA PREPARATION BH PART 2--------------
------------------------------------------
uncache table if exists Data_prep_BH_2;
drop view if exists Data_prep_BH_2;
cache table Data_prep_BH_2 as

SELECT DISTINCT COALESCE(hol.ID,0) AS bank_holiday_excl
,COALESCE(hol2.ID,0) AS bank_holiday_id
,COALESCE(hol2.lower_window) AS bh_lower_window
,COALESCE(hol2.upper_window) AS bh_upper_window
,b.* FROM Data_prep_2 AS b

LEFT JOIN Data_prep_BH_1 AS hol
ON hol.country_code = b.int_cntr_code
AND b.iso_date BETWEEN hol.BH_from AND hol.BH_to

LEFT JOIN Data_prep_BH_1 AS hol2
ON hol2.country_code = b.int_cntr_code
AND b.iso_date = hol2.BH_date
;
--------------------------------------- 
-----HISTORICAL SALES ----------------- 
--------------------------------------- 
drop table if exists sch_analysts.tbl_ce_payweek_data_sales;
set spark.sql.legacy.timeParserPolicy=LEGACY;
set spark.sql.parquet.writeLegacyFormat=true;
CREATE EXTERNAL TABLE sch_analysts.tbl_ce_payweek_data_sales
TBLPROPERTIES('external.table.purge'='TRUE')
STORED AS ORC
LOCATION "s3a://cep-sch-analysts-db/sch_analysts_external/tbl_ce_payweek_data_sales" as

SELECT sal.int_cntr_code 
,gld.RMS_ID
,gld.sg_cd
,cal.iso_date 
,sal.store
,clus.store_cluster
,gld.dmat_div_code
,gld.dmat_dep_code
,gld.dmat_dep_des_en
,gld.dmat_sec_code
,gld.dmat_sec_des_en
,gld.dmat_grp_code
,gld.dmat_grp_des_en
,gld.dmat_sgr_code as dmat_sgr_code
,gld.dmat_sgr_des_en as dmat_sgr_des_en
,ROUND(SUM(CASE WHEN step_ind IN ('P','B') THEN sal.adj_sales_sngls*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo) ELSE 0 END),2) AS adj_sales_P
,ROUND(SUM(CASE WHEN step_ind NOT IN ('P','B') THEN sal.adj_sales_sngls ELSE 0 END),2) AS adj_sales_N
,ROUND(SUM(CASE WHEN step_ind IN ('P','B')  THEN sal.adj_sales_sngls*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo)  ELSE sal.adj_sales_sngls END),2) AS adj_sales_total_coef
,ROUND(SUM(CASE WHEN step_ind IN ('P','B')  THEN sal.exp_daily_sales*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo)  ELSE sal.exp_daily_sales END),2) AS exp_daily_sales_coef
,ROUND(SUM(CASE WHEN step_ind IN ('P','B')  THEN sal.act_sales_sngls*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo)  ELSE sal.act_sales_sngls END),2) AS act_sales_coef
,ROUND(SUM(CASE WHEN step_ind IN ('P','B')  THEN sal.lost_sales_sngls*COALESCE(coef_sec.coefficient_promo_non_promo,coef_dep.coefficient_promo_non_promo) ELSE sal.lost_sales_sngls END),2) AS lost_sales_coef
FROM dw_go.go_historical_sales sal
  
INNER JOIN CALENDAR as cal
ON date_format(cal.iso_date,'yyyyMMdd') = sal.part_col 

INNER JOIN RMS_hierarchy AS gld
ON sal.int_cntr_code = gld.cntr_code
AND sal.tpnb = gld.slad_tpnb
AND CAST(gld.dmat_dep_code AS INT) IN (${Department list | type: raw})

--COEFFICIENT TABLE FOR SECTION LEVEL
LEFT JOIN (SELECT int_cntr_code, CAST(department_num as INT) as department_num, CAST(section_num as INT) as section_num, CAST(coefficient_promo_non_promo as DECIMAL(10,3)) as coefficient_promo_non_promo FROM sch_analysts.ce_tbl_event_promo_coefficients WHERE CAST(section_num as INT) NOT IN ("0")) as coef_sec
ON coef_sec.int_cntr_code = sal.int_cntr_code
AND coef_sec.section_num = CAST(gld.dmat_sec_code AS INT)
AND coef_sec.department_num = CAST(gld.dmat_dep_code AS INT)

 --COEFFICIENT TABLE FOR DEPARTMENT LEVEL  
INNER JOIN (SELECT int_cntr_code, CAST(department_num as INT) as department_num, CAST(section_num as INT) as section_num, CAST(coefficient_promo_non_promo as DECIMAL(10,3)) as coefficient_promo_non_promo FROM sch_analysts.ce_tbl_event_promo_coefficients WHERE CAST(section_num as INT) IN ("0")) as coef_dep
ON coef_dep.int_cntr_code = sal.int_cntr_code
AND coef_dep.department_num = CAST(gld.dmat_dep_code AS INT)

INNER JOIN sch_analysts.ce_tbl_payweek_clusters_feb as clus
ON CAST(clus.store AS INT) = sal.store
AND clus.int_cntr_code = sal.int_cntr_code
AND clus.RMS_ID  = CONCAT(CAST(gld.dmat_div_code AS INT),CAST(gld.dmat_dep_code AS INT))

WHERE sal.int_cntr_code = UPPER('${Country code | type: str}')
AND cal.tesco_yrwk <= GREATEST(${Payweeks_forecasted | type: raw}) 
AND cal.iso_date >= DATE_ADD(${Training end date | type: date},-400)  
  
GROUP BY sal.int_cntr_code 
,cal.iso_date
,sal.store
,clus.store_cluster
,sal.tesco_yrwk
,gld.RMS_ID
,gld.sg_cd
,gld.dmat_div_code
,gld.dmat_dep_code
,gld.dmat_dep_code
,gld.dmat_dep_des_en
,gld.dmat_sec_code
,gld.dmat_sec_des_en
,gld.dmat_grp_code
,gld.dmat_grp_des_en
,gld.dmat_sgr_code
,gld.dmat_sgr_des_en
;
----------------------------- SELECT * FROM sch_analysts.tbl_ce_payweek_data limit 5 WHERE RMS_ID = 11313071511 AND STORE = 1036 ORDER BY iso_date DESC
--BASE TABLE----------------- 
----------------------------- 
drop table if exists sch_analysts.tbl_ce_payweek_data_base;
set spark.sql.legacy.timeParserPolicy=LEGACY;
set spark.sql.parquet.writeLegacyFormat=true;
CREATE EXTERNAL TABLE sch_analysts.tbl_ce_payweek_data_base
TBLPROPERTIES('external.table.purge'='TRUE')
STORED AS ORC
LOCATION "s3a://cep-sch-analysts-db/sch_analysts_external/tbl_ce_payweek_data_base" as

SELECT base.* 
FROM
  (SELECT base.*
  ,sal.adj_sales_P AS adj_sales_P
  ,sal.adj_sales_N AS adj_sales_N
  ,sal.adj_sales_total_coef AS adj_sales_total_coef
  ,sal.exp_daily_sales_coef AS exp_daily_sales_coef
  ,sal.act_sales_coef AS act_sales_coef
  ,sal.lost_sales_coef AS lost_sales_coef
  FROM Data_prep_BH_2 AS base
  
  LEFT JOIN sch_analysts.tbl_ce_payweek_data_sales AS sal
  ON sal.store = base.store
  AND sal.RMS_ID = base.RMS_ID
  AND sal.iso_date = base.iso_date
  ) as base
; 
drop table if exists sch_analysts.tbl_ce_payweek_data;
set spark.sql.legacy.timeParserPolicy=LEGACY;
set spark.sql.parquet.writeLegacyFormat=true;
CREATE EXTERNAL TABLE sch_analysts.tbl_ce_payweek_data
TBLPROPERTIES('external.table.purge'='TRUE')
STORED AS ORC
LOCATION "s3a://cep-sch-analysts-db/sch_analysts_external/tbl_ce_payweek_data" as

SELECT *
,CASE WHEN tpnb_count = 0 AND tpnb_count_cluster_date = 0 AND adj_sales_cluster_date > 0 THEN LAG(tpnb_count,1) OVER(PARTITION BY RMS_ID, store_cluster, store ORDER BY iso_date asc) ELSE tpnb_count END as tpnb_count_v2
FROM
  (SELECT *
  ,SUM(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID, iso_date) as tpnb_count_cluster_date
  ,SUM(adj_sales_total_coef) OVER(PARTITION BY store_cluster, RMS_ID, iso_date) as adj_sales_cluster_date
  FROM sch_analysts.tbl_ce_payweek_data_base
  ORDER BY RMS_ID, store_cluster , iso_date ASC)
;
--CLEANING TABLES
DROP TABLE IF EXISTS sch_analysts.tbl_ce_payweek_data_base;
DROP TABLE IF EXISTS sch_analysts.tbl_ce_payweek_data_sales;
----------------------------- 
--SUBGROUP LEVEL-------------   SELECT * FROM SGR WHERE RMS_ID = 11414071211 AND store_cluster = 'Large-Intense' 
-----------------------------
uncache table if exists SGR;
drop view if exists SGR;
cache table SGR as

SELECT *
,STDDEV_POP(CASE WHEN tesco_yrwk_days = 7 AND filt_ptp_BH_excl = 0 AND (LY_week_range = 1 OR TY_week_range = 1) THEN filt_ptp ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) AS ptp_reg_weight
FROM
  (SELECT *
  --FILTERING CONDITIONS
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales_LY
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as avg_sales_per_day
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) AS avg_sales_per_day_LY
  ,MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/MIN(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID) AS seasonality_ratio
  ,adj_sales/(SUM(adj_sales) OVER(partition by store_cluster, RMS_ID, tesco_yrwk)) as filt_ptp
  ,MAX(bank_holiday_id) OVER(partition by store_cluster, RMS_ID, tesco_yrwk) as filt_ptp_BH_excl
  ,COUNT(CASE WHEN LY_week_range = 1 OR TY_week_range = 1 THEN tesco_yrwk ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) as tesco_yrwk_days
  ,(SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID))/(MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/30) as seasonality_filter
  ,SUM(CASE WHEN fcst_week_id = 1 AND event_id = 1 THEN 1 ELSE 0 END) over(partition by store_cluster,RMS_ID) AS event_present
  --REGRESSORS
  ,CASE WHEN (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_tpnb_count 
  ,CASE WHEN (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_promo_sales
  ,CASE WHEN (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_normal_retail_price
  ,CASE WHEN (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_promo_price
  ,CASE WHEN (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_total_price
  ,CASE WHEN (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_wthrfactor
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 THEN tpnb_count ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_tpnb_count

  FROM
  (SELECT int_cntr_code
  ,CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT),CAST(dmat_sgr_code AS INT)) as RMS_ID
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,dmat_grp_code
  ,dmat_grp_des_en
  ,dmat_sgr_code
  ,dmat_sgr_des_en
  ,sg_cd
  ,store_cluster
  ,iso_date
  ,CONCAT(YEAR(iso_date),MONTH(iso_date)) as yearmonth
  ,SUM(CASE WHEN fcst_week_id = 0 THEN 1 ELSE 0 END) OVER(PARTITION BY CONCAT(YEAR(iso_date),MONTH(iso_date)),CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT),CAST(dmat_sgr_code AS INT)),store_cluster) as yearmonth_days
  ,SUM(CASE WHEN fcst_week_id = 0 AND TY_week_range = 1 THEN 1 ELSE 0 END) OVER(PARTITION BY tesco_yrwk, CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT),CAST(dmat_sgr_code AS INT)),store_cluster) as yearweek_days
  ,tesco_yrwk
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,SUM(normal_retail_price_sum)/SUM(normal_retail_price_count) as normal_retailprice_avg 
  ,COALESCE(SUM(promo_price_sum)/SUM(promo_price_count),SUM(normal_retail_price_sum)/SUM(normal_retail_price_count)) as promoprice_avg 
  ,(SUM(normal_retail_price_sum)+COALESCE(SUM(promo_price_sum),0))/(SUM(normal_retail_price_count)+COALESCE(SUM(promo_price_count),0)) as total_price_avg
  ,COALESCE(SUM(wthrfactor_sum_f)/SUM(wthrfactor_sum_sales),SUM(wthrfactor_sum)/SUM(wthrfactor_count)) as wthrfactor
  ,COUNT(distinct store) AS store_count
  ,SUM(tpnb_count_v2) AS tpnb_count
  ,SUM(promo_count) AS promo_count
  ,SUM(CASE WHEN iso_date >= CURRENT_DATE THEN exp_sales_P_BSP ELSE adj_sales_P_BSP END) AS sales_P_BSP
  ,COALESCE(SUM(adj_sales_N),0) as adj_sales_N
  ,COALESCE(SUM(adj_sales_P),0) as adj_sales_P
  ,COALESCE(SUM(adj_sales_total_coef),0) AS adj_sales
  ,COALESCE(SUM(exp_daily_sales_coef),0) AS exp_sales
  ,COALESCE(SUM(act_sales_coef),0) AS act_sales
  ,COALESCE(SUM(lost_sales_coef),0) AS lost_sales
  FROM sch_analysts.tbl_ce_payweek_data

  GROUP BY int_cntr_code
  ,sg_cd
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,iso_date
  ,tesco_yrwk
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,dmat_grp_code
  ,dmat_grp_des_en
  ,dmat_sgr_code
  ,dmat_sgr_des_en
  ,store_cluster
  )
  )

WHERE 
avg_sales_per_day > 70 AND
((seasonality_ratio >= 8 AND avg_sales_per_day_LY > 100 AND minimum_sales_LY > 50) OR (seasonality_ratio < 8 AND avg_sales_per_day_LY > 70 AND minimum_sales_LY > 50)) AND 
((seasonality_ratio >= 15 AND seasonality_filter > 0.1) OR (seasonality_ratio < 15)) AND 
minimum_tpnb_count > 0 AND
event_present = 0 AND
((dmat_dep_des_en = 'Dairy' AND minimum_sales > 30) OR (dmat_dep_des_en <> 'Dairy' AND (seasonality_ratio >= 3 OR minimum_sales > 30))) 
;
-----------------------------
---GROUP LEVEL--------------- SELECT * FROM GRP WHERE RMS_ID = 112120513 and store_cluster = 'Large-Intense' ORDER BY iso_date DESC
-----------------------------
uncache table if exists GRP; 
drop view if exists GRP;
cache table GRP as

SELECT *
,STDDEV_POP(CASE WHEN tesco_yrwk_days = 7 AND filt_ptp_BH_excl = 0 AND (LY_week_range = 1 OR TY_week_range = 1) THEN filt_ptp ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) AS ptp_reg_weight
FROM
  (SELECT *
  --FILTERING CONDITIONS
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales_LY
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as avg_sales_per_day
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) AS avg_sales_per_day_LY
  ,MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/MIN(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID) AS seasonality_ratio
  ,adj_sales/(SUM(adj_sales) OVER(partition by store_cluster, RMS_ID, tesco_yrwk)) as filt_ptp
  ,MAX(bank_holiday_id) OVER(partition by store_cluster, RMS_ID, tesco_yrwk) as filt_ptp_BH_excl
  ,COUNT(CASE WHEN LY_week_range = 1 OR TY_week_range = 1 THEN tesco_yrwk ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) as tesco_yrwk_days
  ,(SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID))/(MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/30) as seasonality_filter
  ,SUM(CASE WHEN fcst_week_id = 1 AND event_id = 1 THEN 1 ELSE 0 END) over(partition by store_cluster,RMS_ID) AS event_present
  --REGRESSORS
  ,CASE WHEN (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_tpnb_count 
  ,CASE WHEN (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_promo_sales
  ,CASE WHEN (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_normal_retail_price
  ,CASE WHEN (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_promo_price
  ,CASE WHEN (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_total_price
  ,CASE WHEN (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_wthrfactor
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 THEN tpnb_count ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_tpnb_count
  FROM
  (SELECT int_cntr_code
  ,CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT)) as RMS_ID
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,dmat_grp_code
  ,dmat_grp_des_en
  ,"-" as dmat_sgr_code
  ,"-" as dmat_sgr_des_en
  ,SUBSTR(sg_cd,1,4) as sg_cd
  ,store_cluster
  ,iso_date
  ,CONCAT(YEAR(iso_date),MONTH(iso_date)) as yearmonth
  ,SUM(CASE WHEN fcst_week_id = 0 THEN 1 ELSE 0 END) OVER(PARTITION BY CONCAT(YEAR(iso_date),MONTH(iso_date)),CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT)),store_cluster) as yearmonth_days
  ,SUM(CASE WHEN fcst_week_id = 0 AND TY_week_range = 1 THEN 1 ELSE 0 END) OVER(PARTITION BY tesco_yrwk, CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT),CAST(dmat_grp_code AS INT)),store_cluster) as yearweek_days
  ,tesco_yrwk
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,SUM(normal_retail_price_sum)/SUM(normal_retail_price_count) as normal_retailprice_avg 
  ,COALESCE(SUM(promo_price_sum)/SUM(promo_price_count),SUM(normal_retail_price_sum)/SUM(normal_retail_price_count)) as promoprice_avg 
  ,(SUM(normal_retail_price_sum)+COALESCE(SUM(promo_price_sum),0))/(SUM(normal_retail_price_count)+COALESCE(SUM(promo_price_count),0)) as total_price_avg
  ,COALESCE(SUM(wthrfactor_sum_f)/SUM(wthrfactor_sum_sales),SUM(wthrfactor_sum)/SUM(wthrfactor_count)) as wthrfactor
  ,COUNT(distinct store) AS store_count
  ,SUM(tpnb_count_v2) AS tpnb_count
  ,SUM(promo_count) AS promo_count
  ,SUM(CASE WHEN iso_date >= CURRENT_DATE THEN exp_sales_P_BSP ELSE adj_sales_P_BSP END) AS sales_P_BSP
  ,COALESCE(SUM(adj_sales_N),0) as adj_sales_N
  ,COALESCE(SUM(adj_sales_P),0) as adj_sales_P
  ,COALESCE(SUM(adj_sales_total_coef),0) AS adj_sales
  ,COALESCE(SUM(exp_daily_sales_coef),0) AS exp_sales
  ,COALESCE(SUM(act_sales_coef),0) AS act_sales
  ,COALESCE(SUM(lost_sales_coef),0) AS lost_sales
  FROM sch_analysts.tbl_ce_payweek_data

  GROUP BY int_cntr_code
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,iso_date
  ,tesco_yrwk
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,dmat_grp_code
  ,dmat_grp_des_en
  ,store_cluster
  ,SUBSTR(sg_cd,1,4)
  ,monday_pensioners
  )
  )

WHERE 
avg_sales_per_day > 70 AND
((seasonality_ratio >= 8 AND avg_sales_per_day_LY > 100 AND minimum_sales_LY > 50) OR (seasonality_ratio < 8 AND avg_sales_per_day_LY > 70 AND minimum_sales_LY > 50)) AND  
((seasonality_ratio >= 15 AND seasonality_filter > 0.1) OR (seasonality_ratio < 15)) AND 
minimum_tpnb_count >0 AND
event_present = 0 AND
((dmat_dep_des_en = 'Dairy' AND minimum_sales > 30) OR (dmat_dep_des_en <> 'Dairy' AND (seasonality_ratio >= 3 OR minimum_sales > 30))) 
;
-----------------------------
---SECTION LEVEL-------------
----------------------------- SELECT * FROM SEC WHERE RMS_ID = 112120513 
uncache table if exists SEC; 
drop view if exists SEC;
cache table SEC as

SELECT *
,STDDEV_POP(CASE WHEN tesco_yrwk_days = 7 AND filt_ptp_BH_excl = 0 AND (LY_week_range = 1 OR TY_week_range = 1) THEN filt_ptp ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) AS ptp_reg_weight
FROM
  (SELECT *
  --FILTERING CONDITIONS
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_sales_LY
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND fcst_week_id = 0  THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) as avg_sales_per_day
  ,SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID) AS avg_sales_per_day_LY
  ,MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/MIN(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID) AS seasonality_ratio
  ,adj_sales/(SUM(adj_sales) OVER(partition by store_cluster, RMS_ID, tesco_yrwk)) as filt_ptp
  ,MAX(bank_holiday_id) OVER(partition by store_cluster, RMS_ID, tesco_yrwk) as filt_ptp_BH_excl
  ,COUNT(CASE WHEN LY_week_range = 1 OR TY_week_range = 1 THEN tesco_yrwk ELSE NULL END) OVER(PARTITION BY store_cluster, RMS_ID, tesco_yrwk) as tesco_yrwk_days
  ,(SUM(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID)/COUNT(CASE WHEN bank_holiday_id = 0 AND event_id = 0 AND LY_week_range = 1 THEN adj_sales ELSE NULL END) over(partition by store_cluster,RMS_ID))/(MAX(SUM(CASE WHEN yearmonth_days < 27 THEN NULL ELSE adj_sales END) over(partition by store_cluster,RMS_ID,yearmonth)) over(partition by store_cluster,RMS_ID)/30) as seasonality_filter
  ,SUM(CASE WHEN fcst_week_id = 1 AND event_id = 1 THEN 1 ELSE 0 END) over(partition by store_cluster,RMS_ID) AS event_present
  --REGRESSORS
  ,CASE WHEN (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (tpnb_count - MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(tpnb_count) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_tpnb_count 
  ,CASE WHEN (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (sales_P_BSP - MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(sales_P_BSP) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_promo_sales
  ,CASE WHEN (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE (normal_retailprice_avg - MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(normal_retailprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_normal_retail_price
  ,CASE WHEN (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (promoprice_avg - MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(promoprice_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_promo_price
  ,CASE WHEN (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (total_price_avg - MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(total_price_avg) OVER(PARTITION BY store_cluster, RMS_ID))*-1 END AS scaled_total_price
  ,CASE WHEN (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) IS NULL THEN 0 ELSE
  (wthrfactor - MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID))/(MAX(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)-MIN(wthrfactor) OVER(PARTITION BY store_cluster, RMS_ID)) END AS scaled_wthrfactor
  ,MIN(CASE WHEN bank_holiday_id = 0 AND event_id = 0 THEN tpnb_count ELSE NULL END) over(partition by store_cluster,RMS_ID) as minimum_tpnb_count
  FROM
  (SELECT int_cntr_code
  ,CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT)) as RMS_ID
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,"-" as dmat_grp_code
  ,"-" as dmat_grp_des_en
  ,"-" as dmat_sgr_code
  ,"-" as dmat_sgr_des_en
  ,SUBSTR(sg_cd,1,3) as sg_cd
  ,store_cluster
  ,iso_date
  ,CONCAT(YEAR(iso_date),MONTH(iso_date)) as yearmonth
  ,SUM(CASE WHEN fcst_week_id = 0 THEN 1 ELSE 0 END) OVER(PARTITION BY CONCAT(YEAR(iso_date),MONTH(iso_date)),CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT)),store_cluster) as yearmonth_days
  ,SUM(CASE WHEN fcst_week_id = 0 AND TY_week_range = 1 THEN 1 ELSE 0 END) OVER(PARTITION BY tesco_yrwk, CONCAT(CAST(dmat_div_code AS INT),CAST(dmat_dep_code AS INT),CAST(dmat_sec_code AS INT)),store_cluster) as yearweek_days
  ,tesco_yrwk
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,SUM(normal_retail_price_sum)/SUM(normal_retail_price_count) as normal_retailprice_avg 
  ,COALESCE(SUM(promo_price_sum)/SUM(promo_price_count),SUM(normal_retail_price_sum)/SUM(normal_retail_price_count)) as promoprice_avg 
  ,(SUM(normal_retail_price_sum)+COALESCE(SUM(promo_price_sum),0))/(SUM(normal_retail_price_count)+COALESCE(SUM(promo_price_count),0)) as total_price_avg
  ,COALESCE(SUM(wthrfactor_sum_f)/SUM(wthrfactor_sum_sales),SUM(wthrfactor_sum)/SUM(wthrfactor_count)) as wthrfactor
  ,COUNT(distinct store) AS store_count
  ,SUM(tpnb_count_v2) AS tpnb_count
  ,SUM(promo_count) AS promo_count
  ,SUM(CASE WHEN iso_date >= CURRENT_DATE THEN exp_sales_P_BSP ELSE adj_sales_P_BSP END) AS sales_P_BSP
  ,COALESCE(SUM(adj_sales_N),0) as adj_sales_N
  ,COALESCE(SUM(adj_sales_P),0) as adj_sales_P
  ,COALESCE(SUM(adj_sales_total_coef),0) AS adj_sales
  ,COALESCE(SUM(exp_daily_sales_coef),0) AS exp_sales
  ,COALESCE(SUM(act_sales_coef),0) AS act_sales
  ,COALESCE(SUM(lost_sales_coef),0) AS lost_sales
  FROM sch_analysts.tbl_ce_payweek_data

  GROUP BY int_cntr_code
  ,LY_week_range
  ,TY_week_range
  ,fcst_week_id
  ,iso_date
  ,tesco_yrwk
  ,weekday
  ,event_id
  ,bank_holiday_id
  ,bh_lower_window
  ,bh_upper_window
  ,small_payday_id
  ,large_payday_id
  ,HU_pensions_id
  ,monday_pensioners
  ,bank_holiday_excl
  ,dmat_div_code
  ,dmat_dep_code
  ,dmat_dep_des_en
  ,dmat_sec_code
  ,dmat_sec_des_en
  ,store_cluster
  ,SUBSTR(sg_cd,1,3)
  ,monday_pensioners
  )
  )

WHERE 
avg_sales_per_day > 50 AND
avg_sales_per_day_LY > 50 AND 
minimum_sales_LY > 50 AND 
((seasonality_ratio >= 15 AND seasonality_filter > 0.1) OR (seasonality_ratio < 15)) AND 
minimum_tpnb_count > 0 AND
event_present = 0 AND
((dmat_dep_des_en = 'Dairy' AND minimum_sales > 50) OR (dmat_dep_des_en <> 'Dairy' AND (seasonality_ratio >= 3 OR minimum_sales > 50)))
;
-------------------------------------
--ALL LEVELS ------------------------
-------------------------------------
SELECT int_cntr_code,
RMS_ID,
sg_cd,
dmat_div_code,
dmat_dep_code,
dmat_dep_des_en,
dmat_sec_code,
dmat_sec_des_en,
dmat_grp_code,
dmat_grp_des_en,
dmat_sgr_code,
dmat_sgr_des_en,
store_cluster,
iso_date,
tesco_yrwk,
LY_week_range,
TY_week_range,
fcst_week_id,
weekday,
event_id,
bank_holiday_id,
bh_lower_window,
bh_upper_window,
small_payday_id,
large_payday_id,
HU_pensions_id,
monday_pensioners,
bank_holiday_excl,
normal_retailprice_avg,
promoprice_avg,
total_price_avg,
store_count,
tpnb_count,
promo_count,
adj_sales,
exp_sales,
seasonality_ratio,
seasonality_filter,
wthrfactor,
scaled_tpnb_count,
scaled_promo_sales,
scaled_normal_retail_price,
scaled_promo_price,
scaled_total_price,
scaled_wthrfactor,
AVG(ptp_reg_weight) OVER(PARTITION BY store_cluster, RMS_ID) as ptp_reg_weight SELECT count(*)
FROM(
  (SELECT * FROM SGR)
  UNION ALL
  (SELECT * FROM GRP)
  UNION ALL
  (SELECT * FROM SEC)
  )  
;
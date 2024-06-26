CREATE OR REPLACE TEMP TABLE UNIONED AS
(
SELECT 
    *,
    'Birmingham' AS STORE
FROM PD2021_WK03_BIRMINGHAM
UNION ALL
SELECT 
    *, 
    'Leeds' AS STORE
FROM PD2021_WK03_LEEDS
UNION ALL
SELECT 
    *,
    'London' AS STORE
FROM PD2021_WK03_LONDON
UNION ALL
SELECT 
    *,
    'Manchester' AS STORE
FROM PD2021_WK03_MANCHESTER
UNION ALL
SELECT 
    *, 
    'York' AS STORE
FROM PD2021_WK03_YORK
);  

SELECT 
   EXTRACT (QUARTER FROM UNIONED."Date") AS QUARTER,
   STORE,
   SUM(VALUE) AS PRODUCTS_SOLD,
   PD2021_WK04_TARGETS."Target",
   (PRODUCTS_SOLD - "Target") AS VARIANCE_TO_TARGET,
   RANK () OVER (PARTITION BY QUARTER ORDER BY "VARIANCE_TO_TARGET" DESC) AS RANK
FROM UNIONED
UNPIVOT
    (VALUE FOR ATTRIBUTE IN ("New_-_Saddles", "New_-_Mudguards", "New_-_Wheels", "New_-_Bags","Existing_-_Saddles", "Existing_-_Mudguards", "Existing_-_Wheels", "Existing_-_Bags")
    )
LEFT JOIN 
    PD2021_WK04_TARGETS
ON 
    QUARTER = PD2021_WK04_TARGETS."Quarter" AND UNIONED.STORE = PD2021_WK04_TARGETS."Store"
GROUP BY QUARTER, STORE, PD2021_WK04_TARGETS."Target";
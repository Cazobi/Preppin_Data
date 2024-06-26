CREATE OR REPLACE TEMP TABLE UNIONED AS
(
SELECT
    CASE
        WHEN CLASS = 'Economy' THEN 'First Class'
        WHEN CLASS = 'First Class' THEN 'Economy'
        WHEN CLASS = 'Business Class' THEN 'Premium Economy'
        WHEN CLASS = 'Premium Economy' THEN 'Business Class'
    END AS CLASS,
    IFF(FLOW_CARD = '1', 'Yes','No') AS FLOW_CARD,
    MONTH(TO_DATE("DATE", 'DD/MM/YYYY')) AS "MONTH",
    PRICE
FROM PD2024_WK02_FLOW_CARD

UNION

SELECT 
    CASE
        WHEN CLASS = 'Economy' THEN 'First Class'
        WHEN CLASS = 'First Class' THEN 'Economy'
        WHEN CLASS = 'Business Class' THEN 'Premium Economy'
        WHEN CLASS = 'Premium Economy' THEN 'Business Class'
    END AS CLASS,
    IFF(FLOW_CARD = '1', 'Yes','No') AS FLOW_CARD,
    MONTH(TO_DATE("DATE", 'DD/MM/YYYY')) AS "MONTH",
    PRICE
FROM PD2024_WK02_NON_FLOW_CARD
);


SELECT
    ROUND(SUM(PRICE) - AVG(TARGET),1) AS DIFFERENCE_TO_TARGET,
    UNIONED.MONTH,
    CONCAT(LEFT(SPLIT_PART(UNIONED.CLASS, ' ', 1),1),LEFT(SPLIT_PART(UNIONED.CLASS, ' ', 2),1)) AS CLASS_CODE,
    SUM(PRICE),
    ROUND(AVG(TARGET))
FROM UNIONED
FULL OUTER JOIN 
(
    SELECT *
    FROM PD2024_WK03_INPUT_Q1

    UNION ALL

    SELECT *
    FROM PD2024_WK03_INPUT_Q2

    UNION ALL

    SELECT *
    FROM PD2024_WK03_INPUT_Q3

    UNION ALL

    SELECT *
    FROM PD2024_WK03_INPUT_Q4
) AS TARGETS
ON CLASS_CODE = TARGETS.CLASS AND UNIONED.MONTH = TARGETS.MONTH
GROUP BY CLASS_CODE, UNIONED.MONTH;
(SELECT  *
FROM UNIONED
PIVOT(MEDIAN(PRICE) FOR CLASS IN (ANY ORDER BY CLASS))
ORDER BY FLOW_CARD, QUARTER)

UNION ALL

(SELECT *
FROM UNIONED
PIVOT(MIN(PRICE) FOR CLASS IN (ANY ORDER BY CLASS))
ORDER BY FLOW_CARD, QUARTER)

UNION ALL

(SELECT *
FROM UNIONED
PIVOT(MAX(PRICE) FOR CLASS IN (ANY ORDER BY CLASS))
ORDER BY FLOW_CARD, QUARTER);
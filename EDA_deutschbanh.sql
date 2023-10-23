
/*------------------------------------------------------------------- */
/*------------------------- CELAN # TABLES -------------------------- */
/*------------------------------------------------------------------- */

DROP TABLE IF EXISTS #T1

/*------------------------------------------------------------------- */
/*------------------------- PRINCIPAL QUERY ------------------------- */
/*------------------------------------------------------------------- */

SELECT 
      [bst_nr_8]
     ,CONVERT(DATE,[prod_datum]) AS [prod_datum]
     ,[number_trips]
     ,[minutes]
	 ,ROUND(CONVERT(FLOAT,[minutes]) / CONVERT(FLOAT,[number_trips]),2)  AS [avg_delay_per_trip]
--INTO #T1
FROM [DWH].[dbo].[deutschebahn_real_trafic_data] WITH(NOLOCK)
WHERE [country] = 'DEUTSCHLAND'
GROUP BY [bst_nr_8], [country], [prod_datum], [number_trips], [minutes]
ORDER BY [prod_datum] DESC,[number_trips] DESC, [minutes] DESC


/*------------------------------------------------------------------- */
/*---------- PERCENTAGE OF DELAYED AND NON-DELAYED TRAINS ----------- */
/*------------------------------------------------------------------- */

-- Total
DECLARE @TOTAL VARCHAR(20) = (SELECT COUNT(*) FROM #T1)

-- With delay
DECLARE @DELAY VARCHAR(20) = (SELECT COUNT(*) FROM #T1 WHERE [minutes] > 0)

-- Without delay
DECLARE @CORRECT VARCHAR(20) = (SELECT COUNT(*)	FROM #T1 WHERE [minutes] <= 0)

-- Percentage delay
DECLARE @PERCENTAGE_DELAY FLOAT =  CONVERT(FLOAT,@DELAY) * 100 / CONVERT(FLOAT,@TOTAL) 

-- Percentage without delay
DECLARE @PERCENTAGE_CORRECT FLOAT =  CONVERT(FLOAT,@CORRECT) * 100 / CONVERT(FLOAT,@TOTAL) 


PRINT 'In the year 2016 there were a total of ' + @TOTAL + ' trips in Germany,' +
	  ' of which ' + CONVERT(VARCHAR(20),@PERCENTAGE_DELAY * 1) + '%' + ' had a delay of at least 1 minute' +
	  ' while those with no delay were a total of ' + CONVERT(VARCHAR(20),@PERCENTAGE_CORRECT * 1) + '%'


/*------------------------------------------------------------------- */
/*-------- WHAT WAS THE DAY AND MONTH WITH THE MOST DELAYS? --------- */
/*------------------------------------------------------------------- */

-- The day 
SELECT 
	  --[bst_nr_8]
      [prod_datum]
     ,SUM([number_trips]) AS total_number_trips
     ,SUM([minutes]) AS [total_minutes_delay]
	 ,ROUND(CONVERT(FLOAT,SUM([minutes])) / CONVERT(FLOAT,SUM([number_trips])),2)  AS [avg_delay_per_trip]
FROM #T1
GROUP BY [prod_datum]
ORDER BY [prod_datum] DESC


-- The month 
SELECT 
      DATEPART(MONTH, [prod_datum]) AS mes,
      SUM([number_trips]) AS total_number_trips,
      SUM([minutes]) AS [total_minutes_delay],
      ROUND(CONVERT(FLOAT, SUM([minutes])) / NULLIF(CONVERT(FLOAT, SUM([number_trips])), 0), 2) AS [avg_delay_per_trip]
FROM #T1
GROUP BY DATEPART(MONTH, [prod_datum])
ORDER BY [avg_delay_per_trip] DESC;








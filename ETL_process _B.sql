/* 
bst_nr_8: Internal number of the operating station, e.g. 10000018. It can be used as a key to connect to the data record "Freight Transport Station Directory" with the column "BST8" there.

country: Name of the country in which the BST is located, e.g. Finland.

prod_datum: Date of production. The day for which the data in the columns "Train trips" and "Delay minutes" were measured.

number_trips: Number of DB Cargo train trips that passed through the operating station specified in column "BST_NR_8" on the day specified in column "PROD_DATUM".

[minutes]: the sum of DB Cargo delay minutes recorded on the day specified in column "PROD_DATUM" for the station specified in column "BST_NR_8".

last_update: It is a field that allows to visualize when was the last update date (data not available in the dataset).
*/

/*------------------------------------------------------------------- */
/*------------------------------ PROD TABLE ------------------------- */
/*------------------------------------------------------------------- */

USE [DWH]

CREATE TABLE [DWH].[dbo].[deutschebahn_real_trafic_data]
(
	bst_nr_8		INT		NOT NULL,
	country			VARCHAR(20) 	NOT NULL,
	prod_datum		DATETIME	NOT NULL,
	number_trips		INT		NOT NULL,
	[minutes]		INT		NOT NULL,
	[last_update]		DATETIME	NOT NULL
)
GO
	ALTER TABLE [dbo].[deutschebahn_real_trafic_data] ADD CONSTRAINT [deutschebahn_real_trafic_data_lastupdate] DEFAULT (getdate()) FOR [last_update]
GO
-- It is always a best practice to add detail in the extended properties.
GO
	EXEC sys.sp_addextendedproperty @name='t description', 
	@value=N'Table from deutschebahn (data.deutschebahn.com/dataset/ist-verkehrsdaten-der-db-cargo-auf-bst8-ebene.html), 
	The data provided here represent the number of train trips and delay minutes per day and season of operation. 
	All BSTs where at least 10 train trips were taken into account.', 
	@level0type=N'SCHEMA', @level0name=N'dbo',
	@level1type=N'TABLE', @level1name=N'deutschebahn_real_trafic_data'
GO


/*------------------------------------------------------------------- */
/*------------------------------ TEMP TABLE ------------------------- */
/*------------------------------------------------------------------- */

DROP TABLE IF EXISTS [DWH].[dbo].[temp_deutschebahn_real_trafic_data]

CREATE TABLE [DWH].[dbo].[temp_deutschebahn_real_trafic_data]
(
	bst_nr_8		INT		NOT NULL,
	country			VARCHAR(20) 	NOT NULL,
	prod_datum		DATETIME	NOT NULL,
	number_trips		INT		NOT NULL,
	[minutes]		INT		NOT NULL
)
	

/*------------------------------------------------------------------- */
/*----------------------- MERGE TO PRODUCTION ----------------------- */
/*------------------------------------------------------------------- */

-- For this case we will use data deletion, although it is recommended to use merge.

IF (SELECT COUNT(*) FROM [DWH].[dbo].[temp_deutschebahn_real_trafic_data] WITH(NOLOCK))  > 0
BEGIN

	DECLARE @date_min DATE = (SELECT MIN(CONVERT(DATE, prod_datum, 104)) FROM [DWH].[dbo].[temp_deutschebahn_real_trafic_data] WITH(NOLOCK))
	DECLARE @date_max DATE = (SELECT MAX(CONVERT(DATE, prod_datum, 104)) FROM [DWH].[dbo].[temp_deutschebahn_real_trafic_data] WITH(NOLOCK))

	DELETE  FROM [DWH].[dbo].[deutschebahn_real_trafic_data] 
	WHERE CONVERT(DATE, prod_datum, 104) >= @date_min AND 
		  CONVERT(DATE, prod_datum, 104) <= @date_max

	INSERT INTO [DWH].[dbo].[deutschebahn_real_trafic_data]
	SELECT 
		 CONVERT(INT,bst_nr_8)			AS bst_nr_8
		,CONVERT(VARCHAR(20),country)		AS country
		,CONVERT(DATETIME,prod_datum,104)	AS prod_datum
		,CONVERT(INT,number_trips)		AS number_trips
		,CONVERT(INT,[minutes])			AS [minutes]
		,GETDATE()				AS [last_update]
	FROM [DWH].[dbo].[temp_deutschebahn_real_trafic_data] WITH(NOLOCK)

END


/*------------------------------------------------------------------- */
/*------------------------ CELAN TEMP TABLE ------------------------- */
/*------------------------------------------------------------------- */

DROP TABLE IF EXISTS [DWH].[dbo].[temp_deutschebahn_real_trafic_data]



# EDA deutschebahn 


The project consists of an analysis with train delay data, initially it was considered for a predictive analysis on the probability that a certain station or train had a delay, however, it is complicated since there are only 2 years of data, so it was decided to do only an exploratory analysis.

The main objective was to determine the percentages of train delays, with which it is concluded that for the year 2016 there were a total of 771621 trips, of which 59.58% had a delay of at least 1 minute, while 40.42% did not present any type of delay, being so that the most affected month was November.
In the same way, it was decided to show the ways in which this analysis can be done in SQL and Python.

The following can be found in the repository:

* deutschebahn_real_trafic_data.dtsx: This is an SSIS where from a folder the deposited file is taken and inserted into a table in a database (using a Flat file source).

* Zugfahrten_2016_12.zip: Zugfahrten_2016_12.zip: File downloaded from the official train website. 

* EDA_deutschbanh.sql: SQL analysis to determine % of trips that had a delay, find the month with the highest number of delays, etc.

* ETL_process _B.sql: Queries used by the SSIS to insert data into the production table.

* main.ipynb: Python code that replicates the queries made in SQL, in the same way as a connection to the database to read the table from SQL and not from the file.

Data consulted: https://data.deutschebahn.com/dataset/ist-verkehrsdaten-der-db-cargo-auf-bst8-ebene.html


-------------------------------------------------

El proyecto consta en un análisis con datos de retraso en los trenes, inicialmente se consideró para un análisis predictivo sobre que probabilidad existía de que determinada estación o tren tuviera un retraso, sin embargo, se complica debido a que solo existen datos de 2 años, por lo que se decidió únicamente hacer un análisis exploratorio.

El objetivo principal era determinar los porcentajes de retraso en los trenes, con lo cual se concluye que para el año 2016 hubo un total de 771621 viajes, de los cuales el 59.58% tuvo un retraso al menos de 1 minuto, mientras que un 40.42% no presentó ningún tipo de retraso, siendo así que el mes más afectado fue noviembre.
Del mismo modo, se decidió mostrar las formas en las que se puede hacer este análisis en SQL y Python.

En el repositorio se encuentra lo siguiente:

* deutschebahn_real_trafic_data.dtsx: Es un SSIS donde desde una carpeta se toma el file depositado y se inserta en una tabla en una base de datos (usando un Flat file source).

* Zugfahrten_2016_12.zip: Archivo comprimido descargado de la página oficial de trenes. 

* EDA_deutschbanh.sql: Analisis en SQL para determinar % de viajes que tuvieron un retraso, encontrar el mes con mayor número de retrasos, etc.

* ETL_process _B.sql: Consultas que usa el SSIS para insertar data a la tabla de producción.

* main.ipynb: Código en Python que replica las consultas realizadas en SQL, del mismo modo que una conexión a la base datos para leer la tabla desde SQL y no desde el file.

Datos consultados: https://data.deutschebahn.com/dataset/ist-verkehrsdaten-der-db-cargo-auf-bst8-ebene.html

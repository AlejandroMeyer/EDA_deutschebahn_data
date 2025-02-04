# EDA deutschebahn 


The project consists of an analysis with train delay data, initially it was considered for a predictive analysis on the probability that a certain station or train had a delay, however, it is complicated since there are only 2 years of data, so it was decided to do only an exploratory analysis.

The main objective was to determine the percentages of train delays, with which it is concluded that for the year 2016 there were a total of 771621 trips, of which 59.58% had a delay of at least 1 minute, while 40.42% did not present any type of delay, being so that the most affected month was November.
In the same way, it was decided to show the ways in which this analysis can be done in SQL and Python.

The following can be found in the repository:

* deutschebahn_real_trafic_data.dtsx: This is an SSIS where from a folder the deposited file is taken and inserted into a table in a database (using a Flat file source).

* Zugfahrten_2016_12.zip: File downloaded from the official train website. 

* EDA_deutschbanh.sql: SQL analysis to determine % of trips that had a delay, find the month with the highest number of delays, etc.

* ETL_process _B.sql: Queries used by the SSIS to insert data into the production table.

* main.ipynb: Python code that replicates the queries made in SQL, in the same way as a connection to the database to read the table from SQL and not from the file.

Data consulted: https://data.deutschebahn.com/dataset/ist-verkehrsdaten-der-db-cargo-auf-bst8-ebene.html




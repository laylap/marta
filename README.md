marta
=====

data science for Atlanta's public transportation

Historical Model

HistoricalModel.py
to run, just set the amount of simulations that you would like and run with python.
The results to analyze will be in results.csv, and the parameters for each simulation are in allparams.csv

What HistoricalModel.py does:
1) Gets a random amount of weeks k as a training data, from 3 to 12.
2) Generate the parameters for a random query. This includes getting a:
	-stop id
		* get all stops from the file allStops.csv, and choose one randomly.
		* enter the database and obtain all information available (tripid, scheduled time) from a random time from the google_transit
	-route
		* we query the database again because it is not in the same database as stop id 
	-day of the week
		* obtain the day of the week of the scheduled time.
	-start and end date
		* from the date, add the amount of weeks obtained from 1) to get the end date
	-start and end time
		* from the scheduled time, remove 15 minutes and add 15 minutes to get t
3) Save these results in allparams.csv
4) Do the random query with the parameters obtained in 2). Save the results to tmp_results
5) Get the real coordenates of the randomly obtained stop. This is in the google_transit
6) Get all the adherences:
	- For every week, get the the entry that is closest (L2) to the real coordenates. 
	- Save the adherence. In the end, we should have k adherences.
7) Use (k-1) adherences and obtain the median and mean.
8) In results.csv write iteration, k, median, mean, kth entry of adherences



 	


To manually check that it is doing what we want it to do:
1) Check any of the results in allparms.csv
2) From there, run the following in postgresql, changing the parameters as necessary:

select * from marta_gps_clean where route='19' and stopid='905913' and msgdate>='2014-05-03' and msgdate<='2014-05-31' and extract(dow from msgdate)=3 and msgtime>='14:08:00' and msgtime<='14:38:00' order by msgdate,msgtime	

3) Check the same id in the file results.csv
4) Check to see that there are the right amount of training data and the result is expected.

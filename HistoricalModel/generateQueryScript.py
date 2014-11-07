def generateQueryScript(stop,r,d,startDate,endDate,startTime,endTime):
	setvars="\set STOP_ID '"+stop+"'\n\set ROUTE_NUM '"+r+"'\n\set DAY "+d+"\n\set LOW_DATE '"+startDate+"'\n\set HIGH_DATE '"+endDate+"'\n\set LOW_TIME '"+startTime+"'\n\set HIGH_TIME '"+endTime+"'\n"
	query="DROP TABLE IF EXISTS tmp_results;\nselect * into tmp_results from marta_gps_clean where\n route=cast(:ROUTE_NUM as VARCHAR) and \n stopid=cast(:STOP_ID as VARCHAR) and \n msgdate>=:'LOW_DATE' and \n msgdate<=:'HIGH_DATE' and \n extract(dow from msgdate)=:DAY and \n msgtime >=:'LOW_TIME' and \n msgtime <:'HIGH_TIME' \norder by msgdate, lattitude, longitude;\n"
	savetable="\copy tmp_results to tmp_results.csv delimiter ',';\n"
	f=open('query_script.sql','w')
	f.write(setvars+query+savetable)
	f.close()
	
	

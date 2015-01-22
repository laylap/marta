import os


def getStopsAndCoords_Route(route_num):
        f=open('aux.sql','w')
        f.write("DROP TABLE IF EXISTS aux;\nselect stop_id,stop_lat,stop_lon into aux from stops where stop_id in (select stop_id from stop_times where trip_id = (select trip_id from trips where route_id = (select route_id from routes where route_short_name = '"+route_num+"') limit 1 ));;\n\copy aux to auxfile.csv delimiter ',';\n")
        f.close()
        os.system("psql -d adherencedb -a -f aux.sql")
        f=open('auxfile.csv','r')
        line=f.readlines()
        f.close()
        os.system("rm auxfile.csv aux.sql")
        return line




def getStopsAndCoords(trip):
	f=open('aux.sql','w')
        f.write("DROP TABLE IF EXISTS aux;\nselect stop_id,stop_lat,stop_lon into aux from stops where stop_id in (select stop_id from stop_times where trip_id = '"+str(trip)+"');\n\copy aux to auxfile.csv delimiter ',';\n")
        f.close()
        os.system("psql -d adherencedb -a -f aux.sql")
        f=open('auxfile.csv','r')
        line=f.readlines()
        f.close()
        os.system("rm auxfile.csv aux.sql")
        return line



def getDBLineOffset(db_name,offset):
	f=open('getline.sql','w')
        f.write("DROP TABLE IF EXISTS getline;\nselect * into getline from "+db_name+" limit 1 offset "+str(offset)+";\n\copy getline to getlinefile.csv delimiter ',';\n")
        f.close()
        os.system("psql -d adherencedb -a -f getline.sql")
        f=open('getlinefile.csv','r')
        line=f.readline()
        f.close()
        os.system("rm getlinefile.csv getline.sql")
	return line



def getRealStopId():	
	f=open('allTripIds.csv','r')
        allTrips=[]
        for line in f:
                allTrips.append(line.replace("\n",""))

        f.close()
	allStops=[]
	f=open('allStops.csv','r')
	for line in f:
		allStops.append(line.replace("\n",""))
	
	f.close()
	

		


def simplePredict(all_adh):	
	all_adh=map(int,all_adh)
	med=get_median(all_adh[0:-1])
	mea=get_mean(all_adh[0:-1])
	real=all_adh[-1]
	return(med,mea,real)


def get_mean(lst):
	import numpy
	return numpy.mean(numpy.array(lst))


def get_median(lst):
	import numpy
	return numpy.median(numpy.array(lst))


def findBestMatch(realcoords):
	f=open("tmp_results.csv",'r')
	first= f.readline()
	min_d=getDist(first.split(",")[5],realcoords[0], first.split(",")[6], realcoords[1])
	adh=first.split(",")[1]
	real_adh=list()
	for line in f:
		if(first.split(",")[8]==line.split(",")[8]):	
			lat=line.split(",")[5]
			lon=line.split(",")[6]
			if(getDist(lat,realcoords[0],lon,realcoords[1])<min_d):
				min_d=getDist(lat,realcoords[0],lon,realcoords[1])
				adh=line.split(",")[1]
		else:
			real_adh.append(adh)
			first=line
			min_d=getDist(first.split(",")[5],realcoords[0], first.split(",")[6], realcoords[1])
			adh=first.split(",")[1]
	real_adh.append(adh) #Dont forget to save the last one too!!	
	return(real_adh)
			

def getDist(x1,x2,y1,y2):
	import math
	x1=float(x1)
	x2=float(x2)
	y1=float(y1)
	y2=float(y2)
	return(math.sqrt((x1-x2)**2+(y1-y2)**2))

def getLatLongRealStop(stopid):
        f=open('lat_long.sql','w')
	f.write("DROP TABLE IF EXISTS latlong;\nselect stop_lat, stop_lon into latlong from stops where stop_id='"+stopid+"';\n\copy latlong to latlongfile.csv delimiter ',';\n")
	f.close()
	os.system("psql -d adherencedb -a -f lat_long.sql")
	f=open('latlongfile.csv','r')
	coord=f.readline()
	f.close()
	os.system("rm latlongfile.csv lat_long.sql")
	return(coord.replace("\n","").split(","))
		

def generateParametersForRandomQuery(weeks):
	import datetime
	from datetime import timedelta
	import random
	print("at least we entered")
	f=open('allStops.csv','r')
	allStops=[]
	for line in f:
		allStops.append(line.replace("\n",""))
	
	f.close()	
	randomStop=random.choice(allStops);
	randomQuery="DROP TABLE IF EXISTS tmp_results;\nselect * into tmp_results from stop_times where stop_id='"+randomStop+"' order by random() limit 1;\n\copy tmp_results to tmp_results.csv delimiter ',';\n"
	f=open('randq.sql','w')
	f.write(randomQuery)
	f.close()
	os.system("psql -d adherencedb -a -f randq.sql")
	f=open("tmp_results.csv",'r')
	line=f.readline()
	f.close()
	List=line.split(",");
	trip_id=List[0]
	exp_time=datetime.datetime.strptime(List[1],"%H:%M:%S")
	startTime=str(exp_time-timedelta(0,15*60))
	startTime=startTime.split(" ")[1]
	endTime=str(exp_time+timedelta(0,15*60))
	endTime=endTime.split(" ")[1]
	stop=List[3]
	d1=datetime.datetime.strptime('2014-05-01','%Y-%m-%d')
	d2=datetime.datetime.strptime('2014-08-30','%Y-%m-%d')
	startDate=randomDate(d1,d2)
	endDate=startDate+timedelta(weeks*7,0)
	startDate=str(startDate).split(" ")[0]
	endDate=str(endDate).split(" ")[0]
	
	
	randomQuery="DROP TABLE IF EXISTS tmp_results;\nselect route_short_name into tmp_results from routes where route_id=(select route_id from trips where trip_id=(select trip_id from stop_times where stop_id='"+randomStop+"' order by random() limit 1));;\n\copy tmp_results to tmp_results.csv delimiter ',';\n"
	f=open('randq.sql','w')
	f.write(randomQuery)
	f.close()
	os.system("psql -d adherencedb -a -f randq.sql")
	f=open("tmp_results.csv",'r')
	route=f.readline().replace("\n","")
	f.close()
	os.system("rm randq.sql")	
	return(stop,route,random.randint(1,5),startDate,endDate,startTime,endTime)
	


	
def generateQueryScript(stop,r,d,startDate,endDate,startTime,endTime):
	setvars="\set STOP_ID '"+stop+"'\n\set ROUTE_NUM '"+r+"'\n\set DAY "+d+"\n\set LOW_DATE '"+startDate+"'\n\set HIGH_DATE '"+endDate+"'\n\set LOW_TIME '"+startTime+"'\n\set HIGH_TIME '"+endTime+"'\n"
	query="DROP TABLE IF EXISTS tmp_results;\nselect * into tmp_results from marta_gps_clean where\n route=cast(:ROUTE_NUM as VARCHAR) and \n stopid=cast(:STOP_ID as VARCHAR) and \n msgdate>=:'LOW_DATE' and \n msgdate<=:'HIGH_DATE' and \n extract(dow from msgdate)=:DAY and \n msgtime >=:'LOW_TIME' and \n msgtime <:'HIGH_TIME' \norder by msgdate, msgtime,lattitude, longitude;\n"
	savetable="\copy tmp_results to tmp_results.csv delimiter ',';\n"
	f=open('query_script.sql','w')
	f.write(setvars+query+savetable)
	f.close()
	os.system("psql -d adherencedb -a -f query_script.sql")
	os.system("rm query_script.sql")
	
def randomDate(start, end):
	"""
	This function will return a random datetime between two datetime 
	objects.
	"""
	from random import randrange
	from datetime import timedelta
	delta = end - start
	int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
	random_second = randrange(int_delta)
	return start + timedelta(seconds=random_second)


def sendmail(subj,msg):
		import smtplib
		gmail_user = "danielatemory@gmail.com"
		gmail_pwd = "new passwor"
		FROM = 'danielatemory@gmail.com'
		TO =['dgarci8@emory.edu']
		SUBJECT = subj
		TEXT = msg
		message=""
		#message = """\From: %s\nTo: %s\nSubject: %s\n\n%s""" % (FROM, ", ".join(TO), SUBJECT, "Problem") 
		server = smtplib.SMTP("smtp.gmail.com", 587) #or port 465 doesn't seem to work!
		server.ehlo()
		server.starttls()
		server.login(gmail_user, gmail_pwd)
		server.sendmail(FROM, TO, message)
		server.close()
		print 'successfully sent the mail'



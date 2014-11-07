def generateParametersForRandomQuery():
	import datetime
	from datetime import timedelta
	allRoutes=["7686","7646","7688","7694","7722","7634","7668","7672","7648","7652","7664","7654","7670","8618","7669","7698","7647","7676","7687","7703","7721","7661","7679","7691","7712","7707","7667","7674","7645","7677","7705","7745","7675","7656","7716","7662","7682","7742","7723","7638","7681","7695","7643","7709","7651","7671","7713","7635","7683","7700","7741","7692","7701","8487","8484","7657","7665","7666","7663","7653","7693","7673","7678","7690","7717","7720","7684","7714","7743","7660","7704","7649","7706","7659","7689","7727","7658","7696","7639","7640","7650","7642","7744","7636","7641","7637","7746","7718","7702","8617","7710","7726","7699","7697","7708","7719"]
	randomRoute=random.choice(allRoutes);
	randomQuery="DROP TABLE IF EXISTS tmp_results;\nselect * into tmp_results from stop_times where trip_id=(select trip_id from trips where route_id='"+randomRoute+"' order by random() limit 1) order by random() limit 1;\n\copy tmp_results to tmp_results.csv delimiter ',';\n"
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
	return(stop,randomRoute,random.randint(1,7),startDate,endDate,startTime,endTime)
	


	

import MyPyFunctions
g=open("marta_gps_db_real_stop.csv",'a')
g.write("row_id,adherence,blockid,block_abbr,direction,lattitude,longitude,msgdate,msgtime,route,stopid,timepoint,tripid,vehicle,real_stopid,dist_toreal_stopid\n") 
for i in range(1,27036336):
	print i
	marta_entry=MyPyFunctions.getDBLineOffset('marta_gps_clean',i)
	marta_tripid=marta_entry.split(",")[12]
	marta_lat=marta_entry.split(",")[5]
	marta_lon=marta_entry.split(",")[6]
	marta_route=marta_entry.split(",")[9]
	try:
		list_of_stop_ids = MyPyFunctions.getStopsAndCoords_Route(marta_route)
		closest_stop=list_of_stop_ids[0].replace("\n","").split(",")[0]
		closest_dist=MyPyFunctions.getDist(list_of_stop_ids[0].replace("\n","").split(",")[1],marta_lat,list_of_stop_ids[0].replace("\n","")[2],marta_lon)
		for st_pos in list_of_stop_ids:
			new_dist=MyPyFunctions.getDist(st_pos.replace("\n","").split(",")[1],marta_lat,st_pos.replace("\n","").split(",")[2],marta_lon)
			if new_dist < closest_dist:
				closest_dist=new_dist;
				closest_stop=st_pos.split(",")[0]
		g.write(marta_entry.replace("\n",",")+closest_stop+","+str(closest_dist)+"\n")
	except:
		print "Again some problem...."
		
	
print "Finished!!!"	
g.close()
	#MyPyFunctions.sendmail("Finished!","Check marta_gps_db_real_stop.csv")

import os
import MyPyFunctions
import random


sims = 50000

os.system("rm allparams.csv")
h=open("allparams.csv",'a')
h.write("iter,stop,route,day,startDate,endDate,startTime,endTime\n")
g=open("results.csv",'a')
g.write("iter,weeks,training_size,median,mean,real\n")

try:
	for i in range(0,sims):
		k=random.randint(3,12) #Taking k weeks as training and trying to predict the next week
		try:
			stop,r,d,startDate,endDate,startTime,endTime=MyPyFunctions.generateParametersForRandomQuery(k)
			MyPyFunctions.generateQueryScript(stop,r,str(d),startDate,endDate,startTime,endTime) #this creates the file query_script.sql and runs it to generate file tmp_results.csv
			h.write(str(i)+","+stop+","+str(r)+","+str(d)+","+str(startDate)+","+str(endDate)+","+str(startTime)+","+str(endTime)+"\n")
		except:
			print("Error with getting parameters or writing them to file")
		try:	
			realcoords=MyPyFunctions.getLatLongRealStop(stop)
			all_adh=MyPyFunctions.findBestMatch(realcoords)
			pred_median,pred_mean,real=MyPyFunctions.simplePredict(all_adh)
			g.write(str(i)+","+str(k)+","+str(len(all_adh)-1)+","+str(pred_median)+","+str(pred_mean)+","+str(real)+"\n")
		except:
			print("Error with prediction or writing results. It could be nothing...")
except:
	MyPyFunctions.sendmail("Bus error","Error in Historical Prediction Model. Go check it out")	
h.close()
g.close()


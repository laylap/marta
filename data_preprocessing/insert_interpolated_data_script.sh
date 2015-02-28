#!/bin/sh

for infile in ./june_aug/*.csv
do
   echo $infile 		
   cat $infile | psql -h istanbul.mathcs.emory.edu -U dgarci8 -d adherencedb -c "\COPY gps_june_aug_interpolated from stdin with delimiter as ',' NULL AS 'NA' CSV HEADER"
done
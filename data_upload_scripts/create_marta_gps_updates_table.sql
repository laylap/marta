﻿drop TABLE marta_gps;
CREATE TABLE marta_gps
(
ROW_ID 	 int PRIMARY KEY
,ADHERENCE VARCHAR(15)
,BLOCKID VARCHAR(15)
,BLOCK_ABBR VARCHAR(15)
,DIRECTION VARCHAR(15)
,LATTITUDE VARCHAR(15)
,LONGITUDE VARCHAR(15)
,MSGTIME TIMESTAMP
,ROUTE VARCHAR(15)
,STOPID VARCHAR(15)
,TIMEPOINT TEXT
,TRIPID VARCHAR(15)
,VEHICLE  VARCHAR(15)
);


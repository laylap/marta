﻿/*drop TABLE marta_gps;*/
CREATE TABLE marta_gps
(
ROW_ID 	 int PRIMARY KEY
,ADHERENCE INT
,BLOCKID VARCHAR(10)
,BLOCK_ABBR VARCHAR(10)
,DIRECTION VARCHAR(11)
,LATTITUDE REAL
,LONGITUDE REAL
,MSGTIME TIMESTAMP
,ROUTE VARCHAR(5)
,STOPID INT
,TIMEPOINT TEXT
,TRIPID INT
,VEHICLE  INT
);


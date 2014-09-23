insert into marta_gps
select 
row_id
,SPLIT_PART(SPLIT_PART(DATA, '","',1), '":"',2)::int as ADHERENCE
,SPLIT_PART(SPLIT_PART(DATA, '","',2), '":"',2) as BLOCKID
,SPLIT_PART(SPLIT_PART(DATA, '","',3), '":"',2) as BLOCK_ABBR
,SPLIT_PART(SPLIT_PART(DATA, '","',4), '":"',2) as DIRECTION
,SPLIT_PART(SPLIT_PART(DATA, '","',5), '":"',2)::real as LATTITUDE
,SPLIT_PART(SPLIT_PART(DATA, '","',6), '":"',2)::real as LONGITUDE
,to_timestamp(SPLIT_PART(SPLIT_PART(DATA, '","',7), '":"',2),'MM/DD/YYYY HH12:MI:SS AM or PM') as MSGTIME
,SPLIT_PART(SPLIT_PART(DATA, '","',8), '":"',2) as ROUTE
,SPLIT_PART(SPLIT_PART(DATA, '","',9), '":"',2)::int as STOPID
,SPLIT_PART(SPLIT_PART(DATA, '","',10), '":"',2) as TIMEPOINT
,SPLIT_PART(SPLIT_PART(DATA, '","',11), '":"',2)::int as TRIPID
,SPLIT_PART(SPLIT_PART(DATA, 'VEHICLE":"',2), '"',1)::int as VEHICLE
from marta_raw;
/* This queries, create all the google_transit(GTFS) tables */

drop TABLE trips;
CREATE TABLE trips
(
route_id VARCHAR(15)
,service_id VARCHAR(15)
,trip_id VARCHAR(15) PRIMARY KEY
,trip_headsign TEXT
,direction_id VARCHAR(15)
,block_id VARCHAR(15)
,shape_id VARCHAR(15)
);

drop TABLE routes;
CREATE TABLE routes
(
route_id VARCHAR(15) PRIMARY KEY
,route_short_name VARCHAR(15)
,route_long_name TEXT 
,route_desc TEXT
,route_type VARCHAR(15)
,route_url VARCHAR(15)
,route_color VARCHAR(15)
,route_text_color VARCHAR(15)
);

drop TABLE stops;
CREATE TABLE stops
(
stop_id VARCHAR(15) PRIMARY KEY
,stop_code VARCHAR(15)
,stop_name TEXT 
,stop_lat VARCHAR(15)
,stop_lon VARCHAR(15)
);


drop TABLE stop_times;
CREATE TABLE stop_times
(
trip_id VARCHAR(15)
,arrival_time varchar(8)
,departure_time varchar(8) 
,stop_id VARCHAR(15)
,stop_sequence VARCHAR(15)
);

drop TABLE shapes;
CREATE TABLE shapes
(
shape_id VARCHAR(15)
,shape_pt_lat varchar(15)
,shape_pt_lon varchar(15) 
,shape_pt_sequence VARCHAR(15)
);


drop TABLE calendar_dates;
CREATE TABLE calendar_dates
(
service_id VARCHAR(15)
,date varchar(8)
,exception_type varchar(15) 
);

drop TABLE calendar;
CREATE TABLE calendar
(
service_id VARCHAR(15)
,monday varchar(1)
,tuesday varchar(1)
,wednesday varchar(1)
,thursday varchar(1)
,friday varchar(1)
,saturday varchar(1)
,sunday varchar(1)
,start_date varchar(8)
,end_date varchar(8)
);

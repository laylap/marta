DROP TABLE IF EXISTS gps_april_may_updated;
select Z.* into gps_april_may_updated from (select row_id, min(distance) as mindist from viewX 
group by row_id) as Y inner join viewX Z on Y.row_id=Z.row_id and Y.mindist=Z.distance;
 


/*DROP VIEW IF EXISTS viewX;
CREATE VIEW viewX as
select A.*, st.stop_lat, st.stop_lon, ST_DISTANCE(ST_MAKEPOINT(A.longitude::float,A.lattitude::float), ST_MAKEPOINT(st.stop_lon::float,st.stop_lat::float)) as distance from 
(select * from gps_april_may as g inner join gtfs_april_may.stop_times s on g.tripid=s.trip_id ) 
as A inner join gtfs_april_may.stops st on A.stop_id=st.stop_id; 
*/
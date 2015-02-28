/*extract historical data*/
select g.trip_id, g.msgdate, g.stopseq, avg(g.adherence), t.service_id 
from gps_june_aug_interpolated g inner join gtfs_june_aug.trips t on g.trip_id=t.trip_id::int 
where g.msgdate>='2014-06-28' and g.msgdate<='2014-07-25'
group by g.trip_id, g.msgdate, g.stopseq, t.service_id

;
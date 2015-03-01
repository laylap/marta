/*extract historical data (Average/Median value per Weeddays,Saturdays, Sundays, and Holidays) ~80% data for building the model: 28 out of 36 days*/

drop table if exists gps_june_aug_historical;
select g.trip_id, g.stopseq, avg(g.adherence) as adherence_avg, median(g.adherence::numeric) as adherence_med, t.service_id 
into gps_june_aug_historical
from gps_june_aug_interpolated g inner join gtfs_june_aug.trips t on g.trip_id=t.trip_id::int 
where g.msgdate>='2014-06-28' and g.msgdate<='2014-07-25'
group by g.trip_id, g.stopseq, t.service_id;

select * from gps_june_aug_historical limit 10;
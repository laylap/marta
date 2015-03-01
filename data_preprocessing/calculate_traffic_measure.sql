drop view if exists temp_view cascade;
create view temp_view as
select gi.trip_id,gi.stopseq,gi.adherence,st.stop_id from gps_june_aug_interpolated gi inner join gtfs_june_aug.stop_times st on gi.trip_id::int = st.trip_id::int and gi.stopseq::int = st.stop_sequence::int
where st.stop_id in (select stop_id from gtfs_june_aug.stop_times where trip_id = '4093948' and stop_sequence::int <=50 and stop_sequence::int >=  40) 
and st.arrival_time <= '19:30:00' and st.arrival_time::time + (gi.adherence::text || ' minutes')::interval <= '19:30:00' 
and st.arrival_time >= '19:00:00' and st.arrival_time::time + (gi.adherence::text || ' minutes')::interval >= '19:00:00' and gi.msgdate = '2014-07-01'; 

drop view if exists temp_view_2;
create view temp_view_2 as
select A.trip_id, B.stopseq -A.stopseq as stop_count, B.adherence - A.adherence as ad_dif
from
temp_view A inner join temp_view B
on A.trip_id = B.trip_id and (B.stopseq -A.stopseq) <= 10 and (B.stopseq -A.stopseq) > 0 and A.stop_id <> B.stop_id;

select avg(A.ad_dif/A.stop_count) as traffic_measure from temp_view_2 A inner join (select trip_id, max(stop_count) as m_stop_count from temp_view_2 group by trip_id) as B on A.trip_id = B.trip_id and A.stop_count =  B.m_stop_count


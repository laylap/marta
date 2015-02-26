drop table if exists public.gps_april_may_updated_distinct;
SELECT g.msgdate, g.route, g.trip_id, t.direction_id, g.stop_sequence::int as stopseq, round(avg(g.adherence)) as adherence, g.arrival_time, g.departure_time, g.stop_id, g.stop_lat as latitude, g.stop_lon as longitude
into public.gps_april_may_updated_distinct
FROM public.gps_april_may_updated g inner join gtfs_april_may.trips t on t.trip_id = g.trip_id inner join gtfs_april_may.directions d on d.direction_name = g.direction and d.direction_id::int = t.direction_id::int 
inner join gtfs_april_may.routes r on r.route_short_name = g.route and t.route_id = r.route_id
group by g.msgdate, g.route, g.trip_id, t.direction_id, stopseq, g.arrival_time, g.departure_time, g.stop_id,g.stop_lat,g.stop_lon;

/*select count(*) from public.gps_april_may_updated_distinct
union all
select count(*) from 
(select distinct trip_id, msgdate, stopseq from public.gps_april_may_updated_distinct) as foo*/

/*select count(*),trip_id,msgdate,stopseq from public.gps_april_may_updated_distinct
group by trip_id,msgdate,stopseq
order by count desc
limit 10*/


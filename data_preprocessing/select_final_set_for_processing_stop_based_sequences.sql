SELECT distinct g.msgdate, g.route, g.trip_id, g.direction as direction_name, t.direction_id, g.vehicle, g.stop_sequence::int as stopseq, round(avg(g.adherence)) as adherence, g.arrival_time, g.departure_time, g.stop_id, g.stop_lat as latitude, g.stop_lon as longitude
into public.gps_april_may_updated_distinct
FROM public.gps_april_may_updated g inner join gtfs_april_may.trips t on t.trip_id = g.trip_id inner join gtfs_april_may.directions d on d.direction_name = g.direction and d.direction_id::int = t.direction_id::int 
group by g.msgdate, g.route, g.trip_id, g.direction, t.direction_id, g.vehicle, stopseq, g.arrival_time, g.departure_time, g.stop_id,g.stop_lat,g.stop_lon
order by msgdate,route, trip_id, direction_name, vehicle, stopseq;

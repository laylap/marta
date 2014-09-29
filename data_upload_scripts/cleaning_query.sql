drop table marta_gps_clean;
SELECT distinct row_id, adherence::int, blockid, block_abbr, direction, lattitude::real, 
       longitude::real, date(msgtime) as msgdate, pg_catalog.time(msgtime) as msgtime, route, stopid, timepoint, tripid, vehicle
  FROM marta_gps where adherence <>'' and tripid::int <> 0

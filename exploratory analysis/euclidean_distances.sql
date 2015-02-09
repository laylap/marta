select t1.longitude, t1.lattitude, t2.longitude, t2.lattitude,st_distance(st_makepoint(t1.longitude::float, t1.lattitude::float),st_makepoint(t2.longitude::float, t2.lattitude::float)) as dist from
marta_gps_clean t1, marta_gps_clean t2
limit 2

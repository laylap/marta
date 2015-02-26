drop table if exists gps_april_may_interpolated;
create table gps_april_may_interpolated(
msgdate  date,
trip_id  integer,
stopseq  integer,
adherence  integer
)
drop table if exists gps_june_aug_interpolated;
create table gps_june_aug_interpolated(
msgdate  date,
trip_id  integer,
stopseq  integer,
adherence  integer
)
DROP TABLE if exists gtfs_june_aug.directions;

CREATE TABLE gtfs_june_aug.directions
(
  direction_id integer,
  direction_name character varying
);

insert into gtfs_june_aug.directions (direction_id,direction_name)
values
(0,'Northbound'),
(1,'Southbound'),
(0,'Eastbound'),
(1,'Westbound');

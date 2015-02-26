/*Dates are: 
gps_april_may: 2014-04-16 to 2014-05-18
gps_may_june: 2014-05-18 to 2014-06-15
gps_june_june: 2014-06-15 to 2014-06-28
gps_june_aug: 2014-06-28 to 2014-08-07
gps_aug_oct: 2014-08-07 to 2014-10-07
*/

drop table if exists gps_april_may;
SELECT * INTO gps_april_may
FROM marta_gps_clean
WHERE msgdate>='2014-04-16' AND msgdate<'2014-05-18'; 
-- To run from the terminal:
-- psql -d adherencedb -a -f query_script.sql 

\set STOP_ID '901834'
\set ROUTE_NUM '16'
\set DAY 5
\set LOW_DATE '2014-05-01'
\set HIGH_DATE '2014-05-31'
\set LOW_TIME '09:45:00'
\set HIGH_TIME '10:15:00'

DROP TABLE IF EXISTS tmp_results;
select * into tmp_results from marta_gps_clean where
        route=cast(:ROUTE_NUM as VARCHAR) and
        stopid=cast(:STOP_ID as VARCHAR) and
        msgdate>=:'LOW_DATE' and
        msgdate<=:'HIGH_DATE' and
        extract(dow from msgdate)=:DAY and
        msgtime >=:'LOW_TIME' and
        msgtime <:'HIGH_TIME'
        order by msgdate, lattitude, longitude;
\copy tmp_results to tmp_results.csv delimiter ',';


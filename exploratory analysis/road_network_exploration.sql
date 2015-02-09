/*** Since SRID was not set for the geom column in atlanta_georgia.osm-line table, I update it to 3857 which is the SRID for OSM.***/
/*SELECT UpdateGeometrySRID('atlanta_georgia.osm-line','geom',3857);*/

/*** Just to see what is there***/
/*SELECT GeometryType(roads.geom), ST_NumGeometries(roads.geom), ST_GeometryN(roads.geom,1), st_startpoint(ST_GeometryN(roads.geom,1)), st_endpoint(ST_GeometryN(roads.geom,1)), st_transform(st_startpoint(ST_GeometryN(roads.geom,1)),4326), st_transform(st_endpoint(ST_GeometryN(roads.geom,1)),4326)
   FROM "atlanta_georgia.osm-line" roads
   limit 10*/

/*** Create a view of road segments' start and end points***/
 /*CREATE OR REPLACE VIEW road_ext AS
   SELECT *, st_startpoint(ST_GeometryN(roads.geom,1)), st_endpoint(ST_GeometryN(roads.geom,1))
   FROM "atlanta_georgia.osm-line" roads;*/

/*** Extract distinct nodes ***/
/*CREATE TABLE node AS
   SELECT row_number() OVER (ORDER BY foo.p)::integer AS id,
          foo.p AS the_geom
   FROM (        
      SELECT DISTINCT road_ext.st_startpoint AS p FROM road_ext
      UNION
      SELECT DISTINCT road_ext.st_endpoint AS p FROM road_ext
   ) foo
   GROUP BY foo.p;*/

/*** Combine road_ext and node table for a routable network ***/
CREATE TABLE network AS
   SELECT a.*, b.id as start_id, c.id as end_id
   FROM road_ext AS a
      JOIN node AS b ON a.st_startpoint = b.the_geom
      JOIN node AS c ON a.st_endpoint = c.the_geom;  
   
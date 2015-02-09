/*SELECT * into
  roads	
  FROM public."atlanta_georgia.osm-line";
ALTER TABLE roads ADD COLUMN source integer;
ALTER TABLE roads ADD COLUMN target integer;
*/
SELECT assign_vertex_id('roads', 0.00001, 'geom', 'gid');
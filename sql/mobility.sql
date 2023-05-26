-- add columns stop_lon and stop_lat by joining the stop_times table with the stops table by joining on stop_id

DROP TABLE IF EXISTS stop_times_coord;
CREATE TABLE stop_times_coord AS
SELECT trip_id, ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 4326) AS stop_coord, stop_lon, stop_lat, arrival_time, stop_sequence
FROM stop_times
JOIN stops
ON stop_times.stop_id = stops.stop_id;

-- aggregate the stop_times_coord table by trip_id and stop_sequence to get the trajectories of each trip in mobilityDB format

DROP TABLE IF EXISTS stop_times_traj;
CREATE TABLE stop_times_traj AS
SELECT trip_id, tgeompoint_seq(array_agg(tgeompoint_inst(stop_coord, arrival_time) ORDER BY stop_sequence)) AS traj
FROM stop_times_coord
GROUP BY trip_id
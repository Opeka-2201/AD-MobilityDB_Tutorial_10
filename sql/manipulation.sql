-- MANIPULATE TO OBTAIN THE DESIRED DATA (datetimes correctly for trajectories)

DROP TABLE IF EXISTS calendar_trips CASCADE;
CREATE TABLE calendar_trips AS
SELECT
    calendar.service_id,
    trips.trip_id || RIGHT(calendar.service_id, 2) AS trip_id,
    calendar.monday,
    calendar.tuesday,
    calendar.wednesday,
    calendar.thursday,
    calendar.friday,
    calendar.saturday,
    calendar.sunday,
    trips.trip_short_name,
    trips.direction_id
FROM calendar
JOIN trips ON calendar.service_id LIKE '%' || trips.service_id || '%'
ORDER BY calendar.service_id;
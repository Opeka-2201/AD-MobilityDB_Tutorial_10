-- CREATE THE TABLES

DROP TABLE IF EXISTS agency;
CREATE TABLE agency(
    agency_id TEXT PRIMARY KEY,
    agency_name TEXT NOT NULL,
    agency_url TEXT NOT NULL,
    agency_timezone TEXT NOT NULL,
    agency_lang TEXT,
    agency_phone TEXT
);

DROP TABLE IF EXISTS calendar;
CREATE TABLE calendar(
    service_id TEXT PRIMARY KEY,
    monday INTEGER NOT NULL,
    tuesday INTEGER NOT NULL,
    wednesday INTEGER NOT NULL,
    thursday INTEGER NOT NULL,
    friday INTEGER NOT NULL,
    saturday INTEGER NOT NULL,
    sunday INTEGER NOT NULL,
    start_date date,
    end_date date
);

DROP TABLE IF EXISTS routes;
CREATE TABLE routes(
    route_id TEXT PRIMARY KEY,
    agency_id TEXT NOT NULL,
    route_short_name TEXT NOT NULL,
    route_long_name TEXT NOT NULL,
    route_desc TEXT,
    route_type INTEGER NOT NULL,
    route_url TEXT
);

DROP TABLE IF EXISTS stops;
CREATE TABLE stops(
    stop_id TEXT PRIMARY KEY,
    stop_code TEXT,
    stop_name TEXT NOT NULL,
    stop_desc TEXT,
    stop_lat REAL NOT NULL,
    stop_lon REAL NOT NULL,
    zone_id TEXT,
    stop_url TEXT,
    location_type INTEGER
);

DROP TABLE IF EXISTS trips;
CREATE TABLE trips(
    route_id TEXT NOT NULL,
    service_id TEXT NOT NULL,
    trip_id TEXT PRIMARY KEY,
    trip_short_name TEXT,
    direction_id INTEGER
);

DROP TABLE IF EXISTS stop_times;
CREATE TABLE stop_times(
    trip_id TEXT NOT NULL REFERENCES trips(trip_id),
    arrival_time timestamp NOT NULL,
    departure_time timestamp NOT NULL,
    stop_id TEXT NOT NULL REFERENCES stops(stop_id),
    stop_sequence INTEGER NOT NULL,
    pickup_type INTEGER,
    drop_off_type INTEGER
);

-- INSERT DATA INTO TABLES

COPY agency FROM '/var/lib/postgresql/agency.txt' DELIMITER ',' CSV HEADER;
COPY calendar FROM '/var/lib/postgresql/calendar.txt' DELIMITER ',' CSV HEADER;
COPY routes FROM '/var/lib/postgresql/routes.txt' DELIMITER ',' CSV HEADER;
COPY stops FROM '/var/lib/postgresql/stops.txt' DELIMITER ',' CSV HEADER;
COPY trips FROM '/var/lib/postgresql/trips.txt' DELIMITER ',' CSV HEADER;
COPY stop_times FROM '/var/lib/postgresql/stop_times.txt' DELIMITER ',' CSV HEADER;
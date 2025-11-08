PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS
  Routes (
    RouteId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 1,
    InsertedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastUpdatedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP
  );

INSERT INTO Routes (RouteId, Name)
  VALUES(1, "DASH F");

CREATE TABLE IF NOT EXISTS
  SubRoutes (
    SubRouteId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    RouteId INTEGER NOT NULL,
    Description TEXT NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 1,
    InsertedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastUpdatedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(RouteId) REFERENCES Routes(RouteId)
  );

INSERT INTO 
  SubRoutes (SubRouteId, RouteId, Description)
VALUES
  (1, 1, "Southbound"),
  (2, 1, "Northbound");

CREATE TABLE IF NOT EXISTS
  RouteStops (
    StopId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    RouteId INTEGER NOT NULL,
    Name TEXT NOT NULL,
    Number INTEGER NOT NULL,
    SubRouteId INTEGER NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 1,
    InsertedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastUpdatedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(RouteId) REFERENCES Routes(RouteId),
    FOREIGN KEY(SubRouteId) REFERENCES SubRoutes(SubRouteId)
  );

CREATE INDEX IF NOT EXISTS 
  INDEX_RouteStops_RouteId ON RouteStops (RouteId ASC); 

INSERT INTO
  RouteStops (StopId, RouteId, Name, Number, SubRouteId)
VALUES
  (1, 1, "Beaudry Ave & 3rd St", 6041, 1),
  (2, 1, "4th St & Figueroa St", 6138, 1),
  (3, 1, "Flower St & 5th St", 6021, 1),
  (4, 1, "Flower St & 7th St", 6139, 1),
  (5, 1, "Flower St & 8th St", 6140, 1),
  (6, 1, "Flower St & 9th St", 9638, 1),
  (7, 1, "Flower St & Olympic Blvd", 6142, 1),
  (8, 1, "Figueroa & 12th St (Crypto.com Arena)", 6143, 1),
  (9, 1, "Figueroa St & Pico Blvd", 6144, 1),
  (10, 1, "Figueroa St & Venice Blvd", 6145, 1),
  (11, 1, "Figueroa St & Washington Blvd", 6146, 1),
  (12, 1, "Figueroa St & 23rd St", 6147, 1),
  (13, 1, "Figueroa St & Adams Blvd", 6148, 1),
  (14, 1, "Figueroa St & 30th St", 6149, 1),
  (15, 1, "Figueroa St & Jefferson Blvd", 6150, 1),
  (16, 1, "Figueroa St & McCarthy Way", 6151, 1),
  (17, 1, "Exposition Blvd & Trousdale Pkwy", 6216, 1),
  (18, 1, "Exposition Blvd & Watt Way", 6152, 1),
  (19, 1, "Vermont Ave & Exposition Blvd", 6040, 2),
  (20, 1, "Vermont Ave & 37th Pl", 6119, 2),
  (21, 1, "Vermont Ave & 36th Pl", 6120, 2),
  (22, 1, "Jefferson Blvd & Vermont Ave", 6121, 2),
  (23, 1, "Jefferson Blvd & McClintock Ave", 6122, 2),
  (24, 1, "Jefferson Blvd & Hoover St", 6123, 2),
  (25, 1, "Figueroa St & 33rd St", 6124, 2),
  (26, 1, "Figueroa St & 30th St", 6125, 2),
  (27, 1, "Figueroa St & Adams Blvd", 6126, 2),
  (28, 1, "Figueroa St & 23rd St", 6127, 2),
  (29, 1, "Figueroa St & Washington Blvd", 6128, 2),
  (30, 1, "Figueroa St & Venice Blvd", 6129, 2),
  (31, 1, "Figueroa St & 12th St", 6130, 2),
  (32, 1, "Figueroa & 11th St (Crypto.com Arena)", 6132, 2),
  (33, 1, "Figueroa St & Olympic Blvd", 6133, 2),
  (34, 1, "Figueroa St & 8th St", 6135, 2),
  (35, 1, "Figueroa St & 7th St", 6136, 2),
  (36, 1, "Figueroa St & 5th St", 6137, 2);

CREATE TABLE IF NOT EXISTS
  StopTimes (
    TimeId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    StopId INTEGER NOT NULL,
    Time TEXT NOT NULL,
    DayCategory TEXT NOT NULL,
    IsActive INTEGER NOT NULL DEFAULT 1,
    InsertedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    LastUpdatedAtUtc DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(StopId) REFERENCES RouteStops(StopId)
  );

CREATE INDEX IF NOT EXISTS 
  INDEX_StopTimes_StopId ON StopTimes (StopId ASC);  

INSERT INTO 
  StopTimes (StopId, Time, DayCategory)
VALUES
  -- WEEKDAYS
  -- Southbound
  -- Trip 1: 06:00 departure
  (1, "06:00", "Weekday"), (2, "06:03", "Weekday"), (3, "06:07", "Weekday"), (4, "06:11", "Weekday"), (5, "06:15", "Weekday"), (6, "06:18", "Weekday"), (7, "06:22", "Weekday"), (8, "06:26", "Weekday"), (9, "06:30", "Weekday"), (10, "06:34", "Weekday"), (11, "06:38", "Weekday"), (12, "06:42", "Weekday"), (13, "06:46", "Weekday"), (14, "06:50", "Weekday"), (15, "06:53", "Weekday"), (16, "06:57", "Weekday"), (17, "07:01", "Weekday"), (18, "07:05", "Weekday"),
  -- Trip 2: 07:00 departure - Rush hour, slightly longer intervals
  (1, "07:00", "Weekday"), (2, "07:05", "Weekday"), (3, "07:09", "Weekday"), (4, "07:14", "Weekday"), (5, "07:19", "Weekday"), (6, "07:23", "Weekday"), (7, "07:28", "Weekday"), (8, "07:33", "Weekday"), (9, "07:38", "Weekday"), (10, "07:43", "Weekday"), (11, "07:48", "Weekday"), (12, "07:53", "Weekday"), (13, "07:58", "Weekday"), (14, "08:03", "Weekday"), (15, "08:07", "Weekday"), (16, "08:12", "Weekday"), (17, "08:17", "Weekday"), (18, "08:22", "Weekday"),
  -- Trip 3: 08:00 departure - Rush hour, slightly longer intervals
  (1, "08:00", "Weekday"), (2, "08:04", "Weekday"), (3, "08:09", "Weekday"), (4, "08:14", "Weekday"), (5, "08:19", "Weekday"), (6, "08:23", "Weekday"), (7, "08:28", "Weekday"), (8, "08:33", "Weekday"), (9, "08:38", "Weekday"), (10, "08:43", "Weekday"), (11, "08:48", "Weekday"), (12, "08:53", "Weekday"), (13, "08:58", "Weekday"), (14, "09:03", "Weekday"), (15, "09:07", "Weekday"), (16, "09:12", "Weekday"), (17, "09:17", "Weekday"), (18, "09:22", "Weekday"),
  -- Trip 4: 09:00 departure - Rush hour, slightly longer intervals
  (1, "09:00", "Weekday"), (2, "09:05", "Weekday"), (3, "09:10", "Weekday"), (4, "09:15", "Weekday"), (5, "09:20", "Weekday"), (6, "09:24", "Weekday"), (7, "09:29", "Weekday"), (8, "09:34", "Weekday"), (9, "09:39", "Weekday"), (10, "09:44", "Weekday"), (11, "09:49", "Weekday"), (12, "09:54", "Weekday"), (13, "09:59", "Weekday"), (14, "10:04", "Weekday"), (15, "10:08", "Weekday"), (16, "10:13", "Weekday"), (17, "10:18", "Weekday"), (18, "10:23", "Weekday"),
  -- Trip 5: 10:00 departure
  (1, "10:00", "Weekday"), (2, "10:04", "Weekday"), (3, "10:08", "Weekday"), (4, "10:12", "Weekday"), (5, "10:16", "Weekday"), (6, "10:19", "Weekday"), (7, "10:23", "Weekday"), (8, "10:27", "Weekday"), (9, "10:31", "Weekday"), (10, "10:35", "Weekday"), (11, "10:39", "Weekday"), (12, "10:43", "Weekday"), (13, "10:47", "Weekday"), (14, "10:51", "Weekday"), (15, "10:54", "Weekday"), (16, "10:58", "Weekday"), (17, "11:02", "Weekday"), (18, "11:06", "Weekday"),
  -- Trip 6: 11:00 departure
  (1, "11:00", "Weekday"), (2, "11:03", "Weekday"), (3, "11:07", "Weekday"), (4, "11:11", "Weekday"), (5, "11:15", "Weekday"), (6, "11:18", "Weekday"), (7, "11:22", "Weekday"), (8, "11:26", "Weekday"), (9, "11:30", "Weekday"), (10, "11:34", "Weekday"), (11, "11:38", "Weekday"), (12, "11:42", "Weekday"), (13, "11:46", "Weekday"), (14, "11:50", "Weekday"), (15, "11:53", "Weekday"), (16, "11:57", "Weekday"), (17, "12:01", "Weekday"), (18, "12:05", "Weekday"),
  -- Trip 7: 12:00 departure
  (1, "12:00", "Weekday"), (2, "12:04", "Weekday"), (3, "12:08", "Weekday"), (4, "12:12", "Weekday"), (5, "12:16", "Weekday"), (6, "12:19", "Weekday"), (7, "12:23", "Weekday"), (8, "12:27", "Weekday"), (9, "12:31", "Weekday"), (10, "12:35", "Weekday"), (11, "12:39", "Weekday"), (12, "12:43", "Weekday"), (13, "12:47", "Weekday"), (14, "12:51", "Weekday"), (15, "12:54", "Weekday"), (16, "12:58", "Weekday"), (17, "13:02", "Weekday"), (18, "13:06", "Weekday"),
  -- Trip 8: 13:00 departure
  (1, "13:00", "Weekday"), (2, "13:03", "Weekday"), (3, "13:07", "Weekday"), (4, "13:11", "Weekday"), (5, "13:15", "Weekday"), (6, "13:18", "Weekday"), (7, "13:22", "Weekday"), (8, "13:26", "Weekday"), (9, "13:30", "Weekday"), (10, "13:34", "Weekday"), (11, "13:38", "Weekday"), (12, "13:42", "Weekday"), (13, "13:46", "Weekday"), (14, "13:50", "Weekday"), (15, "13:53", "Weekday"), (16, "13:57", "Weekday"), (17, "14:01", "Weekday"), (18, "14:05", "Weekday"),
  -- Trip 9: 14:00 departure
  (1, "14:00", "Weekday"), (2, "14:04", "Weekday"), (3, "14:08", "Weekday"), (4, "14:12", "Weekday"), (5, "14:16", "Weekday"), (6, "14:19", "Weekday"), (7, "14:23", "Weekday"), (8, "14:27", "Weekday"), (9, "14:31", "Weekday"), (10, "14:35", "Weekday"), (11, "14:39", "Weekday"), (12, "14:43", "Weekday"), (13, "14:47", "Weekday"), (14, "14:51", "Weekday"), (15, "14:54", "Weekday"), (16, "14:58", "Weekday"), (17, "15:02", "Weekday"), (18, "15:06", "Weekday"),
  -- Trip 10: 15:00 departure
  (1, "15:00", "Weekday"), (2, "15:03", "Weekday"), (3, "15:07", "Weekday"), (4, "15:11", "Weekday"), (5, "15:15", "Weekday"), (6, "15:18", "Weekday"), (7, "15:22", "Weekday"), (8, "15:26", "Weekday"), (9, "15:30", "Weekday"), (10, "15:34", "Weekday"), (11, "15:38", "Weekday"), (12, "15:42", "Weekday"), (13, "15:46", "Weekday"), (14, "15:50", "Weekday"), (15, "15:53", "Weekday"), (16, "15:57", "Weekday"), (17, "16:01", "Weekday"), (18, "16:05", "Weekday"),
  -- Trip 11: 16:00 departure - Rush hour, slightly longer intervals
  (1, "16:00", "Weekday"), (2, "16:05", "Weekday"), (3, "16:10", "Weekday"), (4, "16:15", "Weekday"), (5, "16:20", "Weekday"), (6, "16:24", "Weekday"), (7, "16:29", "Weekday"), (8, "16:34", "Weekday"), (9, "16:39", "Weekday"), (10, "16:44", "Weekday"), (11, "16:49", "Weekday"), (12, "16:54", "Weekday"), (13, "16:59", "Weekday"), (14, "17:04", "Weekday"), (15, "17:08", "Weekday"), (16, "17:13", "Weekday"), (17, "17:18", "Weekday"), (18, "17:23", "Weekday"),
  -- Trip 12: 17:00 departure - Rush hour, slightly longer intervals
  (1, "17:00", "Weekday"), (2, "17:04", "Weekday"), (3, "17:09", "Weekday"), (4, "17:14", "Weekday"), (5, "17:19", "Weekday"), (6, "17:23", "Weekday"), (7, "17:28", "Weekday"), (8, "17:33", "Weekday"), (9, "17:38", "Weekday"), (10, "17:43", "Weekday"), (11, "17:48", "Weekday"), (12, "17:53", "Weekday"), (13, "17:58", "Weekday"), (14, "18:03", "Weekday"), (15, "18:07", "Weekday"), (16, "18:12", "Weekday"), (17, "18:17", "Weekday"), (18, "18:22", "Weekday"),
  -- Trip 13: 18:00 departure - Rush hour, slightly longer intervals
  (1, "18:00", "Weekday"), (2, "18:05", "Weekday"), (3, "18:10", "Weekday"), (4, "18:15", "Weekday"), (5, "18:20", "Weekday"), (6, "18:24", "Weekday"), (7, "18:29", "Weekday"), (8, "18:34", "Weekday"), (9, "18:39", "Weekday"), (10, "18:44", "Weekday"), (11, "18:49", "Weekday"), (12, "18:54", "Weekday"), (13, "18:59", "Weekday"), (14, "19:04", "Weekday"), (15, "19:08", "Weekday"), (16, "19:13", "Weekday"), (17, "19:18", "Weekday"), (18, "19:23", "Weekday"),
  -- Trip 14: 19:00 departure
  (1, "19:00", "Weekday"), (2, "19:03", "Weekday"), (3, "19:07", "Weekday"), (4, "19:11", "Weekday"), (5, "19:15", "Weekday"), (6, "19:18", "Weekday"), (7, "19:22", "Weekday"), (8, "19:26", "Weekday"), (9, "19:30", "Weekday"), (10, "19:34", "Weekday"), (11, "19:38", "Weekday"), (12, "19:42", "Weekday"), (13, "19:46", "Weekday"), (14, "19:50", "Weekday"), (15, "19:53", "Weekday"), (16, "19:57", "Weekday"), (17, "20:01", "Weekday"), (18, "20:05", "Weekday"),
  -- Trip 15: 20:00 departure
  (1, "20:00", "Weekday"), (2, "20:04", "Weekday"), (3, "20:08", "Weekday"), (4, "20:12", "Weekday"), (5, "20:16", "Weekday"), (6, "20:19", "Weekday"), (7, "20:23", "Weekday"), (8, "20:27", "Weekday"), (9, "20:31", "Weekday"), (10, "20:35", "Weekday"), (11, "20:39", "Weekday"), (12, "20:43", "Weekday"), (13, "20:47", "Weekday"), (14, "20:51", "Weekday"), (15, "20:54", "Weekday"), (16, "20:58", "Weekday"), (17, "21:02", "Weekday"), (18, "21:06", "Weekday"),

  -- Northbound
  -- Trip 1: 06:05 departure
  (19, "06:05", "Weekday"), (20, "06:08", "Weekday"), (21, "06:12", "Weekday"), (22, "06:16", "Weekday"), (23, "06:20", "Weekday"), (24, "06:23", "Weekday"), (25, "06:27", "Weekday"), (26, "06:31", "Weekday"), (27, "06:35", "Weekday"), (28, "06:39", "Weekday"), (29, "06:43", "Weekday"), (30, "06:47", "Weekday"), (31, "06:51", "Weekday"), (32, "06:55", "Weekday"), (33, "06:58", "Weekday"), (34, "07:02", "Weekday"), (35, "07:06", "Weekday"), (36, "07:10", "Weekday"),
  -- Trip 2: 07:05 departure - Rush hour, slightly longer intervals
  (19, "07:05", "Weekday"), (20, "07:10", "Weekday"), (21, "07:14", "Weekday"), (22, "07:19", "Weekday"), (23, "07:24", "Weekday"), (24, "07:28", "Weekday"), (25, "07:33", "Weekday"), (26, "07:38", "Weekday"), (27, "07:43", "Weekday"), (28, "07:48", "Weekday"), (29, "07:53", "Weekday"), (30, "07:58", "Weekday"), (31, "08:03", "Weekday"), (32, "08:08", "Weekday"), (33, "08:12", "Weekday"), (34, "08:17", "Weekday"), (35, "08:22", "Weekday"), (36, "08:27", "Weekday"),
  -- Trip 3: 08:05 departure - Rush hour, slightly longer intervals
  (19, "08:05", "Weekday"), (20, "08:09", "Weekday"), (21, "08:14", "Weekday"), (22, "08:19", "Weekday"), (23, "08:24", "Weekday"), (24, "08:28", "Weekday"), (25, "08:33", "Weekday"), (26, "08:38", "Weekday"), (27, "08:43", "Weekday"), (28, "08:48", "Weekday"), (29, "08:53", "Weekday"), (30, "08:58", "Weekday"), (31, "09:03", "Weekday"), (32, "09:08", "Weekday"), (33, "09:12", "Weekday"), (34, "09:17", "Weekday"), (35, "09:22", "Weekday"), (36, "09:27", "Weekday"),
  -- Trip 4: 09:05 departure - Rush hour, slightly longer intervals
  (19, "09:05", "Weekday"), (20, "09:10", "Weekday"), (21, "09:15", "Weekday"), (22, "09:20", "Weekday"), (23, "09:25", "Weekday"), (24, "09:29", "Weekday"), (25, "09:34", "Weekday"), (26, "09:39", "Weekday"), (27, "09:44", "Weekday"), (28, "09:49", "Weekday"), (29, "09:54", "Weekday"), (30, "09:59", "Weekday"), (31, "10:04", "Weekday"), (32, "10:09", "Weekday"), (33, "10:13", "Weekday"), (34, "10:18", "Weekday"), (35, "10:23", "Weekday"), (36, "10:28", "Weekday"),
  -- Trip 5: 10:05 departure
  (19, "10:05", "Weekday"), (20, "10:09", "Weekday"), (21, "10:13", "Weekday"), (22, "10:17", "Weekday"), (23, "10:21", "Weekday"), (24, "10:24", "Weekday"), (25, "10:28", "Weekday"), (26, "10:32", "Weekday"), (27, "10:36", "Weekday"), (28, "10:40", "Weekday"), (29, "10:44", "Weekday"), (30, "10:48", "Weekday"), (31, "10:52", "Weekday"), (32, "10:56", "Weekday"), (33, "10:59", "Weekday"), (34, "11:03", "Weekday"), (35, "11:07", "Weekday"), (36, "11:11", "Weekday"),
  -- Trip 6: 11:05 departure
  (19, "11:05", "Weekday"), (20, "11:08", "Weekday"), (21, "11:12", "Weekday"), (22, "11:16", "Weekday"), (23, "11:20", "Weekday"), (24, "11:23", "Weekday"), (25, "11:27", "Weekday"), (26, "11:31", "Weekday"), (27, "11:35", "Weekday"), (28, "11:39", "Weekday"), (29, "11:43", "Weekday"), (30, "11:47", "Weekday"), (31, "11:51", "Weekday"), (32, "11:55", "Weekday"), (33, "11:58", "Weekday"), (34, "12:02", "Weekday"), (35, "12:06", "Weekday"), (36, "12:10", "Weekday"),
  -- Trip 7: 12:05 departure
  (19, "12:05", "Weekday"), (20, "12:09", "Weekday"), (21, "12:13", "Weekday"), (22, "12:17", "Weekday"), (23, "12:21", "Weekday"), (24, "12:24", "Weekday"), (25, "12:28", "Weekday"), (26, "12:32", "Weekday"), (27, "12:36", "Weekday"), (28, "12:40", "Weekday"), (29, "12:44", "Weekday"), (30, "12:48", "Weekday"), (31, "12:52", "Weekday"), (32, "12:56", "Weekday"), (33, "12:59", "Weekday"), (34, "13:03", "Weekday"), (35, "13:07", "Weekday"), (36, "13:11", "Weekday"),
  -- Trip 8: 13:05 departure
  (19, "13:05", "Weekday"), (20, "13:08", "Weekday"), (21, "13:12", "Weekday"), (22, "13:16", "Weekday"), (23, "13:20", "Weekday"), (24, "13:23", "Weekday"), (25, "13:27", "Weekday"), (26, "13:31", "Weekday"), (27, "13:35", "Weekday"), (28, "13:39", "Weekday"), (29, "13:43", "Weekday"), (30, "13:47", "Weekday"), (31, "13:51", "Weekday"), (32, "13:55", "Weekday"), (33, "13:58", "Weekday"), (34, "14:02", "Weekday"), (35, "14:06", "Weekday"), (36, "14:10", "Weekday"),
  -- Trip 9: 14:05 departure
  (19, "14:05", "Weekday"), (20, "14:09", "Weekday"), (21, "14:13", "Weekday"), (22, "14:17", "Weekday"), (23, "14:21", "Weekday"), (24, "14:24", "Weekday"), (25, "14:28", "Weekday"), (26, "14:32", "Weekday"), (27, "14:36", "Weekday"), (28, "14:40", "Weekday"), (29, "14:44", "Weekday"), (30, "14:48", "Weekday"), (31, "14:52", "Weekday"), (32, "14:56", "Weekday"), (33, "14:59", "Weekday"), (34, "15:03", "Weekday"), (35, "15:07", "Weekday"), (36, "15:11", "Weekday"),
  -- Trip 10: 15:05 departure
  (19, "15:05", "Weekday"), (20, "15:08", "Weekday"), (21, "15:12", "Weekday"), (22, "15:16", "Weekday"), (23, "15:20", "Weekday"), (24, "15:23", "Weekday"), (25, "15:27", "Weekday"), (26, "15:31", "Weekday"), (27, "15:35", "Weekday"), (28, "15:39", "Weekday"), (29, "15:43", "Weekday"), (30, "15:47", "Weekday"), (31, "15:51", "Weekday"), (32, "15:55", "Weekday"), (33, "15:58", "Weekday"), (34, "16:02", "Weekday"), (35, "16:06", "Weekday"), (36, "16:10", "Weekday"),
  -- Trip 11: 16:05 departure - Rush hour, slightly longer intervals
  (19, "16:05", "Weekday"), (20, "16:10", "Weekday"), (21, "16:15", "Weekday"), (22, "16:20", "Weekday"), (23, "16:25", "Weekday"), (24, "16:29", "Weekday"), (25, "16:34", "Weekday"), (26, "16:39", "Weekday"), (27, "16:44", "Weekday"), (28, "16:49", "Weekday"), (29, "16:54", "Weekday"), (30, "16:59", "Weekday"), (31, "17:04", "Weekday"), (32, "17:09", "Weekday"), (33, "17:13", "Weekday"), (34, "17:18", "Weekday"), (35, "17:23", "Weekday"), (36, "17:28", "Weekday"),
  -- Trip 12: 17:05 departure - Rush hour, slightly longer intervals
  (19, "17:05", "Weekday"), (20, "17:09", "Weekday"), (21, "17:14", "Weekday"), (22, "17:19", "Weekday"), (23, "17:24", "Weekday"), (24, "17:28", "Weekday"), (25, "17:33", "Weekday"), (26, "17:38", "Weekday"), (27, "17:43", "Weekday"), (28, "17:48", "Weekday"), (29, "17:53", "Weekday"), (30, "17:58", "Weekday"), (31, "18:03", "Weekday"), (32, "18:08", "Weekday"), (33, "18:12", "Weekday"), (34, "18:17", "Weekday"), (35, "18:22", "Weekday"), (36, "18:27", "Weekday"),
  -- Trip 13: 18:05 departure - Rush hour, slightly longer intervals
  (19, "18:05", "Weekday"), (20, "18:10", "Weekday"), (21, "18:15", "Weekday"), (22, "18:20", "Weekday"), (23, "18:25", "Weekday"), (24, "18:29", "Weekday"), (25, "18:34", "Weekday"), (26, "18:39", "Weekday"), (27, "18:44", "Weekday"), (28, "18:49", "Weekday"), (29, "18:54", "Weekday"), (30, "18:59", "Weekday"), (31, "19:04", "Weekday"), (32, "19:09", "Weekday"), (33, "19:13", "Weekday"), (34, "19:18", "Weekday"), (35, "19:23", "Weekday"), (36, "19:28", "Weekday"),
  -- Trip 14: 19:05 departure
  (19, "19:05", "Weekday"), (20, "19:08", "Weekday"), (21, "19:12", "Weekday"), (22, "19:16", "Weekday"), (23, "19:20", "Weekday"), (24, "19:23", "Weekday"), (25, "19:27", "Weekday"), (26, "19:31", "Weekday"), (27, "19:35", "Weekday"), (28, "19:39", "Weekday"), (29, "19:43", "Weekday"), (30, "19:47", "Weekday"), (31, "19:51", "Weekday"), (32, "19:55", "Weekday"), (33, "19:58", "Weekday"), (34, "20:02", "Weekday"), (35, "20:06", "Weekday"), (36, "20:10", "Weekday"),
  -- Trip 15: 20:05 departure
  (19, "20:05", "Weekday"), (20, "20:09", "Weekday"), (21, "20:13", "Weekday"), (22, "20:17", "Weekday"), (23, "20:21", "Weekday"), (24, "20:24", "Weekday"), (25, "20:28", "Weekday"), (26, "20:32", "Weekday"), (27, "20:36", "Weekday"), (28, "20:40", "Weekday"), (29, "20:44", "Weekday"), (30, "20:48", "Weekday"), (31, "20:52", "Weekday"), (32, "20:56", "Weekday"), (33, "20:59", "Weekday"), (34, "21:03", "Weekday"), (35, "21:07", "Weekday"), (36, "21:11", "Weekday"),

  -- WEEKENDS
  -- Southbound
  -- Trip 1: 06:00 departure
  (1, "06:00", "Weekend"), (2, "06:03", "Weekend"), (3, "06:07", "Weekend"), (4, "06:11", "Weekend"), (5, "06:15", "Weekend"), (6, "06:18", "Weekend"), (7, "06:22", "Weekend"), (8, "06:26", "Weekend"), (9, "06:30", "Weekend"), (10, "06:34", "Weekend"), (11, "06:38", "Weekend"), (12, "06:42", "Weekend"), (13, "06:46", "Weekend"), (14, "06:50", "Weekend"), (15, "06:53", "Weekend"), (16, "06:57", "Weekend"), (17, "07:01", "Weekend"), (18, "07:05", "Weekend"),
  -- Trip 2: 07:30 departure
  (1, "07:30", "Weekend"), (2, "07:33", "Weekend"), (3, "07:37", "Weekend"), (4, "07:41", "Weekend"), (5, "07:45", "Weekend"), (6, "07:48", "Weekend"), (7, "07:52", "Weekend"), (8, "07:56", "Weekend"), (9, "08:00", "Weekend"), (10, "08:04", "Weekend"), (11, "08:08", "Weekend"), (12, "08:12", "Weekend"), (13, "08:16", "Weekend"), (14, "08:20", "Weekend"), (15, "08:23", "Weekend"), (16, "08:27", "Weekend"), (17, "08:31", "Weekend"), (18, "08:35", "Weekend"),
  -- Trip 3: 09:00 departure
  (1, "09:00", "Weekend"), (2, "09:04", "Weekend"), (3, "09:08", "Weekend"), (4, "09:12", "Weekend"), (5, "09:16", "Weekend"), (6, "09:19", "Weekend"), (7, "09:23", "Weekend"), (8, "09:27", "Weekend"), (9, "09:31", "Weekend"), (10, "09:35", "Weekend"), (11, "09:39", "Weekend"), (12, "09:43", "Weekend"), (13, "09:47", "Weekend"), (14, "09:51", "Weekend"), (15, "09:54", "Weekend"), (16, "09:58", "Weekend"), (17, "10:02", "Weekend"), (18, "10:06", "Weekend"),
  -- Trip 4: 10:30 departure
  (1, "10:30", "Weekend"), (2, "10:33", "Weekend"), (3, "10:37", "Weekend"), (4, "10:41", "Weekend"), (5, "10:45", "Weekend"), (6, "10:48", "Weekend"), (7, "10:52", "Weekend"), (8, "10:56", "Weekend"), (9, "11:00", "Weekend"), (10, "11:04", "Weekend"), (11, "11:08", "Weekend"), (12, "11:12", "Weekend"), (13, "11:16", "Weekend"), (14, "11:20", "Weekend"), (15, "11:23", "Weekend"), (16, "11:27", "Weekend"), (17, "11:31", "Weekend"), (18, "11:35", "Weekend"),
  -- Trip 5: 12:00 departure
  (1, "12:00", "Weekend"), (2, "12:04", "Weekend"), (3, "12:08", "Weekend"), (4, "12:12", "Weekend"), (5, "12:16", "Weekend"), (6, "12:19", "Weekend"), (7, "12:23", "Weekend"), (8, "12:27", "Weekend"), (9, "12:31", "Weekend"), (10, "12:35", "Weekend"), (11, "12:39", "Weekend"), (12, "12:43", "Weekend"), (13, "12:47", "Weekend"), (14, "12:51", "Weekend"), (15, "12:54", "Weekend"), (16, "12:58", "Weekend"), (17, "13:02", "Weekend"), (18, "13:06", "Weekend"),
  -- Trip 6: 13:30 departure
  (1, "13:30", "Weekend"), (2, "13:33", "Weekend"), (3, "13:37", "Weekend"), (4, "13:41", "Weekend"), (5, "13:45", "Weekend"), (6, "13:48", "Weekend"), (7, "13:52", "Weekend"), (8, "13:56", "Weekend"), (9, "14:00", "Weekend"), (10, "14:04", "Weekend"), (11, "14:08", "Weekend"), (12, "14:12", "Weekend"), (13, "14:16", "Weekend"), (14, "14:20", "Weekend"), (15, "14:23", "Weekend"), (16, "14:27", "Weekend"), (17, "14:31", "Weekend"), (18, "14:35", "Weekend"),
  -- Trip 7: 15:00 departure
  (1, "15:00", "Weekend"), (2, "15:03", "Weekend"), (3, "15:07", "Weekend"), (4, "15:11", "Weekend"), (5, "15:15", "Weekend"), (6, "15:18", "Weekend"), (7, "15:22", "Weekend"), (8, "15:26", "Weekend"), (9, "15:30", "Weekend"), (10, "15:34", "Weekend"), (11, "15:38", "Weekend"), (12, "15:42", "Weekend"), (13, "15:46", "Weekend"), (14, "15:50", "Weekend"), (15, "15:53", "Weekend"), (16, "15:57", "Weekend"), (17, "16:01", "Weekend"), (18, "16:05", "Weekend"),
  -- Trip 8: 16:30 departure
  (1, "16:30", "Weekend"), (2, "16:33", "Weekend"), (3, "16:37", "Weekend"), (4, "16:41", "Weekend"), (5, "16:45", "Weekend"), (6, "16:48", "Weekend"), (7, "16:52", "Weekend"), (8, "16:56", "Weekend"), (9, "17:00", "Weekend"), (10, "17:04", "Weekend"), (11, "17:08", "Weekend"), (12, "17:12", "Weekend"), (13, "17:16", "Weekend"), (14, "17:20", "Weekend"), (15, "17:23", "Weekend"), (16, "17:27", "Weekend"), (17, "17:31", "Weekend"), (18, "17:35", "Weekend"),
  -- Trip 9: 18:00 departure
  (1, "18:00", "Weekend"), (2, "18:04", "Weekend"), (3, "18:08", "Weekend"), (4, "18:12", "Weekend"), (5, "18:16", "Weekend"), (6, "18:19", "Weekend"), (7, "18:23", "Weekend"), (8, "18:27", "Weekend"), (9, "18:31", "Weekend"), (10, "18:35", "Weekend"), (11, "18:39", "Weekend"), (12, "18:43", "Weekend"), (13, "18:47", "Weekend"), (14, "18:51", "Weekend"), (15, "18:54", "Weekend"), (16, "18:58", "Weekend"), (17, "19:02", "Weekend"), (18, "19:06", "Weekend"),
  -- Trip 10: 19:30 departure
  (1, "19:30", "Weekend"), (2, "19:33", "Weekend"), (3, "19:37", "Weekend"), (4, "19:41", "Weekend"), (5, "19:45", "Weekend"), (6, "19:48", "Weekend"), (7, "19:52", "Weekend"), (8, "19:56", "Weekend"), (9, "20:00", "Weekend"), (10, "20:04", "Weekend"), (11, "20:08", "Weekend"), (12, "20:12", "Weekend"), (13, "20:16", "Weekend"), (14, "20:20", "Weekend"), (15, "20:23", "Weekend"), (16, "20:27", "Weekend"), (17, "20:31", "Weekend"), (18, "20:35", "Weekend"),

  -- Northbound
  -- Trip 1: 06:05 departure
  (19, "06:05", "Weekend"), (20, "06:08", "Weekend"), (21, "06:12", "Weekend"), (22, "06:16", "Weekend"), (23, "06:20", "Weekend"), (24, "06:23", "Weekend"), (25, "06:27", "Weekend"), (26, "06:31", "Weekend"), (27, "06:35", "Weekend"), (28, "06:39", "Weekend"), (29, "06:43", "Weekend"), (30, "06:47", "Weekend"), (31, "06:51", "Weekend"), (32, "06:55", "Weekend"), (33, "06:58", "Weekend"), (34, "07:02", "Weekend"), (35, "07:06", "Weekend"), (36, "07:10", "Weekend"),
  -- Trip 2: 07:35 departure
  (19, "07:35", "Weekend"), (20, "07:38", "Weekend"), (21, "07:42", "Weekend"), (22, "07:46", "Weekend"), (23, "07:50", "Weekend"), (24, "07:53", "Weekend"), (25, "07:57", "Weekend"), (26, "08:01", "Weekend"), (27, "08:05", "Weekend"), (28, "08:09", "Weekend"), (29, "08:13", "Weekend"), (30, "08:17", "Weekend"), (31, "08:21", "Weekend"), (32, "08:25", "Weekend"), (33, "08:28", "Weekend"), (34, "08:32", "Weekend"), (35, "08:36", "Weekend"), (36, "08:40", "Weekend"),
  -- Trip 3: 09:05 departure
  (19, "09:05", "Weekend"), (20, "09:09", "Weekend"), (21, "09:13", "Weekend"), (22, "09:17", "Weekend"), (23, "09:21", "Weekend"), (24, "09:24", "Weekend"), (25, "09:28", "Weekend"), (26, "09:32", "Weekend"), (27, "09:36", "Weekend"), (28, "09:40", "Weekend"), (29, "09:44", "Weekend"), (30, "09:48", "Weekend"), (31, "09:52", "Weekend"), (32, "09:56", "Weekend"), (33, "09:59", "Weekend"), (34, "10:03", "Weekend"), (35, "10:07", "Weekend"), (36, "10:11", "Weekend"),
  -- Trip 4: 10:35 departure
  (19, "10:35", "Weekend"), (20, "10:38", "Weekend"), (21, "10:42", "Weekend"), (22, "10:46", "Weekend"), (23, "10:50", "Weekend"), (24, "10:53", "Weekend"), (25, "10:57", "Weekend"), (26, "11:01", "Weekend"), (27, "11:05", "Weekend"), (28, "11:09", "Weekend"), (29, "11:13", "Weekend"), (30, "11:17", "Weekend"), (31, "11:21", "Weekend"), (32, "11:25", "Weekend"), (33, "11:28", "Weekend"), (34, "11:32", "Weekend"), (35, "11:36", "Weekend"), (36, "11:40", "Weekend"),
  -- Trip 5: 12:05 departure
  (19, "12:05", "Weekend"), (20, "12:09", "Weekend"), (21, "12:13", "Weekend"), (22, "12:17", "Weekend"), (23, "12:21", "Weekend"), (24, "12:24", "Weekend"), (25, "12:28", "Weekend"), (26, "12:32", "Weekend"), (27, "12:36", "Weekend"), (28, "12:40", "Weekend"), (29, "12:44", "Weekend"), (30, "12:48", "Weekend"), (31, "12:52", "Weekend"), (32, "12:56", "Weekend"), (33, "12:59", "Weekend"), (34, "13:03", "Weekend"), (35, "13:07", "Weekend"), (36, "13:11", "Weekend"),
  -- Trip 6: 13:35 departure
  (19, "13:35", "Weekend"), (20, "13:38", "Weekend"), (21, "13:42", "Weekend"), (22, "13:46", "Weekend"), (23, "13:50", "Weekend"), (24, "13:53", "Weekend"), (25, "13:57", "Weekend"), (26, "14:01", "Weekend"), (27, "14:05", "Weekend"), (28, "14:09", "Weekend"), (29, "14:13", "Weekend"), (30, "14:17", "Weekend"), (31, "14:21", "Weekend"), (32, "14:25", "Weekend"), (33, "14:28", "Weekend"), (34, "14:32", "Weekend"), (35, "14:36", "Weekend"), (36, "14:40", "Weekend"),
  -- Trip 7: 15:05 departure
  (19, "15:05", "Weekend"), (20, "15:08", "Weekend"), (21, "15:12", "Weekend"), (22, "15:16", "Weekend"), (23, "15:20", "Weekend"), (24, "15:23", "Weekend"), (25, "15:27", "Weekend"), (26, "15:31", "Weekend"), (27, "15:35", "Weekend"), (28, "15:39", "Weekend"), (29, "15:43", "Weekend"), (30, "15:47", "Weekend"), (31, "15:51", "Weekend"), (32, "15:55", "Weekend"), (33, "15:58", "Weekend"), (34, "16:02", "Weekend"), (35, "16:06", "Weekend"), (36, "16:10", "Weekend"),
  -- Trip 8: 16:35 departure
  (19, "16:35", "Weekend"), (20, "16:38", "Weekend"), (21, "16:42", "Weekend"), (22, "16:46", "Weekend"), (23, "16:50", "Weekend"), (24, "16:53", "Weekend"), (25, "16:57", "Weekend"), (26, "17:01", "Weekend"), (27, "17:05", "Weekend"), (28, "17:09", "Weekend"), (29, "17:13", "Weekend"), (30, "17:17", "Weekend"), (31, "17:21", "Weekend"), (32, "17:25", "Weekend"), (33, "17:28", "Weekend"), (34, "17:32", "Weekend"), (35, "17:36", "Weekend"), (36, "17:40", "Weekend"),
  -- Trip 9: 18:05 departure
  (19, "18:05", "Weekend"), (20, "18:09", "Weekend"), (21, "18:13", "Weekend"), (22, "18:17", "Weekend"), (23, "18:21", "Weekend"), (24, "18:24", "Weekend"), (25, "18:28", "Weekend"), (26, "18:32", "Weekend"), (27, "18:36", "Weekend"), (28, "18:40", "Weekend"), (29, "18:44", "Weekend"), (30, "18:48", "Weekend"), (31, "18:52", "Weekend"), (32, "18:56", "Weekend"), (33, "18:59", "Weekend"), (34, "19:03", "Weekend"), (35, "19:07", "Weekend"), (36, "19:11", "Weekend"),
  -- Trip 10: 19:35 departure
  (19, "19:35", "Weekend"), (20, "19:38", "Weekend"), (21, "19:42", "Weekend"), (22, "19:46", "Weekend"), (23, "19:50", "Weekend"), (24, "19:53", "Weekend"), (25, "19:57", "Weekend"), (26, "20:01", "Weekend"), (27, "20:05", "Weekend"), (28, "20:09", "Weekend"), (29, "20:13", "Weekend"), (30, "20:17", "Weekend"), (31, "20:21", "Weekend"), (32, "20:25", "Weekend"), (33, "20:28", "Weekend"), (34, "20:32", "Weekend"), (35, "20:36", "Weekend"), (36, "20:40", "Weekend");
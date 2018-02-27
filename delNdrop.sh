psql cs421 --echo-all <<-END 2>&1 | tee delNdrop.log

DROP TABLE Users CASCADE;
DROP TABLE Categories CASCADE;
DROP TABLE Dates CASCADE;
DROP TABLE Activities CASCADE;
DROP TABLE Reviews CASCADE;
DROP TABLE Venues CASCADE;
DROP TABLE Payments CASCADE;
DROP TABLE UserPrefersCategory CASCADE;
DROP TABLE Availabilities CASCADE;
DROP TABLE VenueAvailabilities CASCADE;
DROP TABLE ActivityCategories CASCADE;
DROP TABLE DateActivities CASCADE;
DROP TABLE UserAvailabilities CASCADE;
DROP TABLE VenueHasAvailability CASCADE;

END

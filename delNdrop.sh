psql cs421 --echo-all <<-END 2>&1 | tee delNdrop.log

DROP TABLE Users CASCADE;
DROP TABLE Categories CASCADE;
DROP TABLE Dates CASCADE;
DROP TABLE Activities CASCADE;
DROP TABLE Venues CASCADE;
DROP TABLE Payments CASCADE;
DROP TABLE UserPrefersCategories CASCADE;
DROP TABLE Availability CASCADE;
DROP TABLE VenueAvailability CASCADE;
DROP TABLE ActivityCategories CASCADE;
DROP TABLE DateActivities CASCADE;
DROP TABLE UserAvailability CASCADE;
DROP TABLE VenueHasAvailability CASCADE;

END

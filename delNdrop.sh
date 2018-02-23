psql cs421 --echo-all <<-END 2>&1 | tee delNdrop.log

DROP TABLE Categories
DROP TABLE Dates
DROP TABLE Activities
DROP TABLE Venues
DROP TABLE Payments
DROP TABLE UserPrefersCategories
DROP TABLE Availability
DROP TABLE VenueAvailability
DROP TABLE ActivityCategories
DROP TABLE DateActivities
DROP TABLE UserAvailability
DROP TABLE VenueHasAvailability

END

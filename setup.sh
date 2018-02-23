psql cs421 --echo-all <<-END 2>&1 | tee setup.log

CREATE TABLE Categories (
    categoryName VARCHAR(35),
    PRIMARY KEY(categoryName)
)

CREATE TABLE Dates (
	userOneEmailAddress VARCHAR(35) REFERENCES Users,
	userTwoEmailAddress VARCHAR(35) REFERENCES Users,
	date DATE,
	startTime VARCHAR(5),
	endTime VARCHAR(5),
	netPrice INT,
	PRIMARY KEY(date, startTime)
);

CREATE TABLE Activities (
	name VARCHAR(35),
	date DATE,
	startTime VARCHAR(5),
	endTime VARCHAR(5),
	address VARCHAR(35) NOT NULL,
	venueName VARCHAR(35) NOT NULL,
	price INT,
	PRIMARY KEY(name, date, startTime),
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name)
);


CREATE TABLE Venues (
	name VARCHAR(35),
	address VARCHAR(35),
	PRIMARY KEY (name, address)
)

CREATE TABLE Payments (
	PID INT PRIMARY KEY,
	venueAddress VARCHAR(35) NOT NULL,
	venueName VARCHAR(35) NOT NULL,
	timePaid DATE,
	amount INT,
	FOREIGN KEY(venueAddress, venueName) REFERENCES Venues(address, name)
)

CREATE TABLE UserPrefersCategories (
    emailAddress VARCHAR(35), 
    categoryName VARCHAR(20), 
    PRIMARY KEY(emailAddress, categoryName) 
);

CREATE TABLE Availability (
	date DATE,
	startTime CHAR(6),
	endTime CHAR(6),
	PRIMARY KEY(date, startTime)
);

CREATE TABLE VenueAvailability(
	date DATE,
	time CHAR(6),
	capacity INT,
	FOREIGN KEY(date, time) REFERENCES Availability(date, startTime),
	PRIMARY KEY(date, time)
)

CREATE TABLE ActivityCategories (
	date DATE,
	startTime CHAR(6),
	activityName VARCHAR(35),
	categoryName VARCHAR(30),
	PRIMARY KEY(date, startTime, activityName, categoryName),
	FOREIGN KEY(date, startTime, activityName) REFERENCES Activities(date, startTime, name),
	FOREIGN KEY(categoryName) REFERENCES Categories
)

CREATE TABLE DateActivities (
	participantEmailAddressOne VARCHAR(35) REFERENCES Users,
	participantEmailAddressTwo VARCHAR(35) REFERENCES Users,
	startTime CHAR(6),
	date DATE,
	activityDate DATE,
	activityStartTime CHAR(6),
	activityName VARCHAR(35),
	FOREIGN KEY(date, startTime) REFERENCES Dates(date, startTime),
	FOREIGN KEY(activityDate, activityStartTime, activityName) REFERENCES Activities(date, startTime, name),
	PRIMARY KEY(participantEmailAddressOne, participantEmailAddressTwo, startTime, date, activityDate, activityStartTime, activityName)
)

CREATE TABLE UserAvailability (
	emailAddress VARCHAR(35) REFERENCES Users,
	date DATE,
	startTime CHAR(6),
	FOREIGN KEY (date, startTime) REFERENCES Availability(date, startTime)
)

CREATE TABLE VenueHasAvailability (
	address VARCHAR(35),
	venueName VARCHAR(35),
	date DATE,
	time CHAR(6),
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name),
	FOREIGN KEY(date, time) REFERENCES Availability(date, startTime),
	PRIMARY KEY(address, venueName, date, time)
)

END

psql cs421 --echo-all <<-END 2>&1 | tee setup.log

CREATE TABLE Categories (
    categoryName VARCHAR(35),
    PRIMARY KEY(categoryName)
);

CREATE TABLE Users (
    emailAddress VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(6),
    genderPreference VARCHAR(6),
    age INT,
    budget INT,
    phoneNumber CHAR(14),
    lastName VARCHAR(30),
    firstName VARCHAR(30)
);

CREATE TABLE Dates (
	userOneEmailAddress VARCHAR(50) REFERENCES Users,
	userTwoEmailAddress VARCHAR(50) REFERENCES Users,
	date DATE,
	startTime VARCHAR(5),
	endTime VARCHAR(5),
	netPrice INT,
	PRIMARY KEY(date, startTime)
);

CREATE TABLE Venues (
	name VARCHAR(50),
	address VARCHAR(75),
	PRIMARY KEY (name, address)
);

CREATE TABLE Activities (
	name VARCHAR(50),
	date DATE,
	startTime VARCHAR(5),
	endTime VARCHAR(5),
	address VARCHAR(75) NOT NULL,
	venueName VARCHAR(75) NOT NULL,
	price INT,
	PRIMARY KEY(name, date, startTime),
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name)
);


CREATE TABLE Payments (
	PID INT PRIMARY KEY,
	venueAddress VARCHAR(75) NOT NULL,
	venueName VARCHAR(50) NOT NULL,
	timePaid DATE,
	amount INT,
	FOREIGN KEY(venueAddress, venueName) REFERENCES Venues(address, name)
);

CREATE TABLE UserPrefersCategories (
    emailAddress VARCHAR(50), 
    categoryName VARCHAR(35), 
    PRIMARY KEY(emailAddress, categoryName) 
);

CREATE TABLE Availability (
	date DATE,
	startTime CHAR(5),
	endTime CHAR(5),
	PRIMARY KEY(date, startTime)
);

CREATE TABLE VenueAvailability(
	date DATE,
	time CHAR(5),
	capacity INT,
	FOREIGN KEY(date, time) REFERENCES Availability(date, startTime),
	PRIMARY KEY(date, time)
);

CREATE TABLE ActivityCategories (
	date DATE,
	startTime CHAR(5),
	activityName VARCHAR(50),
	categoryName VARCHAR(35),
	PRIMARY KEY(date, startTime, activityName, categoryName),
	FOREIGN KEY(date, startTime, activityName) REFERENCES Activities(date, startTime, name),
	FOREIGN KEY(categoryName) REFERENCES Categories
);

CREATE TABLE DateActivities (
	participantEmailAddressOne VARCHAR(50) REFERENCES Users,
	participantEmailAddressTwo VARCHAR(50) REFERENCES Users,
	startTime CHAR(5),
	date DATE,
	activityDate DATE,
	activityStartTime CHAR(5),
	activityName VARCHAR(50),
	FOREIGN KEY(date, startTime) REFERENCES Dates(date, startTime),
	FOREIGN KEY(activityDate, activityStartTime, activityName) REFERENCES Activities(date, startTime, name),
	PRIMARY KEY(participantEmailAddressOne, participantEmailAddressTwo, startTime, date, activityDate, activityStartTime, activityName)
);

CREATE TABLE UserAvailability (
	emailAddress VARCHAR(50) REFERENCES Users,
	date DATE,
	startTime CHAR(5),
	FOREIGN KEY (date, startTime) REFERENCES Availability(date, startTime)
);

CREATE TABLE VenueHasAvailability (
	address VARCHAR(75),
	venueName VARCHAR(50),
	date DATE,
	time CHAR(5),
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name),
	FOREIGN KEY(date, time) REFERENCES Availability(date, startTime),
	PRIMARY KEY(address, venueName, date, time)
);

INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Morgan','Jane','Donec.egestas@dis.org',1140,'1-514-108-5682','Female','Female',25),('Morse','Alfreda','semper@eratvolutpatNulla.ca',1676,'1-514-340-3867','Female','Female',46),('Baldwin','Stacy','pharetra.felis@semelit.edu',2272,'1-514-527-4385','Male','Female',46),('Prince','Abbot','orci.lacus.vestibulum@tristique.ca',1925,'1-514-113-8877','Female','Male',18),('Richards','Leigh','dolor.vitae@aliquet.com',727,'1-514-955-0619','Other','Male',47),('Tran','Stuart','libero.et.tristique@Nulla.edu',4337,'1-514-100-1823','Other','Female',36),('Burch','Ayanna','nonummy@ametrisusDonec.edu',2279,'1-514-731-9139','Male','Male',66),('Dickerson','Morgan','Fusce.mi@vitaesodalesat.org',3946,'1-514-644-0754','Other','Female',37),('Farmer','Danielle','Proin.vel.nisl@Quisque.co.uk',590,'1-514-512-6921','Male','None',74),('Knight','Aspen','fermentum.metus@vitaeposuereat.org',3755,'1-514-806-1635','Other','Male',49);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Barker','Otto','sed.est@Nullam.edu',2355,'1-514-480-8326','Female','Female',51),('Beach','Denton','Nulla.interdum@auctor.net',2083,'1-514-703-8265','Other','Female',61),('Powell','Troy','quam.vel@adipiscing.org',919,'1-514-209-0037','Male','None',41),('Rivers','Clarke','in@purusgravidasagittis.edu',1096,'1-514-245-0990','Female','Female',58),('Joseph','Nathan','semper.rutrum@purus.org',4187,'1-514-825-1875','Male','Female',72),('Potter','Gray','Maecenas.mi@mitempor.ca',3956,'1-514-480-0158','Other','Female',60),('Goodman','Joelle','eu.placerat.eget@duiaugueeu.org',4243,'1-514-455-8896','Other','None',74),('Castillo','Cade','Nunc@sitametconsectetuer.co.uk',2865,'1-514-968-0101','Male','None',55),('Le','Wyatt','nec.imperdiet@magnamalesuada.net',2437,'1-514-302-0088','Female','None',26),('Douglas','Keane','arcu.eu@blandit.org',294,'1-514-806-6786','Other','Male',69);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Stewart','Nathaniel','Aenean.eget@ad.ca',4663,'1-514-650-5627','Female','Male',56),('Herrera','Macey','at@in.net',4198,'1-514-246-5290','Other','Female',75),('Morales','Noelani','mi.eleifend.egestas@adipiscingelitAliquam.org',3827,'1-514-477-5632','Male','None',67),('Roy','Amal','nec@Maecenaslibero.net',3822,'1-514-398-2137','Female','Male',35),('Jacobson','Andrew','dignissim.lacus@viverra.net',1125,'1-514-995-5020','Male','Female',70),('Lewis','Olympia','non@Mauris.com',578,'1-514-858-9207','Female','Female',50),('Stephenson','Tyler','massa.Quisque@nullaIntegervulputate.net',3503,'1-514-445-6017','Other','Female',46),('Cherry','Damon','purus@urnajusto.ca',4811,'1-514-217-0208','Male','Male',47),('Burks','Ray','Donec@tempor.edu',937,'1-514-577-8656','Male','Male',74),('Cook','Driscoll','dignissim.tempor.arcu@magnaaneque.com',2075,'1-514-811-4658','Female','None',66);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Hendricks','Hyatt','pharetra.Quisque.ac@iaculisquis.co.uk',3137,'1-514-420-6985','Male','Female',50),('Le','Cyrus','nunc@tempusnon.ca',803,'1-514-698-8613','Female','Female',28),('Myers','Isabella','ac.turpis.egestas@eget.edu',4275,'1-514-137-4135','Male','Female',21),('Valdez','Melanie','tortor.dictum.eu@orcisem.co.uk',2020,'1-514-784-9963','Male','None',42),('Doyle','Kareem','risus.Nunc@lorem.com',2262,'1-514-605-0495','Female','Male',46),('Winters','Dustin','ultricies.adipiscing.enim@nisia.net',3256,'1-514-462-0947','Male','Female',34),('Sweeney','Florence','sit@dictumeleifendnunc.co.uk',2572,'1-514-246-9908','Male','Male',38),('Garza','Shannon','massa.lobortis@semconsequatnec.ca',2854,'1-514-898-1099','Other','None',19),('Adkins','Orli','tellus.non@Nunc.net',4368,'1-514-312-9945','Other','Female',19),('Diaz','Whitney','sit.amet@veliteusem.com',824,'1-514-859-5006','Male','Male',64);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Merritt','Carolyn','at@duiFuscediam.ca',1084,'1-514-626-6927','Female','Female',31),('Zamora','Chloe','enim.non.nisi@pharetra.ca',2358,'1-514-316-3420','Female','Female',59),('Sexton','McKenzie','magna.malesuada.vel@Aenean.ca',1598,'1-514-984-2096','Female','None',39),('Pearson','Fitzgerald','sem.consequat.nec@vel.org',3623,'1-514-275-1015','Female','None',73),('Rollins','Francis','eu.eleifend.nec@at.ca',2660,'1-514-368-7398','Other','Female',23),('Bruce','Iliana','Aenean@Proinnisl.com',2705,'1-514-523-8713','Female','None',19),('Lindsay','Igor','elit.Nulla.facilisi@posuerevulputate.ca',4614,'1-514-866-9936','Female','Male',54),('Moreno','Wing','Pellentesque@tellus.com',3014,'1-514-202-1825','Female','None',58),('Pope','Thor','ipsum.cursus.vestibulum@Classaptent.ca',3844,'1-514-284-3315','Female','None',40),('Richards','Beverly','nunc.id.enim@consectetuer.co.uk',2434,'1-514-981-1022','Male','Male',60);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Copeland','Kane','penatibus.et@egestas.edu',3974,'1-514-931-5604','Female','Female',55),('Russell','Blythe','Donec@velitPellentesque.net',841,'1-514-158-2605','Female','None',35),('Michael','Dale','Proin.ultrices.Duis@duiCumsociis.edu',379,'1-514-716-4579','Female','Female',21),('Marks','Jeremy','vitae.orci@maurisblandit.edu',361,'1-514-297-3901','Male','None',56),('Hanson','Seth','imperdiet@Duiselementum.net',3726,'1-514-173-0030','Female','Female',43),('Spencer','Brent','eu.dui.Cum@fringilla.com',1278,'1-514-254-9780','Male','Male',22),('Clarke','Giselle','sit.amet@pretiumet.edu',226,'1-514-924-1245','Female','Male',65),('Fitzgerald','Destiny','ultrices@nisidictumaugue.com',699,'1-514-623-9408','Female','Female',45),('Lee','Teagan','in.sodales@consequat.co.uk',3243,'1-514-749-0469','Male','None',67),('Stark','Thaddeus','pharetra.felis.eget@nequevitae.ca',3000,'1-514-470-8865','Male','Female',33);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Walsh','Shellie','tristique.pellentesque@placerat.co.uk',635,'1-514-961-7723','Male','None',18),('Randall','Reese','venenatis.a.magna@Integer.net',1238,'1-514-128-6889','Other','Male',36),('Watts','Quintessa','accumsan@arcu.edu',2440,'1-514-211-7001','Other','Female',55),('Doyle','Lionel','eleifend.non@urna.org',2630,'1-514-889-3094','Female','Female',39),('Cooper','Francis','nec.luctus.felis@Crasvulputatevelit.net',4164,'1-514-772-0247','Male','None',50),('Howell','Jared','volutpat.Nulla@pharetrafeliseget.net',234,'1-514-498-0068','Male','Female',73),('Dejesus','Rudyard','ligula@sem.com',2404,'1-514-448-2439','Other','None',24),('Schneider','Dominic','dictum.placerat.augue@eratnonummy.co.uk',4191,'1-514-283-8435','Female','None',34),('Strong','Nyssa','eros@Sed.net',4687,'1-514-657-5246','Female','Male',44),('Hill','Joseph','Aliquam@faucibuslectusa.net',1724,'1-514-241-9465','Other','None',61);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Clayton','Melinda','convallis.in@blanditNamnulla.edu',4530,'1-514-781-1323','Male','None',41),('Mayer','Felix','imperdiet@enimSuspendisse.com',4459,'1-514-226-9045','Other','Female',54),('Mccormick','Faith','purus.ac@nullaIntincidunt.net',1944,'1-514-397-6433','Female','Male',25),('Parks','Judith','turpis.In.condimentum@loremeget.ca',4537,'1-514-341-9432','Male','Female',19),('Robertson','Blake','tristique@Aliquamrutrum.com',2406,'1-514-724-8997','Female','Female',43),('Mcdowell','Linus','ullamcorper@Mauris.net',2706,'1-514-368-4989','Male','Male',67),('Rodriguez','Stephanie','consectetuer.cursus@feugiat.edu',3863,'1-514-212-7223','Female','Male',18),('Rodriguez','Len','nunc@augueeutempor.com',4085,'1-514-269-7016','Other','Male',63),('Solis','Geoffrey','ligula@vitaeeratVivamus.com',2369,'1-514-102-0364','Male','None',42),('Ortiz','Colton','Cras.vulputate.velit@liberoatauctor.net',1483,'1-514-389-6992','Female','None',48);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Meadows','Dylan','Curabitur.consequat.lectus@eterosProin.net',2302,'1-514-172-1149','Male','None',73),('Carter','Cheyenne','vulputate.lacus.Cras@ametfaucibus.ca',1505,'1-514-330-6849','Other','Male',57),('Castaneda','Kibo','non.hendrerit@lobortistellusjusto.edu',2413,'1-514-324-5698','Male','None',31),('Cleveland','Sopoline','volutpat.ornare@ut.ca',1642,'1-514-680-2525','Male','Female',28),('Acosta','Anika','id.nunc.interdum@massanon.com',1079,'1-514-492-6286','Female','Female',18),('Harmon','Beau','Duis.volutpat.nunc@diamPellentesquehabitant.com',1323,'1-514-285-6503','Female','None',69),('Gill','Piper','euismod.in.dolor@eunullaat.edu',379,'1-514-911-4713','Male','Male',32),('Callahan','Eliana','odio@Nuncut.net',4894,'1-514-803-2945','Male','Male',55),('Lowery','Owen','eu@interdumenim.com',3300,'1-514-364-0211','Male','Female',60),('Britt','Shaeleigh','porttitor.eros.nec@tellussem.co.uk',3262,'1-514-911-8111','Male','Female',19);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Chan','Jolie','ac.metus.vitae@enimEtiam.ca',3176,'1-514-771-9000','Other','Female',53),('Chang','Nicholas','risus.Duis.a@aaliquet.ca',3814,'1-514-266-0115','Male','None',44),('Lamb','Alan','ipsum.Phasellus.vitae@gravidamauris.net',3833,'1-514-828-9451','Other','None',67),('Rosa','Hoyt','dui.semper@mattis.co.uk',4990,'1-514-817-6907','Male','Male',35),('Mccullough','Maryam','lacinia.vitae.sodales@tristiquepellentesque.co.uk',519,'1-514-749-9954','Male','Male',51),('Quinn','Cole','Quisque.libero@tristiquepharetra.edu',2655,'1-514-611-3730','Male','Female',65),('Atkins','Maxwell','eu@turpisIncondimentum.edu',1808,'1-514-478-0237','Male','Female',65),('Skinner','Carissa','dictum.Proin@risusQuisquelibero.com',984,'1-514-782-3743','Male','None',37),('Meyer','Grace','imperdiet.non@commodohendrerit.co.uk',4264,'1-514-904-9730','Male','None',46),('Horne','Ralph','posuere.cubilia.Curae@tincidunt.ca',2580,'1-514-774-2232','Male','None',26);
INSERT INTO availability (date, startTime, endTime) values ('5/3/2018', '12:33', '18:33');
INSERT INTO availability (date, startTime, endTime) values ('8/5/2018', '14:26', '16:18');
INSERT INTO availability (date, startTime, endTime) values ('4/22/2018', '14:58', '19:11');
INSERT INTO availability (date, startTime, endTime) values ('4/20/2018', '12:15', '18:43');
INSERT INTO availability (date, startTime, endTime) values ('8/5/2018', '13:11', '20:19');
INSERT INTO availability (date, startTime, endTime) values ('2/24/2018', '12:50', '16:47');
INSERT INTO availability (date, startTime, endTime) values ('8/7/2018', '12:03', '19:11');
INSERT INTO availability (date, startTime, endTime) values ('2/24/2018', '14:05', '18:00');
INSERT INTO availability (date, startTime, endTime) values ('6/24/2018', '14:09', '17:49');
INSERT INTO availability (date, startTime, endTime) values ('6/1/2018', '12:50', '15:14');
INSERT INTO availability (date, startTime, endTime) values ('7/4/2018', '14:38', '20:11');
INSERT INTO availability (date, startTime, endTime) values ('3/21/2018', '12:51', '22:54');
INSERT INTO availability (date, startTime, endTime) values ('4/11/2018', '12:14', '21:58');
INSERT INTO availability (date, startTime, endTime) values ('6/22/2018', '14:35', '16:51');
INSERT INTO availability (date, startTime, endTime) values ('2/24/2018', '12:52', '15:08');
INSERT INTO availability (date, startTime, endTime) values ('7/28/2018', '13:18', '19:45');
INSERT INTO availability (date, startTime, endTime) values ('7/5/2018', '13:45', '22:54');
INSERT INTO availability (date, startTime, endTime) values ('7/30/2018', '14:56', '15:34');
INSERT INTO availability (date, startTime, endTime) values ('8/21/2018', '13:26', '16:45');
INSERT INTO availability (date, startTime, endTime) values ('4/29/2018', '12:24', '19:16');
INSERT INTO availability (date, startTime, endTime) values ('4/24/2018', '14:23', '16:09');
INSERT INTO availability (date, startTime, endTime) values ('6/10/2018', '12:11', '19:58');
INSERT INTO availability (date, startTime, endTime) values ('3/26/2018', '13:22', '16:40');
INSERT INTO availability (date, startTime, endTime) values ('8/16/2018', '12:14', '15:57');
INSERT INTO availability (date, startTime, endTime) values ('5/16/2018', '12:02', '21:45');
INSERT INTO availability (date, startTime, endTime) values ('5/29/2018', '14:00', '16:56');
INSERT INTO availability (date, startTime, endTime) values ('6/24/2018', '14:31', '20:28');
INSERT INTO availability (date, startTime, endTime) values ('4/8/2018', '13:58', '18:40');
INSERT INTO availability (date, startTime, endTime) values ('5/27/2018', '14:30', '20:30');
INSERT INTO availability (date, startTime, endTime) values ('5/24/2018', '12:04', '20:23');
INSERT INTO availability (date, startTime, endTime) values ('5/21/2018', '13:23', '15:41');
INSERT INTO availability (date, startTime, endTime) values ('3/4/2018', '14:32', '22:12');
INSERT INTO availability (date, startTime, endTime) values ('3/30/2018', '12:30', '22:30');
INSERT INTO availability (date, startTime, endTime) values ('4/30/2018', '14:28', '19:51');
INSERT INTO availability (date, startTime, endTime) values ('7/29/2018', '13:44', '18:40');
INSERT INTO availability (date, startTime, endTime) values ('7/9/2018', '13:25', '17:46');
INSERT INTO availability (date, startTime, endTime) values ('8/13/2018', '14:07', '16:25');
INSERT INTO availability (date, startTime, endTime) values ('7/10/2018', '14:02', '16:12');
INSERT INTO availability (date, startTime, endTime) values ('4/18/2018', '14:57', '22:33');
INSERT INTO availability (date, startTime, endTime) values ('7/3/2018', '13:14', '16:39');
INSERT INTO availability (date, startTime, endTime) values ('3/5/2018', '12:16', '21:19');
INSERT INTO availability (date, startTime, endTime) values ('4/13/2018', '12:52', '20:56');
INSERT INTO availability (date, startTime, endTime) values ('7/23/2018', '12:07', '22:20');
INSERT INTO availability (date, startTime, endTime) values ('5/5/2018', '12:17', '22:06');
INSERT INTO availability (date, startTime, endTime) values ('2/25/2018', '13:23', '16:11');
INSERT INTO availability (date, startTime, endTime) values ('7/14/2018', '14:56', '22:50');
INSERT INTO availability (date, startTime, endTime) values ('6/14/2018', '14:16', '16:21');
INSERT INTO availability (date, startTime, endTime) values ('3/7/2018', '13:07', '21:59');
INSERT INTO availability (date, startTime, endTime) values ('4/23/2018', '13:16', '21:13');
INSERT INTO availability (date, startTime, endTime) values ('8/12/2018', '13:36', '20:51');
INSERT INTO availability (date, startTime, endTime) values ('7/31/2018', '12:59', '17:59');
INSERT INTO availability (date, startTime, endTime) values ('6/28/2018', '14:11', '21:14');
INSERT INTO availability (date, startTime, endTime) values ('3/24/2018', '14:14', '15:32');
INSERT INTO availability (date, startTime, endTime) values ('5/1/2018', '14:13', '19:09');
INSERT INTO availability (date, startTime, endTime) values ('7/5/2018', '14:03', '22:29');
INSERT INTO availability (date, startTime, endTime) values ('3/26/2018', '13:40', '16:06');
INSERT INTO availability (date, startTime, endTime) values ('3/8/2018', '14:06', '21:50');
INSERT INTO availability (date, startTime, endTime) values ('3/28/2018', '13:34', '19:53');
INSERT INTO availability (date, startTime, endTime) values ('3/26/2018', '13:57', '20:56');
INSERT INTO availability (date, startTime, endTime) values ('3/15/2018', '13:29', '20:42');
INSERT INTO availability (date, startTime, endTime) values ('5/14/2018', '13:01', '16:30');
INSERT INTO availability (date, startTime, endTime) values ('7/22/2018', '13:34', '21:15');
INSERT INTO availability (date, startTime, endTime) values ('6/17/2018', '13:20', '22:49');
INSERT INTO availability (date, startTime, endTime) values ('7/11/2018', '14:19', '22:02');
INSERT INTO availability (date, startTime, endTime) values ('3/28/2018', '13:23', '16:05');
INSERT INTO availability (date, startTime, endTime) values ('3/28/2018', '12:17', '15:12');
INSERT INTO availability (date, startTime, endTime) values ('7/16/2018', '13:26', '18:24');
INSERT INTO availability (date, startTime, endTime) values ('3/22/2018', '13:30', '18:24');
INSERT INTO availability (date, startTime, endTime) values ('3/21/2018', '14:09', '15:20');
INSERT INTO availability (date, startTime, endTime) values ('5/8/2018', '13:14', '15:16');
INSERT INTO availability (date, startTime, endTime) values ('4/17/2018', '13:15', '15:07');
INSERT INTO availability (date, startTime, endTime) values ('7/15/2018', '12:20', '17:28');
INSERT INTO availability (date, startTime, endTime) values ('3/12/2018', '13:03', '19:12');
INSERT INTO availability (date, startTime, endTime) values ('8/9/2018', '12:31', '20:22');
INSERT INTO availability (date, startTime, endTime) values ('7/29/2018', '14:43', '22:08');
INSERT INTO availability (date, startTime, endTime) values ('6/3/2018', '12:09', '18:08');
INSERT INTO availability (date, startTime, endTime) values ('4/6/2018', '13:50', '18:12');
INSERT INTO availability (date, startTime, endTime) values ('4/3/2018', '12:34', '21:42');
INSERT INTO availability (date, startTime, endTime) values ('6/2/2018', '12:19', '20:23');
INSERT INTO availability (date, startTime, endTime) values ('6/18/2018', '13:30', '19:31');
INSERT INTO availability (date, startTime, endTime) values ('7/7/2018', '14:42', '20:51');
INSERT INTO availability (date, startTime, endTime) values ('3/14/2018', '14:57', '19:01');
INSERT INTO availability (date, startTime, endTime) values ('4/8/2018', '14:27', '18:43');
INSERT INTO availability (date, startTime, endTime) values ('5/12/2018', '14:55', '15:44');
INSERT INTO availability (date, startTime, endTime) values ('5/16/2018', '14:12', '17:40');
INSERT INTO availability (date, startTime, endTime) values ('8/18/2018', '13:56', '20:38');
INSERT INTO availability (date, startTime, endTime) values ('5/11/2018', '14:06', '19:47');
INSERT INTO availability (date, startTime, endTime) values ('3/13/2018', '12:36', '20:04');
INSERT INTO availability (date, startTime, endTime) values ('5/22/2018', '14:16', '19:10');
INSERT INTO availability (date, startTime, endTime) values ('5/20/2018', '14:19', '18:53');
INSERT INTO availability (date, startTime, endTime) values ('6/10/2018', '14:58', '21:54');
INSERT INTO availability (date, startTime, endTime) values ('7/19/2018', '13:19', '15:41');
INSERT INTO availability (date, startTime, endTime) values ('5/4/2018', '12:21', '16:49');
INSERT INTO availability (date, startTime, endTime) values ('4/22/2018', '13:11', '15:12');
INSERT INTO availability (date, startTime, endTime) values ('7/23/2018', '14:13', '17:31');
INSERT INTO availability (date, startTime, endTime) values ('4/9/2018', '12:36', '18:14');
INSERT INTO availability (date, startTime, endTime) values ('8/11/2018', '14:12', '19:30');
INSERT INTO availability (date, startTime, endTime) values ('7/31/2018', '13:45', '19:30');
INSERT INTO availability (date, startTime, endTime) values ('3/14/2018', '14:19', '20:02');
INSERT INTO availability (date, startTime, endTime) values ('8/1/2018', '12:49', '17:33');

INSERT INTO Venues VALUES('Universel Dejeuner Bar and Grill', '2055 Peel St');
INSERT INTO Venues VALUES ('McDonalds', '625 Saint-Catherine St W');
INSERT INTO Venues VALUES ('Burger King', '977 Saint-Catherine St W');
INSERT INTO Venues VALUES ('Biodome', '4777 Pierre-de Coubertin Ave');
INSERT INTO Venues VALUES ('Upstairs Jazz Bar', '1254 Mackay St');
INSERT INTO Venues VALUES ('Tokyo Bar', '3709 St Laurent Blvd');
INSERT INTO Venues VALUES ('Cafe Campus', '57 Rue Prince Arthur E');


END

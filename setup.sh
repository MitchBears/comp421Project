psql cs421 --echo-all <<-END 2>&1 | tee setup.log

CREATE TABLE Categories (
    categoryName VARCHAR(35) NOT NULL,
    PRIMARY KEY(categoryName)
);

CREATE TABLE Users (
    emailAddress VARCHAR(50) PRIMARY KEY NOT NULL,
    gender VARCHAR(6),
    genderPreference VARCHAR(6),
    age INT NOT NULL CHECK(age > 17),
    budget INT CHECK(budget > 0),
    phoneNumber CHAR(14) NOT NULL,
    lastName VARCHAR(30),
    firstName VARCHAR(30) NOT NULL
);

CREATE TABLE Dates (
	userOneEmailAddress VARCHAR(50) NOT NULL REFERENCES Users,
	userTwoEmailAddress VARCHAR(50) NOT NULL REFERENCES Users,
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	endTime VARCHAR(5),
	netPrice INT CHECK(netPrice >= 0),
	PRIMARY KEY(userOneEmailAddress, userTwoEmailAddress, date, startTime)
);

CREATE TABLE Venues (
	name VARCHAR(50) NOT NULL,
	address VARCHAR(75) NOT NULL,
	PRIMARY KEY (name, address)
);

CREATE TABLE Activities (
	name VARCHAR(50) NOT NULL,
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	endTime VARCHAR(5),
	address VARCHAR(75) NOT NULL,
	venueName VARCHAR(75) NOT NULL,
	price INT CHECK(price >= 0),
	PRIMARY KEY(name, date, startTime),
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name)
);

CREATE TABLE Payments (
	PID INT PRIMARY KEY NOT NULL,
	venueAddress VARCHAR(75) NOT NULL,
	venueName VARCHAR(50) NOT NULL,
	timePaid DATE NOT NULL,
	amount INT NOT NULL CHECK(amount >= 0),
	FOREIGN KEY(venueAddress, venueName) REFERENCES Venues(address, name)
);

CREATE TABLE Reviews (
	reviewID INT PRIMARY KEY NOT NULL,
	emailAddress VARCHAR(50) NOT NULL,
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	name VARCHAR(50) NOT NULL,
	comments VARCHAR(200),
	rating INT CHECK(rating > 0 AND rating <= 10) NOT NULL,
	FOREIGN KEY(emailAddress) REFERENCES Users(emailAddress),
	FOREIGN KEY(date, startTime, name) REFERENCES Activities(date, startTime, name)
);

CREATE TABLE UserPrefersCategory (
    emailAddress VARCHAR(50) NOT NULL, 
    categoryName VARCHAR(35) NOT NULL, 
    PRIMARY KEY(emailAddress, categoryName) 
);

CREATE TABLE Availabilities (
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	endTime VARCHAR(5) NOT NULL,
	PRIMARY KEY(date, startTime, endTime)
);

CREATE TABLE VenueAvailabilities(
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	endTime VARCHAR(5) NOT NULL,
	capacity INT CHECK(capacity >= 0),
	FOREIGN KEY(date, startTime, endTime) REFERENCES Availabilities(date, startTime, endTime),
	PRIMARY KEY(date, startTime, endTime)
);

CREATE TABLE ActivityCategories (
	activityName VARCHAR(50) NOT NULL,
	date DATE NOT NULL,
	startTime CHAR(5) NOT NULL,
	categoryName VARCHAR(35) NOT NULL,
	PRIMARY KEY(date, startTime, activityName, categoryName),
	FOREIGN KEY(date, startTime, activityName) REFERENCES Activities(date, startTime, name),
	FOREIGN KEY(categoryName) REFERENCES Categories
);

CREATE TABLE DateActivities (
	participantEmailAddressOne VARCHAR(50) NOT NULL,
	participantEmailAddressTwo VARCHAR(50) NOT NULL,
	startTime CHAR(5) NOT NULL,
	date DATE NOT NULL,
	activityDate DATE NOT NULL,
	activityStartTime CHAR(5) NOT NULL,
	activityName VARCHAR(50) NOT NULL,
	FOREIGN KEY(participantEmailAddressOne, participantEmailAddressTwo, startTime, date) REFERENCES Dates(userOneEmailAddress, userTwoEmailAddress, startTime, date),
	FOREIGN KEY(activityDate, activityStartTime, activityName) REFERENCES Activities(date, startTime, name),
	PRIMARY KEY(participantEmailAddressOne, participantEmailAddressTwo, startTime, date, activityDate, activityStartTime, activityName)
);

CREATE TABLE UserAvailabilities (
	emailAddress VARCHAR(50) NOT NULL REFERENCES Users,
	date DATE NOT NULL,
	startTime VARCHAR(5) NOT NULL,
	endTime VARCHAR(5) NOT NULL,
	FOREIGN KEY (date, startTime, endTime) REFERENCES Availabilities(date, startTime, endTime),
	PRIMARY KEY(emailAddress, date, startTime, endTime)
);

CREATE TABLE VenueHasAvailability (
	address VARCHAR(75) NOT NULL,
	venueName VARCHAR(50) NOT NULL,
	date DATE NOT NULL,
	startTime CHAR(5) NOT NULL,
	endTime CHAR(5) NOT NULL,
	FOREIGN KEY(address, venueName) REFERENCES Venues(address, name),
	FOREIGN KEY(date, startTime, endTime) REFERENCES VenueAvailabilities(date, startTime, endTime),
	PRIMARY KEY(address, venueName, date, startTime, endTime)
);

INSERT INTO Users (emailAddress, age, budget, phoneNumber, lastName, firstName, gender, genderPreference) VALUES
('john.smith@gmail.com', 25, 250, '5145551234', 'Smith', 'John', 'Male', 'Male'),
('anne.poppins@gmail.com', 23, 800, '5142970770', 'Poppins', 'Anne', 'Female', 'Male'),
('tonyhawk50@hotmail.com', 34, 1200, '5148839942', 'Hawk', 'Tony', 'Male', 'Female'),
('elaineWilliams@yahoo.com', 29, 150, '5148276543', 'Williams', 'Elaine', 'Female', 'Female'),
('miriam_farry@yahoo.com', 19, 300, '5146706709', 'Farry', 'Miriam', 'Female', 'Male'),
('madison_hof@ygmail.com', 22, 100, '5146619516', 'Hof',  'Madison', 'Male', 'Female'),
('christianEspo99@gmail.com', 39, 1500, '5149986677', 'Espos', 'Christian', 'Other', 'Female'),
('emilySeinfeld123@gmail.com', 42, 1500, '5141552436', 'Seinfeld', 'Emily', 'Female', 'Both'),
('mobyDick32@gmail.com', 75, 75, '5140001295', 'Dick', 'Moby', 'Male', 'Male');


INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Morgan','Jane','Donec.egestas@dis.org',1140,'1-514-108-5682','Female','Female',25),('Morse','Alfreda','semper@eratvolutpatNulla.ca',1676,'1-514-340-3867','Female','Female',46),('Baldwin','Stacy','pharetra.felis@semelit.edu',2272,'1-514-527-4385','Male','Female',46),('Prince','Abbot','orci.lacus.vestibulum@tristique.ca',1925,'1-514-113-8877','Female','Male',18),('Richards','Leigh','dolor.vitae@aliquet.com',727,'1-514-955-0619','Other','Male',47),('Tran','Stuart','libero.et.tristique@Nulla.edu',4337,'1-514-100-1823','Other','Female',36),('Burch','Ayanna','nonummy@ametrisusDonec.edu',2279,'1-514-731-9139','Male','Male',66),('Dickerson','Morgan','Fusce.mi@vitaesodalesat.org',3946,'1-514-644-0754','Other','Female',37),('Farmer','Danielle','Proin.vel.nisl@Quisque.co.uk',590,'1-514-512-6921','Male','None',74),('Knight','Aspen','fermentum.metus@vitaeposuereat.org',3755,'1-514-806-1635','Other','Male',49);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Barker','Otto','sed.est@Nullam.edu',2355,'1-514-480-8326','Female','Female',51),('Beach','Denton','Nulla.interdum@auctor.net',2083,'1-514-703-8265','Other','Female',61),('Powell','Troy','quam.vel@adipiscing.org',919,'1-514-209-0037','Male','None',41),('Rivers','Clarke','in@purusgravidasagittis.edu',1096,'1-514-245-0990','Female','Female',58),('Joseph','Nathan','semper.rutrum@purus.org',4187,'1-514-825-1875','Male','Female',72),('Potter','Gray','Maecenas.mi@mitempor.ca',3956,'1-514-480-0158','Other','Female',60),('Goodman','Joelle','eu.placerat.eget@duiaugueeu.org',4243,'1-514-455-8896','Other','None',74),('Castillo','Cade','Nunc@sitametconsectetuer.co.uk',2865,'1-514-968-0101','Male','None',55),('Le','Wyatt','nec.imperdiet@magnamalesuada.net',2437,'1-514-302-0088','Female','None',26),('Douglas','Keane','arcu.eu@blandit.org',294,'1-514-806-6786','Other','Male',69);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Stewart','Nathaniel','Aenean.eget@ad.ca',4663,'1-514-650-5627','Female','Male',56),('Herrera','Macey','at@in.net',4198,'1-514-246-5290','Other','Female',75),('Morales','Noelani','mi.eleifend.egestas@adipiscingelitAliquam.org',3827,'1-514-477-5632','Male','None',67),('Roy','Amal','nec@Maecenaslibero.net',3822,'1-514-398-2137','Female','Male',35),('Jacobson','Andrew','dignissim.lacus@viverra.net',1125,'1-514-995-5020','Male','Female',70),('Lewis','Olympia','non@Mauris.com',578,'1-514-858-9207','Female','Female',50),('Stephenson','Tyler','massa.Quisque@nullaIntegervulputate.net',3503,'1-514-445-6017','Other','Female',46),('Cherry','Damon','purus@urnajusto.ca',4811,'1-514-217-0208','Male','Male',47),('Burks','Ray','Donec@tempor.edu',937,'1-514-577-8656','Male','Male',74),('Cook','Driscoll','dignissim.tempor.arcu@magnaaneque.com',2075,'1-514-811-4658','Female','None',66);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Hendricks','Hyatt','pharetra.Quisque.ac@iaculisquis.co.uk',3137,'1-514-420-6985','Male','Female',50),('Le','Cyrus','nunc@tempusnon.ca',803,'1-514-698-8613','Female','Female',28),('Myers','Isabella','ac.turpis.egestas@eget.edu',4275,'1-514-137-4135','Male','Female',21),('Valdez','Melanie','tortor.dictum.eu@orcisem.co.uk',2020,'1-514-784-9963','Male','None',42),('Doyle','Kareem','risus.Nunc@lorem.com',2262,'1-514-605-0495','Female','Male',46),('Winters','Dustin','ultricies.adipiscing.enim@nisia.net',3256,'1-514-462-0947','Male','Female',34),('Sweeney','Florence','sit@dictumeleifendnunc.co.uk',2572,'1-514-246-9908','Male','Male',38),('Garza','Shannon','massa.lobortis@semconsequatnec.ca',2854,'1-514-898-1099','Other','None',19),('Adkins','Orli','tellus.non@Nunc.net',4368,'1-514-312-9945','Other','Female',19),('Diaz','Whitney','sit.amet@veliteusem.com',824,'1-514-859-5006','Male','Male',64);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Merritt','Carolyn','at@duiFuscediam.ca',1084,'1-514-626-6927','Female','Female',31),('Zamora','Chloe','enim.non.nisi@pharetra.ca',2358,'1-514-316-3420','Female','Female',59),('Sexton','McKenzie','magna.malesuada.vel@Aenean.ca',1598,'1-514-984-2096','Female','None',39),('Pearson','Fitzgerald','sem.consequat.nec@vel.org',3623,'1-514-275-1015','Female','None',73),('Rollins','Francis','eu.eleifend.nec@at.ca',2660,'1-514-368-7398','Other','Female',23),('Bruce','Iliana','Aenean@Proinnisl.com',2705,'1-514-523-8713','Female','None',19),('Lindsay','Igor','elit.Nulla.facilisi@posuerevulputate.ca',4614,'1-514-866-9936','Female','Male',54),('Moreno','Wing','Pellentesque@tellus.com',3014,'1-514-202-1825','Female','None',58),('Pope','Thor','ipsum.cursus.vestibulum@Classaptent.ca',3844,'1-514-284-3315','Female','None',40),('Richards','Beverly','nunc.id.enim@consectetuer.co.uk',2434,'1-514-981-1022','Male','Male',60);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Copeland','Kane','penatibus.et@egestas.edu',3974,'1-514-931-5604','Female','Female',55),('Russell','Blythe','Donec@velitPellentesque.net',841,'1-514-158-2605','Female','None',35),('Michael','Dale','Proin.ultrices.Duis@duiCumsociis.edu',379,'1-514-716-4579','Female','Female',21),('Marks','Jeremy','vitae.orci@maurisblandit.edu',361,'1-514-297-3901','Male','None',56),('Hanson','Seth','imperdiet@Duiselementum.net',3726,'1-514-173-0030','Female','Female',43),('Spencer','Brent','eu.dui.Cum@fringilla.com',1278,'1-514-254-9780','Male','Male',22),('Clarke','Giselle','sit.amet@pretiumet.edu',226,'1-514-924-1245','Female','Male',65),('Fitzgerald','Destiny','ultrices@nisidictumaugue.com',699,'1-514-623-9408','Female','Female',45),('Lee','Teagan','in.sodales@consequat.co.uk',3243,'1-514-749-0469','Male','None',67),('Stark','Thaddeus','pharetra.felis.eget@nequevitae.ca',3000,'1-514-470-8865','Male','Female',33);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Walsh','Shellie','tristique.pellentesque@placerat.co.uk',635,'1-514-961-7723','Male','None',18),('Randall','Reese','venenatis.a.magna@Integer.net',1238,'1-514-128-6889','Other','Male',36),('Watts','Quintessa','accumsan@arcu.edu',2440,'1-514-211-7001','Other','Female',55),('Doyle','Lionel','eleifend.non@urna.org',2630,'1-514-889-3094','Female','Female',39),('Cooper','Francis','nec.luctus.felis@Crasvulputatevelit.net',4164,'1-514-772-0247','Male','None',50),('Howell','Jared','volutpat.Nulla@pharetrafeliseget.net',234,'1-514-498-0068','Male','Female',73),('Dejesus','Rudyard','ligula@sem.com',2404,'1-514-448-2439','Other','None',24),('Schneider','Dominic','dictum.placerat.augue@eratnonummy.co.uk',4191,'1-514-283-8435','Female','None',34),('Strong','Nyssa','eros@Sed.net',4687,'1-514-657-5246','Female','Male',44),('Hill','Joseph','Aliquam@faucibuslectusa.net',1724,'1-514-241-9465','Other','None',61);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Clayton','Melinda','convallis.in@blanditNamnulla.edu',4530,'1-514-781-1323','Male','None',41),('Mayer','Felix','imperdiet@enimSuspendisse.com',4459,'1-514-226-9045','Other','Female',54),('Mccormick','Faith','purus.ac@nullaIntincidunt.net',1944,'1-514-397-6433','Female','Male',25),('Parks','Judith','turpis.In.condimentum@loremeget.ca',4537,'1-514-341-9432','Male','Female',19),('Robertson','Blake','tristique@Aliquamrutrum.com',2406,'1-514-724-8997','Female','Female',43),('Mcdowell','Linus','ullamcorper@Mauris.net',2706,'1-514-368-4989','Male','Male',67),('Rodriguez','Stephanie','consectetuer.cursus@feugiat.edu',3863,'1-514-212-7223','Female','Male',18),('Rodriguez','Len','nunc@augueeutempor.com',4085,'1-514-269-7016','Other','Male',63),('Solis','Geoffrey','ligula@vitaeeratVivamus.com',2369,'1-514-102-0364','Male','None',42),('Ortiz','Colton','Cras.vulputate.velit@liberoatauctor.net',1483,'1-514-389-6992','Female','None',48);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Meadows','Dayna','Curabitur.consequat.lectus@eterosProin.net',2302,'1-514-172-1149','Female','None',73),('Carter','Cheyenne','vulputate.lacus.Cras@ametfaucibus.ca',1505,'1-514-330-6849','Other','Male',57),('Castaneda','Kibo','non.hendrerit@lobortistellusjusto.edu',2413,'1-514-324-5698','Male','None',31),('Cleveland','Sopoline','volutpat.ornare@ut.ca',1642,'1-514-680-2525','Male','Female',28),('Acosta','Anika','id.nunc.interdum@massanon.com',1079,'1-514-492-6286','Female','Female',18),('Harmon','Beau','Duis.volutpat.nunc@diamPellentesquehabitant.com',1323,'1-514-285-6503','Female','None',69),('Gill','Piper','euismod.in.dolor@eunullaat.edu',379,'1-514-911-4713','Male','Male',32),('Callahan','Eliana','odio@Nuncut.net',4894,'1-514-803-2945','Male','Male',55),('Lowery','Owen','eu@interdumenim.com',3300,'1-514-364-0211','Male','Female',60),('Britt','Shaeleigh','porttitor.eros.nec@tellussem.co.uk',3262,'1-514-911-8111','Male','Female',19);
INSERT INTO Users (lastName,firstName,emailAddress,budget,phoneNumber,gender,genderPreference,age) VALUES ('Chan','Jolie','ac.metus.vitae@enimEtiam.ca',3176,'1-514-771-9000','Other','Female',53),('Chang','Nicholas','risus.Duis.a@aaliquet.ca',3814,'1-514-266-0115','Male','None',44),('Lamb','Alan','ipsum.Phasellus.vitae@gravidamauris.net',3833,'1-514-828-9451','Other','None',67),('Rosa','Hoyt','dui.semper@mattis.co.uk',4990,'1-514-817-6907','Male','Male',35),('Mccullough','Maryam','lacinia.vitae.sodales@tristiquepellentesque.co.uk',519,'1-514-749-9954','Male','Male',51),('Quinn','Cole','Quisque.libero@tristiquepharetra.edu',2655,'1-514-611-3730','Male','Female',65),('Atkins','Maxwell','eu@turpisIncondimentum.edu',1808,'1-514-478-0237','Male','Female',65),('Skinner','Carissa','dictum.Proin@risusQuisquelibero.com',984,'1-514-782-3743','Male','None',37),('Meyer','Grace','imperdiet.non@commodohendrerit.co.uk',4264,'1-514-904-9730','Male','None',46),('Horne','Ralph','posuere.cubilia.Curae@tincidunt.ca',2580,'1-514-774-2232','Male','None',26);
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/28', '12:37', '19:21');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/15', '15:39', '20:41');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '11:32', '17:23');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/28', '15:35', '18:31');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/04', '16:49', '21:53');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/04', '12:30', '18:44');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/10', '16:17', '21:33');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/12', '14:29', '18:51');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/21', '14:26', '20:50');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/07', '12:03', '19:31');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/18', '16:16', '22:17');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/07', '14:30', '18:16');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/10', '14:49', '17:39');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/05', '12:34', '17:17');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/14', '16:57', '17:28');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/26', '13:33', '18:11');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/08', '12:48', '17:59');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/01', '15:24', '21:46');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/17', '14:53', '20:08');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/04', '14:11', '18:50');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/07', '16:49', '22:36');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/01', '15:03', '19:25');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/17', '14:52', '21:31');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/28', '14:19', '22:16');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/16', '15:06', '19:28');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/04', '13:29', '17:37');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/25', '14:00', '20:03');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/23', '14:13', '17:26');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/28', '13:08', '19:10');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/02', '13:43', '21:39');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/26', '16:51', '19:43');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/14', '15:25', '19:45');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '18:39', '23:23');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/22', '13:05', '20:48');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/26', '15:52', '18:17');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/30', '16:24', '22:37');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/05', '13:18', '20:29');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/12', '13:11', '19:36');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/10', '12:04', '17:46');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/07', '16:32', '19:14');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/10', '12:59', '21:23');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/17', '12:07', '18:20');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/04', '15:24', '22:49');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/27', '12:20', '21:13');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/27', '15:42', '21:58');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/03', '12:18', '22:42');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '19:00', '22:30');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/30', '15:58', '20:10');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/25', '13:36', '19:51');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/15', '15:44', '17:17');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/15', '14:36', '21:08');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/08', '12:56', '19:21');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/25', '13:41', '19:08');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/30', '14:01', '22:01');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/25', '14:07', '21:35');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/06', '14:59', '21:27');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/26', '12:04', '19:45');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/18', '12:20', '20:56');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/11', '13:33', '22:30');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/10', '13:59', '21:52');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/03', '16:31', '22:16');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/18', '14:45', '20:48');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/06', '15:10', '20:45');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/14', '12:27', '21:31');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/06', '15:39', '21:41');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '21:12', '02:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/28', '14:19', '20:20');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/04', '13:35', '21:27');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/25', '14:36', '19:43');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/25', '15:29', '19:20');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/14', '13:27', '21:20');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/27', '13:15', '20:38');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/19', '15:29', '21:56');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '15:35', '18:27');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/30', '12:52', '21:26');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/17', '12:55', '20:14');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '15:21', '22:43');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/13', '14:29', '18:02');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/12', '16:31', '22:12');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/27', '15:35', '17:29');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/19', '12:40', '19:47');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/14', '13:47', '21:18');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/28', '12:38', '22:04');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/07', '15:45', '22:42');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/01', '13:59', '20:24');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/28', '10:35', '18:01');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/23', '15:15', '22:29');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/21', '13:23', '22:59');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/02/27', '14:00', '18:15');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/18', '13:04', '21:57');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/22', '13:45', '18:50');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/28', '12:18', '17:51');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/30', '13:15', '20:34');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '20:52', '01:12');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/17', '15:24', '17:17');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/14', '16:21', '19:05');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '11:17', '16:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/04', '16:00', '21:50');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/20', '13:21', '18:35');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/03/24', '16:18', '17:10');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/28', '10:00', '23:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/28', '10:00', '18:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '12:30', '02:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '09:00', '21:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '00:00', '23:59');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/02', '10:00', '23:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/16', '19:00', '04:00');
INSERT INTO Availabilities (date, startTime, endTime) VALUES ('2018/04/09', '07:00', '11:00');

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Donec.egestas@dis.org','2018/04/28','12:18', '17:51' );
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Donec.egestas@dis.org','2018/04/02', '15:35', '18:27');
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Curabitur.consequat.lectus@eterosProin.net','2018/04/28', '10:35', '18:01');

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('imperdiet@enimSuspendisse.com','2018/04/16', '15:21', '22:43');
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('ac.metus.vitae@enimEtiam.ca','2018/04/16', '18:39', '23:23' );

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('venenatis.a.magna@Integer.net','2018/04/02', '11:17', '16:00' );
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Donec@velitPellentesque.net','2018/04/02', '11:32', '17:23');

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Aenean.eget@ad.ca','2018/04/16', '20:52', '01:12' );
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('imperdiet@enimSuspendisse.com','2018/04/16', '21:12', '02:00');

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('tonyhawk50@hotmail.com','2018/04/16', '19:00', '22:30' );
INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('john.smith@gmail.com','2018/04/16', '18:39', '23:23');

INSERT INTO UserAvailabilities (emailAddress, date, startTime, endTime) VALUES ('Nulla.interdum@auctor.net','2018/03/24', '16:18', '17:10');

INSERT INTO Venues (name, address) VALUES ('Universel Dejeuner Bar and Grill', '2055 Peel St');
INSERT INTO Venues (name, address) VALUES ('McDonalds', '625 Saint-Catherine St W');
INSERT INTO Venues (name, address) VALUES ('Burger King', '977 Saint-Catherine St W');
INSERT INTO Venues (name, address) VALUES ('Biodome', '4777 Pierre-de Coubertin Ave');
INSERT INTO Venues (name, address) VALUES ('Upstairs Jazz Bar', '1254 Mackay St');
INSERT INTO Venues (name, address) VALUES ('Tokyo Bar', '3709 St Laurent Blvd');
INSERT INTO Venues (name, address) VALUES ('Cafe Campus', '57 Rue Prince Arthur E');
INSERT INTO Venues (name, address) VALUES ('Parc La Fontaine', '1619 QC-138');
INSERT INTO Venues (name, address) VALUES ('Mount Royal', 'Mount Royal');
INSERT INTO Venues (name, address) VALUES ('Beaver Lake', 'Beaver Lake');

INSERT INTO Payments (PID, venueAddress, venueName, timePaid, amount) VALUES (0, '1254 Mackay St', 'Upstairs Jazz Bar', '2018/03/30', 1500);
INSERT INTO Payments (PID, venueAddress, venueName, timePaid, amount) VALUES (1, '1254 Mackay St', 'Upstairs Jazz Bar', '2018/03/31', 1738);
INSERT INTO Payments (PID, venueAddress, venueName, timePaid, amount) VALUES (2, '3709 St Laurent Blvd', 'Tokyo Bar', '2018/03/29', 1900);
INSERT INTO Payments (PID, venueAddress, venueName, timePaid, amount) VALUES (3, '625 Saint-Catherine St W', 'McDonalds', '2018/04/1', 70);
INSERT INTO Payments (PID, venueAddress, venueName, timePaid, amount) VALUES (4, '2055 Peel St', 'Universel Dejeuner Bar and Grill', '2018/04/15', 1650);


INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Burgers for Lunch', '2018/04/28', '12:30', '13:30', '977 Saint-Catherine St W', 'Burger King', 15);
INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Biodome Visit', '2018/04/28', '14:30', '17:30', '4777 Pierre-de Coubertin Ave', 'Biodome', 20);

INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Dinner and Jazz', '2018/04/16', '19:30', '22:30', '1254 Mackay St', 'Upstairs Jazz Bar', 14);

INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Skating on Beaver Lake', '2018/04/02', '14:00', '15:30', 'Beaver Lake', 'Beaver Lake', 10);
INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Hike to Beaver Lake', '2018/04/02', '13:00', '14:00', 'Mount Royal', 'Mount Royal', 0);
INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Burgers for Lunch', '2018/04/02', '12:00', '13:00', '625 Saint-Catherine St W', 'McDonalds', 15);

INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Clubbing at Cafe Campus', '2018/04/16', '23:00', '01:00', '57 Rue Prince Arthur E', 'Cafe Campus', 8);

INSERT INTO Activities (name, date, startTime, endTime, address, venueName, price) VALUES('Breakfast Buffet', '2018/04/09', '09:00', '11:00', '2055 Peel St', 'Universel Dejeuner Bar and Grill', 20);


INSERT INTO Categories (categoryName) VALUES('food');
INSERT INTO Categories (categoryName) VALUES('club');
INSERT INTO Categories (categoryName) VALUES('fitness');
INSERT INTO Categories (categoryName) VALUES('music');
INSERT INTO Categories (categoryName) VALUES('bar');
INSERT INTO Categories (categoryName) VALUES('nature');
INSERT INTO Categories (categoryName) VALUES('theatre');
INSERT INTO Categories (categoryName) VALUES('movie');
INSERT INTO Categories (categoryName) VALUES('dance');
INSERT INTO Categories (categoryName) VALUES('sports');
INSERT INTO Categories (categoryName) VALUES('cheap');

INSERT INTO Dates (userOneEmailAddress, userTwoEmailAddress, date, startTime, endTime, netPrice) VALUES('Donec.egestas@dis.org', 'Curabitur.consequat.lectus@eterosProin.net', '2018/04/28', '12:30','17:30', 35);
INSERT INTO Dates (userOneEmailAddress, userTwoEmailAddress, date, startTime, endTime, netPrice) VALUES('imperdiet@enimSuspendisse.com', 'ac.metus.vitae@enimEtiam.ca', '2018/04/16', '19:30','22:30', 14);
INSERT INTO Dates (userOneEmailAddress, userTwoEmailAddress, date, startTime, endTime, netPrice) VALUES('venenatis.a.magna@Integer.net', 'Donec@velitPellentesque.net', '2018/04/02', '13:00','15:30', 10);
INSERT INTO Dates (userOneEmailAddress, userTwoEmailAddress, date, startTime, endTime, netPrice) VALUES('Aenean.eget@ad.ca', 'imperdiet@enimSuspendisse.com','2018/04/16', '23:00', '01:00', 8);
INSERT INTO Dates (userOneEmailAddress, userTwoEmailAddress, date, startTime, endTime, netPrice) VALUES('tonyhawk50@hotmail.com', 'john.smith@gmail.com', '2018/04/16', '19:30','22:30', 14);

INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('Donec.egestas@dis.org', 'Curabitur.consequat.lectus@eterosProin.net', '2018/04/28', '12:30', 'Burgers for Lunch', '2018/04/28', '12:30');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('Donec.egestas@dis.org', 'Curabitur.consequat.lectus@eterosProin.net', '2018/04/28', '12:30', 'Biodome Visit', '2018/04/28', '14:30');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('imperdiet@enimSuspendisse.com', 'ac.metus.vitae@enimEtiam.ca', '2018/04/16', '19:30', 'Dinner and Jazz', '2018/04/16', '19:30');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('venenatis.a.magna@Integer.net', 'Donec@velitPellentesque.net', '2018/04/02', '13:00', 'Skating on Beaver Lake', '2018/04/02', '14:00');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('venenatis.a.magna@Integer.net', 'Donec@velitPellentesque.net', '2018/04/02', '13:00', 'Hike to Beaver Lake', '2018/04/02', '13:00');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('venenatis.a.magna@Integer.net', 'Donec@velitPellentesque.net', '2018/04/02', '13:00', 'Burgers for Lunch', '2018/04/02', '12:00');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('Aenean.eget@ad.ca', 'imperdiet@enimSuspendisse.com','2018/04/16', '23:00', 'Clubbing at Cafe Campus', '2018/04/16', '23:00');
INSERT INTO DateActivities (participantEmailAddressOne, participantEmailAddressTwo, date, startTime, activityName, activityDate, activityStartTime) VALUES('tonyhawk50@hotmail.com', 'john.smith@gmail.com', '2018/04/16', '19:30', 'Dinner and Jazz', '2018/04/16', '19:30');

INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Burgers for Lunch', '2018/04/28', '12:30', 'food');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Burgers for Lunch', '2018/04/28', '12:30', 'cheap');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Biodome Visit', '2018/04/28', '14:30', 'nature');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Dinner and Jazz', '2018/04/16', '19:30', 'food');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Dinner and Jazz', '2018/04/16', '19:30', 'music');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Dinner and Jazz', '2018/04/16', '19:30', 'bar');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Skating on Beaver Lake', '2018/04/02', '14:00', 'fitness');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Skating on Beaver Lake', '2018/04/02', '14:00', 'nature');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Hike to Beaver Lake', '2018/04/02', '13:00', 'fitness');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Hike to Beaver Lake', '2018/04/02', '13:00', 'nature');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Hike to Beaver Lake', '2018/04/02', '13:00', 'cheap');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Burgers for Lunch', '2018/04/02', '12:00', 'food');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Burgers for Lunch', '2018/04/02', '12:00', 'cheap');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Clubbing at Cafe Campus', '2018/04/16', '23:00', 'club');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Clubbing at Cafe Campus', '2018/04/16', '23:00', 'music');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Clubbing at Cafe Campus', '2018/04/16', '23:00', 'bar');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Clubbing at Cafe Campus', '2018/04/16', '23:00', 'dance');
INSERT INTO ActivityCategories (activityName, date, startTime, categoryName) VALUES('Breakfast Buffet', '2018/04/09', '09:00', 'food');

INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('82738', 'tonyhawk50@hotmail.com', '2018/04/16', '19:30', 'Dinner and Jazz', 'Great atmosphere and fantastic music. Food and drinks were pretty pricy, though.', 8);
INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('82790', 'imperdiet@enimSuspendisse.com','2018/04/16', '19:30', 'Dinner and Jazz', 'Music was boring and sub-par. Food and drinks were excellent, well worth the price.', 4);
INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('79688', 'Nulla.interdum@auctor.net','2018/04/09', '09:00', 'Breakfast Buffet', 'tasty foodz', 10);
INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('78402', 'venenatis.a.magna@Integer.net','2018/04/02', '13:00', 'Hike to Beaver Lake', 'Perfect weather, pefect length!', 9);
INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('85721', 'Curabitur.consequat.lectus@eterosProin.net','2018/04/28', '14:30', 'Biodome Visit', 'Those animals sure were animal-y! And the plants were exceedingly plant-y', 5);
INSERT INTO Reviews (reviewID, emailAddress, date, startTime, name, comments, rating) VALUES('78503', 'tonyhawk50@hotmail.com', '2018/04/02', '13:00', 'Hike to Beaver Lake', 'Nothing compared to a good X-games.', 1);

INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/28', '10:00', '23:00', 60);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/28', '10:00', '18:00', 200);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/16', '12:30', '02:00', 50);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/02', '09:00', '21:00', NULL);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/02', '00:00', '23:59', NULL);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/02', '10:00', '23:00', 60);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/16', '19:00', '04:00', 300);
INSERT INTO VenueAvailabilities (date, startTime, endTime, capacity) VALUES('2018/04/09', '07:00', '11:00', 100);

INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('977 Saint-Catherine St W', 'Burger King', '2018/04/28', '10:00', '23:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('4777 Pierre-de Coubertin Ave', 'Biodome', '2018/04/28', '10:00', '18:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('1254 Mackay St', 'Upstairs Jazz Bar', '2018/04/16', '12:30', '02:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('Beaver Lake', 'Beaver Lake', '2018/04/02', '09:00', '21:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('Mount Royal', 'Mount Royal', '2018/04/02', '00:00', '23:59');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('625 Saint-Catherine St W', 'McDonalds', '2018/04/02', '10:00', '23:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('57 Rue Prince Arthur E', 'Cafe Campus', '2018/04/16', '19:00', '04:00');
INSERT INTO VenueHasAvailability (address, venueName, date, startTime, endTime) VALUES('2055 Peel St', 'Universel Dejeuner Bar and Grill', '2018/04/09', '07:00', '11:00');

INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Donec.egestas@dis.org', 'cheap');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Donec.egestas@dis.org', 'nature');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Curabitur.consequat.lectus@eterosProin.net', 'food');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Curabitur.consequat.lectus@eterosProin.net', 'nature');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('imperdiet@enimSuspendisse.com', 'music');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('ac.metus.vitae@enimEtiam.ca', 'music');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('ac.metus.vitae@enimEtiam.ca', 'food');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('ac.metus.vitae@enimEtiam.ca', 'fitness');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('venenatis.a.magna@Integer.net', 'fitness');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Donec@velitPellentesque.net', 'nature');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Aenean.eget@ad.ca', 'music');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Aenean.eget@ad.ca', 'dance');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Aenean.eget@ad.ca', 'bar');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('Aenean.eget@ad.ca', 'club');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('tonyhawk50@hotmail.com', 'food');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('tonyhawk50@hotmail.com', 'sports');
INSERT INTO UserPrefersCategory (emailAddress, categoryName) VALUES ('tonyhawk50@hotmail.com', 'fitness');



















END

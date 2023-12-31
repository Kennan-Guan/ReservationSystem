CREATE DATABASE IF NOT EXISTS ReservationSystem;
USE ReservationSystem;

DROP TABLE IF EXISTS airline;
CREATE TABLE airline (
    airline_id CHAR(2) NOT NULL,
    PRIMARY KEY (airline_id)
);

DROP TABLE IF EXISTS aircraft;
CREATE TABLE aircraft (
    aircraft_id VARCHAR(5) PRIMARY KEY,
    seats INTEGER NOT NULL,
    airline_id CHAR(2),
    FOREIGN KEY (airline_id) REFERENCES ReservationSystem.airline (airline_id) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS aircraft_days;
CREATE TABLE aircraft_days(
	aircraft_id VARCHAR(5),
    day_of_week VARCHAR(10),
    FOREIGN KEY (aircraft_id) REFERENCES ReservationSystem.aircraft (aircraft_id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (aircraft_id, day_of_week)
);

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
    airport_id CHAR(3) PRIMARY KEY
);

DROP TABLE IF EXISTS customerrep;
CREATE TABLE customerrep (
    repusername VARCHAR(30) NOT NULL,
    reppassword VARCHAR(30) NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    PRIMARY KEY (repusername)
);
INSERT INTO customerrep (repusername, reppassword, firstname, lastname)
VALUES ('custrep', 'custrep', 'cust', 'rep');


DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
    adminusername VARCHAR(30) NOT NULL,
    adminpassword VARCHAR(30) NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    PRIMARY KEY (adminusername)
);
INSERT INTO admin (adminusername, adminpassword, firstname, lastname)
VALUES ('admin', 'admin', 'admin', 'admin');
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    username VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    PRIMARY KEY (username)
);
INSERT INTO customer (username, password, firstname, lastname)
VALUES ('achuth', 'achuth', 'achuth', 'nair');
DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
    flight_num VARCHAR(5),
    airline_id CHAR(2),
    is_domestic BOOLEAN NOT NULL,
    aircraft_id VARCHAR(5) NOT NULL,
    departure_airport_id CHAR(3) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_airport_id CHAR(3) NOT NULL,
    arrival_time DATETIME NOT NULL,
    economy_rate FLOAT NOT NULL,
    seats_remaining INT NOT NULL,
foreign Key (airline_id) References ReservationSystem.airline (airline_id) ON DELETE CASCADE ON UPDATE CASCADE,
foreign Key (aircraft_id) References ReservationSystem.aircraft (aircraft_id) ON UPDATE CASCADE,
foreign key (departure_airport_id) References ReservationSystem.airport(airport_id) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (arrival_airport_id) References ReservationSystem.airport(airport_id) ON DELETE CASCADE ON UPDATE CASCADE,
primary key (flight_num, airline_id)
);

DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets (
	ticket_id INT AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    purchase_datetime DATETIME NOT NULL,
    total_fare FLOAT NOT NULL,
    class VARCHAR(10) NOT NULL,
    booking_fee FLOAT NOT NULL DEFAULT 10.00,
    passenger_fname VARCHAR(30) NOT NULL,
    passenger_lname VARCHAR(30) NOT NULL,
    FOREIGN KEY (username)
        REFERENCES ReservationSystem.customer (username) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (ticket_id)
);

DROP TABLE IF EXISTS ticket_flights;
CREATE TABLE ticket_flights(
	ticket_id INT,
    flight_num VARCHAR(5),
    airline_id CHAR(2),
    seat_number INT NOT NULL,
    PRIMARY KEY (ticket_id, flight_num, airline_id),
    FOREIGN KEY(ticket_id) 
		REFERENCES ReservationSystem.tickets (ticket_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (airline_id) 
        REFERENCES ReservationSystem.flight (airline_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (flight_num) 
        REFERENCES ReservationSystem.flight (flight_num) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS operates_in;
CREATE TABLE operates_in (
    airport_id CHAR(3),
    airline_id CHAR(2),
    PRIMARY KEY (airport_id , airline_id),
    FOREIGN KEY (airport_id)
        REFERENCES airport (airport_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (airline_id)
        REFERENCES airline (airline_id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS waitinglist;
CREATE TABLE waitinglist (
    username VARCHAR(30) NOT NULL,
    airline_id VARCHAR(2) NOT NULL,
    flight_num VARCHAR(5) NOT NULL,
    waitlistAlert BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (username)
        REFERENCES ReservationSystem.customer (username) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (airline_id)
        REFERENCES ReservationSystem.flight (airline_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (flight_num)
        REFERENCES ReservationSystem.flight (flight_num) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (username , airline_id , flight_num)
);

DROP TABLE IF EXISTS all_usernames;
CREATE TABLE all_usernames (
    username VARCHAR(30) NOT NULL PRIMARY KEY
);

INSERT INTO all_usernames (username)
SELECT username FROM customer
UNION
SELECT repusername FROM customerrep;

DROP TABLE IF EXISTS chat_message;
CREATE TABLE chat_message (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id VARCHAR(30) NOT NULL,
    text VARCHAR(255) NOT NULL,
    date_time_sent DATETIME NOT NULL,
        responded CHAR(1) DEFAULT 'N',
    FOREIGN KEY (sender_id) REFERENCES all_usernames (username)
        ON DELETE CASCADE ON UPDATE CASCADE
);



DROP TABLE IF EXISTS chat_customer;

CREATE TABLE chat_customer (
    username VARCHAR(30) NOT NULL,
    PRIMARY KEY (username),
    FOREIGN KEY (username)
        REFERENCES customer (username) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS chat_customer_rep;
CREATE TABLE chat_customer_rep (
    repusername VARCHAR(30) NOT NULL,
    PRIMARY KEY (repusername),
    FOREIGN KEY (repusername)
        REFERENCES customerrep (repusername) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS chat_association;
CREATE TABLE chat_association (
    chat_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_username VARCHAR(30) NOT NULL,
    rep_username VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_username) REFERENCES customer (username) ON UPDATE CASCADE,
    FOREIGN KEY (rep_username) REFERENCES customerrep (repusername) ON UPDATE CASCADE
);













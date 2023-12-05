CREATE DATABASE IF NOT EXISTS ReservationSystem;
USE ReservationSystem;

DROP TABLE IF EXISTS airline;
CREATE TABLE airline (
    airline_id VARCHAR(5) NOT NULL,
    PRIMARY KEY (airline_id)
);

DROP TABLE IF EXISTS aircraft;
CREATE TABLE aircraft (
    aircraft_id VARCHAR(5) PRIMARY KEY,
    seats INTEGER,
    airline_id CHAR(5)
);

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
    airport_id CHAR(5) PRIMARY KEY
);

DROP TABLE IF EXISTS customerrep;
CREATE TABLE customerrep (
    repusername VARCHAR(30) NOT NULL,
    reppassword VARCHAR(30) NOT NULL,
    PRIMARY KEY (repusername)
);

DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
    adminusername VARCHAR(30) NOT NULL,
    adminpassword VARCHAR(30) NOT NULL,
    PRIMARY KEY (adminusername)
);
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    username VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
    PRIMARY KEY (username)
);

DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
    flight_num VARCHAR(5),
    airline_id VARCHAR(5),
    is_domestic BOOLEAN,
    aircraft_id VARCHAR(5),
    departure_airport_id VARCHAR(5),
    departure_time DATETIME,
    departure_date DATE NOT NULL,
    arrival_airport_id VARCHAR(5),
    arrival_time DATETIME,
    seats INT,
    stops INT NOT NULL,
    econonmy_rate INT NOT NULL,
    business_rate INT NOT NULL,
    firstclass_rate INT NOT NULL,
foreign Key (airline_id) References ReservationSystem.airline (airline_id),
foreign Key (aircraft_id) References ReservationSystem.aircraft (aircraft_id),
primary key (airline_id, aircraft_id,departure_date)
);
DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets (
    username VARCHAR(30) NOT NULL,
    airline_id VARCHAR(5) NOT NULL,
    aircraft_id VARCHAR(5) NOT NULL,
    ticket_id VARCHAR(5) NOT NULL,
    departure_airport VARCHAR(5) NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_airport VARCHAR(5) NOT NULL,
    seat_class VARCHAR(15) NOT NULL,
    seat_number INT NOT NULL,
    FOREIGN KEY (username)
        REFERENCES ReservationSystem.customer (username),
    FOREIGN KEY (airline_id)
        REFERENCES ReservationSystem.flight (airline_id),
    FOREIGN KEY (aircraft_id)
        REFERENCES ReservationSystem.flight (aircraft_id),
    PRIMARY KEY (username , ticket_id)
);

DROP TABLE IF EXISTS operates_in;
CREATE TABLE operates_in (
    airport_id CHAR(5),
    airline_id CHAR(5),
    PRIMARY KEY (airport_id , airline_id),
    FOREIGN KEY (airport_id)
        REFERENCES airport (airport_id),
    FOREIGN KEY (airline_id)
        REFERENCES airline (airline_id)
);

DROP TABLE IF EXISTS waitinglist;
CREATE TABLE waitinglist (
    username VARCHAR(30) NOT NULL,
    airline_id VARCHAR(5) NOT NULL,
    aircraft_id VARCHAR(5) NOT NULL,
    departure_date DATE NOT NULL,
    FOREIGN KEY (username)
        REFERENCES ReservationSystem.customer (username),
    PRIMARY KEY (username , airline_id , aircraft_id , departure_date)
);
DROP TABLE IF EXISTS chat_message;
CREATE TABLE chat_message (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id VARCHAR(30) NOT NULL,
    receiver_id VARCHAR(30) NOT NULL,
    text VARCHAR(255) NOT NULL,
    date_time_sent DATETIME NOT NULL
);
DROP TABLE IF EXISTS chat_customer;
CREATE TABLE chat_customer (
    username VARCHAR(30) NOT NULL,
    PRIMARY KEY (username),
    FOREIGN KEY (username)
        REFERENCES customer (username)
);

DROP TABLE IF EXISTS chat_customer_rep;
CREATE TABLE chat_customer_rep (
    repusername VARCHAR(30) NOT NULL,
    PRIMARY KEY (repusername),
    FOREIGN KEY (repusername)
        REFERENCES customerrep (repusername)
);












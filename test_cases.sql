-- Values for airline table
INSERT INTO airline (airline_id) VALUES
('AA'),
('DL'),
('UA'),
('WN'),
('LH'),
('NK');

-- Values for aircraft table
INSERT INTO aircraft (aircraft_id, seats, airline_id) VALUES
('A320', 150, 'AA'),
('A101', 3, 'AA'),
('A222', 100, 'AA'),
('B737', 160, 'WN'),
('B777', 300, 'UA'),
('B123', 68, 'UA'),
('B007', 2, 'UA'),
('B709', 200, 'UA'),
('A380', 550, 'LH'),
('MD90', 130, 'DL'),
('MD01', 122, 'DL'),
('MD99', 180, 'DL'),
('F111', 2, 'NK'),
('F337', 200, 'NK'),
('F122', 101, 'NK');

INSERT INTO aircraft_days VALUES
('A320', 'Monday'),
('A320', 'Tuesday'),
('A320', 'Wednesday'),
('A320', 'Thursday'),
('A320', 'Friday'),
('A320', 'Saturday'),
('A320', 'Sunday'),
('A101', 'Monday'),
('A101', 'Tuesday'),
('A101', 'Wednesday'),
('A101', 'Thursday'),
('A101', 'Friday'),
('A101', 'Saturday'),
('A101', 'Sunday'),
('A222', 'Monday'),
('A222', 'Tuesday'),
('A222', 'Wednesday'),
('A222', 'Thursday'),
('A222', 'Friday'),
('A222', 'Saturday'),
('A222', 'Sunday'),
('B737', 'Monday'),
('B737', 'Tuesday'),
('B737', 'Wednesday'),
('B737', 'Thursday'),
('B737', 'Friday'),
('B737', 'Saturday'),
('B737', 'Sunday'),
('B777', 'Monday'),
('B777', 'Tuesday'),
('B777', 'Wednesday'),
('B777', 'Thursday'),
('B777', 'Friday'),
('B777', 'Saturday'),
('B777', 'Sunday'),
('B123', 'Monday'),
('B123', 'Tuesday'),
('B123', 'Wednesday'),
('B123', 'Thursday'),
('B123', 'Friday'),
('B123', 'Saturday'),
('B123', 'Sunday'),
('B007', 'Monday'),
('B007', 'Tuesday'),
('B007', 'Wednesday'),
('B007', 'Thursday'),
('B007', 'Friday'),
('B007', 'Saturday'),
('B007', 'Sunday'),
('B709', 'Monday'),
('B709', 'Tuesday'),
('B709', 'Wednesday'),
('B709', 'Thursday'),
('B709', 'Friday'),
('B709', 'Saturday'),
('B709', 'Sunday'),
('A380', 'Monday'),
('A380', 'Tuesday'),
('A380', 'Wednesday'),
('A380', 'Thursday'),
('A380', 'Friday'),
('A380', 'Saturday'),
('A380', 'Sunday'),
('MD90', 'Monday'),
('MD90', 'Tuesday'),
('MD90', 'Wednesday'),
('MD90', 'Thursday'),
('MD90', 'Friday'),
('MD90', 'Saturday'),
('MD90', 'Sunday'),
('MD01', 'Monday'),
('MD01', 'Tuesday'),
('MD01', 'Wednesday'),
('MD01', 'Thursday'),
('MD01', 'Friday'),
('MD01', 'Saturday'),
('MD01', 'Sunday'),
('MD99', 'Monday'),
('MD99', 'Tuesday'),
('MD99', 'Wednesday'),
('MD99', 'Thursday'),
('MD99', 'Friday'),
('MD99', 'Saturday'),
('MD99', 'Sunday'),
('F111', 'Monday'),
('F111', 'Tuesday'),
('F111', 'Wednesday'),
('F111', 'Thursday'),
('F111', 'Friday'),
('F111', 'Saturday'),
('F111', 'Sunday'),
('F337', 'Monday'),
('F337', 'Tuesday'),
('F337', 'Wednesday'),
('F337', 'Thursday'),
('F337', 'Friday'),
('F337', 'Saturday'),
('F337', 'Sunday'),
('F122', 'Monday'),
('F122', 'Tuesday'),
('F122', 'Wednesday'),
('F122', 'Thursday'),
('F122', 'Friday'),
('F122', 'Saturday'),
('F122', 'Sunday')
;
-- Values for airport table
INSERT INTO airport (airport_id) VALUES
('JFK'),
('LAX'),
('ORD'),
('SFO'),
('ATL'),
('EWR'), 
('BGI'), 
('LGA'), 
('PEK'), 
('LHR'), 
('CLT');
-- Values for customerrep table
INSERT INTO customerrep (repusername, reppassword, firstname, lastname) VALUES
('rep_user1', 'password123', 'John', 'Doe'),
('rep_user2', 'secret456', 'Jane', 'Smith'),
('rep_user3', 'secure789', 'Chris', 'Johnson');

-- Values for admin table
INSERT INTO admin (adminusername, adminpassword, firstname, lastname) VALUES
('admin_user1', 'adminpass123', 'Admin', 'One'),
('admin_user2', 'adminpass456', 'Admin', 'Two'),
('admin_user3', 'adminpass789', 'Admin', 'Three');

-- Values for customer table
INSERT INTO customer (username, password, firstname, lastname) VALUES
('john_doe', 'userpass123', 'John', 'Doe'),
('jane_smith', 'pass456', 'Jane', 'Smith'),
('chris_johnson', 'secure789', 'Chris', 'Johnson');

-- Values for flight table
-- (Assuming you have airlines AA, WN, and airports JFK, LAX)
INSERT INTO flight (flight_num, airline_id, is_domestic, aircraft_id, departure_airport_id, departure_time, arrival_airport_id, arrival_time, economy_rate, seats_remaining)
VALUES ('FL001', 'AA', true, 'A320', 'JFK', '2023-12-13 10:00:00', 'LAX', '2023-12-13 16:00:00', 200.50, 149),
       ('FL002', 'WN', false, 'B737', 'LAX', '2023-12-12 12:00:00', 'JFK', '2023-12-12 17:49:00', 180.00, 119),
       ('FL001', 'UA', TRUE, 'A320', 'EWR', '2023-12-22 23:00:00', 'CLT', '2023-12-23 02:00:00', 200.00, 150),
	   ('FL002', 'UA', TRUE, 'A320', 'CLT', '2023-12-23 04:00:00', 'ORD', '2023-12-23 08:00:00', 200.00, 150),
	   ('FL003', 'UA', TRUE, 'A320', 'ORD', '2023-12-23 10:00:00', 'LGA', '2023-12-23 14:00:00', 200.00, 150),
	   ('FL004', 'UA', FALSE, 'A320', 'LGA', '2023-12-23 15:20:00', 'BGI', '2023-12-23 22:00:00', 200.00, 150),
	   ('FL001', 'NK', FALSE, 'F337', 'EWR', '2023-12-22 11:00:00', 'BGI','2023-12-22 18:05:00', 500.00, 200),
	   ('FL002', 'NK', TRUE, 'F111', 'EWR', '2023-12-20 12:01:55', 'LGA', '2023-12-20 12:00:00', 100.00, 0);

-- Values for tickets table
-- (Assuming you have a customer with the username 'john_doe')
INSERT INTO tickets (username, purchase_datetime, total_fare, class, booking_fee, passenger_fname, passenger_lname) VALUES
('john_doe', '2023-12-11 15:30:00', 150.00, 'Economy', 10.00, 'John', 'Doe'),
('john_doe', '2023-12-11 16:00:00', 180.00, 'Business', 10.00, 'John', 'Doe'),
('john_doe', '2023-12-11 16:00:00', 100.00, 'Economy', 10.00, 'John', 'Doe'),
('chris_johnson', '2023-12-13 16:02:00', 100.00, 'First', 10.00, 'Chris', 'Johnson');

-- Values for ticket_flights table
INSERT INTO ticket_flights (ticket_id, flight_num, airline_id, seat_number) VALUES
(1, 'FL001', 'AA', 150),
(2, 'FL002', 'WN', 150),
(3, 'FL002', 'NK', 2),
(4, 'FL002', 'NK', 1);

-- Values for operates_in table
-- (Assuming you have airlines AA, WN and airports JFK, LAX)
INSERT INTO operates_in (airport_id, airline_id) VALUES
('JFK', 'AA'),
('JFK', 'UA'),
('JFK', 'DL'),
('JFK', 'WN'),
('JFK', 'LH'),
('JFK', 'NK'),
('LAX', 'AA'),
('LAX', 'UA'),
('LAX', 'DL'),
('LAX', 'WN'),
('LAX', 'LH'),
('LAX', 'NK'),
('EWR', 'AA'),
('EWR', 'UA'),
('EWR', 'DL'),
('EWR', 'LH'),
('EWR', 'WN'),
('EWR', 'NK'),
('CLT', 'UA'),
('CLT', 'AA'),
('CLT', 'DL'),
('CLT', 'WN'),
('CLT', 'LH'),
('CLT', 'NK'),
('LGA','UA'),
('LGA','AA'),
('LGA','DL'),
('LGA','WN'),
('LGA','LH'),
('LGA','NK'),
('ORD','UA'),
('ORD','AA'),
('ORD','DL'),
('ORD','WN'),
('ORD','LH'),
('ORD','NK'),
('BGI','UA'),
('BGI', 'NK'),
('BGI', 'AA'),
('BGI', 'DL'),
('BGI', 'WN'),
('BGI', 'LH'),
('SFO', 'AA'),
('SFO', 'UA'),
('SFO', 'DL'),
('SFO', 'LH'),
('SFO', 'NK'),
('SFO', 'WN'),
('ATL','AA'),
('ATL','DL'),
('ATL','UA'),
('ATL','WN'),
('ATL','LH'),
('ATL','NK'),
('PEK', 'AA'),
('PEK', 'UA'), 
('PEK', 'DL'), 
('PEK', 'WN'), 
('PEK', 'LH'), 
('PEK', 'NK'),  
('LHR', 'AA'),
('LHR', 'UA'),
('LHR', 'DL'),
('LHR', 'WN'),
('LHR', 'LH'),
('LHR', 'NK');

-- Values for waitinglist table
-- (Assuming you have a customer with the username 'jane_smith' and airlines AA, WN)
INSERT INTO waitinglist (username, airline_id, flight_num) VALUES
('jane_smith', 'NK', 'FL002');

-- Values for all_usernames table
-- (Assuming you have existing usernames from the customer and customerrep tables)
INSERT INTO all_usernames (username) VALUES
('john_doe'),
('jane_smith'),
('chris_johnson'),
('rep_user1'),
('rep_user2'),
('rep_user3');

-- Values for chat_message table
-- (Assuming you have existing usernames from the all_usernames table)
INSERT INTO chat_message (sender_id, text, date_time_sent, responded) VALUES
('john_doe', 'Hello!', '2023-12-11 18:00:00', 'N'),
('jane_smith', 'How are you?', '2023-12-11 18:30:00', 'N');

-- Values for chat_customer table
-- (Assuming you have existing usernames from the customer table)
INSERT INTO chat_customer (username) VALUES
('john_doe'),
('jane_smith');

-- Values for chat_customer_rep table
-- (Assuming you have existing repusernames from the customerrep table)
INSERT INTO chat_customer_rep (repusername) VALUES
('rep_user1'),
('rep_user2');

-- Values for chat_association table
-- (Assuming you have existing usernames from the customer and customerrep tables)
INSERT INTO chat_association (customer_username, rep_username) VALUES
('john_doe', 'rep_user1'),
('jane_smith', 'rep_user2');

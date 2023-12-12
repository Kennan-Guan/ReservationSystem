-- Values for airline table
INSERT INTO airline (airline_id) VALUES
('AA'),
('DL'),
('UA'),
('WN'),
('LH');

-- Values for aircraft table
INSERT INTO aircraft (aircraft_id, seats, airline_id) VALUES
('A320', 150, 'AA'),
('B737', 160, 'WN'),
('B777', 300, 'UA'),
('A380', 550, 'LH'),
('MD90', 130, 'DL');

-- Values for airport table
INSERT INTO airport (airport_id) VALUES
('JFK'),
('LAX'),
('ORD'),
('SFO'),
('ATL');
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
VALUES ('FL001', 'AA', true, 'A320', 'JFK', '2023-12-11 10:00:00', 'LAX', '2023-12-11 14:00:00', 200.50, 150),
       ('FL002', 'WN', false, 'B737', 'LAX', '2023-12-12 12:00:00', 'JFK', '2023-12-12 16:00:00', 180.00, 120);

-- Values for tickets table
-- (Assuming you have a customer with the username 'john_doe')
INSERT INTO tickets (username, purchase_datetime, total_fare, class) VALUES
('john_doe', '2023-12-11 15:30:00', 150.00, 'Economy'),
('john_doe', '2023-12-11 16:00:00', 180.00, 'Business');

-- Values for ticket_flights table
INSERT INTO ticket_flights (ticket_id, flight_num, airline_id, seat_number) VALUES
(1, 'FL001', 'AA', 15),
(2, 'FL002', 'WN', 10);

-- Values for operates_in table
-- (Assuming you have airlines AA, WN and airports JFK, LAX)
INSERT INTO operates_in (airport_id, airline_id) VALUES
('JFK', 'AA'),
('LAX', 'WN');

-- Values for waitinglist table
-- (Assuming you have a customer with the username 'jane_smith' and airlines AA, WN)
INSERT INTO waitinglist (username, airline_id, flight_num) VALUES
('jane_smith', 'AA', 'FL002'),
('jane_smith', 'WN', 'FL001');

-- Values for all_usernames table
-- (Assuming you have existing usernames from the customer and customerrep tables)
INSERT INTO all_usernames (username) VALUES
('john_doe'),
('jane_smith'),
('rep_user1'),
('rep_user2');

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

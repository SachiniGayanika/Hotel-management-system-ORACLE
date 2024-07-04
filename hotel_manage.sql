CREATE TABLE Hotel (
    hotel_id INT PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    address VARCHAR2(255),
    city VARCHAR2(100),
    country VARCHAR2(100)
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY,
    hotel_id INT,
    room_number INT,
    type VARCHAR2(50),
    rate_per_night NUMBER(8,2),
    capacity INT,
    CONSTRAINT fk_hotel_id FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Guest (
    guest_id INT PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(20)
);

CREATE TABLE Reservation (
    reservation_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE,
    check_out_date DATE,
    CONSTRAINT fk_guest_id FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
    CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES Room(room_id),
    CONSTRAINT chk_dates CHECK (check_out_date > check_in_date)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    reservation_id INT,
    amount_paid NUMBER(10,2),
    payment_date DATE,
    CONSTRAINT fk_reservation_id FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);


-- Insert data into Hotel table
INSERT INTO Hotel (hotel_id, name, address, city, country)
VALUES (1, 'Hotel ABC', '123 Main Street', 'New York', 'USA');

INSERT INTO Hotel (hotel_id, name, address, city, country)
VALUES (2, 'Grand Hotel', '456 Elm Street', 'Los Angeles', 'USA');

INSERT INTO Hotel (hotel_id, name, address, city, country)
VALUES (3, 'Beach Resort', '789 Ocean Avenue', 'Miami', 'USA');

INSERT INTO Hotel (hotel_id, name, address, city, country)
VALUES (4, 'Mountain Lodge', '101 Pine Road', 'Aspen', 'USA');

INSERT INTO Hotel (hotel_id, name, address, city, country)
VALUES (5, 'City Plaza Hotel', '555 Downtown Blvd', 'Chicago', 'USA');

-- Insert data into Room table
INSERT INTO Room (room_id, hotel_id, room_number, type, rate_per_night, capacity)
VALUES (1, 1, 101, 'Single', 100.00, 1);

INSERT INTO Room (room_id, hotel_id, room_number, type, rate_per_night, capacity)
VALUES (2, 1, 102, 'Double', 150.00, 2);

INSERT INTO Room (room_id, hotel_id, room_number, type, rate_per_night, capacity)
VALUES (3, 2, 201, 'Single', 120.00, 1);

INSERT INTO Room (room_id, hotel_id, room_number, type, rate_per_night, capacity)
VALUES (4, 2, 202, 'Double', 180.00, 2);

INSERT INTO Room (room_id, hotel_id, room_number, type, rate_per_night, capacity)
VALUES (5, 3, 301, 'Suite', 250.00, 4);

-- Insert data into Guest table
INSERT INTO Guest (guest_id, name, email, phone)
VALUES (1, 'John Smith', 'john@example.com', '123-456-7890');

INSERT INTO Guest (guest_id, name, email, phone)
VALUES (2, 'Jane Doe', 'jane@example.com', '987-654-3210');

INSERT INTO Guest (guest_id, name, email, phone)
VALUES (3, 'Michael Johnson', 'michael@example.com', '456-789-0123');

INSERT INTO Guest (guest_id, name, email, phone)
VALUES (4, 'Emily Brown', 'emily@example.com', '321-654-0987');

INSERT INTO Guest (guest_id, name, email, phone)
VALUES (5, 'David Wilson', 'david@example.com', '789-012-3456');

-- Insert data into Reservation table
INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date)
VALUES (1, 1, 1, TO_DATE('2024-03-15', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date)
VALUES (2, 2, 2, TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'));

INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date)
VALUES (3, 3, 3, TO_DATE('2024-05-20', 'YYYY-MM-DD'), TO_DATE('2024-05-25', 'YYYY-MM-DD'));

INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date)
VALUES (4, 4, 4, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD'));

INSERT INTO Reservation (reservation_id, guest_id, room_id, check_in_date, check_out_date)
VALUES (5, 5, 5, TO_DATE('2024-07-15', 'YYYY-MM-DD'), TO_DATE('2024-07-20', 'YYYY-MM-DD'));

-- Insert data into Payment table
INSERT INTO Payment (payment_id, reservation_id, amount_paid, payment_date)
VALUES (1, 1, 500.00, TO_DATE('2024-03-18', 'YYYY-MM-DD'));

INSERT INTO Payment (payment_id, reservation_id, amount_paid, payment_date)
VALUES (2, 2, 750.00, TO_DATE('2024-04-13', 'YYYY-MM-DD'));

INSERT INTO Payment (payment_id, reservation_id, amount_paid, payment_date)
VALUES (3, 3, 1000.00, TO_DATE('2024-05-23', 'YYYY-MM-DD'));

INSERT INTO Payment (payment_id, reservation_id, amount_paid, payment_date)
VALUES (4, 4, 900.00, TO_DATE('2024-06-08', 'YYYY-MM-DD'));

INSERT INTO Payment (payment_id, reservation_id, amount_paid, payment_date)
VALUES (5, 5, 1250.00, TO_DATE('2024-07-18', 'YYYY-MM-DD'));


SELECT * FROM Room WHERE rate_per_night > 150;

SELECT hotel_id, COUNT(*) AS num_reservations
FROM Room
JOIN Reservation ON Room.room_id = Reservation.room_id
GROUP BY hotel_id;

SELECT * FROM Guest ORDER BY name;

SELECT * FROM Guest WHERE email LIKE '%example.com%';

SELECT COUNT(*) FROM Reservation WHERE guest_id = 1;

SELECT * FROM Guest WHERE LENGTH(name) > 10;

SELECT INITCAP(name) FROM Guest;

SELECT MAX(rate_per_night) FROM Room;

SELECT MIN(capacity) FROM Room;

SELECT * FROM Room WHERE rate_per_night < 200 AND capacity > 2;

SELECT * FROM Room WHERE rate_per_night < 100 OR capacity > 3;


SELECT Reservation.reservation_id, Guest.name
FROM Reservation
JOIN Guest ON Reservation.guest_id = Guest.guest_id;

SELECT * FROM Reservation WHERE check_in_date > TO_DATE('2024-05-01', 'YYYY-MM-DD') ORDER BY check_in_date;

SELECT Room.hotel_id, COUNT(*) AS num_reservations 
FROM Reservation 
JOIN Room ON Reservation.room_id = Room.room_id 
GROUP BY Room.hotel_id 
HAVING COUNT(*) > 2 
ORDER BY num_reservations DESC;


SELECT type, COUNT(*) AS num_reservations 
FROM Room 
JOIN Reservation ON Room.room_id = Reservation.room_id 
GROUP BY type 
ORDER BY num_reservations DESC;

SELECT * FROM Guest WHERE name LIKE 'J%' ORDER BY name;
SELECT INITCAP(name) 
FROM Hotel 
WHERE country = 'USA' 
ORDER BY name;

SELECT hotel_id, MAX(rate_per_night) AS max_rate 
FROM Room 
GROUP BY hotel_id;

SELECT Room.hotel_id, MIN(rate_per_night) AS min_rate 
FROM Room 
JOIN Hotel ON Room.hotel_id = Hotel.hotel_id 
WHERE city = 'New York' 
GROUP BY Room.hotel_id 
ORDER BY min_rate;


SELECT * FROM Reservation WHERE guest_id = 1;

SELECT * FROM Room WHERE rate_per_night < 150.00;



DECLARE
    v_guest_id Guest.guest_id%TYPE;
    v_guest_name Guest.name%TYPE;
    v_guest_email Guest.email%TYPE;
    v_guest_phone Guest.phone%TYPE;
BEGIN
    -- Get guest ID from user input
    v_guest_id := &guest_id;

    -- Retrieve guest information based on guest ID
    SELECT name, email, phone INTO v_guest_name, v_guest_email, v_guest_phone
    FROM Guest
    WHERE guest_id = v_guest_id;

  
    DBMS_OUTPUT.PUT_LINE('Guest Name: ' || v_guest_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_guest_email);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || v_guest_phone);
END;
/

 DECLARE
    v_guest_name Guest.name%TYPE;
BEGIN
    -- Get guest name from user input
    v_guest_name := '&guest_name';

    -- Retrieve all reservations made by the specified guest
    FOR reservation_rec IN (
        SELECT *
        FROM Reservation
        WHERE guest_id = (SELECT guest_id FROM Guest WHERE name = v_guest_name)
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || reservation_rec.reservation_id);
        -- Output other reservation details as needed
    END LOOP;
END;
/
DECLARE
    v_guest_name Guest.name%TYPE;
    v_total_amount_paid NUMBER(10, 2);
BEGIN
    -- Get guest name from user input
    v_guest_name := '&guest_name';

    -- Retrieve the total amount paid by the specified guest
    SELECT SUM(amount_paid) INTO v_total_amount_paid
    FROM Payment
    WHERE reservation_id IN (
        SELECT reservation_id
        FROM Reservation
        WHERE guest_id = (SELECT guest_id FROM Guest WHERE name = v_guest_name)
    );

    -- Output the total amount paid by the guest
    DBMS_OUTPUT.PUT_LINE('Total amount paid by ' || v_guest_name || ': $' || v_total_amount_paid);
END;
/

DECLARE
    v_check_in_date DATE;
BEGIN
    -- Get check-in date from user input
    v_check_in_date := TO_DATE('&check_in_date', 'YYYY-MM-DD');

    -- Retrieve all reservations for the specified date
    FOR reservation_rec IN (
        SELECT *
        FROM Reservation
        WHERE check_in_date = v_check_in_date
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || reservation_rec.reservation_id);
        -- Output other reservation details as needed
    END LOOP;
END;
/

DECLARE
    v_num_guests INTEGER := &num_guests;
BEGIN
    IF v_num_guests > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Welcome to the hotel!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No guests arrived yet.');
    END IF;
END;
/
DECLARE
    v_room_type VARCHAR2(50) := '&room_type';
BEGIN
    CASE v_room_type
        WHEN 'Single' THEN
            DBMS_OUTPUT.PUT_LINE('You selected a single room.');
        WHEN 'Double' THEN
            DBMS_OUTPUT.PUT_LINE('You selected a double room.');
        WHEN 'Suite' THEN
            DBMS_OUTPUT.PUT_LINE('You selected a suite.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Room type not recognized.');
    END CASE;
END;
/
DECLARE
    v_max_rooms CONSTANT INTEGER := 5;
BEGIN
    FOR i IN 1..v_max_rooms LOOP
        DBMS_OUTPUT.PUT_LINE('Room ' || i || ': Available');
    END LOOP;
END;
/
DECLARE
    v_counter INTEGER := 1;
BEGIN
    WHILE v_counter <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE('Counter: ' || v_counter);
        v_counter := v_counter + 1;
    END LOOP;
END;
/
CREATE OR REPLACE PROCEDURE CalculateTotalAmountPaid(
    p_guest_id IN Reservation.guest_id%TYPE,
    p_total_amount OUT NUMBER
)
IS
BEGIN
    SELECT SUM(amount_paid) INTO p_total_amount
    FROM Payment
    WHERE reservation_id IN (
        SELECT reservation_id
        FROM Reservation
        WHERE guest_id = p_guest_id
    );
END;
/
CREATE OR REPLACE PROCEDURE GetGuestInfo(
    p_guest_id IN Guest.guest_id%TYPE,
    p_guest_name OUT Guest.name%TYPE,
    p_guest_email OUT Guest.email%TYPE
)
IS
BEGIN
    SELECT name, email INTO p_guest_name, p_guest_email
    FROM Guest
    WHERE guest_id = p_guest_id;
END;
/
CREATE OR REPLACE PROCEDURE UpdateGuestPhone(
    p_guest_id IN Guest.guest_id%TYPE,
    p_new_phone_number IN Guest.phone%TYPE
)
IS
BEGIN
    UPDATE Guest
    SET phone = p_new_phone_number
    WHERE guest_id = p_guest_id;
END;
/
CREATE OR REPLACE FUNCTION NewCalculateTotalAmountPaid(
    p_guest_id IN Reservation.guest_id%TYPE
) RETURN NUMBER
IS
    v_total_amount NUMBER;
BEGIN
    SELECT SUM(amount_paid) INTO v_total_amount
    FROM Payment
    WHERE reservation_id IN (
        SELECT reservation_id
        FROM Reservation
        WHERE guest_id = p_guest_id
    );

    RETURN v_total_amount;
END;
/

CREATE OR REPLACE FUNCTION RoomExists(
    p_room_number IN Room.room_number%TYPE
) RETURN BOOLEAN
IS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Room
    WHERE room_number = p_room_number;
    
    IF v_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

CREATE OR REPLACE FUNCTION GetGuestName(
    p_guest_id IN Guest.guest_id%TYPE
) RETURN VARCHAR2
IS
    v_guest_name Guest.name%TYPE;
BEGIN
    SELECT name INTO v_guest_name
    FROM Guest
    WHERE guest_id = p_guest_id;
    
    RETURN v_guest_name;
END;
/

CREATE OR REPLACE VIEW ReservationDetails AS
SELECT r.reservation_id, r.guest_id, g.name AS guest_name, g.email AS guest_email, r.room_id, r.check_in_date, r.check_out_date
FROM Reservation r
JOIN Guest g ON r.guest_id = g.guest_id;

CREATE OR REPLACE VIEW AvailableRooms AS
SELECT r.room_id, r.room_number, r.type, r.rate_per_night
FROM Room r
LEFT JOIN Reservation res ON r.room_id = res.room_id
WHERE res.reservation_id IS NULL;

CREATE OR REPLACE VIEW TotalAmountPaidByGuest AS
SELECT g.guest_id, g.name AS guest_name, SUM(p.amount_paid) AS total_amount_paid
FROM Guest g
JOIN Reservation r ON g.guest_id = r.guest_id
JOIN Payment p ON r.reservation_id = p.reservation_id
GROUP BY g.guest_id, g.name;

CREATE MATERIALIZED VIEW mv_TotalAmountPaidByGuest
REFRESH COMPLETE ON COMMIT
AS
SELECT g.guest_id, g.name AS guest_name, SUM(p.amount_paid) AS total_amount_paid
FROM Guest g
JOIN Reservation r ON g.guest_id = r.guest_id
JOIN Payment p ON r.reservation_id = p.reservation_id
GROUP BY g.guest_id, g.name;

CREATE MATERIALIZED VIEW mv_ReservationsCountByGuest
REFRESH COMPLETE ON COMMIT
AS
SELECT guest_id, COUNT(*) AS reservations_count
FROM Reservation
GROUP BY guest_id;

CREATE MATERIALIZED VIEW mv_TotalRevenueByHotel
REFRESH COMPLETE ON COMMIT
AS
SELECT h.hotel_id, h.name AS hotel_name, SUM(p.amount_paid) AS total_revenue
FROM Hotel h
JOIN Room r ON h.hotel_id = r.hotel_id
JOIN Reservation res ON r.room_id = res.room_id
JOIN Payment p ON res.reservation_id = p.reservation_id
GROUP BY h.hotel_id, h.name;






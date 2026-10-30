CREATE DATABASE restaurant_db;
USE restaurant_db;
 
CREATE TABLE Restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100),
    phone VARCHAR(50)
);
 
CREATE TABLE RestaurantTable (
    table_id INT AUTO_INCREMENT PRIMARY KEY,
    table_number INT,
    seats INT,
    area VARCHAR(50),
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);
 
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_date DATE,
    booking_time TIME,
    party_size INT,
    status VARCHAR(20),
    notes VARCHAR(255),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
 
CREATE TABLE BookingTable (
    booking_id INT,
    table_id INT,
    PRIMARY KEY (booking_id, table_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (table_id) REFERENCES RestaurantTable(table_id)
);

INSERT INTO Restaurant (name, address, phone) VALUES
('Restaurant Hygge', 'Nyhavn 17, 1051 København K', '+4533123456');
 
INSERT INTO RestaurantTable (table_number, seats, area, restaurant_id) VALUES
(1, 2, 'Vindue', 1),
(2, 2, 'Vindue', 1),
(3, 4, 'Indendørs', 1),
(4, 4, 'Indendørs', 1),
(5, 4, 'Indendørs', 1),
(6, 6, 'Indendørs', 1),
(7, 6, 'Indendørs', 1),
(8, 2, 'Terrasse', 1),
(9, 4, 'Terrasse', 1),
(10, 8, 'Selskabslokale', 1);
 
INSERT INTO Customer (first_name, last_name, phone, email) VALUES
('Emma', 'Nielsen', '+4521345678', 'emma.nielsen@example.dk'),
('Lars', 'Jensen', '+4522456789', 'lars.jensen@example.dk'),
('Sofie', 'Hansen', '+4523567890', 'sofie.hansen@example.dk'),
('Mikkel', 'Pedersen', '+4524678901', 'mikkel.pedersen@example.dk'),
('Freja', 'Andersen', '+4525789012', 'freja.andersen@example.dk'),
('Oliver', 'Christensen', '+4526890123', 'oliver.christensen@example.dk'),
('Ida', 'Larsen', '+4527901234', 'ida.larsen@example.dk'),
('Magnus', 'Sørensen', '+4528012345', 'magnus.sorensen@example.dk'),
('Emilie', 'Rasmussen', '+4529123456', 'emilie.rasmussen@example.dk'),
('Mads', 'Jørgensen', '+4530234567', 'mads.jorgensen@example.dk');
 
INSERT INTO Booking (booking_date, booking_time, party_size, status, notes, customer_id) VALUES
('2026-11-06', '18:00', 2, 'confirmed', 'Bryllupsdag', 1),
('2026-11-06', '18:30', 4, 'confirmed', NULL, 2),
('2026-11-06', '19:00', 3, 'confirmed', 'En vegetar', 3),
('2026-11-06', '20:30', 2, 'confirmed', NULL, 4),
('2026-11-13', '19:00', 4, 'confirmed', 'Fødselsdag', 1),
('2026-11-07', '18:00', 6, 'confirmed', 'Børnestol', 5),
('2026-11-07', '19:30', 2, 'cancelled', NULL, 6),
('2026-11-07', '20:00', 8, 'confirmed', 'Firmamiddag', 7),
('2026-11-08', '12:30', 4, 'confirmed', 'Nøddeallergi', 8),
('2026-11-08', '18:00', 2, 'confirmed', NULL, 9),
('2026-10-02', '19:00', 2, 'completed', NULL, 1),
('2026-11-06', '21:00', 4, 'confirmed', NULL, 10),
('2026-11-14', '18:30', 5, 'confirmed', NULL, 3),
('2026-11-14', '19:00', 6, 'confirmed', NULL, 2);
 
INSERT INTO BookingTable (booking_id, table_id) VALUES
(1, 1), (2, 3), (3, 4), (4, 2), (5, 3), (6, 6), (7, 8),
(8, 10), (9, 5), (10, 1), (11, 2), (12, 3), (13, 4), (13, 8), (14, 7);

SELECT table_id, table_number, seats, area
FROM RestaurantTable
WHERE restaurant_id = 1
ORDER BY table_number;

SELECT booking_id, booking_date, booking_time, party_size
FROM Booking
WHERE customer_id = 1
ORDER BY booking_date, booking_time;

SELECT table_id, booking_date, booking_time, first_name, last_name
FROM BookingTable
JOIN Booking ON BookingTable.booking_id = Booking.booking_id
JOIN Customer ON Booking.customer_id = Customer.customer_id
WHERE table_id = 3 AND booking_date = '2026-11-06'
ORDER BY booking_time;
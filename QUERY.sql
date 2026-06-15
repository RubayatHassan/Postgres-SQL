-- Football Ticket Booking System
-- PostgreSQL schema, sample data, and assignment queries

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)
);

CREATE TABLE matches (
    match_id INTEGER PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(80) NOT NULL,
    base_ticket_price NUMERIC(10, 2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(30) NOT NULL CHECK (
        match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed')
    )
);

CREATE TABLE bookings (
    booking_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    match_id INTEGER NOT NULL,
    seat_number VARCHAR(20),
    payment_status VARCHAR(30) CHECK (
        payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
    ),
    total_cost NUMERIC(10, 2) NOT NULL CHECK (total_cost >= 0),
    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_match
        FOREIGN KEY (match_id)
        REFERENCES matches (match_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

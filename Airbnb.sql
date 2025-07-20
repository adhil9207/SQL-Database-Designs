create database Airbnb;
use Airbnb;


CREATE TABLE airbnb_hosts (
    host_id INT PRIMARY KEY,
    host_name VARCHAR(250),
    host_since DATE,
    host_location VARCHAR(250),
    host_response_time VARCHAR(250),
    host_response_rate INT,
    host_acceptance_rate INT,
    host_is_superhost BOOLEAN,
    host_neighbourhood VARCHAR(250),
    host_listings_count INT,
    host_has_profile_pic BOOLEAN,
    host_identity_verified BOOLEAN
);

CREATE TABLE listings (
    id INT PRIMARY KEY,
    listing_name VARCHAR(200),
    street VARCHAR(300),
    neighbourhood_cleansed VARCHAR(250),
    neighbourhood_group_cleansed VARCHAR(250),
    city VARCHAR(250),
    state VARCHAR(250),
    zipcode VARCHAR(250),
    latitude FLOAT,
    longitude FLOAT,
    is_location_exact BOOLEAN,
    property_type VARCHAR(250),
    room_type VARCHAR(250),
    accommodates INT,
    bathrooms INT,
    bedrooms INT,
    beds INT,
    bed_type VARCHAR(250),
    square_feet INT,
    price FLOAT,
    weekly_price FLOAT,
    monthly_price FLOAT,
    security_deposit FLOAT,
    cleaning_fee FLOAT,
    guests_included INT,
    extra_people FLOAT,
    minimum_nights INT,
    maximum_nights INT,
    has_availability BOOLEAN,
    availability_30 INT,
    availability_60 INT,
    availability_90 INT,
    availability_365 INT,
    calendar_updated DATE,
    number_of_reviews INT,
    first_review DATE,
    last_review DATE,
    review_scores_rating INT,
    review_scores_accuracy INT,
    review_scores_cleanliness INT,
    review_scores_checkin INT,
    review_scores_communication INT,
    review_scores_location INT,
    review_scores_value INT,
    requires_license BOOLEAN,
    instant_bookable BOOLEAN,
    cancellation_policy VARCHAR(200),
    require_guest_profile_picture BOOLEAN,
    require_guest_phone_verification BOOLEAN,
    reviews_per_month FLOAT,
    host_id INT,
    FOREIGN KEY (host_id) REFERENCES airbnb_hosts(host_id) ON DELETE CASCADE
);

CREATE TABLE property_availability (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    listing_id INT,
    available_date DATE,
    available BOOLEAN,
    price FLOAT,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);

CREATE TABLE property_reviews (
    review_id INT PRIMARY KEY,
    listing_id INT,
    review_date DATE,
    reviewer_id INT,
    reviewer_name VARCHAR(100),
    comments MEDIUMTEXT,
    FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);


INSERT INTO airbnb_hosts (
    host_id, host_name, host_since, host_location, host_response_time,
    host_response_rate, host_acceptance_rate, host_is_superhost, host_neighbourhood,
    host_listings_count, host_has_profile_pic, host_identity_verified
)
VALUES 
(1, 'Alice Smith', '2018-06-12', 'New York, NY', 'within an hour', 95, 98, TRUE, 'Manhattan', 3, TRUE, TRUE),
(2, 'Bob Johnson', '2019-03-24', 'San Francisco, CA', 'within a few hours', 90, 93, FALSE, 'Mission', 1, TRUE, TRUE);



INSERT INTO listings (
    id, listing_name, street, neighbourhood_cleansed, neighbourhood_group_cleansed,
    city, state, zipcode, latitude, longitude, is_location_exact,
    property_type, room_type, accommodates, bathrooms, bedrooms, beds,
    bed_type, square_feet, price, weekly_price, monthly_price, security_deposit,
    cleaning_fee, guests_included, extra_people, minimum_nights, maximum_nights,
    has_availability, availability_30, availability_60, availability_90, availability_365,
    calendar_updated, number_of_reviews, first_review, last_review,
    review_scores_rating, review_scores_accuracy, review_scores_cleanliness,
    review_scores_checkin, review_scores_communication, review_scores_location,
    review_scores_value, requires_license, instant_bookable, cancellation_policy,
    require_guest_profile_picture, require_guest_phone_verification, reviews_per_month,
    host_id
)
VALUES 
(101, 'Modern Apartment Downtown', '123 Main St', 'Downtown', 'Manhattan', 'New York', 'NY', '10001', 40.7128, -74.0060, TRUE,
'Apartment', 'Entire home/apt', 2, 1, 1, 1, 'Real Bed', 600, 150.00, 950.00, 3600.00, 200.00, 50.00, 1, 25.00, 2, 30,
TRUE, 25, 50, 70, 300, '2025-05-01', 120, '2020-06-15', '2025-04-20', 95, 9, 9, 10, 9, 9, 9, TRUE, TRUE, 'moderate', TRUE, TRUE, 3.5, 1),

(102, 'Cozy Studio in Mission', '456 Mission St', 'Mission', 'San Francisco', 'San Francisco', 'CA', '94110', 37.7599, -122.4148, TRUE,
'Studio', 'Private room', 1, 1, 1, 1, 'Futon', 300, 90.00, 600.00, 2200.00, 100.00, 30.00, 1, 15.00, 2, 90,
TRUE, 20, 40, 60, 240, '2025-05-01', 75, '2021-01-05', '2025-03-22', 90, 8, 9, 9, 8, 8, 8, FALSE, FALSE, 'flexible', FALSE, TRUE, 2.7, 2);

INSERT INTO property_availability (
    listing_id, available_date, available, price
)
VALUES 
(101, '2025-06-01', TRUE, 150.00),
(101, '2025-06-02', TRUE, 150.00),
(102, '2025-06-01', TRUE, 90.00),
(102, '2025-06-02', FALSE, 0.00);


INSERT INTO property_reviews (
    review_id, listing_id, review_date, reviewer_id, reviewer_name, comments
)
VALUES 
(1001, 101, '2025-04-20', 201, 'John Doe', 'Great place, very clean and centrally located.'),
(1002, 102, '2025-03-22', 202, 'Jane Smith', 'The studio was cozy and in a nice neighborhood.');


SELECT AVG(price) AS average_price
FROM listings
WHERE bedrooms = 8;

SELECT 
    h.host_id, h.host_name, h.host_location,
    l.listing_name, l.street, l.state
FROM airbnb_hosts h
JOIN listings l ON h.host_id = l.host_id;

SELECT beds, bedrooms, bed_type
FROM listings;


SELECT 
    pa.price, pa.available_date,
    pr.review_date, pr.reviewer_id
FROM property_availability pa
LEFT JOIN property_reviews pr ON pa.listing_id = pr.listing_id;


SELECT review_id, listing_id, reviewer_id
FROM property_reviews;

SELECT 
    review_scores_rating,
    review_scores_accuracy,
    review_scores_cleanliness,
    review_scores_checkin,
    review_scores_communication,
    review_scores_location
FROM listings;


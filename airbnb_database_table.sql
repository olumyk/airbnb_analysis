
SHOW DATABASES;

DROP DATABASE IF EXISTS airbnb;

-- Create a database
CREATE DATABASE airbnb;

USE airbnb;

-- Create and load calendar table
DROP TABLE IF EXISTS airbnb.calendar;

create table airbnb.calendar (
    listing_id            bigint,
    dt                    char(10),
    available             char(1),
    price                  varchar(20)
);

truncate airbnb.calendar; -- clean up if there are any existing data

SET GLOBAL LOCAL_INFILE = 1;

-- load data into the calendar table
load data local infile 'C:\\Users\\myk70\\Desktop\\STUDY\\DataScience\\SQL\\airbnb\\calendar.csv'
into table airbnb.calendar
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- test calendar table
SELECT * FROM airbnb.calendar LIMIT 5;
SELECT * FROM airbnb.calendar WHERE listing_id = 14204600 AND dt = '2017-08-20';

-- Create listings table
drop table if exists airbnb.listings;
create table airbnb.listings (
    id bigint,
    listing_url text,
    scrape_id bigint,
    last_scraped char(10),
    name text,
    summary text,
    space text,
    description text,
    experiences_offered text,
    neighborhood_overview text,
    notes text,
    transit text,
    access text,
    interaction text,
    house_rules text,
    thumbnail_url text,
    medium_url text,
    picture_url text,
    xl_picture_url text,
    host_id bigint,
    host_url text,
    host_name varchar(100),
    host_since char(10),
    host_location text,
    host_about text,
    host_response_time text,
    host_response_rate text,
    host_acceptance_rate text,
    host_is_superhost char(1),
    host_thumbnail_url text,
    host_picture_url text,
    host_neighbourhood text,
    host_listings_count int,
    host_total_listings_count int,
    host_verifications text,
    host_has_profile_pic char(1),
    host_identity_verified char(1),
    street text,
    neighbourhood text,
    neighbourhood_cleansed text,
    neighbourhood_group_cleansed text,
    city text,
    state text,
    zipcode text,
    market text,
    smart_location text,
    country_code text,
    country text,
    latitude text,
    longitude text,
    is_location_exact text,
    property_type text,
    room_type text,
    accommodates int,
    bathrooms text,
    bedrooms text,
    beds text,
    bed_type text,
    amenities text,
    square_feet text,
    price text,
    weekly_price text,
    monthly_price text,
    security_deposit text,
    cleaning_fee text,
    guests_included int,
    extra_people text,
    minimum_nights int,
    maximum_nights int,
    calendar_updated text,
    has_availability varchar(10),
    availability_30 int,
    availability_60 int,
    availability_90 int,
    availability_365 int,
    calendar_last_scraped varchar(10),
    number_of_reviews int,
    first_review varchar(10),
    last_review varchar(10),
    review_scores_rating text,
    review_scores_accuracy text,
    review_scores_cleanliness text,
    review_scores_checkin text,
    review_scores_communication text,
    review_scores_location text,
    review_scores_value text,
    requires_license char(1),
    license text,
    jurisdiction_names text,
    instant_bookable char(1),
    cancellation_policy varchar(20),
    require_guest_profile_picture char(1),
    require_guest_phone_verification char(1),
    calculated_host_listings_count int,
    reviews_per_month text
);

truncate airbnb.listings; -- clean up if there are any existing data

-- load data into the listings table
load data local infile 'C:\\Users\\myk70\\Desktop\\STUDY\\DataScience\\SQL\\airbnb\\listings.csv'
into table airbnb.listings
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Check
SELECT * FROM listings LIMIT 5;


-- Create and load reviews table
drop table if exists airbnb.reviews;
create table airbnb.reviews (
    listing_id bigint,
    id bigint,
    date varchar(10),
    reviewer_id bigint,
    reviewer_name text,
    comments text
);

-- load data into the reviews table
load data local infile 'C:\\Users\\myk70\\Desktop\\STUDY\\DataScience\\SQL\\airbnb\\reviews.csv'
into table airbnb.reviews
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

SELECT * FROM reviews LIMIT 5;

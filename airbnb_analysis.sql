#                                 SQL Assignment - Airbnb

        ########################################################################
        #   Weighting 2.5%, 15 points in total                                 #
        #   Structure:                                                         #
        # - 7 Questions                                                        #
        # -------------------------------------------------------------------- #
        #   Please keep the following in mind:                                 #
        # - Is the code organized such that it is easy to read/understandable? #
        # - Is documentation (where needed) included?                          #
        # - Code quality/efficiency/logic                                      #
        # - One query per question                                             #
        ########################################################################

#                                     Introduction
# -Analysis: Exploring Airbnb guest data to get interesting insights and to answer business questions.
# -Data: Dataset download link: https://weclouddata.s3.amazonaws.com/datasets/hotel/airbnb/airbnb.zip
# -Tools: MySQL (table structure as shown in the tutorial below)
########################################################################################################################
SHOW DATABASES;
USE airbnb;
SHOW TABLES;
#                                     Questions
# 1: How many unique listings are provided in the calendar table?
DESCRIBE calendar;
SELECT * FROM calendar LIMIT 5;

-- solution
SELECT
    COUNT(DISTINCT listing_id) listing_id
FROM
    calendar;


# 2: How many calendar years do the calendar table span?
# (Expected output: e.g., this table has data from 2009 to 2010)
SELECT COUNT(dt) FROM calendar WHERE dt is null;

-- solution 1
SELECT
    CONCAT(
            'this table has data from ',
            MIN(YEAR(dt)), ' to ',
            MAX(YEAR(dt))
    ) AS calendarYear,
    MAX(YEAR(dt)) - MIN(YEAR(dt)) + 1 AS calendarYearSpan
FROM
    calendar;

-- solution 2
SELECT
    CONCAT(
        'This table has data from ',
        EXTRACT(YEAR FROM MIN(dt)),
        ' to ',
        EXTRACT(YEAR FROM MAX(dt))
    ) AS calendarYear
FROM calendar;


# 3: Find listings that are completely available for the entire year (available for 365 days)
SELECT * FROM calendar LIMIT 5;
SELECT COUNT(DISTINCT listing_id) FROM calendar;
SELECT DISTINCT available FROM calendar;

-- solution
SELECT
    listing_id,
    available,
    COUNT(available) AS available365
FROM
    calendar
WHERE available = 't'
GROUP BY listing_id
HAVING COUNT(DISTINCT DATE(dt)) = 365;

    
# 4: How many listings have been completely booked for the year (0 days available)?
SHOW tables;
SELECT * FROM calendar LIMIT 5;
SELECT * FROM listings LIMIT 5;
SELECT * FROM reviews LIMIT 5;
SELECT listing_id, available FROM calendar WHERE available = 'f';

-- solution
SELECT
    listing_id,
    available,
    COUNT(available) AS zeroAvailable
FROM
    calendar
WHERE available = 'f'
GROUP BY listing_id
HAVING COUNT(DISTINCT DATE(dt)) = 365;


# 5: Which city has the most listings?
DESCRIBE listings;
SELECT * FROM listings LIMIT 5;

-- solution
SELECT
    city,
    COUNT(id) AS countID
FROM
    listings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


# 6: Which street/st/ave has the most number of listings in Boston?
# (Note:  `beacon street` and `beacon st` should be considered the same street)
SELECT * FROM listings LIMIT 5;

-- solution 1
SELECT
    street,
    COUNT(id) AS countID
FROM
    listings
WHERE city = 'Boston'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- solution 2
SELECT
    street,
    COUNT(*) AS countListings
FROM (
  SELECT REPLACE(REPLACE(street, 'beacon st', 'beacon street'), 'beacon street', 'beacon st') AS street
  FROM listings
  WHERE city = 'Boston'
  ) AS boston_listings
GROUP BY street
ORDER BY 2 DESC
LIMIT 1;


# 7: In the calendar table, how many listings charge different prices for weekends and weekdays?
# Hint: use average weekend price vs average weekday price

-- solution
SELECT listing_id
FROM (
    SELECT
        listing_id,
        AVG(CASE WHEN DAYOFWEEK(dt) IN (1, 7) THEN price END) AS avgWeekendPrice,
        AVG(CASE WHEN DAYOFWEEK(dt) BETWEEN 2 AND 6 THEN price END) AS avgWeekdayPrice
    FROM calendar
    GROUP BY 1
    ) AS avgPrices
WHERE avgWeekendPrice != avgWeekdayPrice;





########################################################################################################################
# Tutorial - Create Tables
# Create and load calendar table
drop table if exists airbnb.calendar;

create table airbnb.calendar (
    listing_id            bigint,
    dt                    char(10),
    available             char(1),
    price                  varchar(20)
);

truncate airbnb.calendar;

-- load data into the calendar table
load data local infile '/Your/own/path'
into table airbnb.calendar
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

# test calendar table
select * from airbnb.calendar limit 5;
select * from airbnb.calendar where listing_id=14204600 and dt='2017-08-20';

# Create listings table
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
# Create and load reviews table
drop table if exists airbnb.reviews;
create table airbnb.reviews (
    listing_id bigint,
    id bigint,
    date varchar(10),
    reviewer_id bigint,
    reviewer_name text,
    comments text
);
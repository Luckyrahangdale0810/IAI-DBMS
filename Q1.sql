create database retail_db;
use retail_db;

create table customers(
 customer_id VARCHAR(50) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(30),
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    registration_date DATE,
    preferred_channel VARCHAR(30)

);
select * from customers;
CREATE TABLE transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    product_name VARCHAR(150),
    product_category VARCHAR(80),
    quantity INT,
    price DECIMAL(10,2),
    transaction_date DATE,
    store_location VARCHAR(100),
    payment_method VARCHAR(50),
    discount_applied DECIMAL(5,2),

    CONSTRAINT fk_customer_transaction
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

select* from transactions;


CREATE TABLE interactions (
    interaction_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    channel VARCHAR(50),
    interaction_type VARCHAR(50),
    interaction_date DATETIME,
    duration DECIMAL(8,2),
    page_or_product VARCHAR(150),
    session_id VARCHAR(100),
    CONSTRAINT fk_customer_interaction
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

select * from interactions;

CREATE TABLE campaigns (
    campaign_id VARCHAR(50) PRIMARY KEY,
    campaign_name VARCHAR(150),
    campaign_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    target_segment VARCHAR(100),
    budget DECIMAL(12,2),
    impressions INT,
    clicks INT,
    conversions INT,
    conversion_rate DECIMAL(5,4),
    roi DECIMAL(8,2)
);

select * from campaigns;

CREATE TABLE customer_reviews_complete (
    review_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    product_name VARCHAR(150),
    product_category VARCHAR(80),
    full_name VARCHAR(100),
    transaction_date DATE,
    review_date DATE,
    rating INT,
    review_title VARCHAR(255),
    review_text TEXT,
    CONSTRAINT fk_customer_review
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
select * from customer_reviews_complete;

CREATE TABLE support_tickets (
    ticket_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    issue_category VARCHAR(80),
    priority VARCHAR(20),
    submission_date DATETIME,
    resolution_date DATETIME,
    resolution_status VARCHAR(30),
    resolution_time_hours DECIMAL(8,2),
    customer_satisfaction_score DECIMAL(3,2),
    notes TEXT,
    CONSTRAINT fk_customer_ticket
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

select * from support_tickets;

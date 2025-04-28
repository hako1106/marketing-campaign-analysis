--DROP DATABASE IF EXISTS marketing_campaign;

--CREATE DATABASE marketing_campaign;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')) NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 100) NOT NULL,
    signup_date DATE NOT NULL,
    income NUMERIC(10,2) CHECK (income > 0) NOT NULL
);


CREATE TABLE campaigns (
    campaign_id SERIAL PRIMARY KEY,
    campaign_name TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description TEXT
);

CREATE TABLE customer_campaigns (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    campaign_id INTEGER NOT NULL REFERENCES campaigns(campaign_id) ON DELETE CASCADE,
    assigned_date DATE NOT NULL
);


CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    transaction_date DATE NOT NULL,
    amount NUMERIC(10,2) CHECK (amount > 0) NOT NULL,
    campaign_id INTEGER REFERENCES campaigns(campaign_id) ON DELETE SET NULL
);

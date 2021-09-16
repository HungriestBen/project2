CREATE DATABASE custom_cards;

-- Table for cards

CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    title TEXT,
    attack INTEGER,
    health INTEGER,
    rarity TEXT,
    text_description TEXT,
    cost INTEGER,
    image_url TEXT,
    user_id INTEGER
);

-- Table for users

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT,
    email TEXT,
    password_digest TEXT
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    time TIMESTAMP,
    comment TEXT,
    user_id INTEGER,
    card_id TEXT
);
CREATE DATABASE custom_cards;

CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    title TEXT,
    attack INTEGER,
    health INTEGER,
    rarity TEXT,
    text_description TEXT,
    cost INTEGER,
    image_url TEXT
);


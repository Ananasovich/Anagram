-- +migrate Up

CREATE TABLE IF NOT EXISTS words
(
    id      SERIAL PRIMARY KEY,
    word    varchar(256) NOT NULL UNIQUE,
    letters varchar(256) NOT NULL
);

CREATE INDEX letters ON words (letters);

-- +migrate Down

DROP TABLE IF EXISTS words;
-- Database: books_database
-- 	don't forget to change the file path for the data import when executing these instructions
CREATE TABLE raw_books (
    book_id varchar,
	title varchar,
	author varchar,
	avg_rating numeric,
	isbn varchar,
	isbn13 varchar,
	lang varchar,
	pages numeric,
	ratings_count numeric,
	text_reviews numeric,
	publication_date date,
	publisher varchar
);

COPY raw_books
  FROM '/private/tmp/books-3.csv'
  WITH (FORMAT CSV, HEADER, DELIMITER ',');
  
CREATE TABLE books (
	isbn varchar,
	title varchar,
	author varchar,
	lang varchar,
	pages numeric,
	publication_date date,
	publisher varchar,
	PRIMARY KEY(isbn)
);

CREATE TABLE ratings (
	isbn varchar,
	avg_rating numeric,
	ratings_count numeric,
	text_reviews numeric,
	PRIMARY KEY(isbn),
   	CONSTRAINT for_key
      FOREIGN KEY(isbn) 
	  REFERENCES books(isbn)
);

INSERT INTO books (isbn, title, author, lang, pages, publication_date, publisher)
SELECT isbn, title, author, lang, pages, publication_date, publisher
FROM raw_books;

INSERT INTO ratings (isbn, avg_rating, ratings_count, text_reviews)
SELECT isbn, avg_rating, ratings_count, text_reviews
FROM raw_books;
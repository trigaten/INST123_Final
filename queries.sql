-- What was the most reviewed book in the last 5 years?
select books.title, text_reviews from ratings
JOIN books ON books.isbn = ratings.isbn
WHERE books.publication_date > '2015-05-03'
ORDER BY ratings.text_reviews DESC
LIMIT 1
-- Who is the publisher with the most reviewed books (quantity of text reviews) published in the last 10 years?
SELECT books.publisher, sum(text_reviews) as text_reviews FROM ratings
JOIN books ON books.isbn = ratings.isbn
WHERE books.publication_date > '2010-05-03'
GROUP BY books.publisher
ORDER BY text_reviews DESC
LIMIT 1
-- Which are better rated: novellas (<= 200 pages) or other books?
-- Reference: https://bookriot.com/how-long-is-a-short-story/
-- We can see that the first entry, which represents the average rating of novellas if slightly
-- higher than the average rating of non-novellas
SELECT sum(avg_rating)/count(avg_rating)::float as ratings FROM ratings
JOIN books ON books.isbn = ratings.isbn
GROUP BY books.pages <= 200
-- How many books written by J.K. Rowling are in the database?
SELECT COUNT(*) FROM books
WHERE author like '%J.K. Rowling%'

-- Which books have more than average lifetime revenue?
SELECT books.title, lifetime_sales.revenue
FROM books
JOIN lifetime_sales 
ON lifetime_sales.isbn = books.isbn
WHERE lifetime_sales.revenue > (
		SELECT AVG (revenue)
		FROM lifetime_sales
		);


-- What is the best reviewed book on record? We can see that there are multiple.
SELECT books.title, ratings.avg_rating FROM ratings
JOIN books ON books.isbn = ratings.isbn
ORDER BY ratings.avg_rating DESC


-- How many books are written in English without regional specification?
SELECT count(books.title) from books
WHERE books.lang like '%eng%'
-- How many books are written in English including regional specifications?
SELECT count(books.title) from books
WHERE books.lang like '%en%'
-- What is the average number of pages of books in the database?
SELECT avg(books.pages) FROM books
-- What is the average number of pages of highly rated (4.0+) books in the database?
SELECT avg(books.pages) FROM books 
JOIN ratings ON books.isbn = ratings.isbn
WHERE avg_rating >= 4

-- Which author has the best rated books?
-- We can see that there are a few.
SELECT books.author, avg(ratings.avg_rating):: NUMERIC(3, 2) FROM ratings 
JOIN books ON books.isbn = ratings.isbn
GROUP BY books.author
ORDER BY avg(ratings.avg_rating) DESC
-- What is the average page length of Harry Potter books in the database
SELECT avg(pages):: NUMERIC(5, 2) FROM books
WHERE title LIKE '%Harry Potter%'

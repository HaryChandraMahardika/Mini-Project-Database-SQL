-- PILIH DATABASE
USE distreaming;

-- BUAT TABLE USERS
CREATE TABLE users (
	user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name_user VARCHAR(50) NOT NULL,
    join_date DATE,
    email VARCHAR(50) NOT NULL
);

-- BUAT TABLE MOVIES
CREATE TABLE movies (
	movie_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    movie_name VARCHAR(50) NOT NULL,
    release_year INT NOT NULL,
    rating FLOAT NOT NULL
);

-- BUAT TABLE MOVIE_CATEGORY
CREATE TABLE movie_category (
	movie_category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    movie_id INT NOT NULL,
    category_id INT NOT NULL
);

-- BUAT TABLE Categories
CREATE TABLE category (
	category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(50) NOT NULL
);

-- BUAT TABLE WATCHLIST
CREATE TABLE watchlist (
	watchlist_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    added_date DATETIME NOT NULL,
    status ENUM('Already watched', 'Currently watching', 'Haven’t watched')
);

-- INSERT TABLE USERS
INSERT INTO users (name_user, join_date, email) values 
('Andi', '2025-10-25', 'andi@mail.com'),
('Budi', '2025-09-25', 'budi@mail.com'),
('Citra', '2025-02-21', 'citra@mail.com'),
('Dewi', '2025-01-22', 'dewi@mail.com'),
('Eko', '2025-10-23', 'andi@mail.com'),
('Fani', '2025-05-10', 'eko@mail.com'),
('Gilang', '2025-08-25', 'gilang@mail.com'),
('Husna', '2025-07-25', 'husna@mail.com'),
('Ida', '2025-05-10', 'ilyas@mail.com'),
('Joko', '2025-03-22', 'joko@mail.com'),
('Krisna', '2025-06-22', 'krisna@mail.com'),
('Luna', '2025-04-22', 'luna@mail.com'),
('Mahmud', '2025-03-01', 'mahmud@mail.com'),
('Niko', '2025-06-20', 'niko@mail.com'),
('Ollie', '2025-05-30', 'ollie@mail.com');

-- INSERT TABLE category
INSERT INTO category (category_name) VALUES 
('Action'), 
('Drama'), 
('Horror'),
('Romance'), 
('Comedy'), 
('Thriller'), 
('Science Fiction'),
('Mystery'), 
('Crime'), 
('Animation'), 
('Adventure'),
('Psychological');

-- INSERT TABLE MOVIES
INSERT INTO movies (movie_name, release_year, rating) VALUES
('Nosferatu', 2024, 7.1),
('Avengers End Game', 2019, 8.4),
('Titanic', 1997, 7.9),
('Crazy, Stupid, Love', 2011, 7.4),
('The Fall Guy', 2024, 6.8),
('Spirited Away', 2001, 8.6),
('Seven', 1995, 8.6),
('The Hunger Games', 2012, 7.2),
('Parasite', 2019, 8.5),
('Free Guy', 2021, 7.1),
('Ready Player One', 2018, 7.4),
('Uncharted', 2022, 6.3),
('The Shawshank Redemption', 1994, 9.3),
('Fight Club', 1999, 8.8),
('The Silence of the Lambs', 1991, 8.6);

-- INSERT TABLE movie_category
INSERT INTO movie_category (movie_id, category_id) VALUES
(1, 3),
(2, 1),
(3, 4),
(4, 4),
(5, 5),
(6, 10),
(7, 7),
(8, 7),
(9, 6),
(10, 5),
(11, 7),
(12, 11),
(13, 3),
(14, 12),
(15, 3);

-- INSERT TABLE WATCHLIST
INSERT INTO watchlist (user_id, movie_id, added_date, status) VALUES
(1, 2, '2025-11-10', 'Already watched'),
(2, 14, '2025-11-12', 'Already watched'),
(3, 3, '2025-11-11', 'Already watched'),
(4, 6, '2025-11-20', 'Already watched'),
(5, 9, '2025-11-13', 'Currently watching'),
(6, 12, '2025-11-15', 'Haven’t watched'),
(7, 10, '2025-11-14', 'Already watched'),
(8, 13, '2025-11-12', 'Currently watching'),
(9, 11, '2025-11-16', 'Already watched'),
(10, 8, '2025-11-18', 'Already watched'),
(11, 4, '2025-11-01', 'Already watched'),
(12, 1, '2025-11-02', 'Currently watching'),
(13, 7, '2025-11-10', 'Haven’t watched'),
(14, 5, '2025-11-10', 'Already watched'),
(15, 15, '2025-11-26', 'Haven’t watched');

-- CEK & VIEW TABLE

-- VIEW TABLE USERS
DESC users;
SELECT * FROM users;

-- VIEW TABLE Movies
DESC movies;
SELECT * FROM movies;

-- VIEW TABLE Category
DESC category;
SELECT * FROM category;

-- VIEW TABLE Movie_Category
DESC movie_category;
SELECT * FROM movie_category;

-- VIEW TABLE WATCHLIST
DESC watchlist;
SELECT * FROM watchlist;

-- -------- 1. SQL Fundamentals -----------

-- 1.1 Tampilkan seluruh film dari tabel Movies
SELECT * FROM movies;

-- 1.2 Tampilkan film dengan rating di atas 8.0
SELECT * FROM movies WHERE rating > 8.0;

-- 1.3 Tampilkan 5 user pertama berdasarkan nama (A–Z)
SELECT * FROM users ORDER BY name_user LIMIT 5;

-- 1.4 Tampilkan film yang judulnya mengandung kata “Love”
SELECT * FROM movies WHERE movie_name LIKE '%Love%';

-- 1.5 Tampilkan film yang rilis pada tahun tertentu (2024)
SELECT * FROM movies WHERE release_year = 2024;

-- -----------------2. Aggregate & Conditional Logic ---------------

-- 2.1 Hitung total user yang terdaftar
SELECT COUNT(*) AS total_user FROM users;

-- 2.2 Hitung jumlah film per kategori (COUNT + GROUP BY category_id)
SELECT 
category.category_id,
category.category_name,
COUNT(movie_category.movie_id) AS total_film FROM category 
LEFT JOIN movie_category ON category.category_id = movie_category.category_id
GROUP BY category.category_id, category.category_name;

-- 2.3 Buat kategori film (kolom baru) berdasarkan rating menggunakan CASE WHEN
SELECT movie_name, rating,
CASE
	WHEN rating >= 8.5 THEN "Top Rated"
    WHEN rating > 7.0 THEN "Popular"
    ELSE "Reguler"
END AS grade
FROM movies;

-- ----------------------- 3. Join Statements ---------------
-- 3.1 Tampilkan daftar film lengkap (kategori film, rating(score), release year)
SELECT movies.movie_name,
movies.release_year,
movies.rating,
category.category_name
FROM movies
INNER JOIN movie_category ON movies.movie_id = movie_category.movie_id
INNER JOIN category
ON movie_category.category_id = category.category_id;

-- 3.2 Tampilkan kategori yang belum memiliki film
SELECT 
category.category_name
FROM category
LEFT JOIN movie_category
ON category.category_id = movie_category.category_id 
WHERE movie_category.movie_id IS NULL;

# Database diStreaming - MySQL

### 
Ini adalah proyek sederhana yang dirancang untuk mempraktikkan pembuatan ERD, DDL, DML, query SQL fundamental, Aggregate & Conditional Logic dan Join Statements. Proyek ini berisi data tentang pengguna, film, list tontonan, dan kategori film. 

## Table Database
### Proyek ini berisi 3 entitas utama yaitu :

### User : Menyimpan data pengguna
| Field        | Type        |
| -----------  |:-----------:|
| user_id (PK) | INT         |
| name_user    | VARCHAR(50) |
| join_date    | DATE        |
| email        | VARCHAR(50) |

### Movies : Menyimpan data list film
| Field         | Type        |
| -----------   |:-----------:|
| movie_id (PK) | INT         |
| movie_name    | VARCHAR(50) |
| release_year  | INT         |
| rating        | FLOAT       |

### Category : Menyimpan data kategori film
| Field            | Type        |
| -----------      |:-----------:|
| category_id (PK) | INT         |
| category_name    | VARCHAR(50) |


### 2 Relasi
### Movie Category : Relasi antara Movies dan Category
| Field                  | Type        |
| ---------------------  |:-----------:|
| movie_category_id (PK) | INT         |
| movie_id (FK)          | VARCHAR(50) |
| category_id (FK)       | DATE        |

### Watchlist : List tontonan sebagai relasi antara Users dan Movies
| Field             | Type        |
| ----------------- |:-----------:|
| watchlist_id (PK) | INT         |
| user_id (FK)      | INT         |
| movie_id (FK)     | INT         |
| added_date        | DATETIME |
| status            | ENUM('Already watched', 'Currently watching', 'Haven’t watched') |


### CREATE DATABASE

```sql
CREATE DATABASE diStreaming;
USE diStreaming;
```

### CREATE TABLE dengan PK, FK, NOT NULL, dan Constraints

#### Tabel `users`
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE, 
    fullname VARCHAR(100) NOT NULL,       
    email VARCHAR(255) NOT NULL UNIQUE, -- Diperpanjang ke 255
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Tabel `MOVIES`
```sql
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    movie_name VARCHAR(255) NOT NULL, 
    release_year INT NOT NULL,
    rating FLOAT NOT NULL,
    description TEXT,
    poster_url VARCHAR(255),
    background_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

#### Tabel `CATEGORY`
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```
#### Tabel PIVOT (Hubungan Film & Kategori)
#### Tabel `Movie_category`
```sql
CREATE TABLE movie_category (
    movie_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (movie_id, category_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);
```
#### Tabel `WATCHLIST`
```sql
CREATE TABLE watchlist (
    watchlist_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    status ENUM('Watched', 'Watching', 'Planned') DEFAULT 'Planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- Constraint agar satu user tidak bisa duplikat movie yang sama
    CONSTRAINT unique_user_movie UNIQUE (user_id, movie_id),
    -- Foreign Keys
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_movie FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);
```
##  Data Insertion (DML)

Setiap tabel telah diisi dengan data lebih dari **10 record**:

| Tabel | Jumlah Record |
|-------|---------------|
| `users` | 20 records |
| `movie_categories` | 40 records |
| `movies` | 40 records |
| `category` | 14 records |
| `watchlist` | 44 records |


*Lihat file `diStreaming.sql` untuk detail lengkap INSERT statements.*

## 1. SQL Fundamentals 

### 1.1 Tampilkan seluruh film dari tabel Movies
```sql
SELECT * FROM movies;
```

### 1.2 Tampilkan film dengan rating di atas 8.0
```sql
SELECT movie_name, rating FROM movies WHERE rating > 8.0;
```

### 1.3 Tampilkan 5 user pertama berdasarkan nama (A–Z)
```sql
SELECT * FROM users ORDER BY fullname LIMIT 5;
```

### 1.4 Tampilkan film yang judulnya mengandung kata “Love”
```sql
SELECT * FROM movies WHERE movie_name LIKE '%The%';
```

### 1.5 Tampilkan film yang rilis pada tahun tertentu (2024)
```sql
SELECT * FROM movies WHERE release_year = 2024;
```

## 2. Aggregate & Conditional Logic 

### 2.1 Hitung total user yang terdaftar
```sql
SELECT COUNT(*) AS total_user FROM users;
```

### 2.2 Hitung jumlah film per kategori (COUNT + GROUP BY category_id)
```sql
SELECT 
    c.category_id,
    c.category_name,
    COUNT(mc.movie_id) AS total_movies
FROM 
    category c
LEFT JOIN 
    movie_category mc ON c.category_id = mc.category_id
GROUP BY 
    c.category_id, c.category_name
ORDER BY 
    total_movies DESC;
```

### 2.3 Buat kategori film (kolom baru) berdasarkan rating menggunakan CASE WHEN
```sql
SELECT movie_name, rating,
CASE
	WHEN rating >= 8.5 THEN "Top Rated"
    WHEN rating > 7.0 THEN "Popular"
    ELSE "Reguler"
END AS popularity
FROM movies
ORDER BY rating DESC;
```

## 3. Join Statements 
### 3.1 Tampilkan daftar film lengkap (kategori film, rating(score), release year)
```sql
SELECT 
    m.movie_id,
    m.movie_name,
    m.release_year,
    m.rating,
    GROUP_CONCAT(c.category_name SEPARATOR ', ') AS categories
FROM 
    movies m
LEFT JOIN 
    movie_category mc ON m.movie_id = mc.movie_id
LEFT JOIN 
    category c ON mc.category_id = c.category_id
GROUP BY 
    m.movie_id, m.movie_name, m.release_year, m.rating
ORDER BY 
    m.release_year DESC, m.rating DESC;
```

### 3.2 Tampilkan kategori yang belum memiliki film
```sql
SELECT 
    c.category_id,
    c.category_name
FROM 
    category c
LEFT JOIN 
    movie_category mc ON c.category_id = mc.category_id
WHERE 
    mc.movie_id IS NULL;
```

##  Cara Menjalankan

1. Buka MySQL client (MySQL Workbench, phpMyAdmin, atau CLI)
2. Jalankan file `diStreaming.sql`
3. Database `diStreaming` akan otomatis dibuat dengan semua tabel dan data

```bash
mysql -u root -p < diStreaming.sql
```

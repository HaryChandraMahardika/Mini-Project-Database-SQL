# diStreaming - Asignment Mini Project Database MySQL

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
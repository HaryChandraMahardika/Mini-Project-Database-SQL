-- PILIH DATABASE
USE laravel_distreaming;

-- TABLE USERS
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE, 
    fullname VARCHAR(100) NOT NULL,       
    email VARCHAR(255) NOT NULL UNIQUE, -- Diperpanjang ke 255
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- TABLE MOVIES
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

-- TABLE CATEGORY
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- TABLE PIVOT (Hubungan Film & Kategori)
CREATE TABLE movie_category (
    movie_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (movie_id, category_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

-- TABLE WATCHLIST
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

-- INSERT TABLE USERS
INSERT INTO users ( fullname, username, email, password) values 
('Andi Zakaria', 'andiz', 'andi@mail.com', 'password123'),
('Budi Sudarsono', 'budisu', 'budi@mail.com', 'password123'),
('Citra Ayu', 'citraay', 'citra@mail.com', 'password123'),
('Dewi Pangesti',  'dewip','dewi@mail.com', 'password123'),
('Eko Julianto',  'ekoju', 'eko@mail.com', 'password123'),
('Ferry Irwandi', 'ferryir', 'ferry@mail.com', 'password123'),
('Gilang Dharmawangsa', 'gilangdh', 'gilang@mail.com', 'password123'),
('Husna Nuraini', 'husnanur', 'husna@mail.com', 'password123'),
('Ida Fitriani', 'idafit', 'ida@mail.com', 'password123'),
('Joko Susilo', 'jokosu', 'joko@mail.com', 'password123'),
('Krisna Firdaus', 'krisnaf', 'krisna@mail.com', 'password123'),
('Luna Maya', 'lunam', 'luna@mail.com', 'password123'),
('Maudy Ayunda', 'maudya', 'maudy@mail.com', 'password123'),
('Nikita Willy', 'nikitaw', 'nikita@mail.com', 'password123'),
('Ollie Larasati', 'olliel', 'ollie@mail.com', 'password123'),
('Pandji Pragiwaksono', 'panjip', 'panji@mail.com', 'password123'),
('Raditya Dika', 'radityad', 'radit@mail.com', 'password123'),
('Sophia Latjuba', 'sophial', 'sophia@mail.com', 'password123'),
('Tora Sudiro', 'toras', 'tora@mail.com', 'password123'),
('Vanesha Prescilla', 'vaneshap', 'vanesha@mail.com', 'password123');

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
('Fantasy'),
('Documentary'),
('Psychological');

-- INSERT TABLE MOVIES
INSERT INTO movies (movie_name, release_year, rating, description, poster_url, background_url) VALUES
('Nosferatu', 2024, 7.1, 
"Thomas Hutter, agen properti yang dikirim ke Transylvania untuk berbisnis dengan bangsawan misterius Count Orlok, 
yang ternyata adalah vampir kuno. Orlok tertarik pada istri Thomas, Ellen Hutter, yang merasa gelisah sebelum suaminya pergi, 
memicu serangkaian peristiwa mengerikan ketika vampir itu tiba di kota mereka membawa wabah dan obsesi mematikan pada Ellen, yang harus berjuang melawan kegelapan itu.", 
"https://m.media-amazon.com/images/M/MV5BY2FhZGE3NmEtNWJjOC00NDI1LWFhMTQtMjcxNmQzZmEwNGIzXkEyXkFqcGc@._V1_FMjpg_UX1080_.jpg",
"https://posters.movieposterdb.com/25_08/2024/5040012/l_nosferatu-movie-poster_13af1d48.jpg"),
('Avengers End Game', 2019, 8.4, 
"Terdampar di luar angkasa tanpa makanan atau air, 
Tony Stark mengirimkan pesan kepada Pepper Potts saat persediaan oksigennya mulai menipis. 
Sementara itu, anggota Avengers yang tersisa Thor, Black Widow, Captain America, dan Bruce Banner 
harus menemukan cara untuk mengembalikan sekutu mereka yang telah kalah demi pertarungan puncak melawan Thanos, 
demigod jahat yang telah membinasakan planet dan alam semesta.",
"https://m.media-amazon.com/images/M/MV5BMTkxNTQzNTg4Nl5BMl5BanBnXkFtZTgwMzYzNDQ2NzM@._V1_.jpg",
"https://posters.movieposterdb.com/21_06/2019/4154796/l_4154796_c7cbf855.jpg"
),
('Zodiac', 2007, 7.7, 
"Pada akhir 1960-an dan 1970-an, ketakutan mencekam kota San Francisco saat seorang pembunuh berantai yang menjuluki dirinya Zodiac menghantui penduduknya. 
Para penyelidik (Mark Ruffalo, Anthony Edwards) dan wartawan (Jake Gyllenhaal, Robert Downey Jr.) 
menjadi terobsesi untuk mengungkap identitas sang pembunuh dan menyeretnya ke pengadilan. 
Sementara itu, Zodiac terus memakan korban demi korban dan mengejek pihak berwenang melalui pesan teka-teki, sandi (sifer), serta panggilan telepon yang mengancam.",
"https://m.media-amazon.com/images/M/MV5BNDFkMTRkZmQtM2I0NC00NjJjLWJlMDctNTNiZWYxYzhjZDZiXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/07_04/2007/443706/l_443706_bfe68c4d.jpg"),
('Crazy, Stupid, Love', 2011, 7.4, 
"Cal Weaver menjalani kehidupan yang tampak sempurna hingga ia mengetahui bahwa istrinya, Emily, telah berselingkuh dan ingin bercerai. 
Di usianya yang menginjak 40-an dan mendadak melajang, Cal yang malang mulai menghabiskan malam-malamnya dengan meratapi nasib di sebuah bar. 
Hidupnya berubah saat ia bertemu dengan Jacob Palmer, seorang pria tampan penakluk wanita, 
yang memutuskan untuk membantu Cal melupakan istrinya dan mulai menjalani hidup baru dengan memberikan transformasi gaya hidup serta mengajarinya cara memikat wanita.",
"https://m.media-amazon.com/images/M/MV5BMTg2MjkwMTM0NF5BMl5BanBnXkFtZTcwMzc4NDg2NQ@@._V1_.jpg",
"https://posters.movieposterdb.com/13_12/2011/1570728/l_1570728_ac53a9c3.jpg"),
('The Fall Guy', 2024, 6.8, 
"Colt Seavers adalah seorang stuntman atau pemeran pengganti yang sudah meninggalkan dunia film demi kesehatan fisik dan mentalnya. 
Namun, ia ditarik kembali ke dunia kerja ketika bintang utama dari film studio beranggaran besar—yang disutradarai oleh mantan kekasihnya, 
Jody Moreno—menghilang secara misterius. 
Sambil melakukan aksi-aksi berbahaya di lokasi syuting, Colt harus memecahkan konspirasi gelap dan mencoba memenangkan kembali cinta dalam hidupnya, 
sambil membuktikan bahwa dia adalah pahlawan di kehidupan nyata, bukan hanya di layar lebar.", 
"https://m.media-amazon.com/images/M/MV5BM2U0MTJiYTItMjNiZS00MzU4LTkxYTAtYTU0ZGY1ODJhMjRhXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/24_05/2024/1684562/l_the-fall-guy-movie-poster_c12ec434.jpg"),
('Spirited Away', 2001, 8.6, 
"Chihiro adalah seorang gadis berusia sepuluh tahun yang pindah ke lingkungan baru bersama orang tuanya. 
Namun, mereka tersesat dan tanpa sengaja memasuki dunia ajaib yang dihuni oleh roh dan dewa. 
Setelah orang tuanya berubah menjadi babi secara misterius karena memakan makanan di sana, 
Chihiro harus bekerja di sebuah pemandian umum milik penyihir jahat bernama Yubaba. Dengan bantuan seorang pemuda misterius bernama Haku, 
Chihiro harus berjuang mengumpulkan keberanian untuk menyelamatkan keluarganya dan menemukan jalan pulang ke dunia manusia.",
"https://m.media-amazon.com/images/M/MV5BNTEyNmEwOWUtYzkyOC00ZTQ4LTllZmUtMjk0Y2YwOGUzYjRiXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/22_02/2001/245429/l_245429_8b3093b2.jpg"),
('Seven', 1995, 8.6, 
"Seorang detektif veteran yang akan segera pensiun, William Somerset, dipasangkan dengan detektif muda yang idealis dan temperamental, David Mills. 
Mereka bekerja sama untuk memburu seorang pembunuh berantai sadis yang menggunakan 'Tujuh Dosa Mematikan' (Seven Deadly Sins) 
sebagai tema dalam setiap aksi pembunuhan mengerikan yang dilakukannya. Saat mayat-mayat mulai ditemukan dengan kondisi yang mengenaskan, 
para detektif ini terseret ke dalam permainan psikologis sang pembunuh yang bertujuan untuk memberikan 'pelajaran' kelam kepada dunia.",
"https://m.media-amazon.com/images/M/MV5BY2IzNzMxZjctZjUxZi00YzAxLTk3ZjMtODFjODdhMDU5NDM1XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/14_12/1995/114369/l_114369_156764e9.jpg"),
('The Hunger Games', 2012, 7.2, 
"Di masa depan yang distopia, sebuah negara bernama Panem terbagi menjadi 12 distrik yang dikuasai oleh Capitol yang kejam. 
Sebagai hukuman atas pemberontakan di masa lalu, 
setiap distrik wajib mengirimkan dua remaja—seorang laki-laki dan seorang perempuan—untuk berpartisipasi dalam 'Hunger Games', 
sebuah kompetisi mematikan yang disiarkan secara langsung di televisi di mana hanya ada satu orang yang boleh bertahan hidup. 
Ketika adik perempuannya terpilih, Katniss Everdeen sukarela mengajukan diri untuk menggantikannya. Dengan mengandalkan insting dan kemampuan memanahnya, 
Katniss harus bertahan hidup di arena melawan peserta lain yang lebih kuat dalam permainan hidup dan mati.",
"https://m.media-amazon.com/images/M/MV5BMWI1OGM4YjQtNmIxNi00YmE2LWJkNTAtY2Q0YjU4NTI5NWQyXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/12_04/2012/1392170/l_1392170_b56ab6f1.jpg"),
('Parasite', 2019, 8.5, 
"Keluarga Kim yang miskin tinggal di sebuah apartemen semi-basement yang sempit, bertahan hidup dengan melipat kotak pizza dan melakukan pekerjaan serabutan. 
Nasib mereka berubah ketika putra mereka, Ki-woo, mendapatkan pekerjaan sebagai guru les bahasa Inggris untuk putri dari keluarga Park yang sangat kaya. 
Satu demi satu, anggota keluarga Kim yang cerdik mulai menyusup ke dalam rumah keluarga Park dengan menyamar sebagai pekerja profesional yang tidak saling kenal. 
Namun, kehidupan mewah yang mereka 'curi' mulai terancam saat rahasia gelap yang tersembunyi di dalam rumah tersebut terungkap, 
memicu rangkaian peristiwa yang tak terduga dan mematikan.",
"https://m.media-amazon.com/images/M/MV5BYjk1Y2U4MjQtY2ZiNS00OWQyLWI3MmYtZWUwNmRjYWRiNWNhXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/22_03/2019/6751668/l_6751668_2674e717.jpg"),
('Free Guy', 2021, 7.1, 
"Seorang teller bank bernama Guy menjalani kehidupan yang sangat rutin dan ceria setiap harinya, meskipun bank tempatnya bekerja dirampok berulang kali. 
Namun, dunianya jungkir balik ketika ia menyadari bahwa ia sebenarnya adalah seorang karakter latar belakang (NPC) 
dalam sebuah video game open-world yang sangat populer dan penuh kekerasan berjudul 'Free City'. 
Setelah jatuh cinta pada seorang pemain sungguhan bernama Molotov Girl, Guy memutuskan untuk menulis ulang ceritanya sendiri. 
Ia berubah menjadi pahlawan yang berusaha menyelamatkan dunianya sebelum sang pencipta game menutupnya selamanya.",
"https://m.media-amazon.com/images/M/MV5BN2I0MGMxYjUtZTZiMS00MzMxLTkzNWYtMDUyZmUwY2ViYTljXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/21_08/2020/6264654/l_6264654_89fb80d7.jpg"),
('Ready Player One', 2018, 7.4, 
"Pada tahun 2045, dunia berada di ambang kehancuran dan kekacauan. 
Manusia menemukan pelarian dalam OASIS, sebuah dunia virtual yang sangat luas ciptaan James Halliday yang eksentrik. 
Ketika Halliday meninggal, ia menjanjikan kekayaan luar biasa dan kendali penuh atas OASIS kepada siapa pun yang bisa menemukan 'Easter Egg' digital yang ia sembunyikan 
di dalam dunia tersebut. Wade Watts, seorang pemuda biasa, berhasil memenangkan tantangan pertama dalam perburuan harta karun ini. 
Ia pun terseret ke dalam persaingan berbahaya di dunia nyata maupun virtual melawan perusahaan raksasa yang siap melakukan apa pun untuk menguasai OASIS.",
"https://m.media-amazon.com/images/M/MV5BNzVkMTgzODQtMWIwZC00NzE4LTgzZjYtMzAwM2I5OGZhNjE4XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/20_06/2018/1677720/l_1677720_a96ea42f.jpg"),
('Uncharted', 2022, 6.3, 
"Nathan Drake, seorang pemuda cerdas yang bekerja sebagai bartender, direkrut oleh pemburu harta karun berpengalaman bernama Victor 'Sully' Sullivan 
untuk menemukan harta karun besar yang dikumpulkan oleh Ferdinand Magellan dan hilang 500 tahun yang lalu. 
Apa yang bermula sebagai pekerjaan pencurian sederhana bagi keduanya, 
berubah menjadi petualangan keliling dunia yang mendebarkan untuk mencapai harta tersebut sebelum Moncada, 
seorang pria kejam yang merasa keluarganya adalah pewaris sah harta itu, menemukannya terlebih dahulu. 
Jika Nate dan Sully bisa belajar bekerja sama, mereka berpotensi menemukan harta senilai 5 miliar dolar 
dan bahkan mungkin menemukan kakak laki-laki Nate yang sudah lama hilang.",
"https://m.media-amazon.com/images/M/MV5BYjQxYWNiNzgtOTc2Yi00OGEwLTk5MjAtODdiZTk0ZDJlZGY4XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/22_02/2022/1464335/l_1464335_e7a2ddcc.jpg"),
('The Shawshank Redemption', 1994, 9.3, 
"Andy Dufresne, seorang bankir muda yang sukses, dijatuhi hukuman seumur hidup di Penjara Shawshank atas pembunuhan istri dan kekasihnya, 
meskipun ia bersikeras bahwa dirinya tidak bersalah. 
Di dalam penjara yang keras dan penuh korupsi, Andy menjalin persahabatan yang kuat selama dua dekade dengan sesama narapidana bernama Red. 
Dengan kecerdasan dan ketabahannya, Andy tidak hanya menemukan cara untuk bertahan hidup, 
tetapi juga memberikan harapan kepada rekan-rekan narapidananya melalui tindakan-tindakan kecil yang luar biasa, 
sambil tetap menyimpan rencana rahasia untuk menebus kebebasannya.",
"https://m.media-amazon.com/images/M/MV5BMDAyY2FhYjctNDc5OS00MDNlLThiMGUtY2UxYWVkNGY2ZjljXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/06_05/1994/0111161/l_113271_0111161_233da302.jpg"),
('Fight Club', 1999, 8.8, 
"Seorang pria yang menderita insomnia kronis dan merasa depresi dengan kehidupan korporatnya yang membosankan bertemu dengan Tyler Durden, 
seorang penjual sabun yang karismatik dan berjiwa bebas dengan filosofi hidup yang radikal. 
Bersama-sama, mereka mendirikan sebuah organisasi rahasia bernama 'Fight Club', di mana para pria bisa saling bertarung sebagai bentuk pelarian dari kekosongan hidup mereka. 
Namun, hubungan pertemanan mereka mulai retak ketika Tyler mengubah klub tersebut menjadi sebuah gerakan anarkis yang berbahaya, 
dan sang narator terseret ke dalam kekacauan psikologis yang mengungkap kenyataan mengejutkan tentang dirinya sendiri.", 
"https://m.media-amazon.com/images/M/MV5BOTgyOGQ1NDItNGU3Ny00MjU3LTg2YWEtNmEyYjBiMjI1Y2M5XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/05_09/1999/0137523/l_53787_0137523_7ccf70c6.jpg"),
('The Silence of the Lambs', 1991, 8.6, 
"Clarice Starling, seorang kadet muda FBI yang berbakat, 
ditugaskan untuk meminta bantuan dari seorang narapidana jenius sekaligus pembunuh kanibal yang sangat berbahaya, Dr. Hannibal Lecter. 
Kerja sama ini bertujuan untuk mendapatkan informasi demi menangkap seorang pembunuh berantai lain yang sedang berkeliaran, yang dijuluki 'Buffalo Bill'. 
Dalam pertemuan-pertemuan mereka yang mencekam, Clarice harus menghadapi permainan psikologis Lecter yang manipulatif untuk bisa masuk ke dalam pikiran seorang pembunuh, 
sambil berpacu dengan waktu untuk menyelamatkan nyawa seorang gadis yang sedang disekap.",
"https://m.media-amazon.com/images/M/MV5BNDdhOGJhYzctYzYwZC00YmI2LWI0MjctYjg4ODdlMDExYjBlXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/08_03/1991/102926/l_102926_a60c9052.jpg"),
('Avatar', 2009, 7.9,
"Jake Sully adalah seorang mantan marinir berkursi roda yang dikirim ke planet jauh bernama Pandora untuk menggantikan mendiang saudara kembar dalam misi ilmiah. 
Di sana, ia mengendalikan 'Avatar', tubuh buatan yang mirip dengan penduduk asli Pandora bernama Na'vi. 
Namun, rencana awal untuk mengeksploitasi sumber daya alam Pandora berubah total saat Jake jatuh cinta pada Neytiri, putri dari klan Na'vi. 
Jake kini terjebak di tengah konflik antara militer manusia yang ingin menghancurkan hutan demi kekayaan bumi, 
dan kaum Na'vi yang berjuang mati-matian untuk melindungi rumah serta keseimbangan alam mereka.",
"https://m.media-amazon.com/images/M/MV5BMDEzMmQwZjctZWU2My00MWNlLWE0NjItMDJlYTRlNGJiZjcyXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/09_11/2009/499549/l_499549_db0e85bb.jpg"),
("Agak Laen: Menyala Pantiku!", 2025, 8,
"Empat detektif gagal—Bene, Boris, Jegel, dan Oki—yang diberi kesempatan terakhir untuk memperbaiki karier mereka 
dengan menyamar di panti jompo untuk menangkap buronan pembunuhan anak wali kota, 
menghasilkan kekacauan komedi, salah paham, dan drama personal di tengah kehidupan para lansia",
"https://m.media-amazon.com/images/M/MV5BOTdlOGEyYmMtN2I2OC00ZWJkLWE1ZTQtMjQwYmQ1NGNlODgzXkEyXkFqcGc@._V1_.jpg",
"https://image.idntimes.com/post/20251123/upload_ca7a9d2bac49ed04f9560a0e0c25607b_b89a5443-2d81-4779-9998-121d16e52341.jpeg"),
("Inception", 2010, 8.8,
"Dom Cobb adalah seorang pencuri ulung yang ahli dalam seni berbahaya 'ekstraksi', 
yaitu mencuri rahasia berharga dari dalam alam bawah sadar seseorang saat mereka sedang tidur dan bermimpi. 
Kemampuannya yang langka ini menjadikannya aset berharga dalam dunia spionase korporat, namun juga menjadikannya buronan internasional. 
Cobb mendapatkan kesempatan terakhir untuk menebus kesalahannya dan kembali ke kehidupan normalnya jika ia bisa melakukan hal yang mustahil: 'Inception', 
yaitu bukan mencuri ide, melainkan menanamkan sebuah ide ke dalam pikiran seseorang. 
Namun, sebuah musuh berbahaya yang tampaknya bisa memprediksi setiap gerakannya telah menanti, dan hanya Cobb yang bisa melihat ancaman tersebut datang.",
"https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_.jpg",
"https://posters.movieposterdb.com/10_05/2010/1375666/l_1375666_bd547b2d.jpg"),
("Spiderman: No Way Home", 2021, 8.2,
"Untuk pertama kalinya dalam sejarah sinematik Spider-Man, identitas asli sang pahlawan ramah lingkungan ini terungkap ke seluruh dunia, 
membuat kehidupannya dan orang-orang yang ia cintai berada dalam bahaya. 
Putus asa untuk mengembalikan rahasianya, Peter Parker meminta bantuan Doctor Strange untuk merapal mantra pengubah kenyataan. 
Namun, mantra tersebut rusak dan justru membuka gerbang multiverse, memanggil musuh-musuh kuat yang pernah melawan Spider-Man di alam semesta lain. 
Kini, Peter harus menghadapi tantangan terbesarnya yang tidak hanya akan mengubah masa depannya sendiri, tetapi juga masa depan multiverse selamanya.",
"https://m.media-amazon.com/images/M/MV5BMmFiZGZjMmEtMTA0Ni00MzA2LTljMTYtZGI2MGJmZWYzZTQ2XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_01/2021/10872600/l_spider-man-no-way-home-movie-poster_cd8ae446.jpg"),
("Bullet Train", 2022, 7.3,
"Ladybug adalah seorang pembunuh bayaran yang kurang beruntung, yang bertekad untuk melakukan pekerjaannya dengan damai setelah terlalu banyak misi yang berakhir kacau. 
Namun, nasib berkata lain ketika misi terbarunya menempatkannya di atas kereta peluru tercepat di dunia yang sedang melaju melintasi Jepang. 
Di dalam kereta tersebut, ia terjebak bersama sekelompok pembunuh bayaran mematikan dari seluruh dunia—yang semuanya memiliki tujuan yang saling berkaitan namun saling berlawanan. 
Ladybug harus menemukan cara untuk menyelesaikan misinya dan turun dari kereta hidup-hidup, sementara musuh-musuh berbahaya mengintai di setiap gerbong.",
"https://m.media-amazon.com/images/M/MV5BODUyZjkxZDMtZGI3ZC00ZmEwLTgwMTUtYTU4OTQ5YjU4ZjRlXkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/22_09/2022/12593682/xl_12593682_4ad761b9.jpg"),
("No Hard Feelings", 2023, 6.4,
"Maddie adalah seorang wanita muda yang terancam kehilangan rumah masa kecilnya karena masalah keuangan yang menumpuk. 
Di tengah keputusasaan, ia menemukan sebuah iklan lowongan kerja yang unik di Craigslist: sepasang orang tua kaya mencari seseorang untuk 'berkencan' dengan putra mereka yang pemalu dan canggung secara sosial, Percy, sebelum ia berangkat kuliah. 
Awalnya, Maddie mengira ini akan menjadi pekerjaan yang mudah, namun ia segera menyadari bahwa mendekati Percy yang kaku bukanlah hal yang sederhana. 
Dalam prosesnya, hubungan yang awalnya hanya demi uang ini berubah menjadi sebuah persahabatan yang tak terduga dan penuh momen konyol sekaligus menyentuh.",
"https://m.media-amazon.com/images/M/MV5BZjk1NmZiNzYtZGUyYi00YzEwLTgwNWQtM2VmOWFmMGIwZDM2XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/23_06/2023/15671028/l_no-hard-feelings-movie-poster_0bca72a9.jpg"),
("Titanic", 1997, 7.9,
"Pada tahun 1912, kapal uap terbesar yang pernah dibuat, RMS Titanic, berangkat dalam pelayaran perdananya yang megah melintasi Samudra Atlantik. 
Di atas kapal tersebut, Rose DeWitt Bukater, seorang wanita muda dari kelas atas yang merasa tertekan oleh pertunangan paksa, bertemu dengan Jack Dawson, 
seorang seniman miskin yang berjiwa bebas dari kelas bawah. 
Meskipun berasal dari dunia yang berbeda, mereka jatuh cinta secara mendalam di tengah kemewahan kapal tersebut. 
Namun, kisah cinta mereka berubah menjadi perjuangan hidup dan mati yang tragis ketika kapal yang dianggap 'tidak bisa tenggelam' itu menabrak gunung es, 
memaksa mereka menghadapi bencana maritim terbesar dalam sejarah.",
"https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/11_12/1997/120338/l_120338_a585cb67.jpg"),
("Anyone But You", 2023, 6.9,
"Bea dan Ben terlihat seperti pasangan yang sempurna setelah kencan pertama yang luar biasa. 
Namun, sebuah insiden kecil membuat ketertarikan mereka berubah menjadi rasa benci yang dingin. 
Takdir mempertemukan mereka kembali secara tak terduga di sebuah pesta pernikahan di Australia. 
Karena terjepit situasi dan ingin membuat mantan kekasih mereka masing-masing cemburu, Bea dan Ben memutuskan untuk melakukan hal yang dewasa: berpura-pura menjadi pasangan kekasih. 
Di tengah pemandangan pantai yang indah, mereka harus menjaga sandiwara tersebut tetap meyakinkan tanpa benar-benar saling membunuh satu sama lain.",
"https://m.media-amazon.com/images/M/MV5BZWUxYTFhMzItMmE0ZC00ODgzLTkwZWItOGUwMTI1YjQwMDJjXkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/23_12/2023/26047818/xl_anyone-but-you-movie-poster_b9680b3e.jpg"),
("Joker", 2019, 8.4,
"Berlatar di Kota Gotham yang kelam pada tahun 1981, 
Arthur Fleck adalah seorang pria yang bekerja sebagai badut sewaan sambil berjuang dengan masalah kesehatan mental dan kemiskinan. 
Terisolasi, diganggu, dan diabaikan oleh masyarakat, Arthur perlahan-lahan kehilangan pegangan pada kenyataan. 
Kegagalan demi kegagalan yang ia alami sebagai pelawak tunggal, ditambah dengan penemuan rahasia kelam tentang masa lalunya, memicu transformasi dirinya menjadi sosok kriminal yang mengerikan dan penuh kekacauan yang dikenal sebagai Joker.",
"https://m.media-amazon.com/images/M/MV5BNzY3OWQ5NDktNWQ2OC00ZjdlLThkMmItMDhhNDk3NTFiZGU4XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/24_04/2019/7286456/l_joker-movie-poster_807f33bb.jpeg"),
("The Maze Runner", 2014, 6.8,
"Thomas terbangun di dalam sebuah lift yang bergerak naik, tanpa ingatan sedikit pun tentang siapa dirinya atau bagaimana ia bisa sampai di sana. 
Ia tiba di 'The Glade', sebuah kawasan terbuka luas yang dikelilingi oleh tembok batu raksasa, yang dihuni oleh sekelompok remaja laki-laki yang telah membangun komunitas mereka sendiri. Setiap pagi, tembok tersebut membuka jalan menuju sebuah labirin (Maze) raksasa yang selalu berubah polanya setiap malam. Thomas bergabung dengan para 'Runners' untuk memetakan labirin tersebut demi mencari jalan keluar, namun mereka harus berhadapan dengan makhluk mekanis mematikan bernama Grievers. 
Misteri semakin dalam ketika seorang gadis terakhir tiba dengan pesan bahwa waktu mereka hampir habis.",
"https://m.media-amazon.com/images/M/MV5BMjUyNTA3MTAyM15BMl5BanBnXkFtZTgwOTEyMTkyMjE@._V1_.jpg",
"https://posters.movieposterdb.com/14_08/2014/1790864/l_1790864_a599b1dc.jpg"),
("Demon Slayer: Kimetsu no Yaiba Infinity Castle", 2025, 8.4,
"Setelah peristiwa di Pelatihan Hashira, sang raja iblis Muzan Kibutsuji akhirnya menemukan lokasi persembunyian Ubuyashiki. 
Namun, sebuah jebakan besar justru menyeret Muzan dan seluruh anggota Korps Pembasmi Iblis ke dalam 'Infinity Castle', sebuah ruang dimensi tak terbatas yang dikendalikan oleh iblis Bulan Atas, Nakime. Di dalam benteng yang membingungkan dan berubah-ubah ini, Tanjiro, Nezuko, serta para Hashira yang tersisa harus menghadapi pertarungan hidup dan mati melawan tiga Iblis Bulan Atas terkuat: Akaza, Doma, dan Kokushibo. 
Ini adalah perang habis-habisan yang akan menentukan nasib umat manusia dan akhir dari perseteruan seribu tahun melawan Muzan.",
"https://m.media-amazon.com/images/M/MV5BOGQ3YWUzYjEtMTJiYy00ZjQ0LWI0YjktYjhiNGVhNGExYTM3XkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_03/2025/32820897/xl_gekijo-ban-kimetsu-no-yaiba-mugen-jo-hen-movie-poster_05f8e8f9.jpg"),
("Your Name", 2016, 8.4,
"Mitsuha adalah seorang siswi SMA yang merasa bosan dengan kehidupannya di desa terpencil, 
sementara Taki adalah seorang pemuda yang sibuk dengan sekolah dan kerja paruh waktu di hiruk-pikuk kota Tokyo. 
Suatu hari, mereka terbangun dalam tubuh satu sama lain secara misterius. Meski awalnya bingung, mereka mulai belajar berkomunikasi dengan meninggalkan catatan dan saling membantu menjalani kehidupan masing-masing. Namun, saat sebuah rahasia besar tentang fenomena tersebut dan sebuah komet yang akan melintasi bumi terungkap, 
Taki dan Mitsuha harus berpacu dengan waktu dan takdir untuk bisa bertemu secara nyata 
dan menyelamatkan apa yang mereka cintai sebelum ingatan mereka tentang satu sama lain menghilang selamanya.",
"https://m.media-amazon.com/images/M/MV5BMjI1ODZkYTgtYTY3Yy00ZTJkLWFkOTgtZDUyYWM4MzQwNjk0XkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/23_11/2016/5311514/xl_kimi-no-na-wa-movie-poster_2cda3394.jpg"),
("John Wick", 2014, 7.4,
"John Wick adalah seorang mantan pembunuh bayaran legendaris yang telah pensiun untuk menikmati kehidupan damai bersama istrinya. Namun, setelah istrinya meninggal karena sakit, John menerima hadiah terakhir darinya berupa seekor anak anjing bernama Daisy untuk membantunya berduka. Kehidupannya yang tenang hancur ketika putra seorang bos mafia Rusia mencuri mobil antik miliknya dan membunuh anak anjing tersebut tanpa tahu siapa John sebenarnya. Kejadian itu memicu kembalinya 'Baba Yaga' ke dunia bawah tanah yang penuh darah. 
Dengan kemampuan menembak dan bertarung yang tak tertandingi, John Wick memulai misi balas dendam tunggal yang brutal terhadap organisasi yang pernah ia layani.",
"https://m.media-amazon.com/images/M/MV5BMTU2NjA1ODgzMF5BMl5BanBnXkFtZTgwMTM2MTI4MjE@._V1_.jpg",
"https://xl.movieposterdb.com/15_01/2014/2911666/xl_2911666_926cbf49.jpg"),
("Fantastic Beasts and Where to Find Them", 2016, 7.2,
"Tujuh puluh tahun sebelum Harry Potter membaca bukunya di Hogwarts, seorang magizoologist (ahli hewan gaib) bernama Newt Scamander tiba di New York 
setelah melakukan perjalanan keliling dunia untuk menemukan dan mendokumentasikan makhluk-makhluk sihir yang langka. 
Newt membawa sebuah koper ajaib yang berisi berbagai hewan fantastis di dalamnya. Namun, situasi menjadi kacau ketika koper tersebut tertukar dengan milik seorang Muggle 
(No-Maj) bernama Jacob Kowalski, yang menyebabkan beberapa makhluk sihir lepas ke jalanan kota. 
Di tengah ketegangan antara kaum penyihir dan manusia yang semakin meningkat, Newt harus bekerja sama dengan Jacob dan seorang mantan Auror untuk menangkap kembali makhluk-makhluk tersebut sebelum mereka memicu perang besar, 
sambil menghadapi ancaman gelap yang jauh lebih berbahaya.",
"https://m.media-amazon.com/images/M/MV5BMjMxOTM1OTI4MV5BMl5BanBnXkFtZTgwODE5OTYxMDI@._V1_.jpg",
"https://xl.movieposterdb.com/23_10/2016/3183660/xl_fantastic-beasts-and-where-to-find-them-movie-poster_4193f1c0.jpg"),
("Harry Potter and the Goblet of Fire", 2005, 7.7,
"Tahun keempat Harry Potter di Hogwarts dimulai dengan kejutan besar ketika ia secara misterius terpilih sebagai peserta keempat dalam Turnamen Triwizard—sebuah 
kompetisi sihir yang sangat berbahaya yang biasanya hanya diikuti oleh tiga penyihir senior dari sekolah yang berbeda. Harry yang belum cukup umur terpaksa menghadapi serangkaian tugas yang mematikan, mulai dari melawan naga hingga menyelam ke dasar danau yang penuh monster. Namun, di balik kemegahan turnamen tersebut, sebuah rencana gelap sedang berjalan. Harry tidak hanya harus berjuang memenangkan piala, 
tetapi juga menghadapi kenyataan mengerikan bahwa musuh bebuyutannya, Lord Voldemort, sedang berusaha untuk kembali bangkit dengan kekuatan penuh.",
"https://m.media-amazon.com/images/M/MV5BMTIzNzUzOTk2NV5BMl5BanBnXkFtZTYwNTI4MDg2._V1_.jpg",
"https://www.pluggedin.com/wp-content/uploads/2019/12/harry-potter-and-the-goblet-of-fire-1024x576.jpg"),
("Omniscient Reader: The Prophecy", 2025, 5.8, 
"Kim Dok-ja adalah seorang pekerja kantor biasa yang hobi membaca novel web berjudul 'Tiga Cara Bertahan Hidup di Dunia yang Hancur'. Saat ia menyelesaikan bab terakhir, dunia tiba-tiba berubah menjadi seperti apa yang ada di dalam novel tersebut. 
Sebagai satu-satunya orang yang mengetahui akhir dari cerita dunia ini, Dok-ja harus bekerja sama dengan sang protagonis novel, Yoo Joong-hyuk, 
untuk mengubah alur takdir dan bertahan hidup dalam skenario mematikan yang dipandu oleh entitas misterius yang disebut 'Constellations'.",
"https://m.media-amazon.com/images/M/MV5BZjllNWY3NzktN2E2Ny00OGM0LTg3YTItYjgwNTBhNWIxYWJlXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_07/2025/30254719/l_jeonjijeok-dokja-sijeom-movie-poster_9f78aad0.jpeg"),
("Until Dawn", 2025, 5.7, "Delapan orang teman terjebak di sebuah penginapan gunung yang terisolasi tepat setahun setelah hilangnya dua anggota kelompok mereka. 
Suasana reuni yang tenang berubah menjadi mimpi buruk saat mereka menyadari bahwa mereka tidak sendirian di gunung tersebut. Diburu oleh sosok misterius 
dan ancaman supernatural yang haus darah, setiap keputusan yang mereka ambil akan menentukan siapa yang akan bertahan hidup hingga fajar menyingsing.", 
"https://m.media-amazon.com/images/M/MV5BZWU4NDY0ODktOGI3OC00NWE1LWIwYmQtNmJiZWU3NmZlMDhkXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_02/2025/30955489/l_until-dawn-movie-poster_d57f27be.jpg"),
("Avatar: Fire and Ash", 2025, 7.4, "Setelah peristiwa pertempuran besar melawan RDA, Jake Sully dan Neytiri harus memimpin klan Omaticaya menghadapi ancaman baru yang tidak terduga. Kali ini mereka bertemu dengan 'Suku Abu', klan Na'vi yang tinggal di wilayah vulkanik. Berbeda dengan klan yang pernah mereka temui, suku ini memiliki sifat lebih agresif dan kejam, memaksa Jake untuk mempertanyakan kembali apa yang harus ia lakukan demi menjaga perdamaian di Pandora.", 
"https://m.media-amazon.com/images/M/MV5BZDYxY2I1OGMtN2Y4MS00ZmU1LTgyNDAtODA0MzAyYjI0N2Y2XkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_11/2025/1757678/xl_avatar-fire-and-ash-movie-poster_89c90a0e.jpg"),
("Final Destination: Bloodlines", 2025, 6.7, 
"Seorang remaja mendapatkan penglihatan mengerikan tentang kecelakaan fatal yang akan menimpa keluarganya. Meski berhasil menyelamatkan mereka dari kejadian tersebut, ia segera menyadari bahwa kematian tidak pernah suka dicurangi. Satu per satu, anggota keluarga tersebut mulai tewas dalam serangkaian kecelakaan aneh yang brutal. Mereka harus mengungkap rahasia masa lalu keluarga mereka untuk memutus kutukan garis keturunan ini sebelum semuanya terlambat.", 
"https://m.media-amazon.com/images/M/MV5BMzc3OWFhZWItMTE2Yy00N2NmLTg1YTktNGVlNDY0ODQ5YjNlXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_04/2025/9619824/l_final-destination-bloodlines-movie-poster_f75d1fb1.jpg"),
("Mission: Impossible - Dead Reckoning Part 2", 2025, 7.2, 
"Ethan Hunt berada dalam perlombaan paling berbahaya melawan waktu untuk melacak sebuah senjata AI mematikan yang dikenal sebagai 'The Entity' sebelum jatuh ke tangan yang salah. Setelah peristiwa di kapal selam Sevastopol, Ethan menyadari bahwa taruhannya bukan lagi sekadar misi, melainkan masa depan umat manusia. Bersama tim IMF-nya, ia harus melakukan aksi infiltrasi yang mustahil di bawah laut dalam dan di ketinggian ekstrem untuk menghancurkan ancaman yang mampu memprediksi setiap langkah mereka.", 
"https://m.media-amazon.com/images/M/MV5BZGQ5NGEyYTItMjNiMi00Y2EwLTkzOWItMjc5YjJiMjMyNTI0XkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_05/2025/9603208/xl_mission-impossible-the-final-reckoning-movie-poster_d452cdf8.jpg"),
("The Fantastic Four: First Steps", 2025, 6.9, 
"Berlatar di dunia alternatif tahun 1960-an yang futuristik, Reed Richards, Sue Storm, Johnny Storm, dan Ben Grimm harus menghadapi tantangan terbesar mereka sebagai pahlawan super. Setelah mendapatkan kekuatan luar biasa dari radiasi kosmik, mereka tidak hanya harus belajar menyesuaikan diri sebagai sebuah keluarga, tetapi juga harus melindungi Bumi dari ancaman entitas galaksi raksasa, Galactus, dan utusannya yang misterius, Silver Surfer. Perjalanan ini akan menentukan nasib keberadaan mereka di multisemesta.", 
"https://m.media-amazon.com/images/M/MV5BOGM5MzA3MDAtYmEwMi00ZDNiLTg4MDgtMTZjOTc0ZGMyNTIwXkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_05/2025/10676052/xl_the-fantastic-four-first-steps-movie-poster_33639562.jpg"),
("Jurassic World: Rebirth", 2025, 5.9, 
"Lima tahun setelah peristiwa Dominion, ekosistem Bumi terbukti tidak ramah bagi dinosaurus. Spesies yang tersisa kini hidup di lingkungan tropis yang terisolasi. Seorang ahli operasi rahasia, Zora Bennett, dikirim dalam misi berbahaya untuk mengambil materi genetik dari tiga spesies dinosaurus raksasa yang masih hidup di darat, laut, dan udara. Namun, misi penyelamatan ini berubah menjadi upaya bertahan hidup ketika mereka terdampar di sebuah pulau dan menemukan rahasia mengejutkan yang telah disembunyikan dari dunia selama puluhan tahun.", 
"https://m.media-amazon.com/images/M/MV5BNjg2NTcwYWQtYzk4NS00MTJhLWEzZjItMzIxNjk3YzlkYzU0XkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_06/2025/31036941/xl_jurassic-world-rebirth-movie-poster_9dd26b16.jpg"),
("A Minecraft Movie", 2025, 5.6, 
"Empat orang asing—Garrett, Henry, Natalie, dan Cass—tiba-tiba ditarik melalui portal misterius ke dalam Dunia Atas (Overworld), sebuah dunia blok yang ajaib sekaligus berbahaya. Untuk bisa kembali ke rumah, mereka harus menguasai dunia ini dan melindunginya dari ancaman jahat Piglins dan Zombies. Dengan bantuan seorang pengrajin ahli bernama Steve, mereka memulai petualangan epik yang mengajarkan bahwa kreativitas bukan hanya penting untuk membangun sesuatu, tetapi juga kunci untuk bertahan hidup.", 
"https://m.media-amazon.com/images/M/MV5BYzFjMzNjOTktNDBlNy00YWZhLWExYTctZDcxNDA4OWVhOTJjXkEyXkFqcGc@._V1_.jpg",
"https://xl.movieposterdb.com/25_05/2025/3566834/xl_a-minecraft-movie-movie-poster_7bc08d0d.jpg"),
("Karate Kid: Legends", 2025, 6.3, 
"Seorang remaja muda dari Pantai Timur Amerika menemukan arah hidup baru melalui seni bela diri setelah pindah ke Pantai Barat. Dalam perjalanannya, ia mendapatkan bimbingan dari dua mentor yang sangat berbeda namun legendaris: Daniel LaRusso dan Tuan Han. Di bawah asuhan mereka, ia harus mempersiapkan diri menghadapi turnamen karate paling bergengsi yang akan mempertemukan berbagai aliran bela diri, sambil belajar bahwa kekuatan sejati bukan berasal dari pukulan, melainkan dari kedamaian batin dan disiplin.", 
"https://m.media-amazon.com/images/M/MV5BM2MwYTlkY2MtNmUzNy00MTljLThjNDAtZGUzNzMxMzcxNzM5XkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_05/2025/1674782/l_karate-kid-legends-movie-poster_2d3ef9cc.jpg"),
("Jumbo", 2025, 8.0, 
"Doni adalah seorang anak laki-laki dengan imajinasi tinggi yang sangat menyukai cerita-cerita dongeng. Namun, kehidupannya berubah ketika ia mulai mengalami perundungan (bullying) dari teman-teman di sekolahnya. Di tengah perjuangannya menghadapi rasa takut, Doni menemukan sebuah rahasia besar yang membawanya ke dalam petualangan ajaib. Di sana, ia belajar bahwa keberanian bukan berarti tidak memiliki rasa takut, melainkan kemampuan untuk menghadapinya demi melindungi hal-hal yang ia sayangi.", 
"https://m.media-amazon.com/images/M/MV5BOTNlNmI2NzQtNjNkZS00MzZlLTg2MTAtZjZhNjE3ZmQ3NGNhXkEyXkFqcGc@._V1_.jpg",
"https://posters.movieposterdb.com/25_04/2025/27433995/l_jumbo-movie-poster_c99f0036.jpg");


-- INSERT TABLE movie_category
INSERT INTO movie_category (movie_id, category_id) VALUES
(1, 3), 
(1, 2),
(2, 1),
(2, 7),
(3, 9),
(3, 8),
(4, 4),
(4, 5),
(5, 1), 
(5, 5),
(6, 10), 
(6, 11),
(7, 8),
(7, 9),
(8, 7), 
(8, 11),
(9, 2), 
(9, 6),
(10, 1), 
(10, 5),
(11, 7), 
(11, 11),
(12, 1), 
(12, 11),
(13, 2), 
(13, 9),
(14, 6), 
(14, 8),
(15, 3), 
(15, 6),
(16, 7), 
(16, 11),
(17, 5), 
(17, 8),
(18, 7), 
(18, 8),
(19, 1), 
(19, 7),
(20, 1), 
(20, 5),
(21, 4), 
(21, 5),
(22, 2), 
(22, 4),
(23, 4), 
(23, 5),
(24, 2), 
(24, 9),
(25, 7), 
(25, 11),
(26, 12), 
(26, 13),
(27, 4), 
(27, 12),
(28, 1), 
(28, 9),
(29, 13), 
(29, 11),
(30, 13), 
(30, 11);

INSERT INTO movie_category (movie_id, category_id) VALUES
(31, 7),
(31, 12), 
(32, 3), 
(32, 6), 
(33, 11), 
(33, 12), 
(34, 3), 
(34, 6), 
(35, 1), 
(35, 11), 
(36, 1),
(36, 7),
(37, 7),
(37, 11),
(38, 11),
(38, 12),
(39, 1),
(39, 2),
(40, 2),
(40, 10);

select * from category;

-- INSERT TABLE WATCHLIST
INSERT INTO watchlist (user_id, movie_id, status) VALUES
(1, 1, 'Watched'), (1, 2, 'Watching'), (1, 3, 'Planned'),
(2, 4, 'Watched'), (2, 5, 'Watching'), (2, 6, 'Planned'),
(3, 7, 'Watched'), (3, 8, 'Watching'), (3, 9, 'Planned'),
(4, 10, 'Watched'), (4, 11, 'Planned'), (4, 20, 'Planned'), 
(5, 12, 'Watching'), (5, 13, 'Watched'),
(6, 14, 'Planned'), (6, 15, 'Watched'),
(7, 16, 'Watching'), (7, 17, 'Planned'),
(8, 18, 'Watched'), (8, 19, 'Watching'), (8, 30, 'Planned'), 
(9, 20, 'Planned'), (9, 21, 'Watched'),
(10, 22, 'Watching'), (10, 23, 'Planned'),
(11, 24, 'Watched'), (11, 1, 'Planned'),
(12, 25, 'Watching'), (12, 2, 'Watched'),
(13, 26, 'Planned'), (13, 3, 'Watching'),
(14, 27, 'Watched'), (14, 4, 'Planned'),
(15, 28, 'Watching'), (15, 5, 'Watched'),
(16, 29, 'Planned'), (16, 6, 'Watching'),
(17, 30, 'Watched'), (17, 7, 'Planned'),
(18, 15, 'Watched'), (18, 5, 'Watching'),
(19, 20, 'Watching'), (19, 10, 'Watched'),
(20, 30, 'Planned');

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
SELECT movie_name, rating FROM movies WHERE rating > 8.0;

-- 1.3 Tampilkan 5 user pertama berdasarkan nama (A–Z)
SELECT * FROM users ORDER BY fullname LIMIT 5;

-- 1.4 Tampilkan film yang judulnya mengandung kata “Love”
SELECT * FROM movies WHERE movie_name LIKE '%The%';

-- 1.5 Tampilkan film yang rilis pada tahun tertentu (2024)
SELECT * FROM movies WHERE release_year = 2024;

-- -----------------2. Aggregate & Conditional Logic ---------------

-- 2.1 Hitung total user yang terdaftar
SELECT COUNT(*) AS total_user FROM users;

-- 2.2 Hitung jumlah film per kategori (COUNT + GROUP BY category_id)
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


-- 2.3 Buat kategori film (kolom baru) berdasarkan rating menggunakan CASE WHEN
SELECT movie_name, rating,
CASE
	WHEN rating >= 8.5 THEN "Top Rated"
    WHEN rating > 7.0 THEN "Popular"
    ELSE "Reguler"
END AS popularity
FROM movies
ORDER BY rating DESC;

-- ----------------------- 3. Join Statements ---------------
-- 3.1 Tampilkan daftar film lengkap (kategori film, rating(score), release year)
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


-- 3.2 Tampilkan kategori yang belum memiliki film
SELECT 
    c.category_id,
    c.category_name
FROM 
    category c
LEFT JOIN 
    movie_category mc ON c.category_id = mc.category_id
WHERE 
    mc.movie_id IS NULL;

